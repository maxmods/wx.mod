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

Import "wxcommon.bmx"
Import "wxgadget.bmx"
?linux
Import "fdhandler.c"
?

Global wxDriver:TwxGUIDriver =New TwxGUIDriver

Type TwxGuiSystemDriver Extends TwxSystemDriver
	Field gui:TwxGUIDriver

?linux
	Field gsource:Byte Ptr
?
	Method Poll()
		' fun with hand-crafted event handling...
		While Not bmx_wxapp_pending() And bmx_wxapp_processidle() ; Wend
		While bmx_wxapp_pending()
			If Not bmx_wxapp_dispatch() Then
				Exit
			End If
		Wend

		DispatchGuiEvents()
	End Method
		
	Method Wait()
		Poll()
?linux
		' some crazy glib stuff
		While Not g_main_context_iteration(g_main_context_default(), True)
		Wend
?Not linux
		Super.Wait()
?
	End Method
			
	Function Create:TwxGuiSystemDriver(host:TwxGUIDriver)
		Local guisystem:TwxGuiSystemDriver		
		guisystem=New TwxGuiSystemDriver
		guisystem.gui=host
?linux
		' attach max's fd to a glib event source so things like timers can work
		guisystem.gsource = bmx_wxmg_event_source_new(bbSystemAsyncFD())
?
		Return guisystem
	End Function
	
End Type

Type TwxSystemDriver Extends TSystemDriver

	Field NativeDriver:TSystemDriver

	Method New()
		NativeDriver=brl.System.Driver
	End Method
	
	Method Poll()
		NativeDriver.Poll()
	End Method
		
	Method Wait()
		NativeDriver.Wait()
	End Method
	
	Method Emit( osevent:Byte Ptr,source:Object )
		Throw "oops"
	End Method

	Method IsFullScreen:Int()
		Return False
	End Method	

	Method SetMouseVisible(bool:Int)
		NativeDriver.SetMouseVisible bool
	End Method

	Method MoveMouse( x:Int, y:Int )
		NativeDriver.MoveMouse x,y
	End Method

	Method Notify( text:String, serious:Int )
		Local msgBox:wxMessageDialog = New wxMessageDialog.Create(Null, text)
		
		msgBox.ShowModal()
		msgBox.Free()
	End Method
	
	Method Confirm:Int( text:String, serious:Int )
Rem
		Local msgBox:QMessageBox = New QMessageBox.Create()
		msgBox.setText(text)
		msgBox.setStandardButtons(QMessageBox.Button_Ok | QMessageBox.Button_Cancel)
	
		If serious Then
			msgBox.setIcon(QMessageBox.Icon_Critical)
		Else
			msgBox.setIcon(QMessageBox.Icon_Information)
		End If
		
		Local ret:Int = msgBox.exec()
		
		msgBox.free()
		
		Select ret
			Case QMessageBox.Button_Ok
				Return 1
			Case QMessageBox.Button_Cancel
				Return 0
		End Select
End Rem
	End Method

	Method Proceed:Int( text:String, serious:Int )
Rem
		Local msgBox:QMessageBox = New QMessageBox.Create()
		msgBox.setText(text)
		msgBox.setStandardButtons(QMessageBox.Button_Yes | QMessageBox.Button_No | QMessageBox.Button_Cancel)

		If serious Then
			msgBox.setIcon(QMessageBox.Icon_Critical)
		Else
			msgBox.setIcon(QMessageBox.Icon_Information)
		End If
		
		Local ret:Int = msgBox.exec()
		
		msgBox.free()
		
		Select ret
			Case QMessageBox.Button_Yes
				Return 1
			Case QMessageBox.Button_No
				Return 0
		End Select
		
		' otherwise we cancelled
		Return -1
End Rem
	End Method
	
	Method RequestFile:String(text:String, exts:String, Save:Int, file:String)
		Local filename:String
		
		If save Then
			filename = wxFileSelector(text, ExtractDir(file), StripDir(file), "", buildExtFilter(exts))
		Else
			filename = wxFileSelector(text, ExtractDir(file), StripDir(file), "", buildExtFilter(exts))
		End If
		
		Return filename
	End Method
	
	Method RequestDir:String( text:String, path:String )
		Return wxDirSelector(text, path)
	End Method

	Method OpenURL:Int( url:String )
		Return NativeDriver.OpenURL(url)
	End Method

	Method buildExtFilter:String(exts:String)
		Local filter:String
		
		If exts Then
		
			' split into groups
			Local groups:String[] = exts.Split(";")
			
			For Local group:String = EachIn groups
			
				' split into name:exts pairs
				Local pairs:String[] = group.Split(":")
				
				Local name:String ' optional
				Local extensions:String[]
				
				If pairs.length = 1 Then
					extensions = pairs[0].Split(",")
				Else
					name = pairs[0]
					extensions = pairs[1].Split(",")
				End If
				
				If filter Then
					filter :+ "|"
				End If
				
				If name Then
					filter :+ name + " "
				End If
				
				filter :+ "("
				
				Local exts:String
				For Local extension:String = EachIn extensions
					If exts Then
						exts :+ " "
					End If
			
					If extension <> "*" Then
						exts :+ "*."
					End If
					
					exts :+ extension.Trim()
				Next
				filter :+ exts
				
				filter :+ ")"
			Next
		
		End If
		
		Return filter
	End Method

End Type

Type TMaxGUIApp Extends wxApp

	Method OnInit:Int()

		ConnectAny(wxEVT_ACTIVATE_APP, OnActivate)
	
		Return True
	
	End Method
	
	Function OnActivate(event:wxEvent)
		If wxActivateEvent(event).GetActive() Then
			PostGUIEvent EVENT_APPRESUME
		Else
			PostGUIEvent EVENT_APPSUSPEND
		End If
		event.Skip()
	End Function

End Type

Type TwxGUIDriver Extends TMaxGUIDriver

	Field app:TMaxGUIApp

	Method New()
		app = New TMaxGUIApp
		
		app.EntryStart()
	
		brl.System.Driver = TwxGuiSystemDriver.Create(Self)

		maxgui_driver=Self
		
		
		AddHook EmitEventHook, eventHandler, Null, True
	End Method

	Method LoadFont:TGuiFont(name:String, size:Int, flags:Int)
	
		Local font:wxFont
		Local weight:Int = wxFONTWEIGHT_NORMAL
		Local style:Int = wxFONTSTYLE_NORMAL
		Local underline:Int
		
		If flags & FONT_BOLD Then
			weight = wxFONTWEIGHT_BOLD
		End If
		
		If flags & FONT_ITALIC Then
			style = wxFONTSTYLE_ITALIC
		End If

		If flags & FONT_UNDERLINE Then
			underline = True
		End If

		font = New wxFont.CreateWithAttribs(size, wxFONTFAMILY_DEFAULT, weight, style, underline, name)
		
		If flags & FONT_STRIKETHROUGH Then
			font.SetStrikethrough(True)
		End If
		
		Return New TwxGuiFont.Create(font)
	End Method
	
	Method DoLoadFont:TGuiFont(font:TGuiFont)
		DebugLog "TODO : TwxGUIDriver::DoLoadFont"
	End Method

	Method LibraryFont:TGuiFont( fontType:Int = GUIFONT_SYSTEM, size:Double = 0, style:Int = FONT_NORMAL )
		If fontType = GUIFONT_SYSTEM Then
			Local font:wxFont = wxSystemSettings.GetFont(wxSYS_SYSTEM_FONT)
			
			If size <= 0 Then
				Local w:Int, h:Int
				font.GetPixelSize(w, h)
				size = h
				
				If size < 0 Then
					size = font.GetPointSize()
				End If
			End If

			Return LoadFontWithDouble( font.GetFaceName(), size, TwxGuiFont.styleFromFont(font) | style )
		Else
			Return Super.LibraryFont( fontType, size, style )
		EndIf
	End Method
	
	Method CreateGadget:TGadget(GadgetClass:Int, name:String, x:Int, y:Int, w:Int, h:Int,group:TGadget, style:Int)

		Local gadget:TwxGadget
'		Local gtkclass:Int = -1
'		Local gtkGroup:TQtGadget

		Select GadgetClass
			Case GADGET_DESKTOP
				Return New TwxDesktop.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
			Case GADGET_WINDOW
				Return New TwxWindow.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
			Case GADGET_BUTTON
				Select style & 7
					Case 0, BUTTON_OK, BUTTON_CANCEL
						Return New TwxPushButton.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
					Case BUTTON_CHECKBOX
						If style & BUTTON_PUSH Then
							Return New TwxToggleButton.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
						Else
							Return New TwxCheckBox.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
						End If
					Case BUTTON_RADIO
						If style & BUTTON_PUSH Then
							Return New TwxToggleButton.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
						Else
							Return New TwxRadioButton.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
						End If
				End Select

			Case GADGET_PANEL
				Select style & (PANEL_GROUP|PANEL_SUNKEN|PANEL_RAISED)
					Case PANEL_GROUP
						Return New TwxStaticBox.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
					Default
						Return New TwxPanel.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
				End Select

			Case GADGET_TEXTFIELD
				Return New TwxTextField.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
Rem
			Case GADGET_TEXTAREA
				Return New TQtTextArea.CreateGadget(name, x, y, w, h, TQtGadget(group), style)
End Rem
			Case GADGET_COMBOBOX
				Return New TwxComboBox.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
			Case GADGET_LISTBOX
				Return New TwxListBox.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
Rem 
			Case GADGET_TOOLBAR
				Return New TQtToolBar.CreateGadget(name, x, y, w, h, TQtGadget(group), style)
			Case GADGET_TABBER
				Return New TQtTabber.CreateGadget(name, x, y, w, h, TQtGadget(group), style)
			Case GADGET_TREEVIEW
				Return New TQtTreeView.CreateGadget(name, x, y, w, h, TQtGadget(group), style)
End Rem

			Case GADGET_HTMLVIEW
				If wxmaxgui_htmlview Then
					Return wxmaxgui_htmlview.CreateHTMLView(name, x, y, w, h, TwxGadget(group), style)
				Else
					Throw "No HTMLView specified. You need To Import one!    " + ..
						" Import wx.wxmaxguiwebview " + ..
						" or    " + ..
						" Import wx.wxmaxguihtmlwindow"
				End If

			Case GADGET_LABEL
				If style & 3 = LABEL_SEPARATOR Then
					Return New TwxSeparator.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
				Else
					Return New TwxLabel.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
				End If

			Case GADGET_SLIDER
				If style & SLIDER_STEPPER Then
					Return New TwxStepper.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
				Else If style & SLIDER_TRACKBAR Then
					Return New TwxTrackBar.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
				Else
					Return New TwxScrollBar.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
				End If 
			Case GADGET_PROGBAR
				Return New TwxProgressBar.CreateGadget(name, x, y, w, h, TwxGadget(group), style)
Rem 
			Case GADGET_MENUITEM
				Return New TQtMenuItem.CreateGadget(name, x, y, w, h, TQtGadget(group), style)
			Case GADGET_CANVAS
				Return New TQtCanvas.CreateGadget(name, x, y, w, h, TQtGadget(group), style)
End Rem
		End Select

	End Method
	
	Function eventHandler:Object(id:Int, data:Object, context:Object )

		'DebugLog "event : " + event.id + " : " + EVENT_WINDOWSIZE
		
'		Local event:TEvent = TEvent(data)
'		Local gadget:TwxGadget = TwxGadget(event.source)
		
'		If gadget Then
'			Select event.id
'				Case EVENT_WINDOWSIZE
'DebugLog "EVENT_WINDOWSIZE"
'					If gadget.width <> event.x Or gadget.height <> event.y Then
'DebugLog "Need layout"
'DebugStop
'						gadget.SetRect gadget.xpos,gadget.ypos,event.x,event.y
'						gadget.LayoutKids
'					Else
'						Return data
'					EndIf
'			End Select
'		End If

		Return data
	End Function

	Method ActiveGadget:TGadget()
		DebugLog "TODO : TwxGUIDriver::ActiveGadget"
	End Method
	
	Method RequestColor:Int(r:Int, g:Int, b:Int)
		Local rc:Int, gc:Int, bc:Int
		Local color:wxColour = wxGetColourFromUser(Null, New wxColour.Create(r, g, b))
		
		If color.IsOk()
			color.GetRGB(rc, gc, bc)
			Return $ff000000 | (rc Shl 16) | (gc Shl 8) | bc
		End If
		
		Return 0
	End Method
	
	Method RequestFont:TGuiFont(font:TGuiFont)
		Local f:wxFont
		If font Then
			f = TwxGuiFont(font).font
		End If
		f = wxGetFontFromUser(Null, f)
		Return New TwxGuiFont.Create(f)
	End Method
	
	Method SetPointer(shape:Int)

		' undo the last change
		wxSetCursor(Null)
		
		Local cursor:Int
		Select shape
			Case POINTER_DEFAULT
				' just return to the standard cursor
				Return
			Case POINTER_ARROW
				cursor = wxCURSOR_ARROW
			Case POINTER_IBEAM
				cursor = wxCURSOR_IBEAM
			Case POINTER_WAIT
				cursor = wxCURSOR_WAIT
			Case POINTER_CROSS
				cursor = wxCURSOR_CROSS
			Case POINTER_UPARROW
				cursor = wxCURSOR_RIGHT_ARROW ' ???
			Case POINTER_SIZENWSE
				cursor = wxCURSOR_SIZENWSE
			Case POINTER_SIZENESW
				cursor = wxCURSOR_SIZENESW
			Case POINTER_SIZEWE
				cursor = wxCURSOR_SIZEWE
			Case POINTER_SIZENS
				cursor = wxCURSOR_SIZENS
			Case POINTER_SIZEALL
				cursor = wxCURSOR_SIZING
			Case POINTER_NO
				cursor = wxCURSOR_NO_ENTRY
			Case POINTER_HAND
				cursor = wxCURSOR_HAND
			Case POINTER_APPSTARTING
				cursor = wxCURSOR_WATCH
			Case POINTER_HELP
				cursor = wxCURSOR_QUESTION_ARROW
		End Select
		
		wxSetCursor(New wxCursor.StockCreate(cursor))

	End Method
	
	Method LoadIconStrip:TIconStrip(source:Object)
		Return TwxIconStrip.Create(source)
	End Method
	
	Method UserName:String()
		Return wxGetUserName()
	End Method
	
	Method ComputerName:String()
		Return wxGetHostName()
	End Method

End Type

Type TwxWebDriver
	Method CreateHTMLView:TGadget(text:String, x:Int, y:Int, w:Int, h:Int, group:TwxGadget, style:Int) Abstract
End Type

Global wxmaxgui_htmlview:TwxWebDriver

?linux
Extern
	Function bmx_wxmg_event_source_new:Byte Ptr(fd:Int)
	
	Function g_main_context_iteration:Int(context:Byte Ptr, block:Int)
	Function g_main_context_default:Byte Ptr()
End Extern
?