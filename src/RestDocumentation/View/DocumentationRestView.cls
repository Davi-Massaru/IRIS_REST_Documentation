Class RestDocumentation.View.DocumentationRestView Extends %CSP.Page [ ProcedureBlock ]
{

ClassMethod OnPage() As %Status
{
    &html<
        <html>
            <head>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
                <link rel="stylesheet" href="/RestDocumentation/Style/style.css">

                <script src="/RestDocumentation/Js/chevron_animation.js"></script>
                <script src="/RestDocumentation/Js/formatter.js"></script>

                <link rel="icon" href="/RestDocumentation/Img/ISC_IRIS_prod_icon.svg" sizes="192x192">
                        <title>Documentation Rest</title>
            </head>
        <body>
        <section class="col-12 col-lg-8 mx-auto px-3" >>

        Try {

            Set classname = ""
            Set:$data(%request.Data("CLASSNAME",1)) classname= %request.Data("CLASSNAME",1)
            Write "<h1> Documentation of: ", classname, "</h1>"

            Set:(classname '= "") restDocumentation = ..GetDocumentationUrlMaps(classname)
            Do:(classname '= "") ..DrawUrlRoutes(restDocumentation)
            Do:(classname '= "") ..DrawUrlMaps(restDocumentation)
            
           } catch(sc){
            Write "<ul> this reference class has problems"
            WRITE "<li> error code: ",sc.Code,"</li>"
            WRITE "<li> error location: ",sc.Location,"</li>"
            WRITE "<li> errorText: ", $System.Status.GetErrorText(sc,1),"</li>"
            WRITE "<li> GetOneStatusText: ", $System.Status.GetOneStatusText(sc,1),"</li>"
            WRITE "</ul>"
        }
    &html<
        </section>
        </body>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
    </html>>
    Quit $$$OK
}

ClassMethod DrawUrlMaps(pRestDocumentation As RestDocumentation.Model.RestDocumentation) As %Status
{
    Set countMaps = pRestDocumentation.Maps.Count()
    Write:(countMaps > 0) "<br>  Maps:"
    For i=1:1:countMaps{
        
        Set map = pRestDocumentation.Maps.GetAt(i)
        Write "<br> ----------------------------------------"
        Write:(map.Description '= "") "<br> Description: ",$REPLACE(map.Description, $CHAR(13,10), "<br>" )
        Write:(map.Prefix '= "") "<br> Prefix: ",map.Prefix
        Write:(map.Forward '= "") "<br> Forward: ",map.Forward
    }
   Quit $$$OK
}

ClassMethod DrawUrlRoutes(pRestDocumentation As RestDocumentation.Model.RestDocumentation) As %Status
{
    Set countRoutes = pRestDocumentation.Routes.Count()
    Quit:( countRoutes = 0 ) $$$OK

    &html<
    <h4> Routes :</h4>
    <ul class="p-0">>
    For i=1:1:countRoutes{
        Set route = pRestDocumentation.Routes.GetAt(i)
        
        Set idList = $REPLACE((route.Call_route.Url_route.Method_i), "/","" )
        Set idList = $REPLACE((idList), ":","")
        
        Set colorMethod = $CASE(
            route.Method,
                "GET":"#10c9a1",
                "POST":"#2469d1",
                "PUT":"#e37527",
                "PATCH":"#f0c416",
                "DELETE":"#d12c37",
                "HEAD":"#870fd1",
                "OPTIONS":"#6e6e6e",
                "TRACE":"#2de066",
                "CONNECT":"#c71a87",
                :"#000"
        )

            &html<<li id="#(idList)#" class="list list-shadow" style="height: 52px;" data-bs-toggle="collapse" href="##(idList_"collapse")#" role="button" aria-expanded="false" aria-controls="collapseExample" onClick='setChevronState("#(idList)#")' >
                    <div class="w-100 h-100 d-flex">
                        <div class="m-2 method-tag d-flex align-items-center justify-content-center" style="background-color: #(colorMethod)#">
                            <span class="p-2 text-light">
                                <strong style="font-size: 14px;">> Write:(route.Method '= "") route.Method
                            &html< </strong> </span>
                        </div>
                        
                        <div class="m-2 ellipsis"> >
                            &html< <p class="m-0 route-name"> > Write:(route.Call '= "") route.Call &html< </p> >
                            &html< <p class="m-0 route lighter"> > Write:(route.Url '= "") route.Url   &html< </p> >
                        &html<</div>

                        <div class="m-2 ms-auto icon-area d-flex align-items-center justify-content-center">
                            <svg width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
                            </svg>
                        </div>
                    </div>
                </li>>

        &html<<div class="collapse collapsed-documentation p-3" id="#(idList_"collapse")#">>

            &html<
                <div class="mt-3 mb-4">
                    <h4 class="text-wrap">#(route.Call)#</h4>
                    <h5 class="lighter text-wrap">#(route.Url)# </h5>
                </div>

                <p class="description mx-2">#( $REPLACE(route.Description, $CHAR(13,10), "<br>" ))#</p>

            >
            
            Do:(route.ParameterQuery.Count() > 0) ..DescribeParameterQuerys(route.ParameterQuery)
            
            If ( (route.Cors '= "") || (route.ContentType '= "") ) {
                &html<
                    <div class="mt-4 d-flex align-items-center justify-content-between">
                        <p class="d-block h5 mb-0">Request:</p>
                        <div>
                >
                            Write:(route.ContentType '= "") "<span class='pill'><strong>content-type: </strong>"_route.ContentType_"</span>"
                            Write:(route.Cors '= "") "<span class='pill'><strong>cors: </strong>"_route.Cors_"</span>"
                &html<
                        </div>
                    </div>
                    <hr>
                >   
            }
    
            If (route.RequestBody '= ""){
                Set requestBody = ..interpretBody(route.RequestBody)

                &html<
                    <p class="mt-2 h6">Body:</p>

                    <code class="mt-1">
                        <pre><script language="javascript"> formatJson( #(requestBody)# ) </script></pre>
                    </code>
                >
            }

            If (route.ResponseBody '= ""){
                Set responseBody = ..interpretBody(route.ResponseBody)
                &html<
                    <p class="mt-4 h6">Response:</p>

                    <code class="mt-1">
                        <pre><script language="javascript"> formatJson( #(responseBody)# ) </script></pre>
                    </code>
                >
            }

        &html<</div>>
    }

    &html<</ul>>
    Quit $$$OK
}

ClassMethod DescribeParameterQuerys(pParameterQuerys As %ListOfDataTypes) As %Status
{
    &html<
        <p class="mt-3 h6">Query Params:</p>
    >

    Set CountParameterQuery =  pParameterQuerys.Count()

    &html<<div style="margin-left: 16px;">>
        For indexPameter=1:1:CountParameterQuery{
            Set parameterQuery = pParameterQuerys.GetAt(indexPameter)

            Set parameterName = $PIECE(parameterQuery,",",1)
            Set parameterInformation = $PIECE(parameterQuery,",",2)

            &html<
                <p class="mb-1"><strong>#(parameterName)#:</strong> #(parameterInformation)#</p>
            >

        }
    &html<</div>>

    Quit $$$OK
}

ClassMethod interpretBody(pBody) As %String
{
    Set structPropertyDefinition = ##Class(RestDocumentation.Service.JsonConverterService).GetStructPropertyDefinition(pBody)
    Set structPropertyDefinition = structPropertyDefinition.%ToJSON()
    Set structPropertyDefinition = $REPLACE(structPropertyDefinition,($CHAR(34)_"Bool(1)"_$CHAR(34)), "true")
    Set structPropertyDefinition = $REPLACE(structPropertyDefinition,($CHAR(34)_"Bool(0)"_$CHAR(34)), "false")
    Return structPropertyDefinition
}

ClassMethod GetDocumentationUrlMaps(pClassname As %String) As RestDocumentation.Model.RestDocumentation
{
    Set restDocumentation = ##Class(RestDocumentation.Service.DocumentationService).GetDocumentation(pClassname)
    Return restDocumentation
}

}
