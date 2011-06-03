package vivo.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.GWT;
import com.google.gwt.event.dom.client.*;
import com.google.gwt.user.client.rpc.AsyncCallback;
import com.google.gwt.user.client.ui.*;
import vivo.shared.dto.VivoQueryDTO;
import vivo.shared.services.VivoQueryService;
import vivo.shared.services.VivoQueryServiceAsync;

/**
 * Entry point classes define <code>onModuleLoad()</code>.
 */
public class GWTSpring implements EntryPoint {
    /**
     * The message displayed to the user when the server cannot be reached or
     * returns an error.
     */
    private static final String SERVER_ERROR = "An error occurred while "
            + "attempting to contact the server. Please check your network "
            + "connection and try again. The error is : ";

    /**
     * Create a remote service proxy to talk to the server-side VivoQuery service.
     */
    private final VivoQueryServiceAsync vivoQueryService = GWT
            .create(VivoQueryService.class);

    /**
     * This is the entry point method.
     */
    public void onModuleLoad() {
        final Button saveOrUpdateButton = new Button("SaveOrUpdate");
        final Button retrieveButton = new Button("Retrieve");
        final TextBox vivoQueryInfoField = new TextBox();
        vivoQueryInfoField.setText("VivoQuery Info");
        final TextBox vivoQueryIdField = new TextBox();
        final Label errorLabel = new Label();

        // We can add style names to widgets
        saveOrUpdateButton.addStyleName("sendButton");
        retrieveButton.addStyleName("sendButton");

        // Add the nameField and sendButton to the RootPanel
        // Use RootPanel.get() to get the entire body element
        RootPanel.get("vivoQueryInfoFieldContainer").add(vivoQueryInfoField);
        RootPanel.get("updateVivoQueryButtonContainer").add(saveOrUpdateButton);
        RootPanel.get("vivoQueryIdFieldContainer").add(vivoQueryIdField);
        RootPanel.get("retrieveVivoQueryButtonContainer").add(retrieveButton);
        RootPanel.get("errorLabelContainer").add(errorLabel);

        // Focus the cursor on the name field when the app loads
        vivoQueryInfoField.setFocus(true);
        vivoQueryInfoField.selectAll();

        // Create the popup dialog box
        final DialogBox dialogBox = new DialogBox();
        dialogBox.setText("Remote Procedure Call");
        dialogBox.setAnimationEnabled(true);
        final Button closeButton = new Button("Close");
        // We can set the id of a widget by accessing its Element
        closeButton.getElement().setId("closeButton");
        final Label textToServerLabel = new Label();
        final HTML serverResponseLabel = new HTML();
        VerticalPanel dialogVPanel = new VerticalPanel();
        dialogVPanel.addStyleName("dialogVPanel");
        dialogVPanel.add(new HTML("<b>Sending request to the server:</b>"));
        dialogVPanel.add(textToServerLabel);
        dialogVPanel.add(new HTML("<br><b>Server replies:</b>"));
        dialogVPanel.add(serverResponseLabel);
        dialogVPanel.setHorizontalAlignment(VerticalPanel.ALIGN_RIGHT);
        dialogVPanel.add(closeButton);
        dialogBox.setWidget(dialogVPanel);

        // Add a handler to close the DialogBox
        closeButton.addClickHandler(new ClickHandler() {
            public void onClick(ClickEvent event) {
                dialogBox.hide();
                saveOrUpdateButton.setEnabled(true);
                saveOrUpdateButton.setFocus(true);
                retrieveButton.setEnabled(true);
            }
        });

        // Create a handler for the saveOrUpdateButton and vivoQueryInfoField
        class SaveOrUpdateVivoQueryHandler implements ClickHandler, KeyUpHandler {
            /**
             * Fired when the user clicks on the saveOrUpdateButton.
             */
            public void onClick(ClickEvent event) {
                sendVivoQueryInfoToServer();
            }

            /**
             * Fired when the user types in the vivoQueryInfoField.
             */
            public void onKeyUp(KeyUpEvent event) {
                if (event.getNativeKeyCode() == KeyCodes.KEY_ENTER) {
                    sendVivoQueryInfoToServer();
                }
            }

            /**
             * Send the vivoQuery info from the vivoQueryInfoField to the server and wait for a response.
             */
            private void sendVivoQueryInfoToServer() {
                // First, we validate the input.
                errorLabel.setText("");
                String textToServer = vivoQueryInfoField.getText();

                // Then, we send the input to the server.
                saveOrUpdateButton.setEnabled(false);
                textToServerLabel.setText(textToServer);
                serverResponseLabel.setText("");

                String[] vivoQueryInfo = textToServer.split(" ");

                long vivoQueryId = Long.parseLong(vivoQueryInfo[0]);
                String userId = vivoQueryInfo[1];
                String vivoQueryString = vivoQueryInfo[2];

                vivoQueryService.saveOrUpdateVivoQuery(vivoQueryId, userId, vivoQueryString,
                        new AsyncCallback<Void>() {
                            public void onFailure(Throwable caught) {
                                // Show the RPC error message to the user
                                dialogBox
                                        .setText("Remote Procedure Call - Failure");
                                serverResponseLabel
                                        .addStyleName("serverResponseLabelError");
                                serverResponseLabel.setHTML(SERVER_ERROR + caught.toString());
                                dialogBox.center();
                                closeButton.setFocus(true);
                            }

                            public void onSuccess(Void noAnswer) {
                                dialogBox.setText("Remote Procedure Call");
                                serverResponseLabel
                                        .removeStyleName("serverResponseLabelError");
                                serverResponseLabel.setHTML("OK");
                                dialogBox.center();
                                closeButton.setFocus(true);
                            }
                        });
            }
        }

        // Create a handler for the retrieveButton and vivoQueryIdField
        class RetrieveVivoQueryHandler implements ClickHandler, KeyUpHandler {
            /**
             * Fired when the user clicks on the retrieveButton.
             */
            public void onClick(ClickEvent event) {
                sendVivoQueryIdToServer();
            }

            /**
             * Fired when the user types in the vivoQueryIdField.
             */
            public void onKeyUp(KeyUpEvent event) {
                if (event.getNativeKeyCode() == KeyCodes.KEY_ENTER) {
                    sendVivoQueryIdToServer();
                }
            }

            /**
             * Send the id from the vivoQueryIdField to the server and wait for a response.
             */
            private void sendVivoQueryIdToServer() {
                // First, we validate the input.
                errorLabel.setText("");
                String textToServer = vivoQueryIdField.getText();

                // Then, we send the input to the server.
                retrieveButton.setEnabled(false);
                textToServerLabel.setText(textToServer);
                serverResponseLabel.setText("");

                vivoQueryService.findVivoQuery(Long.parseLong(textToServer),
                        new AsyncCallback<VivoQueryDTO>() {
                            public void onFailure(Throwable caught) {
                                // Show the RPC error message to the user
                                dialogBox
                                        .setText("Remote Procedure Call - Failure");
                                serverResponseLabel
                                        .addStyleName("serverResponseLabelError");
                                serverResponseLabel.setHTML(SERVER_ERROR + caught.toString());
                                dialogBox.center();
                                closeButton.setFocus(true);
                            }

                            public void onSuccess(VivoQueryDTO vivoQueryDTO) {
                                dialogBox.setText("Remote Procedure Call");
                                serverResponseLabel
                                        .removeStyleName("serverResponseLabelError");
                                if (vivoQueryDTO != null)
                                    serverResponseLabel.setHTML("VivoQuery Information <br>Id : " + vivoQueryDTO.getVivoQueryId() + "<br>Name : " + vivoQueryDTO.getUserId() + "<br>Query : " + vivoQueryDTO.getVivoQueryString());
                                else
                                    serverResponseLabel.setHTML("No vivoQuery with the specified id found");
                                dialogBox.center();
                                closeButton.setFocus(true);
                            }
                        });
            }
        }

        // Add a handler to send the vivoQuery info to the server
        SaveOrUpdateVivoQueryHandler saveOrUpdateVivoQueryhandler = new SaveOrUpdateVivoQueryHandler();
        saveOrUpdateButton.addClickHandler(saveOrUpdateVivoQueryhandler);
        vivoQueryInfoField.addKeyUpHandler(saveOrUpdateVivoQueryhandler);

        // Add a handler to send the vivoQuery id to the server
        RetrieveVivoQueryHandler retrieveVivoQueryhandler = new RetrieveVivoQueryHandler();
        retrieveButton.addClickHandler(retrieveVivoQueryhandler);
        vivoQueryIdField.addKeyUpHandler(retrieveVivoQueryhandler);
    }
}
