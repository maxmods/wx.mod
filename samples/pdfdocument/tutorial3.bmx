SuperStrict

Import wx.wxPdfDocument
Import BRL.TextStream

' Line breaks and colors
'
' Let's continue with an example which prints justified paragraphs.
' It also illustrates the use of colors. 
' 
' The GetStringWidth() method allows to determine the length of a string in the
' current font, which is used here to calculate the position and the width of
' the frame surrounding the title. Then colors are set (via SetDrawColor(),
' SetFillColor() and SetTextColor()) and the thickness of the line is set to
' 1 mm (against 0.2 by default) with SetLineWidth(). Finally, we output the cell
' (the last parameter to 1 indicates that the background must be filled). 
' 
' The method used to print the paragraphs is MultiCell(). Each time a line reaches
' the right extremity of the cell or a carriage-return character is met, a line
' break is issued and a new cell automatically created under the current one.
' Text is justified by default. 
' 
' Two document properties are defined: title (SetTitle()) and author (SetAuthor()).
' Properties can be viewed by two means. First is open the document directly with
' Acrobat Reader, go to the File menu, Document info, General. Second, also available
' from the plug-in, is click on the triangle just above the right scrollbar and
' choose Document info. 
'
Type PdfTuto3 Extends wxPdfDocument

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
		SetDrawColor(New wxColour.Create(0,80,180))
		SetFillColor(New wxColour.Create(230,230,0))
		SetTextColor(New wxColour.Create(220,50,50))
		' Thickness of frame (1 mm)
		SetLineWidth(1)
		' Title
		Cell(w, 9, m_myTitle, wxPDF_BORDER_FRAME, 1, wxPDF_ALIGN_CENTER, 1)
		' Line break
		Ln(10)
	End Method

	Method Footer()
		' Position at 1.5 cm from bottom
		SetY(-15)
		' Arial italic 8
		SetFont("Arial", "I", 8)
		' Text color in gray
		SetTextColorGrayScale(128)
		' Page number
		Cell(0, 10, "Page " + PageNo(), 0, 0, wxPDF_ALIGN_CENTER)
	End Method

	Method ChapterTitle(num:Int, label:String)
		' Arial 12
		SetFont("Arial", "", 12)
		' Background color
		SetFillColor(New wxColour.Create(200,220,255))
		' Title
		Cell(0, 6, "Chapter " + num + " : " + label, 0, 1, wxPDF_ALIGN_LEFT,1)
		' Line break
		Ln(4)
	End Method

	Method ChapterBody(file:String)
		' Read text file
		Local txt:String = LoadText(file)
		' Times 12
		SetFont("Times", "", 12)
		' Output justified text
		MultiCell(0, 5, txt)
		' Line break
		Ln()
		' Mention in italics
		SetFont("", "I")
		Cell(0, 5, "(end of excerpt)")
	End Method

	Method PrintChapter(num:Int, title:String, file:String)
		AddPage()
		ChapterTitle(num, title)
		ChapterBody(file)
	End Method
	
End Type


Function tutorial3()
  Local pdf:PdfTuto3 = PdfTuto3(New PdfTuto3.Create())
  pdf.SetMyTitle("20000 Leagues Under the Seas")
  pdf.SetAuthor("Jules Verne")
  pdf.PrintChapter(1, "A RUNAWAY REEF", "20k_c1.txt")
  pdf.PrintChapter(2, "THE PROS AND CONS", "20k_c2.txt")
  pdf.SaveAsFile("tutorial3.pdf")
End Function

