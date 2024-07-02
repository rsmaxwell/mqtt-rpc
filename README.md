# mqtt-rpc

This project is the parent of a set of git modules which implement Remote procedure call (or request/response) form of messages over mqtt v5.

To download the complete set:

	git clone --recurse-submodules git@github.com:rsmaxwell/mqtt-rpc.git
	
which will result in the following:

    mqtt-rpc
    ├── ...
    ├── mqtt-rpc-common
    ├── mqtt-rpc-request
    ├── mqtt-rpc-response
    └── ...


mqtt expects a broker to be running to which a responder client and a number of requester clients can connect. 
One such broker is mosquitto ( https://mosquitto.org/ )

A requester publishes its requests on the "request" topic and expects a response on the "{clientID}/response" topic.
The responder listens for incoming requests on the "request" topic and sends responses to the appropriate "{clientID}/response" topic

The requester will receive responses asynchronously, so a mechanism is provided for the requesting thread to wait for the response to arrive 
before picking up the response and returning to the caller.

The requester will need customised implementations for:

- encoding their requests into a request object
- unpacking the response
     
The responder will need a customised implementation for:  

- unpacking the request
- processing the request
- generating a response
    

### Building

The project is expected to be compiled on a Jenkins build environment with a build file which:

* clones the project
* calls ./scripts/prepare.sh
    * which updates tags in Version.java with build information
    * writes build information to a file

* calls ./scripts/deploy.sh
    * which builds the project and deploys to a maven repository
        
However a user may find it more appropriate to user the scripts in the ./{subproject}/scripts/development-scripts

- build.bat, just builds the {subproject} into a jar

    


### Running the sample

In ./mqtt-rpc-response/scripts/development-scripts
* getDeps.bat - extracts all the dependent jars into the "runtime" directory     
* Responser.bat, starts the responser (loaded with a set of example request handlers)

In ./mqtt-rpc-request/scripts/development-scripts    
* getDeps.bat - extracts all the dependent jars into the "runtime" directory 
* calculator.bat - sends a calculator request (with parameters)
* getPages.bat - sends a simple request (no parameters)
* quit.bat - sends a special request which causes the responder to quit.

    

    
    
    
    
    