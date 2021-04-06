Class RestDocumentation.ServiceDocumentation Extends %RegisteredObject
{

ClassMethod getListMapXData(pNameClass As %String) As %ListOfObjects
{
    Quit:'(..IsExtentionOfREST(pNameClass))

    Set tSC = ..GetRouteResult(pNameClass,"Map",.tResults)
    Quit:$$$ISERR(tSC)

    Set maps = ..ConvertXmlResultAttributesToObjectList(tResults)

    Set listMapDocumentaion = ##class(%ListOfObjects).%New()
    For index=1:1:maps.Count(){

        Set map = maps.GetAt(index)
        Set mapDocumentation =##class(RestDocumentation.Model.MapDocumentation).%New()
        Set mapDocumentation.Prefix = $PROPERTY(map, "Prefix")
        Set mapDocumentation.Forward = $PROPERTY(map, "Forward")

        Set classCalled = ##class(%Dictionary.ClassDefinition).%OpenId(mapDocumentation.Forward)
        Set mapDocumentation.Description = classCalled.Description

        Do listMapDocumentaion.Insert(mapDocumentation)
    }
    Return listMapDocumentaion
}

ClassMethod getListRoutesXData(pNameClass As %String) As %ListOfObjects
{
    Quit:'(..IsExtentionOfREST(pNameClass))

    Set tSC = ..GetRouteResult(pNameClass,"Route",.tResults)
    Quit:$$$ISERR(tSC)

    Set routes = ..ConvertXmlResultAttributesToObjectList(tResults)
    Set listRouteDocumentaion = ##class(%ListOfObjects).%New()
    For indexRoute=1:1:routes.Count(){

        Set route = routes.GetAt(indexRoute)
        Set routeDocumentaion =##class(RestDocumentation.Model.RouteDocumentaion).%New()
        Set routeDocumentaion.Url =  $PROPERTY(route, "Url")
        Set routeDocumentaion.Method = $PROPERTY(route, "Method")
        Set routeDocumentaion.Call = $PROPERTY(route, "Call")
        Set routeDocumentaion.Cors = $PROPERTY(route, "Cors")

        Set descriptionMethd = ..GetDescriptionMethd(pNameClass_"||"_routeDocumentaion.Call)
        Set routeDocumentaion.Description = descriptionMethd.description
        Set routeDocumentaion.ResponseBody = descriptionMethd.ResponseBody
        Set routeDocumentaion.RequestBody  = descriptionMethd.RequestBody
        Set routeDocumentaion.ContentType  = descriptionMethd.ContentType
        Set routeDocumentaion.ParameterQuery = descriptionMethd.ParameterQuery

        Do listRouteDocumentaion.Insert(routeDocumentaion)
    }

    Return listRouteDocumentaion
}

ClassMethod GetRouteResult(pNameClass As %String, pExpression As %String, Output pResults As %ListOfObjects(CLASSNAME="%XML.XPATH.RESULT")) As %Status
{
    Return:'(..IsExtentionOfREST(pNameClass)) 0

    Set UrlMap = ##class(%Dictionary.XDataDefinition).%OpenId(pNameClass_"||UrlMap").Data
    Return:'$IsObject(UrlMap) 0

    Set tSC = ##class(%XML.XPATH.Document).CreateFromStream(UrlMap,.tDocument) 
    Return:$$$ISERR(tSC) tSC

    Set tSC=tDocument.EvaluateExpression("/Routes",pExpression,.pResults)
    Return:$$$ISERR(tSC) tSC

    Return $$$OK
}

ClassMethod GetDescriptionMethd(pDefinitionMethod As %String) As RestDocumentation.Model.descriptionMethod
{
    Set descriptionMethod = ##class(RestDocumentation.Model.descriptionMethod).%New()
    Set methodDefinition = ##class(%Dictionary.MethodDefinition).%OpenId(pDefinitionMethod)

    Set listDescription = $LISTFROMSTRING(methodDefinition.Description, "@")

    For index=1:1:$LISTLENGTH(listDescription){
        Set description = $LIST(listDescription, index)
        Set descriptionMethod.description = descriptionMethod.description _"@"_ description
        Set:( $FIND(description, "ResponseBody") > 0) descriptionMethod.ResponseBody = ..GetAnnotationValue(description)
        Set:( $FIND(description, "RequestBody") > 0) descriptionMethod.RequestBody = ..GetAnnotationValue(description)
        Set:( $FIND(description, "ContentType") > 0) descriptionMethod.ContentType = ..GetAnnotationValue(description)
        Do:( $FIND(description, "ParameterQuery") > 0) descriptionMethod.ParameterQuery.Insert( ..GetAnnotationValue(description) )
    }
    Return descriptionMethod
}

ClassMethod GetAnnotationValue(pAnnotation As %String) As %String
{
    Set pAnnotation = $REPLACE(pAnnotation, $CHAR(13,10), "")
    Set regex = ##class(%Regex.Matcher).%New("(?<=\().+?(?=\))", pAnnotation)
    Return:'(regex.Locate()) ""
    Set value = regex.Group
    Set value = $REPLACE(value, " ", "")
    Return value
}

ClassMethod ConvertXmlResultAttributesToObjectList(pResults As %ListOfObjects(CLASSNAME="%XML.XPATH.RESULT")) As %ListOfObjects
{
    Set listOfObjects = ##class(%ListOfObjects).%New()
    For index=1:1:pResults.Count(){
        Set result = pResults.GetAt(index)
        While result.Read(){
            If result.HasAttributes {

                Set objectAttributes = ##class(%Library.DynamicObject).%New()
                For indexObject=1:1:result.AttributeCount {
                    Do result.MoveToAttributeIndex(indexObject)
                    Set $PROPERTY(objectAttributes, result.Name) = result.Value
                }
                Do listOfObjects.Insert(objectAttributes)

            }
        }
    }

    Return listOfObjects
}

ClassMethod IsExtentionOfREST(pNameClass As %String) As %Boolean
{
 	Set classDefinition = ##class(%Dictionary.ClassDefinition).%OpenId(pNameClass)
    Set superclasses  = $LISTFROMSTRING(classDefinition.Super,",")
    Set isREST = ($LISTFIND(superclasses,"%CSP.REST") > 0 )
    Return isREST
}

}
