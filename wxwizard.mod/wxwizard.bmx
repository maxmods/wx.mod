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
bbdoc: wxWizard
End Rem
Module wx.wxWizard

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
bbdoc: wxWizard is the central type for implementing 'wizard-like' dialogs.
about: These dialogs are mostly familiar to Windows users and are nothing other than a sequence of 'pages',
each displayed inside a dialog which has the buttons to navigate to the next (and previous) pages.
<p>
The wizards are typically used to decompose a complex dialog into several simple steps and are mainly
useful to the novice users, hence it is important to keep them as simple as possible.
</p>
<p>
To show a wizard dialog, you must first create an instance of the wxWizard class using either the non-default
constructor or a default one followed by call to the Create function. Then you should add all pages you want
the wizard to show and call RunWizard. Finally, don't forget to call wizard->Destroy(), otherwise your
application will hang on exit due to an undestroyed window.
</p>
End Rem
Type wxWizard Extends wxDialog

	Function _create:wxWizard(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxWizard = New wxWizard
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _xrcNew:wxWizard(wxObjectPtr:Byte Ptr)
		Return wxWizard._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateWizard:wxWizard(parent:wxWindow = Null, id:Int = -1, title:String = "", bitmap:wxBitmap = Null, ..
			x:Int = -1, y:Int = -1, style:Int = wxDEFAULT_DIALOG_STYLE)
		Return New wxWizard.Create(parent, id, title, bitmap, x, y, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxWizard(parent:wxWindow = Null, id:Int = -1, title:String = "", bitmap:wxBitmap = Null, ..
			x:Int = -1, y:Int = -1, style:Int = wxDEFAULT_DIALOG_STYLE)
		If parent Then
			If bitmap Then
				wxObjectPtr = bmx_wxwizard_create(Self, parent.wxObjectPtr, id, title, bitmap.wxObjectPtr, x, y, style)
			Else
				wxObjectPtr = bmx_wxwizard_create(Self, parent.wxObjectPtr, id, title, Null, x, y, style)
			End If
		Else
			If bitmap Then
				wxObjectPtr = bmx_wxwizard_create(Self, Null, id, title, bitmap.wxObjectPtr, x, y, style)
			Else
				wxObjectPtr = bmx_wxwizard_create(Self, Null, id, title, Null, x, y, style)
			End If
		End If
		Return Self
	End Method

	Rem
	bbdoc: Get the current page while the wizard is running.
	about: Null is returned if RunWizard() is not being executed now.
	End Rem
	Method GetCurrentPage:wxWizardPage()
		Local p:Byte Ptr = bmx_wxwizard_getcurrentpage(wxObjectPtr)
		If p Then
			Local page:wxWizardPage = wxWizardPage(wxfind(p))
			If Not page Then
				Return wxWizardPage._create(p)
			End If
			Return page
		End If
	End Method
	
	Rem
	bbdoc: Returns the page area sizer.
	about: The wizard is laid out using sizers and the page area sizer is the place-holder for the pages.
	All pages are resized before being shown to match the wizard page area.
	<p>
	Page area sizer has a minimal size that is the maximum of several values. First, all pages
	(or other objects) added to the sizer. Second, all pages reachable by repeatedly applying
	wxWizardPage::GetNext to any page inserted into the sizer. Third, the minimal size specified using
	SetPageSize and FitToPage. Fourth, the total wizard height may be increased to accommodate the bitmap
	height. Fifth and finally, wizards are never smaller than some built-in minimal size to avoid wizards
	that are too small.
	</p>
	<p>
	The caller can use wxSizer::SetMinSize to enlarge it beyond the minimal size. If wxRESIZE_BORDER was
	passed to constructor, user can resize wizard and consequently the page area (but not make it smaller
	than the minimal size).
	</p>
	<p>
	It is recommended to add the first page to the page area sizer. For simple wizards, this will enlarge
	the wizard to fit the biggest page. For non-linear wizards, the first page of every separate chain
	should be added. Caller-specified size can be accomplished using wxSizer::SetMinSize.
	</p>
	<p>
	Adding pages to the page area sizer affects the default border width around page area that can be
	altered with SetBorder.
	</p>
	End Rem
	Method GetPageAreaSizer:wxSizer()
		Return wxSizer._create(bmx_wxwizard_getpageareasizer(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the size available for the pages.
	End Rem
	Method GetPageSize(w:Int Var, h:Int Var)
		bmx_wxwizard_getpagesize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Return true if this page is not the last one in the wizard.
	about: The base type version implements this by calling page->GetNext but this could be undesirable
	if, for example, the pages are created on demand only.
	End Rem
	Method HasNextPage:Int(page:wxWizardPage)
		Return bmx_wxwizard_hasnextpage(wxObjectPtr, page.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this page is not the last one in the wizard.
	about: The base type version implements this by calling page->GetPrev but this could be undesirable
	if, for example, the pages are created on demand only.
	End Rem
	Method HasPrevPage:Int(page:wxWizardPage)
		Return bmx_wxwizard_hasprevpage(wxObjectPtr, page.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Executes the wizard starting from the given page, returning true if it was successfully finished or false if user cancelled it.
	about: The @firstPage can not be NULL.
	End Rem
	Method RunWizard:Int(firstPage:wxWizardPage)
		Return bmx_wxwizard_runwizard(wxObjectPtr, firstPage.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets width of border around page area.
	about: Default is zero. For backward compatibility, if there are no pages in GetPageAreaSizer,
	the default is 5 pixels.
	<p>
	If there is a five point border around all controls in a page and the border around page area is
	left as zero, a five point white space along all dialog borders will be added to the control border
	in order to space page controls ten points from the dialog border and non-page controls.
	</p>
	End Rem
	Method SetBorder(border:Int)
		bmx_wxwizard_setborder(wxObjectPtr, border)
	End Method
	
End Type

Rem
bbdoc: wxWizardPage is one of the screens in wxWizard: it must know what are the following and preceding pages (which may be NULL for the first/last page).
about: Except for this extra knowledge, wxWizardPage is just a panel, so the controls may be placed directly
on it in the usual way.
<p>
This type allows the programmer to decide the order of pages in the wizard dynamically (during run-time)
and so provides maximal flexibility. Usually, however, the order of pages is known in advance in which case
wxWizardPageSimple class is enough and it is simpler to use.
</p>
<p>
To use this type, you must override GetPrev and GetNext methods (or you may use wxWizardPageSimple instead).
</p>
End Rem
Type wxWizardPage Extends wxPanel

	Rem
	bbdoc: 
	End Rem
	Function CreateWizardPage:wxWizardPage(parent:wxWizard, bitmap:wxBitmap = Null)
		Return New wxWizardPage.CreatePage(parent, bitmap)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method CreatePage:wxWizardPage(parent:wxWizard, bitmap:wxBitmap = Null)
		If bitmap Then
			wxObjectPtr = bmx_wxwizardpage_create(Self, parent.wxObjectPtr, bitmap.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxwizardpage_create(Self, parent.wxObjectPtr, Null)
		End If
		
		OnInit()
		Return Self
	End Method


	Function _create:wxWizardPage(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxWizardPage = New wxWizardPage
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _xrcNew:wxWizardPage(wxObjectPtr:Byte Ptr)
		Return wxWizardPage._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Get the page which should be shown when the user chooses the "Back" button.
	about: If Null is returned, this button will be disabled. The first page of the wizard will usually
	return Null from here, but the others will not.
	End Rem
	Method GetPrev:wxWizardPage()
		Local p:Byte Ptr = bmx_wxwizardpage_getprev(wxObjectPtr)
		If p Then
			Local page:wxWizardPage = wxWizardPage(wxfind(p))
			If Not page Then
				Return wxWizardPage._create(p)
			End If
			Return page
		End If
	End Method
	
	Function _GetPrev:Byte Ptr(obj:Object)
		Local page:wxWizardPage = wxWizardPage(obj).GetPrev()
		If page Then
			Return page.wxObjectPtr
		Else
			Return Null
		End If
	End Function

	Rem
	bbdoc: Get the page which should be shown when the user chooses the "Next" button
	about: If Null is returned, this button will be disabled. The last page of the wizard will usually
	return Null from here, but the others will not.
	End Rem
	Method GetNext:wxWizardPage()
		Local p:Byte Ptr = bmx_wxwizardpage_getnext(wxObjectPtr)
		If p Then
			Local page:wxWizardPage = wxWizardPage(wxfind(p))
			If Not page Then
				Return wxWizardPage._create(p)
			End If
			Return page
		End If
	End Method
	
	Function _GetNext:Byte Ptr(obj:Object)
		Local page:wxWizardPage = wxWizardPage(obj).GetNext()
		If page Then
			Return page.wxObjectPtr
		Else
			Return Null
		End If
	End Function
	
	Rem
	bbdoc: This method is called by wxWizard to get the bitmap to display alongside the page.
	about: If the bitmap was not explicitly set (i.e. if wxNullBitmap is returned), the default bitmap
	for the wizard should be used.
	End Rem
	Method GetBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxwizardpage_getbitmap(wxObjectPtr))
	End Method
	
End Type

Rem
bbdoc: wxWizardPageSimple is the simplest possible wxWizardPage implementation: it just returns the pointers given to its constructor from GetNext() and GetPrev() functions.
about: This makes it very easy to use the objects of this type in the wizards where the pages order is
known statically - on the other hand, if this is not the case you must derive your own class from
wxWizardPage instead.
End Rem
Type wxWizardPageSimple Extends wxWizardPage

	Function _create:wxWizardPageSimple(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxWizardPageSimple = New wxWizardPageSimple
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _xrcNew:wxWizardPageSimple(wxObjectPtr:Byte Ptr)
		Return wxWizardPageSimple._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructor takes the previous and next pages.
	about: They may be modified later by SetPrev() or SetNext().
	End Rem
	Function CreateWizardPageSimple:wxWizardPageSimple(parent:wxWizard = Null, prev:wxWizardPage = Null, ..
			nxt:wxWizardPage, bitmap:wxBitmap = Null)
		Return New wxWizardPageSimple.CreateSimple(parent, prev, nxt, bitmap)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method CreateSimple:wxWizardPageSimple(parent:wxWizard = Null, prev:wxWizardPage = Null, ..
			nxt:wxWizardPage = Null, bitmap:wxBitmap = Null)
		If parent Then
			If prev Then
				If nxt Then
					If bitmap Then
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, parent.wxObjectPtr, prev.wxObjectPtr, nxt.wxObjectPtr, bitmap.wxObjectPtr)
					Else
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, parent.wxObjectPtr, prev.wxObjectPtr, nxt.wxObjectPtr, Null)
					End If
				Else
					If bitmap Then
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, parent.wxObjectPtr, prev.wxObjectPtr, Null, bitmap.wxObjectPtr)
					Else
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, parent.wxObjectPtr, prev.wxObjectPtr, Null, Null)
					End If
				End If
			Else
				If nxt Then
					If bitmap Then
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, parent.wxObjectPtr, Null, nxt.wxObjectPtr, bitmap.wxObjectPtr)
					Else
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, parent.wxObjectPtr, Null, nxt.wxObjectPtr, Null)
					End If
				Else
					If bitmap Then
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, parent.wxObjectPtr, Null, Null, bitmap.wxObjectPtr)
					Else
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, parent.wxObjectPtr, Null, Null, Null)
					End If
				End If
			End If
		Else
			If prev Then
				If nxt Then
					If bitmap Then
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, Null, prev.wxObjectPtr, nxt.wxObjectPtr, bitmap.wxObjectPtr)
					Else
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, Null, prev.wxObjectPtr, nxt.wxObjectPtr, Null)
					End If
				Else
					If bitmap Then
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, Null, prev.wxObjectPtr, Null, bitmap.wxObjectPtr)
					Else
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, Null, prev.wxObjectPtr, Null, Null)
					End If
				End If
			Else
				If nxt Then
					If bitmap Then
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, Null, Null, nxt.wxObjectPtr, bitmap.wxObjectPtr)
					Else
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, Null, Null, nxt.wxObjectPtr, Null)
					End If
				Else
					If bitmap Then
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, Null, Null, Null, bitmap.wxObjectPtr)
					Else
						wxObjectPtr = bmx_wxwizardpagesimple_create(Self, Null, Null, Null, Null)
					End If
				End If
			End If
		End If
		
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: Sets the previous page.
	End Rem
	Method SetPrev(page:wxWizardPage)
		bmx_wxwizardpagesimple_setprev(wxObjectPtr, page.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the next page.
	End Rem
	Method SetNext(page:wxWizardPage)
		bmx_wxwizardpagesimple_setnext(wxObjectPtr, page.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: A convenience function to make the pages follow each other.
	End Rem
	Function Chain(First:wxWizardPageSimple, Second:wxWizardPageSimple)
		bmx_wxwizardpagesimple_chain(First.wxObjectPtr, Second.wxObjectPtr)
	End Function
	
End Type


Rem
bbdoc: wxWizardEvent type represents an event generated by the wizard: this event is first sent to the page itself and, if not processed there, goes up the window hierarchy as usual.
End Rem
Type wxWizardEvent Extends wxNotifyEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxWizardEvent = New wxWizardEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Return the direction in which the page is changing.
	about: For wxEVT_WIZARD_PAGE_CHANGING, return true if we're going forward or false otherwise and for
	wxEVT_WIZARD_PAGE_CHANGED return true if we came from the previous page and false if we returned from
	the next one.
	End Rem
	Method GetDirection:Int()
		Return bmx_wxwizardevent_getdirection(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the wxWizardPage which was active when this event was generated.
	End Rem
	Method GetPage:wxWizardPage()
		Local p:Byte Ptr = bmx_wxwizardevent_getpage(wxEventPtr)
		If p Then
			Local page:wxWizardPage = wxWizardPage(wxfind(p))
			If Not page Then
				Return wxWizardPage._create(p)
			End If
			Return page
		End If
	End Method
	
End Type


Type TWizardEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_WIZARD_PAGE_CHANGED, ..
					wxEVT_WIZARD_PAGE_CHANGING, ..
					wxEVT_WIZARD_CANCEL, ..
					wxEVT_WIZARD_HELP, ..
					wxEVT_WIZARD_FINISHED
				Return wxWizardEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_WIZARD_PAGE_CHANGED, ..
					wxEVT_WIZARD_PAGE_CHANGING, ..
					wxEVT_WIZARD_CANCEL, ..
					wxEVT_WIZARD_HELP, ..
					wxEVT_WIZARD_FINISHED
				Return bmx_wxwizard_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TWizardEventFactory

Type TWizardResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxwizard_addresourcehandler()
	End Method
		
End Type

New TWizardResourceFactory
