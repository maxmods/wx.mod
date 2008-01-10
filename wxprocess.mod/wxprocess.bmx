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
bbdoc: wxProcess 
EndRem
Module wx.wxProcess

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
bbdoc: 
End Rem
Type wxProcess Extends wxEvtHandler

	Function CreateProcess:wxProcess(parent:wxEvtHandler = Null, id:Int = -1)
	End Function
	
	Method Create:wxProcess(parent:wxEvtHandler = Null, id:Int = -1)
	End Method
	
	Function CreateProcessWithFlags:wxProcess(flags:Int)
	End Function
	
	Method CreateWithFlags:wxProcess(flags:Int)
	End Method
	
	Method CloseOutput()
	End Method
	
	Method Detach()
	End Method
	
	Method GetErrorStream:wxInputStream()
	End Method
	
	Method GetInputStream:wxInputStream()
	End Method
	
	Method GetOutputStream:wxOutputStream()
	End Method
	
	Method IsErrorAvailable:Int()
	End Method
	
	Method IsInputAvailable:Int()
	End Method
	
	Method IsInputOpened:Int()
	End Method
	
	Function Kill:Int(pid:Int, signal:Int = wxSIGNONE, flags:Int = wxKILL_NOCHILDREN)
	End Function
	
	Function Exists:Int(pid:Int)
	End Function
	
	Function Open:wxProcess(cmd:String, flags:Int = wxEXEC_ASYNC)
	End Function
	
	Method GetPid:Int()
	End Method
	
	Method Redirect()
	End Method
	
	Method Free()
	End Method

End Type

Rem
bbdoc: Executes another program.
about: 
End Rem
Function wxExecute:Int(command:String, sync:Int = wxEXEC_ASYNC, callback:wxProcess = Null)

End Function


Rem
bbdoc: 
End Rem
Function wxExit()
End Function

Rem
bbdoc: 
End Rem
Function wxKill:Int(pid:Int, signal:Int = wxSIGNONE, rc:Int Var, flags:Int = 0)
End Function

Rem
bbdoc: Returns the number uniquely identifying the current process in the system.
about: If an error occurs, 0 is returned.
End Rem
Function wxGetProcessId:Int()
End Function

Rem
bbdoc: Executes a command in an interactive shell window.
about: If no command is specified, then just the shell is spawned.
End Rem
Function wxShell:Int(command:String = Null)
End Function

Rem
bbdoc: This function shuts down or reboots the computer depending on the value of the flags.
returns: True on success, false if an error occurred.
about: Please notice that doing this requires the corresponding access rights (superuser under Unix, SE_SHUTDOWN
privilege under Windows NT) and that this function is only implemented under Unix and Win32.
End Rem
Function wxShutdown:Int(flags:Int)
End Function


