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
Import wx.wxArchive
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

End Extern


Const wxZIP_METHOD_STORE:Int = 0
Const wxZIP_METHOD_SHRINK:Int = 1
Const wxZIP_METHOD_REDUCE1:Int = 2
Const wxZIP_METHOD_REDUCE2:Int = 3
Const wxZIP_METHOD_REDUCE3:Int = 4
Const wxZIP_METHOD_REDUCE4:Int = 5
Const wxZIP_METHOD_IMPLODE:Int = 6
Const wxZIP_METHOD_TOKENIZE:Int = 7
Const wxZIP_METHOD_DEFLATE:Int = 8
Const wxZIP_METHOD_DEFLATE64:Int = 9
Const wxZIP_METHOD_BZIP2:Int = 12
Const wxZIP_METHOD_DEFAULT:Int = $ffff


Const wxZIP_SYSTEM_MSDOS:Int = 0
Const wxZIP_SYSTEM_AMIGA:Int = 1
Const wxZIP_SYSTEM_OPENVMS:Int = 2
Const wxZIP_SYSTEM_UNIX:Int = 3
Const wxZIP_SYSTEM_VM_CMS:Int = 4
Const wxZIP_SYSTEM_ATARI_ST:Int = 5
Const wxZIP_SYSTEM_OS2_HPFS:Int = 6
Const wxZIP_SYSTEM_MACINTOSH:Int = 7
Const wxZIP_SYSTEM_Z_SYSTEM:Int = 8
Const wxZIP_SYSTEM_CPM:Int = 9
Const wxZIP_SYSTEM_WINDOWS_NTFS:Int = 10
Const wxZIP_SYSTEM_MVS:Int = 11
Const wxZIP_SYSTEM_VSE:Int = 12
Const wxZIP_SYSTEM_ACORN_RISC:Int = 13
Const wxZIP_SYSTEM_VFAT:Int = 14
Const wxZIP_SYSTEM_ALTERNATE_MVS:Int = 15
Const wxZIP_SYSTEM_BEOS:Int = 16
Const wxZIP_SYSTEM_TANDEM:Int = 17
Const wxZIP_SYSTEM_OS_400:Int = 18

Const wxZIP_A_RDONLY:Int = $01
Const wxZIP_A_HIDDEN:Int = $02
Const wxZIP_A_SYSTEM:Int = $04
Const wxZIP_A_SUBDIR:Int = $10
Const wxZIP_A_ARCH:Int = $20
Const wxZIP_A_MASK:Int = $37

Const wxZIP_ENCRYPTED:Int = $0001
Const wxZIP_DEFLATE_NORMAL:Int = $0000   ' normal compression
Const wxZIP_DEFLATE_EXTRA:Int = $0002   ' extra compression
Const wxZIP_DEFLATE_FAST:Int = $0004   ' fast compression
Const wxZIP_DEFLATE_SUPERFAST:Int = $0006   ' superfast compression
Const wxZIP_DEFLATE_MASK:Int = $0006
Const wxZIP_SUMS_FOLLOW:Int = $0008   ' crc And sizes come after the data
Const wxZIP_ENHANCED:Int = $0010
Const wxZIP_PATCH:Int = $0020
Const wxZIP_STRONG_ENC:Int = $0040
Const wxZIP_UNUSED:Int = $0F80
Const wxZIP_RESERVED:Int = $F000

