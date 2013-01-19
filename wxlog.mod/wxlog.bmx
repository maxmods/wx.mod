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

Rem
bbdoc: wxLog
End Rem
Module wx.wxLog

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2013 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
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


Rem
bbdoc: Defines the interface for the log targets used by wxWidgets logging functions as explained in the wxLog overview.
about: The only situations when you need to directly use this class is when you want to derive your own log target
because the existing ones don't satisfy your needs. Another case is if you wish to customize the behaviour of the
standard logging classes (all of which respect the wxLog settings): for example, set which trace messages are logged
and which are not or change (or even remove completely) the timestamp on the messages.
<p>
Otherwise, it is completely hidden behind the wxLogXXX() functions and you may not even know about its existence.
</p>
End Rem
Type wxLog

	Field wxLogPtr:Byte Ptr
	
	Function _create:wxLog(wxLogPtr:Byte Ptr)
		If wxLogPtr Then
			Local this:wxLog = New wxLog
			this.wxLogPtr = wxLogPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Add the mask to the list of allowed masks for wxLogTrace.
	End Rem
	Function AddTraceMask(mask:String)
		bmx_wxlog_addtracemask(mask)
	End Function
	
	Rem
	bbdoc: Removes all trace masks previously set with AddTraceMask.
	End Rem
	Function ClearTraceMasks()
		bmx_wxlog_cleartracemasks()
	End Function
	
	Rem
	bbdoc: Instructs wxLog to not create new log targets on the fly if there is none currently.
	about: (Almost) for internal use only: it is supposed to be called by the application shutdown code.
	<p>
	Note that this function also calls ClearTraceMasks.
	</p>
	End Rem
	Function DontCreateOnDemand()
		bmx_wxlog_dontcreateondemand()
	End Function
	
	Rem
	bbdoc: Flushes the current log target if any, does nothing if there is none.
	End Rem
	Function FlushActive()
		bmx_wxlog_flushactive()
	End Function
	
	Rem
	bbdoc: Returns the currently allowed list of string trace masks.
	End Rem
	Function GetTraceMasks:String[]()
		bmx_wxlog_gettracemasks()
	End Function

	Rem
	bbdoc: Returns the pointer to the active log target (may be NULL).
	End Rem
	Function GetActiveTarget:wxLog()
		Return wxLog._create(bmx_wxlog_getactivetarget())
	End Function
	
	Rem
	bbdoc: Returns the current log level limit.
	End Rem
	Function GetLogLevel:Int()
		Return bmx_wxlog_getloglevel()
	End Function
	
	Rem
	bbdoc: Returns whether the repetition counting mode is enabled.
	End Rem
	Function GetRepetitionCounting:Int()
		Return bmx_wxlog_getrepetitioncounting()
	End Function
	
	Rem
	bbdoc: Returns the current timestamp format string.
	End Rem
	Function GetTimestamp:String()
		Return bmx_wxlog_gettimestamp()
	End Function
	
	Rem
	bbdoc: Returns the current trace mask.
	End Rem
	Function GetTraceMask:Int()
		Return bmx_wxlog_gettracemask()
	End Function
	
	Rem
	bbdoc: Returns whether the verbose mode is currently active.
	End Rem
	Function GetVerbose:Int()
		Return bmx_wxlog_getverbose()
	End Function
	
	Rem
	bbdoc: Returns true if the mask is one of allowed masks for wxLogTrace.
	End Rem
	Function IsAllowedTraceMask:Int(mask:String)
		Return bmx_wxlog_isallowedtracemask(mask)
	End Function
	
	Rem
	bbdoc: Remove the mask from the list of allowed masks for wxLogTrace.
	End Rem
	Function RemoveTraceMask(mask:String)
		bmx_wxlog_removetracemask(mask)
	End Function

	Rem
	bbdoc: Resumes logging previously suspended by a call to Suspend.
	about: All messages logged in the meanwhile will be flushed soon.
	End Rem
	Function Resume()
		bmx_wxlog_resume()
	End Function
	
	Rem
	bbdoc: Sets the specified log target as the active one.
	about: Returns the previous active log target (may be Null). To suppress logging use a new
	instance of wxLogNull, not Null. If the active log target is set to Null a new default log target will be
	created when logging occurs.
	End Rem
	Function SetActiveTarget:wxLog(target:wxLog)
		Local m:Byte Ptr = bmx_wxlog_setactivetarget(target.wxLogPtr)
		If m Then
			Local logger:wxLog = wxLog(wxlogfind(m))
			If Not logger Then
				Return wxLog._create(m)
			End If
			Return logger
		End If
	End Function
	
	Rem
	bbdoc: Specifies that log messages with level > logLevel should be ignored and not sent to the active log target.
	End Rem
	Function SetLogLevel(level:Int)
		bmx_wxlog_setloglevel(level)
	End Function
	
	Rem
	bbdoc: Enables logging mode in which a log message is logged once, and in case exactly the same message successively repeats one or more times, only the number of repetitions is logged.
	End Rem
	Function SetRepetitionCounting(repetCounting:Int = True)
		bmx_wxlog_setrepetitioncounting(repetCounting)
	End Function
	
	Rem
	bbdoc: Sets the trace mask.
	End Rem
	Function SetTraceMask(mask:Int)
		bmx_wxlog_settracemask(mask)
	End Function
	
	Rem
	bbdoc: Suspends the logging until Resume is called.
	about: Note that the latter must be called the same number of times as the former to undo it,
	i.e. if you call Suspend() twice you must call Resume() twice as well.
	<p>
	Note that suspending the logging means that the log sink won't be be flushed periodically, it doesn't
	have any effect if the current log target does the logging immediately without waiting for Flush to be
	called (the standard GUI log target only shows the log dialog when it is flushed, so Suspend() works as
	expected with it).
	</p>
	End Rem
	Function Suspend()
		bmx_wxlog_suspend()
	End Function
	
	Rem
	bbdoc: Sets the timestamp format prepended by the default log targets to all messages.
	about: The string may contain any normal characters as well as % prefixed format specificators, see strftime()
	manual for details. Passing a Null value (not empty string) to this function disables message timestamping.
	End Rem
	Function SetTimestamp(format:String)
		If format Then
			bmx_wxlog_settimestamp(format)
		Else
			bmx_wxlog_settimestamp(Null)
		End If
	End Function
	
	Rem
	bbdoc: Activates or deactivates verbose mode in which the verbose messages are logged as the normal ones instead of being silently dropped.
	End Rem
	Function SetVerbose(verbose:Int = True)
		bmx_wxlog_setverbose(verbose)
	End Function
	
	Method Free()
		If wxLogPtr Then
			bmx_wxlog_delete(wxLogPtr)
			wxLogPtr = Null
		End If
	End Method

	Method Delete()
		Free()
	End Method
	
End Type

Rem
Type wxLogNull Extends wxLog

	Function CreateLogNull:wxLogNull()
		Return New wxLogNull.Create()
	End Function
	
	Method Create:wxLogNull()
		wxLogPtr = bmx_wxlognull_create(Self)
		Return Self
	End Method
	
End Type
End Rem

Rem
bbdoc: Allows all the log messages to be redirected to a text control.
about: The text control must have been created with wxTE_MULTILINE style by the caller previously.
End Rem
Type wxLogTextCtrl Extends wxLog

	Rem
	bbdoc: Constructs a log target which sends all the log messages to the given text control.
	about: The textctrl parameter cannot be Null.
	End Rem
	Function CreateLogTextCtrl:wxLogTextCtrl(textCtrl:wxTextCtrl)
		Return New wxLogTextCtrl.Create(textCtrl)
	End Function
	
	Rem
	bbdoc: Constructs a log target which sends all the log messages to the given text control.
	about: The textctrl parameter cannot be Null.
	End Rem
	Method Create:wxLogTextCtrl(textCtrl:wxTextCtrl)
		wxLogPtr = bmx_wxlogtextctrl_create(Self, textCtrl.wxObjectPtr)
		Return Self
	End Method

End Type

Rem
bbdoc: A very simple implementation of log sink which simply collects all the logged messages in a string (except the debug messages which are output in the usual way immediately as we're presumably not interested in collecting them for later).
about: The messages from different log function calls are separated by the new lines.
<p>
All the messages collected so far can be shown to the user (and the current buffer cleared) by calling the overloaded Flush() method.
</p>
End Rem
Type wxLogBuffer Extends wxLog

	Rem
	bbdoc: Creates a new wxLogBuffer.
	End Rem
	Function CreateLogBuffer:wxLogBuffer()
		Return New wxLogBuffer.Create()
	End Function
	
	Rem
	bbdoc: Creates a new wxLogBuffer.
	End Rem
	Method Create:wxLogBuffer()
		wxLogPtr = bmx_wxlogbuffer_create(Self)
		Return Self
	End Method
	
	Rem
	bbdoc: Shows all the messages collected so far to the user (using a message box in the GUI applications or by printing them out to the console in text mode) and clears the internal buffer.
	End Rem
	Method Flush()
		bmx_wxlogbuffer_flush(wxLogPtr)
	End Method
	
	Rem
	bbdoc: Returns the current buffer contains.
	about: Messages from different log function calls are separated with the new lines in the buffer. The buffer can be cleared by
	Flush() which will also show the current contents to the user.
	End Rem
	Method GetBuffer:String()
		Return bmx_wxlogbuffer_getbuffer(wxLogPtr)
	End Method

End Type

Rem
bbdoc: Allows the use of any writeable TStream for logging.
about: The stream is assumed to be opened and closed by the user.
End Rem
Type wxLogStream Extends wxLog

	Field _stream:TStream
	
	Rem
	bbdoc: Creates a new wxLogStream.
	End Rem
	Function CreateLogStream:wxLogStream(stream:TStream)
		Return New wxLogStream.Create(stream)
	End Function
	
	Rem
	bbdoc: Creates a new wxLogStream.
	End Rem
	Method Create:wxLogStream(stream:TStream)
		_stream = stream
		wxLogPtr = bmx_wxlogstream_create(Self)
		Return Self
	End Method

	Function _DoLogString(logger:wxLogStream, text:String)
		logger.DoLogString(text)
	End Function
	
	Method DoLogString(text:String)
		_stream.WriteLine(text)
	End Method
	
End Type

