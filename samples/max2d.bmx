SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxmax2D
Import wx.wxTimer


New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		' Create the main application windowType MyFrame Extends wxFrame

		frame = MyFrame(New MyFrame.Create(,,"", , , 640, 480))
		
		' Show it and tell the application that it's our main window
		frame.show(True)
		SetTopWindow(frame)

		Return True
	End Method

End Type

Type MyFrame Extends wxFrame

	Field canvas:MyCanvas

	Method OnInit()
		
		canvas = MyCanvas(New MyCanvas.CreateWin(Self))
		
		ConnectAny(wxEVT_CLOSE, OnClose)
	End Method

	Function OnClose(event:wxEvent)
	
		MyFrame(event.parent).canvas.timer.Stop() ' stop the timer!
		wxWindow(event.parent).Destroy() ' remove the frame
	
	End Function

End Type

Type MyCanvas Extends wxWindow

	Field timer:wxTimer

	Method OnInit()
		SetBackgroundStyle(wxBG_STYLE_CUSTOM)
	
		timer = New wxTimer.Create(Self)


		ConnectAny(wxEVT_PAINT, OnPaint)
		ConnectAny(wxEVT_TIMER, OnTick)

		timer.Start(30)
	End Method

	Function OnPaint(event:wxEvent)
		Local canvas:MyCanvas = MyCanvas(event.parent)

		SetGraphics wxGraphics(canvas)
		
		SetColor(0, 0, 0)
		
		Cls

		canvas.drawClock()
		
		Flip

	End Function

	Function OnTick(event:wxEvent)
		wxWindow(event.parent).Refresh()
	End Function
	
	
	Method drawClock()
	
		SetLineWidth(2)

		Local x:Int = 200, y:Int = 200
		Local radius:Int = 100
		' clock ticks
		For Local i:Int = 0 Until 12
			Local inset:Double = 0
		
			If i Mod 3 = 0 Then
				SetLineWidth(2)
				inset = 0.2 * radius
			Else
				inset = 0.1 * radius
				SetLineWidth(1)
			End If
			
			DrawLine x + (radius - inset) * Cos(i * 30), y + (radius - inset) * Sin(i * 30), ..
				x + radius * Cos(i * 30), y + radius * Sin (i * 30)
			
			' draw numbers
			inset = 0.3 * radius
			
			Local t:Int = (i + 2) Mod 12 + 1
			DrawText romanNumerals(t), x + (radius - inset) * Cos(i * 30) - 7, y + (radius - inset) * Sin(i * 30) - 6
		Next


		' clock hands
		Local hours:Int = CurrentTime()[0..2].toInt() Mod 12
		Local minutes:Int = CurrentTime()[3..5].toInt()
		Local seconds:Int = CurrentTime()[6..8].toInt()
		
		' hour hand:
		' the hour hand is rotated 30 degrees  per hour + 1/2 a degree per minute
		'
		SetLineWidth(4)

		DrawLine x, y, x + radius / 2 * Sin(30 * hours + minutes / 2.0), ..
				   y + radius / 2 * -Cos(30 * hours + minutes / 2.0)
		
		
		' minute hand:
		' the minute hand is rotated 6 degrees per minute + 1/10 a degree per second
		'
		SetLineWidth(2)
		DrawLine x, y, x + radius * 0.75 * Sin(6 * minutes + seconds / 10.0), ..
				   y + radius * 0.75 * -Cos(6 * minutes + seconds / 10.0)
		
		' seconds hand:
		' the second hand is rotated 6 degrees per second
		'
		SetColor(255, 0, 0)

		DrawLine x, y, x + radius * 0.7 * Sin(6 * seconds), ..
				   y + radius * 0.7 * -Cos(6 * seconds)


	End Method

	Method romanNumerals:String(value:Int)
		Local rn:String = ""
		
		While value > 9
			rn:+ "X"
			value:- 10
		Wend
	
		If value > 8 Then
			rn:+ "IX"
			value:- 9
		End If
		
		If value > 4 Then
			rn:+ "V"
			value:- 5
		End If
		
		If value > 3 Then
			rn:+ "IV"
			value:- 4
		End If
		
		While value > 0
			rn:+ "I"
			value:- 1
		Wend
		
		Return rn
	End Method

End Type

