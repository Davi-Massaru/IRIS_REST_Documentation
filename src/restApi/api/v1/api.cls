/// Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
Class restApi.v1.api Extends %CSP.REST
{

ClassMethod MethodWithoutDescription() As %Status
{
    Set sc = $$$OK
    Return sc
}

/// TesteCallByDefinition
/// Lorem ipsum dolor sit amet, consectetur adipiscing elit
ClassMethod TesteCallByDefinition() As %Status
{
    Set sc = $$$OK
    Write "TesteCallByDefinition"
    Return sc
}

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
ClassMethod DocumentationExample() As %Status
{
    Set sc = $$$OK
    // do something
    Return sc
}

XData UrlMap
{
<Routes>
<Route Url="/DocumentationExample/:pParameter/show" Method="GET" Call="DocumentationExample" Cors="true" />
<Route Url="/TesteCallByDefinition" Method="POST" Call="TesteCallByDefinition" />
<Route Url="/MethodWithoutDescription" Method="CONNECT" Call="MethodWithoutDescription" />
</Routes>
}

}
