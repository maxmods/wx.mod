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

Import wx.wx
Import wx.wxCommandProcessor
Import wx.wxWindow
Import wx.wxPrintout
Import wx.wxConfig
Import wx.wxFileHistory
Import BRL.Blitz


' headers :-)
?linuxx86
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
?linuxx64
Import "../lib/linuxx64/wx/include/gtk2-unicode-release-static/*.h"
?win32x86
Import "../lib/win32/mswu/*.h"
?win32x64
Import "../lib/win32x64/mswu/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
?macosx64
Import "../lib/macosx64/wx/include/mac-unicode-release-static/*.h"
?raspberrypi
Import "../lib/raspberrypi/wx/include/gtk2-unicode-release-static/*.h"
?
Import "../include/*.h"

Import "glue.cpp"

Extern

	Function bmx_wxdocument_create:Byte Ptr(handle:Object)
	Function bmx_wxdocument_addview:Int(handle:Byte Ptr, view:Byte Ptr)
	Function bmx_wxdocument_close:Int(handle:Byte Ptr)
	Function bmx_wxdocument_deleteallviews:Int(handle:Byte Ptr)
	Function bmx_wxdocument_getcommandprocessor:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocument_getdocumenttemplate:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocument_getdocumentmanager:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocument_getdocumentname:String(handle:Byte Ptr)
	Function bmx_wxdocument_getdocumentwindow:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocument_getfilename:String(handle:Byte Ptr)
	Function bmx_wxdocument_getfirstview:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocument_getprintablename:String(handle:Byte Ptr)
	Function bmx_wxdocument_gettitle:String(handle:Byte Ptr)
	Function bmx_wxdocument_ismodified:Int(handle:Byte Ptr)
?Not linux
	Function bmx_wxdocument_loadobject:Byte Ptr(handle:Byte Ptr, stream:Byte Ptr)
?
	Function bmx_wxdocument_modify(handle:Byte Ptr, doModify:Int)
	Function bmx_wxdocument_onchangedviewlist(handle:Byte Ptr)
	Function bmx_wxdocument_onclosedocument:Int(handle:Byte Ptr)
	Function bmx_wxdocument_oncreate:Int(handle:Byte Ptr, path:String, flags:Int)
	Function bmx_wxdocument_oncreatecommandprocessor:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocument_onnewdocument:Int(handle:Byte Ptr)
	Function bmx_wxdocument_onopendocument:Int(handle:Byte Ptr, filename:String)
	Function bmx_wxdocument_onsavedocument:Int(handle:Byte Ptr, filename:String)
	Function bmx_wxdocument_onsavemodified:Int(handle:Byte Ptr)
	Function bmx_wxdocument_removeview:Int(handle:Byte Ptr, view:Byte Ptr)
	Function bmx_wxdocument_save:Int(handle:Byte Ptr)
	Function bmx_wxdocument_saveas:Int(handle:Byte Ptr)
?Not linux
	Function bmx_wxdocument_saveobject:Byte Ptr(handle:Byte Ptr, stream:Byte Ptr)
?
	Function bmx_wxdocument_setcommandprocessor(handle:Byte Ptr, processor:Byte Ptr)
	Function bmx_wxdocument_setdocumentname(handle:Byte Ptr, name:String)
	Function bmx_wxdocument_setdocumenttemplate(handle:Byte Ptr, templ:Byte Ptr)
	Function bmx_wxdocument_setfilename(handle:Byte Ptr, filename:String, notifyViews:Int)
	Function bmx_wxdocument_settitle(handle:Byte Ptr, title:String)
	Function bmx_wxdocument_updateallviews(handle:Byte Ptr, sender:Byte Ptr)

	Function bmx_wxdoctemplate_create:Byte Ptr(handle:Object, manager:Byte Ptr, desc:String, filter:String, dir:String, ext:String, ..
			docTypeName:String, viewTypeName:String, flags:Int)
	Function bmx_wxdoctemplate_getdefaultextension:String(handle:Byte Ptr)
	Function bmx_wxdoctemplate_getdescription:String(handle:Byte Ptr)
	Function bmx_wxdoctemplate_getdirectory:String(handle:Byte Ptr)
	Function bmx_wxdoctemplate_getdocumentmanager:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdoctemplate_getdocumentname:String(handle:Byte Ptr)
	Function bmx_wxdoctemplate_getfilefilter:String(handle:Byte Ptr)
	Function bmx_wxdoctemplate_getflags:Int(handle:Byte Ptr)
	Function bmx_wxdoctemplate_getviewname:String(handle:Byte Ptr)
	Function bmx_wxdoctemplate_initdocument:Int(handle:Byte Ptr, doc:Byte Ptr, path:String, flags:Int)
	Function bmx_wxdoctemplate_isvisible:Int(handle:Byte Ptr)
	Function bmx_wxdoctemplate_setdefaultextension(handle:Byte Ptr, ext:String)
	Function bmx_wxdoctemplate_setdescription(handle:Byte Ptr, desc:String)
	Function bmx_wxdoctemplate_setdirectory(handle:Byte Ptr, dir:String)
	Function bmx_wxdoctemplate_setfilefilter(handle:Byte Ptr, filter:String)
	Function bmx_wxdoctemplate_setflags(handle:Byte Ptr, flags:Int)

	Function bmx_wxdocmanager_create:Byte Ptr(handle:Object)
	Function bmx_wxdocmanager_activateview(handle:Byte Ptr, doc:Byte Ptr, activate:Int)
	Function bmx_wxdocmanager_adddocument(handle:Byte Ptr, doc:Byte Ptr)
	Function bmx_wxdocmanager_addfiletohistory(handle:Byte Ptr, filename:String)
	Function bmx_wxdocmanager_associatetemplate(handle:Byte Ptr, temp:Byte Ptr)
	Function bmx_wxdocmanager_closedocuments:Int(handle:Byte Ptr, force:Int)
	Function bmx_wxdocmanager_createdocument:Byte Ptr(handle:Byte Ptr, path:String, flags:Int)
	Function bmx_wxdocmanager_createview:Byte Ptr(handle:Byte Ptr, doc:Byte Ptr, flags:Int)
	Function bmx_wxdocmanager_disassociatetemplate(handle:Byte Ptr, temp:Byte Ptr)
	Function bmx_wxdocmanager_filehistoryaddfilestomenu(handle:Byte Ptr)
	Function bmx_wxdocmanager_filehistoryload(handle:Byte Ptr, config:Byte Ptr)
	Function bmx_wxdocmanager_filehistoryremovemenu(handle:Byte Ptr, menu:Byte Ptr)
	Function bmx_wxdocmanager_filehistorysave(handle:Byte Ptr, resourceFile:Byte Ptr)
	Function bmx_wxdocmanager_filehistoryusemenu(handle:Byte Ptr, menu:Byte Ptr)
	Function bmx_wxdocmanager_findtemplateforpath:Byte Ptr(handle:Byte Ptr, path:String)
	Function bmx_wxdocmanager_getcurrentdocument:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocmanager_getcurrentview:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocmanager_getfilehistory:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocmanager_getlastdirectory:String(handle:Byte Ptr)
	Function bmx_wxdocmanager_getmaxdocsopen:Int(handle:Byte Ptr)
	Function bmx_wxdocmanager_gethistoryfilescount:Int(handle:Byte Ptr)
	Function bmx_wxdocmanager_makedefaultname:String(handle:Byte Ptr)
	Function bmx_wxdocmanager_removedocument(handle:Byte Ptr, doc:Byte Ptr)
	Function bmx_wxdocmanager_setlastdirectory(handle:Byte Ptr, dir:String)
	Function bmx_wxdocmanager_setmaxdocsopen(handle:Byte Ptr, num:Int)

	Function bmx_wxview_create:Byte Ptr(handle:Object)
	Function bmx_wxview_activate(handle:Byte Ptr, doActivate:Int)
	Function bmx_wxview_close:Int(handle:Byte Ptr, deleteWindow:Int)
	Function bmx_wxview_getdocument:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxview_getdocumentmanager:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxview_getframe:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxview_getviewname:String(handle:Byte Ptr)
	Function bmx_wxview_onactivateview(handle:Byte Ptr, activate:Int, activeView:Byte Ptr, deactiveView:Byte Ptr)
	Function bmx_wxview_onchangefilename(handle:Byte Ptr)
	Function bmx_wxview_onclose:Int(handle:Byte Ptr, deleteWindow:Int)
	Function bmx_wxview_onclosingdocument(handle:Byte Ptr)
	Function bmx_wxView_oncreate:Int(handle:Byte Ptr, doc:Byte Ptr, flags:Int)
	Function bmx_wxview_oncreateprintout:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxview_ondraw(handle:Byte Ptr, dc:Byte Ptr)
	Function bmx_wxview_onupdate(handle:Byte Ptr, sender:Byte Ptr)
	Function bmx_wxview_setdocument(handle:Byte Ptr, doc:Byte Ptr)
	Function bmx_wxview_setframe(handle:Byte Ptr, frame:Byte Ptr)
	Function bmx_wxview_setviewname(handle:Byte Ptr, name:String)

End Extern

Const wxDOC_SDI:Int = 1
Const wxDOC_MDI:Int = 2
Const wxDOC_NEW:Int = 3
Const wxDOC_SILENT:Int = 4
Const wxDEFAULT_DOCMAN_FLAGS:Int = wxDOC_SDI

Const wxTEMPLATE_VISIBLE:Int = 1
Const wxTEMPLATE_INVISIBLE:Int = 2
Const wxDEFAULT_TEMPLATE_FLAGS:Int = wxTEMPLATE_VISIBLE


