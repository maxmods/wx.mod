' Copyright (c) 2007-2015 Bruce A Henderson
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
bbdoc: wxSimplebook
End Rem
Module wx.wxSimplebook

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2015 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"


Rem
bbdoc: A control showing exactly one of its several pages.
about: It implements wxBookCtrlBase class interface but doesn't allow the user to change the page being
displayed, unlike all the other book control classes, only the program can do it.
End Rem
Type wxSimplebook Extends wxBookCtrlBase

	Function _create:wxSimpleBook(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSimpleBook = New wxSimpleBook
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxSimpleBook(wxObjectPtr:Byte Ptr)
		Return wxSimpleBook._create(wxObjectPtr)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreateSimplebook:wxSimplebook(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxSimplebook.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxSimplebook(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxsimplebook_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method
	
	Rem
	bbdoc: Set the effects to use for showing and hiding the pages.
	about: This method allows to specify the effects passed to wxWindow::ShowWithEffect()
	and wxWindow::HideWithEffect() respectively when the pages need to be shown or hidden.
	<p>
	By default, no effects are used, but as the pages are only changed by the program and not the user
	himself, it may be useful to use some visual effects to make the changes more noticeable.
	</p>
	End Rem
	Method SetEffects(showEffect:Int, hideEffect:Int)
		bmx_wxsimplebook_seteffects(wxObjectPtr, showEffect, hideEffect)
	End Method
	
	Rem
	bbdoc: Set the same effect to use for both showing and hiding the pages.
	about: This is the same as SetEffects(effect, effect).
	End Rem
	Method SetEffect(effect:Int)
		bmx_wxsimplebook_seteffect(wxObjectPtr, effect)
	End Method
	
	Rem
	bbdoc: Set the effect timeout to use for showing and hiding the pages.
	about: This method allows to configure the timeout arguments passed to wxWindow::ShowWithEffect()
	and wxWindow::HideWithEffect() if a non-default effect is used.
	<p>
	If this method is not called, default, system-dependent timeout is used.
	</p>
	End Rem
	Method SetEffectsTimeouts(showTimeout:Int, hideTimeout:Int)
		bmx_wxsimplebook_seteffectstimeouts(wxObjectPtr, showTimeout, hideTimeout)
	End Method
	
	Rem
	bbdoc: Set the same effect timeout to use for both showing and hiding the pages.
	about: This is the same as SetEffectsTimeouts(timeout, timeout).
	End Rem
	Method SetEffectTimeout(timeout:Int)
		bmx_wxsimplebook_seteffecttimeout(wxObjectPtr, timeout)
	End Method
	
	Rem
	bbdoc: Add a new page and show it immediately.
	about: This is simply a thin wrapper around the base class wxBookCtrlBase::AddPage() method using
	empty label (which is unused by this class anyhow) and selecting the new page immediately.
	End Rem
	Method ShowNewPage(page:wxWindow)
		bmx_wxsimplebook_shownewpage(wxObjectPtr, page.wxObjectPtr)
	End Method

End Type

' TODO : not yet implemented in wxWidgets
'Type TSimplebookResourceFactory Extends TXMLResourceFactory
'
'	Method AddHandler()
'		bmx_wxsimplebook_addresourcehandler()
'	End Method
'		
'End Type
'
'New TSimplebookResourceFactory
