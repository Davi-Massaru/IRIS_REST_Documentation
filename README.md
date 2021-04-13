## REST Documentation [ IRIS ]
This project is a developer tool to how you can be visually analyzing the flow of your REST API endpoints, based on a ObjectScript class reference;

With it is possible to add annotations to document your API to add more information when generating the documentation.

## Prerequisites

Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

# Installation 

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/Davi-Massaru/IRIS_REST_Documentation.git
```

Open the terminal in this directory and run:

```
$ docker-compose build
```

Run the IRIS container with your project:

```
$ docker-compose up -d
```
## Getting Started

In tem folder src/restApi you have sample of ObjectScript RestApi,looking for restApi.dispath.cls
try to access the link http://${host}:${port}/csp/${namespace}/RestDocumentation.View.DocumentationRestView.cls?CLASSNAME=restApi.dispath.cls

Note: 
- ${host} : the host that your server
- ${port} : the port of your application, is the same one where you access the Management portal
If necessary, login with the _SYSTEM or another user.
And now you have a UI visualization of the rest class Api.dispatch with its routes and Maps generated described in the XData UrlMap

```
XData UrlMap
{
    <Routes>
        <Map Prefix="/api/v1*" Forward="restApi.v1.api"/>
        <Map Prefix="/api/v2*" Forward="restApi.v2.api"/>
        <Route Url="/ping/" Method="POST" Call="PingPost" />
        <Route Url="/ping/" Method="GET" Call="Ping" />
        <Route Url="/ping/test/get/:myParameter/DocumentationMethodSample" Method="GET" Call="DocumentationMethodSample" Cors="true"/>
    </Routes>
}
```
<img src="https://github.com/Davi-Massaru/IRIS_REST_Documentation/blob/main/READMEFILES/show.mkv?raw=true"></img>


