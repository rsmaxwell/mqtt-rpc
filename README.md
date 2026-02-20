# mqtt-rpc


Some webapps need both a request/resonse and a publish/subscribe messaging model to both make requests to a server which require a particular response (e.g. logon) and
also to subscribe to events as they happen (e.g. display share price). http works well for request/response but has to resort to polling to keep up-to-date in a dynamic environment. 
MQTT is built around the publish/subscribe model and now in v5 supports request/response as well. This package uses these mqtt v5 features to provide an implementation of request/response messaging. 

*MQTT* requires a broker process to be running to which clients connect. In the case of mqtt-rpc there is one client (*Responder*) which listens to a well known topic, and sends replies to a reply_topic,
the name of which was contained in the original request. There may be many *Requester* clients which send requests, and wait for a reply.  *Requester* clients can only make requests which are supported by the *Responder*.

One example of an *MQTT* broker is **Mosquitto**  ( https://mosquitto.org/ ). Connections to the *MQTT* broker, which will be exposed to the internet, need to be appropriately secured





## Download

To clone this project and the subprojects:

```
git clone --recurse-submodules git@github.com:rsmaxwell/mqtt-rpc.git
```



	

    

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
* quit.bat - sends a special request which causes the responder to quit

    

    
    
    
    
    