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

Import "wxfont.bmx"

Type TwxGadget Extends TGadget

	Field widget:wxWindow
	Field icons:TwxIconStrip
	
	Field initing:Int = True

	Method CreateGadget:TwxGadget(text:String, x:Int, y:Int, w:Int, h:Int, group:TwxGadget, style:Int)
		
		Self.style = style
		SetRect(x, y, w, h)
		parent = group
		InitGadget()
		
		LockLayout()
		
		If (LocalizationMode() & LOCALIZATION_OVERRIDE) Then
			LocalizeGadget(Self, text)
		Else
			SetText(text)
		EndIf

		If parent Then
			parent.kids.Remove(Self)
			parent.kids.AddLast(Self)
		End If
		
		initing = False
		'SetFont(TFLTKGUIDriver.fntDefault)
		Return Self
		
	End Method
	
	Method InitGadget()
	End Method

	Method SetShow(truefalse:Int)
		If truefalse Then
			widget.Show()
		Else
			widget.Hide()
		End If
	End Method

	Method SetTooltip(text:String)
		widget.setToolTip(text)
	End Method
		
	Method ClientWidth:Int()
		Local w:Int, h:Int
		If Not widget.IsShown() Then
			widget.GetSize(w, h)
		Else
			widget.GetClientSize(w, h)
		End If
		Return w
	End Method

	Method ClientHeight:Int()
		Local w:Int, h:Int
		If Not widget.IsShown() Then
			widget.GetSize(w, h)
		Else
			widget.GetClientSize(w, h)
		End If
		Return h
	End Method

	Method SetColor(r:Int, g:Int, b:Int)
		Local col:wxColour = New wxColour.Create(r, g, b)
		widget.SetOwnBackgroundColour(col)
		widget.refresh() ' Windows (at least) requires this.
	End Method

	Method RealParentForChild:wxWindow()
		Return widget
	End Method

	Method SetFont(font:TGuiFont)
		widget.SetFont(TwxGuiFont(font).font)
	End Method
	
	Method GetFont:TGuiFont()
		Return New TwxGuiFont.Create(widget.GetFont())
	End Method

	Method SetIconStrip(iconstrip:TIconStrip)
		icons = TwxIconStrip(iconstrip)
	End Method
	
	Method Rethink()
		widget.Move(xpos, ypos)
		widget.SetSize(width, height)
	End Method

End Type

Type TwxIconStrip Extends TIconStrip
	
	Field icons:wxBitmap[]
	Field dim:Int
	
	Function IsNotBlank:Int(pixmap:TPixmap)
		Local h:Int = pixmap.height
		Local c:Int = pixmap.ReadPixel(0,0) 			
		For Local x:Int = 0 Until h
			For Local y:Int = 0 Until h
				If pixmap.ReadPixel(x,y)<>c Return True
			Next
		Next
	End Function
		
	Function Create:TwxIconStrip(source:Object)
		Local iconstrip:TwxIconStrip

		Local pixmap:TPixmap = TPixmap(source)
		If Not pixmap Then
			pixmap = LoadPixmap(source)
		End If
		If Not pixmap Return Null
		
		Select pixmap.format
			Case PF_I8,PF_BGR888
				pixmap = pixmap.Convert( PF_RGB888 )
			Case PF_A8,PF_BGRA8888
				pixmap = pixmap.Convert( PF_RGBA8888 )
			Default
				pixmap = pixmap.Copy()
		End Select
		
		If AlphaBitsPerPixel[ pixmap.format ]
			For Local y:Int = 0 Until pixmap.height
				For Local x:Int = 0 Until pixmap.width
					Local argb:Int = pixmap.ReadPixel( x,y )
					pixmap.WritePixel x, y, premult(argb)
				Next
			Next
		EndIf
		
		Local n:Int = pixmap.width/pixmap.height
		If n = 0 Return Null
		
		iconstrip = New TwxIconStrip
		iconstrip.pixmap = pixmap
		iconstrip.count = n
		iconstrip.icons = New wxBitmap[n]
		
		Local w:Int = pixmap.width / n
		iconstrip.dim = w
		For Local x:Int = 0 Until n
			Local pix:TPixmap = pixmap.Window(x*w, 0, w, pixmap.height)
			If IsNotBlank(pix) Then
				iconstrip.icons[x] = wxBitmap.CreateBitmapFromPixmap(pix)
			End If
		Next

		Return iconstrip
	End Function	

	Function premult:Int(argb:Int)
		Local a:Int = ((argb Shr 24) & $FF)
		Return ((((argb&$ff00ff)*a)Shr 8)&$ff00ff)|((((argb&$ff00)*a)Shr 8)&$ff00)|(a Shl 24)
	End Function
	
	' create an imagelist from the icons
	Method GetImageList:wxImageList()
		Local imageList:wxImageList = New wxImageList.Create(dim, dim)
		For Local bitmap:wxBitmap = EachIn icons
			imageList.Add(bitmap)
		Next
		
		Return imageList
	End Method
	
EndType

Type TwxWindow Extends TwxGadget

	Field clientCoords:Int

	Method InitGadget()
		CreateWindow()
	End Method
	
	Method CreateWindow()
		Local flags:Int = 0
		
		If parent Then
			widget = New MaxGuiwxFrame.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, style)
		Else
			widget = New MaxGuiwxFrame.MCreate(Self, Null, xpos, ypos, width, height, style)
		End If
	
		If style & WINDOW_MENU Then
'			MaxGuiQMainWindow(widget).createMenuBar()
		End If
		
		If style & WINDOW_STATUS Then
			'createStatusbar()
'			MaxGuiQMainWindow(widget).createStatusBar()
			'SetStatus("")
		EndIf
		
		If style & WINDOW_RESIZABLE Then

		Else
'			widget.setFixedSize(width, height)
		End If
		
		If style & WINDOW_CLIENTCOORDS Then
			clientCoords = True
		End If

		Rethink()

		If ~style & WINDOW_HIDDEN
			Setshow(True)
		Else
			SetShow(False)
		End If
	End Method

	Method SetText(text:String)
		wxTopLevelWindow(widget).SetTitle(text)
	End Method

	Method Rethink()
		If widget Then
			widget.SetPosition(xpos, ypos)
			If clientCoords Then
				widget.SetClientSize(width, height)
			Else
				widget.SetSize(width, height)
			End If

			LayoutKids()
		End If
	End Method

	Method RealParentForChild:wxWindow()
		Return MaxGuiwxFrame(widget).clientWidget
	End Method

End Type

Type TwxButton Extends TwxGadget


	Method SetText(text:String)
		wxControl(widget).SetLabel(text)
	End Method
	
	Method GetText:String()
		Return wxControl(widget).GetLabel()
	End Method

	Method Class:Int()
		Return GADGET_BUTTON
	End Method

End Type


Type TwxPushButton Extends TwxButton

	Method InitGadget()
		CreateButton()
	End Method
	
	Method CreateButton()
	
		widget = New MaxGuiwxButton.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, style)

'		Select style & 7
'			Case BUTTON_CHECKBOX
'				MaxGuiQPushButton(widget).setFlat(True)
'				MaxGuiQPushButton(widget).setCheckable(True)
'				MaxGuiQPushButton(widget).setAutoFillBackground(True)
'			Case BUTTON_RADIO
'				MaxGuiQPushButton(widget).setFlat(True)
'				MaxGuiQPushButton(widget).setCheckable(True)
'				MaxGuiQPushButton(widget).setAutoExclusive(True)
'				MaxGuiQPushButton(widget).setAutoFillBackground(True)
'			Default
'		End Select
				
'		If style = BUTTON_OK Then
'			MaxGuiQPushButton(widget).setDefault(True)
'			
'			Local window:TQtWindow = TQtWindow(getParentWindow())
'			
'			If window Then
'				window.setOKButton(Self)
'			End If
'			
'		End If
		
'		If style = BUTTON_CANCEL Then
'			Local window:TQtWindow = TQtWindow(getParentWindow())
'			
'			If window Then
'				window.setCancelButton(Self)
'			End If
'
'		End If
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetPixmap(pixmap:TPixmap, flags:Int)
		If pixmap Then
			Local bitmap:wxBitmap = wxBitmap.CreateBitmapFromPixmap(pixmap)
			wxButton(widget).SetBitmap(bitmap)
		End If
	End Method

End Type

Type TwxCheckBox Extends TwxButton

	Method InitGadget()
		CreateButton()
	End Method
	
	Method CreateButton()
	
		widget = New MaxGuiwxCheckBox.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)

		Rethink()
		
		SetShow(True)
		
	End Method

	Method State:Int()
		Local flags:Int = Super.State()

		If wxCheckBox(widget).IsChecked() Then
			flags:|STATE_SELECTED
		End If

		Return flags
	End Method

	Method SetSelected(bool:Int)
		wxCheckBox(widget).SetValue(bool)
	End Method

End Type

Type TwxToggleButton Extends TwxButton

	Method InitGadget()
		CreateButton()
	End Method
	
	Method CreateButton()
	
		widget = New MaxGuiwxToggleButton.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)

		Rethink()
		
		SetShow(True)
		
	End Method

	Method State:Int()
		Local flags:Int = Super.State()

		If wxToggleButton(widget).GetValue() Then
			flags:|STATE_SELECTED
		End If

		Return flags
	End Method

	Method SetSelected(bool:Int)
		wxToggleButton(widget).SetValue(bool)
	End Method

End Type

Type TwxRadioButton Extends TwxButton

	Method InitGadget()
		CreateButton()
	End Method
	
	Method CreateButton()
	
		widget = New MaxGuiwxRadioButton.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)

		Rethink()
		
		SetShow(True)
		
	End Method

	Method State:Int()
		Local flags:Int = Super.State()

		If wxRadioButton(widget).GetValue() Then
			flags:|STATE_SELECTED
		End If

		Return flags
	End Method

	Method SetSelected(bool:Int)
		wxRadioButton(widget).SetValue(bool)
	End Method

End Type

Type TwxLabel Extends TwxGadget

	Method InitGadget()
		CreateLabel()
	End Method
	
	Method CreateLabel()
	
		Local labelStyle:Int = 0
		
		Select style & 3
			Case LABEL_FRAME
				labelStyle :| wxBORDER_SIMPLE
			Case LABEL_SUNKENFRAME
				labelStyle :| wxBORDER_SUNKEN
'			Case LABEL_SEPARATOR
'				' TODO : Horiz/Vert depending on width/height ?
'				If width < height Then
'					MaxGuiQLabel(widget).setFrameStyle(QFrame.Shape_VLine | QFrame.Shadow_Sunken)
'				Else
'					MaxGuiQLabel(widget).setFrameStyle(QFrame.Shape_HLine | QFrame.Shadow_Sunken)
'				End If
		End Select
		
		' alignment
		Select style & 24
			Case LABEL_LEFT
				labelStyle :| wxALIGN_LEFT
			Case LABEL_RIGHT
				labelStyle :| wxALIGN_RIGHT
			Case LABEL_CENTER
				labelStyle :| wxALIGN_CENTRE_HORIZONTAL
		End Select

		widget = New MaxGuiwxStaticText.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, labelStyle)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetText(text:String)
		wxControl(widget).SetLabel(text)
	End Method
	
	Method GetText:String()
		Return wxControl(widget).GetLabel()
	End Method
	
	Method Class:Int()
		Return GADGET_LABEL
	End Method

End Type

Type TwxSeparator Extends TwxGadget

	Method InitGadget()
		CreateSeparator()
	End Method
	
	Method CreateSeparator()
	
		Local separatorStyle:Int = 0
		Local w:Int = width
		Local h:Int = height
		
		If width < height Then
			separatorStyle = wxLI_VERTICAL
			w = -1
		Else
			separatorStyle = wxLI_HORIZONTAL
			h = -1
		End If


		widget = New MaxGuiwxStaticLine.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, w, h, separatorStyle)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method Class:Int()
		Return GADGET_LABEL
	End Method

End Type

Type TwxTextField Extends TwxGadget

	Method InitGadget()
		CreateTextField()
	End Method
	
	Method CreateTextField()
	
		widget = New MaxGuiwxTextCtrl.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, style)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetText(text:String)
		MaxGuiwxTextCtrl(widget).ChangeValue(text)
	End Method
	
	Method GetText:String()
		Return MaxGuiwxTextCtrl(widget).GetValue()
	End Method

'	Method SetColor(r:Int, g:Int, b:Int)
'		Local pal:QPalette = widget.palette()
'		pal.SetColor(QPalette.Role_Base, New QColor.Create(r, g, b))
'		widget.setPalette(pal)
'	End Method

	Method Class:Int()
		Return GADGET_TEXTFIELD
	End Method

End Type

Type TwxPanel Extends TwxGadget

	Method InitGadget()
		CreatePanel()
	End Method
	
	Method CreatePanel()
		Local panelStyle:Int = 0
		
		Select style & 3
			Case LABEL_FRAME
				panelStyle :| wxBORDER_SIMPLE
			Case LABEL_SUNKENFRAME
				panelStyle :| wxBORDER_SUNKEN
		End Select

		widget = New MaxGuiwxPanel.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, panelStyle)

		If style & PANEL_ACTIVE Then
			' enable mouse sensitivity for active panel
			sensitivity :| SENSITIZE_MOUSE
		'	widget.setMouseTracking(True)
		End If

		Rethink()
		
		SetShow(True)
		
	End Method

'	Method RealParentForChild:QWidget()
'		Return MaxGuiQFrame(widget).clientWidget
'	End Method
'
'	Method ClientWidth:Int()
'		If Not widget.isVisible() Then
'			Return widget.width()
'		Else
'			Return MaxGuiQFrame(widget).ClientWidth()
'		End If
'	End Method
'
'	Method ClientHeight:Int()
'		If Not widget.isVisible() Then
'			Return widget.height()
'		Else
'			Return MaxGuiQFrame(widget).ClientHeight()
''		End If
''	End Method
'	
'	Method SetPixmap(pixmap:TPixmap, flags:Int)
'		If pixmap Then
'''			Local pix:QPixmap = ConvertPixmap(pixmap)
	'		MaxGuiQFrame(widget).setPixmap(pix, flags)
	'	End If
'	End Method

	Method Class:Int()
		Return GADGET_PANEL
	End Method

End Type

Type TwxStaticBox Extends TwxGadget

	Method InitGadget()
		CreateStaticBox()
	End Method
	
	Method CreateStaticBox()
	
		widget = New MaxGuiwxStaticBox.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetText(text:String)
		MaxGuiwxStaticBox(widget).SetLabelText(text)
	End Method
	
	Method GetText:String()
		Return MaxGuiwxStaticBox(widget).GetLabelText()
	End Method

'	Method RealParentForChild:QWidget()
'		Return MaxGuiQGroupBox(widget).clientWidget
'	End Method

'	Method ClientWidth:Int()
'		Return MaxGuiQGroupBox(widget).ClientWidth()
'	End Method

'	Method ClientHeight:Int()
'		Return MaxGuiQGroupBox(widget).ClientHeight()
'	End Method
	
End Type

Type TwxTrackBar Extends TwxGadget

	Method InitGadget()
		CreateTrackBar()
	End Method
	
	Method CreateTrackBar()
	
		Local flags:Int = wxSL_HORIZONTAL

		If style & SLIDER_VERTICAL Then
			flags = wxSL_VERTICAL | wxSL_INVERSE
		End If
	
		widget = New MaxGuiwxSlider.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, flags)
		
		' default range
		SetRange(1, 10)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetRange(small:Int, big:Int)
		MaxGuiwxSlider(widget).SetRange(small, big)
	End Method
	
	Method SetProp(value:Int)
		MaxGuiwxSlider(widget).SetValue(value)
	End Method

	Method GetProp:Int()
		Return MaxGuiwxSlider(widget).GetValue()
	End Method

	Method Class:Int()
		Return GADGET_SLIDER
	End Method

End Type

Type TwxStepper Extends TwxGadget

	Method InitGadget()
		CreateStepper()
	End Method
	
	Method CreateStepper()
	
		widget = New MaxGuiwxSpinButton.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetRange(small:Int, big:Int)
		MaxGuiwxSpinButton(widget).SetRange(small, big)
	End Method
	
	Method SetProp(value:Int)
		MaxGuiwxSpinButton(widget).SetValue(value)
	End Method

	Method GetProp:Int()
		Return MaxGuiwxSpinButton(widget).GetValue()
	End Method

	Method Class:Int()
		Return GADGET_SLIDER
	End Method

End Type

Type TwxScrollBar Extends TwxGadget

	Field thumbSize:Int
	Field Range:Int
	Field pageSize:Int

	Method InitGadget()
		CreateScrollBar()
	End Method
	
	Method CreateScrollBar()
	
		Local orientation:Int = wxSB_HORIZONTAL
		
		If style & SLIDER_VERTICAL Then
			orientation = wxSB_VERTICAL
		End If
	
		widget = New MaxGuiwxScrollBar.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, orientation)
		
		' default range
		SetRange(1, 10)

		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetRange(small:Int, big:Int)
		Range = big - small
		pageSize = small
		
		If small <> 0 Then
			thumbSize = big/small
		Else
			thumbSize = 1
		End If
		
		MaxGuiwxScrollBar(widget).SetScrollbar(GetProp(), thumbSize, Range + thumbSize, pageSize)
	End Method

	Method SetProp(value:Int)
		MaxGuiwxScrollBar(widget).SetScrollbar(value, thumbSize, Range + thumbSize, pageSize)
	End Method

	Method GetProp:Int()
		Return MaxGuiwxScrollBar(widget).GetThumbPosition()
	End Method

	Method Class:Int()
		Return GADGET_SLIDER
	End Method

End Type

Type TwxProgressBar Extends TwxGadget

	Method InitGadget()
		CreateProgressBar()
	End Method
	
	Method CreateProgressBar()
	
		widget = New MaxGuiwxGauge.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, wxGA_SMOOTH)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetValue(value:Float)
		MaxGuiwxGauge(widget).SetValue(value * 100)
	End Method
	
	Method Class:Int()
		Return GADGET_PROGBAR
	End Method

End Type

Type TwxComboBox Extends TwxGadget

	Method InitGadget()
		CreateComboBox()
	End Method
	
	Method CreateComboBox()
	
		If style & COMBOBOX_EDITABLE Then
			widget = New MaxGuiwxComboBox.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)
		Else
			widget = New MaxGuiwxChoice.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)
		End If
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method InsertListItem(index:Int, text:String, tip:String, icon:Int, extra:Object)
		wxControlWithItems(widget).Insert(text, index, extra)
	End Method

	Method SetItemState:Int(index:Int, state:Int)
DebugLog "TODO : TwxComboBox::SetItemState"
	End Method

	Method ItemState:Int(index:Int)
DebugLog "TODO : TwxComboBox::ItemState"
	End Method
	
	Method SelectedItem:Int()
		Return wxControlWithItems(widget).GetSelection()
	End Method

	Method SetListItem(index:Int, text:String ,tip:String, icon:Int, data:Object)
		wxControlWithItems(widget).SetString(index, text)
		wxControlWithItems(widget).SetItemClientData(index, data)
	End Method


	Method SelectItem:Int(index:Int, op:Int= 1) '0=deselect 1=select 2=toggle
		wxControlWithItems(widget).SetSelection(index)
	End Method
	
	Method RemoveListItem(index:Int)
		wxControlWithItems(widget).DeleteItem(index)
	End Method

	Method Class:Int()
		Return GADGET_COMBOBOX
	End Method

End Type

Type TwxDesktop Extends TwxGadget

	Method InitGadget()
		CreateDesktop()
	End Method
	
	Method CreateDesktop()
	
		widget = Null
		
	End Method
	
	Method Rethink()
	End Method

	Method GetWidth:Int()
		Local w:Int, h:Int
		wxDisplaySize(w, h)
		Return w
	End Method
	
	Method GetHeight:Int()
		Local w:Int, h:Int
		wxDisplaySize(w, h)
		Return h
	End Method

	Method Class:Int()
		Return GADGET_DESKTOP
	End Method

	Method ClientWidth:Int()
		Local x:Int, y:Int, w:Int, h:Int
		wxClientDisplayRect(x, y, w, h)
		Return w
	End Method
	
	Method ClientHeight:Int()
		Local x:Int, y:Int, w:Int, h:Int
		wxClientDisplayRect(x, y, w, h)
		Return h
	End Method
	
End Type

Type TwxListBox Extends TwxGadget

	Field imageList:wxImageList

	Method InitGadget()
		CreateListBox()
	End Method
	
	Method CreateListBox()
	
		widget = New MaxGuiwxListCtrl.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, wxLC_REPORT | wxLC_NO_HEADER | wxLC_SINGLE_SEL)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method InsertListItem(index:Int, text:String, tip:String, icon:Int, extra:Object)

		If Not imageList Then
			icon = -1
		End If
		
		MaxGuiwxListCtrl(widget).InsertListItem(index, text, icon, extra)
	End Method

	Method SetListItem(index:Int, text:String ,tip:String, icon:Int, data:Object)

		If Not imageList Then
			icon = -1
		End If
		
		MaxGuiwxListCtrl(widget).SetListItem(index, text, icon, data)
	End Method

	Method SetListItemState(index:Int, state:Int)
DebugLog "TwxListBox::SetListItemState"
		'MaxGuiQListView(widget).setListItemState(index, state)
	End Method

	Method ListItemState:Int(index:Int)
DebugLog "TwxListBox::ListItemState"
		'Return MaxGuiQListView(widget).listItemState(index)
	End Method

	'Method SelectItem:Int(index:Int, op:Int= 1) '0=deselect 1=select 2=toggle
'DebugLog "TQtListBox::SelectItem"
	'	MaxGuiQListView(widget).selectItem(index, op)
	'End Method

	Method RemoveListItem(index:Int)
		MaxGuiwxListCtrl(widget).DeleteItem(index)
	End Method

	Method ClearListItems()
		MaxGuiwxListCtrl(widget).DeleteAllItems()
	End Method

'	Method ItemState:Int(index:Int)
'DebugLog "TQtListBox::ItemState"
'	End Method

	Method SetIconStrip(iconstrip:TIconStrip)
		icons = TwxIconStrip(iconstrip)
		If icons Then
			imageList = icons.GetImageList()
			MaxGuiwxListCtrl(widget).SetImageList(imageList, wxIMAGE_LIST_SMALL)
		End If
	End Method

	Method Class:Int()
		Return GADGET_LISTBOX
	End Method

End Type

Type TwxHTMLView Extends TwxGadget
	Method CreateHTMLView:TwxHTMLView(x:Int, y:Int, w:Int, h:Int, label:String, group:TGadget, style:Int) Abstract

	Method InitGadget() Abstract
	
	Method Stop() Abstract
	Method SetText(url:String) Abstract
	Method GetText:String() Abstract
	Method Activate(cmd:Int) Abstract
	
	Method Class:Int()
		Return GADGET_HTMLVIEW
	End Method

End Type

' +++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Type MaxGuiwxFrame Extends wxFrame

	Field gadget:TwxGadget
	
	' this is our "client area"
	' it automatically scales to fit the inside of the window.
	Field clientWidget:wxPanel

	Method MCreate:MaxGuiwxFrame(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		Local flags:Int
		
		If style & WINDOW_TOOL Then
			flags :| wxFRAME_TOOL_WINDOW
		End If
		
		If style & WINDOW_TITLEBAR Then
			flags :| wxDEFAULT_FRAME_STYLE
		End If
		
		gadget = owner
		Super.Create(parent, -1, "", x, y, w, h, flags)
		Return Self
	End Method

	Method OnInit()
		clientWidget = New wxPanel.Create(Self, wxID_ANY)

		ConnectAny(wxEVT_CLOSE_WINDOW, _OnCloseWindow)
		ConnectAny(wxEVT_SIZE, _OnSizeWindow)
	End Method
	
	Function _OnCloseWindow(event:wxEvent)
		MaxGuiwxFrame(event.parent).OnCloseWindow(wxCloseEvent(event))
	End Function
	
	Method OnCloseWindow(event:wxCloseEvent)
		PostGuiEvent EVENT_WINDOWCLOSE, gadget
		Destroy()
	End Method

	Function _OnSizeWindow(event:wxEvent)
		MaxGuiwxFrame(event.parent).OnSizeWindow(wxSizeEvent(event))
	End Function

	Method OnSizeWindow(event:wxSizeEvent)
		If Not gadget.initing Then
			Local w:Int, h:Int
			event.GetSize(w, h)
		
			gadget.SetRect(gadget.xpos, gadget.ypos, w, h)
			gadget.layoutKids

			PostGuiEvent EVENT_WINDOWSIZE, gadget ,,,w,h
		End If
		
		Event.Skip()
	End Method

End Type

Type MaxGuiwxButton Extends wxButton

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxButton(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		
		Local id:Int = -1
		If style = BUTTON_OK Then
			id = wxID_OK
		End If
		
		Super.Create(parent, id, "", x, y, w, h, 0)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_COMMAND_BUTTON_CLICKED, OnClick)
	End Method

	Function OnClick(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxButton(event.parent).gadget
	End Function
	
End Type

Type MaxGuiwxCheckBox Extends wxCheckBox

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxCheckBox(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, Null, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_COMMAND_CHECKBOX_CLICKED, OnClick)
	End Method

	Function OnClick(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxCheckBox(event.parent).gadget
	End Function
	
End Type

Type MaxGuiwxToggleButton Extends wxToggleButton

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxToggleButton(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, Null, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, OnClick)
	End Method

	Function OnClick(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxToggleButton(event.parent).gadget
	End Function
	
End Type

Type MaxGuiwxRadioButton Extends wxRadioButton

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxRadioButton(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, Null, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_COMMAND_RADIOBUTTON_SELECTED, OnClick)
	End Method

	Function OnClick(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxRadioButton(event.parent).gadget
	End Function
	
End Type

Type MaxGuiwxStaticText Extends wxStaticText

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxStaticText(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, Null, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
	End Method

End Type

Type MaxGuiwxStaticLine Extends wxStaticLine

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxStaticLine(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
	End Method

End Type

Type MaxGuiwxTextCtrl Extends wxTextCtrl

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxTextCtrl(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, "", x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_COMMAND_TEXT_UPDATED, OnEdit)
	End Method

	Function OnEdit(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxTextCtrl(event.parent).gadget
	End Function

End Type

Type MaxGuiwxPanel Extends wxPanel

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxPanel(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_MOUSE_EVENTS, OnMouseEvent, Self)
	End Method
	
	Function OnMouseEvent(event:wxEvent)
		If MaxGuiwxPanel(event.parent).gadget.sensitivity & SENSITIZE_MOUSE Then
			Local evt:wxMouseEvent = wxMouseEvent(event)
			Local x:Int, y:Int
			evt.GetPosition(x, y)
		
			Select evt.GetEventType()
				Case wxEVT_ENTER_WINDOW
					PostGuiEvent EVENT_MOUSEENTER, MaxGuiwxPanel(event.parent).gadget

				Case wxEVT_LEAVE_WINDOW
					PostGuiEvent EVENT_MOUSELEAVE, MaxGuiwxPanel(event.parent).gadget

				Case wxEVT_MOTION
					PostGuiEvent EVENT_MOUSEMOVE, MaxGuiwxPanel(event.parent).gadget, wxMouseButtonToMaxMouseButton(evt.GetButton()), , x, y

				Case wxEVT_LEFT_DOWN, wxEVT_MIDDLE_DOWN
					PostGuiEvent EVENT_MOUSEDOWN, MaxGuiwxPanel(event.parent).gadget, wxMouseButtonToMaxMouseButton(evt.GetButton()), , x, y

				Case wxEVT_RIGHT_DOWN
					PostGuiEvent EVENT_GADGETMENU, MaxGuiwxPanel(event.parent).gadget, MOUSE_RIGHT, , x, y

				Case wxEVT_LEFT_UP, wxEVT_RIGHT_UP, wxEVT_MIDDLE_UP
					PostGuiEvent EVENT_MOUSEUP, MaxGuiwxPanel(event.parent).gadget, wxMouseButtonToMaxMouseButton(evt.GetButton()), , x, y
				
				Case wxEVT_MOUSEWHEEL
					PostGuiEvent EVENT_MOUSEWHEEL, MaxGuiwxPanel(event.parent).gadget, evt.GetWheelRotation(), , x, y
			End Select
		End If
	End Function

End Type

Type MaxGuiwxStaticBox Extends wxStaticBox

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxStaticBox(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, "", x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()

	End Method

End Type

Type MaxGuiwxSlider Extends wxSlider

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxSlider(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, 1, 1, 10, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_SCROLL, OnScroll, Self)
	End Method
	
	Function OnScroll(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxSlider(event.parent).gadget, wxScrollEvent(event).GetPosition()
	End Function

End Type

Type MaxGuiwxSpinButton Extends wxSpinButton

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxSpinButton(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_SPIN, OnSpin, Self)
	End Method

	Function OnSpin(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxSpinButton(event.parent).gadget, wxSpinEvent(event).GetPosition()
	End Function

End Type

Type MaxGuiwxScrollBar Extends wxScrollBar

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxScrollBar(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_SCROLL, OnScroll, Self)
	End Method
	
	Function OnScroll(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxScrollBar(event.parent).gadget, wxScrollEvent(event).GetPosition()
	End Function

End Type

Type MaxGuiwxGauge Extends wxGauge

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxGauge(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, 100, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()

	End Method
	
End Type

Type MaxGuiwxComboBox Extends wxComboBox

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxComboBox(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, "", Null, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		Connect(-1, wxEVT_COMMAND_COMBOBOX_SELECTED, OnSelected, Self)
	End Method

	Function OnSelected(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxComboBox(event.parent).gadget, MaxGuiwxComboBox(event.parent).GetSelection()
	End Function
	
End Type

Type MaxGuiwxChoice Extends wxChoice

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxChoice(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, Null, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		Connect(-1, wxEVT_COMMAND_CHOICE_SELECTED, OnSelected, Self)
	End Method

	Function OnSelected(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxChoice(event.parent).gadget, MaxGuiwxChoice(event.parent).GetSelection()
	End Function
	
End Type

Type MaxGuiwxListCtrl Extends wxListCtrl

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxListCtrl(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()

		InsertColumn(0, "Column 1")
		
		UpdateColumnWidth()
	End Method
	
	' call this whenever we resize
	Method UpdateColumnWidth()
		Local w:Int, h:Int
		GetSize(w, h)
		SetColumnWidth(0, w)
	End Method

	Method InsertListItem(index:Int, text:String, icon:Int, data:Object)
		If icon >= 0 Then
			InsertImageStringItem(index, text, icon)
		Else
			InsertStringItem(index, text)
		End If
		SetItemData(index, data)
	End Method
	
	Method SetListItem(index:Int, text:String, icon:Int, data:Object)
		SetStringItem(index, 0, text, icon)
		SetItemData(index, data)
	End Method
	
End Type
