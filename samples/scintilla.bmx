SuperStrict

Framework wx.wxApp
Import wx.wxScintilla
Import wx.wxFrame


Global commonPrefs:CommonInfo = New CommonInfo


New MyApp.Run()

Type MyApp Extends wxApp

	Field frame:AppFrame

	Method OnInit:Int()
	
		wxInitAllImageHandlers()

		' Create application frame
		frame = AppFrame(New AppFrame.Create(,,"wxScintilla Sample"))
		
		' open application frame
		frame.Layout()
		frame.Show(True)
		SetTopWindow(frame)
	
		Return True
	
	End Method

End Type


Type AppFrame Extends wxFrame


	' edit object
	Field mEdit:Edit
	Field menuBar:wxMenuBar
	
	Method OnInit()

		' Create menu
		menuBar = New wxMenuBar.Create()
		CreateMenu()
		
		' open First page
		mEdit = Edit(New Edit.Create(Self, -1))
		mEdit.SetFocus()

	End Method
	
	Method CreateMenu()
	End Method

	Function OnClose (event:wxEvent)
	End Function
	
	Function OnAbout (event:wxEvent)
	End Function
	
	Function OnExit (event:wxEvent)
	End Function
	
	Function OnTimerEvent (event:wxEvent)
	End Function
	
	' file
	Function OnFileNew (event:wxEvent)
	End Function
	
	Function OnFileNewFrame (event:wxEvent)
	End Function
	
	Function OnFileOpen (event:wxEvent)
	End Function
	
	Function OnFileOpenFrame (event:wxEvent)
	End Function
	
	Function OnFileSave (event:wxEvent)
	End Function
	
	Function OnFileSaveAs (event:wxEvent)
	End Function
	
	Function OnFileClose (event:wxEvent)
	End Function
	
	' properties
	Function OnProperties (event:wxEvent)
	End Function
	
	' Print
	Function OnPrintSetup (event:wxEvent)
	End Function
	
	Function OnPrintPreview (event:wxEvent)
	End Function
	
	Function OnPrint (event:wxEvent)
	End Function
	
	' edit events
	Function OnEdit (event:wxEvent)
	End Function



End Type

Type Edit Extends wxScintilla

	' file
	Field filename:String
	
	' lanugage properties
	'LanguageInfo Const* m_language;
	
	' margin variables
	Field lineNrID:Int
	Field lineNrMargin:Int
	Field foldingID:Int
	Field foldingMargin:Int
	Field dividerID:Int


	Method OnInit()
	
		filename = ""
		'm_language = Null;
		
		lineNrID = 0
		lineNrMargin = TextWidth(wxSCI_STYLE_LINENUMBER, "_999999")
		foldingID = 1
		foldingMargin = 16
		dividerID = 2

		' Default font For all styles
		SetViewEOL(commonPrefs.displayEOLEnable)
		SetIndentationGuides(commonPrefs.indentGuideEnable)
		
		If commonPrefs.lineNumberEnable Then
			SetMarginWidth(lineNrID, lineNrMargin)
		Else
			SetMarginWidth(lineNrID, 0)
		End If
		
		If commonPrefs.longLineOnEnable Then
			SetEdgeMode (wxSCI_EDGE_LINE)
		Else
			SetEdgeMode(wxSCI_EDGE_NONE)
		End If
		
		If commonPrefs.whiteSpaceEnable Then
			SetViewWhiteSpace(wxSCI_WS_VISIBLEALWAYS)
		Else
			SetViewWhiteSpace(wxSCI_WS_INVISIBLE)
		End If
		SetOvertype(commonPrefs.overTypeInitial)
		SetReadOnly(commonPrefs.readOnlyInitial)
		If commonPrefs.wrapModeInitial Then
			SetWrapMode(wxSCI_WRAP_WORD)
		Else
			SetWrapMode(wxSCI_WRAP_NONE)
		End If
		
		Local font:wxFont = New wxFont.CreateWithAttribs(10, wxTELETYPE, wxNORMAL, wxNORMAL)
		
		StyleSetFontFont(wxSCI_STYLE_DEFAULT, font)
		StyleSetForeground(wxSCI_STYLE_DEFAULT, New wxColour.CreateNamedColour("BLACK"))
		StyleSetBackground(wxSCI_STYLE_DEFAULT, New wxColour.CreateNamedColour("WHITE"))
		StyleSetForeground(wxSCI_STYLE_LINENUMBER, New wxColour.CreateNamedColour("DARK GREY"))
		StyleSetBackground(wxSCI_STYLE_LINENUMBER, New wxColour.CreateNamedColour("WHITE"))
		StyleSetForeground(wxSCI_STYLE_INDENTGUIDE, New wxColour.CreateNamedColour("DARK GREY"))
		'InitializePrefs(DEFAULT_LANGUAGE);

		' set visibility
		SetVisiblePolicy(wxSCI_VISIBLE_STRICT | wxSCI_VISIBLE_SLOP, 1)
		SetXCaretPolicy(wxSCI_CARET_EVEN | wxSCI_VISIBLE_STRICT | wxSCI_CARET_SLOP, 1)
		SetYCaretPolicy(wxSCI_CARET_EVEN | wxSCI_VISIBLE_STRICT | wxSCI_CARET_SLOP, 1)
		
		' markers
		MarkerDefine(wxSCI_MARKNUM_FOLDER, wxSCI_MARK_BOXPLUS)
		MarkerSetBackground(wxSCI_MARKNUM_FOLDER, New wxColour.CreateNamedColour("BLACK"))
		MarkerSetForeground(wxSCI_MARKNUM_FOLDER, New wxColour.CreateNamedColour("WHITE"))
		MarkerDefine(wxSCI_MARKNUM_FOLDEROPEN, wxSCI_MARK_BOXMINUS)
		MarkerSetBackground(wxSCI_MARKNUM_FOLDEROPEN, New wxColour.CreateNamedColour("BLACK"))
		MarkerSetForeground(wxSCI_MARKNUM_FOLDEROPEN, New wxColour.CreateNamedColour("WHITE"))
		MarkerDefine(wxSCI_MARKNUM_FOLDERSUB, wxSCI_MARK_EMPTY)
		MarkerDefine(wxSCI_MARKNUM_FOLDEREND, wxSCI_MARK_SHORTARROW)
		MarkerDefine(wxSCI_MARKNUM_FOLDEROPENMID, wxSCI_MARK_ARROWDOWN)
		MarkerDefine(wxSCI_MARKNUM_FOLDERMIDTAIL, wxSCI_MARK_EMPTY)
		MarkerDefine(wxSCI_MARKNUM_FOLDERTAIL, wxSCI_MARK_EMPTY)

		' miscelaneous
		UsePopUp(0)
		SetLayoutCache(wxSCI_CACHE_PAGE)
		SetBufferedDraw(1)

	End Method
	
Rem
Method InitializePrefs:Int(name:String)

    ' initialize styles
    StyleClearAll()
    'LanguageInfo Const* curInfo = Null;

    ' determine language
    Local found:Int = False
    'Int languageNr;
    'For (languageNr = 0; languageNr < g_LanguagePrefsSize; languageNr++) {
    '    curInfo = &g_LanguagePrefs [languageNr];
    '    If (curInfo->name == name) {
    '        found = True;
    '        break;
    '    }
    '}
    'If (!found) Return False;

    ' set lexer And language
    'SetLexer (curInfo->lexer);
    'm_language = curInfo;

    ' set margin For line numbers
    SetMarginType (lineNrID, wxSCI_MARGIN_NUMBER);
    StyleSetForeground (wxSCI_STYLE_LINENUMBER, wxColour (_T("DARK GREY")));
    StyleSetBackground (wxSCI_STYLE_LINENUMBER, wxColour (_T("WHITE")));
    SetMarginWidth (lineNrID,
                    commonPrefs.lineNumberEnable? m_LineNrMargin: 0);

    ' set common styles
    StyleSetForeground (wxSCI_STYLE_DEFAULT, wxColour (_T("DARK GREY")));
    StyleSetForeground (wxSCI_STYLE_INDENTGUIDE, wxColour (_T("DARK GREY")));

    ' initialize settings
    If (commonPrefs.syntaxEnable) {
        Int keywordnr = 0;
        Int Nr;
        For (Nr = 0; Nr < STYLE_TYPES_COUNT; Nr++) {
            If (curInfo->styles[Nr].Type == -1) Continue;
            Const StyleInfo &curType = g_StylePrefs [curInfo->styles[Nr].Type];
            wxFont font (curType.FontSize, wxTELETYPE, wxNORMAL, wxNORMAL, False,
                         curType.FontName);
            StyleSetFont (Nr, font);
            If (curType.foreground) {
                StyleSetForeground (Nr, wxColour (curType.foreground));
            }
            If (curType.background) {
                StyleSetBackground (Nr, wxColour (curType.background));
            }
            StyleSetBold (Nr, (curType.FontStyle & TOKEN_STYLE_BOLD) > 0);
            StyleSetItalic (Nr, (curType.FontStyle & TOKEN_STYLE_ITALIC) > 0);
            StyleSetUnderline (Nr, (curType.FontStyle & TOKEN_STYLE_UNDERL) > 0);
            StyleSetVisible (Nr, (curType.FontStyle & TOKEN_STYLE_HIDDEN) == 0);
            StyleSetCase (Nr, curType.lettercase);
            Const wxChar *pwords = curInfo->styles[Nr].words;
            If (pwords) {
                SetKeyWords (keywordnr, pwords);
                keywordnr += 1;
            }
        }
    }

    ' set margin as unused
    SetMarginType (dividerID, wxSCI_MARGIN_SYMBOL);
    SetMarginWidth (dividerID, 8);
    SetMarginSensitive (dividerID, False);

    ' folding
    SetMarginType (foldingID, wxSCI_MARGIN_SYMBOL);
    SetMarginMask (foldingID, wxSCI_MASK_FOLDERS);
    StyleSetBackground (foldingID, wxColour (_T("WHITE")));
    SetMarginWidth (foldingID, 0);
    SetMarginSensitive (foldingID, False);
    If commonPrefs.foldEnable Then
        SetMarginWidth (m_FoldingID, curInfo->folds != 0? m_FoldingMargin: 0);
        SetMarginSensitive (m_FoldingID, curInfo->folds != 0);
        SetProperty("fold"), curInfo->folds != 0? _T("1"): _T("0"));
        SetProperty("fold.comment",
                     (curInfo->folds & FOLD_TYPE_COMMENT) > 0? _T("1"): _T("0"));
        SetProperty("fold.compact",
                     (curInfo->folds & FOLD_TYPE_COMPACT) > 0? _T("1"): _T("0"));
        SetProperty("fold.preprocessor",
                     (curInfo->folds & FOLD_TYPE_PREPROC) > 0? _T("1"): _T("0"));
        SetProperty("fold.html",
                     (curInfo->folds & FOLD_TYPE_HTML) > 0? _T("1"): _T("0"));
        SetProperty("fold.html.preprocessor"),
                     (curInfo->folds & FOLD_TYPE_HTMLPREP) > 0? _T("1"): _T("0"));
        SetProperty("fold.comment.python"),
                     (curInfo->folds & FOLD_TYPE_COMMENTPY) > 0? _T("1"): _T("0"));
        SetProperty("fold.quotes.python"),
                     (curInfo->folds & FOLD_TYPE_QUOTESPY) > 0? _T("1"): _T("0"));
    End If
    SetFoldFlags (wxSCI_FOLDFLAG_LINEBEFORE_CONTRACTED |
                  wxSCI_FOLDFLAG_LINEAFTER_CONTRACTED);

    ' set spaces And indention
    SetTabWidth (4);
    SetUseTabs (False);
    SetTabIndents (True);
    SetBackSpaceUnIndents (True);
    SetIndent (commonPrefs.indentEnable? 4: 0);

    ' others
    SetViewEOL (commonPrefs.displayEOLEnable);
    SetIndentationGuides (commonPrefs.indentGuideEnable);
    SetEdgeColumn (80);
    SetEdgeMode (commonPrefs.longLineOnEnable? wxSCI_EDGE_LINE: wxSCI_EDGE_NONE);
    SetViewWhiteSpace (commonPrefs.whiteSpaceEnable?
                       wxSCI_WS_VISIBLEALWAYS: wxSCI_WS_INVISIBLE);
    SetOvertype (commonPrefs.overTypeInitial);
    SetReadOnly (commonPrefs.readOnlyInitial);
    SetWrapMode (commonPrefs.wrapModeInitial?
                 wxSCI_WRAP_WORD: wxSCI_WRAP_NONE);

    Return True
End Method
End Rem
End Type


Type CommonInfo
    ' editor functionality prefs
    Field syntaxEnable:Int = True
    Field foldEnable:Int = True
    Field indentEnable:Int = True
    ' display defaults prefs
    Field readOnlyInitial:Int = False
    Field overTypeInitial:Int = False
    Field wrapModeInitial:Int = False
    Field displayEOLEnable:Int = False
    Field indentGuideEnable:Int = False
    Field lineNumberEnable:Int = True
    Field longLineOnEnable:Int = False
    Field whiteSpaceEnable:Int = False
End Type

Type LanguageInfo
    Field name:String
    Field filepattern:String
    Field lexer:Int
    Field styles:TStyles[]
    Field folds:Int
End Type

Type TStyles
	Field kind:Int
	Field words:String
End Type

