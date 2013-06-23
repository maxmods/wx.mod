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

Function maxModifierToString:String(modifier:Int)
	Local s:String
	If modifier & MODIFIER_SHIFT Then
		s:+ "SHIFT"
	End If
	
	If modifier & MODIFIER_CONTROL Then
		If s Then
			s :+ "+"
		End If
		s :+ "RAWCTRL"
	End If
	
	If modifier & MODIFIER_OPTION Then
		If s Then
			s :+ "+"
		End If
		s :+ "ALT"
	End If
	
	?macos
	If modifier & MODIFIER_COMMAND Then
		If s Then
			s :+ "+"
		End If
		s :+ "CTRL"
	End If
	?
	
	Return s
End Function

Function maxKeyCodeToString:String(keycode:Int)
	Select keycode
		Case KEY_BACKSPACE
			Return "BACK"
		Case KEY_TAB
			Return "TAB"
		Case KEY_RETURN
			Return "RETURN"
		Case KEY_ENTER
			Return "ENTER"
		Case KEY_ESCAPE
			Return "ESC"
		Case KEY_SPACE
			Return "SPACE"
		Case KEY_PAGEUP
			Return "PGUP"
		Case KEY_PAGEDOWN
			Return "PGDN"
		Case KEY_END
			Return "END"
		Case KEY_HOME
			Return "HOME"
		Case KEY_LEFT
			Return "LEFT"
		Case KEY_UP
			Return "UP"
		Case KEY_RIGHT
			Return "RIGHT"
		Case KEY_DOWN
			Return "DOWN"
		Case KEY_INSERT
			Return "INS"
		Case KEY_DELETE
			Return "DEL"
	End Select
	
	If keycode >= KEY_0 And keycode <= KEY_9 Then
		Return keycode - KEY_0
	End If
	
	If keycode >= KEY_A And keycode <= KEY_Z Then
		Return Chr(keycode)
	End If
	
	If keycode >= KEY_F1 And keycode <= KEY_F12 Then
		Return "F" + (keycode - KEY_F1 + 1)
	End If

	Return ""
End Function

