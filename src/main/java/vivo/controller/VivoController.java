package vivo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;
import org.springframework.web.portlet.bind.annotation.ResourceMapping;
import vivo.shared.dto.VivoQueryDTO;
import vivo.shared.services.VivoQueryService;
import vivo.util.MultiportalUserInfoUtilities;

import javax.portlet.*;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

@Controller
@RequestMapping("VIEW")
public class VivoController {
    private static final Logger LOG = LoggerFactory.getLogger(VivoController.class);

    private String vivoUrl;

    @Autowired
    private VivoQueryService vivoQueryService;

    @RenderMapping
    public String doView(RenderRequest request, RenderResponse response, ModelMap modelMap) {
        if (vivoUrl == null || "".equals(vivoUrl)) {
            LOG.warn("vivoUrl must be set in configuration");
        }

        modelMap.put("vivoUrl", vivoUrl);
        return "view";
    }

    // very simplistic POJO to JSON (oesn't convert arrays/lists/sets properly, etc.)
    private String mapToJson(Map map) {
        StringBuffer sb = new StringBuffer("{");
        if (map != null) {
            Set keySet = map.keySet();
            Iterator iterator = keySet.iterator();
            boolean delimit = false;
            while (iterator.hasNext()) {
                if (delimit) {
                    sb.append(", ");
                }
                String key = (String) iterator.next();
                sb.append("\"");
                appendIfNotNull(key, sb);
                sb.append("\": \"");
                Object o = map.get(key);
                if (o instanceof Map) {
                    appendIfNotNull(mapToJson((Map) o), sb);
                }
                appendIfNotNull(map.get(key), sb);
                sb.append("\"");
                delimit = true;
            }
        }
        sb.append("}");
        return sb.toString();
    }

    private void appendIfNotNull(Object o, StringBuffer sb) {
        if (o != null) {
            sb.append(o.toString());
        }
    }

    @ResourceMapping(value = "info")
    public void info(ResourceRequest request, ResourceResponse response)
            throws Exception {
        PrintWriter writer = response.getWriter();
        String jvmUsedMemory = "" + Runtime.getRuntime().totalMemory() + "/" + Runtime.getRuntime().maxMemory();
        writer.print("{" +
                "\"vivoUrl\": \"" + vivoUrl + "\"" +
                ", \"totalMemory\": \"" + Runtime.getRuntime().totalMemory() + "\"" +
                ", \"maxMemory\": \"" + Runtime.getRuntime().maxMemory() + "\"" +
                ", " + mapToJson((Map) request.getAttribute(PortletRequest.USER_INFO)) +
                "}");
    }

    @ResourceMapping(value = "vivoUpdate")
    public void updateHistory(ResourceRequest request, ResourceResponse response)
            throws Exception {

        String key = request.getParameter("key");
        if (key==null) {
            throw new Exception("Must supply key parameter in call to vivoUpdate resource");
        }
        else if (!"searchList".equals(key)) {
            throw new Exception("Unfortunately we only support searchList at the moment.");
        }

        String value = request.getParameter("value");
        if (value==null) {
            throw new Exception("Must supply value parameter in call to vivoUpdate resource");
        }

        //USER_LOGIN_ID
        Map userInfo = (Map) request.getAttribute(PortletRequest.USER_INFO);
        String userId = MultiportalUserInfoUtilities.getUserId(userInfo);
        if (userId != null && !"".equals(userId.trim())) {
            // TODO: we shouldn't supply the object id here, only the userId. fix.
            vivoQueryService.saveOrUpdateVivoQuery(99, userId, value);
        }
        else {
            LOG.warn("Couldn't update vivo_portlet query history because userId was '" + userId + "'. userInfo map=" + mapToJson((Map) request.getAttribute(PortletRequest.USER_INFO)));
        }
    }

    @ResourceMapping(value = "vivoGet")
    public void getHistory(ResourceRequest request, ResourceResponse response)
            throws Exception {
        String result = "";

        String key = request.getParameter("key");
        if (key==null) {
            throw new Exception("Must supply key parameter in call to vivoUpdate resource");
        }
        else if (!"searchList".equals(key)) {
            throw new Exception("Unfortunately we only support searchList at the moment.");
        }

        //USER_LOGIN_ID
        Map userInfo = (Map) request.getAttribute(PortletRequest.USER_INFO);
        String userId = MultiportalUserInfoUtilities.getUserId(userInfo);
        if (userId != null && !"".equals(userId.trim())) {
            // TODO: we shouldn't supply the object id here, and should be doing find by userId. fix.
            VivoQueryDTO queryResult = vivoQueryService.findVivoQuery(99);
            if (queryResult!=null) {
                result = queryResult.getVivoQueryString();
            }
        }
        else {
            LOG.warn("Couldn't get vivo_portlet query history because userId was '" + userId + "'. userInfo map=" + mapToJson((Map) request.getAttribute(PortletRequest.USER_INFO)));
        }

        PrintWriter writer = response.getWriter();
        // was going to do jsonp, then was basically going to tweak shindig(?) gadget javascript to call portlet
        // for persistance calls, but for now just returning json
        //writer.print("historyResults({\"" + result + "\")}");
        writer.print("{\"" + result + "\")}"); // probably doesn't even need to be json, could just return value
    }

    public void setVivoUrl(String vivoUrl) {
        this.vivoUrl = vivoUrl;
    }
}
