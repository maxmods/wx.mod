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
	Local Pdf:wxPdfDocument = New wxPdfDocument.Create()
	Pdf.AddPage()
	
	' example of clipped cell
	Pdf.SetFont("Arial" ,"", 14)
	Pdf.SetX(72)
	Pdf.ClippedCell(60,6,"These are clipping examples", wxPDF_BORDER_FRAME)
	
	' example of clipping text
	Pdf.SetFont("Arial", "B", 120)
	'set the outline colour
	Pdf.SetDrawColourGrayScale(0)
	' set the outline width (note that only its outer half will be shown)
	Pdf.SetLineWidth(2)
	' draw the clipping text
	Pdf.ClippingText(40,55, "CLIPS", True)
	'fill it with the image
	Pdf.Image("../media/pdfdocument/clips.jpg",40,10,130)
	' remove the clipping
	Pdf.UnsetClipping()
	
	' example of clipping rectangle
	Pdf.ClippingRect(45,65,116,20,True)
	Pdf.Image("../media/pdfdocument/clips.jpg",40,10,130)
	Pdf.UnsetClipping()
	
	' example of clipping ellipse
	Pdf.ClippingEllipse(102,104,16,10,True)
	Pdf.Image("../media/pdfdocument/clips.jpg", 40, 10, 130)
	Pdf.UnsetClipping()
	
	' example of clipping polygon
	Local x:Double[5], y:Double[5]
	x[0] = 30; y[0] = 135
	x[1] = 60; y[1] = 155
	x[2] = 40; y[2] = 155
	x[3] = 70; y[3] = 160
	x[4] = 30; y[4] = 165
	
	Pdf.ClippingPolygon(x, y, True)
	Pdf.Image("../media/pdfdocument/clips.jpg",20,100,130)
	Pdf.UnsetClipping()
	
	' example of clipping using a shape
	Local shape:wxPdfShape = New wxPdfShape.Create()
	shape.MoveTo(135,140)
	shape.CurveTo(135,137,130,125,110,125)
	shape.CurveTo(80,125,80,162.5,80,162.5)
	shape.CurveTo(80,180,100,202,135,220)
	shape.CurveTo(170,202,190,180,190,162.5)
	shape.CurveTo(190,162.5,190,125,160,125)
	shape.CurveTo(145,125,135,137,135,140)
	
	Pdf.SetLineWidth(1)
	Pdf.SetFillColourPdf(New wxPdfColour.CreateNamedColour("red"))
	Pdf.ClippingPathShape(shape, wxPDF_STYLE_FILLDRAW)
	Pdf.UnsetClipping()

	Pdf.SaveAsFile("clipping.pdf")
End Function




