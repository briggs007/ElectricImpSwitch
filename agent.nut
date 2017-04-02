// Log the URLs we need
// server.log("Turn On: " + http.agenturl());

outletState <- 0;

function requestHandler(request, response) {
    server.log("HTTP Request received");
    local responseText = "&nbsp";
    
    local homePageTop = "<html><head><title>Smart Socket</title></head><body>" + 
        "<p><input style='width:200;height:80' type=\"submit\" value=\"Switch ON\" onclick=\"location.href='" + http.agenturl() + "?SwitchON=1';\"/><br />" +
        "<input style='width:200;height:80' type=\"submit\" value=\"Switch OFF\" onclick=\"location.href='" + http.agenturl() + "?SwitchON=0';\"/></p><p>";
        
    local homePageBottom = "</p><body></html>";
    
    try {
        if ("SwitchON" in request.query) {
            if (request.query.SwitchON == "1" || request.query.SwitchON == "0") {

                local state = request.query.SwitchON.tointeger();
                device.send("SwitchON", state);
                responseText = "OK";
            } // need to handle else case
        }
        
        // send a response back saying everything was OK.
        response.send(200, homePageTop + responseText + homePageBottom);
        
    } catch (ex) {
        response.send(500, "Something went wrong: " + ex);
    }
}

// ------- Event Handlers -------------
// register the HTTP handler
http.onrequest(requestHandler);
