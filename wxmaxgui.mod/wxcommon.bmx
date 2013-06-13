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
