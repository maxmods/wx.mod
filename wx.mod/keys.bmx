' Copyright (c) 2007-2009 Bruce A Henderson
' 
' Permission is hereby granted:Int =  free of charge:Int =  to any person obtaining a copy
' of this software and associated documentation files (the "Software"):Int =  to deal
' in the Software without restriction:Int =  including without limitation the rights
' to use:Int =  copy:Int =  modify:Int =  merge:Int =  publish:Int =  distribute:Int =  sublicense:Int =  and/or sell
' copies of the Software:Int =  and to permit persons to whom the Software is
' furnished to do so:Int =  subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS":Int =  WITHOUT WARRANTY OF ANY KIND:Int =  EXPRESS OR
' IMPLIED:Int =  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY:Int = 
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM:Int =  DAMAGES OR OTHER
' LIABILITY:Int =  WHETHER IN AN ACTION OF CONTRACT:Int =  TORT OR OTHERWISE:Int =  ARISING FROM:Int = 
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Import BRL.KeyCodes

Const wxACCEL_NORMAL:Int = $0000   ' no modifiers
Const wxACCEL_ALT:Int = $001   ' hold Alt key down
Const wxACCEL_CTRL:Int = $0002   ' hold Ctrl key down
Const wxACCEL_SHIFT:Int = $0004   ' hold Shift key down
?macos
Const wxACCEL_CMD:Int = $0008   ' Command key on OS X
?linux
Const wxACCEL_CMD:Int = wxACCEL_CTRL
?win32
Const wxACCEL_CMD:Int = wxACCEL_CTRL
?

Const WXK_BACK:Int = 8
Const WXK_TAB:Int = 9
Const WXK_RETURN:Int = 13
Const WXK_ESCAPE:Int = 27
Const WXK_SPACE:Int = 32
Const WXK_DELETE:Int = 127

Const WXK_START:Int = 300
Const WXK_LBUTTON:Int = 301
Const WXK_RBUTTON:Int = 302
Const WXK_CANCEL:Int = 303
Const WXK_MBUTTON:Int = 304
Const WXK_CLEAR:Int = 305
Const WXK_SHIFT:Int = 306
Const WXK_ALT:Int = 307
Const WXK_CONTROL:Int = 308
Const WXK_MENU:Int = 309
Const WXK_PAUSE:Int = 310
Const WXK_CAPITAL:Int = 311
Const WXK_END:Int = 312
Const WXK_HOME:Int = 313
Const WXK_LEFT:Int = 314
Const WXK_UP:Int = 315
Const WXK_RIGHT:Int = 316
Const WXK_DOWN:Int = 317
Const WXK_SELECT:Int = 318
Const WXK_PRINT:Int = 319
Const WXK_EXECUTE:Int = 320
Const WXK_SNAPSHOT:Int = 321
Const WXK_INSERT:Int = 322
Const WXK_HELP:Int = 323
Const WXK_NUMPAD0:Int = 324
Const WXK_NUMPAD1:Int = 325
Const WXK_NUMPAD2:Int = 326
Const WXK_NUMPAD3:Int = 327
Const WXK_NUMPAD4:Int = 328
Const WXK_NUMPAD5:Int = 329
Const WXK_NUMPAD6:Int = 330
Const WXK_NUMPAD7:Int = 331
Const WXK_NUMPAD8:Int = 332
Const WXK_NUMPAD9:Int = 333
Const WXK_MULTIPLY:Int = 334
Const WXK_ADD:Int = 335
Const WXK_SEPARATOR:Int = 336
Const WXK_SUBTRACT:Int = 337
Const WXK_DECIMAL:Int = 338
Const WXK_DIVIDE:Int = 339
Const WXK_F1:Int = 340
Const WXK_F2:Int = 341
Const WXK_F3:Int = 342
Const WXK_F4:Int = 343
Const WXK_F5:Int = 344
Const WXK_F6:Int = 345
Const WXK_F7:Int = 346
Const WXK_F8:Int = 347
Const WXK_F9:Int = 348
Const WXK_F10:Int = 349
Const WXK_F11:Int = 350
Const WXK_F12:Int = 351
Const WXK_F13:Int = 352
Const WXK_F14:Int = 353
Const WXK_F15:Int = 354
Const WXK_F16:Int = 355
Const WXK_F17:Int = 356
Const WXK_F18:Int = 357
Const WXK_F19:Int = 358
Const WXK_F20:Int = 359
Const WXK_F21:Int = 360
Const WXK_F22:Int = 361
Const WXK_F23:Int = 362
Const WXK_F24:Int = 363
Const WXK_NUMLOCK:Int = 364
Const WXK_SCROLL:Int = 365
Const WXK_PAGEUP:Int = 366
Const WXK_PAGEDOWN:Int = 367
Const WXK_PRIOR:Int = WXK_PAGEUP
Const WXK_NEXT:Int = WXK_PAGEDOWN

Const WXK_NUMPAD_SPACE:Int = 368
Const WXK_NUMPAD_TAB:Int = 369
Const WXK_NUMPAD_ENTER:Int = 370
Const WXK_NUMPAD_F1:Int = 371
Const WXK_NUMPAD_F2:Int = 372
Const WXK_NUMPAD_F3:Int = 373
Const WXK_NUMPAD_F4:Int = 374
Const WXK_NUMPAD_HOME:Int = 375
Const WXK_NUMPAD_LEFT:Int = 376
Const WXK_NUMPAD_UP:Int = 377
Const WXK_NUMPAD_RIGHT:Int = 378
Const WXK_NUMPAD_DOWN:Int = 379
Const WXK_NUMPAD_PAGEUP:Int = 380
Const WXK_NUMPAD_PAGEDOWN:Int = 381

Const WXK_NUMPAD_PRIOR:Int = WXK_NUMPAD_PAGEUP
Const WXK_NUMPAD_NEXT:Int = WXK_NUMPAD_PAGEDOWN

Const WXK_NUMPAD_END:Int = 382
Const WXK_NUMPAD_BEGIN:Int = 383
Const WXK_NUMPAD_INSERT:Int = 384
Const WXK_NUMPAD_DELETE:Int = 385
Const WXK_NUMPAD_EQUAL:Int = 386
Const WXK_NUMPAD_MULTIPLY:Int = 387
Const WXK_NUMPAD_ADD:Int = 388
Const WXK_NUMPAD_SEPARATOR:Int = 389
Const WXK_NUMPAD_SUBTRACT:Int = 390
Const WXK_NUMPAD_DECIMAL:Int = 391
Const WXK_NUMPAD_DIVIDE:Int = 392

Const WXK_WINDOWS_LEFT:Int = 393
Const WXK_WINDOWS_RIGHT:Int = 394
Const WXK_WINDOWS_MENU :Int = 395
Const WXK_COMMAND:Int = 396

    ' Hardware-specific buttons 
Const WXK_SPECIAL1:Int = 193
Const WXK_SPECIAL2:Int = 194
Const WXK_SPECIAL3:Int = 195
Const WXK_SPECIAL4:Int = 196
Const WXK_SPECIAL5:Int = 197
Const WXK_SPECIAL6:Int = 198
Const WXK_SPECIAL7:Int = 199
Const WXK_SPECIAL8:Int = 200
Const WXK_SPECIAL9:Int = 201
Const WXK_SPECIAL10:Int = 202
Const WXK_SPECIAL11:Int = 203
Const WXK_SPECIAL12:Int = 204
Const WXK_SPECIAL13:Int = 205
Const WXK_SPECIAL14:Int = 206
Const WXK_SPECIAL15:Int = 207
Const WXK_SPECIAL16:Int = 208
Const WXK_SPECIAL17:Int = 209
Const WXK_SPECIAL18:Int = 210
Const WXK_SPECIAL19:Int = 211
Const WXK_SPECIAL20:Int = 212

Rem
bbdoc: Maps a wxMax keycode to a BlitzMax keycode.
End Rem
Function MapWxKeyCodeToBlitz:Int(key:Int)
	If key < 91 Then
		If key < 58 And key > 47 Then
			Return key
		Else If key > 64 Then
			Return key
		End If
	End If
	
	If key >= WXK_F1 And key <= WXK_F12 Then
		Return KEY_F1 + (key - WXK_F1)
	End If
	
	Select key
		Case 39 ' quotes ' "
			Return KEY_QUOTES
		Case 44 ' comma
			Return KEY_COMMA
		Case 46 ' period
			Return KEY_PERIOD
		Case 47 ' slash
			Return KEY_SLASH
		Case 59 ' semi-colon
			Return KEY_SEMICOLON
		Case WXK_BACK
			Return KEY_BACKSPACE
		Case WXK_TAB
			Return KEY_TAB
		Case WXK_RETURN, WXK_NUMPAD_ENTER
			Return KEY_RETURN
		Case WXK_ESCAPE
			Return KEY_ESCAPE
		Case WXK_SPACE
			Return KEY_SPACE
		Case WXK_DELETE
			Return KEY_DELETE
		Case 96, 126 ' TILDE - 96 on Mac, 126 on Windows
			Return KEY_TILDE
		Case 91 ' openbracket
			Return KEY_OPENBRACKET
		Case 92 ' backslash
			Return KEY_BACKSLASH
		Case 93 ' closebracket
			Return KEY_CLOSEBRACKET
		Case WXK_SHIFT
			Return KEY_LSHIFT
		Case WXK_ALT
			Return KEY_LALT
		Case WXK_CONTROL
			Return KEY_LCONTROL
		Case WXK_CLEAR
			Return KEY_CLEAR
		Case WXK_MENU
			Return 0
		Case WXK_PAUSE
			Return 19 'KEY_PAUSE
		Case WXK_CAPITAL
			Return 20 'KEY_CAPSLOCK
		Case WXK_END
			Return KEY_END
		Case WXK_HOME
			Return KEY_HOME
		Case WXK_LEFT
			Return KEY_LEFT
		Case WXK_UP
			Return KEY_UP
		Case WXK_RIGHT
			Return KEY_RIGHT
		Case WXK_DOWN
			Return KEY_DOWN
		Case WXK_SELECT
			Return KEY_SELECT
		Case WXK_PRINT
			Return KEY_PRINT
		Case WXK_EXECUTE
			Return KEY_EXECUTE
		Case WXK_SNAPSHOT
			Return KEY_SCREEN
		Case WXK_INSERT
			Return KEY_INSERT
		Case WXK_HELP
			Return 47 'KEY_HELP
		Case WXK_NUMLOCK
			Return 144 'KEY_NUMLOCK
		Case WXK_SCROLL
			Return 145 'KEY_SCROLL
		Case WXK_PAGEUP
			Return KEY_PAGEUP
		Case WXK_PAGEDOWN
			Return KEY_PAGEDOWN
		Case WXK_NUMPAD0, WXK_NUMPAD_INSERT
			Return KEY_NUM0
		Case WXK_NUMPAD1, WXK_NUMPAD_END
			Return KEY_NUM1
		Case WXK_NUMPAD2, WXK_NUMPAD_DOWN
			Return KEY_NUM2
		Case WXK_NUMPAD3, WXK_NUMPAD_PAGEDOWN
			Return KEY_NUM3
		Case WXK_NUMPAD4, WXK_NUMPAD_LEFT
			Return KEY_NUM4
		Case WXK_NUMPAD5
			Return KEY_NUM5
		Case WXK_NUMPAD6, WXK_NUMPAD_RIGHT
			Return KEY_NUM6
		Case WXK_NUMPAD7, WXK_NUMPAD_HOME
			Return KEY_NUM7
		Case WXK_NUMPAD8, WXK_NUMPAD_UP
			Return KEY_NUM8
		Case WXK_NUMPAD9, WXK_NUMPAD_PAGEUP
			Return KEY_NUM9
		Case WXK_NUMPAD_MULTIPLY
			Return KEY_NUMMULTIPLY
		Case WXK_NUMPAD_ADD
			Return KEY_NUMADD
		Case WXK_NUMPAD_SUBTRACT
			Return KEY_NUMSUBTRACT
		Case WXK_NUMPAD_DECIMAL, WXK_NUMPAD_DELETE
			Return KEY_NUMDECIMAL
		Case WXK_NUMPAD_DIVIDE
			Return KEY_NUMDIVIDE
		Case WXK_NUMPAD_EQUAL
			Return KEY_EQUALS ' not very good... looks like BlitzMax is missing (=)
		Case WXK_COMMAND
			Return KEY_LSYS
		Case WXK_ADD, 61, 43 ' 61 on Mac (numpad =), 43 on Windows (numpad =)
			Return KEY_EQUALS
		Case WXK_SUBTRACT, 45
			Return KEY_MINUS
	End Select

	' if we haven't covered the key already, we really need to protect ourselves from returning an out-of-range
	' value.
	DebugLog "Unmapped key : " + key
	' if we don't assert during testing, we'll just return 0 now... just to be sure :-)
	Return 0
End Function

Rem
bbdoc: Maps a BlitzMax keycode to a wxMax keycode.
End Rem
Function MapBlitzKeyCodeToWx:Int(key:Int)
	
	Return key
End Function
