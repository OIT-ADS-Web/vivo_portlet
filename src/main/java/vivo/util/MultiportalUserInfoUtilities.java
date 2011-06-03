package vivo.util;

import javax.portlet.PortletRequest;
import java.util.Map;

public class MultiportalUserInfoUtilities {

    /**
     * Gets user id in a way that is hopefully more compliant with various portals and common configurations.
     *
     * @param userInfo - assumes that (Map) request.getAttribute(PortletRequest.USER_INFO) is passed in as this param
     * @return
     */
    public static String getUserId(Map userInfo) {
        String result = null;
        if (userInfo != null) {
            // JSR-286
            result = (String) userInfo.get(PortletRequest.P3PUserInfos.USER_LOGIN_ID);
            if (result == null) {
                // Liferay 4, 5, 6 way of getting login id
                result = (String) userInfo.get("liferay.user.id");
                if (result == null) {
                    // JSR-168
                    result = (String) userInfo.get("user.login.id");
                    if (result == null) {
                        // another possible user id, from common LDAP user id
                        result = (String) userInfo.get("uid");
                    }
                }
            }
        }

        return result;
    }
}
