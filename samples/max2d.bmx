SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxmax2D


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

	Field canvas:wxWindow

	Method OnInit()
		
		canvas = MyCanvas(New MyCanvas.CreateWin(Self))
		
	End Method


End Type

Type MyCanvas Extends wxWindow

	Method OnInit()
		ConnectNoId(wxEVT_PAINT, OnPaint)
	End Method

	Function OnPaint(event:wxEvent)
'DebugLog "OnPaint"
'DebugStop
		Local canvas:MyCanvas = MyCanvas(event.parent)

		SetGraphics wxGraphics(canvas)
		
		Cls
'DebugStop
		DrawLine 50, 50, 100, 100
		DrawRect 150, 150, 100, 30
		
		Flip

	End Function

End Type

