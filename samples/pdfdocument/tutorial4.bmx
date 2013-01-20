SuperStrict

Import wx.wxPdfDocument
Import BRL.TextStream

Rem
' Multi-columns
' 
' This example is a variant of the previous one showing how to lay the text
' across multiple columns. 
' 
' The key method used is AcceptPageBreak(). It allows to accept or not an
' automatic page break. By refusing it and altering the margin and current
' position, the desired column layout is achieved. 
' For the rest, not much change; two properties have been added to the class
' to save the current column number and the position where columns begin, and
' the MultiCell() call specifies a 6 centimeter width. 
End Rem
Type PdfTuto4 Extends wxPdfDocument

	' Current column
	Field m_col:Int
	' Ordinate of column start
	Field m_y0:Double


	Field m_myTitle:String

	Method SetMyTitle(title:String)
		m_myTitle = title
		SetTitle(title)
	End Method

	Method Header()
		' Arial bold 15
		SetFont("Arial", "B", 15)
		' Calculate width of title And position
		Local w:Double = GetStringWidth(m_myTitle) + 6
		SetX((210 - w) / 2)
		' Colors of frame, background And text
		SetDrawColour(New wxColour.Create(0,80,180))
		SetFillColour(New wxColour.Create(230,230,0))
		SetTextColour(New wxColour.Create(220,50,50))
		' Thickness of frame (1 mm)
		SetLineWidth(1)
		' Title
		Cell(w, 9, m_myTitle, wxPDF_BORDER_FRAME, 1, wxPDF_ALIGN_CENTER, 1)
		' Line break
		Ln(10)
	    ' Save ordinate
		m_y0 = GetY()
	End Method

	Method Footer()
		' Position at 1.5 cm from bottom
		SetY(-15)
		' Arial italic 8
		SetFont("Arial", "I", 8)
		' Text color in gray
		SetTextColourGrayScale(128)
		' Page number
		Cell(0, 10, "Page " + PageNo(), 0, 0, wxPDF_ALIGN_CENTER)
	End Method
	
	Method SetCol(col:Int)
		' Set position at a given column
		m_col = col
		Local x:Double = 10 + col * 65
		SetLeftMargin(x)
		SetX(x)
	End Method


	Method AcceptPageBreak:Int()
		' Method accepting Or Not automatic page break
		If m_col < 2 Then
			' Go To Next column
			SetCol(m_col+1)
			' Set ordinate To top
			SetY(m_y0)
			' Keep on page
			Return False
		Else
			' Go back To First column
			SetCol(0)
			' Page break
			Return True
		End If
	End Method


	Method ChapterTitle(num:Int, label:String)
		' Arial 12
		SetFont("Arial", "", 12)
		' Background color
		SetFillColour(New wxColour.Create(200,220,255))
		' Title
		Cell(0, 6, "Chapter " + num + " : " + label, 0, 1, wxPDF_ALIGN_LEFT,1)
		' Line break
		Ln(4)
		' Save ordinate
		m_y0 = GetY()
	End Method

	Method ChapterBody(file:String)
		' Read text file
		Local txt:String = LoadText(file)
		' Times 12
		SetFont("Times", "", 12)
		' Output justified text
		MultiCell(60, 5, txt)
		' Line break
		Ln()
		' Mention in italics
		SetFont("", "I")
		Cell(0, 5, "(end of excerpt)")
		' Go back To First column
		SetCol(0)
	End Method

	Method PrintChapter(num:Int, title:String, file:String)
		AddPage()
		ChapterTitle(num, title)
		ChapterBody(file)
	End Method

End Type


Function tutorial4()
  Local Pdf:PdfTuto4 = PdfTuto4(New PdfTuto4.Create())
  Pdf.SetMyTitle("20000 Leagues Under the Seas")
  Pdf.SetAuthor("Jules Verne")
  Pdf.PrintChapter(1, "A RUNAWAY REEF", "20k_c1.txt")
  Pdf.PrintChapter(2, "THE PROS AND CONS", "20k_c2.txt")
  Pdf.SaveAsFile("tutorial4.pdf")
End Function


