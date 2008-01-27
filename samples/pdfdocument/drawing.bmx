SuperStrict

Import wx.wxPdfDocument

' Drawing of geometric figures
'
' This example shows how to draw lines, rectangles, ellipses, polygons
' and curves with line style.
'
'
Function drawing()
	Local pdf:wxPdfDocument = New wxPdfDocument.Create()
	pdf.SetFont("Arial" ,"", 10)

	pdf.AddPage()

	Local dash1:Double[] = [10:Double, 20:Double, 5:Double, 10:Double]
	Local style:wxPdfLineStyle = New wxPdfLineStyle.Create(0.5, wxPDF_LINECAP_BUTT, ..
		wxPDF_LINEJOIN_MITER, dash1, 10, New wxPdfColour.Create(255, 0, 0))
	
	Local dash2:Double[]
	Local style2:wxPdfLineStyle = New wxPdfLineStyle.Create(0.5, wxPDF_LINECAP_BUTT, ..
		wxPDF_LINEJOIN_MITER, dash2, 0, New wxPdfColour.Create(255, 0, 0))
	
	Local dash3:Double[] = [2:Double, 10:Double]
	Local style3:wxPdfLineStyle = New wxPdfLineStyle.Create(1.0, wxPDF_LINECAP_ROUND, ..
		wxPDF_LINEJOIN_ROUND, dash3, 0, New wxPdfColour.Create(255, 0, 0))
	
	Local style4:wxPdfLineStyle = New wxPdfLineStyle.Create(0.5, wxPDF_LINECAP_BUTT, ..
		wxPDF_LINEJOIN_MITER, dash1, 10, New wxPdfColour.Create(255, 0, 0))
	
	Local dash5:Double[]
	Local style5:wxPdfLineStyle = New wxPdfLineStyle.Create(0.25, wxPDF_LINECAP_BUTT, ..
		wxPDF_LINEJOIN_MITER, dash5, 0, New wxPdfColour.Create(0, 0, 0))
	
	Local dash6:Double[] = [10:Double, 10:Double]
	Local style6:wxPdfLineStyle = New wxPdfLineStyle.Create(0.5, wxPDF_LINECAP_BUTT, ..
		wxPDF_LINEJOIN_MITER, dash6, 0, New wxPdfColour.Create(0, 255, 0))
	
	Local dash7:Double[]
	Local style7:wxPdfLineStyle = New wxPdfLineStyle.Create(0.5, wxPDF_LINECAP_BUTT, ..
		wxPDF_LINEJOIN_MITER, dash7, 10, New wxPdfColour.Create(200, 200, 0))
	
	Local dash8:Double[]
	Local style8:wxPdfLineStyle = New wxPdfLineStyle.Create(0.5, wxPDF_LINECAP_BUTT, ..
		wxPDF_LINEJOIN_MITER, dash8, 0, New wxPdfColour.Create(0, 0, 0))

	' Line
	pdf.Text(5, 7, "Line examples")
	pdf.SetLineStyle(style)
	pdf.Line(5, 10, 80, 30)
	pdf.SetLineStyle(style2)
	pdf.Line(5, 10, 5, 30)
	pdf.SetLineStyle(style3)
	pdf.Line(5, 10, 80, 10)
	
	' Rect
	pdf.Text(100, 7, "Rectangle examples")
	pdf.SetLineStyle(style5)
	pdf.SetFillColor(New wxColour.Create(220, 220, 200))
	pdf.Rect(100, 10, 40, 20, wxPDF_STYLE_FILLDRAW)
	pdf.SetLineStyle(style3)
	pdf.Rect(145, 10, 40, 20, wxPDF_STYLE_DRAW)
	
	' Curve
	pdf.Text(5, 37, "Curve examples")
	pdf.SetLineStyle(style6)
	pdf.Curve(5, 40, 30, 55, 70, 45, 60, 75, wxPDF_STYLE_DRAW)
	pdf.Curve(80, 40, 70, 75, 150, 45, 100, 75, wxPDF_STYLE_FILL)
	pdf.SetFillColor(New wxColour.Create(200, 220, 200))
	pdf.Curve(140, 40, 150, 55, 180, 45, 200, 75, wxPDF_STYLE_FILLDRAW)
	
	' Circle and ellipse
	pdf.Text(5, 82, "Circle and ellipse examples")
	pdf.SetLineStyle(style5)
	pdf.Circle(25,105,20)
	pdf.SetLineStyle(style6)
	pdf.Circle(25,105,10, 90, 180, wxPDF_STYLE_DRAW)
	pdf.Circle(25,105,10, 270, 360, wxPDF_STYLE_FILL)
	pdf.Circle(25,105,10, 270, 360, wxPDF_STYLE_DRAWCLOSE)
	
	pdf.SetLineStyle(style5)
	pdf.Ellipse(100,105,40,20)
	pdf.SetLineStyle(style6)
	pdf.Ellipse(100,105,20,10, 0, 90, 180, wxPDF_STYLE_DRAW)
	pdf.Ellipse(100,105,20,10, 0, 270, 360, wxPDF_STYLE_FILLDRAW)
	
	pdf.SetLineStyle(style5)
	pdf.Ellipse(175,105,30,15, 45)
	pdf.SetLineStyle(style6)
	pdf.Ellipse(175,105,15,7.50, 45, 90, 180, wxPDF_STYLE_DRAW)
	pdf.SetFillColor(New wxColour.Create(220, 200, 200))
	pdf.Ellipse(175,105,15,7.50, 45, 270, 360, wxPDF_STYLE_FILL)
	
	' Polygon
	pdf.Text(5, 132, "Polygon examples")
	pdf.SetLineStyle(style8)
	
	Local x1:Double[3], y1:Double[3]
	x1[0] =  5; y1[0] = 135
	x1[1] = 45; y1[1] = 135
	x1[2] = 15; y1[2] = 165
	pdf.Polygon(x1, y1)
	
	Local x2:Double[5], y2:Double[5]
	x2[0] = 60; y2[0] = 135
	x2[1] = 80; y2[1] = 135
	x2[2] = 80; y2[2] = 155
	x2[3] = 70; y2[3] = 165
	x2[4] = 50; y2[4] = 155
	pdf.SetLineStyle(style6)
	pdf.Polygon(x2, y2, wxPDF_STYLE_FILLDRAW)
	
	Local x3:Double[4], y3:Double[4]
	x3[0] = 120; y3[0] = 135
	x3[1] = 140; y3[1] = 135
	x3[2] = 150; y3[2] = 155
	x3[3] = 110; y3[3] = 155
	pdf.SetLineStyle(style7)
	pdf.Polygon(x3, y3, wxPDF_STYLE_DRAW)
	
	Local x4:Double[5], y4:Double[5]
	x4[0] = 160; y4[0] = 135
	x4[1] = 190; y4[1] = 155
	x4[2] = 170; y4[2] = 155
	x4[3] = 200; y4[3] = 160
	x4[4] = 160; y4[4] = 165
	pdf.SetLineStyle(style6)
	pdf.SetFillColor(New wxColour.Create(220, 220, 220))
	pdf.Polygon(x4, y4, wxPDF_STYLE_FILLDRAW)
	
	' Regular polygon
	pdf.Text(5, 172, "Regular polygon examples")
	pdf.SetLineStyle(style5)
	pdf.RegularPolygon(20, 190, 15, 6, 0, 1, wxPDF_STYLE_FILL)
	pdf.RegularPolygon(55, 190, 15, 6)
	pdf.SetLineStyle(style7)
	pdf.RegularPolygon(55, 190, 10, 6, 45, 0, wxPDF_STYLE_FILLDRAW)
	pdf.SetLineStyle(style5)
	pdf.SetFillColor(New wxColour.Create(200, 220, 200))
	pdf.RegularPolygon(90, 190, 15, 3, 0, 1, wxPDF_STYLE_FILLDRAW, wxPDF_STYLE_FILL, ..
		Null, New wxPdfColour.Create(255, 200, 200))
	pdf.RegularPolygon(125, 190, 15, 4, 30, 1, wxPDF_STYLE_DRAW, wxPDF_STYLE_DRAW, style6)
	pdf.RegularPolygon(160, 190, 15, 10)
	
	' Star polygon
	pdf.Text(5, 212, "Star polygon examples")
	pdf.SetLineStyle(style5)
	pdf.StarPolygon(20, 230, 15, 20, 3, 0, 1, wxPDF_STYLE_FILL)
	pdf.StarPolygon(55, 230, 15, 12, 5)
	pdf.SetLineStyle(style7)
	pdf.StarPolygon(55, 230, 7, 12, 5, 45, 0, wxPDF_STYLE_FILLDRAW)
	pdf.SetLineStyle(style5)
	pdf.SetFillColor(New wxColour.Create(220, 220, 200))
	pdf.StarPolygon(90, 230, 15, 20, 6, 0, 1, wxPDF_STYLE_FILLDRAW, wxPDF_STYLE_FILL, ..
		Null, New wxPdfColour.Create(255, 200, 200))
	pdf.StarPolygon(125, 230, 15, 5, 2, 30, 1, wxPDF_STYLE_DRAW, wxPDF_STYLE_DRAW, style6)
	pdf.StarPolygon(160, 230, 15, 10, 3)
	pdf.StarPolygon(160, 230, 7, 50, 26)
	
	' Rounded rectangle
	pdf.Text(5, 252, "Rounded rectangle examples")
	pdf.SetLineStyle(style8)
	pdf.RoundedRect(5, 255, 40, 30, 3.50, wxPDF_CORNER_ALL, wxPDF_STYLE_FILLDRAW)
	pdf.RoundedRect(50, 255, 40, 30, 6.50, wxPDF_CORNER_TOP_LEFT)
	pdf.SetLineStyle(style6)
	pdf.RoundedRect(95, 255, 40, 30, 10.0, wxPDF_CORNER_ALL, wxPDF_STYLE_DRAW)
	pdf.SetFillColor(New wxColour.Create(200, 200, 200))
	pdf.RoundedRect(140, 255, 40, 30, 8.0, wxPDF_CORNER_TOP_RIGHT | wxPDF_CORNER_BOTTOM_RIGHT, wxPDF_STYLE_FILLDRAW)
	
	pdf.AddPage()
	
	pdf.SetFont("Arial", "B", 20)
	pdf.SetLineWidth(1)
	
	pdf.SetDrawColorCMYK(50, 0, 0, 0)
	pdf.SetFillColorCMYK(100, 0, 0, 0)
	pdf.SetTextColorCMYK(100, 0, 0, 0)
	pdf.Rect(10, 10, 20, 20, wxPDF_STYLE_FILLDRAW)
	pdf.Text(10, 40, "Cyan")
	
	pdf.SetDrawColorCMYK(0, 50, 0, 0)
	pdf.SetFillColorCMYK(0, 100, 0, 0)
	pdf.SetTextColorCMYK(0, 100, 0, 0)
	pdf.Rect(40, 10, 20, 20, wxPDF_STYLE_FILLDRAW)
	pdf.Text(40, 40, "Magenta")
	
	pdf.SetDrawColorCMYK(0, 0, 50, 0)
	pdf.SetFillColorCMYK(0, 0, 100, 0)
	pdf.SetTextColorCMYK(0, 0, 100, 0)
	pdf.Rect(70, 10, 20, 20, wxPDF_STYLE_FILLDRAW)
	pdf.Text(70, 40, "Yellow")
	
	pdf.SetDrawColorCMYK(0, 0, 0, 50)
	pdf.SetFillColorCMYK(0, 0, 0, 100)
	pdf.SetTextColorCMYK(0, 0, 0, 100)
	pdf.Rect(100, 10, 20, 20, wxPDF_STYLE_FILLDRAW)
	pdf.Text(100, 40, "Black")
	
	pdf.SetDrawColorRGB(128, 0, 0)
	pdf.SetFillColorRGB(255, 0, 0)
	pdf.SetTextColorRGB(255, 0, 0)
	pdf.Rect(10, 50, 20, 20, wxPDF_STYLE_FILLDRAW)
	pdf.Text(10, 80, "Red")
	
	pdf.SetDrawColorRGB(0, 127, 0)
	pdf.SetFillColorRGB(0, 255, 0)
	pdf.SetTextColorRGB(0, 255, 0)
	pdf.Rect(40, 50, 20, 20, wxPDF_STYLE_FILLDRAW)
	pdf.Text(40, 80, "Green")
	
	pdf.SetDrawColorRGB(0, 0, 127)
	pdf.SetFillColorRGB(0, 0, 255)
	pdf.SetTextColorRGB(0, 0, 255)
	pdf.Rect(70, 50, 20, 20, wxPDF_STYLE_FILLDRAW)
	pdf.Text(70, 80, "Blue")
	
	pdf.SetDrawColorGrayscale(127)
	pdf.SetFillColorGrayscale(0)
	pdf.SetTextColorGrayscale(0)
	pdf.Rect(10, 90, 20, 20, wxPDF_STYLE_FILLDRAW)
	pdf.Text(10, 120, "Gray")
	
	pdf.AddSpotColor("PANTONE 404 CVC", 0, 9.02, 23.14, 56.08)
	pdf.SetFillColorName("PANTONE 404 CVC")
	pdf.Rect(10, 130, 20, 20, wxPDF_STYLE_FILL)
	pdf.Text(10, 160, "PANTONE 404 CVC")
	
	pdf.AddPage()
	pdf.SetFont("Arial", "", 10)
	pdf.SetLineWidth(0.2)
	pdf.SetDrawColorGrayscale(0)
	
	pdf.Curve(25, 40, 50, 55, 90, 45, 80, 75, wxPDF_STYLE_DRAW)
	Local shape1:wxPdfShape = New wxPdfShape.Create()
	shape1.MoveTo(25,40)
	shape1.CurveTo(50, 55, 90, 45, 80, 75)
	pdf.ShapedText(shape1, "This is a simple text string along a shaped line.")
	
	pdf.Curve(80, 175, 90, 145, 50, 155, 25, 140, wxPDF_STYLE_DRAW)
	Local shape2:wxPdfShape = New wxPdfShape.Create()
	shape2.MoveTo(80, 175)
	shape2.CurveTo(90, 145, 50, 155, 25, 140)
	pdf.ShapedText(shape2, "This is a simple text string along a shaped line.")
	
	pdf.Curve(125, 40, 150, 55, 190, 45, 180, 75, wxPDF_STYLE_DRAW)
	Local shape3:wxPdfShape = New wxPdfShape.Create()
	shape3.MoveTo(125,40)
	shape3.CurveTo(150, 55, 190, 45, 180, 75)
	pdf.ShapedText(shape3, "Repeat me! ", wxPDF_SHAPEDTEXTMODE_REPEAT)
	
	Local shape4:wxPdfShape = New wxPdfShape.Create()
	shape4.MoveTo(125, 130)
	shape4.LineTo(150, 130)
	shape4.LineTo(150, 150)
	shape4.ClosePath()
	shape4.MoveTo(125, 175)
	shape4.CurveTo(150, 145, 190, 155, 180, 140)
	pdf.Shape(shape4, wxPDF_STYLE_FILL | wxPDF_STYLE_DRAWCLOSE)

	
	pdf.SaveAsFile("drawing.pdf")
End Function





