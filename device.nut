//Simple Switch Demo : For hackware meetup

outlet <- hardware.pin7;  //the pin where the relay is connected
outlet.configure(DIGITAL_OUT);  //tell the imp to configure this pin as a Digital ouput
outletState <- 1; //1=off,0=on -- because the driver chip is a positivie common

//Set initial state of the pin
outlet.write(outletState);

// function to turn LED on or off
function setState(state) {
    
    outletState = state == 0 ? 1 : 0;
    
    server.log("Set state: " + outletState == 1 ? "OFF" : "ON"); // + ", SSID:" + imp.getssid());
    outlet.write(outletState);
}

// register a event handler for "led" messages from the agent
agent.on("SwitchON", setState); 
