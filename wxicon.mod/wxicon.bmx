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

Rem
bbdoc: wxIcon
End Rem
Module wx.wxIcon

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007 Bruce A Henderson"
ModuleInfo "Modserver: BRL"

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
bbdoc: An icon is a small rectangular bitmap usually used for denoting a minimized application.
about: It differs from a wxBitmap in always having a mask associated with it for transparent drawing.
On some platforms, icons and bitmaps are implemented identically, since there is no real distinction
between a wxBitmap with a mask and an icon; and there is no specific icon format on some platforms
(X-based applications usually standardize on XPMs for small bitmaps and icons). However, some platforms
(such as Windows) make the distinction, so a separate class is provided.
End Rem
Type wxIcon Extends wxBitmap

	Function _create:wxIcon(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxIcon = New wxIcon
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreateFromFile:wxIcon(name:Object, kind:Int = wxBITMAP_TYPE_XPM, desiredWidth:Int = -1, desiredHeight:Int = -1)
		Local icon:wxIcon = New wxIcon.Create()
		If icon.LoadFile(name, kind, desiredWidth, desiredHeight)
			Return icon
		End If
		
		Return wxNullIcon
	End Function
	
	Method Create:wxIcon()
		wxObjectPtr = bmx_wxicon_create()
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LoadFile:Int(name:Object, kind:Int = wxBITMAP_TYPE_XPM, desiredWidth:Int = -1, desiredHeight:Int = -1)

		If TStream(name) Then
			' create a maxInputStream and attempt to load
			Local stream:wxMaxInputStream = New wxMaxInputStream.Create(name)
			Local imagePtr:Byte Ptr = bmx_wximage_createfromstream(stream.wxStreamPtr, kind, -1)
			TStream(name).Close()
			
			If imagePtr Then
				' create the bitmap from the image
				Local bitmapPtr:Byte Ptr = bmx_wxbitmap_createfromimage(imagePtr, -1)
				bmx_wxicon_copyfrombitmap(wxObjectPtr, bitmapPtr)
				bmx_wximage_delete(imagePtr)
				bmx_wxbitmap_delete(bitmapPtr)
			End If
			
		Else If wxInputStream(name) Then
			' load using this input stream
			Local imagePtr:Byte Ptr = bmx_wximage_createfromstream(wxInputStream(name).wxStreamPtr, kind, -1)
			
			If imagePtr Then
				' create the bitmap from the image
				Local bitmapPtr:Byte Ptr = bmx_wxbitmap_createfromimage(imagePtr, -1)
				bmx_wxicon_copyfrombitmap(wxObjectPtr, bitmapPtr)
				bmx_wximage_delete(imagePtr)
				bmx_wxbitmap_delete(bitmapPtr)
			End If
		Else
			Local str:String = String(name)
			If str Then
				If str.Find( "::",0 ) > 0 Then
					' Create a stream and load it
					Local stream:TStream = ReadStream(str)
					If stream Then ' did we get a stream?
						Local inp:wxMaxInputStream = New wxMaxInputStream.Create(stream)
						Local imagePtr:Byte Ptr = bmx_wximage_createfromstream(inp.wxStreamPtr, kind, -1)
						stream.Close()
						
						If imagePtr Then
							' create the bitmap from the image
							Local bitmapPtr:Byte Ptr = bmx_wxbitmap_createfromimage(imagePtr, -1)
							bmx_wxicon_copyfrombitmap(wxObjectPtr, bitmapPtr)
							bmx_wximage_delete(imagePtr)
							bmx_wxbitmap_delete(bitmapPtr)
						End If
					End If
				Else
					' use the default loader
					Return bmx_wxicon_loadfile(wxObjectPtr, str, kind)
				End If
			End If
		End If

		Return IsOk()
	End Method

	Rem
	bbdoc: Gets the colour depth of the icon.
	about: A value of 1 indicates a monochrome icon.
	End Rem
	Method GetDepth:Int()
		Return bmx_wxicon_getdepth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the height of the bitmap in pixels.
	End Rem
	Method GetHeight:Int()
		Return bmx_wxicon_getheight(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the width of the bitmap in pixels.
	End Rem
	Method GetWidth:Int()
		Return bmx_wxicon_getwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if bitmap data is present.
	End Rem
	Method IsOk:Int()
		Return bmx_wxicon_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the depth member (does not affect the icon data).
	End Rem
	Method SetDepth(depth:Int)
		bmx_wxicon_setdepth(wxObjectPtr, depth)
	End Method
	
	Rem
	bbdoc: Sets the height member (does not affect the icon data).
	End Rem
	Method SetHeight(height:Int)
		bmx_wxicon_setheight(wxObjectPtr, height)
	End Method
	
	Rem
	bbdoc: Sets the width member (does not affect the icon data).
	End Rem
	Method SetWidth(width:Int)
		bmx_wxicon_setwidth(wxObjectPtr, width)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxicon_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Global wxNullIcon:wxIcon = wxIcon._create(bmx_wxicon_null())

Rem
bbdoc: This type contains multiple copies of an icon in different sizes, see also wxDialog::SetIcons and wxTopLevelWindow::SetIcons.
End Rem
Type wxIconBundle

	Field wxObjectPtr:Byte Ptr
	
	Function _create:wxIconBundle(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxIconBundle = New wxIconBundle
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Creates the bundle with the icon(s) found in the file.
	End Rem
	Function CreateIconBundle:wxIconBundle(filename:String, ftype:Int)
		Return New wxIconBundle.Create(filename, ftype)
	End Function
	
	Rem
	bbdoc: Creates the bundle with the icon(s) found in the file.
	End Rem
	Method Create:wxIconBundle(filename:String, ftype:Int)
		wxObjectPtr = bmx_iconbundle_create(filename, ftype)
		Return Self
	End Method
	
	Rem
	bbdoc: Creates the bundle with a single icon.
	End Rem
	Function CreateIconBundleWithIcon:wxIconBundle(icon:wxIcon)
		Return New wxIconBundle.CreateWithIcon(icon)
	End Function
	
	Rem
	bbdoc: Creates the bundle with a single icon.
	End Rem
	Method CreateWithIcon:wxIconBundle(icon:wxIcon)
		wxObjectPtr = bmx_wxiconbundle_createwithicon(icon.wxObjectPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Adds all the icons contained in the file to the bundle.
	about: If the collection already contains icons with the same width and height,
	they are replaced by the new ones.
	End Rem
	Method AddIcon(file:String, ftype:Int)
		bmx_wxiconbundle_addicon(wxObjectPtr, file, ftype)
	End Method
	
	Rem
	bbdoc: Adds the icon to the collection.
	about: If the collection already contains an icon with the same width and height,
	it is replaced by the new one.
	End Rem
	Method AddIconIcon(icon:wxIcon)
		bmx_wxiconbundle_addiconicon(wxObjectPtr, icon.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the icon with the given size.
	about: If no such icon exists, returns the icon with size wxSYS_ICON_X/wxSYS_ICON_Y.
	If no such icon exists, returns the first icon in the bundle. If size is ( -1, -1 ), returns
	the icon with size wxSYS_ICON_X/wxSYS_ICON_Y.
	End Rem
	Method GetIcon:wxIcon(w:Int, h:Int)
		Return wxIcon._create(bmx_wxiconbundle_geticon(wxObjectPtr, w, h))
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxiconbundle_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

