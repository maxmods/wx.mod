' Copyright (c) 2013 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Module wx.wxMaxGUIHtmlWindow


Import wx.wxMaxGUI

Import wx.wxHtmlWindow


New TwxHtmlWindowDriver

Type TwxHtmlWindowDriver Extends TwxWebDriver
	Method New()
		wxmaxgui_htmlview = Self
		wxInitAllImageHandlers()
	End Method
	
	Method CreateHTMLView:TGadget(text:String, x:Int, y:Int, w:Int, h:Int, group:TwxGadget, style:Int)
		Return New TwxHtmlView.CreateGadget(text, x, y, w, h, group, wxHW_DEFAULT_STYLE)
	End Method
End Type


Type TwxHtmlView Extends TwxGadget

	Method InitGadget()
		CreateHTMLView()
	End Method
	
	Method CreateHTMLView()
		widget = New MaxGuiwxHtmlWindow.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)
		
		Rethink()
		
		SetShow(True)
	End Method

	Method Stop()
		'MaxGuiwxHtmlWindow(widget).Stop()
	End Method

	Method SetText(text:String)
	
		' construct a valid URL
		Local anchor$, a:Int
		a = text.Find("#")
		If a <> -1 Then
			anchor = text[a..]
			text = text[..a]
		End If
		If text[0..7].ToLower() <> "http://" And text[0..7].ToLower() <> "file://"
			If FileType(text)
				text = "file://" + text
			Else
				text = "http://" + text
			End If
		End If
		text:+ anchor
		text = text.Replace(" ","%20")

		' load the URL
		MaxGuiwxHtmlWindow(widget).LoadPage(text)
	End Method
	
	Method GetText:String()
		Return MaxGuiwxHtmlWindow(widget).GetOpenedPage()
	End Method
	
	Method Activate(command:Int)
		Select command
			Case ACTIVATE_COPY
				'MaxGuiwxHtmlWindow(widget).Copy()
			Case ACTIVATE_BACK
				MaxGuiwxHtmlWindow(widget).HistoryBack()
			Case ACTIVATE_FORWARD
				MaxGuiwxHtmlWindow(widget).HistoryForward()
			Case ACTIVATE_PRINT
				'Local easyPrint:wxHtmlEasyPrinting = New wxHtmlEasyPrinting.Create()
				'easyPrint.PrintText(
				'MaxGuiwxHtmlWindow(widget).Print()
		End Select
	End Method

End Type


Type MaxGuiwxHtmlWindow Extends wxHtmlWindow

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxHtmlWindow(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()

	End Method

End Type
