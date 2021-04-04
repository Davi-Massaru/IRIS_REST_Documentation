Class RestDocumentation.ServiceDocumentation Extends %RegisteredObject
{

ClassMethod getListRoutesXData(pNameClass As %String) As %ListOfObjects
{
    Quit:'(..IsExtentionOfREST(pNameClass))

    Set tSC = ..GetRouteResult(pNameClass,"Route",.tResults)
    Quit:$$$ISERR(tSC)

    Set routes = ..ConvertXmlResultAttributesToObjectList(tResults)
    Set listRouteDocumentaion = ##class(%ListOfObjects).%New()
    For indexRoute=1:1:routes.Count(){

        Set route = routes.GetAt(indexRoute)
        Set routeDocumentaion =##class(RestDocumentation.RouteDocumentaion).%New()
        Set routeDocumentaion.Url =  $PROPERTY(route, "Url")
        Set routeDocumentaion.Method = $PROPERTY(route, "Method")
        Set routeDocumentaion.Call = $PROPERTY(route, "Call")
        Set routeDocumentaion.Cors = $PROPERTY(route, "Cors")

        Do listRouteDocumentaion.Insert(routeDocumentaion)
    }

    Return listRouteDocumentaion
}

ClassMethod GetRouteResult(pNameClass As %String, pExpression As %String, Output pResults As %ListOfObjects(CLASSNAME="%XML.XPATH.RESULT")) As %Status
{
    Return:'(..IsExtentionOfREST(pNameClass)) 0

    Set UrlMap = ##class(%Dictionary.XDataDefinition).%OpenId(pNameClass_"||UrlMap").Data
    Return:'$IsObject(UrlMap)

    Set tSC = ##class(%XML.XPATH.Document).CreateFromStream(UrlMap,.tDocument) 
    Return:$$$ISERR(tSC) tSC

    Set tSC=tDocument.EvaluateExpression("/Routes",pExpression,.pResults)
    Return:$$$ISERR(tSC) tSC

    Return $$$OK
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
