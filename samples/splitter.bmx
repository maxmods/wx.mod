Rem

C++ Splitter sample author info from which this .bmx was ported:

/////////////////////////////////////////////////////////////////////////////
// Name:        splitter.cpp
// Purpose:     wxSplitterWindow sample
// Author:      Julian Smart
// Modified by:
// Created:     04/01/98
// RCS-ID:      $Id: splitter.cpp,v 1.24 2005/03/30 15:36:15 JS Exp $
// Copyright:   (c) Julian Smart
// Licence:     wxWindows license
/////////////////////////////////////////////////////////////////////////////

End Rem

SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxScrolledWindow
Import wx.wxSplitterWindow
Import wx.wxDC
Import wx.wxTextCtrl
Import wx.wxTextEntryDialog
Import wx.wxLog



' ----------------------------------------------------------------
Rem
	bbdoc:   
	about:    
End Rem	
Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(,,"wxSplitterWindow sample", 420, 300))

		SetTopWindow(frame)
		
		frame.show()
		
		Return True
	
	End Method

End Type

' ----------------------------------------------------------------
Rem
	bbdoc:   
	about:    
End Rem	
Type MyFrame Extends wxFrame

	Const	SPLIT_QUIT:Int		= 1,..
	    		SPLIT_HORIZONTAL:Int 	= 2,..
	    		SPLIT_VERTICAL:Int 		= 3,..
	   		SPLIT_UNSPLIT:Int		= 4,..
	    		SPLIT_LIVE:Int 			= 5,..
	    		SPLIT_SETPOSITION:Int 	= 6,..
	    		SPLIT_SETMINSIZE:Int 	= 7,..
	    		SPLIT_SETGRAVITY:Int	= 8,..
	    		SPLIT_REPLACE:Int		= 9

	'	If these were fields we would have to use casts in the Connect functions. See SplitHorizontal for more...
	Global m_left:wxScrolledWindow
	Global m_right:wxScrolledWindow
	Global m_splitter:MySplitterWindow
	Global m_replacewindow:wxWindow
	Global m_frame:MyFrame = Null

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method Delete()
	
		If m_replacewindow
		
			m_replacewindow.Destroy()
			m_replacewindow = Null
		
		EndIf
		
	End Method

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method OnInit()
		
		m_frame = Self
					
		CreateStatusBar(2)
		
		Local splitMenu:wxMenu = wxMenu.CreateMenu()
		splitMenu.Append(SPLIT_VERTICAL,"Split &Vertically~tCtrl-V","Split vertically")
		splitMenu.Append(SPLIT_HORIZONTAL,"Split &Horizontally~tCtrl-H","Split horizontally")
		splitMenu.Append(SPLIT_UNSPLIT,"&Unsplit~tCtrl-U","Unsplit")
		splitMenu.AppendSeparator()
		splitMenu.AppendCheckItem(SPLIT_LIVE,"&Live update~tCtrl-L","Toggle live update mode")
		splitMenu.Append(SPLIT_SETPOSITION,"Set splitter &position~tCtrl-P","Set the splitter position")
		splitMenu.Append(SPLIT_SETMINSIZE,"Set &min size~tCtrl-M","Set minimum pane size")
		splitMenu.Append(SPLIT_SETGRAVITY,"Set &gravity~tCtrl-G","Set gravity of sash")
		splitMenu.AppendSeparator()
		splitMenu.Append(SPLIT_REPLACE,"&Replace right window","Replace right window")
		splitMenu.AppendSeparator()
		splitMenu.Append(SPLIT_QUIT,"E&xit~tAlt-X","Exit")
		
		Local menuBar:wxMenuBar = wxMenuBar.CreateMenuBar()
		menuBar.Append(splitMenu,"&Splitter")
		SetMenuBar(menuBar)
			
		menuBar.Check(SPLIT_LIVE,True)
		m_splitter = New MySplitterWindow.CreateMySplitterWindow(Self)
		m_splitter.SetSashGravity(1.0)
		
		m_left = New MyCanvas.CreateMyCanvas(m_splitter,True)
		m_left.SetBackgroundColour(wxRED())
		m_left.SetScrollbars(20,20,5,5)
		m_left.SetCursor(New wxCursor.StockCreate(wxCURSOR_MAGNIFIER))
	
		m_right = New MyCanvas.CreateMyCanvas(m_splitter,False)
		m_right.SetBackgroundColour(wxCYAN())
		m_right.SetScrollbars(20,20,5,5)


'		Alternate code route as found in the C++ source...
?NEVER		
		m_left = New wxTextCtrl.Create(m_splitter, wxID_ANY, "first text")
		m_right = New wxTextCtrl.Create(m_splitter, wxID_ANY, "second text") 
		
		'	You can also do this to start with a single window
		m_right.Show(False)
		m_splitter.Initialize(m_left)
?

		'	You can also try -100
		m_splitter.SplitVertically(m_left,m_right, 100)
		
		SetStatusText("Min pane size = 0",1)
		
		m_replacewindow =Null
		
		Connect(SPLIT_VERTICAL, wxEVT_COMMAND_MENU_SELECTED, SplitVertical)
		Connect(SPLIT_HORIZONTAL, wxEVT_COMMAND_MENU_SELECTED, SplitHorizontal)
		Connect(SPLIT_UNSPLIT, wxEVT_COMMAND_MENU_SELECTED, Unsplit)
		Connect(SPLIT_LIVE, wxEVT_COMMAND_MENU_SELECTED, ToggleLive)
		Connect(SPLIT_SETPOSITION, wxEVT_COMMAND_MENU_SELECTED, SetSashPosition)
		Connect(SPLIT_QUIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(SPLIT_SETMINSIZE, wxEVT_COMMAND_MENU_SELECTED, SetMinimumSize)
		Connect(SPLIT_SETGRAVITY, wxEVT_COMMAND_MENU_SELECTED, SetGravity)
		Connect(SPLIT_REPLACE, wxEVT_COMMAND_MENU_SELECTED, ReplaceWindow)
		
		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)	
		Connect(SPLIT_VERTICAL, wxEVT_UPDATE_UI, UpdateUIVertical)
		Connect(SPLIT_HORIZONTAL, wxEVT_UPDATE_UI, UpdateUIHorizontal)
		Connect(SPLIT_UNSPLIT, wxEVT_UPDATE_UI, UpdateUIUnsplit)
		
	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Function OnQuit(event:wxEvent)
		
		' true is to force the frame to close
		' MyFrame(event.parent).Close(True)
		'wxWindow(event.parent).Close(True)
		
		m_frame.Close(True)
		
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Function OnAbout(event:wxEvent)
		
		wxMessageBox("Welcome to " + wxVERSION_STRING + "!~n" + ..
                    "~n" + ..
                    "This is the splitter wxWidgets sample~n" + ..
                    "running under " + wxGetOsDescription() + ".", ..
                 "About wxWidgets splitter sample", ..
                 wxOK | wxICON_INFORMATION, wxWindow(event.parent))
		
	End Function

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function SplitHorizontal(_event:wxEvent)
		
		Local event:wxCommandEvent = (wxCommandEvent)(_event)
	
		' If m_splitter was a Field we could have accessed it like this: MyFrame(_event.parent).m_splitter. I have used globals to keep the code simple as possible
		If m_splitter.IsSplit() Then m_splitter.Unsplit()
	
		m_left.Show(True)
		m_right.Show(True)
		
		m_splitter.SplitHorizontally(m_left,m_right)
		
		m_frame.SetStatusText("Splitter split horizontally",1)
				
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function SplitVertical(_event:wxEvent)

		Local event:wxCommandEvent = (wxCommandEvent)(_event)
	
		If m_splitter.IsSplit() Then m_splitter.Unsplit()
	
		m_left.Show(True)
		m_right.Show(True)
		
		m_splitter.SplitVertically(m_left,m_right)
		
		m_frame.SetStatusText("Splitter split vertically",1)
				
	End Function

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function Unsplit(_event:wxEvent)
		
		Local event:wxCommandEvent = (wxCommandEvent)(_event)
	
		If m_splitter.IsSplit() Then m_splitter.Unsplit()
	
		m_frame.SetStatusText("No Splitter")
				
	End Function

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function ToggleLive(_event:wxEvent)
		
		Local event:wxCommandEvent = (wxCommandEvent)(_event)
	
		Local style:Int = m_splitter.GetWindowStyleFlag()
		
		If event.IsChecked()
			style :| wxSP_LIVE_UPDATE
		Else
			style :& ~wxSP_LIVE_UPDATE
		EndIf
		
		m_splitter.SetWindowStyleFlag(style)
						
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   Was SetPosition in the .cpp version
		about:    
	End Rem		
	Function SetSashPosition(_event:wxEvent)
		
		Local str:String 
		
		str = m_splitter.GetSashPosition()
		
		str = wxGetTextFromUser("Enter splitter position:","",str)
		If str.length <= 0 Then Return
		
		Local pos:Int
		
		pos = str.ToLong()
		
		If Not pos
			wxLogError("The splitter position should be an integer")
			Return
		End If
		
		m_splitter.SetSashPosition(pos)
		
		wxLogStatus("Splitter position set to " +pos)
	
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   Called SetMinSize in the .cpp source
		about:    
	End Rem		
	Function SetMinimumSize(_event:wxEvent)
	
		Local str:String
				
		str = m_splitter.GetSashPosition()
		str = wxGetTextFromUser("Enter minimal size for panes:","",str)
		If str.length <= 0 Return

		Local minsize:Int = str.ToInt()
		str = "Min pane size = " +minsize
		m_frame.SetStatusText(str,1)

	End Function

	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function SetGravity(_event:wxEvent)
	
		Local str:String
		
		str = m_splitter.GetSashGravity()
		str = wxGetTextFromUser("Enter sash gravity (0,1):","",str)
		If str.length <= 0 Return
		
		Local gravity:Double = Str.ToDouble()
		m_splitter.SetSashGravity(gravity)
		str = "Gravity = " +gravity
		m_frame.SetStatusText(str,1)
		
	End Function

	' ----------------------------------------------------------------
	Rem
		bbdoc: Called Replace in .cpp source  
		about:    
	End Rem		
	Function ReplaceWindow(_event:wxEvent)

		If Not m_replacewindow
			
			m_replacewindow = m_splitter.GetWindow2()
			If m_replacewindow = Null Throw "ReplaceWindow - m_replacewindow is Null!"
			m_splitter.ReplaceWindow(m_replacewindow,New wxPanel.Create(m_splitter,wxID_ANY))
			m_replacewindow.Hide()
		
		Else
		
			Local empty:wxWindow = m_splitter.GetWindow2()
			m_splitter.ReplaceWindow(empty,m_replacewindow)
			m_replacewindow.Show()
			m_replacewindow = Null
			empty.Destroy()
		End If
		
	End Function

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function UpdateUIHorizontal(_event:wxEvent)

		Local event:wxUpdateUIEvent = wxUpdateUIEvent(_event)
		
		event.Enable( Not m_splitter.IsSplit() Or m_splitter.GetSplitMode() <> wxSPLIT_HORIZONTAL )

	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function UpdateUIVertical(_event:wxEvent)

		Local event:wxUpdateUIEvent = wxUpdateUIEvent(_event)
		
		event.Enable( Not m_splitter.IsSplit() Or m_splitter.GetSplitMode() <> wxSPLIT_VERTICAL )

	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function UpdateUIUnsplit(_event:wxEvent)

		Local event:wxUpdateUIEvent = wxUpdateUIEvent(_event)
		
		event.Enable( m_splitter.IsSplit() )

	End Function
End Type

' ----------------------------------------------------------------
Rem
	bbdoc:   
	about:    
End Rem	
Type MySplitterWindow Extends wxSplitterWindow

	Global m_frame:MyFrame
	
	'	Obviously this would need to be a Field if you wanted more than one splitter window
	Global m_splitter:MySplitterWindow
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method CreateMySplitterWindow:MySplitterWindow(parent:wxWindow)
		m_frame = MyFrame(parent)
		create(parent,wxID_ANY,,,,,wxSP_3D | wxSP_LIVE_UPDATE | wxCLIP_CHILDREN)
		m_splitter = Self
		Return Self
	End Method	

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method OnInit()

		Connect(wxID_ANY, wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED, OnPositionChanged)
		Connect(wxID_ANY, wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING, OnPositionChanging)
		Connect(wxID_ANY, wxEVT_COMMAND_SPLITTER_DOUBLECLICKED, OnDClick)
		Connect(wxID_ANY, wxEVT_COMMAND_SPLITTER_UNSPLIT, OnUnsplitEvent)

	End Method

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Function OnPositionChanged(_event:wxEvent)
	
		Local event:wxSplitterEvent = (wxSplitterEvent)(_event)
	
		wxLogStatus("Position has changed, now = " +event.GetSashPosition() +" (or " +m_splitter.GetSashPosition() +")")
			
		event.Skip()
	
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Function OnPositionChanging(_event:wxEvent)
	
		Local event:wxSplitterEvent = (wxSplitterEvent)(_event)
	
		wxLogStatus("Position is changing, now = " +event.GetSashPosition() +" (or " +m_splitter.GetSashPosition() +")")
			
		event.Skip()
	
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Function OnDClick(_event:wxEvent)
	
		Local event:wxSplitterEvent = (wxSplitterEvent)(_event)
	
		m_frame.SetStatusText("Splitter double clicked",1)
		
		event.Skip()
		
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Function OnUnsplitEvent(_event:wxEvent)
	
		Local event:wxSplitterEvent = (wxSplitterEvent)(_event)
	
		m_frame.SetStatusText("Splitter unsplit",1)
		
		event.Skip()
		
	End Function

End Type

' ----------------------------------------------------------------
Rem
	bbdoc:   
	about:    
End Rem	
Type MyCanvas Extends wxScrolledWindow

	Field m_mirror:Int
	
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method CreateMyCanvas:MyCanvas(parent:wxWindow, mirror:Int)
		
		' wxNO_FULL_REPAINT_ON_RESIZE Omitted as it is obsolete, default behaviour and instantiated as 0
		create(parent,wxID_ANY,,,,,wxHSCROLL | wxVSCROLL)' | wxNO_FULL_REPAINT_ON_RESIZE) 
		
		m_mirror = mirror
		
		Return Self
	End Method	

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	
	Method OnDraw(dcOrig:wxDC)

		Local dc:wxMirrorDC = New wxMirrorDC.create(dcOrig,m_mirror)

		dc.SetPen(wxBLACK_PEN())
		dc.DrawLine(0,0,100,200)
		dc.SetBackgroundMode(wxTRANSPARENT)
		dc.DrawText("Testing",50,50)
		dc.SetPen(wxRED_PEN())
		dc.SetBrush(wxGREEN_BRUSH())
		dc.DrawRectangle(120,120,100,80)
		
		'	Remember to free the dc as the bmax garbage collector may not do so instantly
		dc.Free()
		
	End Method

End Type


New MyApp.run()
