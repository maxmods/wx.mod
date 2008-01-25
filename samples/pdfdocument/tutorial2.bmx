SuperStrict

Import wx.wxPdfDocument


' Here is a two page example with header, footer and logo: 
'
' This example makes use of the Header() and Footer() methods to process page
' headers and footers. They are called automatically. They already exist in the
' wxPdfDocument class but do nothing, therefore we have to extend the class and override
' them. 
' 
' The logo is printed with the Image() method by specifying its upper-left corner
' and its width. The height is calculated automatically to respect the image
' proportions. 
' 
' To print the page number, a null value is passed as the cell width. It means
' that the cell should extend up to the right margin of the page; it is handy to
' center text. The current page number is returned by the PageNo() method; as for
' the total number of pages, it is obtained by means of the special value {nb}
' which will be substituted on document closure (provided you first called
' AliasNbPages()). 
' 
' Note the use of the SetY() method which allows to set position at an absolute
' location in the page, starting from the top or the bottom. 

' Another interesting feature is used here: the automatic page breaking. As soon
' as a cell would cross a limit in the page (at 2 centimeters from the bottom by
' default), a break is performed and the font restored. Although the header and
' footer select their own font (Arial), the body continues with Times. This mechanism
' of automatic restoration also applies to colors and line width. The limit which
' triggers page breaks can be set with SetAutoPageBreak(). 
'
Type PdfTuto2 Extends wxPdfDocument

	Method Header()
		' Logo
		Image("../media/pdfdocument/wxpdfdoc.png", 10, 8, 28)
		' Arial bold 15
		SetFont("Arial", "B", 15)
		' Move To the Right
		Cell(80)
		' Title
		Cell(30, 10, "Title", wxPDF_BORDER_FRAME, 0, wxPDF_ALIGN_CENTER)
		' Line break
		Ln(20)
	End Method
	
	Method Footer()
		' Position at 1.5 cm from bottom
		SetY(-15)
		' Arial italic 8
		SetFont("Arial", "I", 8)
		' Page number
		Cell(0, 10, "Page " + PageNo() + "/{nb}", 0, 0, wxPDF_ALIGN_CENTER)
	End Method


End Type


Function tutorial2()

	' Instanciation of inherited class
	Local pdf:PdfTuto2 = PdfTuto2(New PdfTuto2.Create())
	pdf.AliasNbPages()
	pdf.AddPage()
	pdf.Image("../media/pdfdocument/smile.jpg", 70, 40, 12)
	pdf.Image("../media/pdfdocument/apple.gif", 110, 40, 25)
	pdf.SetFont("Times", "", 12)

	For Local i:Int = 1 To 40
		pdf.Cell(0, 10, "Printing line number " + i, 0, 1)
	Next
	pdf.SaveAsFile("tutorial2.pdf")

End Function

