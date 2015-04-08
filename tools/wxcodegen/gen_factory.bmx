' Copyright (c) 2008-2015 Bruce A Henderson
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

Import "fbpmapper.bmx"
Import "pjdmapper.bmx"
Import "wxgmapper.bmx"

Type TObjectFactory

	Function ImportObject:TFBObject(filename:String, version:Float Var)
		
		If filename.EndsWith(".fbp") Then
			Return TFBPObject.ImportProject(filename, version)
		Else If filename.EndsWith(".pjd") Then
			Return TPJDObject.ImportProject(filename, version)
		Else If filename.EndsWith(".wxg") Then
			Return TWXGObject.ImportProject(filename, version)
		End If
		
		Return Null		
	End Function

End Type

Function IsProjectSupported:Int(filename:String)
	Return filename.EndsWith(".fbp") Or filename.EndsWith(".pjd") Or filename.EndsWith(".wxg")
End Function

Function NewObjectForType:TFBObject(oType:Int)

	Select oType
		Case PROJECT_TYPE_FBP
			Return New TFBPObject
		Case PROJECT_TYPE_PJD
			Return New TPJDObject
		Case PROJECT_TYPE_WXG
			Return New TWXGObject
	End Select

	Return Null
End Function