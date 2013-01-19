' Copyright (c) 2007-2013 Bruce A Henderson
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
ModuleInfo "Copyright: (c) 2007-2013 Bruce A Henderson"


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
bbdoc: The document class can be used to model an application's file-based data.
about: It is part of the document/view framework supported by wxWidgets, and cooperates with the
wxView, wxDocTemplate and wxDocManager types.
End Rem
Type wxDocument Extends wxEvtHandler

	' soft linking
	Function _create:wxDocument(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxDocument = New wxDocument
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxDocument(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxDocument = wxDocument(wxfind(wxObjectPtr))
			If Not window Then
				Return wxDocument._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateDocument:wxDocument()
		Return New wxDocument.Create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxDocument()
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
?Not linux
	Rem
	bbdoc: 
	End Rem
	Method LoadObject:wxInputStream(stream:wxInputStream)
		Return wxInputStream._create(bmx_wxdocument_loadobject(wxObjectPtr, stream.wxStreamPtr))
	End Method
?
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
?Not linux
	Rem
	bbdoc: 
	End Rem
	Method SaveObject:wxOutputStream(stream:wxOutputStream)
		Return wxOutputStream._create(bmx_wxdocument_saveobject(wxObjectPtr, stream.wxStreamPtr))
	End Method
?
	
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

Rem
bbdoc: The view type can be used to model the viewing and editing component of an application's file-based data.
about: It is part of the document/view framework supported by wxWidgets, and cooperates with the
wxDocument, wxDocTemplate and wxDocManager types.
End Rem
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
	
	Rem
	bbdoc: Creates a new wxView Object.
	End Rem
	Function CreateView:wxView()
		Return New wxView.Create()
	End Function
	
	Rem
	bbdoc: Creates a new wxView Object.
	about: You should call this method as part of your own implementation's instantiation. For example :
	<pre>
	Local myView:TMyView = New TMyView.Create()
	</pre>
	This method also calls OnInit().
	End Rem
	Method Create:wxView()
		wxObjectPtr = bmx_wxview_create(Self)
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: Call this from your view frame's OnActivate method to tell the framework which view is currently active.
	about: If your windowing system doesn't call OnActivate, you may need to call this method from any place
	where you know the view must be active, and the framework will need to get the current view.
	<p>
	The prepackaged view frame wxDocChildFrame calls wxView::Activate from its OnActivate member.
	</p>
	<p>
	This method calls wxView::OnActivateView.
	</p>
	End Rem
	Method Activate(doActivate:Int)
		bmx_wxview_activate(wxObjectPtr, doActivate)
	End Method
	
	Rem
	bbdoc: Closes the view by calling OnClose.
	about: If @deleteWindow is true, this function should delete the window associated with the view.
	End Rem
	Method Close:Int(deleteWindow:Int = True)
		Return bmx_wxview_close(wxObjectPtr, deleteWindow)
	End Method
	
	Rem
	bbdoc: Returns the document associated with the view.
	End Rem
	Method GetDocument:wxDocument()
		Return wxDocument._find(bmx_wxview_getdocument(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the document manager instance associated with this view.
	End Rem
	Method GetDocumentManager:wxDocManager()
		Return wxDocManager._find(bmx_wxview_getdocumentmanager(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the frame associated with the view (if any).
	about: Note that this 'frame' is not a wxFrame at all in the generic MDI implementation which uses
	the notebook pages instead of the frames and this is why this method returns a wxWindow and
	not a wxFrame.
	End Rem
	Method GetFrame:wxWindow()
		Return wxWindow._find(bmx_wxview_getframe(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the name associated with the view (passed to the wxDocTemplate constructor). Not currently used by the framework.
	End Rem
	Method GetViewName:String()
		Return bmx_wxview_getviewname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Called when a view is activated by means of wxView::Activate.
	about: The default implementation does nothing.
	<p>
	Override this method to provide your own functionality.
	</p>
	End Rem
	Method OnActivateView(activate:Int, activeView:wxView, deactiveView:wxView)
		bmx_wxview_onactivateview(wxObjectPtr, activate, activeView.wxObjectPtr, deactiveView.wxObjectPtr)
	End Method
	
	Function _OnActivateView(view:wxView, activate:Int, activeView:Byte Ptr, deactiveView:Byte Ptr)
		view.OnActivateView(activate, wxView._find(activeView), wxView._find(deactiveView))
	End Function
	
	Rem
	bbdoc: Called when the filename has changed.
	about: The default implementation constructs a suitable title and sets the title of the view frame (if any).
	<p>
	Override this method to provide your own functionality.
	</p>
	End Rem
	Method OnChangeFilename()
		bmx_wxview_onchangefilename(wxObjectPtr)
	End Method
	
	Function _OnChangeFilename(view:wxView)
		view.OnChangeFilename()
	End Function
	
	Rem
	bbdoc: Implements closing behaviour.
	about: The default implementation calls wxDocument::Close to close the associated document. Does
	not delete the view. The application may wish to do some cleaning up operations in this method, if
	a call to wxDocument::Close succeeded. For example, if your views all share the same window, you
	need to disassociate the window from the view and perhaps clear the window. If deleteWindow is true,
	delete the frame associated with the view.
	<p>
	Override this method to provide your own functionality.
	</p>
	End Rem
	Method OnClose:Int(deleteWindow:Int)
		Return bmx_wxview_onclose(wxObjectPtr, deleteWindow)
	End Method
	
	Function _OnClose:Int(view:wxView, deleteWindow:Int)
		Return view.OnClose(deleteWindow)
	End Function
	
	Rem
	bbdoc: Override this to clean up the view when the document is being closed.
	End Rem
	Method OnClosingDocument()
		bmx_wxview_onclosingdocument(wxObjectPtr)
	End Method
	
	Function _OnClosingDocument(view:wxView)
		view.OnClosingDocument()
	End Function
	
	Rem
	bbdoc: wxDocManager or wxDocument creates a wxView via a wxDocTemplate.
	about: Just after the wxDocTemplate creates the wxView, it calls wxView::OnCreate. In its OnCreate
	member function, the wxView can create a wxDocChildFrame or a derived class. This wxDocChildFrame
	provides user interface elements to view and/or edit the contents of the wxDocument.
	<p>
	By default, simply returns true. If the method returns false, the view will be deleted.
	</p>
	<p>
	Override this method to provide your own functionality.
	</p>
	End Rem
	Method OnCreate:Int(doc:wxDocument, flags:Int)
		Return bmx_wxView_oncreate(wxObjectPtr, doc.wxObjectPtr, flags)
	End Method
	
	Function _OnCreate:Int(view:wxView, doc:Byte Ptr, flags:Int)
		Return view.OnCreate(wxDocument._find(doc), flags)
	End Function
	
	Rem
	bbdoc: If the printing framework is enabled in the library, this method returns a wxPrintout object for the purposes of printing.
	about: It should create a new object every time it is called; the framework will delete objects it
	creates.
	<p>
	By default, this function returns an instance of wxDocPrintout, which prints and previews one page by calling wxView::OnDraw.
	</p>
	<p>
	Override to return an instance of a class other than wxDocPrintout.
	</p>
	End Rem
	Method OnCreatePrintout:wxPrintout()
		Return wxPrintout._create(bmx_wxview_oncreateprintout(wxObjectPtr))
	End Method
	
	Function _OnCreatePrintout:Byte Ptr(view:wxView)
		Return View.OnCreatePrintout().wxObjectPtr
	End Function
	
	Rem
	bbdoc: Override this function to render the view on the given device context.
	End Rem
	Method OnDraw(dc:wxDC)
		bmx_wxview_ondraw(wxObjectPtr, dc.wxObjectPtr)
	End Method
	
	Function _OnDraw(view:wxView, dc:Byte Ptr)
		view.OnDraw(wxDC._create(dc))
	End Function
	
	Rem
	bbdoc: Called when the view should be updated.
	about: @sender is a pointer to the view that sent the update request, or NULL if no single view
	requested the update (for instance, when the document is opened).
	<p>
	Override this method to provide your own functionality.
	</p>
	End Rem
	Method OnUpdate(sender:wxView)
		bmx_wxview_onupdate(wxObjectPtr, sender.wxObjectPtr)
	End Method
	
	Function _OnUpdate(view:wxView, sender:Byte Ptr)
		view.OnUpdate(wxView._find(sender))
	End Function
	
	Rem
	bbdoc: Associates the given document with the view. Normally called by the framework.
	End Rem
	Method SetDocument(doc:wxDocument)
		bmx_wxview_setdocument(wxObjectPtr, doc.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the frame associated with this view.
	about: The application should call this if possible, to tell the view about the frame.
	<p>
	See GetFrame for the explanation about the mismatch between the "Frame'' in the method name
	and the type of its parameter.
	</p>
	End Rem
	Method SetFrame(frame:wxWindow)
		bmx_wxview_setframe(wxObjectPtr, frame.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the view type name. Should only be called by the framework.
	End Rem
	Method SetViewName(name:String)
		bmx_wxview_setviewname(wxObjectPtr, name)
	End Method
	
End Type

Rem
bbdoc: The wxDocManager type is part of the document/view framework supported by wxWidgets, and cooperates with the wxView, wxDocument and wxDocTemplate types.
End Rem
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

	Rem
	bbdoc: Creates a new wxDocManager object.
	End Rem
	Function CreateDocManager:wxDocManager()
		Return New wxDocManager.Create()
	End Function
	
	Rem
	bbdoc: Creates a new wxDocManager object.
	End Rem
	Method Create:wxDocManager()
		wxObjectPtr = bmx_wxdocmanager_create(Self)
		OnInit()
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the current view.
	End Rem
	Method ActivateView(doc:wxView, activate:Int = True)
		bmx_wxdocmanager_activateview(wxObjectPtr, doc.wxObjectPtr, activate)
	End Method
	
	Rem
	bbdoc: Adds the document to the list of documents.
	End Rem
	Method AddDocument(doc:wxDocument)
		bmx_wxdocmanager_adddocument(wxObjectPtr, doc.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Adds a file to the file history list, if we have a reference to an appropriate file menu.
	End Rem
	Method AddFileToHistory(filename:String)
		bmx_wxdocmanager_addfiletohistory(wxObjectPtr, filename)
	End Method
	
	Rem
	bbdoc: Adds the template to the document manager's template list.
	End Rem
	Method AssociateTemplate(temp:wxDocTemplate)
		bmx_wxdocmanager_associatetemplate(wxObjectPtr, temp.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Closes all currently opened documents.
	End Rem
	Method CloseDocuments:Int(force:Int = True)
		Return bmx_wxdocmanager_closedocuments(wxObjectPtr, force)
	End Method
	
	Rem
	bbdoc: Creates a new document in a manner determined by the flags parameter.
	about: @flags can be:
	<ul>
	<li>wxDOC_NEW Creates a fresh document.</li>
	<li>wxDOC_SILENT Silently loads the given document file. </li>
	</ul>
	If wxDOC_NEW is present, a new document will be created and returned, possibly after asking the
	user for a template to use if there is more than one document template. If wxDOC_SILENT is present,
	a new document will be created and the given file loaded into it. If neither of these flags is
	present, the user will be presented with a file selector for the file to load, and the template
	to use will be determined by the extension (Windows) or by popping up a template choice list (other
	platforms).
	<p>
	If the maximum number of documents has been reached, this function will delete the oldest currently
	loaded document before creating a new one.
	</p>
	End Rem
	Method CreateDocument:wxDocument(path:String, flags:Int)
		Return wxDocument._find(bmx_wxdocmanager_createdocument(wxObjectPtr, path, flags))
	End Method
	
	Rem
	bbdoc: Creates a new view for the given document.
	about: If more than one view is allowed for the document (by virtue of multiple templates mentioning
	the same document type), a choice of view is presented to the user.
	End Rem
	Method CreateView:wxView(doc:wxDocument, flags:Int)
		Return wxView._find(bmx_wxdocmanager_createview(wxObjectPtr, doc.wxObjectPtr, flags))
	End Method
	
	Rem
	bbdoc: Removes the template from the list of templates.
	End Rem
	Method DisassociateTemplate(temp:wxDocTemplate)
		bmx_wxdocmanager_disassociatetemplate(wxObjectPtr, temp.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Appends the files in the history list, to all menus managed by the file history object.
	End Rem
	Method FileHistoryAddFilesToMenu()
		bmx_wxdocmanager_filehistoryaddfilestomenu(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Loads the file history from a config object.
	End Rem
	Method FileHistoryLoad(config:wxConfigBase)
		bmx_wxdocmanager_filehistoryload(wxObjectPtr, config.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Removes the given menu from the list of menus managed by the file history object.
	End Rem
	Method FileHistoryRemoveMenu(menu:wxMenu)
		bmx_wxdocmanager_filehistoryremovemenu(wxObjectPtr, menu.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Saves the file history into a config object.
	about: This must be called explicitly by the application.
	End Rem
	Method FileHistorySave(resourceFile:wxConfigBase)
		bmx_wxdocmanager_filehistorysave(wxObjectPtr, resourceFile.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Use this menu for appending recently-visited document filenames, for convenient access.
	about: Calling this method with a valid menu enables the history list functionality.
	<p>
	Note that you can add multiple menus using this method, to be managed by the file history object.
	</p>
	End Rem
	Method FileHistoryUseMenu(menu:wxMenu)
		bmx_wxdocmanager_filehistoryusemenu(wxObjectPtr, menu.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Given a path, try to find template that matches the extension.
	about: This is only an approximate method of finding a template for creating a document.
	End Rem
	Method FindTemplateForPath:wxDocTemplate(path:String)
		Return wxDocTemplate._find(bmx_wxdocmanager_findtemplateforpath(wxObjectPtr, path))
	End Method
	
	Rem
	bbdoc: Returns the document associated with the currently active view (if any).
	End Rem
	Method GetCurrentDocument:wxDocument()
		Return wxDocument._find(bmx_wxdocmanager_getcurrentdocument(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the currently active view 
	End Rem
	Method GetCurrentView:wxView()
		Return wxView._find(bmx_wxdocmanager_getcurrentview(wxObjectPtr))
	End Method
	
	Method GetDocuments:wxDocument[]()
		' TODO
	End Method
	
	Rem
	bbdoc: Returns the file history.
	End Rem
	Method GetFileHistory:wxFileHistory()
		Return wxFileHistory._find(bmx_wxdocmanager_getfilehistory(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the directory last selected by the user when opening a file. Initially empty.
	End Rem
	Method GetLastDirectory:String()
		Return bmx_wxdocmanager_getlastdirectory(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of documents that can be open simultaneously.
	End Rem
	Method GetMaxDocsOpen:Int()
		Return bmx_wxdocmanager_getmaxdocsopen(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns the number of files currently stored in the file history.
	End Rem
	Method GetHistoryFilesCount:Int()
		Return bmx_wxdocmanager_gethistoryfilescount(wxObjectPtr)
	End Method
	
	Method GetTemplates:wxDocTemplate[]()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MakeDefaultName:String()
		Return bmx_wxdocmanager_makedefaultname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Removes the document from the list of documents.
	End Rem
	Method RemoveDocument(doc:wxDocument)
		bmx_wxdocmanager_removedocument(wxObjectPtr, doc.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the directory to be displayed to the user when opening a file. Initially this is empty.
	End Rem
	Method SetLastDirectory(dir:String)
		bmx_wxdocmanager_setlastdirectory(wxObjectPtr, dir)
	End Method
	
	Rem
	bbdoc: Sets the maximum number of documents that can be open at a time.
	about: By default, this is 10,000. If you set it to 1, existing documents will be saved and deleted
	when the user tries to open or create a new one (similar to the behaviour of Windows Write, for
	example). Allowing multiple documents gives behaviour more akin to MS Word and other Multiple
	Document Interface applications.
	End Rem
	Method SetMaxDocsOpen(num:Int)
		bmx_wxdocmanager_setmaxdocsopen(wxObjectPtr, num)
	End Method
	
End Type

Rem
bbdoc: The wxDocTemplate type is used to model the relationship between a document type and a view type.
End Rem
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

	Rem
	bbdoc: Creates a new wxDocTemplate object.
	End Rem
	Function CreateDocTemplate:wxDocTemplate(manager:wxDocManager, desc:String, filter:String, dir:String, ..
			ext:String, docTypeName:String, viewTypeName:String, flags:Int = wxDEFAULT_TEMPLATE_FLAGS)
		Return New wxDocTemplate.Create(manager, desc, filter, dir, ext, docTypeName, viewTypeName, flags)
	End Function
	
	Rem
	bbdoc: Creates a new wxDocTemplate object.
	End Rem
	Method Create:wxDocTemplate(manager:wxDocManager, desc:String, filter:String, dir:String, ..
			ext:String, docTypeName:String, viewTypeName:String, flags:Int = wxDEFAULT_TEMPLATE_FLAGS)
		wxObjectPtr = bmx_wxdoctemplate_create(Self, manager.wxObjectPtr, desc, filter, dir, ext, ..
			docTypeName, viewTypeName, flags)
		OnInit()
		Return Self
	End Method
	
	Rem
	bbdoc: Called during template creation.
	about: Override this method to provide your own initialization.
	End Rem
	Method OnInit()
	End Method
	
	Rem
	bbdoc: Creates a new instance of the associated document type.
	about: You will need to override this method to return an appropriate document instance.
	End Rem
	Method CreateDocument:wxDocument(path:String, flags:Int = 0)
		Local doc:wxDocument = New wxDocument.Create()
		doc.SetFilename(path)
		Return doc
	End Method
	
	Function _CreateDocument:Byte Ptr(templ:wxDocTemplate, path:String, flags:Int = 0)
		Return templ.CreateDocument(path, flags).wxObjectPtr
	End Function
	
	Rem
	bbdoc: Creates a new instance of the associated view type.
	about: You will need to override this method to return an appropriate view instance.
	End Rem
	Method CreateView:wxView(doc:wxDocument, flags:Int = 0)
		Local view:wxView = New wxView.Create()
		view.SetDocument(doc)
		Return view
	End Method
	
	Function _CreateView:Byte Ptr(templ:wxDocTemplate, doc:Byte Ptr, flags:Int)
		Return templ.CreateView(wxDocument._find(doc), flags).wxObjectPtr
	End Function
	
	Rem
	bbdoc: Returns the default file extension for the document data, as passed to the document template constructor.
	End Rem
	Method GetDefaultExtension:String()
		Return bmx_wxdoctemplate_getdefaultextension(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the text description of this template, as passed to the document template constructor.
	End Rem
	Method GetDescription:String()
		Return bmx_wxdoctemplate_getdescription(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the default directory, as passed to the document template constructor.
	End Rem
	Method GetDirectory:String()
		Return bmx_wxdoctemplate_getdirectory(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a pointer to the document manager instance for which this template was created.
	End Rem
	Method GetDocumentManager:wxDocManager()
		Return wxDocManager._find(bmx_wxdoctemplate_getdocumentmanager(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the document type name, as passed to the document template constructor.
	End Rem
	Method GetDocumentName:String()
		Return bmx_wxdoctemplate_getdocumentname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the file filter, as passed to the document template constructor.
	End Rem
	Method GetFileFilter:String()
		Return bmx_wxdoctemplate_getfilefilter(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the flags, as passed to the document template constructor.
	End Rem
	Method GetFlags:Int()
		Return bmx_wxdoctemplate_getflags(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the view type name, as passed to the document template constructor.
	End Rem
	Method GetViewName:String()
		Return bmx_wxdoctemplate_getviewname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Initialises the document, calling wxDocument::OnCreate.
	about: This is called from wxDocTemplate::CreateDocument.
	<p>
	Override this method to add your own functionality.
	</p>
	End Rem
	Method InitDocument:Int(doc:wxDocument, path:String, flags:Int = 0)
		Return bmx_wxdoctemplate_initdocument(wxObjectPtr, doc.wxObjectPtr, path, flags)
	End Method
	
	Function _InitDocument:Int(templ:wxDocTemplate, doc:Byte Ptr, path:String, flags:Int)
		Return templ.InitDocument(wxDocument._find(doc), path, flags)
	End Function
	
	Rem
	bbdoc: Returns true if the document template can be shown in user dialogs, false otherwise.
	End Rem
	Method IsVisible:Int()
		Return bmx_wxdoctemplate_isvisible(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the default file extension.
	End Rem
	Method SetDefaultExtension(ext:String)
		bmx_wxdoctemplate_setdefaultextension(wxObjectPtr, ext)
	End Method
	
	Rem
	bbdoc: Sets the template description.
	End Rem
	Method SetDescription(desc:String)
		bmx_wxdoctemplate_setdescription(wxObjectPtr, desc)
	End Method
	
	Rem
	bbdoc: Sets the default directory.
	End Rem
	Method SetDirectory(dir:String)
		bmx_wxdoctemplate_setdirectory(wxObjectPtr, dir)
	End Method
	
	Rem
	bbdoc: Sets the file filter.
	End Rem
	Method SetFileFilter(filter:String)
		bmx_wxdoctemplate_setfilefilter(wxObjectPtr, filter)
	End Method
	
	Rem
	bbdoc: Sets the internal document template flags.
	End Rem
	Method SetFlags(flags:Int)
		bmx_wxdoctemplate_setflags(wxObjectPtr, flags)
	End Method
	
End Type


