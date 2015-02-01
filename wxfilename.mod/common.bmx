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

Import "glue.cpp"

Extern

	Function bmx_wxfilename_create:Byte Ptr(path:String, name:String, format:Int)
	Function bmx_wxfilename_appenddir(handle:Byte Ptr, dir:String)
	Function bmx_wxfilename_assigncwd(handle:Byte Ptr, volume:String)
	Function bmx_wxfilename_assigndir(handle:Byte Ptr, dir:String, format:Int)
	Function bmx_wxfilename_assignhomedir(handle:Byte Ptr)
	Function bmx_wxfilename_clear(handle:Byte Ptr)
	Function bmx_wxfilename_clearext(handle:Byte Ptr)
	Function bmx_wxfilename_direxists:Int(dir:String)
	Function bmx_wxfilename_dirname:Byte Ptr(dir:String, format:Int)
	Function bmx_wxfilename_fileexists:Int(handle:Byte Ptr)
	Function bmx_wxfilename_ffileexists:Int(filename:String)
	Function bmx_wxfilename_filename:Byte Ptr(file:String, format:Int)
	Function bmx_wxfilename_getcwd:String(volume:String)
	Function bmx_wxfilename_getdircount:Int(handle:Byte Ptr)
	Function bmx_wxfilename_getdirs:String[](handle:Byte Ptr)
	Function bmx_wxfilename_getext:String(handle:Byte Ptr)
	Function bmx_wxfilename_getforbiddenchars:String(format:Int)
	Function bmx_wxfilename_getformat:Int(format:Int)
	Function bmx_wxfilename_getfullname:String(handle:Byte Ptr)
	Function bmx_wxfilename_getfullpath:String(handle:Byte Ptr, format:Int)
	Function bmx_wxfilename_gethomedir:String()
	Function bmx_wxfilename_getlongpath:String(handle:Byte Ptr)
	Function bmx_wxfilename_getmodificationtime:Int(handle:Byte Ptr)
	Function bmx_wxfilename_getname:String(handle:Byte Ptr)
	Function bmx_wxfilename_getpath:String(handle:Byte Ptr, flags:Int, format:Int)
	Function bmx_wxfilename_getpathseparator:String(format:Int)
	Function bmx_wxfilename_getpathseparators:String(format:Int)
	Function bmx_wxfilename_getpathterminators:String(format:Int)
	Function bmx_wxfilename_getpathwithsep:String(handle:Byte Ptr, format:Int)
	Function bmx_wxfilename_getshortpath:String(handle:Byte Ptr)
	Function bmx_wxfilename_getsize(handle:Byte Ptr, size:Long Ptr)
	Function bmx_wxfilename_fgetsize(filename:String, size:Long Ptr)
	Function bmx_wxfilename_gethumanreadablesize:String(handle:Byte Ptr, failmsg:String, precision:Int)
	Function bmx_wxfilename_fgethumanreadablesize:String(size:Long, failmsg:String, precision:Int)
	Function bmx_wxfilename_gettempdir:String()
	Function bmx_wxfilename_getvolume:String(handle:Byte Ptr)
	Function bmx_wxfilename_getvolumeseparator:String(format:Int)
	Function bmx_wxfilename_hasext:Int(handle:Byte Ptr)
	Function bmx_wxfilename_hasname:Int(handle:Byte Ptr)
	Function bmx_wxfilename_hasvolume:Int(handle:Byte Ptr)
	Function bmx_wxfilename_insertdir(handle:Byte Ptr, before:Int, dir:String)
	Function bmx_wxfilename_isabsolute:Int(handle:Byte Ptr, format:Int)
	Function bmx_wxfilename_iscasesensitive:Int(format:Int)
	Function bmx_wxfilename_isdirreadable:Int(handle:Byte Ptr)
	Function bmx_wxfilename_fisdirreadable:Int(dir:String)
	Function bmx_wxfilename_isdirwritable:Int(handle:Byte Ptr)
	Function bmx_wxfilename_fisdirwritable:Int(dir:String)
	Function bmx_wxfilename_isfileexecutable:Int(handle:Byte Ptr)
	Function bmx_wxfilename_fisfileexecutable:Int(file:String)
	Function bmx_wxfilename_isfilereadable:Int(handle:Byte Ptr)
	Function bmx_wxfilename_fisfilereadable:Int(file:String)
	Function bmx_wxfilename_isfilewritable:Int(handle:Byte Ptr)
	Function bmx_wxfilename_fisfilewritable:Int(file:String)
	Function bmx_wxfilename_isok:Int(handle:Byte Ptr)
	Function bmx_wxfilename_ispathseparator:Int(char:String, format:Int)
	Function bmx_wxfilename_isrelative:Int(handle:Byte Ptr, format:Int)
	Function bmx_wxfilename_isdir:Int(handle:Byte Ptr)
	Function bmx_wxfilename_makeabsolute:Int(handle:Byte Ptr, cwd:String, format:Int)
	Function bmx_wxfilename_makerelativeto:Int(handle:Byte Ptr, pathBase:String, format:Int)
	Function bmx_wxfilename_mkdir:Int(handle:Byte Ptr, perm:Int, flags:Int)
	Function bmx_wxfilename_fmkdir:Int(dir:String, perm:Int, flags:Int)
	Function bmx_wxfilename_normalize:Int(handle:Byte Ptr, flags:Int, cwd:String, format:Int)
	Function bmx_wxfilename_prependdir(handle:Byte Ptr, dir:String)
	Function bmx_wxfilename_removedir(handle:Byte Ptr, pos:Int)
	Function bmx_wxfilename_removelastdir(handle:Byte Ptr)
	Function bmx_wxfilename_rmdir:Int(handle:Byte Ptr)
	Function bmx_wxfilename_frmdir:Int(dir:String)
	Function bmx_wxfilename_sameas:Int(handle:Byte Ptr, filename:Byte Ptr, format:Int)
	Function bmx_wxfilename_setcwd:Int(handle:Byte Ptr)
	Function bmx_wxfilename_fsetcwd:Int(dir:String)
	Function bmx_wxfilename_setext(handle:Byte Ptr, ext:String)
	Function bmx_wxfilename_setemptyext(handle:Byte Ptr)
	Function bmx_wxfilename_setfullname(handle:Byte Ptr, name:String)
	Function bmx_wxfilename_setname(handle:Byte Ptr, name:String)
	Function bmx_wxfilename_setvolume(handle:Byte Ptr, volume:String)
	Function bmx_wxfilename_touch:Int(handle:Byte Ptr)
	Function bmx_wxfilename_delete(handle:Byte Ptr)

	
End Extern

