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

Import wx.wx
Import wx.wxControl
Import wx.wxScrollBar
Import wx.wxDC
Import wx.wxBitmap
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

'Import "include/*.h"

?linux
Import "-lwx_gtk2u_stc-2.9"
Import "-lwxscintilla-2.9"
?win32
Import "-lwxmsw29u_stc"
Import "-lwxscintilla"
?macosx86
Import "-lwx_osx_cocoau_stc-2.9"
Import "-lwxscintilla-2.9"
?

' scintilla source
' Headers
Import "src/scintilla/src/*.h"
Import "src/scintilla/include/*.h"
Import "src/scintilla/lexlib/*.h"
Rem
'?win32
'Import "src/scintilla/win32/*.h"
'?macos
'Import "src/scintilla/macosx/*.h"
'?linux
'Import "src/scintilla/gtk/*.h"
'?
' the code
Import "src/scintilla/src/AutoComplete.cxx"
Import "src/scintilla/src/CallTip.cxx"
Import "src/scintilla/src/CellBuffer.cxx"
Import "src/scintilla/src/LineMarker.cxx"
Import "src/scintilla/src/CharClassify.cxx"
Import "src/scintilla/src/PositionCache.cxx"
Import "src/scintilla/src/ContractionState.cxx"
Import "src/scintilla/src/PropSet.cxx"
Import "src/scintilla/src/Decoration.cxx"
Import "src/scintilla/src/RESearch.cxx"
Import "src/scintilla/src/DocumentAccessor.cxx"
Import "src/scintilla/src/RunStyles.cxx"
Import "src/scintilla/src/Document.cxx"
Import "src/scintilla/src/ScintillaBase.cxx"
Import "src/scintilla/src/Editor.cxx"
Import "src/scintilla/src/StyleContext.cxx"
Import "src/scintilla/src/ExternalLexer.cxx"
Import "src/scintilla/src/Style.cxx"
Import "src/scintilla/src/Indicator.cxx"
Import "src/scintilla/src/UniConversion.cxx"
Import "src/scintilla/src/KeyMap.cxx"
Import "src/scintilla/src/ViewStyle.cxx"
Import "src/scintilla/src/KeyWords.cxx"
Import "src/scintilla/src/WindowAccessor.cxx"
Import "src/scintilla/src/XPM.cxx"

' wx source
Import "src/PlatWX.cpp"
Import "src/ScintillaWX.cpp"
Import "src/wxscintilla.cpp"

' lexers
Import "LexMax.cxx"

Import "src/scintilla/src/LexSQL.cxx"
Import "src/scintilla/src/LexPython.cxx"
Import "src/scintilla/src/LexCPP.cxx"
Import "src/scintilla/src/LexHTML.cxx"
Import "src/scintilla/src/LexAPDL.cxx"
Import "src/scintilla/src/LexAU3.cxx"
Import "src/scintilla/src/LexAVE.cxx"
Import "src/scintilla/src/LexAda.cxx"
Import "src/scintilla/src/LexAsm.cxx"
Import "src/scintilla/src/LexAsn1.cxx"
Import "src/scintilla/src/LexBaan.cxx"
Import "src/scintilla/src/LexBash.cxx"
Import "src/scintilla/src/LexBullant.cxx"
Import "src/scintilla/src/LexCLW.cxx"
Import "src/scintilla/src/LexCSS.cxx"
Import "src/scintilla/src/LexCaml.cxx"
Import "src/scintilla/src/LexCmake.cxx"
Import "src/scintilla/src/LexConf.cxx"
Import "src/scintilla/src/LexCrontab.cxx"
Import "src/scintilla/src/LexCsound.cxx"
Import "src/scintilla/src/LexD.cxx"
Import "src/scintilla/src/LexEScript.cxx"
Import "src/scintilla/src/LexEiffel.cxx"
Import "src/scintilla/src/LexErlang.cxx"
Import "src/scintilla/src/LexFlagship.cxx"
Import "src/scintilla/src/LexForth.cxx"
Import "src/scintilla/src/LexFortran.cxx"
Import "src/scintilla/src/LexGAP.cxx"
Import "src/scintilla/src/LexGui4Cli.cxx"
Import "src/scintilla/src/LexHaskell.cxx"
Import "src/scintilla/src/LexInno.cxx"
Import "src/scintilla/src/LexKix.cxx"
Import "src/scintilla/src/LexLisp.cxx"
Import "src/scintilla/src/LexLout.cxx"
Import "src/scintilla/src/LexLua.cxx"
Import "src/scintilla/src/LexMMIXAL.cxx"
Import "src/scintilla/src/LexMPT.cxx"
Import "src/scintilla/src/LexMSSQL.cxx"
Import "src/scintilla/src/LexMatlab.cxx"
Import "src/scintilla/src/LexMPT.cxx"
Import "src/scintilla/src/LexMetapost.cxx"
Import "src/scintilla/src/LexNsis.cxx"
Import "src/scintilla/src/LexOpal.cxx"
Import "src/scintilla/src/LexOthers.cxx"
Import "src/scintilla/src/LexPB.cxx"
Import "src/scintilla/src/LexPLM.cxx"
Import "src/scintilla/src/LexPOV.cxx"
Import "src/scintilla/src/LexPS.cxx"
Import "src/scintilla/src/LexPascal.cxx"
Import "src/scintilla/src/LexPerl.cxx"
Import "src/scintilla/src/LexProgress.cxx"
Import "src/scintilla/src/LexRebol.cxx"
Import "src/scintilla/src/LexRuby.cxx"
Import "src/scintilla/src/LexScriptol.cxx"
Import "src/scintilla/src/LexSmalltalk.cxx"
Import "src/scintilla/src/LexSpecman.cxx"
Import "src/scintilla/src/LexSpice.cxx"
Import "src/scintilla/src/LexTADS3.cxx"
Import "src/scintilla/src/LexTCL.cxx"
Import "src/scintilla/src/LexTeX.cxx"
Import "src/scintilla/src/LexVB.cxx"
Import "src/scintilla/src/LexVHDL.cxx"
Import "src/scintilla/src/LexVerilog.cxx"
Import "src/scintilla/src/LexYAML.cxx"
End Rem

Import "LexMax.cxx"

Import "glue.cpp"

Import "consts.bmx"

Extern
	Function bmx_init_scintilla_modules()
	Function bmx_wxscintilla_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)

	Function bmx_wxscintilla_getcurrentline:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_stylesetspec(handle:Byte Ptr, style:Int, spec:String)
	Function bmx_wxscintilla_stylesetfontfont(handle:Byte Ptr, style:Int, font:Byte Ptr)
	Function bmx_wxscintilla_stylesetfontattr(handle:Byte Ptr, style:Int, size:Int, faceName:String, bold:Int, italic:Int, underline:Int, encoding:Int)
	Function bmx_wxscintilla_stylesetfontencoding(handle:Byte Ptr, style:Int, encoding:Int)
	Function bmx_wxscintilla_cmdkeyexecute(handle:Byte Ptr, cmd:Int)
	Function bmx_wxscintilla_setmargins(handle:Byte Ptr, leftMargin:Int, rightMargin:Int)
	Function bmx_wxscintilla_getselection(handle:Byte Ptr, startPos:Int Ptr, endPos:Int Ptr)
	Function bmx_wxscintilla_pointfromposition(handle:Byte Ptr, pos:Int, x:Int Ptr, y:Int Ptr)
	Function bmx_wxscintilla_scrolltoline(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_scrolltocolumn(handle:Byte Ptr, column:Int)
	Function bmx_wxscintilla_setvscrollbar(handle:Byte Ptr, bar:Byte Ptr)
	Function bmx_wxscintilla_sethscrollbar(handle:Byte Ptr, bar:Byte Ptr)
	Function bmx_wxscintilla_getlastkeydownprocessed:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setlastkeydownprocessed(handle:Byte Ptr, val:Int)
	Function bmx_wxscintilla_savefile:Int(handle:Byte Ptr, filename:String)
	Function bmx_wxscintilla_loadfile:Int(handle:Byte Ptr, filename:String)
	Function bmx_wxscintilla_setuseantialiasing(handle:Byte Ptr, useAA:Int)
	Function bmx_wxscintilla_getuseantialiasing:Int(handle:Byte Ptr)

	' //++Autogenerated
	Function bmx_wxscintilla_addtext(handle:Byte Ptr, text:String)
	Function bmx_wxscintilla_inserttext(handle:Byte Ptr, pos:Int, text:String)
	Function bmx_wxscintilla_clearall(handle:Byte Ptr)
	Function bmx_wxscintilla_deleterange(handle:Byte Ptr, pos:Int, deleteLength:Int)
	Function bmx_wxscintilla_cleardocumentstyle(handle:Byte Ptr)
	Function bmx_wxscintilla_getlength:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_getcharat:Int(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_getcurrentpos:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_getanchor:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_getstyleat:Int(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_redo(handle:Byte Ptr)
	Function bmx_wxscintilla_setundocollection(handle:Byte Ptr, collectUndo:Int)
	Function bmx_wxscintilla_selectall(handle:Byte Ptr)
	Function bmx_wxscintilla_setsavepoint(handle:Byte Ptr)
	Function bmx_wxscintilla_canredo:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_markerlinefromhandle:Int(handle:Byte Ptr, handle_:Int)
	Function bmx_wxscintilla_markerdeletehandle(handle:Byte Ptr, handle_:Int)
	Function bmx_wxscintilla_getundocollection:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_getviewwhitespace:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setviewwhitespace(handle:Byte Ptr, viewWS:Int)
	Function bmx_wxscintilla_positionfrompoint:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxscintilla_positionfrompointclose:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxscintilla_gotoline(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_gotopos(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_setanchor(handle:Byte Ptr, posAnchor:Int)
	Function bmx_wxscintilla_getcurline:String(handle:Byte Ptr, index:Int Ptr)
	Function bmx_wxscintilla_getendstyled:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_converteols(handle:Byte Ptr, eolMode:Int)
	Function bmx_wxscintilla_geteolmode:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_seteolmode(handle:Byte Ptr, eolMode:Int)
	Function bmx_wxscintilla_startstyling(handle:Byte Ptr, pos:Int, mask:Int)
	Function bmx_wxscintilla_setstyling(handle:Byte Ptr, length:Int, style:Int)
	Function bmx_wxscintilla_getbuffereddraw:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setbuffereddraw(handle:Byte Ptr, buffered:Int)
	Function bmx_wxscintilla_settabwidth(handle:Byte Ptr, tabWidth:Int)
	Function bmx_wxscintilla_gettabwidth:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setcodepage(handle:Byte Ptr, codePage:Int)
	Function bmx_wxscintilla_markerdefine(handle:Byte Ptr, markerNumber:Int, markerSymbol:Int)
	Function bmx_wxscintilla_markersetforeground(handle:Byte Ptr, markerNumber:Int, fore:Byte Ptr)
	Function bmx_wxscintilla_markersetbackground(handle:Byte Ptr, markerNumber:Int, back:Byte Ptr)
	Function bmx_wxscintilla_markersetbackgroundselected(handle:Byte Ptr, markerNumber:Int, back:Byte Ptr)
	Function bmx_wxscintilla_markerenablehighlight(handle:Byte Ptr, enabled:Int)
	Function bmx_wxscintilla_markeradd:Int(handle:Byte Ptr, line:Int, markerNumber:Int)
	Function bmx_wxscintilla_markerdelete(handle:Byte Ptr, line:Int, markerNumber:Int)
	Function bmx_wxscintilla_markerdeleteall(handle:Byte Ptr, markerNumber:Int)
	Function bmx_wxscintilla_markerget:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_markernext:Int(handle:Byte Ptr, lineStart:Int, markerMask:Int)
	Function bmx_wxscintilla_markerprevious:Int(handle:Byte Ptr, lineStart:Int, markerMask:Int)
	Function bmx_wxscintilla_markerdefinebitmap(handle:Byte Ptr, markerNumber:Int, bitmap:Byte Ptr)
	Function bmx_wxscintilla_markeraddset(handle:Byte Ptr, line:Int, set:Int)
	Function bmx_wxscintilla_markersetalpha(handle:Byte Ptr, markerNumber:Int, alpha:Int)
	Function bmx_wxscintilla_setmargintype(handle:Byte Ptr, margin:Int, marginType:Int)
	Function bmx_wxscintilla_getmargintype:Int(handle:Byte Ptr, margin:Int)
	Function bmx_wxscintilla_setmarginwidth(handle:Byte Ptr, margin:Int, pixelWidth:Int)
	Function bmx_wxscintilla_getmarginwidth:Int(handle:Byte Ptr, margin:Int)
	Function bmx_wxscintilla_setmarginmask(handle:Byte Ptr, margin:Int, mask:Int)
	Function bmx_wxscintilla_getmarginmask:Int(handle:Byte Ptr, margin:Int)
	Function bmx_wxscintilla_setmarginsensitive(handle:Byte Ptr, margin:Int, sensitive:Int)
	Function bmx_wxscintilla_getmarginsensitive:Int(handle:Byte Ptr, margin:Int)
	Function bmx_wxscintilla_setmargincursor(handle:Byte Ptr, margin:Int, cursor:Int)
	Function bmx_wxscintilla_getmargincursor:Int(handle:Byte Ptr, margin:Int)
	Function bmx_wxscintilla_styleclearall(handle:Byte Ptr)
	Function bmx_wxscintilla_stylesetforeground(handle:Byte Ptr, style:Int, fore:Byte Ptr)
	Function bmx_wxscintilla_stylesetbackground(handle:Byte Ptr, style:Int, back:Byte Ptr)
	Function bmx_wxscintilla_stylesetbold(handle:Byte Ptr, style:Int, bold:Int)
	Function bmx_wxscintilla_stylesetitalic(handle:Byte Ptr, style:Int, italic:Int)
	Function bmx_wxscintilla_stylesetsize(handle:Byte Ptr, style:Int, sizePoints:Int)
	Function bmx_wxscintilla_stylesetfacename(handle:Byte Ptr, style:Int, FontName:String)
	Function bmx_wxscintilla_styleseteolfilled(handle:Byte Ptr, style:Int, filled:Int)
	Function bmx_wxscintilla_styleresetdefault(handle:Byte Ptr)
	Function bmx_wxscintilla_stylesetunderline(handle:Byte Ptr, style:Int, underline:Int)
	Function bmx_wxscintilla_stylegetforeground:Byte Ptr(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylegetbackground:Byte Ptr(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylegetbold:Int(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylegetitalic:Int(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylegetsize:Int(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylegetfacename:String(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylegeteolfilled:Int(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylegetunderline:Int(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylegetcase:Int(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylegetvisible:Int(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylegetchangeable:Int(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylegethotspot:Int(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylesetcase(handle:Byte Ptr, style:Int, caseForce:Int)
	Function bmx_wxscintilla_stylesetsizefractional(handle:Byte Ptr, style:Int, caseForce:Int)
	Function bmx_wxscintilla_stylegetsizefractional:Int(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylesetweight(handle:Byte Ptr, style:Int, weight:Int)
	Function bmx_wxscintilla_stylegetweight:Int(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_stylesetcharacterset(handle:Byte Ptr, style:Int, characterSet:Int)
	Function bmx_wxscintilla_stylesethotspot(handle:Byte Ptr, style:Int, hotspot:Int)
	Function bmx_wxscintilla_setselforeground(handle:Byte Ptr, useSetting:Int, fore:Byte Ptr)
	Function bmx_wxscintilla_setselbackground(handle:Byte Ptr, useSetting:Int, back:Byte Ptr)
	Function bmx_wxscintilla_getselalpha:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setselalpha(handle:Byte Ptr, alpha:Int)
	Function bmx_wxscintilla_setcaretforeground(handle:Byte Ptr, fore:Byte Ptr)
	Function bmx_wxscintilla_cmdkeyclearall(handle:Byte Ptr)
	Function bmx_wxscintilla_stylesetvisible(handle:Byte Ptr, style:Int, visible:Int)
	Function bmx_wxscintilla_getcaretperiod:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setcaretperiod(handle:Byte Ptr, periodMilliseconds:Int)
	Function bmx_wxscintilla_setwordchars(handle:Byte Ptr, characters:String)
	Function bmx_wxscintilla_getwordchars:String(handle:Byte Ptr)
	Function bmx_wxscintilla_beginundoaction(handle:Byte Ptr)
	Function bmx_wxscintilla_endundoaction(handle:Byte Ptr)
	Function bmx_wxscintilla_indicatorsetstyle(handle:Byte Ptr, indic:Int, style:Int)
	Function bmx_wxscintilla_indicatorgetstyle:Int(handle:Byte Ptr, indic:Int)
	Function bmx_wxscintilla_indicatorsetforeground(handle:Byte Ptr, indic:Int, fore:Byte Ptr)
	Function bmx_wxscintilla_indicatorgetforeground:Byte Ptr(handle:Byte Ptr, indic:Int)
	Function bmx_wxscintilla_setwhitespaceforeground(handle:Byte Ptr, useSetting:Int, fore:Byte Ptr)
	Function bmx_wxscintilla_setwhitespacebackground(handle:Byte Ptr, useSetting:Int, back:Byte Ptr)
	Function bmx_wxscintilla_setwhitespacesize(handle:Byte Ptr, size:Int)
	Function bmx_wxscintilla_getwhitespacesize:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setstylebits(handle:Byte Ptr, bits:Int)
	Function bmx_wxscintilla_getstylebits:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setlinestate(handle:Byte Ptr, line:Int, state:Int)
	Function bmx_wxscintilla_getlinestate:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_getmaxlinestate:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_getcaretlinevisible:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setcaretlinevisible(handle:Byte Ptr, show:Int)
	Function bmx_wxscintilla_getcaretlinebackground:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxscintilla_setcaretlinebackground(handle:Byte Ptr, back:Byte Ptr)
	Function bmx_wxscintilla_stylesetchangeable(handle:Byte Ptr, style:Int, changeable:Int)
	Function bmx_wxscintilla_autocompshow(handle:Byte Ptr, lenEntered:Int, itemList:String)
	Function bmx_wxscintilla_autocompcancel(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompactive:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompposstart:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompcomplete(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompstops(handle:Byte Ptr, characterSet:String)
	Function bmx_wxscintilla_autocompsetseparator(handle:Byte Ptr, separatorCharacter:Int)
	Function bmx_wxscintilla_autocompgetseparator:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompselect(handle:Byte Ptr, text:String)
	Function bmx_wxscintilla_autocompsetcancelatstart(handle:Byte Ptr, cancel:Int)
	Function bmx_wxscintilla_autocompgetcancelatstart:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompsetfillups(handle:Byte Ptr, characterSet:String)
	Function bmx_wxscintilla_autocompsetchoosesingle(handle:Byte Ptr, chooseSingle:Int)
	Function bmx_wxscintilla_autocompgetchoosesingle:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompsetignorecase(handle:Byte Ptr, ignoreCase:Int)
	Function bmx_wxscintilla_autocompgetignorecase:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_userlistshow(handle:Byte Ptr, listType:Int, itemList:String)
	Function bmx_wxscintilla_autocompsetautohide(handle:Byte Ptr, autoHide:Int)
	Function bmx_wxscintilla_autocompgetautohide:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompsetdroprestofword(handle:Byte Ptr, dropRestOfWord:Int)
	Function bmx_wxscintilla_autocompgetdroprestofword:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_registerimage(handle:Byte Ptr, type_:Int, xpmData:String)
	Function bmx_wxscintilla_clearregisteredimages(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompgettypeseparator:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompsettypeseparator(handle:Byte Ptr, separatorCharacter:Int)
	Function bmx_wxscintilla_autocompsetmaxwidth(handle:Byte Ptr, characterCount:Int)
	Function bmx_wxscintilla_autocompgetmaxwidth:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompsetmaxheight(handle:Byte Ptr, rowCount:Int)
	Function bmx_wxscintilla_autocompgetmaxheight:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setindent(handle:Byte Ptr, indentSize:Int)
	Function bmx_wxscintilla_getindent:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setusetabs(handle:Byte Ptr, useTabs:Int)
	Function bmx_wxscintilla_getusetabs:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setlineindentation(handle:Byte Ptr, line:Int, indentSize:Int)
	Function bmx_wxscintilla_getlineindentation:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_getlineindentposition:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_getcolumn:Int(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_countcharacters:Int(handle:Byte Ptr, startPos:Int, endPos:Int)
	Function bmx_wxscintilla_setusehorizontalscrollbar(handle:Byte Ptr, show:Int)
	Function bmx_wxscintilla_getusehorizontalscrollbar:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setindentationguides(handle:Byte Ptr, indentView:Int)
	Function bmx_wxscintilla_getindentationguides:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_sethighlightguide(handle:Byte Ptr, column:Int)
	Function bmx_wxscintilla_gethighlightguide:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_getlineendposition:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_getcodepage:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_getcaretforeground:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxscintilla_getreadonly:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setcurrentpos(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_setselectionstart(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_getselectionstart:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setselectionend(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_getselectionend:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setemptyselection(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_setprintmagnification(handle:Byte Ptr, magnification:Int)
	Function bmx_wxscintilla_getprintmagnification:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setprintcolourmode(handle:Byte Ptr, Mode:Int)
	Function bmx_wxscintilla_getprintcolourmode:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_findtext:Int(handle:Byte Ptr, minPos:Int, maxPos:Int, text:String, flags:Int)
	Function bmx_wxscintilla_formatrange:Int(handle:Byte Ptr, doDraw:Int, startPos:Int, endPos:Int, draw:Byte Ptr, target:Byte Ptr, renderRect:Byte Ptr, pageRect:Byte Ptr)
	Function bmx_wxscintilla_getfirstvisibleline:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_getline:String(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_getlinecount:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setmarginleft(handle:Byte Ptr, pixelWidth:Int)
	Function bmx_wxscintilla_getmarginleft:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setmarginright(handle:Byte Ptr, pixelWidth:Int)
	Function bmx_wxscintilla_getmarginright:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_getmodify:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setselection(handle:Byte Ptr, startPos:Int, endPos:Int)
	Function bmx_wxscintilla_getselectedtext:String(handle:Byte Ptr)
	Function bmx_wxscintilla_gettextrange:String(handle:Byte Ptr, startPos:Int, endPos:Int)
	Function bmx_wxscintilla_hideselection(handle:Byte Ptr, normal:Int)
	Function bmx_wxscintilla_linefromposition:Int(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_positionfromline:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_linescroll(handle:Byte Ptr, columns:Int, lines:Int)
	Function bmx_wxscintilla_ensurecaretvisible(handle:Byte Ptr)
	Function bmx_wxscintilla_replaceselection(handle:Byte Ptr, text:String)
	Function bmx_wxscintilla_setreadonly(handle:Byte Ptr, readOnly:Int)
	Function bmx_wxscintilla_canpaste:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_canundo:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_emptyundobuffer(handle:Byte Ptr)
	Function bmx_wxscintilla_undo(handle:Byte Ptr)
	Function bmx_wxscintilla_cut(handle:Byte Ptr)
	Function bmx_wxscintilla_copy(handle:Byte Ptr)
	Function bmx_wxscintilla_paste(handle:Byte Ptr)
	Function bmx_wxscintilla_clear(handle:Byte Ptr)
	Function bmx_wxscintilla_settext(handle:Byte Ptr, text:String)
	Function bmx_wxscintilla_gettext:String(handle:Byte Ptr)
	Function bmx_wxscintilla_gettextlength:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setovertype(handle:Byte Ptr, overtype:Int)
	Function bmx_wxscintilla_getovertype:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setcaretwidth(handle:Byte Ptr, pixelWidth:Int)
	Function bmx_wxscintilla_getcaretwidth:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_settargetstart(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_gettargetstart:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_settargetend(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_gettargetend:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_replacetarget:Int(handle:Byte Ptr, text:String)
	Function bmx_wxscintilla_replacetargetre:Int(handle:Byte Ptr, text:String)
	Function bmx_wxscintilla_searchintarget:Int(handle:Byte Ptr, text:String)
	Function bmx_wxscintilla_setsearchflags(handle:Byte Ptr, flags:Int)
	Function bmx_wxscintilla_getsearchflags:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_calltipshow(handle:Byte Ptr, pos:Int, definition:String)
	Function bmx_wxscintilla_calltipcancel(handle:Byte Ptr)
	Function bmx_wxscintilla_calltipactive:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_calltipposatstart:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_calltipsethighlight(handle:Byte Ptr, startPos:Int, endPos:Int)
	Function bmx_wxscintilla_calltipsetbackground(handle:Byte Ptr, back:Byte Ptr)
	Function bmx_wxscintilla_calltipsetforeground(handle:Byte Ptr, fore:Byte Ptr)
	Function bmx_wxscintilla_calltipsetforegroundhighlight(handle:Byte Ptr, fore:Byte Ptr)
	Function bmx_wxscintilla_calltipusestyle(handle:Byte Ptr, tabSize:Int)
	Function bmx_wxscintilla_calltipsetposition(handle:Byte Ptr, above:Int)
	Function bmx_wxscintilla_visiblefromdocline:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_doclinefromvisible:Int(handle:Byte Ptr, lineDisplay:Int)
	Function bmx_wxscintilla_wrapcount:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_setfoldlevel(handle:Byte Ptr, line:Int, level:Int)
	Function bmx_wxscintilla_getfoldlevel:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_getlastchild:Int(handle:Byte Ptr, line:Int, level:Int)
	Function bmx_wxscintilla_getfoldparent:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_showlines(handle:Byte Ptr, lineStart:Int, lineEnd:Int)
	Function bmx_wxscintilla_hidelines(handle:Byte Ptr, lineStart:Int, lineEnd:Int)
	Function bmx_wxscintilla_getlinevisible:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_getalllinesvisible:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setfoldexpanded(handle:Byte Ptr, line:Int, expanded:Int)
	Function bmx_wxscintilla_getfoldexpanded:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_togglefold(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_ensurevisible(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_setfoldflags(handle:Byte Ptr, flags:Int)
	Function bmx_wxscintilla_ensurevisibleenforcepolicy(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_settabindents(handle:Byte Ptr, tabIndents:Int)
	Function bmx_wxscintilla_gettabindents:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setbackspaceunindents(handle:Byte Ptr, bsUnIndents:Int)
	Function bmx_wxscintilla_getbackspaceunindents:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setmousedwelltime(handle:Byte Ptr, periodMilliseconds:Int)
	Function bmx_wxscintilla_getmousedwelltime:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_wordstartposition:Int(handle:Byte Ptr, pos:Int, onlyWordCharacters:Int)
	Function bmx_wxscintilla_wordendposition:Int(handle:Byte Ptr, pos:Int, onlyWordCharacters:Int)
	Function bmx_wxscintilla_setwrapmode(handle:Byte Ptr, Mode:Int)
	Function bmx_wxscintilla_getwrapmode:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setwrapvisualflags(handle:Byte Ptr, wrapVisualFlags:Int)
	Function bmx_wxscintilla_getwrapvisualflags:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setwrapvisualflagslocation(handle:Byte Ptr, wrapVisualFlagsLocation:Int)
	Function bmx_wxscintilla_getwrapvisualflagslocation:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setwrapstartindent(handle:Byte Ptr, indent:Int)
	Function bmx_wxscintilla_getwrapstartindent:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setwrapindentmode(handle:Byte Ptr, Mode:Int)
	Function bmx_wxscintilla_getwrapindentmode:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setlayoutcache(handle:Byte Ptr, Mode:Int)
	Function bmx_wxscintilla_getlayoutcache:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setscrollwidth(handle:Byte Ptr, pixelWidth:Int)
	Function bmx_wxscintilla_getscrollwidth:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setscrollwidthtracking(handle:Byte Ptr, tracking:Int)
	Function bmx_wxscintilla_getscrollwidthtracking:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_textwidth:Int(handle:Byte Ptr, style:Int, text:String)
	Function bmx_wxscintilla_setendatlastline(handle:Byte Ptr, endAtLastLine:Int)
	Function bmx_wxscintilla_getendatlastline:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_textheight:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_setuseverticalscrollbar(handle:Byte Ptr, show:Int)
	Function bmx_wxscintilla_getuseverticalscrollbar:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_appendtext(handle:Byte Ptr, text:String)
	Function bmx_wxscintilla_gettwophasedraw:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_settwophasedraw(handle:Byte Ptr, twoPhase:Int)
	Function bmx_wxscintilla_setfirstvisibleline(handle:Byte Ptr, lineDisplay:Int)
	Function bmx_wxscintilla_setmultipaste(handle:Byte Ptr, multiPaste:Int)
	Function bmx_wxscintilla_getmultipaste:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_gettag:String(handle:Byte Ptr, tagNumber:Int)
	Function bmx_wxscintilla_targetfromselection(handle:Byte Ptr)
	Function bmx_wxscintilla_linesjoin(handle:Byte Ptr)
	Function bmx_wxscintilla_linessplit(handle:Byte Ptr, pixelWidth:Int)
	Function bmx_wxscintilla_setfoldmargincolour(handle:Byte Ptr, useSetting:Int, back:Byte Ptr)
	Function bmx_wxscintilla_setfoldmarginhicolour(handle:Byte Ptr, useSetting:Int, fore:Byte Ptr)
	Function bmx_wxscintilla_linedown(handle:Byte Ptr)
	Function bmx_wxscintilla_linedownextend(handle:Byte Ptr)
	Function bmx_wxscintilla_lineup(handle:Byte Ptr)
	Function bmx_wxscintilla_lineupextend(handle:Byte Ptr)
	Function bmx_wxscintilla_charleft(handle:Byte Ptr)
	Function bmx_wxscintilla_charleftextend(handle:Byte Ptr)
	Function bmx_wxscintilla_charright(handle:Byte Ptr)
	Function bmx_wxscintilla_charrightextend(handle:Byte Ptr)
	Function bmx_wxscintilla_wordleft(handle:Byte Ptr)
	Function bmx_wxscintilla_wordleftextend(handle:Byte Ptr)
	Function bmx_wxscintilla_wordright(handle:Byte Ptr)
	Function bmx_wxscintilla_wordrightextend(handle:Byte Ptr)
	Function bmx_wxscintilla_home(handle:Byte Ptr)
	Function bmx_wxscintilla_homeextend(handle:Byte Ptr)
	Function bmx_wxscintilla_lineend(handle:Byte Ptr)
	Function bmx_wxscintilla_lineendextend(handle:Byte Ptr)
	Function bmx_wxscintilla_documentstart(handle:Byte Ptr)
	Function bmx_wxscintilla_documentstartextend(handle:Byte Ptr)
	Function bmx_wxscintilla_documentend(handle:Byte Ptr)
	Function bmx_wxscintilla_documentendextend(handle:Byte Ptr)
	Function bmx_wxscintilla_pageup(handle:Byte Ptr)
	Function bmx_wxscintilla_pageupextend(handle:Byte Ptr)
	Function bmx_wxscintilla_pagedown(handle:Byte Ptr)
	Function bmx_wxscintilla_pagedownextend(handle:Byte Ptr)
	Function bmx_wxscintilla_edittoggleovertype(handle:Byte Ptr)
	Function bmx_wxscintilla_cancel(handle:Byte Ptr)
	Function bmx_wxscintilla_deleteback(handle:Byte Ptr)
	Function bmx_wxscintilla_tab(handle:Byte Ptr)
	Function bmx_wxscintilla_backtab(handle:Byte Ptr)
	Function bmx_wxscintilla_newline(handle:Byte Ptr)
	Function bmx_wxscintilla_formfeed(handle:Byte Ptr)
	Function bmx_wxscintilla_vchome(handle:Byte Ptr)
	Function bmx_wxscintilla_vchomeextend(handle:Byte Ptr)
	Function bmx_wxscintilla_zoomin(handle:Byte Ptr)
	Function bmx_wxscintilla_zoomout(handle:Byte Ptr)
	Function bmx_wxscintilla_delwordleft(handle:Byte Ptr)
	Function bmx_wxscintilla_delwordright(handle:Byte Ptr)
	Function bmx_wxscintilla_delwordrightend(handle:Byte Ptr)
	Function bmx_wxscintilla_linecut(handle:Byte Ptr)
	Function bmx_wxscintilla_linedelete(handle:Byte Ptr)
	Function bmx_wxscintilla_linetranspose(handle:Byte Ptr)
	Function bmx_wxscintilla_lineduplicate(handle:Byte Ptr)
	Function bmx_wxscintilla_lowercase(handle:Byte Ptr)
	Function bmx_wxscintilla_uppercase(handle:Byte Ptr)
	Function bmx_wxscintilla_linescrolldown(handle:Byte Ptr)
	Function bmx_wxscintilla_linescrollup(handle:Byte Ptr)
	Function bmx_wxscintilla_deletebacknotline(handle:Byte Ptr)
	Function bmx_wxscintilla_homedisplay(handle:Byte Ptr)
	Function bmx_wxscintilla_homedisplayextend(handle:Byte Ptr)
	Function bmx_wxscintilla_lineenddisplay(handle:Byte Ptr)
	Function bmx_wxscintilla_lineenddisplayextend(handle:Byte Ptr)
	Function bmx_wxscintilla_homewrap(handle:Byte Ptr)
	Function bmx_wxscintilla_homewrapextend(handle:Byte Ptr)
	Function bmx_wxscintilla_lineendwrap(handle:Byte Ptr)
	Function bmx_wxscintilla_lineendwrapextend(handle:Byte Ptr)
	Function bmx_wxscintilla_vchomewrap(handle:Byte Ptr)
	Function bmx_wxscintilla_vchomewrapextend(handle:Byte Ptr)
	Function bmx_wxscintilla_linecopy(handle:Byte Ptr)
	Function bmx_wxscintilla_movecaretinsideview(handle:Byte Ptr)
	Function bmx_wxscintilla_linelength:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_bracehighlight(handle:Byte Ptr, pos1:Int, pos2:Int)
	Function bmx_wxscintilla_bracehighlightindicator(handle:Byte Ptr, useBraceHighlightIndicator:Int, indicator:Int)
	Function bmx_wxscintilla_bracebadlight(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_bracebadlightindicator(handle:Byte Ptr, useBraceBadLightIndicator:Int, indicator:Int)
	Function bmx_wxscintilla_bracematch:Int(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_getvieweol:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setvieweol(handle:Byte Ptr, visible:Int)
	Function bmx_wxscintilla_getdocpointer:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxscintilla_setdocpointer(handle:Byte Ptr, docPointer:Byte Ptr)
	Function bmx_wxscintilla_setmodeventmask(handle:Byte Ptr, mask:Int)
	Function bmx_wxscintilla_getedgecolumn:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setedgecolumn(handle:Byte Ptr, column:Int)
	Function bmx_wxscintilla_getedgemode:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setedgemode(handle:Byte Ptr, Mode:Int)
	Function bmx_wxscintilla_getedgecolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxscintilla_setedgecolour(handle:Byte Ptr, edgeColour:Byte Ptr)
	Function bmx_wxscintilla_searchanchor(handle:Byte Ptr)
	Function bmx_wxscintilla_searchnext:Int(handle:Byte Ptr, flags:Int, text:String)
	Function bmx_wxscintilla_searchprev:Int(handle:Byte Ptr, flags:Int, text:String)
	Function bmx_wxscintilla_linesonscreen:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_usepopup(handle:Byte Ptr, allowPopUp:Int)
	Function bmx_wxscintilla_selectionisrectangle:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setzoom(handle:Byte Ptr, zoom:Int)
	Function bmx_wxscintilla_getzoom:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_createdocument:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxscintilla_addrefdocument(handle:Byte Ptr, docPointer:Byte Ptr)
	Function bmx_wxscintilla_releasedocument(handle:Byte Ptr, docPointer:Byte Ptr)
	Function bmx_wxscintilla_getmodeventmask:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setstcfocus(handle:Byte Ptr, focus:Int)
	Function bmx_wxscintilla_getstcfocus:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setstatus(handle:Byte Ptr, statusCode:Int)
	Function bmx_wxscintilla_getstatus:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setmousedowncaptures(handle:Byte Ptr, captures:Int)
	Function bmx_wxscintilla_getmousedowncaptures:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setcontrolcharsymbol(handle:Byte Ptr, symbol:Int)
	Function bmx_wxscintilla_getcontrolcharsymbol:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_wordpartleft(handle:Byte Ptr)
	Function bmx_wxscintilla_wordpartleftextend(handle:Byte Ptr)
	Function bmx_wxscintilla_wordpartright(handle:Byte Ptr)
	Function bmx_wxscintilla_wordpartrightextend(handle:Byte Ptr)
	Function bmx_wxscintilla_setvisiblepolicy(handle:Byte Ptr, visiblePolicy:Int, visibleSlop:Int)
	Function bmx_wxscintilla_dellineleft(handle:Byte Ptr)
	Function bmx_wxscintilla_dellineright(handle:Byte Ptr)
	Function bmx_wxscintilla_setxoffset(handle:Byte Ptr, newOffset:Int)
	Function bmx_wxscintilla_getxoffset:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_choosecaretx(handle:Byte Ptr)
	Function bmx_wxscintilla_setxcaretpolicy(handle:Byte Ptr, caretPolicy:Int, caretSlop:Int)
	Function bmx_wxscintilla_setycaretpolicy(handle:Byte Ptr, caretPolicy:Int, caretSlop:Int)
	Function bmx_wxscintilla_setprintwrapmode(handle:Byte Ptr, Mode:Int)
	Function bmx_wxscintilla_getprintwrapmode:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_sethotspotactiveforeground(handle:Byte Ptr, useSetting:Int, fore:Byte Ptr)
	Function bmx_wxscintilla_sethotspotactivebackground(handle:Byte Ptr, useSetting:Int, back:Byte Ptr)
	Function bmx_wxscintilla_sethotspotactiveunderline(handle:Byte Ptr, underline:Int)
	Function bmx_wxscintilla_sethotspotsingleline(handle:Byte Ptr, singleLine:Int)
	Function bmx_wxscintilla_paradown(handle:Byte Ptr)
	Function bmx_wxscintilla_paradownextend(handle:Byte Ptr)
	Function bmx_wxscintilla_paraup(handle:Byte Ptr)
	Function bmx_wxscintilla_paraupextend(handle:Byte Ptr)
	Function bmx_wxscintilla_positionbefore:Int(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_positionafter:Int(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_copyrange(handle:Byte Ptr, startPos:Int, endPos:Int)
	Function bmx_wxscintilla_setselectionmode(handle:Byte Ptr, Mode:Int)
	Function bmx_wxscintilla_getselectionmode:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_getlineselstartposition:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_getlineselendposition:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_linedownrectextend(handle:Byte Ptr)
	Function bmx_wxscintilla_lineuprectextend(handle:Byte Ptr)
	Function bmx_wxscintilla_charleftrectextend(handle:Byte Ptr)
	Function bmx_wxscintilla_charrightrectextend(handle:Byte Ptr)
	Function bmx_wxscintilla_homerectextend(handle:Byte Ptr)
	Function bmx_wxscintilla_vchomerectextend(handle:Byte Ptr)
	Function bmx_wxscintilla_lineendrectextend(handle:Byte Ptr)
	Function bmx_wxscintilla_pageuprectextend(handle:Byte Ptr)
	Function bmx_wxscintilla_pagedownrectextend(handle:Byte Ptr)
	Function bmx_wxscintilla_stutteredpageup(handle:Byte Ptr)
	Function bmx_wxscintilla_stutteredpageupextend(handle:Byte Ptr)
	Function bmx_wxscintilla_stutteredpagedown(handle:Byte Ptr)
	Function bmx_wxscintilla_stutteredpagedownextend(handle:Byte Ptr)
	Function bmx_wxscintilla_wordleftend(handle:Byte Ptr)
	Function bmx_wxscintilla_wordleftendextend(handle:Byte Ptr)
	Function bmx_wxscintilla_wordrightend(handle:Byte Ptr)
	Function bmx_wxscintilla_wordrightendextend(handle:Byte Ptr)
	Function bmx_wxscintilla_setwhitespacechars(handle:Byte Ptr, characters:String)
	Function bmx_wxscintilla_getwhitespacechars:String(handle:Byte Ptr)
	Function bmx_wxscintilla_setpunctuationchars(handle:Byte Ptr, characters:String)
	Function bmx_wxscintilla_getpunctuationchars:String(handle:Byte Ptr)
	Function bmx_wxscintilla_setcharsdefault(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompgetcurrent:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_autocompsetcaseinsensitivebehaviour(handle:Byte Ptr, behaviour:Int)
	Function bmx_wxscintilla_autocompgetcaseinsensitivebehaviour:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_allocate(handle:Byte Ptr, bytes:Int)
	Function bmx_wxscintilla_findcolumn:Int(handle:Byte Ptr, line:Int, column:Int)
	Function bmx_wxscintilla_getcaretsticky:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setcaretsticky(handle:Byte Ptr, useCaretStickyBehaviour:Int)
	Function bmx_wxscintilla_togglecaretsticky(handle:Byte Ptr)
	Function bmx_wxscintilla_setpasteconvertendings(handle:Byte Ptr, convert:Int)
	Function bmx_wxscintilla_getpasteconvertendings:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_selectionduplicate(handle:Byte Ptr)
	Function bmx_wxscintilla_setcaretstyle(handle:Byte Ptr, caretStyle:Int)
	Function bmx_wxscintilla_getcaretstyle:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setindicatorcurrent(handle:Byte Ptr, indicator:Int)
	Function bmx_wxscintilla_getindicatorcurrent:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setindicatorvalue(handle:Byte Ptr, value:Int)
	Function bmx_wxscintilla_getindicatorvalue:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_indicatorfillrange(handle:Byte Ptr, position:Int, fillLength:Int)
	Function bmx_wxscintilla_indicatorclearrange(handle:Byte Ptr, position:Int, clearLength:Int)
	Function bmx_wxscintilla_indicatorallonfor:Int(handle:Byte Ptr, position:Int)
	Function bmx_wxscintilla_indicatorvalueat:Int(handle:Byte Ptr, indicator:Int, position:Int)
	Function bmx_wxscintilla_indicatorstart:Int(handle:Byte Ptr, indicator:Int, position:Int)
	Function bmx_wxscintilla_indicatorend:Int(handle:Byte Ptr, indicator:Int, position:Int)
	Function bmx_wxscintilla_setpositioncachesize(handle:Byte Ptr, size:Int)
	Function bmx_wxscintilla_getpositioncachesize:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_copyallowline(handle:Byte Ptr)
	Function bmx_wxscintilla_getgapposition:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setkeysunicode(handle:Byte Ptr, keysUnicode:Int)
	Function bmx_wxscintilla_getkeysunicode:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_indicatorsetalpha(handle:Byte Ptr, indicator:Int, alpha:Int)
	Function bmx_wxscintilla_indicatorgetalpha:Int(handle:Byte Ptr, indicator:Int)
	Function bmx_wxscintilla_indicatorsetoutlinealpha(handle:Byte Ptr, indicator:Int, alpha:Int)
	Function bmx_wxscintilla_indicatorgetoutlinealpha:Int(handle:Byte Ptr, indicator:Int)
	Function bmx_wxscintilla_setextraascent(handle:Byte Ptr, extraAscent:Int)
	Function bmx_wxscintilla_getextraascent:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setextradescent(handle:Byte Ptr, extraDescent:Int)
	Function bmx_wxscintilla_getextradescent:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_marginsettext(handle:Byte Ptr, line:Int, text:String)
	Function bmx_wxscintilla_margingettext:String(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_marginsetstyle(handle:Byte Ptr, line:Int, style:Int)
	Function bmx_wxscintilla_margingetstyle:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_marginsetstyles(handle:Byte Ptr, line:Int, styles:String)
	Function bmx_wxscintilla_margingetstyles:String(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_margintextclearall(handle:Byte Ptr)
	Function bmx_wxscintilla_marginsetstyleoffset(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_margingetstyleoffset:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setmarginoptions(handle:Byte Ptr, marginOptions:Int)
	Function bmx_wxscintilla_getmarginoptions:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_annotationsettext(handle:Byte Ptr, line:Int, text:String)
	Function bmx_wxscintilla_annotationgettext:String(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_annotationsetstyle(handle:Byte Ptr, line:Int, style:Int)
	Function bmx_wxscintilla_annotationgetstyle:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_annotationsetstyles(handle:Byte Ptr, line:Int, styles:String)
	Function bmx_wxscintilla_annotationgetstyles:String(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_annotationgetlines:Int(handle:Byte Ptr, line:Int)
	Function bmx_wxscintilla_annotationclearall(handle:Byte Ptr)
	Function bmx_wxscintilla_annotationsetvisible(handle:Byte Ptr, visible:Int)
	Function bmx_wxscintilla_annotationgetvisible:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_annotationsetstyleoffset(handle:Byte Ptr, style:Int)
	Function bmx_wxscintilla_annotationgetstyleoffset:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_addundoaction(handle:Byte Ptr, token:Int, flags:Int)
	Function bmx_wxscintilla_charpositionfrompoint:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxscintilla_charpositionfrompointclose:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxscintilla_setmultipleselection(handle:Byte Ptr, multipleSelection:Int)
	Function bmx_wxscintilla_getmultipleselection:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setadditionalselectiontyping(handle:Byte Ptr, additionalSelectionTyping:Int)
	Function bmx_wxscintilla_getadditionalselectiontyping:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setadditionalcaretsblink(handle:Byte Ptr, additionalCaretsBlink:Int)
	Function bmx_wxscintilla_getadditionalcaretsblink:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setadditionalcaretsvisible(handle:Byte Ptr, additionalCaretsBlink:Int)
	Function bmx_wxscintilla_getadditionalcaretsvisible:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_getselections:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_clearselections(handle:Byte Ptr)
	Function bmx_wxscintilla_addselection:Int(handle:Byte Ptr, caret:Int, anchor:Int)
	Function bmx_wxscintilla_setmainselection(handle:Byte Ptr, selection:Int)
	Function bmx_wxscintilla_getmainselection:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setselectionncaret(handle:Byte Ptr, selection:Int, pos:Int)
	Function bmx_wxscintilla_getselectionncaret:Int(handle:Byte Ptr, selection:Int)
	Function bmx_wxscintilla_setselectionnanchor(handle:Byte Ptr, selection:Int, posAnchor:Int)
	Function bmx_wxscintilla_getselectionnanchor:Int(handle:Byte Ptr, selection:Int)
	Function bmx_wxscintilla_setselectionncaretvirtualspace(handle:Byte Ptr, selection:Int, space:Int)
	Function bmx_wxscintilla_getselectionncaretvirtualspace:Int(handle:Byte Ptr, selection:Int)
	Function bmx_wxscintilla_setselectionnanchorvirtualspace(handle:Byte Ptr, selection:Int, space:Int)
	Function bmx_wxscintilla_getselectionnanchorvirtualspace:Int(handle:Byte Ptr, selection:Int)
	Function bmx_wxscintilla_setselectionnstart(handle:Byte Ptr, selection:Int, pos:Int)
	Function bmx_wxscintilla_getselectionnstart:Int(handle:Byte Ptr, selection:Int)
	Function bmx_wxscintilla_setselectionnend(handle:Byte Ptr, selection:Int, pos:Int)
	Function bmx_wxscintilla_getselectionnend:Int(handle:Byte Ptr, selection:Int)
	Function bmx_wxscintilla_setrectangularselectioncaret(handle:Byte Ptr, pos:Int)
	Function bmx_wxscintilla_getrectangularselectioncaret:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setrectangularselectionanchor(handle:Byte Ptr, posAnchor:Int)
	Function bmx_wxscintilla_getrectangularselectionanchor:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setrectangularselectioncaretvirtualspace(handle:Byte Ptr, space:Int)
	Function bmx_wxscintilla_getrectangularselectioncaretvirtualspace:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setrectangularselectionanchorvirtualspace(handle:Byte Ptr, space:Int)
	Function bmx_wxscintilla_getrectangularselectionanchorvirtualspace:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setvirtualspaceoptions(handle:Byte Ptr, virtualSpaceOptions:Int)
	Function bmx_wxscintilla_getvirtualspaceoptions:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setrectangularselectionmodifier(handle:Byte Ptr, modifier:Int)
	Function bmx_wxscintilla_getrectangularselectionmodifier:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setadditionalselforeground(handle:Byte Ptr, fore:Byte Ptr)
	Function bmx_wxscintilla_setadditionalselbackground(handle:Byte Ptr, back:Byte Ptr)
	Function bmx_wxscintilla_setadditionalselalpha(handle:Byte Ptr, alpha:Int)
	Function bmx_wxscintilla_getadditionalselalpha:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_setadditionalcaretforeground(handle:Byte Ptr, fore:Byte Ptr)
	Function bmx_wxscintilla_getadditionalcaretforeground:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxscintilla_rotateselection(handle:Byte Ptr)
	Function bmx_wxscintilla_swapmainanchorcaret(handle:Byte Ptr)
	Function bmx_wxscintilla_changelexerstate:Int(handle:Byte Ptr, startPos:Int, endPos:Int)
	Function bmx_wxscintilla_contractedfoldnext:Int(handle:Byte Ptr, lineStart:Int)
	Function bmx_wxscintilla_verticalcentrecaret(handle:Byte Ptr)
	Function bmx_wxscintilla_moveselectedlinesup(handle:Byte Ptr)
	Function bmx_wxscintilla_moveselectedlinesdown(handle:Byte Ptr)
	Function bmx_wxscintilla_setidentifier(handle:Byte Ptr, identifier:Int)
	Function bmx_wxscintilla_getidentifier:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_rgbaimagesetwidth(handle:Byte Ptr, width:Int)
	Function bmx_wxscintilla_rgbaimagesetheight(handle:Byte Ptr, height:Int)
	Function bmx_wxscintilla_scrolltostart(handle:Byte Ptr)
	Function bmx_wxscintilla_scrolltoend(handle:Byte Ptr)
	Function bmx_wxscintilla_settechnology(handle:Byte Ptr, technology:Int)
	Function bmx_wxscintilla_gettechnology:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_startrecord(handle:Byte Ptr)
	Function bmx_wxscintilla_stoprecord(handle:Byte Ptr)
	Function bmx_wxscintilla_setlexer(handle:Byte Ptr, lexer:Int)
	Function bmx_wxscintilla_getlexer:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_colourise(handle:Byte Ptr, startPos:Int, endPos:Int)
	Function bmx_wxscintilla_setproperty(handle:Byte Ptr, key:String, value:String)
	Function bmx_wxscintilla_setkeywords(handle:Byte Ptr, keywordSet:Int, keyWords:String)
	Function bmx_wxscintilla_setlexerlanguage(handle:Byte Ptr, language:String)
	Function bmx_wxscintilla_getproperty:String(handle:Byte Ptr, key:String)
	Function bmx_wxscintilla_getpropertyexpanded:String(handle:Byte Ptr, key:String)
	Function bmx_wxscintilla_getpropertyint:Int(handle:Byte Ptr, key:String)
	Function bmx_wxscintilla_getstylebitsneeded:Int(handle:Byte Ptr)
	Function bmx_wxscintilla_propertynames:String(handle:Byte Ptr)
	Function bmx_wxscintilla_propertytype:Int(handle:Byte Ptr, name:String)
	Function bmx_wxscintilla_describeproperty:String(handle:Byte Ptr, name:String)
	Function bmx_wxscintilla_describekeywordsets:String(handle:Byte Ptr)
	' //--Autogenerated


	Function bmx_wxscintillaevent_getposition:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getkey:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getmodifiers:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getmodificationtype:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_gettext:String(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getlength:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getlinesadded:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getline:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getfoldlevelnow:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getfoldlevelprev:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getmargin:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getmessage:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getwparam:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getlparam:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getlisttype:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getx:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_gety:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getdragtext:String(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getdragallowmove:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getshift:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getcontrol:Int(handle:Byte Ptr)
	Function bmx_wxscintillaevent_getalt:Int(handle:Byte Ptr)

	Function bmx_wxscintilla_geteventtype:Int(evt:Int)
	
End Extern


