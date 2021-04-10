Class restApi.dispath Extends %CSP.REST
{

/// Lorem ipsum dolor sit amet, consectetur adipiscing elit,
/// sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
/// Ut enim ad minim veniam
/// 
/// Annotations :
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

/// This endPoint return $$$OK to test the connection
/// always returns PONG
ClassMethod Ping() As %Status
{
    Write "Pong"
    Return $$$OK
}

/// This endPoint return $$$OK to test the connection and the %request.Content 
ClassMethod PingPost() As %Status
{
    Set %response.ContentType="application/json"
    W (##class(%DynamicAbstractObject).%FromJSON(%request.Content.Read())).%ToJSON()
    Return $$$OK
}

XData UrlMap
{
<Routes>
<Map Prefix="/api/v1*" Forward="restApi.v1.api"/>
<Map Prefix="/api/v2*" Forward="restApi.v2.api"/>
<Route Url="/ping/" Method="POST" Call="PingPost" Cors="true"/>
<Route Url="/ping/" Method="GET" Call="Ping" />
<Route Url="/DocumentationMethodSample" Method="GET" Call="DocumentationMethodSample" />
</Routes>
}

}
