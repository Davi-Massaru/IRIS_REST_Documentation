Class restApi.dispath Extends %CSP.REST
{

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
</Routes>
}

}
