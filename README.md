# Sample Windows Buildpack #

This sample buildpack starts a simple webserver (using an HttpListener in PowerShell) that serves the static content of an app (your application must have an index.html).

A sample app is available in sample_app (**this is not an actual part of the buildpack**)

# Creating your own buildpack #

Windows buildpacks have the same directory structure as Linux buildpacks. You can check out the Linux documentation [here](http://docs.cloudfoundry.com/docs/using/deploying-apps/custom-buildpacks.html).

## Detect Script ##
The detect script has to be able to tell if an application is intended for a specific buildpack.
For example, an ASP.NET web application should have a web.config file. 
This script should return a 0 exit code if the app matched, and write the name of the buildpack to stdout.
Return 1 if the app does not match. 

The sample buildpack example looks for a file named 'index.html'.

## Compile Script ##
The compilation script has to do whatever is necessary for the application to run. This includes compilation. In this script you have access to a couple of parameters:

-  a cache path (you can use this path for reusable resources)
-  a build path (this is where the app is)

The stdout output that happens in this step will be visible to the user that is pushing the app, so you should write useful info, to keep the user informed of what's happening.

The sample buildpack just copies the 'static' buildpack directory to the app's directory. 

## Release Script ##
The release script needs to output a valid yaml file to stdout. The yaml contains information about where the start script for your buildpack is located.

The sample buildpack example the path is set to 'static\start.bat'.

## Start Script ##
The start script of your buildpack needs to run a webserver on the port specified by the **PORT** environment variable.

Your start script controls the lifetime of your application. If your script stops, the application stops. So make sure not to run the server as a background process.

In the example buildpack, the start script runs a powershell script that starts an HttpListener.

## Environment Variables ##

The following are a list of useful environment variables available in the context of your start script.

- TEMP=**[absolute path to your temp folder]**
- TMP=**[same as TEMP]**
- HOME=**[absolute path to your app directory]**
- VCAP_APPLICATION=**[JSON with info about your application - read more [here](http://docs.cloudfoundry.com/docs/using/deploying-apps/environment-variable.html#VCAP_APPLICATION)]**
- VCAP_SERVICES=**[JSON with info about services bound to your app - read more [here](http://docs.cloudfoundry.com/docs/using/deploying-apps/environment-variable.html#VCAP_SERVICES)]]**
- VCAP_APP_HOST=**[IP address of the host machine]**
- VCAP_APP_PORT=**[the port you have to start the webserver on]**
- PORT=**[same as VCAP_APP_PORT]**
- VCAP_WINDOWS_USER=**[name of the windows user running the app]**
- VCAP_WINDOWS_USER_PASSWORD=**[password of the windows user]**
 