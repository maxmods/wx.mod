' Copyright (c) 2008 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Import "mappercore.bmx"

Global PROJECT_TYPE_FBP:Int = NextProjectId()

Type TFBPObject Extends TFBObject

	Method New()
		oType = PROJECT_TYPE_FBP
	End Method

	Function ImportProject:TFBObject(filename:String, version:Float Var)

		Local doc:TxmlDoc = TxmlDoc.parseFile(filename)

		Local root:TxmlNode = doc.getRootElement()
		
		Local project:TFBObject
		
		For Local node:TxmlNode = EachIn root.getChildren()
		
			If node.GetName() = "FileVersion" Then
				version = node.GetAttribute("major").ToFloat() + (node.GetAttribute("minor").ToFloat()/10.0)
			End If
		
			If node.GetName() = "object" Then
				project = New TFBPObject
				project.extractDetails(node)
			End If
		
		Next
		
		doc.Free()
		doc = Null
	
		Return project
		
	End Function
	
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
						Local widget:TFBPObject = New TFBPObject
						objects.AddLast(widget)
						widget.extractDetails(det)
				End Select
			
			Next
		End If
		
	End Method

End Type
