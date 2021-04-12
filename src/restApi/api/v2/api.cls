Class restApi.v2.api Extends %CSP.REST
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
ClassMethod MethodGET() As %Status
{
    Return $$$ok
}

/// @ResponseBody(restApi.Model.Sample)
/// @RequestBody(restApi.Model.Company)
/// @ContentType(application/json)
/// @ParameterQuery(color,blue|green|red)
/// @ParameterQuery(name,string)
/// @ParameterQuery(company,string)
ClassMethod MehtodHEad() As %Status
{
    Return $$$ok
}

ClassMethod POST() As %Status
{
    Return $$$ok
}

/// @ResponseBody(restApi.Model.Sample)
/// @RequestBody(restApi.Model.Company)
/// @ContentType(application/json)
/// @ParameterQuery(company,string)
ClassMethod PUT() As %Status
{
    Return $$$ok
}

ClassMethod DELETE() As %Status
{
    Return $$$ok
}

ClassMethod CONNECT() As %Status
{
    Return $$$ok
}

ClassMethod OPTIONS() As %Status
{
    Return $$$ok
}

ClassMethod TRACE() As %Status
{
    Return $$$ok
}

ClassMethod PATCH() As %Status
{
    Return $$$ok
}

XData UrlMap
{
<Routes>
<Route  Url="/ping/Test/url" Method="GET" Call="MethodGET"  Cors="true"   />
<Route  Url="/ping/Test/url" Method="PUT" Call="PUT"     />
<Route  Url="/ping/Test/url" Method="HEAD" Call="MehtodHEad"    />
<Route  Url="/ping/Test/url" Method="POST" Call="POST"    />
<Route  Url="/ping/Test/url" Method="TRACE" Call="TRACE"   />
<Route  Url="/ping/Test/url" Method="PATCH" Call="PATCH"   />
<Route  Url="/ping/Test/url" Method="DELETE" Call="DELETE"  />
<Route  Url="/ping/Test/url" Method="OPTIONS" Call="OPTIONS" />
<Route  Url="/ping/Test/url" Method="CONNECT" Call="CONNECT" /> 
</Routes>
}

}
