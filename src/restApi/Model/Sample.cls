Class restApi.Model.Sample Extends %RegisteredObject
{

Property Name As %String;

Property Address As %Library.String;

Property Age As %Integer;

Property HasChildren As %Boolean;

Property Childrens As list Of restApi.Model.Children;

Property Company As restApi.Model.Company;

}
