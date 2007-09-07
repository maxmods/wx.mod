'
' wxTimer example
'
' Creates a custom timer type, overriding the Notify() method.
'
'
SuperStrict

Framework wx.wxApp
Import wx.wxTimer
Import BRL.StandardIO

Type MyApp Extends wxApp

	Field timer:MyTimer

	Method OnInit:Int()

		timer = MyTimer(New MyTimer.Create())
		timer.Start(100)
	
		Return True
	
	End Method

End Type

Type MyTimer Extends wxTimer

	Field count:Int

	Method Notify()	
		count:+1
		
		Print "Tick (" + count + ")"
		
		If count = 50 Then
			End
		End If
		
	End Method

End Type

New MyApp.run()
