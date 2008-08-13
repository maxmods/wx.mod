' Copyright (c) 2007,2008 Bruce A Henderson
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

Rem
bbdoc: wxXmlResource
End Rem
Module wx.wxXmlResource

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007 Bruce A Henderson"
ModuleInfo "Modserver: BRL"

?linux
ModuleInfo "CC_OPTS: -D__WXGTK__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?win32
ModuleInfo "CC_OPTS: -DHAVE_W32API_H"
ModuleInfo "CC_OPTS: -D__WXMSW__"
ModuleInfo "CC_OPTS: -D_UNICODE"
ModuleInfo "CC_OPTS: -DUNICODE"
?macos
ModuleInfo "CC_OPTS: -D__WXMAC__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: 
End Rem
Type wxXmlResource Extends wxObject

	Function _create:wxXmlResource(wxObjectPtr:Byte Ptr)
		Local this:wxXmlResource = New wxXmlResource
		
		this.wxObjectPtr = wxObjectPtr
		
		Return this
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function Get:wxXmlResource()
		Return wxXmlResource._create(bmx_wxxmlresource_get())
	End Function

	Rem
	bbdoc: Initializes handlers for all supported controls/windows.
	End Rem
	Method InitAllHandlers()
		bmx_wxxmlresource_initallhandlers(wxObjectPtr)
		TXMLResourceFactory.InitHandlers()
	End Method
	
	Rem
	bbdoc: Loads resources from XML files that match given filemask.
	End Rem
	Method Load:Int(filemask:String)
		Return bmx_wxxmlresource_load(wxObjectPtr, filemask)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LoadBitmap:wxBitmap(name:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LoadDialog:wxDialog(parent:wxWindow, name:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LoadFrame:wxFrame(parent:wxWindow, name:String)
		If parent Then
			Return wxFrame._find(bmx_wxxmlresource_loadframe(wxObjectPtr, parent.wxObjectPtr, name))
		Else
			Return wxFrame._find(bmx_wxxmlresource_loadframe(wxObjectPtr, Null, name))
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method LoadObject(this:wxObject, parent:wxWindow, name:String, classname:String)
		If parent Then
			this.wxObjectPtr = bmx_wxxmlresource_loadobject(wxObjectPtr, this, parent.wxObjectPtr, name, classname)
		Else
			this.wxObjectPtr = bmx_wxxmlresource_loadobject(wxObjectPtr, this, Null, name, classname)
		End If
	End Method

End Type

Rem
bbdoc: Returns pointer to particular control in dialog created using XML resources.
End Rem
Function XRCCTRL:wxWindow(parent:wxWindow, id:String)
	Return wxWindow._find(bmx_wxxmlresource_xrcctrl(parent.wxObjectPtr, id))
End Function

Rem
bbdoc: Translates string identifier (as used in XML resource, e.g. &ltg;menuitem id="my_menu"&gt;...&ltg;/menuitem&gt;) to widget event id.
End Rem
Function XRCID:Int(name:String)
	Return bmx_wxxmlresource_wrcid(name)
End Function


