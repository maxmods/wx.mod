SuperStrict

Import wx.wxPdfDocument

' Clipping
'
' This example shows several clipping options provided by wxPdfDocument.
' A clipping area restricts the display and prevents any elements from showing outside
' of it. 3 shapes are available: text, rectangle and ellipse. For each one, you can
' choose whether to draw the outline or not.

'
'
Function clipping()
	Local pdf:wxPdfDocument = New wxPdfDocument.Create()
	pdf.AddPage()
	
	' example of clipped cell
	pdf.SetFont("Arial" ,"", 14)
	pdf.SetX(72)
	pdf.ClippedCell(60,6,"These are clipping examples", wxPDF_BORDER_FRAME)
	
	' example of clipping text
	pdf.SetFont("Arial", "B", 120)
	'set the outline color
	pdf.SetDrawColorGrayScale(0)
	' set the outline width (note that only its outer half will be shown)
	pdf.SetLineWidth(2)
	' draw the clipping text
	pdf.ClippingText(40,55, "CLIPS", True)
	'fill it with the image
	pdf.Image("../media/pdfdocument/clips.jpg",40,10,130)
	' remove the clipping
	pdf.UnsetClipping()
	
	' example of clipping rectangle
	pdf.ClippingRect(45,65,116,20,True)
	pdf.Image("../media/pdfdocument/clips.jpg",40,10,130)
	pdf.UnsetClipping()
	
	' example of clipping ellipse
	pdf.ClippingEllipse(102,104,16,10,True)
	pdf.Image("../media/pdfdocument/clips.jpg", 40, 10, 130)
	pdf.UnsetClipping()
	
	' example of clipping polygon
	Local x:Double[5], y:Double[5]
	x[0] = 30; y[0] = 135
	x[1] = 60; y[1] = 155
	x[2] = 40; y[2] = 155
	x[3] = 70; y[3] = 160
	x[4] = 30; y[4] = 165
	
	pdf.ClippingPolygon(x, y, True)
	pdf.Image("../media/pdfdocument/clips.jpg",20,100,130)
	pdf.UnsetClipping()
	
	' example of clipping using a shape
	Local shape:wxPdfShape = New wxPdfShape.Create()
	shape.MoveTo(135,140)
	shape.CurveTo(135,137,130,125,110,125)
	shape.CurveTo(80,125,80,162.5,80,162.5)
	shape.CurveTo(80,180,100,202,135,220)
	shape.CurveTo(170,202,190,180,190,162.5)
	shape.CurveTo(190,162.5,190,125,160,125)
	shape.CurveTo(145,125,135,137,135,140)
	
	pdf.SetLineWidth(1)
	pdf.SetFillColorPdf(New wxPdfColour.CreateNamedColour("red"))
	pdf.ClippingPathShape(shape, wxPDF_STYLE_FILLDRAW)
	pdf.UnsetClipping()

	pdf.SaveAsFile("clipping.pdf")
End Function




