SuperStrict

Import wx.wxPdfDocument

' Barcodes
'
' This example shows how to use the barcode creator add-on .
'
Function barcodes()
	Local pdf:wxPdfDocument = New wxPdfDocument.Create()
	Local barcode:wxPdfBarCodeCreator = New wxPdfBarCodeCreator.Create(pdf)
	
	pdf.AddPage()
	
	barcode.EAN13(80, 40, "123456789012")

	barcode.UPC_A(80, 70, "1234567890")
	
	barcode.Code39(60, 100, "Code 39")
	
	barcode.I25(90, 140, "12345678")
	
	Local zipcode:String = "48109-1109"
	barcode.PostNet(40, 180, zipcode)
	pdf.Text(40, 185, zipcode)
	
	pdf.SaveAsFile("barcodes.pdf")
End Function


