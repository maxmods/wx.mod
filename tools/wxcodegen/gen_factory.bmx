SuperStrict

Import BaH.libxml


Type TObjectFactory

	Function ImportObject:TFBObject(filename:String, version:Float Var)
		
		If filename.EndsWith(".fbp") Then
			Return ImportFormBuilderProject(filename, version)
		Else If filename.EndsWith(".pjd") Then
			Return ImportDialogBlocksProject(filename, version)
		End If
		
		Return Null		
	End Function
	
	Function ImportFormBuilderProject:TFBObject(filename:String, version:Float Var)

		Local doc:TxmlDoc = TxmlDoc.parseFile(filename)

		Local root:TxmlNode = doc.getRootElement()
		
		Local project:TFBObject
		
		For Local node:TxmlNode = EachIn root.getChildren()
		
			If node.GetName() = "FileVersion" Then
				version = node.GetAttribute("major").ToFloat() + (node.GetAttribute("minor").ToFloat()/10.0)
			End If
		
			If node.GetName() = "object" Then
				project = New TFBObject
				project.extractDetails(node)
			End If
		
		Next
		
		doc.Free()
		doc = Null
	
		Return project

	End Function

	Function ImportDialogBlocksProject:TFBObject(filename:String, version:Float Var)
		
	End Function
	
End Type


Type TFBObject

	Field class:String
	Field subclass:String
	Field expanded:Int

	Field properties:TMap = New TMap
	Field events:TMap = New TMap
	
	Field objects:TList = New TList


	Method extractDetails(node:TxmlNode)
	
		class = node.GetAttribute("class")
		subclass = node.GetAttribute("subclass")
		expanded = Int(node.GetAttribute("expanded"))
		
		Local children:TList = node.getChildren()
		
		If children Then
			For Local det:TxmlNode = EachIn children
			
				Select det.GetName()
				
					Case "property"
						Local text:String = det.GetText().Trim()
						If text Then
							Local name:String = det.getAttribute("name")
							properties.Insert(name, text)
						End If
					Case "event"
						Local text:String = det.GetText().Trim()
						If text Then
							Local name:String = det.getAttribute("name")
							events.Insert(name, text)
						End If
					Case "object"
						Local widget:TFBObject = New TFBObject
						objects.AddLast(widget)
						widget.extractDetails(det)
				End Select
			
			Next
		End If
		
	End Method
	
	Method Free()
		properties.Clear()
		events.Clear()
		
		For Local obj:TFBObject = EachIn objects
			obj.Free()
		Next
		
		objects.Clear()
	End Method

End Type

