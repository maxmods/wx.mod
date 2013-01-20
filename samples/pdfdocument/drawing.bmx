SuperStrict

Import wx.wxPdfDocument

' Drawing of geometric figures
'
' This example shows how to draw lines, rectangles, ellipses, polygons
' and curves with line style.
'
'
Function drawing()
	Local Pdf:wxPdfDocument = New wxPdfDocument.Create()
	Pdf.SetFont("Arial" ,"", 10)

	Pdf.AddPage()

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
	Pdf.Text(5, 7, "Line examples")
	Pdf.SetLineStyle(style)
	Pdf.Line(5, 10, 80, 30)
	Pdf.SetLineStyle(style2)
	Pdf.Line(5, 10, 5, 30)
	Pdf.SetLineStyle(style3)
	Pdf.Line(5, 10, 80, 10)
	
	' Rect
	Pdf.Text(100, 7, "Rectangle examples")
	Pdf.SetLineStyle(style5)
	Pdf.SetFillColour(New wxColour.Create(220, 220, 200))
	Pdf.Rect(100, 10, 40, 20, wxPDF_STYLE_FILLDRAW)
	Pdf.SetLineStyle(style3)
	Pdf.Rect(145, 10, 40, 20, wxPDF_STYLE_DRAW)
	
	' Curve
	Pdf.Text(5, 37, "Curve examples")
	Pdf.SetLineStyle(style6)
	Pdf.Curve(5, 40, 30, 55, 70, 45, 60, 75, wxPDF_STYLE_DRAW)
	Pdf.Curve(80, 40, 70, 75, 150, 45, 100, 75, wxPDF_STYLE_FILL)
	Pdf.SetFillColour(New wxColour.Create(200, 220, 200))
	Pdf.Curve(140, 40, 150, 55, 180, 45, 200, 75, wxPDF_STYLE_FILLDRAW)
	
	' Circle and ellipse
	Pdf.Text(5, 82, "Circle and ellipse examples")
	Pdf.SetLineStyle(style5)
	Pdf.Circle(25,105,20)
	Pdf.SetLineStyle(style6)
	Pdf.Circle(25,105,10, 90, 180, wxPDF_STYLE_DRAW)
	Pdf.Circle(25,105,10, 270, 360, wxPDF_STYLE_FILL)
	Pdf.Circle(25,105,10, 270, 360, wxPDF_STYLE_DRAWCLOSE)
	
	Pdf.SetLineStyle(style5)
	Pdf.Ellipse(100,105,40,20)
	Pdf.SetLineStyle(style6)
	Pdf.Ellipse(100,105,20,10, 0, 90, 180, wxPDF_STYLE_DRAW)
	Pdf.Ellipse(100,105,20,10, 0, 270, 360, wxPDF_STYLE_FILLDRAW)
	
	Pdf.SetLineStyle(style5)
	Pdf.Ellipse(175,105,30,15, 45)
	Pdf.SetLineStyle(style6)
	Pdf.Ellipse(175,105,15,7.50, 45, 90, 180, wxPDF_STYLE_DRAW)
	Pdf.SetFillColour(New wxColour.Create(220, 200, 200))
	Pdf.Ellipse(175,105,15,7.50, 45, 270, 360, wxPDF_STYLE_FILL)
	
	' Polygon
	Pdf.Text(5, 132, "Polygon examples")
	Pdf.SetLineStyle(style8)
	
	Local x1:Double[3], y1:Double[3]
	x1[0] =  5; y1[0] = 135
	x1[1] = 45; y1[1] = 135
	x1[2] = 15; y1[2] = 165
	Pdf.Polygon(x1, y1)
	
	Local x2:Double[5], y2:Double[5]
	x2[0] = 60; y2[0] = 135
	x2[1] = 80; y2[1] = 135
	x2[2] = 80; y2[2] = 155
	x2[3] = 70; y2[3] = 165
	x2[4] = 50; y2[4] = 155
	Pdf.SetLineStyle(style6)
	Pdf.Polygon(x2, y2, wxPDF_STYLE_FILLDRAW)
	
	Local x3:Double[4], y3:Double[4]
	x3[0] = 120; y3[0] = 135
	x3[1] = 140; y3[1] = 135
	x3[2] = 150; y3[2] = 155
	x3[3] = 110; y3[3] = 155
	Pdf.SetLineStyle(style7)
	Pdf.Polygon(x3, y3, wxPDF_STYLE_DRAW)
	
	Local x4:Double[5], y4:Double[5]
	x4[0] = 160; y4[0] = 135
	x4[1] = 190; y4[1] = 155
	x4[2] = 170; y4[2] = 155
	x4[3] = 200; y4[3] = 160
	x4[4] = 160; y4[4] = 165
	Pdf.SetLineStyle(style6)
	Pdf.SetFillColour(New wxColour.Create(220, 220, 220))
	Pdf.Polygon(x4, y4, wxPDF_STYLE_FILLDRAW)
	
	' Regular polygon
	Pdf.Text(5, 172, "Regular polygon examples")
	Pdf.SetLineStyle(style5)
	Pdf.RegularPolygon(20, 190, 15, 6, 0, 1, wxPDF_STYLE_FILL)
	Pdf.RegularPolygon(55, 190, 15, 6)
	Pdf.SetLineStyle(style7)
	Pdf.RegularPolygon(55, 190, 10, 6, 45, 0, wxPDF_STYLE_FILLDRAW)
	Pdf.SetLineStyle(style5)
	Pdf.SetFillColour(New wxColour.Create(200, 220, 200))
	Pdf.RegularPolygon(90, 190, 15, 3, 0, 1, wxPDF_STYLE_FILLDRAW, wxPDF_STYLE_FILL, ..
		Null, New wxPdfColour.Create(255, 200, 200))
	Pdf.RegularPolygon(125, 190, 15, 4, 30, 1, wxPDF_STYLE_DRAW, wxPDF_STYLE_DRAW, style6)
	Pdf.RegularPolygon(160, 190, 15, 10)
	
	' Star polygon
	Pdf.Text(5, 212, "Star polygon examples")
	Pdf.SetLineStyle(style5)
	Pdf.StarPolygon(20, 230, 15, 20, 3, 0, 1, wxPDF_STYLE_FILL)
	Pdf.StarPolygon(55, 230, 15, 12, 5)
	Pdf.SetLineStyle(style7)
	Pdf.StarPolygon(55, 230, 7, 12, 5, 45, 0, wxPDF_STYLE_FILLDRAW)
	Pdf.SetLineStyle(style5)
	Pdf.SetFillColour(New wxColour.Create(220, 220, 200))
	Pdf.StarPolygon(90, 230, 15, 20, 6, 0, 1, wxPDF_STYLE_FILLDRAW, wxPDF_STYLE_FILL, ..
		Null, New wxPdfColour.Create(255, 200, 200))
	Pdf.StarPolygon(125, 230, 15, 5, 2, 30, 1, wxPDF_STYLE_DRAW, wxPDF_STYLE_DRAW, style6)
	Pdf.StarPolygon(160, 230, 15, 10, 3)
	Pdf.StarPolygon(160, 230, 7, 50, 26)
	
	' Rounded rectangle
	Pdf.Text(5, 252, "Rounded rectangle examples")
	Pdf.SetLineStyle(style8)
	Pdf.RoundedRect(5, 255, 40, 30, 3.50, wxPDF_CORNER_ALL, wxPDF_STYLE_FILLDRAW)
	Pdf.RoundedRect(50, 255, 40, 30, 6.50, wxPDF_CORNER_TOP_LEFT)
	Pdf.SetLineStyle(style6)
	Pdf.RoundedRect(95, 255, 40, 30, 10.0, wxPDF_CORNER_ALL, wxPDF_STYLE_DRAW)
	Pdf.SetFillColour(New wxColour.Create(200, 200, 200))
	Pdf.RoundedRect(140, 255, 40, 30, 8.0, wxPDF_CORNER_TOP_RIGHT | wxPDF_CORNER_BOTTOM_RIGHT, wxPDF_STYLE_FILLDRAW)
	
	Pdf.AddPage()
	
	Pdf.SetFont("Arial", "B", 20)
	Pdf.SetLineWidth(1)
	
	Pdf.SetDrawColourCMYK(50, 0, 0, 0)
	Pdf.SetFillColourCMYK(100, 0, 0, 0)
	Pdf.SetTextColourCMYK(100, 0, 0, 0)
	Pdf.Rect(10, 10, 20, 20, wxPDF_STYLE_FILLDRAW)
	Pdf.Text(10, 40, "Cyan")
	
	Pdf.SetDrawColourCMYK(0, 50, 0, 0)
	Pdf.SetFillColourCMYK(0, 100, 0, 0)
	Pdf.SetTextColourCMYK(0, 100, 0, 0)
	Pdf.Rect(40, 10, 20, 20, wxPDF_STYLE_FILLDRAW)
	Pdf.Text(40, 40, "Magenta")
	
	Pdf.SetDrawColourCMYK(0, 0, 50, 0)
	Pdf.SetFillColourCMYK(0, 0, 100, 0)
	Pdf.SetTextColourCMYK(0, 0, 100, 0)
	Pdf.Rect(70, 10, 20, 20, wxPDF_STYLE_FILLDRAW)
	Pdf.Text(70, 40, "Yellow")
	
	Pdf.SetDrawColourCMYK(0, 0, 0, 50)
	Pdf.SetFillColourCMYK(0, 0, 0, 100)
	Pdf.SetTextColourCMYK(0, 0, 0, 100)
	Pdf.Rect(100, 10, 20, 20, wxPDF_STYLE_FILLDRAW)
	Pdf.Text(100, 40, "Black")
	
	Pdf.SetDrawColourRGB(128, 0, 0)
	Pdf.SetFillColourRGB(255, 0, 0)
	Pdf.SetTextColourRGB(255, 0, 0)
	Pdf.Rect(10, 50, 20, 20, wxPDF_STYLE_FILLDRAW)
	Pdf.Text(10, 80, "Red")
	
	Pdf.SetDrawColourRGB(0, 127, 0)
	Pdf.SetFillColourRGB(0, 255, 0)
	Pdf.SetTextColourRGB(0, 255, 0)
	Pdf.Rect(40, 50, 20, 20, wxPDF_STYLE_FILLDRAW)
	Pdf.Text(40, 80, "Green")
	
	Pdf.SetDrawColourRGB(0, 0, 127)
	Pdf.SetFillColourRGB(0, 0, 255)
	Pdf.SetTextColourRGB(0, 0, 255)
	Pdf.Rect(70, 50, 20, 20, wxPDF_STYLE_FILLDRAW)
	Pdf.Text(70, 80, "Blue")
	
	Pdf.SetDrawColourGrayscale(127)
	Pdf.SetFillColourGrayscale(0)
	Pdf.SetTextColourGrayscale(0)
	Pdf.Rect(10, 90, 20, 20, wxPDF_STYLE_FILLDRAW)
	Pdf.Text(10, 120, "Gray")
	
	Pdf.AddSpotColour("PANTONE 404 CVC", 0, 9.02, 23.14, 56.08)
	Pdf.SetFillColourName("PANTONE 404 CVC")
	Pdf.Rect(10, 130, 20, 20, wxPDF_STYLE_FILL)
	Pdf.Text(10, 160, "PANTONE 404 CVC")
	
	Pdf.AddPage()
	Pdf.SetFont("Arial", "", 10)
	Pdf.SetLineWidth(0.2)
	Pdf.SetDrawColourGrayscale(0)
	
	Pdf.Curve(25, 40, 50, 55, 90, 45, 80, 75, wxPDF_STYLE_DRAW)
	Local shape1:wxPdfShape = New wxPdfShape.Create()
	shape1.MoveTo(25,40)
	shape1.CurveTo(50, 55, 90, 45, 80, 75)
	Pdf.ShapedText(shape1, "This is a simple text string along a shaped line.")
	
	Pdf.Curve(80, 175, 90, 145, 50, 155, 25, 140, wxPDF_STYLE_DRAW)
	Local shape2:wxPdfShape = New wxPdfShape.Create()
	shape2.MoveTo(80, 175)
	shape2.CurveTo(90, 145, 50, 155, 25, 140)
	Pdf.ShapedText(shape2, "This is a simple text string along a shaped line.")
	
	Pdf.Curve(125, 40, 150, 55, 190, 45, 180, 75, wxPDF_STYLE_DRAW)
	Local shape3:wxPdfShape = New wxPdfShape.Create()
	shape3.MoveTo(125,40)
	shape3.CurveTo(150, 55, 190, 45, 180, 75)
	Pdf.ShapedText(shape3, "Repeat me! ", wxPDF_SHAPEDTEXTMODE_REPEAT)
	
	Local shape4:wxPdfShape = New wxPdfShape.Create()
	shape4.MoveTo(125, 130)
	shape4.LineTo(150, 130)
	shape4.LineTo(150, 150)
	shape4.ClosePath()
	shape4.MoveTo(125, 175)
	shape4.CurveTo(150, 145, 190, 155, 180, 140)
	Pdf.Shape(shape4, wxPDF_STYLE_FILL | wxPDF_STYLE_DRAWCLOSE)

	
	Pdf.SaveAsFile("drawing.pdf")
End Function





