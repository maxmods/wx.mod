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

Import BRL.Map
Import BRL.Blitz

Import "consts.bmx"

?linux
'Import "-L../lib/linux/"
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
Import "../include/*.h"

' the wx libs
Import "-lwx_gtk2u_aui-2.8"
Import "-lwx_gtk2u_xrc-2.8"
Import "-lwx_gtk2u_qa-2.8"
Import "-lwx_gtk2u_html-2.8"
Import "-lwx_gtk2u_adv-2.8"
Import "-lwx_gtk2u_core-2.8"
Import "-lwx_baseu_xml-2.8"
Import "-lwx_baseu_net-2.8"
Import "-lwx_baseu-2.8"
Import "-lwx_gtk2u_gl-2.8"
Import "-lwx_gtk2u_richtext-2.8"
Import "-lwxregexu-2.8"

' other libs
Import "-lgdk-x11-2.0"
Import "-latk-1.0"
Import "-lgdk_pixbuf-2.0"
Import "-lm"
Import "-lpango-1.0"
Import "-lgobject-2.0"
Import "-lgmodule-2.0"
Import "-ldl"
Import "-lgthread-2.0"
Import "-lrt"
Import "-lglib-2.0"
Import "-lXinerama"
Import "-lSM"
Import "-ltiff"
Import "-lgtk-x11-2.0"
Import "-lXxf86vm"

?win32
Import "../lib/win32/mswu/*.h"
Import "../include/*.h"

Import "-lwxmsw28u_aui"
Import "-lwxmsw28u_xrc"
Import "-lwxmsw28u_html"
Import "-lwxmsw28u_adv"
Import "-lwxmsw28u_core"
Import "-lwxbase28u_xml"
Import "-lwxbase28u_net"
Import "-lwxbase28u"
Import "-lwxjpeg"
Import "-lwxmsw28u_gl"
Import "-lwxpng"
Import "-lwxzlib"
Import "-lwxmsw28u_media"
Import "-lwxregexu"
Import "-lwxexpat"
Import "-lwxmsw28u_richtext"
Import "-lwxtiff"

Import "-ladvapi32"
Import "-lshell32"
Import "-lkernel32"
Import "-luser32"
Import "-lgdi32"
Import "-lcomdlg32"
Import "-lwinspool"
Import "-lwinmm"
Import "-lcomctl32"
Import "-lole32"
Import "-loleaut32"
Import "-luuid"
Import "-lrpcrt4"
Import "-lwsock32"
Import "-lodbc32"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"

Import "-lwx_macu_aui-2.8"
Import "-lwx_macu_xrc-2.8"
Import "-lwx_macu_qa-2.8"
Import "-lwx_macu_html-2.8"
Import "-lwx_macu_adv-2.8"
Import "-lwx_macu_core-2.8"
Import "-lwx_base_carbonu_xml-2.8"
Import "-lwx_base_carbonu_net-2.8"
Import "-lwx_base_carbonu-2.8"
Import "-lwx_macu_gl-2.8"
Import "-lwx_macu_richtext-2.8"
Import "-lwxtiff-2.8"
Import "-lwxjpeg-2.8"
Import "-lwxpng-2.8"
Import "-lwxregexu-2.8"
Import "-lwxexpat-2.8"

Import "-framework QuickTime"
Import "-framework IOKit"
Import "-framework Carbon"
Import "-framework Cocoa"
Import "-framework System"
Import "-framework WebKit"
Import "-lz"
Import "-liconv"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"

Import "-lwx_macu_aui-2.8"
Import "-lwx_macu_xrc-2.8"
Import "-lwx_macu_qa-2.8"
Import "-lwx_macu_html-2.8"
Import "-lwx_macu_adv-2.8"
Import "-lwx_macu_core-2.8"
Import "-lwx_base_carbonu_xml-2.8"
Import "-lwx_base_carbonu_net-2.8"
Import "-lwx_base_carbonu-2.8"
Import "-lwx_macu_gl-2.8"
Import "-lwx_macu_richtext-2.8"
Import "-lwxtiff-2.8"
Import "-lwxjpeg-2.8"
Import "-lwxpng-2.8"
Import "-lwxregexu-2.8"
Import "-lwxexpat-2.8"

Import "-framework QuickTime"
Import "-framework IOKit"
Import "-framework Carbon"
Import "-framework Cocoa"
Import "-framework System"
Import "-framework WebKit"
Import "-lz"
Import "-liconv"
?


Import "wxglue.cpp"


Extern
	Function wxfind:Object(handle:Byte Ptr)

	Function bmx_app_wxentry:Int()
	Function bmx_wxapp_settopwindow(window:Byte Ptr)
	Function bmx_wxapp_setappname(name:String)
	Function bmx_wxapp_yield:Int(onlyIfNeeded:Int)
	
	Function bmx_wxevthandler_create:Byte Ptr(handle:Object)
	Function bmx_wxevthandler_connectnoid(handle:Byte Ptr, eventType:Int, data:Object)
	Function bmx_wxevthandler_connect(handle:Byte Ptr, id:Int, eventType:Int, data:Object)
	Function bmx_wxevthandler_connectrange(handle:Byte Ptr, id:Int, lastId:Int, eventType:Int, data:Object)
	
	Function bmx_event_geteventobject:Object(evt:Byte Ptr)
	Function bmx_eventtype_value:Int(value:Int)
	Function bmx_wxcommandevent_getstring:String(evt:Byte Ptr)
	Function bmx_wxcommandevent_ischecked:Int(evt:Byte Ptr)
	Function bmx_wxcommandevent_getint:Int(evt:Byte Ptr)
	Function bmx_wxcommandevent_getselection:Int(evt:Byte Ptr)
	Function bmx_wxcommandevent_isselection:Int(evt:Byte Ptr)
	Function bmx_wxcommandevent_getextralong:Int(evt:Byte Ptr)
	Function bmx_wxcommandevent_getclientdata:Object(evt:Byte Ptr)
	Function bmx_wxcommandevent_setclientdata(evt:Byte Ptr, data:Object)
	Function bmx_wxmoveevent_getposition(evt:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxevent_skip(evt:Byte Ptr, skip:Int)
	Function bmx_wxsizeevent_getsize(evt:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxevent_geteventtype:Int(evt:Byte Ptr)
	Function bmx_wxevent_getid:Int(evt:Byte Ptr)
	Function bmx_wxevent_getskipped:Int(evt:Byte Ptr)
	Function bmx_wxevent_gettimestamp:Int(evt:Byte Ptr)
	Function bmx_wxevent_iscommandevent:Int(evt:Byte Ptr)
	Function bmx_wxevent_resumepropagation(evt:Byte Ptr, propagationLevel:Int)
	Function bmx_wxevent_shouldpropagate:Int(evt:Byte Ptr)
	Function bmx_wxevent_stoppropagation:Int(evt:Byte Ptr)
	Function bmx_wxevent_geteventobject:Byte Ptr(evt:Byte Ptr)

	Function bmx_wxupdateeventui_check(evt:Byte Ptr, value:Int)
	Function bmx_wxupdateeventui_enable(evt:Byte Ptr, value:Int)
	Function bmx_wxupdateeventui_show(evt:Byte Ptr, value:Int)
	
	Function bmx_wxnotifyevent_allow(evt:Byte Ptr)
	Function bmx_wxnotifyevent_veto(evt:Byte Ptr)
	Function bmx_wxnotifyevent_isallowed:Int(evt:Byte Ptr)

	Function bmx_wxscrollevent_getorientation:Int(evt:Byte Ptr)
	Function bmx_wxscrollevent_getposition:Int(evt:Byte Ptr)
	
	Function bmx_wxcontextmenuevent_getposition(evt:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxcontextmenuevent_setposition(evt:Byte Ptr, x:Int, y:Int)

	Function bmx_wxkeyevent_altdown:Int(evt:Byte Ptr)
	Function bmx_wxkeyevent_cmddown:Int(evt:Byte Ptr)
	Function bmx_wxkeyevent_controldown:Int(evt:Byte Ptr)
	Function bmx_wxkeyevent_getkeycode:Int(evt:Byte Ptr)
	Function bmx_wxkeyevent_getmodifiers:Int(evt:Byte Ptr)
	Function bmx_wxkeyevent_getposition(evt:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxkeyevent_getrawkeycode:Int(evt:Byte Ptr)
	Function bmx_wxkeyevent_getrawkeyflags:Int(evt:Byte Ptr)
	Function bmx_wxkeyevent_getunicodekey:String(evt:Byte Ptr)
	Function bmx_wxkeyevent_getx:Int(evt:Byte Ptr)
	Function bmx_wxkeyevent_gety:Int(evt:Byte Ptr)
	Function bmx_wxkeyevent_hasmodifiers:Int(evt:Byte Ptr)
	Function bmx_wxkeyevent_metadown:Int(evt:Byte Ptr)
	Function bmx_wxkeyevent_shiftdown:Int(evt:Byte Ptr)
	
	Function bmx_wxcloseevent_canveto:Int(evt:Byte Ptr)
	Function bmx_wxcloseevent_getloggingoff:Int(evt:Byte Ptr)
	Function bmx_wxcloseevent_setcanveto(evt:Byte Ptr, canVeto:Int)
	Function bmx_wxcloseevent_setloggingoff(evt:Byte Ptr, loggingOff:Int)
	Function bmx_wxcloseevent_veto(evt:Byte Ptr, value:Int)

	Function bmx_wxversion_string:String()
	Function bmx_wxmessagebox:Int(message:String, caption:String, style:Int, parent:Byte Ptr, x:Int, y:Int)
	Function bmx_wxgetosdescription:String()
	
	Function bmx_wxcontrol_getlabel:String(handle:Byte Ptr)
	Function bmx_wxcontrol_getlabeltext:String(handle:Byte Ptr)
	Function bmx_wxcontrol_setlabel(handle:Byte Ptr, label:String)
	
	

	Function bmx_wxarraystring_create:Byte Ptr()
	Function bmx_wxarraystring_add:Int(handle:Byte Ptr, text:String, copies:Int)
	Function bmx_wxarraystring_alloc(handle:Byte Ptr, count:Int)
	Function bmx_wxarraystring_delete(handle:Byte Ptr)
	
	Function bmx_wxcolour_create:Byte Ptr(r:Int, g:Int, b:Int, a:Int)
	Function bmx_wxcolour_null:Byte Ptr()
	Function bmx_wxcolour_delete(handle:Byte Ptr)
	Function bmx_wxcolour_isok:Int(handle:Byte Ptr)
	Function bmx_wxcolour_red:Int(handle:Byte Ptr)
	Function bmx_wxcolour_green:Int(handle:Byte Ptr)
	Function bmx_wxcolour_blue:Int(handle:Byte Ptr)
	Function bmx_wxcolour_alpha:Int(handle:Byte Ptr)
	Function bmx_wxcolour_getasstring:String(handle:Byte Ptr, flags:Int)
	Function bmx_wxcolour_createnamedcolour:Byte Ptr(name:String)
	Function bmx_wxcolour_set(handle:Byte Ptr, r:Int, g:Int, b:Int, a:Int)
	Function bmx_wxcolour_setasnamedcolour:Int(handle:Byte Ptr, name:String)
	Function bmx_wxcolour_equals:Int(handle:Byte Ptr, colour:Byte Ptr)
	
	Function bmx_wxstockgdi_colour_black:Byte Ptr()
	Function bmx_wxstockgdi_colour_blue:Byte Ptr()
	Function bmx_wxstockgdi_colour_cyan:Byte Ptr()
	Function bmx_wxstockgdi_colour_green:Byte Ptr()
	Function bmx_wxstockgdi_colour_lightgrey:Byte Ptr()
	Function bmx_wxstockgdi_colour_red:Byte Ptr()
	Function bmx_wxstockgdi_colour_white:Byte Ptr()
	
	Function bmx_wxstockgdi_font_italic:Byte Ptr()
	Function bmx_wxstockgdi_font_normal:Byte Ptr()
	Function bmx_wxstockgdi_font_small:Byte Ptr()
	Function bmx_wxstockgdi_font_swiss:Byte Ptr()
	
	Function bmx_wxstockgdi_pen_blackdashed:Byte Ptr()
	Function bmx_wxstockgdi_pen_black:Byte Ptr()
	Function bmx_wxstockgdi_pen_cyan:Byte Ptr()
	Function bmx_wxstockgdi_pen_green:Byte Ptr()
	Function bmx_wxstockgdi_pen_grey:Byte Ptr()
	Function bmx_wxstockgdi_pen_lightgrey:Byte Ptr()
	Function bmx_wxstockgdi_pen_mediumgrey:Byte Ptr()
	Function bmx_wxstockgdi_pen_red:Byte Ptr()
	Function bmx_wxstockgdi_pen_transparent:Byte Ptr()
	Function bmx_wxstockgdi_pen_white:Byte Ptr()

	Function bmx_wxfont_create:Byte Ptr()
	Function bmx_wxfont_createattr:Byte Ptr(pointSize:Int, family:Int, style:Int, weight:Int, underline:Int, faceName:String, encoding:Int)
	Function bmx_wxfont_delete(handler:Byte Ptr)
	Function bmx_wxfont_getpointsize:Int(handler:Byte Ptr)
	Function bmx_wxfont_setpointsize(handler:Byte Ptr, size:Int)
	Function bmx_wxfont_isfixedwidth:Int(handle:Byte Ptr)
	Function bmx_wxfont_getdefaultencoding:Int()
	Function bmx_wxfont_getfacename:String(handle:Byte Ptr)
	Function bmx_wxfont_getfamily:Int(handle:Byte Ptr)
	Function bmx_wxfont_getfamilystring:String(handle:Byte Ptr)
	Function bmx_wxfont_getnativefontinfodesc:String(handle:Byte Ptr)
	Function bmx_wxfont_getnativefontinfouserdesc:String(handle:Byte Ptr)
	Function bmx_wxfont_getstyle:Int(handle:Byte Ptr)
	Function bmx_wxfont_getunderlined:Int(handle:Byte Ptr)
	Function bmx_wxfont_getweight:Int(handle:Byte Ptr)
	Function bmx_wxfont_isok:Int(handle:Byte Ptr)
	Function bmx_wxfont_getencoding:Int(handle:Byte Ptr)
	Function bmx_wxfont_getstylestring:String(handle:Byte Ptr)
	Function bmx_wxfont_getweightstring:String(handle:Byte Ptr)
	Function bmx_wxfont_setstyle(handle:Byte Ptr, style:Int)
	Function bmx_wxfont_setunderlined(handle:Byte Ptr, underlined:Int)
	Function bmx_wxfont_setweight(handle:Byte Ptr, weight:Int)
	Function bmx_wxfont_setdefaultencoding(encoding:Int)
	Function bmx_wxfont_setfacename:Int(handle:Byte Ptr, name:String)
	Function bmx_wxfont_setfamily(handle:Byte Ptr, family:Int)
	Function bmx_wxfont_setnativefontinfo:Int(handle:Byte Ptr, info:String)
	Function bmx_wxfont_setnativefontinfouserdesc:Int(handle:Byte Ptr, info:String)
	Function bmx_wxfont_setencoding(handle:Byte Ptr, encoding:Int)

	
	Function bmx_wxpaintdc_create:Byte Ptr(window:Byte Ptr)
	Function bmx_wxpaintdc_delete(handle:Byte Ptr)
	
	Function bmx_wxfontmapper_getencoding:Int(n:Int)
	Function bmx_wxfontmapper_getencodingdescription:String(encoding:Int)
	Function bmx_wxfontmapper_getencodingname:String(encoding:Int)
	Function bmx_wxfontmapper_getsupportedencodingcount:Int()

	Function bmx_wxstreambase_getlength(handle:Byte Ptr, value:Long Ptr)
	Function bmx_wxstreambase_getlasterror:Int(handle:Byte Ptr)
	Function bmx_wxstreambase_getsize:Int(handle:Byte Ptr)
	Function bmx_wxstreambase_isok:Int(handle:Byte Ptr)
	Function bmx_wxstreambase_isseekable:Int(handle:Byte Ptr)


	Function bmx_wxacceleratorentry_getcommand:Int(handle:Byte Ptr)
	Function bmx_wxacceleratorentry_getflags:Int(handle:Byte Ptr)
	Function bmx_wxacceleratorentry_getkeycode:Int(handle:Byte Ptr)
	Function bmx_wxacceleratorentry_set(handle:Byte Ptr, flags:Int, keyCode:Int, cmd:Int)
	Function bmx_wxacceleratorentry_delete(handle:Byte Ptr)
	
	Function bmx_wxisalnum:Int(code:Int)
	Function bmx_wxisprint:Int(code:Int)
	Function bmx_wxinitallimagehandlers()
	Function bmx_wxlaunchdefaultbrowser:Int(url:String, flags:Int)

	Function bmx_wxrect_create:Byte Ptr(x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxrect_centrein:Byte Ptr(handle:Byte Ptr, rect:Byte Ptr, dir:Int)
	Function bmx_wxrect_centerin:Byte Ptr(handle:Byte Ptr, rect:Byte Ptr, dir:Int)
	Function bmx_wxrect_contains:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxrect_containsrect:Int(handle:Byte Ptr, rect:Byte Ptr)
	Function bmx_wxrect_deflate(handle:Byte Ptr, dx:Int, dy:Int)
	Function bmx_wxrect_getbottom:Int(handle:Byte Ptr)
	Function bmx_wxrect_getheight:Int(handle:Byte Ptr)
	Function bmx_wxrect_getleft:Int(handle:Byte Ptr)
	Function bmx_wxrect_getposition(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxrect_gettopleft(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxrect_gettopright(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxrect_getbottomleft(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxrect_getbottomright(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxrect_getright:Int(handle:Byte Ptr)
	Function bmx_wxrect_getsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxrect_gettop:Int(handle:Byte Ptr)
	Function bmx_wxrect_getwidth:Int(handle:Byte Ptr)
	Function bmx_wxrect_getx:Int(handle:Byte Ptr)
	Function bmx_wxrect_gety:Int(handle:Byte Ptr)
	Function bmx_wxrect_inflate(handle:Byte Ptr, dx:Int, dy:Int)
	Function bmx_wxrect_intersects:Int(handle:Byte Ptr, rect:Byte Ptr)
	Function bmx_wxrect_isempty:Int(handle:Byte Ptr)
	Function bmx_wxrect_offset(handle:Byte Ptr, dx:Int, dy:Int)
	Function bmx_wxrect_setheight(handle:Byte Ptr, height:Int)
	Function bmx_wxrect_setsize(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxrect_setwidth(handle:Byte Ptr, width:Int)
	Function bmx_wxrect_setx(handle:Byte Ptr, x:Int)
	Function bmx_wxrect_sety(handle:Byte Ptr, y:Int)
	Function bmx_wxrect_union:Byte Ptr(handle:Byte Ptr, rect:Byte Ptr)
	Function bmx_wxrect_delete(handle:Byte Ptr)

	Function bmx_gdi_wxclientdisplayrect(x:Int Ptr, y:Int Ptr, width:Int Ptr, height:Int Ptr)
	Function bmx_gdi_wxgetclientdisplayrect:Byte Ptr()
	Function bmx_gdi_wxcolourdisplay:Int()
	Function bmx_gdi_wxdisplaydepth:Int()
	Function bmx_gdi_wxdisplaysize(width:Int Ptr, height:Int Ptr)
	Function bmx_gdi_wxdisplaysizemm(width:Int Ptr, height:Int Ptr)

	Function bmx_wxgetemailaddress:String()
	Function bmx_wxgetfreememory(mem:Long Ptr)
	Function bmx_wxgetfullhostname:String()
	Function bmx_wxgethomedir:String()
	Function bmx_wxgethostname:String()
	Function bmx_wxgetosversion:Int(major:Int Ptr, minor:Int Ptr)
	Function bmx_wxisplatformlittleendian:Int()
	Function bmx_wxisplatform64bit:Int()
	Function bmx_wxgetuserhome:String(user:String)
	Function bmx_wxgetuserid:String()
	Function bmx_wxgetusername:String()

End Extern

Global wxVERSION_STRING:String = bmx_wxversion_string()



