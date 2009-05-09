' Copyright (c) 2007-2009 Bruce A Henderson
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

Rem
bbdoc: wxBitmapButton
End Rem
Module wx.wxBitmapButton

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


?linux
ModuleInfo "CC_OPTS: -D__WXGTK__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?win32
ModuleInfo "CC_OPTS: -DHAVE_W32API_H"
ModuleInfo "CC_OPTS: -D__WXMSW__"
ModuleInfo "CC_OPTS: -D_UNICODE"
ModuleInfo "CC_OPTS: -DUNICODE"
?macos
ModuleInfo "CC_OPTS: -D__WXMAC__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"



Rem
bbdoc: A bitmap button is a control that contains a bitmap.
about: It may be placed on a dialog box or panel, or indeed almost any other window.
<p>
A bitmap button can be supplied with a single bitmap, and wxWidgets will draw all button states using this bitmap.
If the application needs more control, additional bitmaps for the selected state, unpressed focused state, and
greyed-out state may be supplied.
</p>
<p><b>Button States</b>
<br>
This type supports bitmaps for several different states:
<table width="90%" align="center">
<tr><td>normal</td><td>This is the bitmap shown in the default state, it must be always valid
while all the other bitmaps are optional and don't have to be set. </td></tr>
<tr><td>disabled</td><td>Bitmap shown when the button is disabled. </td></tr>
<tr><td>selected</td><td>Bitmap shown when the button is pushed (e.g. while the user keeps the
mouse button pressed on it) </td></tr>
<tr><td>focus</td><td>Bitmap shown when the button has keyboard focus but is not pressed. </td></tr>
<tr><td>hover</td><td>Bitmap shown when the mouse is over the button (but it is not pressed).
Notice that if hover bitmap is not specified but the current platform UI uses hover images for
the buttons (such as Windows XP or GTK+), then the focus bitmap is used for hover state as well.
This makes it possible to set focus bitmap only to get reasonably good behaviour on all platforms. </td></tr>
</table>
</p>
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxBU_AUTODRAW</td><td>If this is specified, the button will be drawn automatically using
the label bitmap only, providing a 3D-look border. If this style is not specified, the button
will be drawn without borders and using all provided bitmaps. WIN32 only. </td></tr>
<tr><td>wxBU_LEFT</td><td>Left-justifies the bitmap label. WIN32 only.</td></tr>
<tr><td>wxBU_TOP</td><td>Aligns the bitmap label to the top of the button. WIN32 only. </td></tr>
<tr><td>wxBU_RIGHT</td><td>Right-justifies the bitmap label. WIN32 only. </td></tr>
<tr><td>wxBU_BOTTOM</td><td>Aligns the bitmap label to the bottom of the button. WIN32 only.</td></tr>
</table>
</p>
<p>
Note that wxBU_EXACTFIT supported by wxButton is not used by this class as bitmap buttons don't
have any minimal standard size by default.
</p>
<p>
See also <a href="../../wxwindow.mod/doc/commands.html#wxWindow">wxWindow</a> styles.
</p>
<p><b>Event Handling</b>
<ul>
<li><tt>wxEVT_COMMAND_BUTTON_CLICKED </tt> - Process a wxCommandEvent, when the button is clicked.</li>
</ul>
</p>
End Rem
Type wxBitmapButton Extends wxButton

	Function _create:wxBitmapButton(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxBitmapButton = New wxBitmapButton
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _xrcNew:wxBitmapButton(wxObjectPtr:Byte Ptr)
		Return wxBitmapButton._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateBitmapButton:wxButton(parent:wxWindow, id:Int, bitmap:wxBitmap, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxBU_AUTODRAW)
			
		Return New wxBitmapButton.Create(parent, id, bitmap, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see CreateButton.
	End Rem
	Method Create:wxBitmapButton(parent:wxWindow, id:Int, bitmap:Object, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxBU_AUTODRAW)
			
		Assert wxBitmap(bitmap), "Parameter 'bitmap' does not appear to be a bitmap!"
		
		wxObjectPtr = bmx_wxbitmapbutton_create(Self, parent.wxObjectPtr, id, wxBitmap(bitmap).wxObjectPtr, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Returns the bitmap for the disabled state, may be invalid.
	End Rem
	Method GetBitmapDisabled:wxBitmap()
		Return wxBitmap._create(bmx_wxbitmapbutton_getbitmapdisabled(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the bitmap for the focused state, may be invalid.
	End Rem
	Method GetBitmapFocus:wxBitmap()
		Return wxBitmap._create(bmx_wxbitmapbutton_getbitmapfocus(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the bitmap used when the mouse is over the button, may be invalid.
	End Rem
	Method GetBitmapHover:wxBitmap()
		Return wxBitmap._create(bmx_wxbitmapbutton_getbitmaphover(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: A reference to the button's label bitmap.
	End Rem
	Method GetBitmapLabel:wxBitmap()
		Return wxBitmap._create(bmx_wxbitmapbutton_getbitmaplabel(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the bitmap for the pushed button state, may be invalid.
	End Rem
	Method GetBitmapSelected:wxBitmap()
		Return wxBitmap._create(bmx_wxbitmapbutton_getbitmapselected(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Sets the bitmap for the disabled button appearance.
	End Rem
	Method SetBitmapDisabled(bitmap:wxBitmap)
		bmx_wxbitmapbutton_setbitmapdisabled(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the bitmap for the button appearance when it has the keyboard focus.
	End Rem
	Method SetBitmapFocus(bitmap:wxBitmap)
		bmx_wxbitmapbutton_setbitmapfocus(wxObjectPtr, bitmap.wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the bitmap to be shown when the mouse is over the button.
	End Rem
	Method SetBitmapHover(bitmap:wxBitmap)
		bmx_wxbitmapbutton_setbitmaphover(wxObjectPtr, bitmap.wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the bitmap label for the button.
	about: This is the bitmap used for the unselected state, and for all other states if no other bitmaps are provided.
	End Rem
	Method SetBitmapLabel(bitmap:wxBitmap)
		bmx_wxbitmapbutton_setbitmaplabel(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the bitmap for the selected (depressed) button appearance.
	End Rem
	Method SetBitmapSelected(bitmap:wxBitmap)
		bmx_wxbitmapbutton_setbitmapselected(wxObjectPtr, bitmap.wxObjectPtr)
	End Method

End Type


Type TBitmapButtonResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxbitmapbutton_addresourcehandler()
	End Method
		
End Type

New TBitmapButtonResourceFactory
