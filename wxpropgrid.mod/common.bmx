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

Import wx.wx
Import wx.wxPanel
Import wx.wxDateTime
Import BRL.Blitz


' headers :-)
?linux
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
Import "../include/*.h"
?win32
Import "../lib/win32/mswu/*.h"
Import "../include/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?

Import "src/include/*.h"

Import "src/advprops.cpp"
Import "src/editors.cpp"
Import "src/extras.cpp"
Import "src/manager.cpp"
Import "src/odcombo.cpp"
Import "src/propgrid.cpp"
Import "src/props.cpp"

Import "glue.cpp"

Extern

	Function bmx_wxpropertygrid_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxpropertycontainermethods_append:Byte Ptr(handle:Byte Ptr, property:Byte Ptr)
	Function bmx_wxpropertygrid_append:Byte Ptr(handle:Byte Ptr, property:Byte Ptr)
	Function bmx_wxpropertygrid_getgrid:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getcaptionbackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getcaptionforegroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getcellbackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getcelldisabledtextcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getcelltextcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getlinecolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getmargincolour:Byte Ptr(handle:Byte Ptr)
	
	Function bmx_wxstringproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:String)

	Function bmx_wxintproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:Int)
	Function bmx_wxuintproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:Int)
	Function bmx_wxdoubleproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:Double)
	Function bmx_wxboolproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:Int)
	Function bmx_wxflagsproperty_create:Byte Ptr(handle:Object, label:String, name:String, labels:String[], values:Int[], value:Int)
	Function bmx_wxfileproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:String)
	Function bmx_wxlongstringproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:String)
	Function bmx_wxdirproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:String)
	Function bmx_wxarraystringproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:String[])
	Function bmx_wxcursorproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:Int)
	Function bmx_wximagefileproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:String)
	Function bmx_wxdateproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:Byte Ptr)

	Function bmx_wxpropertycategory_create:Byte Ptr(handle:Object, label:String, name:String)

	Function bmx_wxfontproperty_create:Byte Ptr(handle:Object, label:String, name:String, font:Byte Ptr)

	Function bmx_wxpropertygrid_setpropertyhelpstring(handle:Byte Ptr, prop:Byte Ptr, helpString:String)
	Function bmx_wxpropertygrid_setpropertyhelpstringbyname(handle:Byte Ptr, name:String, helpString:String)

	Function bmx_wxsystemcolourproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:Byte Ptr)

	Function bmx_wxcolourpropertyvalue_delete(handle:Byte Ptr)
	
	Function bmx_wxpgproparg_delete(handle:Byte Ptr)
	

	Function bmx_wxpropertygriditeratorbase_atend:Int(handle:Byte Ptr)
	Function bmx_wxpropertygriditeratorbase_getproperty:Byte Ptr(handle:Byte Ptr)
	'Function bmx_wxpropertygriditeratorbase_getpropertywithchildren:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygriditeratorbase_nextproperty(handle:Byte Ptr, iterateChildren:Int)
	Function bmx_wxpropertygriditeratorbase_prevproperty(handle:Byte Ptr)
	Function bmx_wxpropertygriditeratorbase_setbaseparent(handle:Byte Ptr, baseParent:Byte Ptr)

	Function bmx_wxpropertygrid_getpropertybackgroundcolour:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertycolour:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertytextcolour:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertybackgroundcolourbyname:Byte Ptr(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertycolourbyname:Byte Ptr(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertytextcolourbyname:Byte Ptr(handle:Byte Ptr, name:String)

	Function bmx_wxpropertygrid_beginaddchildren(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_beginaddchildrenbyname(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_clearpropertyvalue:Int(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_clearpropertyvaluebyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_clearselection:Int(handle:Byte Ptr)
	Function bmx_wxpropertygrid_collapse:Int(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_collapsebyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_deleteproperty(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_deletepropertybyname(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_deletepropertychoice(handle:Byte Ptr, prop:Byte Ptr, index:Int)
	Function bmx_wxpropertygrid_deletepropertychoicebyname(handle:Byte Ptr, name:String, index:Int)
	Function bmx_wxpropertygrid_disableproperty:Int(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_disablepropertybyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_enableproperty:Int(handle:Byte Ptr, prop:Byte Ptr, enable:Int)
	Function bmx_wxpropertygrid_enablepropertybyname:Int(handle:Byte Ptr, name:String, enable:Int)
	Function bmx_wxpropertygrid_endaddchildren(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_endaddchildrenbyname(handle:Byte Ptr, name:String)


	Function bmx_wxpropertygrid_setpropertyattribute(handle:Byte Ptr, prop:Byte Ptr, attrName:String, value:Int, argFlags:Int)
	Function bmx_wxpropertygrid_setpropertyattributebyname(handle:Byte Ptr, name:String, attrName:String, value:Int, argFlags:Int)
	Function bmx_wxpropertygrid_setpropertyattributestring(handle:Byte Ptr, prop:Byte Ptr, attrName:String, value:String, argFlags:Int)
	Function bmx_wxpropertygrid_setpropertyattributestringbyname(handle:Byte Ptr, name:String, attrName:String, value:String, argFlags:Int)

	Function bmx_wxpropertygrid_expand:Int(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_expandbyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getfirst:Byte Ptr(handle:Byte Ptr, flags:Int)
	Function bmx_wxpropertygrid_getnextsibling:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertychoices:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyclassname:String(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyclientdata:Object(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyeditor:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyhelpstring:String(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyimage:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyindex:Int(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertylabel:String(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyname:String(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyparent:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_addpropertychoice(handle:Byte Ptr, prop:Byte Ptr, label:String, value:Int)
	Function bmx_wxpropertygrid_addpropertychoicebyname(handle:Byte Ptr, name:String, label:String, value:Int)
	Function bmx_wxpropertygrid_setpropertymaxlength:Int(handle:Byte Ptr, prop:Byte Ptr, maxLen:Int)
	Function bmx_wxpropertygrid_setpropertymaxlengthbyname:Int(handle:Byte Ptr, name:String, maxLen:Int)
	Function bmx_wxpropertygrid_setpropertychoices(handle:Byte Ptr, prop:Byte Ptr, choices:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertychoicesexclusive(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertychoicesbyname(handle:Byte Ptr, name:String, choices:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertychoicesexclusivebyname(handle:Byte Ptr, name:String)

	Function bmx_wxpropertygrid_getpropertyptr:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyshortclassname:String(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueasarrayint:Int[](handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueasarraystring:String[](handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueasbool:Int(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueasdatetime:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueasdouble:Double(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueasint:Int(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueaslong(handle:Byte Ptr, prop:Byte Ptr, value:Long Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueaspoint(handle:Byte Ptr, prop:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueassize(handle:Byte Ptr, prop:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueasstring:String(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyvaluetype:String(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getselection:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyshortclassnamebyname:String(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertyvalueasarrayintbyname:Int[](handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertyvalueasarraystringbyname:String[](handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertyvalueasboolbyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertyvalueasdatetimebyname:Byte Ptr(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertyvalueasdoublebyname:Double(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertyvalueasintbyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertyvalueaslongbyname(handle:Byte Ptr, name:String, value:Long Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueaspointbyname(handle:Byte Ptr, name:String, x:Int Ptr, y:Int Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueassizebyname(handle:Byte Ptr, name:String, w:Int Ptr, h:Int Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueasstringbyname:String(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertyvaluetypebyname:String(handle:Byte Ptr, name:String)


	Function bmx_wxpropertygrid_ispropertcategory:Int(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_ispropertyenabled:Int(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_ispropertyexpanded:Int(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_ispropertymodified:Int(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_ispropertyshown:Int(handle:Byte Ptr, prop:Byte Ptr)

	Function bmx_wxpgchoices_create:Byte Ptr()
	Function bmx_wxpgchoices_delete(handle:Byte Ptr)
	Function bmx_wxpgchoices_add:Byte Ptr(handle:Byte Ptr, label:String, value:Int)
	Function bmx_wxpgchoices_addentries(handle:Byte Ptr, labels:String[], values:Int[])
	Function bmx_wxpgchoices_addassorted:Byte Ptr(handle:Byte Ptr, label:String, value:Int)
	Function bmx_wxpgchoices_getcount:Int(handle:Byte Ptr)
	Function bmx_wxpgchoices_getlabel:String(handle:Byte Ptr, index:Int)
	Function bmx_wxpgchoices_getlabels:String[](handle:Byte Ptr)
	Function bmx_wxpgchoices_getvalue:Int(handle:Byte Ptr, index:Int)
	Function bmx_wxpgchoices_hasvalue:Int(handle:Byte Ptr, value:Int)
	Function bmx_wxpgchoices_hasvalues:Int(handle:Byte Ptr)
	Function bmx_wxpgchoices_index:Int(handle:Byte Ptr, value:Int)
	Function bmx_wxpgchoices_indexforlabel:Int(handle:Byte Ptr, label:String)
	Function bmx_wxpgchoices_insert:Byte Ptr(handle:Byte Ptr, label:String, index:Int, value:Int)
	Function bmx_wxpgchoices_isok:Int(handle:Byte Ptr)
	Function bmx_wxpgchoices_item:Byte Ptr(handle:Byte Ptr, index:Int)
	Function bmx_wxpgchoices_removeat(handle:Byte Ptr, index:Int, count:Int)
	Function bmx_wxpgchoices_set(handle:Byte Ptr, labels:String[], values:Int[])

	Function bmx_wxpgchoiceentry_getbgcol:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpgchoiceentry_getbitmap:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpgchoiceentry_getfgcol:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpgchoiceentry_gettext:String(handle:Byte Ptr)
	Function bmx_wxpgchoiceentry_setbgcol(handle:Byte Ptr, col:Byte Ptr)
	Function bmx_wxpgchoiceentry_setbitmap(handle:Byte Ptr, bitmap:Byte Ptr)
	Function bmx_wxpgchoiceentry_setfgcol(handle:Byte Ptr, col:Byte Ptr)
	Function bmx_wxpgchoiceentry_settext(handle:Byte Ptr, text:String)
	Function bmx_wxpgchoiceentry_delete(handle:Byte Ptr)
	Function bmx_wxpgchoiceentry_getvalue:Int(handle:Byte Ptr)
	Function bmx_wxpgchoiceentry_hasvalue:Int(handle:Byte Ptr)
	Function bmx_wxpgchoiceentry_setvalue(handle:Byte Ptr, value:Int)

	Function bmx_wxpgproperty_setattributestring(handle:Byte Ptr, name:String, value:String)
	Function bmx_wxpgproperty_setattributeint(handle:Byte Ptr, name:String, value:Int)
	Function bmx_wxpgproperty_setattributedouble(handle:Byte Ptr, name:String, value:Double)
	Function bmx_wxpgproperty_setattributebool(handle:Byte Ptr, name:String, value:Int)

	Function bmx_wxenumproperty_createwitharrays:Byte Ptr(handle:Object, label:String, name:String, labels:String[], values:Int[], value:Int)
	Function bmx_wxenumproperty_createwithchoices:Byte Ptr(handle:Object, label:String, name:String, choices:Byte Ptr, value:Int)

	Function bmx_wxmultichoiceproperty_createwitharrays:Byte Ptr(handle:Object, label:String, name:String, labels:String[], value:Int[])
	Function bmx_wxmultichoiceproperty_createwithchoices:Byte Ptr(handle:Object, label:String, name:String, choices:Byte Ptr, value:Int[])

	Function bmx_wxpropertygrid_geteventtype:Int(evt:Int)

	Function bmx_wxpropertygridevent_getmainparent:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygridevent_getproperty:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygridevent_hasproperty:Int(handle:Byte Ptr)
	Function bmx_wxpropertygridevent_ispropertyenabled:Int(handle:Byte Ptr)
	
	Function bmx_wxpropertygrid_getpropertybysubname:Byte Ptr(handle:Byte Ptr, name:String, subName:String)
	Function bmx_wxpropertygrid_getpropertybyname:Byte Ptr(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertycategory:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_hideproperty:Int(handle:Byte Ptr, prop:Byte Ptr, hide:Int)
	Function bmx_wxpropertygrid_insert:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, index:Int, newproperty:Byte Ptr)
	Function bmx_wxpropertygrid_insertcategory:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr, index:Int, label:String)
	Function bmx_wxpropertygrid_insertpropertychoice(handle:Byte Ptr, prop:Byte Ptr, label:String, index:Int, value:Int)
	Function bmx_wxpropertygrid_ispropertyunspecified:Int(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_limitpropertyediting(handle:Byte Ptr, prop:Byte Ptr, limit:Int)
	Function bmx_wxpropertygrid_replaceproperty:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr, property:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertycell(handle:Byte Ptr, prop:Byte Ptr, column:Int, text:String, bitmap:Byte Ptr, fgCol:Byte Ptr, bgCol:Byte Ptr)
	Function bmx_wxpropertygrid_getnextsiblingbyname:Byte Ptr(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertycategorybyname:Byte Ptr(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertychoicesbyname:Byte Ptr(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertyclassnamebyname:String(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertyhelpstringbyname:String(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertyimagebyname:Byte Ptr(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertyindexbyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertylabelbyname:String(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_getpropertynamebyname:String(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_insertpropertychoicebyname(handle:Byte Ptr, name:String, label:String, index:Int, value:Int)
	Function bmx_wxpropertygrid_ispropertycategorybyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_ispropertyenabledbyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_ispropertyexpandedbyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_ispropertymodifiedbyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_ispropertyshownbyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_ispropertyunspecifiedbyname:Int(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_limitpropertyeditingbyname(handle:Byte Ptr, name:String, limit:Int)
	Function bmx_wxpropertygrid_replacepropertybyname:Byte Ptr(handle:Byte Ptr, name:String, property:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertycellbyname(handle:Byte Ptr, name:String, column:Int, text:String, bitmap:Byte Ptr, fgCol:Byte Ptr, bgCol:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertyimage(handle:Byte Ptr, prop:Byte Ptr, bmp:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertylabel(handle:Byte Ptr, prop:Byte Ptr, label:String)
	Function bmx_wxpropertygrid_setpropertyreadonly(handle:Byte Ptr, prop:Byte Ptr, set:Int)
	Function bmx_wxpropertygrid_setpropertyunspecified(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertyvalueintarray(handle:Byte Ptr, prop:Byte Ptr, value:Int[])
	Function bmx_wxpropertygrid_setpropertyvalueulong(handle:Byte Ptr, prop:Byte Ptr, value:Long)
	Function bmx_wxpropertygrid_setpropertyvaluelong(handle:Byte Ptr, prop:Byte Ptr, value:Long)
	Function bmx_wxpropertygrid_setpropertyvaluesize(handle:Byte Ptr, prop:Byte Ptr, w:Int, h:Int)
	Function bmx_wxpropertygrid_setpropertyvaluepoint(handle:Byte Ptr, prop:Byte Ptr, x:Int, y:Int)
	Function bmx_wxpropertygrid_setpropertyvaluebyteptr(handle:Byte Ptr, prop:Byte Ptr, value:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertyvaluestring(handle:Byte Ptr, prop:Byte Ptr, value:String)
	Function bmx_wxpropertygrid_setpropertyvaluedatetime(handle:Byte Ptr, prop:Byte Ptr, time:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertyvaluestringarray(handle:Byte Ptr, prop:Byte Ptr, value:String[])
	Function bmx_wxpropertygrid_setpropertyvaluebool(handle:Byte Ptr, prop:Byte Ptr, value:Int)
	Function bmx_wxpropertygrid_setpropertyvaluedouble(handle:Byte Ptr, prop:Byte Ptr, value:Double)
	Function bmx_wxpropertygrid_setpropertyvalueint(handle:Byte Ptr, prop:Byte Ptr, value:Int)

	Function bmx_wxpropertygrid_setpropertyreadonlybyname(handle:Byte Ptr, name:String, set:Int)
	Function bmx_wxpropertygrid_setpropertyunspecifiedbyname(handle:Byte Ptr, name:String)
	Function bmx_wxpropertygrid_setpropertyvalueintarraybyname(handle:Byte Ptr, name:String, value:Int[])
	Function bmx_wxpropertygrid_setpropertyvalueulongbyname(handle:Byte Ptr, name:String, value:Long)
	Function bmx_wxpropertygrid_setpropertyvaluelongbyname(handle:Byte Ptr, name:String, value:Long)
	Function bmx_wxpropertygrid_setpropertyvaluesizebyname(handle:Byte Ptr, name:String, w:Int, h:Int)
	Function bmx_wxpropertygrid_setpropertyvaluepointbyname(handle:Byte Ptr, name:String, x:Int, y:Int)
	Function bmx_wxpropertygrid_setpropertyvaluebyteptrbyname(handle:Byte Ptr, name:String, value:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertyvaluestringbyname(handle:Byte Ptr, name:String, value:String)
	Function bmx_wxpropertygrid_setpropertyvaluedatetimebyname(handle:Byte Ptr, name:String, time:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertyvaluestringarraybyname(handle:Byte Ptr, name:String, value:String[])
	Function bmx_wxpropertygrid_setpropertyvalueboolbyname(handle:Byte Ptr, name:String, value:Int)
	Function bmx_wxpropertygrid_setpropertyvaluedoublebyname(handle:Byte Ptr, name:String, value:Double)
	Function bmx_wxpropertygrid_setpropertyvalueintbyname(handle:Byte Ptr, name:String, value:Int)
	Function bmx_wxpropertygrid_setpropertyimagebyname(handle:Byte Ptr, name:String, bmp:Byte Ptr)
	Function bmx_wxpropertygrid_setpropertylabelbyname(handle:Byte Ptr, name:String, newproplabel:String)
	Function bmx_wxpropertygrid_hidepropertybyname:Int(handle:Byte Ptr, name:String, hide:Int)
	Function bmx_wxpropertygrid_insertbyname:Byte Ptr(handle:Byte Ptr, parent:String, index:Int, newproperty:Byte Ptr)
	Function bmx_wxpropertygrid_insertcategorybyname:Byte Ptr(handle:Byte Ptr, name:String, index:Int, label:String)
	Function bmx_wxpropertygrid_clear(handle:Byte Ptr)
	Function bmx_wxpropertygrid_clearmodifiedstatus(handle:Byte Ptr)

	Function bmx_wxpropertygrid_getpropertyvalueascolour:Byte Ptr(handle:Byte Ptr, prop:Byte Ptr)
	Function bmx_wxpropertygrid_getpropertyvalueascolourbyname:Byte Ptr(handle:Byte Ptr, name:String)
	Function bmx_wxcolourproperty_create:Byte Ptr(handle:Object, label:String, name:String, value:Byte Ptr)

End Extern

Const INT_MAX:Int = 2147483647

Const wxPG_LABEL:String = "_LABEL_AS_NAME"

Const wxPG_AUTO_SORT:Int = $00000010

Const wxPG_HIDE_CATEGORIES:Int = $00000020
Const wxPG_ALPHABETIC_MODE:Int = wxPG_HIDE_CATEGORIES | wxPG_AUTO_SORT
Const wxPG_BOLD_MODIFIED:Int = $00000040
Const wxPG_SPLITTER_AUTO_CENTER:Int = $00000080
Const wxPG_TOOLTIPS:Int = $00000100
Const wxPG_HIDE_MARGIN:Int = $00000200
Const wxPG_STATIC_SPLITTER:Int = $00000400
Const wxPG_STATIC_LAYOUT:Int = wxPG_HIDE_MARGIN | wxPG_STATIC_SPLITTER
Const wxPG_LIMITED_EDITING:Int = $00000800
Const wxPG_TOOLBAR:Int = $00001000
Const wxPG_DESCRIPTION:Int = $00002000
Const wxPG_COMPACTOR:Int = $00004000

Const wxPG_EX_INIT_NOCAT:Int = $00001000
Const wxPG_EX_NO_FLAT_TOOLBAR:Int = $00002000
Const wxPG_EX_MODE_BUTTONS:Int = $00008000
Const wxPG_EX_HELP_AS_TOOLTIPS:Int = $00010000
Const wxPG_EX_GREY_LABEL_WHEN_DISABLED:Int = $00040000
Const wxPG_EX_NATIVE_DOUBLE_BUFFERING:Int = $00080000
Const wxPG_EX_PROCESS_EVENTS_IMMEDIATELY:Int = $00100000
Const wxPG_EX_AUTO_UNSPECIFIED_VALUES:Int = $00200000

Const wxPG_DEFAULT_STYLE:Int = 0
Const wxPGMAN_DEFAULT_STYLE:Int = 0
Const wxPG_KEEP_STRUCTURE:Int = $00000010
Const wxPG_RECURSE:Int = $00000020
Const wxPG_RECURSE_STARTS:Int = $00000040
Const wxPG_FORCE:Int = $00000080

Const wxPG_LOW:Int = 1
Const wxPG_HIGH:Int = 2

Const wxPG_FULL_VALUE:Int = $00000001
Const wxPG_REPORT_ERROR:Int = $00000002
Const wxPG_PROPERTY_SPECIFIC:Int = $00000004
Const wxPG_EDITABLE_VALUE:Int = $00000008

Const wxPG_PROP_AGGREGATE:Int = $0400
Const wxPG_PROP_CATEGORY:Int = $2000
Const wxPG_PROP_CHILDREN_ARE_COPIES:Int = $0800
Const wxPG_PROP_CLASS_SPECIFIC_1:Int = $0040
Const wxPG_PROP_CLASS_SPECIFIC_2:Int = $0080
Const wxPG_PROP_COLLAPSED:Int = $0020
Const wxPG_PROP_CUSTOMIMAGE:Int = $0008
Const wxPG_PROP_DENY_COMMON_VALUES:Int = $0100
Const wxPG_PROP_DISABLED:Int = $0002
Const wxPG_PROP_HIDDEN:Int = $0004
Const wxPG_PROP_READONLY:Int = $8000
Const wxPG_PROP_MAX:Int = wxPG_PROP_READONLY
Const wxPG_PROP_MISC_PARENT:Int = $4000
Const wxPG_PROP_MODIFIED:Int = $0001
Const wxPG_PROP_NOEDITOR:Int = $0010
Const wxPG_PROP_PARENTAL_FLAGS:Int = wxPG_PROP_AGGREGATE|wxPG_PROP_CATEGORY|wxPG_PROP_MISC_PARENT
Const wxPG_PROP_PROPERTY:Int = $1000
Const wxPG_PROP_WAS_MODIFIED:Int = $0200


Const wxPG_BOOL_USE_CHECKBOX:String = "UseCheckbox"
Const wxPG_BOOL_USE_DOUBLE_CLICK_CYCLING:String = "UseDClickCycling"
Const wxPG_COLOUR_ALLOW_CUSTOM:String = "AllowCustom"
Const wxPG_CUSTOM_PAINT_CALLBACK:String = "PaintCallback"
Const wxPG_CUSTOM_PRIVATE_CHILDREN:String = "PrivateChildren"
Const wxPG_DATE_FORMAT:String = "DateFormat"
Const wxPG_DATE_PICKER_STYLE:String = "PickerStyle"
Const wxPG_DIR_DIALOG_MESSAGE:String = "DialogMessage"
Const wxPG_FILE_DIALOG_TITLE:String = "DialogTitle"
Const wxPG_FILE_INITIAL_PATH:String = "InitialPath"
Const wxPG_FILE_SHOW_FULL_PATH:String = "ShowFullPath"
Const wxPG_FILE_SHOW_RELATIVE_PATH:String = "ShowRelativePath"
Const wxPG_FILE_WILDCARD:String = "Wildcard"
Const wxPG_FLOAT_PRECISION:String = "Precision"
Const wxPG_STRING_PASSWORD:String = "Password"
Const wxPG_UINT_BASE:String = "Base"
Const wxPG_UINT_PREFIX:String = "Prefix"

Const wxPG_BASE_OCT:Int = 8
Const wxPG_BASE_DEC:Int = 10
Const wxPG_BASE_HEX:Int = 16
Const wxPG_BASE_HEXL:Int = 32

' Valid constants For wxPG_UINT_PREFIX attribute
Const wxPG_PREFIX_NONE:Int = 0
Const wxPG_PREFIX_0x:Int = 1
Const wxPG_PREFIX_DOLLAR_SIGN:Int = 2



Const wxEVT_PG_SELECTED:Int = -4300
Const wxEVT_PG_CHANGING:Int = -4301
Const wxEVT_PG_CHANGED:Int = -4302
Const wxEVT_PG_HIGHLIGHTED:Int = -4303
Const wxEVT_PG_RIGHT_CLICK:Int = -4304
Const wxEVT_PG_PAGE_CHANGED:Int = -4305
Const wxEVT_PG_ITEM_EXPANDED:Int = -4306
Const wxEVT_PG_ITEM_COLLAPSED:Int = -4307
Const wxEVT_PG_DOUBLE_CLICK:Int = -4308


