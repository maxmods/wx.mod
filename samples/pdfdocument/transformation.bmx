SuperStrict

Import wx.wxPdfDocument

' Transformations
' 
' This example shows the effects of various geometric transformations.

'
Function transformation()
	Local pdf:wxPdfDocument = New wxPdfDocument.Create()
	pdf.AddPage()
	pdf.SetFont("Arial", "", 16)
	
	' Scaling
	pdf.SetDrawColorGrayScale(200)
	pdf.SetTextColorGrayScale(200)
	pdf.Rect(50, 20, 40, 10, wxPDF_STYLE_DRAW)
	pdf.Text(50, 19, "Scale")
	pdf.SetDrawColorGrayScale(0)
	pdf.SetTextColorGrayScale(0)
	' Start Transformation
	pdf.StartTransform()
	' Scale by 150% centered by (50,30) which is the lower left corner of the rectangle
	pdf.ScaleXY(150, 50, 30)
	pdf.Rect(50, 20, 40, 10, wxPDF_STYLE_DRAW)
	pdf.Text(50, 19, "Scale")
	' Stop Transformation
	pdf.StopTransform()
	
	' Translation
	pdf.SetDrawColorGrayScale(200)
	pdf.SetTextColorGrayScale(200)
	pdf.Rect(125, 20, 40, 10, wxPDF_STYLE_DRAW)
	pdf.Text(125, 19, "Translate")
	pdf.SetDrawColorGrayScale(0)
	pdf.SetTextColorGrayScale(0)
	' Start Transformation
	pdf.StartTransform()
	' Translate 20 to the right, 15 to the bottom
	pdf.Translate(20, 15)
	pdf.Rect(125, 20, 40, 10, wxPDF_STYLE_DRAW)
	pdf.Text(125, 19, "Translate")
	' Stop Transformation
	pdf.StopTransform()
	
	'Rotation
	pdf.SetDrawColorGrayScale(200)
	pdf.SetTextColorGrayScale(200)
	pdf.Rect(50, 50, 40, 10, wxPDF_STYLE_DRAW)
	pdf.Text(50, 49, "Rotate")
	pdf.SetDrawColorGrayScale(0)
	pdf.SetTextColorGrayScale(0)
	' Start Transformation
	pdf.StartTransform()
	' Rotate 20 degrees counter-clockwise centered by (50,60)
	' which is the lower left corner of the rectangle
	pdf.Rotate(20, 50, 60)
	pdf.Rect(50, 50, 40, 10, wxPDF_STYLE_DRAW)
	pdf.Text(50, 49, "Rotate")
	' Stop Transformation
	pdf.StopTransform()
	
	' Skewing
	pdf.SetDrawColorGrayScale(200)
	pdf.SetTextColorGrayScale(200)
	pdf.Rect(125, 50, 40, 10, wxPDF_STYLE_DRAW)
	pdf.Text(125, 49, "Skew")
	pdf.SetDrawColorGrayScale(0)
	pdf.SetTextColorGrayScale(0)
	' Start Transformation
	pdf.StartTransform()
	' skew 30 degrees along the x-axis centered by (125,60)
	' which is the lower left corner of the rectangle
	pdf.SkewX(30, 125, 60)
	pdf.Rect(125, 50, 40, 10, wxPDF_STYLE_DRAW)
	pdf.Text(125, 49, "Skew")
	' Stop Transformation
	pdf.StopTransform()
	
	' Mirroring horizontally
	pdf.SetDrawColorGrayScale(200)
	pdf.SetTextColorGrayScale(200)
	pdf.Rect(50, 80, 40, 10, wxPDF_STYLE_DRAW)
	pdf.Text(50, 79, "MirrorH")
	pdf.SetDrawColorGrayScale(0)
	pdf.SetTextColorGrayScale(0)
	' Start Transformation
	pdf.StartTransform()
	' mirror horizontally with axis of reflection at x-position 50 (left side of the rectangle)
	pdf.MirrorH(50)
	pdf.Rect(50, 80, 40, 10, wxPDF_STYLE_DRAW)
	pdf.Text(50, 79, "MirrorH")
	' Stop Transformation
	pdf.StopTransform()
	
	' Mirroring vertically
	pdf.SetDrawColorGrayScale(200)
	pdf.SetTextColorGrayScale(200)
	pdf.Rect(125, 80, 40, 10, wxPDF_STYLE_DRAW)
	pdf.Text(125, 79, "MirrorV")
	pdf.SetDrawColorGrayScale(0)
	pdf.SetTextColorGrayScale(0)
	' Start Transformation
	pdf.StartTransform()
	' mirror vertically with axis of reflection at y-position 90 (bottom side of the rectangle)
	pdf.MirrorV(90)
	pdf.Rect(125, 80, 40, 10, wxPDF_STYLE_DRAW)
	pdf.Text(125, 79, "MirrorV")
	' Stop Transformation
	pdf.StopTransform()

	
	pdf.SaveAsFile("transformation.pdf")
End Function


