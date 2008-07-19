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

Import "glue.cpp"

Extern

	Function bmx_wxuri_create:Byte Ptr(uri:String)
	Function bmx_wxuri_delete(handle:Byte Ptr)
	Function bmx_wxuri_builduri:String(handle:Byte Ptr)
	Function bmx_wxuri_buildunescapeduri:String(handle:Byte Ptr)
	Function bmx_wxuri_getfragment:String(handle:Byte Ptr)
	Function bmx_wxuri_gethostyype:Int(handle:Byte Ptr)
	Function bmx_wxuri_getpassword:String(handle:Byte Ptr)
	Function bmx_wxuri_getpath:String(handle:Byte Ptr)
	Function bmx_wxuri_getport:String(handle:Byte Ptr)
	Function bmx_wxuri_getquery:String(handle:Byte Ptr)
	Function bmx_wxuri_getscheme:String(handle:Byte Ptr)
	Function bmx_wxuri_getserver:String(handle:Byte Ptr)
	Function bmx_wxuri_getuser:String(handle:Byte Ptr)
	Function bmx_wxuri_getuserinfo:String(handle:Byte Ptr)
	Function bmx_wxuri_hasfragment:Int(handle:Byte Ptr)
	Function bmx_wxuri_haspath:Int(handle:Byte Ptr)
	Function bmx_wxuri_hasport:Int(handle:Byte Ptr)
	Function bmx_wxuri_hasquery:Int(handle:Byte Ptr)
	Function bmx_wxuri_hasscheme:Int(handle:Byte Ptr)
	Function bmx_wxuri_hasserver:Int(handle:Byte Ptr)
	Function bmx_wxuri_isreference:Int(handle:Byte Ptr)
	Function bmx_wxuri_equals:Int(handle:Byte Ptr, uri:Byte Ptr)
	Function bmx_wxuri_resolve(handle:Byte Ptr, base:Byte Ptr, flags:Int)
	Function bmx_wxuri_unescape:String(uri:String)

End Extern

Const wxURI_REGNAME:Int = 0      ' Host is a normal register name (www.mysite.com etc.)
Const wxURI_IPV4ADDRESS:Int = 1  ' Host is a version 4 ip address (192.168.1.100)
Const wxURI_IPV6ADDRESS:Int = 2  ' Host is a version 6 ip address [aa:aa:aa:aa::aa:aa]:5050
Const wxURI_IPVFUTURE:Int = 3     ' Host is a future ip address (wxURI is unsure what kind)


' Component Flags
Const wxURI_SCHEME:Int = 1
Const wxURI_USERINFO:Int = 2
Const wxURI_SERVER:Int = 4
Const wxURI_PORT:Int = 8
Const wxURI_PATH:Int = 16
Const wxURI_QUERY:Int = 32
Const wxURI_FRAGMENT:Int = 64


Const wxURI_STRICT:Int = 1
