Class RestDocumentation.Service.JsonConverterService Extends %RegisteredObject
{

ClassMethod GetStructPropertyDefinition(pClassName As %String) As %Library.DynamicObject
{
    Set Struct = ##Class(%Library.DynamicObject).%New()
    Set class = ##class(%Dictionary.ClassDefinition).%OpenId(pClassName)
    For indexProperty = 1:1:class.Properties.Count(){
        Set property = class.Properties.GetAt(indexProperty)
        Set $PROPERTY(Struct, property.Name ) = ..GetPropertyReferenceValue(property)
    }

    Return Struct
}

ClassMethod GetPropertyReferenceValue(pProperty As %Dictionary.PropertyDefinition) As %Library.DynamicObject
{
    Return:( (pProperty.Collection = "list") || (pProperty.Collection = "array")) [ ( ..InterpreterPropertyType(pProperty.Type) ) ]
    Return ..InterpreterPropertyType(pProperty.Type)
}

ClassMethod InterpreterPropertyType(pPropertyType As %String) As %Status
{
    Set lastPackagename = $PIECE(pPropertyType,".", *)
    Set lastPackagename = $REPLACE(lastPackagename,"%","")
 
    Set value = $Case( 
        lastPackagename,
	        "String" :      "String",
			"Integer":		##class(%PopulateUtils).Integer(),
			"Date":			##class(%PopulateUtils).Date(),
			"Binary":		##class(%PopulateUtils).String(),
			"Double":		##class(%PopulateUtils).Float(),
			"Name":			##class(%PopulateUtils).Name(),
			"Boolean":		"Bool("_$zu(165, 1 , 2)_")",
			"Currency":		##class(%PopulateUtils).Currency(),
			"Float":		##class(%PopulateUtils).Float(),
			"Numeric":		##class(%PopulateUtils).Float(),
			"Decimal":		##class(%PopulateUtils).Float(),
            "SmallInt":     ##class(%PopulateUtils).Integer(-32768,32767),
            "Time":         ##class(%PopulateUtils).Integer( 0, 86399),
            "TinyInt":      ##class(%PopulateUtils).Integer(-128, 127) ,
            "BigInt":       ##class(%PopulateUtils).Integer(-100000000000000000, 100000000000000000) ,
			"PosixTime":	##class(%PopulateUtils).PosixTime(),
			"TimeStamp":	##class(%PopulateUtils).TimeStamp(),
            : "NULL"
    )

    Set:(value = "NULL") value = ..GetStructPropertyDefinition(pPropertyType)
    
    Return value
}

}
