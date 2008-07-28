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
bbdoc: wx.wxSingleInstanceChecker
End Rem
Module wx.wxSingleInstanceChecker

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
bbdoc: wxSingleInstanceChecker type allows to check that only a single instance of a program is running.
about: To do it, you should create an object of this type. As long as this object is alive, calls to
IsAnotherRunning() from other processes will return true.
<p>
As the object should have the life span as big as possible, it makes sense to create it either as a global
or in wxApp::OnInit. For example:
<pre>
Method OnInit:Int()
    Local name:String = "MyApp-" + wxGetUserId() 
    
    m_checker = new wxSingleInstanceChecker.Create(name)
    
    If m_checker.IsAnotherRunning() Then 
        wxLogError(_("Another program instance is already running, aborting.")) 
        Return False
    End If
    ... more initializations ... 
    Return True
End Method
</pre>
</p>
End Rem
Type wxSingleInstanceChecker

	Field wxObjectPtr:Byte Ptr
	
	Rem
	bbdoc: Creates a new instance of wxSingleInstanceChecker.
	about: Parameters:
	<ul>
	<li><b>name</b> must be given and be as unique as possible. It is used as the mutex name under Win32 and the lock
	file name under Unix. GetAppName() and wxGetUserId() are commonly used to construct this parameter.</li>
	<li><b>path</b> is optional and is ignored under Win32 and used as the directory to create the lock file in under
	Unix (default is wxGetHomeDir())</li>
	</ul>
	End Rem
	Function CreateSingleInstanceChecker:wxSingleInstanceChecker(name:String, path:String = Null)
		Return New wxSingleInstanceChecker.Create(name, path)
	End Function
	
	Rem
	bbdoc: Creates a new instance of wxSingleInstanceChecker.
	End Rem
	Method Create:wxSingleInstanceChecker(name:String, path:String = Null)
		wxObjectPtr = bmx_wxsingleinstancechecker_create(name, path)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns true if another copy of this program is already running, false otherwise.
	End Rem
	Method IsAnotherRunning:Int()
		Return bmx_wxsingleinstancechecker_isanotherrunning(wxObjectPtr)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxsingleinstancechecker_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type
