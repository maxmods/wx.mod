' Copyright (c) 2007,2008 Bruce A Henderson
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

Import "keys.bmx"

Const wxVSCROLL:Int = $80000000
Const wxHSCROLL:Int = $40000000
Const wxCAPTION:Int = $20000000

Const wxID_LOWEST:Int = 4999
Const wxID_HIGHEST:Int = 5999

Const wxNOT_FOUND:Int = -1

Rem
bbdoc: Clip children when painting.
about: Reduces flicker in e.g. frames and splitter windows, but can't be used in a panel where a static box must be
'transparent' (panel paints the background for it)
End Rem
Const wxCLIP_CHILDREN:Int = $00400000

Rem
bbdoc: Add this style if the control wants to get all keyboard messages.
about: Under Windows, it won't normally get the dialog navigation key events
End Rem
Const wxWANTS_CHARS:Int = $00040000

Const wxSTAY_ON_TOP:Int = $8000
Const wxICONIZE:Int = $4000
Const wxMINIMIZE:Int = wxICONIZE
Const wxMAXIMIZE:Int = $2000
Const wxCLOSE_BOX:Int = $1000

Const wxSYSTEM_MENU:Int = $0800
Const wxMINIMIZE_BOX:Int = $0400
Const wxMAXIMIZE_BOX:Int = $0200
Const wxTINY_CAPTION_HORIZ:Int = $0100
Const wxTINY_CAPTION_VERT:Int = $0080
Const wxRESIZE_BORDER:Int = $0040

Const wxDEFAULT_FRAME_STYLE:Int = wxSYSTEM_MENU | wxRESIZE_BORDER | wxMINIMIZE_BOX | ..
	wxMAXIMIZE_BOX | wxCLOSE_BOX | wxCAPTION | wxCLIP_CHILDREN

' menu items

Const wxITEM_SEPARATOR:Int = -1
Const wxITEM_NORMAL:Int = 0
Const wxITEM_CHECK:Int = 1
Const wxITEM_RADIO:Int = 2

Const wxID_ANY:Int = -1

Const wxID_OPEN:Int = 5000
Const wxID_CLOSE:Int = 5001
Const wxID_NEW:Int = 5002
Const wxID_SAVE:Int = 5003
Const wxID_SAVEAS:Int = 5004
Const wxID_REVERT:Int = 5005
'?macos
'Global wxID_EXIT:Int = bmx_wxapp_macexitmenuitemid()
'Extern
'	Function bmx_wxapp_macexitmenuitemid:Int()
'End Extern
'?linux
'Const wxID_EXIT:Int = 5006
'?win32
Const wxID_EXIT:Int = 5006
'?
Const wxID_UNDO:Int = 5007
Const wxID_REDO:Int = 5008
Const wxID_HELP:Int = 5009
Const wxID_PRINT:Int = 5010
Const wxID_PRINT_SETUP:Int = 5011
Const wxID_PAGE_SETUP:Int = 5012
Const wxID_PREVIEW:Int = 5013
Const wxID_ABOUT:Int = 5014
Const wxID_HELP_CONTENTS:Int = 5015
Const wxID_HELP_INDEX:Int = 5016
Const wxID_HELP_SEARCH:Int = 5017
Const wxID_HELP_COMMANDS:Int = 5018
Const wxID_HELP_PROCEDURES:Int = 5019
Const wxID_HELP_CONTEXT:Int = 5020
Const wxID_CLOSE_ALL:Int = 5021
Const wxID_PREFERENCES:Int = 5022



Const wxEVT_COMMAND_CHECKBOX_CLICKED:Int = 2
Const wxEVT_COMMAND_LISTBOX_SELECTED:Int = 4
Const wxEVT_COMMAND_LISTBOX_DOUBLECLICKED:Int = 5
Const wxEVT_COMMAND_CHECKLISTBOX_TOGGLED:Int = 6
Const wxEVT_COMMAND_MENU_SELECTED:Int = 9
Const wxEVT_COMMAND_SLIDER_UPDATED:Int = 10
Const wxEVT_COMMAND_SCROLLBAR_UPDATED:Int = 13
Const wxEVT_COMMAND_VLBOX_SELECTED:Int = 14
Const wxEVT_SOCKET:Int = 50
Const wxEVT_CHILD_FOCUS:Int = 114

Const wxEVT_NC_LEFT_DOWN:Int = 200
Const wxEVT_NC_LEFT_UP:Int = 201
Const wxEVT_NC_MIDDLE_DOWN:Int = 202
Const wxEVT_NC_MIDDLE_UP:Int = 203
Const wxEVT_NC_RIGHT_DOWN:Int = 204
Const wxEVT_NC_RIGHT_UP:Int = 205
Const wxEVT_NC_MOTION:Int = 206
Const wxEVT_NC_ENTER_WINDOW:Int = 207
Const wxEVT_NC_LEAVE_WINDOW:Int = 208
Const wxEVT_NC_LEFT_DCLICK:Int = 209
Const wxEVT_NC_MIDDLE_DCLICK:Int = 210
Const wxEVT_NC_RIGHT_DCLICK:Int = 211

' Character Input event Type
Const wxEVT_CHAR:Int = 212
Const wxEVT_CHAR_HOOK:Int = 213
Const wxEVT_NAVIGATION_KEY:Int = 214
Const wxEVT_KEY_DOWN:Int = 215
Const wxEVT_KEY_UP:Int = 216

Const wxEVT_HOTKEY:Int = 217

' Set cursor event
Const wxEVT_SET_CURSOR:Int = 230

' wxScrollBar And wxSlider event identifiers
Const wxEVT_SCROLL:Int = -300
Const wxEVT_SCROLL_TOP:Int = 300
Const wxEVT_SCROLL_BOTTOM:Int = 301
Const wxEVT_SCROLL_LINEUP:Int = 302
Const wxEVT_SCROLL_LINEDOWN:Int = 303
Const wxEVT_SCROLL_PAGEUP:Int = 304
Const wxEVT_SCROLL_PAGEDOWN:Int = 305
Const wxEVT_SCROLL_THUMBTRACK:Int = 306
Const wxEVT_SCROLL_THUMBRELEASE:Int = 307
Const wxEVT_SCROLL_CHANGED:Int = 308

Const wxEVT_COMMAND_SCROLL:Int = wxEVT_SCROLL
Const wxEVT_COMMAND_SCROLL_TOP:Int = wxEVT_SCROLL_TOP
Const wxEVT_COMMAND_SCROLL_BOTTOM:Int = wxEVT_SCROLL_BOTTOM
Const wxEVT_COMMAND_SCROLL_LINEUP:Int = wxEVT_SCROLL_LINEUP
Const wxEVT_COMMAND_SCROLL_LINEDOWN:Int = wxEVT_SCROLL_LINEDOWN
Const wxEVT_COMMAND_SCROLL_PAGEUP:Int = wxEVT_SCROLL_PAGEUP
Const wxEVT_COMMAND_SCROLL_PAGEDOWN:Int = wxEVT_SCROLL_PAGEDOWN
Const wxEVT_COMMAND_SCROLL_THUMBTRACK:Int = wxEVT_SCROLL_THUMBTRACK
Const wxEVT_COMMAND_SCROLL_THUMBRELEASE:Int = wxEVT_SCROLL_THUMBRELEASE
Const wxEVT_COMMAND_SCROLL_CHANGED:Int = wxEVT_SCROLL_CHANGED

' Scroll events from wxWindow
Const wxEVT_SCROLLWIN:Int = -320
Const wxEVT_SCROLLWIN_TOP:Int = 320
Const wxEVT_SCROLLWIN_BOTTOM:Int = 321
Const wxEVT_SCROLLWIN_LINEUP:Int = 322
Const wxEVT_SCROLLWIN_LINEDOWN:Int = 323
Const wxEVT_SCROLLWIN_PAGEUP:Int = 324
Const wxEVT_SCROLLWIN_PAGEDOWN:Int = 325
Const wxEVT_SCROLLWIN_THUMBTRACK:Int = 326
Const wxEVT_SCROLLWIN_THUMBRELEASE:Int = 327

' System events
Const wxEVT_SIZE:Int = 400
Const wxEVT_MOVE:Int = 401
Const wxEVT_CLOSE_WINDOW:Int = 402
Const wxEVT_CLOSE:Int = 402
Const wxEVT_END_SESSION:Int = 403
Const wxEVT_QUERY_END_SESSION:Int = 404
Const wxEVT_ACTIVATE_APP:Int = 405

Const wxEVT_ACTIVATE:Int = 409
Const wxEVT_CREATE:Int = 410
Const wxEVT_DESTROY:Int = 411
Const wxEVT_SHOW:Int = 412
Const wxEVT_ICONIZE:Int = 413
Const wxEVT_MAXIMIZE:Int = 414
Const wxEVT_MOUSE_CAPTURE_CHANGED:Int = 415
Const wxEVT_MOUSE_CAPTURE_LOST:Int = 416
Const wxEVT_PAINT:Int = 417
Const wxEVT_ERASE_BACKGROUND:Int = 418
Const wxEVT_NC_PAINT:Int = 419
Const wxEVT_PAINT_ICON:Int = 420
Const wxEVT_CONTEXT_MENU:Int = 424
Const wxEVT_SYS_COLOUR_CHANGED:Int = 425
Const wxEVT_DISPLAY_CHANGED:Int = 426
Const wxEVT_SETTING_CHANGED:Int = 427
Const wxEVT_QUERY_NEW_PALETTE:Int = 428
Const wxEVT_PALETTE_CHANGED:Int = 429
Const wxEVT_JOY_BUTTON_DOWN:Int = 430
Const wxEVT_JOY_BUTTON_UP:Int = 431
Const wxEVT_JOY_MOVE:Int = 432
Const wxEVT_JOY_ZMOVE:Int = 433
Const wxEVT_DROP_FILES:Int = 434
Const wxEVT_DRAW_ITEM:Int = 435
Const wxEVT_MEASURE_ITEM:Int = 436
Const wxEVT_COMPARE_ITEM:Int = 437
Const wxEVT_INIT_DIALOG:Int = 438
Const wxEVT_IDLE:Int = 439
Const wxEVT_UPDATE_UI:Int = 440
Const wxEVT_SIZING:Int = 441
Const wxEVT_MOVING:Int = 442
Const wxEVT_HIBERNATE:Int = 443

' Generic command events
' Note: a click is a higher-level event than button down/up
Const wxEVT_COMMAND_LEFT_CLICK:Int = 500
Const wxEVT_COMMAND_LEFT_DCLICK:Int = 501
Const wxEVT_COMMAND_RIGHT_CLICK:Int = 502
Const wxEVT_COMMAND_RIGHT_DCLICK:Int = 503
Const wxEVT_COMMAND_SET_FOCUS:Int = 504
Const wxEVT_COMMAND_KILL_FOCUS:Int = 505
Const wxEVT_COMMAND_ENTER:Int = 506

' Help events
Const wxEVT_HELP:Int = 1050
Const wxEVT_DETAILED_HELP:Int = 1051

' mouse events
Const wxEVT_MOUSE_EVENTS:Int = -100
Const wxEVT_LEFT_DOWN:Int = 100
Const wxEVT_LEFT_UP:Int = 101
Const wxEVT_MIDDLE_DOWN:Int = 102
Const wxEVT_MIDDLE_UP:Int = 103
Const wxEVT_RIGHT_DOWN:Int = 104
Const wxEVT_RIGHT_UP:Int = 105
Const wxEVT_MOTION:Int = 106
Const wxEVT_ENTER_WINDOW:Int = 107
Const wxEVT_LEAVE_WINDOW:Int = 108
Const wxEVT_LEFT_DCLICK:Int = 109
Const wxEVT_MIDDLE_DCLICK:Int = 110
Const wxEVT_RIGHT_DCLICK:Int = 111
Const wxEVT_MOUSEWHEEL:Int = 115


Const wxYES:Int = $00000002
Const wxOK:Int = $00000004
Const wxNO:Int = $00000008
Const wxYES_NO:Int = wxYES | wxNO
Const wxCANCEL:Int = $00000010

Const wxYES_DEFAULT:Int = $00000000
Const wxNO_DEFAULT:Int = $00000080

Const wxICON_EXCLAMATION:Int = $00000100
Const wxICON_HAND:Int = $00000200
Const wxICON_WARNING:Int = wxICON_EXCLAMATION
Const wxICON_ERROR:Int = wxICON_HAND
Const wxICON_QUESTION:Int = $00000400
Const wxICON_INFORMATION:Int = $00000800
Const wxICON_STOP:Int = wxICON_HAND
Const wxICON_ASTERISK:Int = wxICON_INFORMATION
Const wxICON_MASK:Int = $00000100|$00000200|$00000400|$00000800

Const wxTAB_TRAVERSAL:Int = $00080000


Const wxID_EDIT:Int = 5030
Const wxID_CUT:Int = 5031
Const wxID_COPY:Int = 5032
Const wxID_PASTE:Int = 5033
Const wxID_CLEAR:Int = 5034
Const wxID_FIND:Int = 5035
Const wxID_DUPLICATE:Int = 5036
Const wxID_SELECTALL:Int = 5037
Const wxID_DELETE:Int = 5038
Const wxID_REPLACE:Int = 5039
Const wxID_REPLACE_ALL:Int = 5040
Const wxID_PROPERTIES:Int = 5041



Const wxID_OK:Int = 5100
Const wxID_CANCEL:Int = 5101
Const wxID_APPLY:Int = 5102
Const wxID_YES:Int = 5103
Const wxID_NO:Int = 5104
Const wxID_STATIC:Int = 5105
Const wxID_FORWARD:Int = 5106
Const wxID_BACKWARD:Int = 5107
Const wxID_DEFAULT:Int = 5108
Const wxID_MORE:Int = 5109
Const wxID_SETUP:Int = 5110
Const wxID_RESET:Int = 5111
Const wxID_CONTEXT_HELP:Int = 5112
Const wxID_YESTOALL:Int = 5113
Const wxID_NOTOALL:Int = 5114
Const wxID_ABORT:Int = 5115
Const wxID_RETRY:Int = 5116
Const wxID_IGNORE:Int = 5117
Const wxID_ADD:Int = 5118
Const wxID_REMOVE:Int = 5119

Const wxID_UP:Int = 5120
Const wxID_DOWN:Int = 5121
Const wxID_HOME:Int = 5122
Const wxID_REFRESH:Int = 5123
Const wxID_STOP:Int = 5124
Const wxID_INDEX:Int = 5125

Const wxID_BOLD:Int = 5126
Const wxID_ITALIC:Int = 5127
Const wxID_JUSTIFY_CENTER:Int = 5128
Const wxID_JUSTIFY_FILL:Int = 5129
Const wxID_JUSTIFY_RIGHT:Int = 5130
Const wxID_JUSTIFY_LEFT:Int = 5131
Const wxID_UNDERLINE:Int = 5132
Const wxID_INDENT:Int = 5133
Const wxID_UNINDENT:Int = 5134
Const wxID_ZOOM_100:Int = 5135
Const wxID_ZOOM_FIT:Int = 5136
Const wxID_ZOOM_IN:Int = 5137
Const wxID_ZOOM_OUT:Int = 5138
Const wxID_UNDELETE:Int = 5139
Const wxID_REVERT_TO_SAVED:Int = 5140

'  System menu IDs (used by wxUniv):
Const wxID_SYSTEM_MENU:Int = 5200
Const wxID_CLOSE_FRAME:Int = 5201
Const wxID_MOVE_FRAME:Int = 5202
Const wxID_RESIZE_FRAME:Int = 5203
Const wxID_MAXIMIZE_FRAME:Int = 5204
Const wxID_ICONIZE_FRAME:Int = 5205
Const wxID_RESTORE_FRAME:Int = 5206

' alignment flags
Const wxALIGN_NOT:Int = $0000
Const wxALIGN_CENTER_HORIZONTAL:Int = $0100
Const wxALIGN_CENTRE_HORIZONTAL:Int = wxALIGN_CENTER_HORIZONTAL
Const wxALIGN_LEFT:Int = wxALIGN_NOT
Const wxALIGN_TOP:Int = wxALIGN_NOT
Const wxALIGN_RIGHT:Int = $0200
Const wxALIGN_BOTTOM:Int = $0400
Const wxALIGN_CENTER_VERTICAL:Int = $0800
Const wxALIGN_CENTRE_VERTICAL:Int = wxALIGN_CENTER_VERTICAL

Const wxALIGN_CENTER:Int = wxALIGN_CENTER_HORIZONTAL | wxALIGN_CENTER_VERTICAL
Const wxALIGN_CENTRE:Int = wxALIGN_CENTER

'  a mask To extract alignment from the combination of flags */
Const wxALIGN_MASK:Int = $0f00

'  Geometric flags */
Const wxCENTRE:Int = $0001
Const wxCENTER:Int = wxCENTRE

'  centering into frame rather than screen (obsolete) */
Const wxCENTER_FRAME:Int = $0000
'  centre on screen rather than parent */
Const wxCENTRE_ON_SCREEN:Int = $0002
Const wxCENTER_ON_SCREEN:Int = wxCENTRE_ON_SCREEN

    ' don't change the values of these elements, they are used elsewhere */
Const wxHORIZONTAL:Int = $0004
Const wxVERTICAL:Int = $0008
Const wxBOTH:Int = wxVERTICAL | wxHORIZONTAL

' stretch
Const wxSTRETCH_NOT:Int = $0000
Const wxSHRINK:Int = $1000
Const wxGROW:Int = $2000
Const wxEXPAND:Int = wxGROW
Const wxSHAPED:Int = $4000
Const wxFIXED_MINSIZE:Int = $8000
Const wxTILE:Int = $c000

Const wxBORDER_DEFAULT:Int = 0
Const wxBORDER_NONE:Int = $00200000
Const wxBORDER_STATIC:Int = $01000000
Const wxBORDER_SIMPLE:Int = $02000000
Const wxBORDER_RAISED:Int = $04000000
Const wxBORDER_SUNKEN:Int = $08000000
Const wxBORDER_DOUBLE:Int = $10000000

'  a mask To extract border style from the combination of flags */
Const wxBORDER_MASK:Int = $1f200000

Const wxDOUBLE_BORDER:Int = wxBORDER_DOUBLE
Const wxSUNKEN_BORDER:Int = wxBORDER_SUNKEN
Const wxRAISED_BORDER:Int = wxBORDER_RAISED
Const wxBORDER:Int = wxBORDER_SIMPLE
Const wxSIMPLE_BORDER:Int = wxBORDER_SIMPLE
Const wxSTATIC_BORDER:Int = wxBORDER_STATIC
Const wxNO_BORDER:Int = wxBORDER_NONE



' direction

Const wxLEFT:Int = $0010
Const wxRIGHT:Int = $0020
Const wxUP:Int = $0040
Const wxDOWN:Int = $0080
Const wxTOP:Int = wxUP
Const wxBOTTOM:Int = wxDOWN
Const wxNORTH:Int = wxUP
Const wxSOUTH:Int = wxDOWN
Const wxWEST:Int = wxLEFT
Const wxEAST:Int = wxRIGHT
Const wxALL:Int = wxUP | wxDOWN | wxRIGHT | wxLEFT


Const wxMENU_TEAROFF:Int = $0001

' Apply To all panel items
Const wxCOLOURED:Int = $0800
Const wxFIXED_LENGTH:Int = $0400

Const wxC2S_NAME:Int = 1   ' Return colour name, when possible
Const wxC2S_CSS_SYNTAX:Int = 2   ' Return colour in rgb(r,g,b) syntax
Const wxC2S_HTML_SYNTAX:Int = 4   ' Return colour in #rrggbb syntax

Const wxALPHA_TRANSPARENT:Int = 0
Const wxALPHA_OPAQUE:Int = $ff


Const wxIMAGELIST_DRAW_NORMAL:Int = $0001
Const wxIMAGELIST_DRAW_TRANSPARENT:Int = $0002
Const wxIMAGELIST_DRAW_SELECTED:Int = $0004
Const wxIMAGELIST_DRAW_FOCUSED:Int = $0008

Const wxIMAGE_LIST_NORMAL:Int = 0 ' Normal icons
Const wxIMAGE_LIST_SMALL:Int = 1  ' Small icons
Const wxIMAGE_LIST_STATE:Int = 2


Const wxUSER_ATTENTION_INFO:Int = 1
Const wxUSER_ATTENTION_ERROR:Int = 2


Const wxFULLSCREEN_NOMENUBAR:Int = $0001
Const wxFULLSCREEN_NOTOOLBAR:Int = $0002
Const wxFULLSCREEN_NOSTATUSBAR:Int = $0004
Const wxFULLSCREEN_NOBORDER:Int = $0008
Const wxFULLSCREEN_NOCAPTION:Int = $0010

Const wxFULLSCREEN_ALL:Int = wxFULLSCREEN_NOMENUBAR | wxFULLSCREEN_NOTOOLBAR | ..
		wxFULLSCREEN_NOSTATUSBAR | wxFULLSCREEN_NOBORDER | wxFULLSCREEN_NOCAPTION


Const wxBITMAP_TYPE_INVALID:Int = 0          ' should be == 0 For compatibility!
Const wxBITMAP_TYPE_BMP:Int = 1
Const wxBITMAP_TYPE_BMP_RESOURCE:Int = 2
Const wxBITMAP_TYPE_RESOURCE:Int = wxBITMAP_TYPE_BMP_RESOURCE
Const wxBITMAP_TYPE_ICO:Int = 3
Const wxBITMAP_TYPE_ICO_RESOURCE:Int = 4
Const wxBITMAP_TYPE_CUR:Int = 5
Const wxBITMAP_TYPE_CUR_RESOURCE:Int = 6
Const wxBITMAP_TYPE_XBM:Int = 7
Const wxBITMAP_TYPE_XBM_DATA:Int = 8
Const wxBITMAP_TYPE_XPM:Int = 9
Const wxBITMAP_TYPE_XPM_DATA:Int = 10
Const wxBITMAP_TYPE_TIF:Int = 11
Const wxBITMAP_TYPE_TIF_RESOURCE:Int = 12
Const wxBITMAP_TYPE_GIF:Int = 13
Const wxBITMAP_TYPE_GIF_RESOURCE:Int = 14
Const wxBITMAP_TYPE_PNG:Int = 15
Const wxBITMAP_TYPE_PNG_RESOURCE:Int = 16
Const wxBITMAP_TYPE_JPEG:Int = 17
Const wxBITMAP_TYPE_JPEG_RESOURCE:Int = 18
Const wxBITMAP_TYPE_PNM:Int = 19
Const wxBITMAP_TYPE_PNM_RESOURCE:Int = 20
Const wxBITMAP_TYPE_PCX:Int = 21
Const wxBITMAP_TYPE_PCX_RESOURCE:Int = 22
Const wxBITMAP_TYPE_PICT:Int = 23
Const wxBITMAP_TYPE_PICT_RESOURCE:Int = 24
Const wxBITMAP_TYPE_ICON:Int = 25
Const wxBITMAP_TYPE_ICON_RESOURCE:Int = 26
Const wxBITMAP_TYPE_ANI:Int = 27
Const wxBITMAP_TYPE_IFF:Int = 28
Const wxBITMAP_TYPE_TGA:Int = 29
Const wxBITMAP_TYPE_MACCURSOR:Int = 30
Const wxBITMAP_TYPE_MACCURSOR_RESOURCE:Int = 31
Const wxBITMAP_TYPE_ANY:Int = 50

Const wxCURSOR_NONE:Int = 0          ' should be 0
Const wxCURSOR_ARROW:Int = 1
Const wxCURSOR_RIGHT_ARROW:Int = 2
Const wxCURSOR_BULLSEYE:Int = 3
Const wxCURSOR_CHAR:Int = 4
Const wxCURSOR_CROSS:Int = 5
Const wxCURSOR_HAND:Int = 6
Const wxCURSOR_IBEAM:Int = 7
Const wxCURSOR_LEFT_BUTTON:Int = 8
Const wxCURSOR_MAGNIFIER:Int = 9
Const wxCURSOR_MIDDLE_BUTTON:Int = 10
Const wxCURSOR_NO_ENTRY:Int = 11
Const wxCURSOR_PAINT_BRUSH:Int = 12
Const wxCURSOR_PENCIL:Int = 13
Const wxCURSOR_POINT_LEFT:Int = 14
Const wxCURSOR_POINT_RIGHT:Int = 15
Const wxCURSOR_QUESTION_ARROW:Int = 16
Const wxCURSOR_RIGHT_BUTTON:Int = 17
Const wxCURSOR_SIZENESW:Int = 18
Const wxCURSOR_SIZENS:Int = 19
Const wxCURSOR_SIZENWSE:Int = 20
Const wxCURSOR_SIZEWE:Int = 21
Const wxCURSOR_SIZING:Int = 22
Const wxCURSOR_SPRAYCAN:Int = 23
Const wxCURSOR_WAIT:Int = 24
Const wxCURSOR_WATCH:Int = 25
Const wxCURSOR_BLANK:Int = 26

Const wxCURSOR_DEFAULT:Int = 27 ' standard X11 cursor
Const wxCURSOR_COPY_ARROW:Int = 27 ' MacOS Theme Plus arrow

Const wxDEFAULT:Int = 70
Const wxDECORATIVE:Int = 71
Const wxROMAN:Int = 72
Const wxSCRIPT:Int = 73
Const wxSWISS:Int = 74
Const wxMODERN:Int = 75
Const wxTELETYPE:Int = 76  ' @@@@

'  Proportional Or Fixed width fonts (Not yet used) */
Const wxVARIABLE:Int = 80
Const wxFIXED:Int = 81

Const wxNORMAL:Int = 90
Const wxLIGHT:Int = 91
Const wxBOLD:Int = 92
'  Also wxNORMAL For normal (non-italic text) */
Const wxITALIC:Int = 93
Const wxSLANT:Int = 94

'  Pen styles
Const wxSOLID:Int = 100
Const wxDOT:Int = 101
Const wxLONG_DASH:Int = 102
Const wxSHORT_DASH:Int = 103
Const wxDOT_DASH:Int = 104
Const wxUSER_DASH:Int = 105

Const wxTRANSPARENT:Int = 106

'  Brush & Pen Stippling. Note that a stippled pen cannot be dashed!! */
'  Note also that stippling a Pen IS meaningfull, because a Line is */
Const wxSTIPPLE_MASK_OPAQUE:Int = 107 ' mask is used For blitting monochrome using text fore And back ground colors */
Const wxSTIPPLE_MASK:Int = 108        ' mask is used For masking areas in the stipple bitmap (To DO) */
'  drawn with a Pen, And without any Brush -- And it can be stippled. */
Const wxSTIPPLE:Int = 110

Const wxBDIAGONAL_HATCH:Int = 111     ' In wxWidgets < 2.6 use WX_HATCH macro  */
Const wxCROSSDIAG_HATCH:Int = 112     ' To verify these wx*_HATCH are in style */
Const wxFDIAGONAL_HATCH:Int = 113     ' of wxBrush. In wxWidgets >= 2.6 use    */
Const wxCROSS_HATCH:Int = 114         ' wxBrush::IsHatch() instead.            */
Const wxHORIZONTAL_HATCH:Int = 115
Const wxVERTICAL_HATCH:Int = 116
Const wxFIRST_HATCH:Int = wxBDIAGONAL_HATCH
Const wxLAST_HATCH:Int = wxVERTICAL_HATCH

Const wxJOIN_BEVEL:Int = 120
Const wxJOIN_MITER:Int = 121
Const wxJOIN_ROUND:Int = 122

Const wxCAP_ROUND:Int = 130
Const wxCAP_PROJECTING:Int = 131
Const wxCAP_BUTT:Int = 132


Const wxFONTFAMILY_DEFAULT:Int = wxDEFAULT
Const wxFONTFAMILY_DECORATIVE:Int = wxDECORATIVE
Const wxFONTFAMILY_ROMAN:Int = wxROMAN
Const wxFONTFAMILY_SCRIPT:Int = wxSCRIPT
Const wxFONTFAMILY_SWISS:Int = wxSWISS
Const wxFONTFAMILY_MODERN:Int = wxMODERN
Const wxFONTFAMILY_TELETYPE:Int = wxTELETYPE
'Const wxFONTFAMILY_MAX,
'Const wxFONTFAMILY_UNKNOWN = wxFONTFAMILY_MAX

Const wxFONTSTYLE_NORMAL:Int = wxNORMAL
Const wxFONTSTYLE_ITALIC:Int = wxITALIC
Const wxFONTSTYLE_SLANT:Int = wxSLANT
'Const wxFONTSTYLE_MAX

Const wxFONTWEIGHT_NORMAL:Int = wxNORMAL
Const wxFONTWEIGHT_LIGHT:Int = wxLIGHT
Const wxFONTWEIGHT_BOLD:Int = wxBOLD
'Const wxFONTWEIGHT_MAX

' font flags
Const wxFONTFLAG_DEFAULT:Int = 0

' slant flags (Default: no slant)
Const wxFONTFLAG_ITALIC:Int = 1 Shl 0
Const wxFONTFLAG_SLANT:Int = 1 Shl 1

' weight flags (Default: medium)
Const wxFONTFLAG_LIGHT:Int = 1 Shl 2
Const wxFONTFLAG_BOLD:Int = 1 Shl 3

' anti-aliasing flag: force on Or off (Default: the current system Default)
Const wxFONTFLAG_ANTIALIASED:Int = 1 Shl 4
Const wxFONTFLAG_NOT_ANTIALIASED:Int = 1 Shl 5

' underlined/strikethrough flags (Default: no lines)
Const wxFONTFLAG_UNDERLINED:Int = 1 Shl 6
Const wxFONTFLAG_STRIKETHROUGH:Int = 1 Shl 7

' the mask of all currently used flags
Const wxFONTFLAG_MASK:Int = wxFONTFLAG_ITALIC | wxFONTFLAG_SLANT | wxFONTFLAG_LIGHT | wxFONTFLAG_BOLD | ..
	wxFONTFLAG_ANTIALIASED | wxFONTFLAG_NOT_ANTIALIASED | wxFONTFLAG_UNDERLINED | wxFONTFLAG_STRIKETHROUGH


Const wxMessageBoxCaptionStr:String = "Message"
Const wxFileSelectorPromptStr:String = "Select a file"
Const wxDirSelectorPromptStr:String = "Select a directory"


Const wxSIZE_AUTO_WIDTH:Int = $0001
Const wxSIZE_AUTO_HEIGHT:Int = $0002
Const wxSIZE_AUTO:Int = wxSIZE_AUTO_WIDTH | wxSIZE_AUTO_HEIGHT
Const wxSIZE_USE_EXISTING:Int = $0000
Const wxSIZE_ALLOW_MINUS_ONE:Int = $0004
Const wxSIZE_NO_ADJUSTMENTS:Int = $0008
Const wxSIZE_FORCE:Int = $0010

Const wxUPDATE_UI_NONE:Int = $0000
Const wxUPDATE_UI_RECURSE:Int = $0001
Const wxUPDATE_UI_FROMIDLE:Int = $0002

Const Origin_Unknown:Int = 0
Const Origin_Keyboard:Int = 1
Const Origin_HelpButton:Int = 2
 

Const wxFromStart:Int = 0
Const wxFromCurrent:Int = 1
Const wxFromEnd:Int = 2

Const wxInvalidOffset:Int = -1

Const wxFILE_KIND_UNKNOWN:Int = 0
Const wxFILE_KIND_DISK:Int = 1     ' a file supporting seeking To arbitrary offsets
Const wxFILE_KIND_TERMINAL:Int = 2 ' a tty
Const wxFILE_KIND_PIPE:Int = 3      ' a pipe
