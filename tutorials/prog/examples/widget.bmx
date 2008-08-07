SuperStrict
 
Import wx.wxPanel
 
Global num:Int[] = [75, 150, 225, 300, 375, 450, 525, 600, 675 ]

Type Widget Extends wxPanel
 
	Field m_parent:wxPanel
	Field cur_width:Int

	Method Create:Widget(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxTAB_TRAVERSAL)
		Return Widget(Super.Create(parent, id, x, y, w, 30, wxSUNKEN_BORDER))
	End Method
 
	Method OnInit()
		m_parent = wxPanel(GetParent())
		
		ConnectAny(wxEVT_PAINT, OnPaint)
		ConnectAny(wxEVT_SIZE, OnSize)
	End Method
	
	Method SetCurWidth(width:Int)
		cur_width = width
	End Method
 
	Function OnSize(event:wxEvent)
		Local panel:Widget = Widget(event.parent)
		panel.Refresh()
	End Function
 
	Function OnPaint(event:wxEvent)
		Local panel:Widget = Widget(event.parent)
		
		Local font:wxFont = New wxFont.CreateWithAttribs(9, wxFONTFAMILY_DEFAULT, ..
			wxFONTSTYLE_NORMAL, wxFONTWEIGHT_NORMAL, False, ..
			"Courier 10 Pitch")
		
		Local dc:wxPaintDC = New wxPaintDC.Create(panel)
		dc.SetFont(font)
		
		Local width:Int, height:Int
		panel.GetSize(width, height)
		
		Local stepSize:Int = width / 10.0
		
		Local till:Int = ((width / 750.0) * panel.cur_width)
		Local full:Int = ((width / 750.0) * 700)
		
		
		If panel.cur_width >= 700 Then
		
			dc.SetPen(New wxPen.CreateFromColour( ..
				New wxColour.Create(255, 255, 184)))
			dc.SetBrush(New wxBrush.CreateFromColour( ..
				New wxColour.Create(255, 255, 184)))
			dc.DrawRectangle(0, 0, full, 30)
			dc.SetPen(New wxPen.CreateFromColour( ..
				New wxColour.Create(255, 175, 175)))
			dc.SetBrush(New wxBrush.CreateFromColour( ..
				New wxColour.Create(255, 175, 175)))
			dc.DrawRectangle(full, 0, till - full, 30)

		Else

			dc.SetPen(New wxPen.CreateFromColour( ..
				New wxColour.Create(255, 255, 184)))
			dc.SetBrush(New wxBrush.CreateFromColour( ..
				New wxColour.Create(255, 255, 184)))
			dc.DrawRectangle(0, 0, till, 30)
			
		End If

		dc.SetPen(New wxPen.CreateFromColour(New wxColour.Create(90, 80, 60)))
		
		For Local i:Int = 1 To num.length
			dc.DrawLine(i * stepSize, 0, i * stepSize, 6)
			dc.GetTextExtent(num[i-1], width, height)
			dc.DrawText(num[i-1], i * stepsize - width/2, 8)
		Next

		dc.Free()

	End Function
 
End Type


