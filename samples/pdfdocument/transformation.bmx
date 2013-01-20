SuperStrict

Import wx.wxPdfDocument

' Transformations
' 
' This example shows the effects of various geometric transformations.

'
Function transformation()
	Local Pdf:wxPdfDocument = New wxPdfDocument.Create()
	Pdf.AddPage()
	Pdf.SetFont("Arial", "", 16)
	
	' Scaling
	Pdf.SetDrawColourGrayScale(200)
	Pdf.SetTextColourGrayScale(200)
	Pdf.Rect(50, 20, 40, 10, wxPDF_STYLE_DRAW)
	Pdf.Text(50, 19, "Scale")
	Pdf.SetDrawColourGrayScale(0)
	Pdf.SetTextColourGrayScale(0)
	' Start Transformation
	Pdf.StartTransform()
	' Scale by 150% centered by (50,30) which is the lower left corner of the rectangle
	Pdf.ScaleXY(150, 50, 30)
	Pdf.Rect(50, 20, 40, 10, wxPDF_STYLE_DRAW)
	Pdf.Text(50, 19, "Scale")
	' Stop Transformation
	Pdf.StopTransform()
	
	' Translation
	Pdf.SetDrawColourGrayScale(200)
	Pdf.SetTextColourGrayScale(200)
	Pdf.Rect(125, 20, 40, 10, wxPDF_STYLE_DRAW)
	Pdf.Text(125, 19, "Translate")
	Pdf.SetDrawColourGrayScale(0)
	Pdf.SetTextColourGrayScale(0)
	' Start Transformation
	Pdf.StartTransform()
	' Translate 20 to the right, 15 to the bottom
	Pdf.Translate(20, 15)
	Pdf.Rect(125, 20, 40, 10, wxPDF_STYLE_DRAW)
	Pdf.Text(125, 19, "Translate")
	' Stop Transformation
	Pdf.StopTransform()
	
	'Rotation
	Pdf.SetDrawColourGrayScale(200)
	Pdf.SetTextColourGrayScale(200)
	Pdf.Rect(50, 50, 40, 10, wxPDF_STYLE_DRAW)
	Pdf.Text(50, 49, "Rotate")
	Pdf.SetDrawColourGrayScale(0)
	Pdf.SetTextColourGrayScale(0)
	' Start Transformation
	Pdf.StartTransform()
	' Rotate 20 degrees counter-clockwise centered by (50,60)
	' which is the lower left corner of the rectangle
	Pdf.Rotate(20, 50, 60)
	Pdf.Rect(50, 50, 40, 10, wxPDF_STYLE_DRAW)
	Pdf.Text(50, 49, "Rotate")
	' Stop Transformation
	Pdf.StopTransform()
	
	' Skewing
	Pdf.SetDrawColourGrayScale(200)
	Pdf.SetTextColourGrayScale(200)
	Pdf.Rect(125, 50, 40, 10, wxPDF_STYLE_DRAW)
	Pdf.Text(125, 49, "Skew")
	Pdf.SetDrawColourGrayScale(0)
	Pdf.SetTextColourGrayScale(0)
	' Start Transformation
	Pdf.StartTransform()
	' skew 30 degrees along the x-axis centered by (125,60)
	' which is the lower left corner of the rectangle
	Pdf.SkewX(30, 125, 60)
	Pdf.Rect(125, 50, 40, 10, wxPDF_STYLE_DRAW)
	Pdf.Text(125, 49, "Skew")
	' Stop Transformation
	Pdf.StopTransform()
	
	' Mirroring horizontally
	Pdf.SetDrawColourGrayScale(200)
	Pdf.SetTextColourGrayScale(200)
	Pdf.Rect(50, 80, 40, 10, wxPDF_STYLE_DRAW)
	Pdf.Text(50, 79, "MirrorH")
	Pdf.SetDrawColourGrayScale(0)
	Pdf.SetTextColourGrayScale(0)
	' Start Transformation
	Pdf.StartTransform()
	' mirror horizontally with axis of reflection at x-position 50 (left side of the rectangle)
	Pdf.MirrorH(50)
	Pdf.Rect(50, 80, 40, 10, wxPDF_STYLE_DRAW)
	Pdf.Text(50, 79, "MirrorH")
	' Stop Transformation
	Pdf.StopTransform()
	
	' Mirroring vertically
	Pdf.SetDrawColourGrayScale(200)
	Pdf.SetTextColourGrayScale(200)
	Pdf.Rect(125, 80, 40, 10, wxPDF_STYLE_DRAW)
	Pdf.Text(125, 79, "MirrorV")
	Pdf.SetDrawColourGrayScale(0)
	Pdf.SetTextColourGrayScale(0)
	' Start Transformation
	Pdf.StartTransform()
	' mirror vertically with axis of reflection at y-position 90 (bottom side of the rectangle)
	Pdf.MirrorV(90)
	Pdf.Rect(125, 80, 40, 10, wxPDF_STYLE_DRAW)
	Pdf.Text(125, 79, "MirrorV")
	' Stop Transformation
	Pdf.StopTransform()

	
	Pdf.SaveAsFile("transformation.pdf")
End Function


