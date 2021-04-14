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

<img src="https://github.com/Davi-Massaru/IRIS_REST_Documentation/blob/main/READMEFILES/show.gif?raw=true"></img>

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

Compare to

<img src="https://github.com/Davi-Massaru/IRIS_REST_Documentation/blob/main/READMEFILES/ui.png?raw=true"></img>

## Document your Rest API

ROUTES:

Sumary
 - Url : It is provided by the XData UrlMap < Route __Url = ""__  >  described in the class
 - Method :  It is provided by the XData UrlMap < Route __Method = ""__  >  described in the class
 - Call :  It is provided by XData UrlMap < Route __Call = ""__  > described in the class
 - Cors : It is provided by XData UrlMap < Route __Cors = ""__  > described in the class
 - Description : It is provided by __Method description__ in the __classmethod__ called by < Route __Call=""__ >  
 - ResponseBody : It is provided by __Annotation @ResponseBody( )__ described in the __Method description__
 - RequestBody :  It is provided by __Annotation @RequestBody( )__ described in the __Method description__
 - ContentType :  It is provided by __Annotation @ContentType( )__ described in the __Method description__
 - ParameterQuery (LIST) :  It is provided by __Annotation @ParameterQuery( )__ described in the __Method description__ you can enter several @ParameterQuery( )

Maps: 
 - Prefix : It is provided by the XData UrlMap < Map __Prefix = ""__  >  described in the class;
 - Forward : It is provided by the XData UrlMap < Map __Forward = ""__  >  described in the class;
 - Description : It is provided by the __Description class__  described in the class caled in Forward;

## Annotations

The Annotations are defined in the description of the method and are used to add additional information to the RestAPI documentation;

```
Class restApi.api Extends %CSP.REST
{

    /// Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. 
    /// It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
    /// 
    /// @ResponseBody(restApi.Model.Sample)
    /// @RequestBody(restApi.Model.Company)
    /// @ContentType(application/json)
    /// @ParameterQuery(color,blue|green|red)
    /// @ParameterQuery(name,string)
    /// @ParameterQuery(company,string)
    ClassMethod DocumentationMethodSample() As %Status
    {
        Set sc = $$$OK
        // do something
        Return sc
    }

    XData UrlMap
    {
    <Routes>
    <Route Url="/ping/get/:myParameter/DocumentationMethodSample" Method="GET" Call="DocumentationMethodSample"/>
    </Routes>
    }
}
```

<img src="https://github.com/Davi-Massaru/IRIS_REST_Documentation/blob/main/READMEFILES/DocumentationMethodSample.png?raw=true"></img>

Note: no one Annotations is required

### ResponseBody And RequestBody 

These annotations work as %RegisteredObject interpreters, input the reference of your class as a value, and the application will try to convert them to a representative JSON structure based on the object's Properties.

Sample: 

If you want to represent a JSON with the structure below:
```
{
    "Description": "String",
    "IsMultinational": true,
    "Name": "String",
    "QuantityEmployees": 544494327
}

```

Build a representative class as described below.

```
Class restApi.Model.Company Extends %RegisteredObject
{

Property Name As %String;

Property Description As %String;

Property QuantityEmployees As %Integer;

Property IsMultinational As %Boolean;

}

```
When you create an Annotations @ResponseBody or @RequestBody input the class reference like a @RequestBody(rest Api.Model.Company) and this JSON representation will appear in the __Body:__

<img src="https://github.com/Davi-Massaru/IRIS_REST_Documentation/blob/main/READMEFILES/Body.png?raw=true"></img>