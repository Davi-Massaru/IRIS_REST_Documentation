Class RestDocumentation.View.DocumentationRestView Extends %CSP.Page [ ProcedureBlock ]
{

ClassMethod OnPage() As %Status
{
    &html<
        <html>
            <head>>
            Do ..ServeStyleSheet()
    &html<</head>
        <body>
        <section class="col-12 col-md-6 mx-auto px-3" >
        >

            Set classname = ""
            Set:$data(%request.Data("CLASSNAME",1)) classname= %request.Data("CLASSNAME",1)
            Write "<h1> Documentation of: ", classname, "</h1>"

            Set:(classname '= "") restDocumentation = ..GetDocumentationUrlMaps(classname)
            Do:(classname '= "") ..DrawUrlRoutes(restDocumentation)
            Do:(classname '= "") ..DrawUrlMaps(restDocumentation)

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
   Quit ""
}

ClassMethod DrawUrlRoutes(pRestDocumentation As RestDocumentation.Model.RestDocumentation) As %Status
{
    Set countRoutes = pRestDocumentation.Routes.Count()
    Quit:( countRoutes = 0 ) $$$OK

    Write "<ul>  Routes:"
    For i=1:1:countRoutes{
        Set route = pRestDocumentation.Routes.GetAt(i)
        
        Set idList = $REPLACE((route.Call_route.Url_route.Method_i), "/","" )
        Set idList = $REPLACE((idList), ":","")
        
        Set colorMethod = $CASE(
            route.Method,
                "GET":"#00b5b0",
                "POST":"#333695",
                "HEAD":"#18aa04",
                "PUT":"#cd6a01",
                "DELETE":"#e52920",
                "PATCH":"#8d5209",
                "OPTIONS":"#7a1e74",
                "TRACE":"#7a7a1e",
                "CONNECT":"#08215f",
                :"#000"
            )
            
            &html<<li class="mb-3" data-bs-toggle="collapse" href="##(idList)#" role="button" aria-expanded="false" aria-controls="collapseExample" >
                    <div class="w-100 d-flex">

                        <div class="m-2 center method-tag" style="background-color: #(colorMethod)#">
                            <span class="p-2">>
                                Write:(route.Method '= "") route.Method
                            &html<</span>

                        </div>

                        <div class="m-2 " >> Write:(route.Url '= "") route.Url &html<</div>
                        <div class="m-2 ms-auto" > V </div>
                    </div>
                </li>>
            //Write:(route.Call '= "") route.Call

        Write "<div class='collapse' id='"_idList_"'>"
        Write:(route.ContentType '= "") "<br> ContentType: ", route.ContentType
        Write:(route.ParameterQuery.Count() > 0) ..DescribeParameterQuerys(route.ParameterQuery)
        Write:(route.Description '= "") "<br> Description: ", $REPLACE(route.Description, $CHAR(13,10), "<br>" )
        Write:(route.Cors '= "") "<br> Cors:", route.Cors
        Write:(route.RequestBody '= "") "<br> Request Body: ", ..interpretBody(route.RequestBody)
        Write:(route.ResponseBody '= "") "<br> Response Body: ", ..interpretBody(route.ResponseBody)
        Write "</div>"

    }

    Write "</ul>"
    Quit ""
}

ClassMethod DescribeParameterQuerys(pParameterQuerys As %ListOfDataTypes) As %Status
{
    Set CountParameterQuery =  pParameterQuerys.Count()
    Write "<ul> ParameterQuerys: "
    For indexPameter=1:1:CountParameterQuery{
        Set parameterQuery = pParameterQuerys.GetAt(indexPameter)
        Write:(parameterQuery '= "") "<li> ", parameterQuery, "</li>"
    }
    Write "</ul>"
    Quit ""
}

ClassMethod interpretBody(pBody) As %Status
{
    Set structPropertyDefinition = ##Class(RestDocumentation.Service.JsonConverterService).GetStructPropertyDefinition(pBody)
    Write structPropertyDefinition.%ToJSON()
    Quit ""
}

ClassMethod GetDocumentationUrlMaps(pClassname As %String) As RestDocumentation.Model.RestDocumentation
{
    Set restDocumentation = ##Class(RestDocumentation.Service.DocumentationService).GetDocumentation(pClassname)
    Return restDocumentation
}

ClassMethod ServeStyleSheet() As %Status [ Private ]
{

    &html<
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

    <style type="text/css"> 

        a {
            text-decoration: none;
            color: #000;
        }

        a:hover {
            color: #000;
        }

        ul {
            list-style-type: none;
        }

        .center {
            text-align: center;
            color:#fff;
        }

        .method-tag {
            font-weight: bolder;
            width:110px;
            border-radius: 5px;
        }

    </style>
    >
    Quit $$$OK
}

}
