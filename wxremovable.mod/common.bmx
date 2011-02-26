' Copyright (c) 2007-2011 Bruce A Henderson & Nigel Brown
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
Import wx.wxApp
Import wx.wxWindow
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

?Win32

	Import "src/eject.c"

	Const WM_DEVICECHANGE:Int = 537

	Const DBT_NO_DISK_SPACE:Int = $47
	Const DBT_CONFIGMGPRIVATE:Int = $7FFF
	Const DBT_DEVICEARRIVAL:Int = $8000
	Const DBT_DEVICEQUERYREMOVE:Int = $8001
	Const DBT_DEVICEQUERYREMOVEFAILED:Int = $8002
	Const DBT_DEVICEREMOVEPENDING:Int = $8003
	Const DBT_DEVICEREMOVECOMPLETE:Int = $8004
	Const DBT_DEVICETYPESPECIFIC:Int = $8005
	Const DBT_DEVTYP_OEM:Int = 0
	Const DBT_DEVTYP_DEVNODE:Int = 1
	Const DBT_DEVTYP_VOLUME:Int = 2
	Const DBT_DEVTYP_PORT:Int = 3
	Const DBT_DEVTYP_NET:Int = 4
	Const DBT_DEVTYP_DEVICEINTERFACE:Int = 5
	Const DBT_DEVTYP_HANDLE:Int = 6
	Const DBT_APPYBEGIN:Int = 0
	Const DBT_APPYEND:Int = 1
	Const DBT_DEVNODES_CHANGED:Int = 7
	Const DBT_QUERYCHANGECONFIG:Int = $17
	Const DBT_CONFIGCHANGED:Int = $18
	Const DBT_CONFIGCHANGECANCELED:Int = $19
	Const DBT_MONITORCHANGE:Int = $1B
	Const DBT_SHELLLOGGEDON:Int = 32
	Const DBT_CONFIGMGAPI32:Int = 34
	Const DBT_VXDINITCOMPLETE:Int = 35
	Const DBT_VOLLOCKQUERYLOCK:Int = $8041
	Const DBT_VOLLOCKLOCKTAKEN:Int = $8042
	Const DBT_VOLLOCKLOCKFAILED:Int = $8043
	Const DBT_VOLLOCKQUERYUNLOCK:Int = $8044
	Const DBT_VOLLOCKLOCKRELEASED:Int = $8045
	Const DBT_VOLLOCKUNLOCKFAILED:Int = $8046
	Const DBT_USERDEFINED:Int = $FFFF

	Const DBTF_MEDIA:Int = 1
	Const DBTF_NET:Int = 2

	Const DEVICE_NOTIFY_WINDOW_HANDLE:Int = 0
	Const DEVICE_NOTIFY_SERVICE_HANDLE:Int = 1
	Const DEVICE_NOTIFY_ALL_INTERFACE_CLASSES:Int = 4

	Const GWL_WNDPROC:Int = -4
	Const WM_DESTROY:Int  = 2	

	Extern "Win32"
		Function SetWindowLong:Int(HWND:Int,nIndex:Int,dwNewLong:Int) = "SetWindowLongA@12"
		Function GetWindowLong:Int(HWND:Int,nIndex:Int) = "GetWindowLongA@8"	
		Function CallWindowProc:Int( prevwndproc:Int, hwnd:Int, msg:Int, wparam:Int, lparam:Int) = "CallWindowProcA@20"
	End Extern
	
	Extern	"C"
		Function EjectVolume:Int( WindowsText$z )
	End Extern
	
	Global OldWindowFunc:Int

	'---------------------------------------------------------------------
	Function _SetWindowFunc:Int( hwnd:Int, newfunc:Int( hwnd:Int, msg:Int, wparam:Int, lparam:Int))
	'---------------------------------------------------------------------
	
		Local oldfunc:Int = GetWindowLong( hwnd, GWL_WNDPROC)
		SetWindowLong( hwnd, GWL_WNDPROC, Int(Byte Ptr newfunc))
	
		Return oldfunc
	
	EndFunction
	

?MacOS
	Import "src/monitor.m"	

	Extern
		Function startListener()
		Function stopListener()
	End Extern
?

Extern

End Extern


Global wxEVT_VOLUME_REMOVED:Int = wxNewEventType()
Global wxEVT_VOLUME_INSERTED:Int = wxNewEventType()

