' Copyright (c) 2007 Bruce A Henderson
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
bbdoc: wxLog
End Rem
Module wx.wxLog

ModuleInfo "Version: 1.00"
ModuleInfo "License:"
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
bbdoc: The function to use for error messages, i.e. the messages that must be shown to the user.
about: The default processing is to pop up a message box to inform the user about it.
End Rem
Function wxLogError(message:String)
	bmx_wxlogerror(message)
End Function

Rem
bbdoc: Like wxLogError, but also terminates the program with the exit code 3.
about: Using abort() standard function also terminates the program with this exit code.
End Rem
Function wxLogFatalError(message:String)
	bmx_wxlogfatalerror(message)
End Function

Rem
bbdoc: For warnings.
about: They are also normally shown to the user, but don't interrupt the program work.
End Rem
Function wxLogWarning(message:String)
	bmx_wxlogwarning(message)
End Function

Rem
bbdoc: For all normal, informational messages.
about: They also appear in a message box by default (but it can be changed).
End Rem
Function wxLogMessage(message:String)
	bmx_wxlogmessage(message)
End Function

Rem
bbdoc: For verbose output.
about: Normally, it is suppressed, but might be activated if the user wishes to know more details
about the program progress (another, but possibly confusing name for the same function is wxLogInfo).
End Rem
Function wxLogVerbose(message:String)
	bmx_wxlogverbose(message)
End Function

Rem
bbdoc: Messages logged by these functions will appear in the statusbar of the @targetFrame or of the top level application window by default.
about: If the target frame doesn't have a statusbar, the message will be lost.
End Rem
Function wxLogStatus(message:String, targetFrame:wxFrame = Null)
	If targetFrame Then
		bmx_wxlogstatus(message, targetFrame.wxObjectPtr)
	Else
		bmx_wxlogstatus(message, Null)
	End If
End Function

Rem
bbdoc: This function shows a message to the user in a safe way and should be safe to call even before the application has been initialized or if it is currently in some other strange state (for example, about to crash).
about: Under Windows this function shows a message box using a native dialog instead of wxMessageBox
(which might be unsafe to call), elsewhere it simply prints the message to the standard output using
the title as prefix.
End Rem
Function wxSafeShowMessage(message:String)
	bmx_wxsafeshowmessage(message)
End Function

Rem
bbdoc: Returns the error code from the last system call.
about: This function uses errno on Unix platforms and GetLastError under Win32.
End Rem
Function wxSysErrorCode:Int()
	Return bmx_wxsyserrorcode()
End Function

Rem
bbdoc: Returns the error message corresponding to the given system error code.
about: If errCode is 0 (default), the last error code (as returned by wxSysErrorCode) is used.
End Rem
Function wxSysErrorMsg:String(code:Int = 0)
	Return bmx_wxsyserrormsg(code)
End Function
