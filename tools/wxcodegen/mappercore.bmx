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

Import BaH.libxml

' the base object type
Type TFBObject

	Field oType:Int

	Field class:String
	Field subclass:String
	Field expanded:Int

	Field properties:TMap = New TMap
	Field events:TMap = New TMap
	
	Field objects:TList = New TList

	Function ImportProject:TFBObject(filename:String, version:Float Var) Abstract

	Method extractDetails(node:TxmlNode) Abstract
	
	Method Free()
		properties.Clear()
		events.Clear()
		
		For Local obj:TFBObject = EachIn objects
			obj.Free()
		Next
		
		objects.Clear()
	End Method

End Type

Function NextProjectId:Int()

	Global id:Int = 0

	id :+ 1
	
	Return id
	
End Function