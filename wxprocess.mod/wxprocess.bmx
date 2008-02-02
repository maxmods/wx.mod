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
bbdoc: The objects of this class are used in conjunction with the wxExecute function.
about: When a wxProcess object is passed to wxExecute(), its OnTerminate() virtual method is called
when the process terminates. This allows the program to be (asynchronously) notified about the
process termination and also retrieve its exit status which is unavailable from wxExecute() in
the case of asynchronous execution.
<p>
Please note that if the process termination notification is processed by the parent, it is responsible
for deleting the wxProcess object which sent it. However, if it is not processed, the object will
delete itself and so the library users should only delete those objects whose notifications have
been processed (and call Detach() for others).
</p>
<p>
wxProcess also supports IO redirection of the child process. For this, you have to call its Redirect
method before passing it to wxExecute. If the child process was launched successfully, GetInputStream,
GetOutputStream and GetErrorStream can then be used to retrieve the streams corresponding to the
child process standard output, input and error output respectively.
</p>
End Rem
Type wxProcess Extends wxEvtHandler

	Function _create:wxProcess(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxProcess = New wxProcess
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructs a process object.
	about: @id is only used in the case you want to use wxWidgets events. It identifies this
	object, or another window that will receive the event.
	<p>
	If the @parent parameter is not Null, it will receive a wxEVT_END_PROCESS notification event
	(you should connect a wxEVT_END_PROCESS function to the parent to handle it)
	with the given id.
	End Rem
	Function CreateProcess:wxProcess(parent:wxEvtHandler = Null, id:Int = -1)
		Return New wxProcess.Create(parent, id)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxProcess(parent:wxEvtHandler = Null, id:Int = -1)
		If parent Then
			wxObjectPtr = bmx_wxprocess_create(Self, parent.wxObjectPtr, id)
		Else
			wxObjectPtr = bmx_wxprocess_create(Self, Null, id)
		End If
		OnInit()
		Return Self
	End Method
	
	Rem
	bbdoc: Creates an object without any associated parent (and hence no id neither) but allows to specify the flags which can have the value of wxPROCESS_DEFAULT or wxPROCESS_REDIRECT.
	about: Specifying the former value has no particular effect while using the latter one is
	equivalent to calling Redirect.
	End Rem
	Function CreateProcessWithFlags:wxProcess(flags:Int)
		Return New wxProcess.CreateWithFlags(flags)
	End Function
	
	Rem
	bbdoc: Creates an object without any associated parent (and hence no id neither) but allows to specify the flags which can have the value of wxPROCESS_DEFAULT or wxPROCESS_REDIRECT.
	about: Specifying the former value has no particular effect while using the latter one is
	equivalent to calling Redirect.
	End Rem
	Method CreateWithFlags:wxProcess(flags:Int)
		wxObjectPtr = bmx_wxprocess_createwithflags(Self, flags)
		OnInit()
		Return Self
	End Method
	
	Rem
	bbdoc: Closes the output stream (the one connected to the stdin of the child process).
	about: This method can be used to indicate to the child process that there is no more
	data to be read - usually, a filter program will only terminate when the input stream
	is closed.
	End Rem
	Method CloseOutput()
		bmx_wxprocess_closeoutput(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Normally, a wxProcess object is deleted by its parent when it receives the notification about the process termination.
	about: However, it might happen that the parent object is destroyed before the external process
	is terminated (e.g. a window from which this external process was launched is closed by the
	user) and in this case it should not delete the wxProcess object, but should call Detach() instead.
	After the wxProcess object is detached from its parent, no notification events will be sent
	to the parent and the object will delete itself upon reception of the process termination
	notification.
	End Rem
	Method Detach()
		bmx_wxprocess_detach(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns an input stream which corresponds to the standard error output (stderr) of the child process.
	End Rem
	Method GetErrorStream:wxInputStream()
		Return wxInputStream._create(bmx_wxprocess_geterrorstream(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: It returns an input stream corresponding to the standard output stream of the subprocess.
	about: If it is NULL, you have not turned on the redirection. See wxProcess::Redirect.
	End Rem
	Method GetInputStream:wxInputStream()
		Return wxInputStream._create(bmx_wxprocess_getintputstream(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: It returns an output stream correspoding to the input stream of the subprocess.
	about: If it is NULL, you have not turned on the redirection. See wxProcess::Redirect.
	End Rem
	Method GetOutputStream:wxOutputStream()
		Return wxOutputStream._create(bmx_wxprocess_getoutputstream(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns true if there is data to be read on the child process standard error stream.
	End Rem
	Method IsErrorAvailable:Int()
		Return bmx_wxprocess_iserroravailable(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if there is data to be read on the child process standard output stream.
	about: This allows to write simple (and extremely inefficient) polling-based code waiting
	for a better mechanism in future wxWidgets versions.
	End Rem
	Method IsInputAvailable:Int()
		Return bmx_wxprocess_isinputavailable(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the child process standard output stream is opened.
	End Rem
	Method IsInputOpened:Int()
		Return bmx_wxprocess_isinputopened(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Send the specified signal to the given process.
	End Rem
	Function Kill:Int(pid:Int, signal:Int = wxSIGNONE, flags:Int = wxKILL_NOCHILDREN)
		Return bmx_wxprocess_kill(pid, signal, flags)
	End Function
	
	Rem
	bbdoc: Returns true if the given process exists in the system.
	End Rem
	Function Exists:Int(pid:Int)
		Return bmx_wxprocess_exists(pid)
	End Function
	
	Rem
	bbdoc: This function replaces the standard popen() function: it launches the process specified by the cmd parameter and returns the wxProcess object which can be used to retrieve the streams connected to the standard input, output and error output of the child process.
	about: If the process couldn't be launched, NULL is returned. Note that the process object will be destroyed automatically when
	the child process terminates. This does mean that the child process should be told to quit
	before the main program exits to avoid memory leaks.
	End Rem
	Function Open:wxProcess(cmd:String, flags:Int = wxEXEC_ASYNC)
		Return _create(bmx_wxprocess_open(cmd, flags))
	End Function
	
	Rem
	bbdoc: Returns the process ID of the process launched by Open.
	End Rem
	Method GetPid:Int()
		Return bmx_wxprocess_getpid(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Turns on redirection.
	about: wxExecute will try to open a couple of pipes to catch the subprocess stdio. The caught
	input stream is returned by GetOutputStream() as a non-seekable stream. The caught output
	stream is returned by GetInputStream() as a non-seekable stream.
	End Rem
	Method Redirect()
		bmx_wxprocess_redirect(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: It is called when the process with the pid @pid finishes.
	about: It raises a wxWidgets event when it isn't overridden.
	End Rem
	Method OnTerminate(pid:Int, status:Int)
		bmx_wxprocess_onterminate(wxObjectPtr, pid, status)
	End Method
	
	Function _OnTerminate(obj:wxProcess, pid:Int, status:Int)
		obj.OnTerminate(pid, status)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxprocess_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Executes another program.
about: 
End Rem
Function wxExecute:Int(command:String, sync:Int = wxEXEC_ASYNC, callback:wxProcess = Null)
	If callback Then
		Return bmx_wxexecute(command, sync, callback.wxObjectPtr)
	Else
		Return bmx_wxexecute(command, sync, Null)
	End If
End Function


Rem
bbdoc: Exits application after calling wxApp::OnExit.
about: Should only be used in an emergency: normally the top-level frame should be deleted (after deleting all other
frames) to terminate the application. See wxCloseEvent and wxApp.
End Rem
Function wxExit()
	bmx_wxexit()
End Function

Rem
bbdoc: 
End Rem
Function wxKill:Int(pid:Int, signal:Int = wxSIGNONE, rc:Int Var, flags:Int = 0)
	Return bmx_wxkill(pid, signal, Varptr rc, flags)
End Function

Rem
bbdoc: Returns the number uniquely identifying the current process in the system.
about: If an error occurs, 0 is returned.
End Rem
Function wxGetProcessId:Int()
	Return bmx_wxgetprocessid()
End Function

Rem
bbdoc: Executes a command in an interactive shell window.
about: If no command is specified, then just the shell is spawned.
End Rem
Function wxShell:Int(command:String = Null)
	Return bmx_wxshell(command)
End Function

Rem
bbdoc: This function shuts down or reboots the computer depending on the value of the flags.
returns: True on success, false if an error occurred.
about: Please notice that doing this requires the corresponding access rights (superuser under Unix, SE_SHUTDOWN
privilege under Windows NT) and that this function is only implemented under Unix and Win32.
<p>@flags : Either wxSHUTDOWN_POWEROFF or wxSHUTDOWN_REBOOT</p>
End Rem
Function wxShutdown:Int(flags:Int)
	Return bmx_wxshutdown(flags)
End Function

Rem
bbdoc: A process event is sent when a process is terminated.
End Rem
Type wxProcessEvent Extends wxEvent

	Function Create:wxProcessEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxProcessEvent = New wxProcessEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the process id.
	End Rem
	Method GetPid:Int()
		Return bmx_wxprocessevent_getpid(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the exist status.
	End Rem
	Method GetExitCode:Int()
		Return bmx_wxprocessevent_getexitcode(wxEventPtr)
	End Method
	
End Type


Type TProcessEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_END_PROCESS Then
			Return wxProcessEvent.Create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_END_PROCESS Then
			Return bmx_wxprocess_geteventtype(eventType)
		End If
	End Method
		
End Type

New TProcessEventFactory

