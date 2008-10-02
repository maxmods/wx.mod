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
bbdoc: wxDocument
End Rem
Module wx.wxDocument

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
bbdoc: The document class can be used to model an application's file-based data.
about: It is part of the document/view framework supported by wxWidgets, and cooperates with the
wxView, wxDocTemplate and wxDocManager types.
End Rem
Type wxDocument Extends wxEvtHandler

	Rem
	bbdoc: 
	End Rem
	Function CreateDocument:wxDocument()
		Return New wxDocument.create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method create:wxDocument()
		wxObjectPtr = bmx_wxdocument_create(Self)
		OnInit()
	End Method
	
	Rem
	bbdoc: If the view is not already in the list of views, adds the view and calls OnChangedViewList.
	End Rem
	Method AddView:Int(view:wxView)
		Return bmx_wxdocument_addview(wxObjectPtr, view.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Closes the document, by calling OnSaveModified and then (if this returned true) OnCloseDocument.
	about: This does not normally delete the document object: use DeleteAllViews to do this implicitly.
	End Rem
	Method Close:Int()
		Return bmx_wxdocument_close(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Calls wxView::Close and deletes each view.
	about: Deleting the final view will implicitly delete the document itself, because the wxView
	destructor calls RemoveView. This in turns calls wxDocument::OnChangedViewList, whose default
	implemention is to save and delete the document if no views exist.
	End Rem
	Method DeleteAllViews:Int()
		Return bmx_wxdocument_deleteallviews(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a pointer to the command processor associated with this document.
	End Rem
	Method GetCommandProcessor:wxCommandProcessor()
		Return wxCommandProcessor._create(bmx_wxdocument_getcommandprocessor(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the template that created the document.
	End Rem
	Method GetDocumentTemplate:wxDocTemplate()
		Return wxDocTemplate._create(bmx_wxdocument_getdocumenttemplate(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the associated document manager.
	End Rem
	Method GetDocumentManager:wxDocManager()
		Return wxDocManager._create(bmx_wxdocument_getdocumentmanager(wxObjectPtr))
	End Method

	Rem
	bbdoc: Gets the document type name for this document.
	about: The document type name given to the wxDocTemplate constructor, copied to this variable
	when the document is created. If several document templates are created that use the same
	document type, this variable is used in wxDocManager::CreateView to collate a list of
	alternative view types that can be used on this kind of document.
	End Rem
	Method GetDocumentName:String()
		Return bmx_wxdocument_getdocumentname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Intended to return a suitable window for using as a parent for document-related dialog boxes.
	about: By default, uses the frame associated with the first view.
	End Rem
	Method GetDocumentWindow:wxWindow()
		Return wxWindow._find(bmx_wxdocument_getdocumentwindow(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the filename associated with this document, or "" if none is associated.
	End Rem
	Method GetFilename:String()
		Return bmx_wxdocument_getfilename(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: A convenience method to get the first view for a document, because in many cases a document will only have a single view.
	End Rem
	Method GetFirstView:wxView()
		Return wxView._find(bmx_wxdocument_getfirstview(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: The default method uses the title, or if there is no title, uses the filename; or if no filename, the string unnamed. 
	End Rem
	Method GetPrintableName:String()
		Return bmx_wxdocument_getprintablename(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the title for this document.
	about: The document title is used for an associated frame (if any), and is usually constructed
	by the framework from the filename.
	End Rem
	Method GetTitle:String()
		Return bmx_wxdocument_gettitle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the list whose elements are the views on the document.
	End Rem
	Method GetViews:wxView[]()
		' TODO
	End Method
	
	Rem
	bbdoc: Returns true if the document has been modified since the last save, false otherwise.
	about: You may need to override this if your document view maintains its own record of being modified
	(for example if using wxTextWindow to view and edit the document).
	End Rem
	Method IsModified:Int()
		Return bmx_wxdocument_ismodified(wxObjectPtr)
	End Method
	
	Function _IsModified:Int(doc:wxDocument)
		Return doc.IsModified()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method LoadObject:wxInputStream(stream:wxInputStream)
		Return wxInputStream._create(bmx_wxdocument_loadobject(wxObjectPtr, stream.wxStreamPtr))
	End Method
	
	Rem
	bbdoc: Call with true to mark the document as modified since the last save, false otherwise.
	about: You may need to override this if your document view maintains its own record of being modified
	(for example if using wxTextWindow to view and edit the document).
	End Rem
	Method Modify(doModify:Int)
		bmx_wxdocument_modify(wxObjectPtr, doModify)
	End Method
	
	Function _Modify(doc:wxDocument, doModify:Int)
		doc.Modify(doModify)
	End Function

	Rem
	bbdoc: Called when a view is added to or deleted from this document.
	about: The default implementation saves and deletes the document if no views exist (the
	last one has just been removed).
	End Rem
	Method OnChangedViewList()
		bmx_wxdocument_onchangedviewlist(wxObjectPtr)
	End Method
	
	Function _OnChangedViewList(doc:wxDocument)
		doc.OnChangedViewList()
	End Function
	
	Rem
	bbdoc: The default implementation calls DeleteContents (an empty implementation) sets the modified flag to false.
	about: Override this to supply additional behaviour when the document is closed with Close.
	End Rem
	Method OnCloseDocument:Int()
		Return bmx_wxdocument_onclosedocument(wxObjectPtr)
	End Method
	
	Function _OnCloseDocument:Int(doc:wxDocument)
		Return doc.OnCloseDocument()
	End Function
	
	Rem
	bbdoc: Called just after the document object is created to give it a chance to initialize itself.
	about: The default implementation uses the template associated with the document to create
	an initial view. If this method returns false, the document is deleted.
	End Rem
	Method OnCreate:Int(path:String, flags:Int)
		Return bmx_wxdocument_oncreate(wxObjectPtr, path, flags)
	End Method

	Function _OnCreate:Int(doc:wxDocument, path:String, flags:Int)
		Return doc.OnCreate(path, flags)
	End Function
	
	Rem
	bbdoc: Override this method if you want a different (or no) command processor to be created when the document is created.
	about: By default, it returns an instance of wxCommandProcessor.
	End Rem
	Method OnCreateCommandProcessor:wxCommandProcessor()
		Return wxCommandProcessor._find(bmx_wxdocument_oncreatecommandprocessor(wxObjectPtr))
	End Method

	Function _OnCreateCommandProcessor:Byte Ptr(doc:wxDocument)
		Return doc.OnCreateCommandProcessor().wxObjectPtr
	End Function
	
	Rem
	bbdoc: The default implementation calls OnSaveModified and DeleteContents, makes a default title for the document, and notifies the views that the filename (in fact, the title) has changed.
	End Rem
	Method OnNewDocument:Int()
		Return bmx_wxdocument_onnewdocument(wxObjectPtr)
	End Method

	Function _OnNewDocument:Int(doc:wxDocument)
		Return doc.OnNewDocument()
	End Function
	
	Rem
	bbdoc: Constructs an input file stream for the given filename (which must not be empty), and calls LoadObject.
	about: If LoadObject returns true, the document is set to unmodified; otherwise, an error message
	box is displayed. The document's views are notified that the filename has changed, to give windows
	an opportunity to update their titles. All of the document's views are then updated.
	End Rem
	Method OnOpenDocument:Int(filename:String)
		Return bmx_wxdocument_onopendocument(wxObjectPtr, filename)
	End Method

	Function _OnOpenDocument:Int(doc:wxDocument, filename:String)
		Return doc.OnOpenDocument(filename)
	End Function
	
	Rem
	bbdoc: Constructs an output file stream for the given filename (which must not be empty), and calls SaveObject.
	about: If SaveObject returns true, the document is set to unmodified; otherwise, an error message
	box is displayed.
	End Rem
	Method OnSaveDocument:Int(filename:String)
		Return bmx_wxdocument_onsavedocument(wxObjectPtr, filename)
	End Method

	Function _OnSaveDocument:Int(doc:wxDocument, filename:String)
		Return doc.OnSaveDocument(filename)
	End Function
	
	Rem
	bbdoc: If the document has been modified, prompts the user to ask if the changes should be changed.
	about: If the user replies Yes, the Save function is called. If No, the document is marked as
	unmodified and the function succeeds. If Cancel, the function fails.
	End Rem
	Method OnSaveModified:Int()
		Return bmx_wxdocument_onsavemodified(wxObjectPtr)
	End Method

	Function _OnSaveModified:Int(doc:wxDocument)
		Return doc.OnSaveModified()
	End Function
	
	Rem
	bbdoc: Removes the view from the document's list of views, and calls OnChangedViewList.
	End Rem
	Method RemoveView:Int(view:wxView)
		Return bmx_wxdocument_removeview(wxObjectPtr, view.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Saves the document by calling OnSaveDocument if there is an associated filename, or SaveAs if there is no filename.
	End Rem
	Method Save:Int()
		Return bmx_wxdocument_save(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Prompts the user for a file to save to, and then calls OnSaveDocument.
	End Rem
	Method SaveAs:Int()
		Return bmx_wxdocument_saveas(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SaveObject:wxOutputStream(stream:wxOutputStream)
		Return wxOutputStream._create(bmx_wxdocument_saveobject(wxObjectPtr, stream.wxStreamPtr))
	End Method
	
	Rem
	bbdoc: Sets the command processor to be used for this document.
	about: The document will then be responsible for its deletion. Normally you should not call
	 this; override OnCreateCommandProcessor instead.
	End Rem
	Method SetCommandProcessor(processor:wxCommandProcessor)
		bmx_wxdocument_setcommandprocessor(wxObjectPtr, processor.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the document type name for this document. See the comment for documentTypeName.
	End Rem
	Method SetDocumentName(name:String)
		bmx_wxdocument_setdocumentname(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Sets the template that created the document. Should only be called by the framework.
	End Rem
	Method SetDocumentTemplate(templ:wxDocTemplate)
		bmx_wxdocument_setdocumenttemplate(wxObjectPtr, templ.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the filename for this document. Usually called by the framework.
	End Rem
	Method SetFilename(filename:String, notifyViews:Int = False)
		bmx_wxdocument_setfilename(wxObjectPtr, filename, notifyViews)
	End Method
	
	Rem
	bbdoc: Sets the title for this document.
	about: The document title is used for an associated frame (if any), and is usually
	constructed by the framework from the filename.
	End Rem
	Method SetTitle(title:String)
		bmx_wxdocument_settitle(wxObjectPtr, title)
	End Method
	
	Rem
	bbdoc: Updates all views. If sender is non-NULL, does not update this view.
	End Rem
	Method UpdateAllViews(sender:wxView = Null)
		If sender Then
			bmx_wxdocument_updateallviews(wxObjectPtr, sender.wxObjectPtr)
		Else
			bmx_wxdocument_updateallviews(wxObjectPtr, Null)
		End If
	End Method
	
End Type


Type wxView Extends wxEvtHandler

	' soft linking
	Function _create:wxView(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxView = New wxView
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxView(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxView = wxView(wxfind(wxObjectPtr))
			If Not window Then
				Return wxView._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Type wxDocManager Extends wxEvtHandler

	' soft linking
	Function _create:wxDocManager(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxDocManager = New wxDocManager
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxDocManager(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxDocManager = wxDocManager(wxfind(wxObjectPtr))
			If Not window Then
				Return wxDocManager._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Type wxDocTemplate Extends wxObject

	' soft linking
	Function _create:wxDocTemplate(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxDocTemplate = New wxDocTemplate
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxDocTemplate(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxDocTemplate = wxDocTemplate(wxfind(wxObjectPtr))
			If Not window Then
				Return wxDocTemplate._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

