SuperStrict

Framework wx.wxApp
Import wx.wxSheet
Import wx.wxFrame
Import wx.wxTextCtrl
Import wx.wxLog

New GridApp.run()


Type GridApp Extends wxApp

	Method OnInit:Int()

		Local frame:GridFrame = GridFrame(New GridFrame.Create(Null, -1, "wxSheet example"))
		
		frame.SetSize(800, 600)
		frame.show()
	
		Return True
	
	End Method

End Type


Type GridFrame Extends wxFrame

	Field grid:wxSheet
	Field logWin:wxTextCtrl
	Field logger:wxLogTextCtrl
	Field logBuf:String

	Field logOld:wxLog
	
	' add the cells To selection when using commands from Select menu?
	Field addToSel:Int
	
	Const ID_TOGGLEROWLABELS:Int = 100
	Const ID_TOGGLECOLLABELS:Int = 101
	Const ID_TOGGLEEDIT:Int = 102
	Const ID_TOGGLEROWSIZING:Int = 103
	Const ID_TOGGLECOLSIZING:Int = 104
	Const ID_TOGGLEROWSIZINGVETO:Int = 105
	Const ID_TOGGLECOLSIZINGVETO:Int = 106
	Const ID_TOGGLEGRIDSIZING:Int = 107
	Const ID_TOGGLEHORIZGRIDLINES:Int = 108
	Const ID_TOGGLEVERTGRIDLINES:Int = 109
	Const ID_HIDESELROWS:Int = 110
	Const ID_HIDESELCOLS:Int = 111
	Const ID_SHOWSELROWS:Int = 112
	Const ID_SHOWSELCOLS:Int = 113
	Const ID_AUTOSIZECOLS:Int = 114
	Const ID_CELLOVERFLOW:Int = 115
	Const ID_RESIZECELL:Int = 116
	Const ID_SETLABELCOLOUR:Int = 117
	Const ID_SETLABELTEXTCOLOUR:Int = 118
	Const ID_SETLABEL_FONT:Int = 119
	
	Const ID_SCROLLBARS_MENU:Int = 120
	Const ID_SCROLLBARS_AS_NEEDED:Int = 121
	Const ID_SCROLLBARS_HORIZ_NEVER:Int = 122
	Const ID_SCROLLBARS_VERT_NEVER:Int = 123
	Const ID_SCROLLBARS_NEVER:Int = 124
	Const ID_SCROLLBARS_HORIZ_ALWAYS:Int = 125
	Const ID_SCROLLBARS_VERT_ALWAYS:Int = 126
	Const ID_SCROLLBARS_ALWAYS:Int = 127
	
	Const ID_ROWLABELALIGN:Int = 128
	Const ID_ROWLABELHORIZALIGN:Int = 129
	Const ID_ROWLABELVERTALIGN:Int = 130
	
	Const ID_COLLABELALIGN:Int = 131
	Const ID_COLLABELHORIZALIGN:Int = 132
	Const ID_COLLABELVERTALIGN:Int = 133
	Const ID_GRIDLINECOLOUR:Int = 134
	Const ID_INSERTROW:Int = 135
	Const ID_INSERTCOL:Int = 136
	Const ID_DELETEROW:Int = 137
	Const ID_DELETECOL:Int = 138
	Const ID_CLEARGRID:Int = 139
	Const ID_ENABLEGRID:Int = 140
	Const ID_CHANGESEL:Int = 141
	Const ID_SELNONE:Int = 142
	Const ID_SELCELLS:Int = 143
	Const ID_SELROWS:Int = 144
	Const ID_SELCOLS:Int = 145
	Const ID_SELSINGLE:Int = 146
	Const ID_SET_CELL_FG_COLOUR:Int = 147
	Const ID_SET_CELL_BG_COLOUR:Int = 148
	Const ID_ABOUT:Int = 149
	Const ID_VTABLE:Int = 150
	Const ID_BUGS_TABLE:Int = 151
	Const ID_SMALL_GRID:Int = 152
	Const ID_SELECT_UNSELECT:Int = 153
	Const ID_SELECT_ALL:Int = 154
	Const ID_SELECT_ROW:Int = 155
	Const ID_SELECT_COL:Int = 156
	Const ID_SELECT_CELL:Int = 157
	Const ID_DESELECT_ALL:Int = 158
	Const ID_DESELECT_ROW:Int = 159
	Const ID_DESELECT_COL:Int = 160
	Const ID_DESELECT_CELL:Int = 161
	
	Const ID_SET_HIGHLIGHT_WIDTH:Int = 162
	Const ID_SET_RO_HIGHLIGHT_WIDTH:Int = 163
	
	Const ID_TESTFUNC:Int = 164

	Method OnInit()
		
		Local fileMenu:wxMenu = New wxMenu.Create()
		fileMenu.Append( ID_VTABLE, "&Virtual table test~tCtrl-A")
		fileMenu.Append( ID_BUGS_TABLE, "&Bugs table test~tCtrl-B")
		fileMenu.Append( ID_SMALL_GRID, "&Small Grid test~tCtrl-S")
		fileMenu.AppendSeparator()
		fileMenu.Append( wxID_EXIT, "E&xit~tAlt-X")
		
		Local viewMenu:wxMenu = New wxMenu.Create()
		viewMenu.Append( ID_TOGGLEROWLABELS,  "&Row labels", "", wxITEM_CHECK )
		viewMenu.Append( ID_TOGGLECOLLABELS,  "&Col labels", "", wxITEM_CHECK )
		viewMenu.Append( ID_TOGGLEEDIT,  "&Editable", "", wxITEM_CHECK )
		viewMenu.Append( ID_TOGGLEROWSIZING, "Ro&w drag-resize", "", wxITEM_CHECK )
		viewMenu.Append( ID_TOGGLECOLSIZING, "C&ol drag-resize", "", wxITEM_CHECK )
		viewMenu.Append( ID_TOGGLEROWSIZINGVETO, "Row drag-resize event veto", "", wxITEM_CHECK )
		viewMenu.Append( ID_TOGGLECOLSIZINGVETO, "Col drag-resize event veto", "", wxITEM_CHECK )
		viewMenu.Append( ID_TOGGLEGRIDSIZING, "&Grid drag-resize", "", wxITEM_CHECK )
		viewMenu.Append( ID_TOGGLEHORIZGRIDLINES, "&Horiz Grid Lines", "", wxITEM_CHECK )
		viewMenu.Append( ID_TOGGLEVERTGRIDLINES, "&Vert Grid Lines", "", wxITEM_CHECK )
		
		viewMenu.Append( ID_HIDESELROWS, "Hide selected rows")
		viewMenu.Append( ID_HIDESELCOLS, "Hide selected cols")
		viewMenu.Append( ID_SHOWSELROWS, "Show selected rows")
		viewMenu.Append( ID_SHOWSELCOLS, "Show selected cols")
		
		viewMenu.Append( ID_SET_HIGHLIGHT_WIDTH, "Set Cell H&ighlight Width...", "")
		viewMenu.Append( ID_SET_RO_HIGHLIGHT_WIDTH, "Set Cell RO Highlight Width...", "")
		viewMenu.Append( ID_AUTOSIZECOLS, "&Auto-size cols")
		viewMenu.Append( ID_CELLOVERFLOW, "Over&flow cells", "", wxITEM_CHECK )
		viewMenu.Append( ID_RESIZECELL, "Resi&ze cell (7,1)", "", wxITEM_CHECK )
		
		Local scrollbarMenu:wxMenu = New wxMenu.Create()
		viewMenu.AppendMenu( ID_SCROLLBARS_MENU, "Show or hide scrollbars", scrollbarMenu, "Show or hide the scrollbars")
		
		scrollbarMenu.AppendRadioItem( ID_SCROLLBARS_AS_NEEDED, "As needed")
		scrollbarMenu.AppendRadioItem( ID_SCROLLBARS_HORIZ_NEVER, "Never show horizontal")
		scrollbarMenu.AppendRadioItem( ID_SCROLLBARS_VERT_NEVER, "Never show vertical")
		scrollbarMenu.AppendRadioItem( ID_SCROLLBARS_NEVER, "Never show either scrollbar")
		scrollbarMenu.AppendRadioItem( ID_SCROLLBARS_HORIZ_ALWAYS, "Always show horiz scrollbar")
		scrollbarMenu.AppendRadioItem( ID_SCROLLBARS_VERT_ALWAYS, "Always show vert scrollbar")
		scrollbarMenu.AppendRadioItem( ID_SCROLLBARS_ALWAYS, "Always show both scrollbars")
		
		Local rowLabelMenu:wxMenu = New wxMenu.Create()
		
		viewMenu.AppendMenu( ID_ROWLABELALIGN, "R&ow label alignment", rowLabelMenu, "Change alignment of row labels")
		
		rowLabelMenu.Append( ID_ROWLABELHORIZALIGN, "&Horizontal")
		rowLabelMenu.Append( ID_ROWLABELVERTALIGN, "&Vertical")
		
		Local colLabelMenu:wxMenu = New wxMenu.Create()
		
		viewMenu.AppendMenu( ID_COLLABELALIGN, "Col l&abel alignment", colLabelMenu, "Change alignment of col labels")
		
		colLabelMenu.Append( ID_COLLABELHORIZALIGN, "&Horizontal")
		colLabelMenu.Append( ID_COLLABELVERTALIGN, "&Vertical")
		
		Local colMenu:wxMenu = New wxMenu.Create()
		colMenu.Append( ID_SETLABELCOLOUR,     "Set row &label colour...")
		colMenu.Append( ID_SETLABELTEXTCOLOUR, "Set row label &text colour...")
		colMenu.Append( ID_SETLABEL_FONT,      "Set row label fo&nt...")
		colMenu.Append( ID_GRIDLINECOLOUR,     "Set &Grid line colour...")
		colMenu.Append( ID_SET_CELL_FG_COLOUR, "Set default cell &foreground colour...")
		colMenu.Append( ID_SET_CELL_BG_COLOUR, "Set default cell &background colour...")
		
		Local editMenu:wxMenu = New wxMenu.Create()
		editMenu.Append( wxID_COPY, "&Copy~tCtrl-C")
		editMenu.Append( wxID_PASTE, "&Paste~tCtrl-V")
		editMenu.Append( ID_INSERTROW, "Insert &row")
		editMenu.Append( ID_INSERTCOL, "Insert c&olumn")
		editMenu.Append( ID_DELETEROW, "Delete selected ro&ws")
		editMenu.Append( ID_DELETECOL, "Delete selected co&ls")
		editMenu.Append( ID_CLEARGRID, "Cl&ear grid cell contents")
		editMenu.AppendCheckItem( ID_ENABLEGRID, "E&nable grid")
		editMenu.Check(ID_ENABLEGRID, True)
		
		Local selectMenu:wxMenu = New wxMenu.Create()
		selectMenu.Append( ID_SELECT_UNSELECT, "Add new cells to the selection", ..
			"When off, old selection is deselected before selecting the new cells", wxITEM_CHECK )
		selectMenu.Append( ID_SELECT_ALL, "Select all")
		selectMenu.Append( ID_SELECT_ROW, "Select row 2")
		selectMenu.Append( ID_SELECT_COL, "Select col 2")
		selectMenu.Append( ID_SELECT_CELL, "Select cell (3, 1)")
		selectMenu.Append( ID_DESELECT_ALL, "Deselect all")
		selectMenu.Append( ID_DESELECT_ROW, "Deselect row 2")
		selectMenu.Append( ID_DESELECT_COL, "Deselect col 2")
		selectMenu.Append( ID_DESELECT_CELL, "Deselect cell (3, 1)")
		Local selectionMenu:wxMenu = New wxMenu.Create()
		selectMenu.AppendMenu( ID_CHANGESEL, "Change &selection mode", selectionMenu, "Change selection mode")
		
		selectionMenu.AppendRadioItem( ID_SELNONE,   "Select &None")
		selectionMenu.AppendRadioItem( ID_SELCELLS,  "Select &Cells")
		selectionMenu.AppendRadioItem( ID_SELROWS,   "Select &Rows")
		selectionMenu.AppendRadioItem( ID_SELCOLS,   "Select C&ols")
		selectionMenu.AppendRadioItem( ID_SELSINGLE, "Select &Single Cell")
		selectionMenu.Check(ID_SELCELLS, True)
		
		Local helpMenu:wxMenu = New wxMenu.Create()
		helpMenu.Append( ID_ABOUT, "&About wxSheet demo")
		
		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		menuBar.Append( fileMenu, "&File")
		menuBar.Append( viewMenu, "&View")
		menuBar.Append( colMenu,  "&Colours")
		menuBar.Append( editMenu, "&Edit")
		menuBar.Append( selectMenu, "&Select")
		menuBar.Append( helpMenu, "&Help")
		
		SetMenuBar( menuBar )

		addToSel = False
	
		Local splitter:wxSplitterWindow = New wxSplitterWindow.Create(Self, wxID_ANY)
		splitter.SetMinimumPaneSize(20)
		splitter.SetSashGravity(0.9)

		' To use the splitter simply create one, Then your sheet as a child
		' And initialize the splitter with the sheet.
		Local sheetSplitter:wxSheetSplitter = New wxSheetSplitter.Create(splitter, -1, 0, 0)
		
		grid = New wxSheet.Create( sheetSplitter, -1, 0, 0)
		
		sheetSplitter.Initialize(grid)
		
		logWin = New wxTextCtrl.Create( splitter, -1, "", ,, ,, wxTE_MULTILINE )
		
		logger = New wxLogTextCtrl.Create( logWin )
		logOld = logger.SetActiveTarget( logger )
		'    logger.SetTimestamp( Null );

		' this will create a grid And, by Default, an associated grid
		' table For strings
		grid.CreateGrid( 0, 0 )
		grid.AppendRows(100)
		grid.AppendCols(100)
		
		Local ir:Int = grid.GetNumberRows()
		grid.DeleteRows(0, ir)
		grid.AppendRows(ir)
		grid.SetRowHeight( 0, 60 )
		grid.SetCellValue( 0, 0, "Ctrl+Home~nwill go to~nthis cell")
		
		grid.SetCellValue( 0, 1, "A long piece of text to demonstrate wrapping.")
		grid.SetCellValue( 0, 1, "A long piece of text to demonstrate wrapping.")
		grid.SetAttrRenderer( 0, 1, New wxSheetCellRenderer.Create(New wxSheetCellAutoWrapStringRendererRefData.Create()))
		grid.SetAttrEditor( 0, 1, New wxSheetCellEditor.Create(New wxSheetCellAutoWrapStringEditorRefData.Create()))
		
		grid.SetCellValue( 0, 2, "Edit change vetoed by event")
		grid.SetCellValue( 0, 3, "Read only")
		grid.SetAttrReadOnly( 0, 3, True )
		
		grid.SetCellValue( 0, 4, "Can veto edit this cell")
		
		grid.SetCellValue( 0, 5, "~nPress~nCtrl+arrow~nto skip over~ncells")
		
		grid.SetCellValue( 0, 8, "Rotated")
		grid.SetAttrOrientation( 0, 8, wxSHEET_AttrOrientVert )

		grid.SetRowHeight( 99, 60 )
		grid.SetCellValue( 99, 99, "Ctrl+End~nwill go to~nthis cell")
		grid.SetCellValue( 1, 0, "This default cell will overflow into neighboring cells, but not if you turn overflow off.")
		
		grid.SetAttrForegroundColour( 1, 2, wxRED())
		grid.SetAttrBackgroundColour( 1, 2, wxGREEN())
		
		grid.SetCellValue( 1, 4, "I'm in the middle")
		
		grid.SetCellValue( 2, 2, "red")
		
		grid.SetAttrForegroundColour( 2, 2, wxRED())
		grid.SetCellValue( 3, 3, "green on grey")
		grid.SetAttrForegroundColour( 3, 3, wxGREEN())
		grid.SetAttrBackgroundColour( 3, 3, wxLIGHT_GREY())
		
		grid.SetCellValue( 4, 4, "a weird looking cell")
		'    grid.SetAttrAlignment( 4, 4, wxSHEET_AttrAlignCenter)
		'    grid.SetAttrRenderer( 4, 4, wxSheetCellRenderer(New MyGridCellRendererRefData()))
		
		grid.SetCellValue( 3, 0, "0")
		grid.SetAttrRenderer( 3, 0, New wxSheetCellRenderer.Create(New wxSheetCellBoolRendererRefData.Create()))
		grid.SetAttrEditor( 3, 0, New wxSheetCellEditor.Create(New wxSheetCellBoolEditorRefData.Create()))
		
		Local attr:wxSheetCellAttr = New wxSheetCellAttr.Create(True)
		attr.SetForegroundColour(wxBLUE())
		grid.SetGridColAttr(5, attr)
		attr = New wxSheetCellAttr.Create(True)
		attr.SetBackgroundColour(wxRED())
		grid.SetGridRowAttr(5, attr)
		
		grid.SetCellValue( 2, 4, "a wider column")
		grid.SetColWidth(4, 120)
		grid.SetMinimalColWidth(4, 120)
		
		grid.SetAttrForegroundColour( 5, 8, wxGREEN())
		grid.SetCellValue( 5, 8, "Bg from row attr~nText colour from cell attr")
		grid.SetCellValue( 5, 5, "Bg from row attr Text col from col attr and this text is so long that it covers over many many empty cells but is broken by one that isn't")
		
		grid.SetColFormatFloat(6)
		grid.SetCellValue( 0, 6, "3.1415")
		grid.SetCellValue( 1, 6, "1415")
		grid.SetCellValue( 2, 6, "12345.67890")
		
		grid.SetAttrEditor( 0, 6, New wxSheetCellEditor.Create(New wxSheetCellFloatEditorRefData.Create(-1, -1)))
		
		grid.SetColFormatFloat(7, 6, 2)
		grid.SetCellValue( 0, 7, "3.1415")
		grid.SetCellValue( 1, 7, "1415")
		grid.SetCellValue( 2, 7, "12345.67890")

		Local choices:String[] = [ "Please select a choice", "This takes two cells", "Another choice" ]
	

		grid.SetAttrEditor( 4, 0, New wxSheetCellEditor.Create(New wxSheetCellChoiceEditorRefData.Create(choices)))
		grid.SetCellSpan( 4, 0, 1, 2)
		grid.SetCellValue( 4, 0, choices[0])
		grid.SetAttrOverflow( 4, 0, False)
		
		grid.SetCellSpan( 7, 1, 3, 4)
		grid.SetAttrAlignment( 7, 1, wxSHEET_AttrAlignCenter)
		grid.SetCellValue( 7, 1, "Big box!")
		
		grid.SetCellSpan( 26, 1, 3, 2)
		grid.SetCellSpan( 26, 4, 3, 2)
		grid.SetCellSpan( 26, 7, 3, 2)

		' ---------------------------------------------------------
		' Extra wxSheet tests

		' lots todo.....
	
	
	
		' text alignment tests, a 3x3 grid
		grid.SetCellValue(10, 4, "The below 3x3 grid tests text alignment")
		
		grid.SetCellValue(11, 4, "TopLeft")
		grid.SetCellValue(11, 5, "TopCenter")
		grid.SetCellValue(11, 6, "TopRight")
		grid.SetCellValue(12, 4, "CenterLeft")
		grid.SetCellValue(12, 5, "CenterCenter")
		grid.SetCellValue(12, 6, "CenterRight")
		grid.SetCellValue(13, 4, "BottomLeft")
		grid.SetCellValue(13, 5, "BottomCenter")
		grid.SetCellValue(13, 6, "BottomRight")
		
		grid.SetAttrAlignment(11, 4, wxSHEET_AttrAlignTop|wxSHEET_AttrAlignLeft)
		grid.SetAttrAlignment(11, 5, wxSHEET_AttrAlignTop|wxSHEET_AttrAlignCenterHoriz)
		grid.SetAttrAlignment(11, 6, wxSHEET_AttrAlignTop|wxSHEET_AttrAlignRight)
		grid.SetAttrAlignment(12, 4, wxSHEET_AttrAlignCenterVert|wxSHEET_AttrAlignLeft)
		grid.SetAttrAlignment(12, 5, wxSHEET_AttrAlignCenterVert|wxSHEET_AttrAlignCenterHoriz)
		grid.SetAttrAlignment(12, 6, wxSHEET_AttrAlignCenterVert|wxSHEET_AttrAlignRight)
		grid.SetAttrAlignment(13, 4, wxSHEET_AttrAlignBottom|wxSHEET_AttrAlignLeft)
		grid.SetAttrAlignment(13, 5, wxSHEET_AttrAlignBottom|wxSHEET_AttrAlignCenterHoriz)
		grid.SetAttrAlignment(13, 6, wxSHEET_AttrAlignBottom|wxSHEET_AttrAlignRight)

		' rotated text alignment tests, a 3x3 grid
		grid.SetCellValue(14, 4, "The below 3x3 grid tests rotated text alignment")
		
		grid.SetCellValue(15, 4, "TopLeft")
		grid.SetCellValue(15, 5, "TopCenter")
		grid.SetCellValue(15, 6, "TopRight")
		grid.SetCellValue(16, 4, "CenterLeft")
		grid.SetCellValue(16, 5, "CenterCenter")
		grid.SetCellValue(16, 6, "CenterRight")
		grid.SetCellValue(17, 4, "BottomLeft")
		grid.SetCellValue(17, 5, "BottomCenter")
		grid.SetCellValue(17, 6, "BottomRight")
		
		grid.SetAttrOrientation(15, 4, wxSHEET_AttrOrientVert)
		grid.SetAttrOrientation(15, 5, wxSHEET_AttrOrientVert)
		grid.SetAttrOrientation(15, 6, wxSHEET_AttrOrientVert)
		grid.SetAttrOrientation(16, 4, wxSHEET_AttrOrientVert)
		grid.SetAttrOrientation(16, 5, wxSHEET_AttrOrientVert)
		grid.SetAttrOrientation(16, 6, wxSHEET_AttrOrientVert)
		grid.SetAttrOrientation(17, 4, wxSHEET_AttrOrientVert)
		grid.SetAttrOrientation(17, 5, wxSHEET_AttrOrientVert)
		grid.SetAttrOrientation(17, 6, wxSHEET_AttrOrientVert)
		
		grid.SetAttrAlignment(15, 4, wxSHEET_AttrAlignTop|wxSHEET_AttrAlignLeft)
		grid.SetAttrAlignment(15, 5, wxSHEET_AttrAlignTop|wxSHEET_AttrAlignCenterHoriz)
		grid.SetAttrAlignment(15, 6, wxSHEET_AttrAlignTop|wxSHEET_AttrAlignRight)
		grid.SetAttrAlignment(16, 4, wxSHEET_AttrAlignCenterVert|wxSHEET_AttrAlignLeft)
		grid.SetAttrAlignment(16, 5, wxSHEET_AttrAlignCenterVert|wxSHEET_AttrAlignCenterHoriz)
		grid.SetAttrAlignment(16, 6, wxSHEET_AttrAlignCenterVert|wxSHEET_AttrAlignRight)
		grid.SetAttrAlignment(17, 4, wxSHEET_AttrAlignBottom|wxSHEET_AttrAlignLeft)
		grid.SetAttrAlignment(17, 5, wxSHEET_AttrAlignBottom|wxSHEET_AttrAlignCenterHoriz)
		grid.SetAttrAlignment(17, 6, wxSHEET_AttrAlignBottom|wxSHEET_AttrAlignRight)

		' Editor tests Col 10
		grid.SetCellValue(-1, 9, "Editor/Renderer types")
		grid.SetCellValue(0, 9, "StringEditor   StringRenderer")
		grid.SetCellValue(1, 9, "AWStringEditor AWStringRenderer")
		grid.SetCellValue(2, 9, "NumberEditor   NumberRenderer")
		grid.SetCellValue(3, 9, "NumberEditor   NumberRenderer")
		grid.SetCellValue(4, 9, "FloatEditor    FloatRenderer")
		grid.SetCellValue(5, 9, "FloatEditor    FloatRenderer")
		grid.SetCellValue(6, 9, "BoolEditor     BoolRenderer")
		grid.SetCellValue(7, 9, "ChoiceEditor   StringRenderer")
		grid.SetCellValue(8, 9, "ChoiceEditor   StringRenderer")
		grid.SetCellValue(9, 9, "EnumEditor     EnumRenderer")
		grid.AutoSizeCol(9, False) ' make the text fit nicely
	
		Local enumStrings:String = "Red,Green,Blue"
		
		grid.SetCellValue(-1, 10, "Test")
		grid.SetAttrEditor(0, 10, New wxSheetCellEditor.Create(New wxSheetCellTextEditorRefData.Create()))
		grid.SetAttrEditor(1, 10, New wxSheetCellEditor.Create(New wxSheetCellAutoWrapStringEditorRefData.Create()))
		grid.SetAttrEditor(2, 10, New wxSheetCellEditor.Create(New wxSheetCellNumberEditorRefData.Create()))
		grid.SetAttrEditor(3, 10, New wxSheetCellEditor.Create(New wxSheetCellNumberEditorRefData.Create(0, 100)))
		grid.SetAttrEditor(4, 10, New wxSheetCellEditor.Create(New wxSheetCellFloatEditorRefData.Create()))
		grid.SetAttrEditor(5, 10, New wxSheetCellEditor.Create(New wxSheetCellFloatEditorRefData.Create(4, 4)))
		grid.SetAttrEditor(6, 10, New wxSheetCellEditor.Create(New wxSheetCellBoolEditorRefData.Create()))
		grid.SetAttrEditor(7, 10, New wxSheetCellEditor.Create(New wxSheetCellChoiceEditorRefData.Create(choices, False)))
		grid.SetAttrEditor(8, 10, New wxSheetCellEditor.Create(New wxSheetCellChoiceEditorRefData.Create(choices, True)))
		grid.SetAttrEditor(9, 10, New wxSheetCellEditor.Create(New wxSheetCellEnumEditorRefData.CreateData(enumStrings)))
		
		grid.SetAttrRenderer(0, 10, New wxSheetCellRenderer.Create(New wxSheetCellStringRendererRefData.Create()))
		grid.SetAttrRenderer(1, 10, New wxSheetCellRenderer.Create(New wxSheetCellAutoWrapStringRendererRefData.Create()))
		grid.SetAttrRenderer(2, 10, New wxSheetCellRenderer.Create(New wxSheetCellNumberRendererRefData.Create()))
		grid.SetAttrRenderer(3, 10, New wxSheetCellRenderer.Create(New wxSheetCellNumberRendererRefData.Create()))
		grid.SetAttrRenderer(4, 10, New wxSheetCellRenderer.Create(New wxSheetCellFloatRendererRefData.CreateData()))
		grid.SetAttrRenderer(5, 10, New wxSheetCellRenderer.Create(New wxSheetCellFloatRendererRefData.CreateData(4, 4)))
		grid.SetAttrRenderer(6, 10, New wxSheetCellRenderer.Create(New wxSheetCellBoolRendererRefData.Create()))
		grid.SetAttrRenderer(7, 10, New wxSheetCellRenderer.Create(New wxSheetCellStringRendererRefData.Create()))
		grid.SetAttrRenderer(8, 10, New wxSheetCellRenderer.Create(New wxSheetCellStringRendererRefData.Create()))
		grid.SetAttrRenderer(9, 10, New wxSheetCellRenderer.Create(New wxSheetCellEnumRendererRefData.CreateData(enumStrings)))


		splitter.SplitHorizontally(sheetSplitter, logWin, 400)
		Centre()
		SetDefaults()
		
	End Method
	

	
	Method SetDefaults()
		GetMenuBar().Check( ID_TOGGLEROWLABELS, True )
		GetMenuBar().Check( ID_TOGGLECOLLABELS, True )
		GetMenuBar().Check( ID_TOGGLEEDIT, True )
		GetMenuBar().Check( ID_TOGGLEROWSIZING, True )
		GetMenuBar().Check( ID_TOGGLECOLSIZING, True )
		GetMenuBar().Check( ID_TOGGLEGRIDSIZING, True )
		GetMenuBar().Check( ID_TOGGLEHORIZGRIDLINES, True )
		GetMenuBar().Check( ID_TOGGLEVERTGRIDLINES, True )
		GetMenuBar().Check( ID_CELLOVERFLOW, True )
	End Method
	
	Function ToggleRowLabels(event:wxEvent)
	End Function
	
	Function ToggleColLabels(event:wxEvent)
	End Function
	
	Function ToggleEditing(event:wxEvent)
	End Function
	
	Function ToggleRowSizing(event:wxEvent)
	End Function
	
	Function ToggleColSizing(event:wxEvent)
	End Function
	
	Function ToggleGridSizing(event:wxEvent)
	End Function
	
	Function ToggleGridLines(event:wxEvent)
	End Function
	
	Function OnHideShowSelRowsCols(event:wxEvent)
	End Function
	
	Function AutoSizeCols(event:wxEvent)
	End Function
	
	Function CellOverflow(event:wxEvent)
	End Function
	
	Function ResizeCell(event:wxEvent)
	End Function
	
	Function SetLabelColour(event:wxEvent)
	End Function
	
	Function SetLabelTextColour(event:wxEvent)
	End Function
	
	Function SetLabelFont(event:wxEvent)
	End Function
	
	Function OnScrollbarsShown(event:wxEvent)
	End Function
	
	Function SetRowLabelHorizAlignment(event:wxEvent)
	End Function
	
	Function SetRowLabelVertAlignment(event:wxEvent)
	End Function
	
	Function SetColLabelHorizAlignment(event:wxEvent)
	End Function
	
	Function SetColLabelVertAlignment(event:wxEvent)
	End Function
	
	Function SetGridLineColour(event:wxEvent)
	End Function
	
	
	Function SetCellFgColour(event:wxEvent)
	End Function
	
	Function SetCellBgColour(event:wxEvent)
	End Function
	
	
	Function OnCopyPaste(event:wxEvent)
	End Function
	
	Function InsertRow(event:wxEvent)
	End Function
	
	Function InsertCol(event:wxEvent)
	End Function
	
	Function DeleteSelectedRows(event:wxEvent)
	End Function
	
	Function DeleteSelectedCols(event:wxEvent)
	End Function
	
	Function ClearGrid(event:wxEvent)
	End Function
	
	Function EnableGrid(event:wxEvent)
	End Function
	
	Function SelectionMode(event:wxEvent)
	End Function
	
	
	Function DeselectCell(event:wxEvent)
	End Function
	
	Function DeselectCol(event:wxEvent)
	End Function
	
	Function DeselectRow(event:wxEvent)
	End Function
	
	Function DeselectAll(event:wxEvent)
	End Function
	
	Function SelectCell(event:wxEvent)
	End Function
	
	Function SelectCol(event:wxEvent)
	End Function
	
	Function SelectRow(event:wxEvent)
	End Function
	
	Function SelectAll(event:wxEvent)
	End Function
	
	Function OnAddToSelectToggle(event:wxEvent)
	End Function
	
	
	Function OnLabelLeftDown(event:wxEvent)
	End Function
	
	Function OnCellLeftDown(event:wxEvent)
	End Function
	
	Function OnCellRightDown(event:wxEvent)
	End Function
	
	Function OnRowSize(event:wxEvent)
	End Function
	
	Function OnColSize(event:wxEvent)
	End Function
	
	Function OnSelectCell(event:wxEvent)
	End Function
	
	Function OnRangeSelect(event:wxEvent)
	End Function
	
	Function OnCellValueChanged(event:wxEvent)
	End Function
	
	Function OnEditorShown(event:wxEvent)
	End Function
	
	Function OnEditorHidden(event:wxEvent)
	End Function
	
	Function OnSheetSplitter(event:wxEvent)
	End Function
	
	Function OnSetHighlightWidth(event:wxEvent)
	End Function
	
	Function OnSetROHighlightWidth(event:wxEvent)
	End Function
	
	Function OnQuit(event:wxEvent)
	End Function
	
	Function About(event:wxEvent)
	End Function
	
	Function OnVTable(event:wxEvent)
	End Function
	
	Function OnBugsTable(event:wxEvent)
	End Function
	
	Function OnSmallGrid(event:wxEvent)
	End Function

End Type

