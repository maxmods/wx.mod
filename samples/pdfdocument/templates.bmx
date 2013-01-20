SuperStrict

Import wx.wxPdfDocument

' Templates 1
' 
' This example shows the creation and use of internal templates.
'
Function templates1()
	Local Pdf:wxPdfDocument = New wxPdfDocument.Create()
	Pdf.AddPage()

	Local w:Double, h:Double
	Local tpl1:Int, tpl2:Int
	
	' Generate a template clip on  x=0, y=0, width=180, height=350
	' Take care, that the margins of the Template are set to the
	' original margins.
	tpl1 = Pdf.BeginTemplate(0, 0, 180, 350)
	Pdf.SetFont("Arial", "", 14)
	Pdf.SetTextColourGrayScale(0)
	For Local i:Int = 0 Until 200
		Pdf.Write(10, "dummy text " + i + " ")
	Next
	Pdf.Image("../media/pdfdocument/glasses.png", 100, 60, 100)
	Pdf.EndTemplate()
	
	' Generate a template that will hold the whole page
	tpl2 = Pdf.BeginTemplate()
	Pdf.SetFont("Arial", "", 14)
	
	' demonstrate how to lay text in background of an existing template
	Pdf.SetXY(115, 55)
	Pdf.Write(10, "write behind it...")
	
	' Now we use our first created template on position x=10, y=10 and
	' give it a width of 50mm (height is calculated automaticaly) and draw a border around it
	Pdf.UseTemplate(tpl1, 10, 10, 50)
	w = 50
	h = 0
	Pdf.GetTemplateSize(tpl1, w, h)
	Pdf.Rect(10, 10, w, h)
	
	' Same as above, but another size
	Pdf.UseTemplate(tpl1, 70, 10, 100)
	w = 100
	h = 0
	Pdf.GetTemplateSize(tpl1, w, h)
	Pdf.Rect(70, 10, w, h)
	Pdf.EndTemplate()
	
	' Till now, there is no output to the PDF-File
	' We draw Template No. 2, that includes 2 Versions of the first
	Pdf.UseTemplate(tpl2)
	
	Pdf.AddPage()
	
	' Here we reuse Template No. 2
	' For example I used the rotate-script
	' to show u how, easy it is to use the created templates
	Pdf.SetFillColourGrayScale(255)
	For Local i:Int = 90 To 0 Step - 30
		Pdf.StartTransform()
		Pdf.Rotate(i, 10, 120)
		w = 100
		h = 0
		Pdf.GetTemplateSize(tpl2, w, h)
		Pdf.Rect(10, 120, w, h, wxPDF_STYLE_FILLDRAW)
		Pdf.UseTemplate(tpl2, 10, 120, 100)
		Pdf.StopTransform()
	Next
	
	Pdf.SaveAsFile("templates1.pdf")
End Function

' Templates 2
' 
' This example shows the use of external templates.
'
Function templates2()
	Local x:Double, y:Double, w:Double, h:Double
	Local Pdf:wxPdfDocument = New wxPdfDocument.Create()
	Pdf.AddPage()

	Pdf.SetTextColourPdf(New wxPdfColour.CreateNamedColour("black"))
	Local pages:Int = Pdf.SetSourceFile("chart2d.pdf")
	
	' Get the document information from the imported PDF file
	Local info:wxPdfInfo = New wxPdfInfo.Create()
	Pdf.GetSourceInfo(info)
	
	Local tpl:Int = Pdf.ImportPage(1)
	
	' Add some extra white space around the template
	Pdf.GetTemplateBBox(tpl, x, y, w, h)
	Pdf.SetTemplateBBox(tpl, x-10, y-10, w+20, h+20)
	Pdf.UseTemplate(tpl, 20, 20, 160)
	
	' Draw a rectangle around the template
	w = 160
	h = 0
	Pdf.GetTemplateSize(tpl, w, h)
	Pdf.Rect(20, 20, w, h)
	
	Pdf.SetXY(30, 30 + h)
	Pdf.SetFont("Arial", "", 10)
	Pdf.SetLeftMargin(30)
	Pdf.Cell(0, 5, "Title: " + info.GetTitle())
	Pdf.Ln(5)
	Pdf.Cell(0, 5, "Creator: " + info.GetCreator())
	Pdf.Ln(5)
	Pdf.Cell(0, 5, "Producer: " + info.GetProducer())
	
	Pdf.SaveAsFile("templates2.pdf")
End Function
