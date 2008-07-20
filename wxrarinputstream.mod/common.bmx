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

Import "include/*.h"
Import "src/unrar/*.hpp"

Import "src/unrar/dll.cpp"
Import "src/unrar/filestr.cpp"
Import "src/unrar/recvol.cpp"
Import "src/unrar/rs.cpp"
Import "src/unrar/scantree.cpp"
Import "src/unrar/rar.cpp"
Import "src/unrar/strlist.cpp"
Import "src/unrar/strfn.cpp"
Import "src/unrar/pathfn.cpp"
Import "src/unrar/int64.cpp"
Import "src/unrar/savepos.cpp"
Import "src/unrar/global.cpp"
Import "src/unrar/file.cpp"
Import "src/unrar/filefn.cpp"
Import "src/unrar/filcreat.cpp"
Import "src/unrar/archive.cpp"
Import "src/unrar/arcread.cpp"
Import "src/unrar/unicode.cpp"
Import "src/unrar/system.cpp"
Import "src/unrar/isnt.cpp"
Import "src/unrar/crypt.cpp"
Import "src/unrar/crc.cpp"
Import "src/unrar/rawread.cpp"
Import "src/unrar/encname.cpp"
Import "src/unrar/resource.cpp"
Import "src/unrar/match.cpp"
Import "src/unrar/timefn.cpp"
Import "src/unrar/rdwrfn.cpp"
Import "src/unrar/consio.cpp"
Import "src/unrar/options.cpp"
Import "src/unrar/ulinks.cpp"
Import "src/unrar/errhnd.cpp"
Import "src/unrar/rarvm.cpp"
Import "src/unrar/rijndael.cpp"
Import "src/unrar/getbits.cpp"
Import "src/unrar/sha1.cpp"
Import "src/unrar/extinfo.cpp"
Import "src/unrar/extract.cpp"
Import "src/unrar/volume.cpp"
Import "src/unrar/list.cpp"
Import "src/unrar/find.cpp"
Import "src/unrar/unpack.cpp"
Import "src/unrar/cmddata.cpp"
	

Import "src/common/rarstream.cpp"

Import "glue.cpp"

Extern

	Function bmx_wxrarinputstream_create:Byte Ptr(filename:String)
	Function bmx_wxrarinputstream_opennextfile:Int(handle:Byte Ptr)
	Function bmx_wxrarinputstream_extractfile:Int(handle:Byte Ptr, destPath:String, destName:String)
	Function bmx_wxrarinputstream_getfileinfo:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxrarinputstream_close(handle:Byte Ptr)

	Function bmx_wxrarfileinfo_delete(handle:Byte Ptr)
	Function bmx_wxrarfileinfo_getname:String(handle:Byte Ptr)
	Function bmx_wxrarfileinfo_getcomment:String(handle:Byte Ptr)
	Function bmx_wxrarfileinfo_getuncompressedsize:Int(handle:Byte Ptr)
	Function bmx_wxrarfileinfo_getcompressedsize:Int(handle:Byte Ptr)
	Function bmx_wxrarfileinfo_getfiletime:Int(handle:Byte Ptr)

End Extern
