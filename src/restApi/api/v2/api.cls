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
ClassMethod GETsample() As %Status
{
    Return $$$ok
}

/// @ResponseBody(restApi.Model.Sample)
/// @RequestBody(restApi.Model.Company)
/// @ContentType(application/json)
/// @ParameterQuery(color,blue|green|red)
/// @ParameterQuery(name,string)
/// @ParameterQuery(company,string)
ClassMethod HEADsample() As %Status
{
    Return $$$ok
}

ClassMethod POSTsample() As %Status
{
    Return $$$ok
}

/// @ResponseBody(restApi.Model.Sample)
/// @RequestBody(restApi.Model.Company)
/// @ContentType(application/json)
/// @ParameterQuery(company,string)
ClassMethod PUTsample() As %Status
{
    Return $$$ok
}

ClassMethod DELETEsample() As %Status
{
    Return $$$ok
}

ClassMethod CONNECTsample() As %Status
{
    Return $$$ok
}

ClassMethod OPTIONSsample() As %Status
{
    Return $$$ok
}

ClassMethod TRACEsample() As %Status
{
    Return $$$ok
}

ClassMethod PATCHsample() As %Status
{
    Return $$$ok
}

XData UrlMap
{
<Routes>
<Route  Url="/ping/Test/url" Method="GET" Call="GETsample"  Cors="true"   />
<Route  Url="/ping/Test/url" Method="PUT" Call="PUTsample"     />
<Route  Url="/ping/Test/url" Method="HEAD" Call="HEADsample"    />
<Route  Url="/ping/Test/url" Method="POST" Call="POSTsample"    />
<Route  Url="/ping/Test/url" Method="TRACE" Call="TRACEsample"   />
<Route  Url="/ping/Test/url" Method="PATCH" Call="PATCHsample"   />
<Route  Url="/ping/Test/url" Method="DELETE" Call="DELETEsample"  />
<Route  Url="/ping/Test/url" Method="OPTIONS" Call="OPTIONSsample" />
<Route  Url="/ping/Test/url" Method="CONNECT" Call="CONNECTsample" /> 
</Routes>
}

}
