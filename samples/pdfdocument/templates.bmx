SuperStrict

Import wx.wxPdfDocument

' Templates 1
' 
' This example shows the creation and use of internal templates.
'
Function templates1()
	Local pdf:wxPdfDocument = New wxPdfDocument.Create()
	pdf.AddPage()

	Local w:Double, h:Double
	Local tpl1:Int, tpl2:Int
	
	' Generate a template clip on  x=0, y=0, width=180, height=350
	' Take care, that the margins of the Template are set to the
	' original margins.
	tpl1 = pdf.BeginTemplate(0, 0, 180, 350)
	pdf.SetFont("Arial", "", 14)
	pdf.SetTextColorGrayScale(0)
	For Local i:Int = 0 Until 200
		pdf.Write(10, "dummy text " + i + " ")
	Next
	pdf.Image("../media/pdfdocument/glasses.png", 100, 60, 100)
	pdf.EndTemplate()
	
	' Generate a template that will hold the whole page
	tpl2 = pdf.BeginTemplate()
	pdf.SetFont("Arial", "", 14)
	
	' demonstrate how to lay text in background of an existing template
	pdf.SetXY(115, 55)
	pdf.Write(10, "write behind it...")
	
	' Now we use our first created template on position x=10, y=10 and
	' give it a width of 50mm (height is calculated automaticaly) and draw a border around it
	pdf.UseTemplate(tpl1, 10, 10, 50)
	w = 50
	h = 0
	pdf.GetTemplateSize(tpl1, w, h)
	pdf.Rect(10, 10, w, h)
	
	' Same as above, but another size
	pdf.UseTemplate(tpl1, 70, 10, 100)
	w = 100
	h = 0
	pdf.GetTemplateSize(tpl1, w, h)
	pdf.Rect(70, 10, w, h)
	pdf.EndTemplate()
	
	' Till now, there is no output to the PDF-File
	' We draw Template No. 2, that includes 2 Versions of the first
	pdf.UseTemplate(tpl2)
	
	pdf.AddPage()
	
	' Here we reuse Template No. 2
	' For example I used the rotate-script
	' to show u how, easy it is to use the created templates
	pdf.SetFillColorGrayScale(255)
	For Local i:Int = 90 To 0 Step - 30
		pdf.StartTransform()
		pdf.Rotate(i, 10, 120)
		w = 100
		h = 0
		pdf.GetTemplateSize(tpl2, w, h)
		pdf.Rect(10, 120, w, h, wxPDF_STYLE_FILLDRAW)
		pdf.UseTemplate(tpl2, 10, 120, 100)
		pdf.StopTransform()
	Next
	
	pdf.SaveAsFile("templates1.pdf")
End Function

' Templates 2
' 
' This example shows the use of external templates.
'
Function templates2()
	Local x:Double, y:Double, w:Double, h:Double
	Local pdf:wxPdfDocument = New wxPdfDocument.Create()
	pdf.AddPage()

	pdf.SetTextColorPdf(New wxPdfColour.CreateForName("black"))
	Local pages:Int = pdf.SetSourceFile("chart2d.pdf")
	
	' Get the document information from the imported PDF file
	local info:wxPdfInfo = new wxPdfInfo.Create()
	pdf.GetSourceInfo(info)
	
	local tpl:int = pdf.ImportPage(1)
	
	' Add some extra white space around the template
	pdf.GetTemplateBBox(tpl, x, y, w, h)
	pdf.SetTemplateBBox(tpl, x-10, y-10, w+20, h+20)
	pdf.UseTemplate(tpl, 20, 20, 160)
	
	' Draw a rectangle around the template
	w = 160
	h = 0
	pdf.GetTemplateSize(tpl, w, h)
	pdf.Rect(20, 20, w, h)
	
	pdf.SetXY(30, 30 + h)
	pdf.SetFont("Arial", "", 10)
	pdf.SetLeftMargin(30)
	pdf.Cell(0, 5, "Title: " + info.GetTitle())
	pdf.Ln(5)
	pdf.Cell(0, 5, "Creator: " + info.GetCreator())
	pdf.Ln(5)
	pdf.Cell(0, 5, "Producer: " + info.GetProducer())
	
	pdf.SaveAsFile("templates2.pdf")
End Function
