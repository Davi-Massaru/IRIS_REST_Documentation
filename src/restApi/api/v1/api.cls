/// Lorem ipsum dolor sit amet, consectetur adipiscing elit,
/// sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
Class restApi.v1.api Extends %CSP.REST
{

ClassMethod MethodSithoutDescription() As %Status
{
    Set sc = $$$OK
    Return sc
}

/// TesteCallByDefinition
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
/// @ResponseBody(ResponseBodyRest)
/// @RequestBody(RequestBody)
/// @ContentType(application/json)
/// @ParameterQuery(color,blue|green|red)
/// @ParameterQuery(name,string)
ClassMethod DocumentationExample() As %Status
{
    Set sc = $$$OK
    // do something
    Return sc
}

XData UrlMap
{
<Routes>
<Route Url="/DocumentationExample/" Method="GET" Call="DocumentationExample" />
</Routes>
}

}
