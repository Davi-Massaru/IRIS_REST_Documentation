Class restApi.v2.api Extends %CSP.REST
{

ClassMethod GET() As %Status
{
Return $$$ok
}

ClassMethod HEAD() As %Status
{
Return $$$ok
}

ClassMethod POST() As %Status
{
Return $$$ok
}

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
<Route  Url="/ping/Test/url" Method="GET" Call="GET"     />
<Route  Url="/ping/Test/url" Method="PUT" Call="PUT"     />
<Route  Url="/ping/Test/url" Method="HEAD" Call="HEAD"    />
<Route  Url="/ping/Test/url" Method="POST" Call="POST"    />
<Route  Url="/ping/Test/url" Method="TRACE" Call="TRACE"   />
<Route  Url="/ping/Test/url" Method="PATCH" Call="PATCH"   />
<Route  Url="/ping/Test/url" Method="DELETE" Call="DELETE"  />
<Route  Url="/ping/Test/url" Method="OPTIONS" Call="OPTIONS" />
<Route  Url="/ping/Test/url" Method="CONNECT" Call="CONNECT" /> 
</Routes>
}

}
