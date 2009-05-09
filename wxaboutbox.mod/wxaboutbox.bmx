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
bbdoc: wxAboutBox
End Rem
Module wx.wxAboutBox

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
bbdoc: This function shows the standard about dialog containing the information specified in info.
about: If the current platform has a native about dialog which is capable of showing all the fields in info,
the native dialog is used, otherwise the function falls back to the generic wxWidgets version of the dialog,
i.e. does the same thing as wxGenericAboutBox().
End Rem
Function wxAboutBox(info:wxAboutDialogInfo)
	bmx_wxaboutbox(info.wxAboutDialogInfoPtr)
End Function

Rem
bbdoc: wxAboutDialogInfo contains information shown in the standard About dialog displayed by the wxAboutBox() function.
about: This type contains the general information about the program, such as its name, version, copyright and so on,
as well as lists of the program developers, documentation writers, artists and translators. The simple properties
from the former group are represented as a string with the exception of the program icon and the program web site,
while the lists from the latter group are stored as wxArrayString and can be either set entirely at once using
SetDevelopers and similar functions or built one by one using AddDeveloper etc.
<p>
Please also notice that while all the main platforms have the native implementation of the about dialog, they are
often more limited than the generic version provided by wxWidgets and so the generic version is used if
wxAboutDialogInfo has any fields not supported by the native version. Currently GTK+ version supports all the
possible fields natively but MSW and Mac versions don't support URLs, licence text nor custom icons in the about
dialog and if either of those is used, wxAboutBox() will automatically use the generic version so you should avoid
specifying these fields to achieve more native look and feel.
</p>
End Rem
Type wxAboutDialogInfo

	Field wxAboutDialogInfoPtr:Byte Ptr
	
	Rem
	bbdoc: Default constructor leaves all fields are initially uninitialized
	about: In general you should call at least SetVersion, SetCopyright and SetDescription.
	End Rem
	Function CreateAboutDialogInfo:wxAboutDialogInfo()
		Return New wxAboutDialogInfo.Create()
	End Function
	
	Rem
	bbdoc: Default constructor leaves all fields are initially uninitialized
	about: In general you should call at least SetVersion, SetCopyright and SetDescription.
	End Rem
	Method Create:wxAboutDialogInfo()
		wxAboutDialogInfoPtr = bmx_wxaboutdialoginfo_create()
		Return Self
	End Method

	Rem
	bbdoc: Adds an artist name to be shown in the program credits.
	End Rem
	Method AddArtist(name:String)
		bmx_wxaboutdialoginfo_addartist(wxAboutDialogInfoPtr, name)
	End Method
	
	Rem
	bbdoc: Adds a developer name to be shown in the program credits.
	End Rem
	Method AddDeveloper(name:String)
		bmx_wxaboutdialoginfo_adddeveloper(wxAboutDialogInfoPtr, name)
	End Method
	
	Rem
	bbdoc: Adds a documentation writer name to be shown in the program credits.
	End Rem
	Method AddDocWriter(name:String)
		bmx_wxaboutdialoginfo_adddocwriter(wxAboutDialogInfoPtr, name)
	End Method
	
	Rem
	bbdoc: Adds a translator name to be shown in the program credits.
	about: Notice that if no translator names are specified explicitely, wxAboutBox() will try to use the
	translation of the string translator-credits from the currently used message catalog -- this can be used to
	show just the name of the translator of the program in the current language.
	End Rem
	Method AddTranslator(name:String)
		bmx_wxaboutdialoginfo_addtranslator(wxAboutDialogInfoPtr, name)
	End Method
	
	Rem
	bbdoc: Sets the the list of artists to be shown in the program credits.
	End Rem
	Method SetArtists(names:String[])
		bmx_wxaboutdialoginfo_setartists(wxAboutDialogInfoPtr, names)
	End Method

	Rem
	bbdoc: Set the short string containing the program copyright information.
	about: Notice that any occurrences of "(C)" in copyright will be replaced by the copyright symbol (circled C)
	automatically, which means that you can avoid using this symbol in the program source code which can be
	problematic.
	End Rem
	Method SetCopyright(copyright:String)
		bmx_wxaboutdialoginfo_setcopyright(wxAboutDialogInfoPtr, copyright)
	End Method
	
	Rem
	bbdoc: Set brief, but possibly multiline, description of the program.
	End Rem
	Method SetDescription(desc:String)
		bmx_wxaboutdialoginfo_setdescription(wxAboutDialogInfoPtr, desc)
	End Method
	
	Rem
	bbdoc: Set the list of developers of the program.
	End Rem
	Method SetDevelopers(names:String[])
		bmx_wxaboutdialoginfo_setdevelopers(wxAboutDialogInfoPtr, names)
	End Method
	
	Rem
	bbdoc: Set the list of documentation writers.
	End Rem
	Method SetDocWriters(names:String[])
		bmx_wxaboutdialoginfo_setdocwriters(wxAboutDialogInfoPtr, names)
	End Method
	
	Rem
	bbdoc: Set the icon to be shown in the dialog.
	about: By default the icon of the main frame will be shown if the native about dialog supports custom icons.
	If it doesn't but a valid icon is specified using this method, the generic about dialog is used instead so
	you should avoid calling this function for maximally native look and feel.
	End Rem
	Method SetIcon(icon:wxIcon)
		bmx_wxaboutdialoginfo_seticon(wxAboutDialogInfoPtr, icon.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set the long, multiline string containing the text of the program licence.
	about: Only GTK+ version supports showing the licence text in the native about dialog currently so the
	generic version will be used under all the other platforms if this method is called. To preserve the native
	look and feel it is advised that you do not call this method but provide a separate menu item in the "Help"
	menu for displaying the text of your program licence.
	End Rem
	Method SetLicence(licence:String)
		bmx_wxaboutdialoginfo_setlicence(wxAboutDialogInfoPtr, licence)
	End Method
	
	Rem
	bbdoc: This is the same as SetLicence.
	End Rem
	Method SetLicense(licence:String)
		SetLicence(licence)
	End Method
	
	Rem
	bbdoc: Set the name of the program.
	about: If this method is not called, the string returned by wxApp::GetAppName() will be shown in the dialog.
	End Rem
	Method SetName(name:String)
		bmx_wxaboutdialoginfo_setname(wxAboutDialogInfoPtr, name)
	End Method
	
	Rem
	bbdoc: Set the list of translators.
	about: Please see AddTranslator for additional discussion.
	End Rem
	Method SetTranslators(names:String[])
		bmx_wxaboutdialoginfo_settranslators(wxAboutDialogInfoPtr, names)
	End Method
	
	Rem
	bbdoc: Set the version of the program.
	about: The version is in free format, i.e. not necessarily in the x.y.z form but it shouldn't contain
	the "version" word.
	End Rem
	Method SetVersion(version:String)
		bmx_wxaboutdialoginfo_setversion(wxAboutDialogInfoPtr, version)
	End Method
	
	Rem
	bbdoc: Set the web site for the program and its description (which defaults to URL itself if empty).
	about: Please notice that only GTK+ version currently supports showing the link in the native about dialog so
	if this method is called, the generic version will be used under all the other platforms.
	End Rem
	Method SetWebSite(url:String, desc:String = Null)
		bmx_wxaboutdialoginfo_setwebsite(wxAboutDialogInfoPtr, url, desc)
	End Method
	
	Method Delete()
		If wxAboutDialogInfoPtr Then
			bmx_wxaboutdialoginfo_delete(wxAboutDialogInfoPtr)
			wxAboutDialogInfoPtr = Null
		End If
	End Method
	
End Type

