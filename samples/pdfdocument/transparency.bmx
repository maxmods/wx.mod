SuperStrict

Import wx.wxPdfDocument

' Transparency
' 
' This example shows transparency effects and image masking.

'
Function transparency()
	Local pdf:wxPdfDocument = New wxPdfDocument.Create()
	pdf.AddPage()
	pdf.SetFont("Arial", "", 16)
	
	Local txt:String
	For Local j:Int = 0 Until 180
		txt :+ "Hello World! "
	Next
	pdf.MultiCell(0, 8, txt)
	
	' A) provide image + separate 8-bit mask (best quality!)
	
	' first embed mask image (w, h, x and y will be ignored, the image will be scaled to the target image's size)
	Local maskImg:Int = pdf.ImageMask("../media/pdfdocument/mask.png")
	
	' embed image, masked with previously embedded mask
	pdf.Image("../media/pdfdocument/image.png", 55, 10, 100, 0, "png", Null, maskImg)
	
	' B) use alpha channel from PNG
	'pdf.ImagePngWithAlpha('image_with_alpha.png', 55, 100, 100)
	
	' C) same as B), but using Image() method that recognizes the alpha channel
	pdf.Image("../media/pdfdocument/image_with_alpha.png", 55, 190, 100)
	
	pdf.AddPage()
	pdf.SetLineWidth(1.5)
	
	' draw opaque red square
	pdf.SetAlpha()
	pdf.SetFillColor(New wxColour.Create(255,0,0))
	pdf.Rect(10, 10, 40, 40, wxPDF_STYLE_FILLDRAW)
	
	' set alpha to semi-transparency
	pdf.SetAlpha(1, 0.5)
	
	' draw green square
	pdf.SetFillColor(New wxColour.Create(0,255,0))
	pdf.Rect(20, 20, 40, 40, wxPDF_STYLE_FILLDRAW)
	
	' draw jpeg image
	pdf.Image("../media/pdfdocument/lena.jpg", 30, 30, 40)
	
	' restore full opacity
	pdf.SetAlpha()
	
	' print name
	pdf.SetFont("Arial", "", 12)
	pdf.Text(46,68,"Lena")
	
	pdf.SaveAsFile("transparency.pdf")
End Function

