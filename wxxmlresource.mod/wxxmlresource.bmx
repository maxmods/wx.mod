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
bbdoc: This is the main type for interacting with the XML-based resource system.
about: It holds XML resources from one or more .xml files, binary files or zip archive files.
End Rem
Type wxXmlResource Extends wxObject

	Function _create:wxXmlResource(wxObjectPtr:Byte Ptr)
		Local this:wxXmlResource = New wxXmlResource
		
		this.wxObjectPtr = wxObjectPtr
		
		Return this
	End Function
	
	Rem
	bbdoc: Removes all handlers and deletes them.
	End Rem
	Method ClearHandlers()
		bmx_wxxmlresource_clearhandlers(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the global resources object or creates one if none exists.
	End Rem
	Function Get:wxXmlResource()
		Return wxXmlResource._create(bmx_wxxmlresource_get())
	End Function

	Rem
	bbdoc: Returns flags, which may be a bitlist of wxXRC_USE_LOCALE and wxXRC_NO_SUBCLASSING.
	End Rem
	Method GetFlags:Int()
		Return bmx_wxxmlresource_getflags(wxObjectPtr)
	End Method
	
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
	bbdoc: Loads a bitmap resource from a file.
	End Rem
	Method LoadBitmap:wxBitmap(name:String)
	End Method
	
	Rem
	bbdoc: Loads a dialog.
	End Rem
	Method LoadDialog:wxDialog(parent:wxWindow, name:String)
		If parent Then
			Return wxDialog._find(bmx_wxxmlresource_loaddialog(wxObjectPtr, parent.wxObjectPtr, name))
		Else
			Return wxDialog._find(bmx_wxxmlresource_loaddialog(wxObjectPtr, Null, name))
		End If
	End Method
	
	Rem
	bbdoc: Loads a frame.
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
	Method LoadIcon:wxIcon(name:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LoadMenu:wxMenu(name:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LoadMenuBar:wxMenuBar(parent:wxWindow = Null, name:String)
		If parent Then
			Return wxMenuBar._find(bmx_wxxmlresource_loadmenubar(wxObjectPtr, parent.wxObjectPtr, name))
		Else
			Return wxMenuBar._find(bmx_wxxmlresource_loadmenubar(wxObjectPtr, Null, name))
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

	Rem
	bbdoc: Loads a toolbar.
	End Rem
	Method LoadPanel:wxPanel(parent:wxWindow, name:String)
		If parent Then
			Return wxPanel._find(bmx_wxxmlresource_loadpanel(wxObjectPtr, parent.wxObjectPtr, name))
		Else
			Return wxPanel._find(bmx_wxxmlresource_loadpanel(wxObjectPtr, Null, name))
		End If
	End Method
	
	Rem
	bbdoc: Loads a toolbar.
	End Rem
	Method LoadToolBar:wxToolBar(parent:wxWindow, name:String)
		If parent Then
			Return wxToolBar._find(bmx_wxxmlresource_loadtoolbar(wxObjectPtr, parent.wxObjectPtr, name))
		Else
			Return wxToolBar._find(bmx_wxxmlresource_loadtoolbar(wxObjectPtr, Null, name))
		End If
	End Method
	
	Rem
	bbdoc: Unloads a resource previously loaded by Load().
	returns: True if the resource was successfully unloaded and false if it hasn't been found in the list of loaded resources.
	End Rem
	Method Unload:Int(filename:String)
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


