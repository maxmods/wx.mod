SuperStrict

Import wx.wxPdfDocument

' Bookmarks
' 
' This example demonstrates the use of bookmarks.

'
Function bookmark()
	Local pdf:wxPdfDocument = New wxPdfDocument.Create()
	pdf.AddPage()
	pdf.SetFont("Arial", "", 15)
	
	'Page 1
	pdf.AddPage()
	pdf.Bookmark("Page 1")
	pdf.Bookmark("Paragraph 1", 1, -1)
	pdf.Cell(0, 6, "Paragraph 1")
	pdf.Ln(50)
	pdf.Bookmark("Paragraph 2", 1, -1)
	pdf.Cell(0, 6, "Paragraph 2")
	pdf.Annotate(60, 30, "First annotation on first page")
	pdf.Annotate(60, 60, "Second annotation on first page")
	'Page 2
	pdf.AddPage()
	pdf.Bookmark("Page 2")
	pdf.Bookmark("Paragraph 3", 1, -1)
	pdf.Cell(0, 6, "Paragraph 3")
	pdf.Annotate(60, 40, "First annotation on second page")
	pdf.Annotate(90, 40, "Second annotation on second page")
	
	pdf.SaveAsFile("bookmark.pdf")
End Function



