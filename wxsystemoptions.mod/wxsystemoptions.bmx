' Copyright (c) 2007-2013 Bruce A Henderson
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
bbdoc: wxSystemOptions
End Rem
Module wx.wxSystemOptions

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2013 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: wxSystemOptions stores option/value pairs that wxWidgets itself or applications can use to alter behaviour at run-time.
about: It can be used to optimize behaviour that doesn't deserve a distinct API, but is still
important to be able to configure.
<p>These options are currently recognised by wxWidgets.</p>
<h3>Windows</h3>
<table width="90%" align="center">
<tr><th>Option</th><th>Value</th></tr>
<tr><td>no-maskblt</td><td>1 to never use WIN32's MaskBlt function, 0 to allow it to be used where
possible. Default: 0. In some circumstances the MaskBlt function can be slower than using the fallback
code, especially if using DC cacheing. By default, MaskBlt will be used where it is implemented by the
operating system and driver.</td></tr>
<tr><td>msw.remap</td><td>If 1 (the default), wxToolBar bitmap colours will be remapped to the current
theme's values. Set this to 0 to disable this functionality, for example if you're using more than 16
colours in your tool bitmaps. </td></tr>
<tr><td>msw.window.no-clip-children</td><td>If 1, windows will not automatically get the WS_CLIPCHILDREN
style. This restores the way windows are refreshed back to the method used in versions of wxWidgets
earlier than 2.5.4, and for some complex window hierarchies it can reduce apparent refresh delays. You
may still specify wxCLIP_CHILDREN for individual windows. </td></tr>
<tr><td>msw.notebook.themed-background</td><td>If set to 0, globally disables themed backgrounds on
notebook pages. Note that this won't disable the theme on the actual notebook background (noticeable
only if there are no pages). </td></tr>
<tr><td>msw.staticbox.optimized-paint</td><td>If set to 0, switches off optimized wxStaticBox painting.
Setting this to 0 causes more flicker, but allows applications to paint graphics on the parent of a
static box (the optimized refresh causes any such drawing to disappear). </td></tr>
<tr><td>msw.display.directdraw</td><td>If set to 1, use DirectDraw-based implementation of wxDisplay.
By default the standard Win32 functions are used. </td></tr>
<tr><td>msw.font.no-proof-quality</td><td>If set to 1, use default fonts quality instead of proof
quality when creating fonts. With proof quality the fonts have slightly better appearance but not
all fonts are available in this quality, e.g. the Terminal font in small sizes is not and this
option may be used if wider fonts selection is more important than higher quality. </td></tr>
</table>
<h3>Linux</h3>
<table width="90%" align="center">
<tr><th>Option</th><th>Value</th></tr>
<tr><td>gtk.window.force-background-colour</td><td>If 1, the backgrounds of windows with the wxBG_STYLE_COLOUR
background style are cleared forcibly instead of relying on the underlying GTK+ window colour.
This works around a display problem when running applications under KDE with the gtk-qt theme
installed (0.6 and below).</td></tr>
</table>
<h3>Mac</h3>
<table width="90%" align="center">
<tr><th>Option</th><th>Value</th></tr>
<tr><td>mac.window-plain-transition</td><td>If 1, uses a plainer transition when showing a window.
You can also use the symbol wxMAC_WINDOW_PLAIN_TRANSITION.</td></tr>
<tr><td>window-default-variant</td><td>The default variant used by windows (cast to integer from the
wxWindowVariant enum). Also known as wxWINDOW_DEFAULT_VARIANT. </td></tr>
<tr><td>mac.listctrl.always_use_generic</td><td>Tells wxListCtrl to use the generic control even when
it is capable of using the native control instead. Also knwon as wxMAC_ALWAYS_USE_GENERIC_LISTCTRL.</td></tr>
</table>
End Rem
Type wxSystemOptions Extends wxObject

	Rem
	bbdoc: Gets an option.
	returns: An empty string if the option hasn't been set.
	about: The function is case-insensitive to name.
	End Rem
	Function GetOption:String(name:String)
		Return bmx_wxsystemtoptions_getoption(name)
	End Function
	
	Rem
	bbdoc: Gets an option as an integer.
	about: The function is case-insensitive to name.
	<p>
	If the option hasn't been set, this function returns 0.
	</p>
	End Rem
	Function GetOptionInt:Int(name:String)
		Return bmx_wxsystemtoptions_getoptionint(name)
	End Function
	
	Rem
	bbdoc: Returns true if the given option is present.
	about: The function is case-insensitive to name.
	End Rem
	Function HasOption:Int(name:String)
		Return bmx_wxsystemtoptions_hasoption(name)
	End Function
	
	Rem
	bbdoc: Returns true if the option with the given name had been set to 0 value.
	about: This is mostly useful for boolean options for which you can't use GetOptionInt(name) = 0 as this would also be true if the option hadn't been set at all.
	End Rem
	Function IsFalse:Int(name:String)
		Return bmx_wxsystemtoptions_isfalse(name)
	End Function
	
	Rem
	bbdoc: Sets an option.
	about: The function is case-insensitive to name.
	End Rem
	Function SetOptionString(name:String, option:String)
		bmx_wxsystemtoptions_setoptionstring(name, option)
	End Function
	
	Rem
	bbdoc: Sets an option.
	about: The function is case-insensitive to name.
	End Rem
	Function SetOption(name:String, option:Int)
		bmx_wxsystemtoptions_setoption(name, option)
	End Function

End Type

