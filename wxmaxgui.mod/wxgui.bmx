SuperStrict

Import "wxcommon.bmx"
Import "wxgadget.bmx"

Global wxDriver:TwxGUIDriver =New TwxGUIDriver

Type TwxGuiSystemDriver Extends TwxSystemDriver
	Field gui:TwxGUIDriver

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

		Super.Wait()

	End Method
			
	Function Create:TwxGuiSystemDriver(host:TwxGUIDriver)
		Local guisystem:TwxGuiSystemDriver		
		guisystem=New TwxGuiSystemDriver
		guisystem.gui=host

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
'		Local msgBox:QMessageBox = New QMessageBox.Create()
'		msgBox.setText(text)
'
'		If serious Then
'			msgBox.setIcon(QMessageBox.Icon_Critical)
'		End If
'		
'		msgBox.exec()
'		msgBox.free()
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
'		Local filename:String
'		
'		If save Then
'			filename = QFileDialog.getSaveFileName(Null, text, file, buildExtFilter(exts))
'		Else
'			filename = QFileDialog.getOpenFileName(Null, text, file, buildExtFilter(exts))
'		End If
'		
'		Return filename
	End Method
	
	Method RequestDir:String( text:String, path:String )
'		Return QFileDialog.getExistingDirectory(Null, text, path)
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
					filter :+ ";;"
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

		Return True
	
	End Method

End Type

Type TwxGUIDriver Extends TMaxGUIDriver

	Field app: TMaxGUIApp

	Method New()
		app = New TMaxGUIApp
		
		app.EntryStart()
	
		brl.System.Driver = TwxGuiSystemDriver.Create(Self)

		maxgui_driver=Self
		
		
		AddHook EmitEventHook, eventHandler, Null, True
	End Method

	Method LoadFont:TGuiFont(name:String, size:Int, flags:Int)
	
Rem		Local font:QFont
		Local weight:Int = QFont.Weight_Normal
		Local italic:Int
		
		If flags & FONT_BOLD Then
			weight = QFont.Weight_Bold
		End If
		
		If flags & FONT_ITALIC Then
			italic = True
		End If
	
		font = New QFont.Create(name, size, weight, italic)
		
		If flags & FONT_UNDERLINE Then
			font.setUnderline(True)
		End If
		
		If flags & FONT_STRIKETHROUGH Then
			font.setStrikeOut(True)
		End If
		
		Return New TQtGuiFont.Create(font)
End Rem
	End Method
	
	Method DoLoadFont:TGuiFont(font:TGuiFont)
		DebugLog "TODO : TwxGUIDriver::DoLoadFont"
	End Method

	Method LibraryFont:TGuiFont( fontType:Int = GUIFONT_SYSTEM, size:Double = 0, style:Int = FONT_NORMAL )
Rem
		If fontType = GUIFONT_SYSTEM Then
			Local font:QFont = QApplication.font()
			
			If size <= 0 Then
				size = font.pixelSize()
				
				If size < 0 Then
					size = font.pointSize()
				End If
			End If

			Return LoadFontWithDouble( font.family(), size, TQtGuiFont.styleFromFont(font) | style )
		Else
			Return Super.LibraryFont( fontType, size, style )
		EndIf
End Rem
	EndMethod
	
	Method CreateGadget:TGadget(GadgetClass:Int, name:String, x:Int, y:Int, w:Int, h:Int,group:TGadget, style:Int)

		Local gadget:TwxGadget
'		Local gtkclass:Int = -1
'		Local gtkGroup:TQtGadget

		Select GadgetClass
			'Case GADGET_DESKTOP
			'	Return New TQtDesktop.CreateGadget(name, x, y, w, h, TQtGadget(group), style)
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
Rem
			Case GADGET_LISTBOX
				Return New TQtListBox.CreateGadget(name, x, y, w, h, TQtGadget(group), style)
			Case GADGET_TOOLBAR
				Return New TQtToolBar.CreateGadget(name, x, y, w, h, TQtGadget(group), style)
			Case GADGET_TABBER
				Return New TQtTabber.CreateGadget(name, x, y, w, h, TQtGadget(group), style)
			Case GADGET_TREEVIEW
				Return New TQtTreeView.CreateGadget(name, x, y, w, h, TQtGadget(group), style)
			Case GADGET_HTMLVIEW
				Return New TQtHtmlView.CreateGadget(name, x, y, w, h, TQtGadget(group), style)
End Rem
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
Rem
		'DebugLog "event : " + event.id + " : " + EVENT_WINDOWSIZE
		
		Local event:TEvent = TEvent(data)
		Local gadget:TQtGadget = TQtGadget(event.source)
		
		If gadget Then
			Select event.id
				Case EVENT_WINDOWSIZE
'DebugLog "EVENT_WINDOWSIZE"
					If gadget.width <> event.x Or gadget.height <> event.y Then
'DebugLog "Need layout"
'DebugStop
						gadget.SetRect gadget.xpos,gadget.ypos,event.x,event.y
						gadget.LayoutKids
					Else
						Return data
					EndIf
			End Select
		End If
End Rem
		Return data
	End Function

	Method ActiveGadget:TGadget()
		DebugLog "TODO : TwxGUIDriver::ActiveGadget"
	End Method
	
	Method RequestColor:Int(r:Int, g:Int, b:Int)
Rem
		Local rc:Int, gc:Int, bc:Int
		Local color:QColor = QColorDialog.GetColor(New QColor.Create(r, g, b))
		
		If color.isValid()
			color.getRgb(rc, gc, bc)
			Return $ff000000 | (rc Shl 16) | (gc Shl 8) | bc
		End If
		
		Return 0
End Rem
	End Method
	
	Method RequestFont:TGuiFont(font:TGuiFont)
Rem
		Local ok:Int
		Local f:QFont = QFontDialog.getFontWithInitial(ok, TQtGuiFont(font).font)
		Return New TQtGuiFont.Create(f)
End Rem
	End Method
	
	Method SetPointer(shape:Int)
Rem
		' undo the last change
		QApplication.restoreOverrideCursor()
		
		Local cursor:Int
		Select shape
			Case POINTER_DEFAULT
				' just return to the standard cursor
				Return
			Case POINTER_ARROW
				cursor = Qt_ArrowCursor
			Case POINTER_IBEAM
				cursor = Qt_IBeamCursor
			Case POINTER_WAIT
				cursor = Qt_WaitCursor
			Case POINTER_CROSS
				cursor = Qt_CrossCursor
			Case POINTER_UPARROW
				cursor = Qt_UpArrowCursor
			Case POINTER_SIZENWSE
				cursor = Qt_SizeFDiagCursor
			Case POINTER_SIZENESW
				cursor = Qt_SizeBDiagCursor
			Case POINTER_SIZEWE
				cursor = Qt_SizeHorCursor
			Case POINTER_SIZENS
				cursor = Qt_SizeVerCursor
			Case POINTER_SIZEALL
				cursor = Qt_SizeAllCursor
			Case POINTER_NO
				cursor = Qt_ForbiddenCursor
			Case POINTER_HAND
				cursor = Qt_OpenHandCursor
			Case POINTER_APPSTARTING
				cursor = Qt_BusyCursor
			Case POINTER_HELP
				cursor = Qt_WhatsThisCursor
		End Select
		
		QApplication.setOverrideCursor(New QCursor.Create(cursor))
End Rem
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

