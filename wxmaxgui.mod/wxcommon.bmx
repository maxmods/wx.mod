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

Import BRL.System
Import MaxGUI.MaxGUI

Import wx.wxApp
Import wx.wxFrame
Import wx.wxButton
Import wx.wxCheckBox
Import wx.wxToggleButton
Import wx.wxRadioButton
Import wx.wxStaticText
Import wx.wxStaticLine
Import wx.wxTextCtrl
Import wx.wxPanel
Import wx.wxStaticBox
Import wx.wxSlider
Import wx.wxSpinButton
Import wx.wxScrollBar
Import wx.wxGauge
Import wx.wxComboBox
Import wx.wxFontDialog
Import wx.wxColourDialog
Import wx.wxSystemSettings
Import wx.wxMessageDialog
Import wx.wxDirDialog
Import wx.wxFileDialog
Import wx.wxListCtrl
Import wx.wxChoice
Import wx.wxNotebook
Import wx.wxSystemOptions
Import wx.wxDataViewTreeCtrl
Import wx.wxScintilla

Function wxMouseButtonToMaxMouseButton:Int(button:Int)
	If button = wxMOUSE_BTN_LEFT
		Return MOUSE_LEFT
	End If
	
	If button = wxMOUSE_BTN_RIGHT
		Return MOUSE_RIGHT
	End If
	
	If button = wxMOUSE_BTN_MIDDLE
		Return MOUSE_MIDDLE
	End If

	' none or unknown
	Return 0
End Function
