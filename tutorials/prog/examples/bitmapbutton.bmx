SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxSlider
Import wx.wxBitmapButton
Import wx.wxPanel

Const ID_SLIDER:Int = 100

New MyApp.Run()

Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local bb:BitmapButton = BitmapButton(New BitmapButton.Create(Null, wxID_ANY, "BitmapButton", -1, -1, 250, 130))
		bb.Show(True)

		Return True
	End Method

End Type

Type BitmapButton Extends wxFrame

	Field slider:wxSlider
	Field button:wxBitmapButton
	Field pos:Int
	
	Method OnInit()

		wxImage.AddHandler( New wxPNGHandler )
		
		Local panel:wxPanel = New wxPanel.Create(Self, wxID_ANY)
		slider = New wxSlider.Create(panel, ID_SLIDER, 0, 0, 100, 10, 30, 140, -1)

		button = New wxBitmapButton.Create(panel, wxID_ANY, ..
			wxBitmap.CreateFromFile("../media/mute.png", wxBITMAP_TYPE_PNG), 180, 20)

		Connect(ID_SLIDER, wxEVT_COMMAND_SLIDER_UPDATED, OnScroll)

		Centre()

	End Method
	
	Function OnScroll(event:wxEvent)
		Local frame:BitmapButton = BitmapButton(event.parent)
	
		frame.pos = frame.slider.GetValue()
		
		If frame.pos = 0 Then
			frame.button.SetBitmapLabel(wxBitmap.CreateFromFile("../media/mute.png", wxBITMAP_TYPE_PNG))
		Else If frame.pos > 0 And frame.pos <= 30 Then
			frame.button.SetBitmapLabel(wxBitmap.CreateFromFile("../media/min.png", wxBITMAP_TYPE_PNG))
		Else If frame.pos > 30 And frame.pos < 80 Then
			frame.button.SetBitmapLabel(wxBitmap.CreateFromFile("../media/med.png", wxBITMAP_TYPE_PNG))
		Else
			frame.button.SetBitmapLabel(wxBitmap.CreateFromFile("../media/max.png", wxBITMAP_TYPE_PNG))
		End If


	End Function

End Type