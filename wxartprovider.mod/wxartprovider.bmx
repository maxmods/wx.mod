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
bbdoc: wxArtProvider
End Rem
Module wx.wxArtProvider

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
bbdoc: wxArtProvider type is used to customize the look of wxWidgets application.
about: When wxWidgets needs to display an icon or a bitmap (e.g. in the standard file dialog), it does
not use a hard-coded resource but asks wxArtProvider for it instead. This way users can plug
in their own wxArtProvider class and easily replace standard art with their own version. All that
is needed is to derive a class from wxArtProvider, override its CreateBitmap method and register
the provider with wxArtProvider::Push.
<p>
There's another way of taking advantage of this class: you can use it in your code and use platform
native icons as provided by wxArtProvider::GetBitmap or wxArtProvider::GetIcon.
</p>
<p>
Every bitmap is known to wxArtProvider under an unique ID that is used by when requesting a resource
from it. The ID is represented by wxArtID type and can have one of these predefined values :
<ul>
<li>wxART_ADD_BOOKMARK</li>
<li>wxART_DEL_BOOKMARK </li>
<li>wxART_HELP_SIDE_PANEL </li>
<li>wxART_HELP_SETTINGS </li>
<li>wxART_HELP_BOOK </li>
<li>wxART_HELP_FOLDER </li>
<li>wxART_HELP_PAGE </li>
<li>wxART_GO_BACK </li>
<li>wxART_GO_FORWARD </li>
<li>wxART_GO_UP </li>
<li>wxART_GO_DOWN </li>
<li>wxART_GO_TO_PARENT </li>
<li>wxART_GO_HOME </li>
<li>wxART_FILE_OPEN </li>
<li>wxART_PRINT </li>
<li>wxART_HELP </li>
<li>wxART_TIP </li>
<li>wxART_REPORT_VIEW </li>
<li>wxART_LIST_VIEW </li>
<li>wxART_NEW_DIR </li>
<li>wxART_FOLDER </li>
<li>wxART_GO_DIR_UP </li>
<li>wxART_EXECUTABLE_FILE </li>
<li>wxART_NORMAL_FILE </li>
<li>wxART_TICK_MARK </li>
<li>wxART_CROSS_MARK </li>
<li>wxART_ERROR </li>
<li>wxART_QUESTION </li>
<li>wxART_WARNING </li>
<li>wxART_INFORMATION </li>
<li>wxART_MISSING_IMAGE</li>
</ul>
Additionally, any string recognized by custom art providers registered using Push may be used.
</p>
<p>
Client is the entity that calls wxArtProvider's GetBitmap or GetIcon function.
It is represented by wxClientID type and can have one of these values: 
<ul>
<li>wxART_TOOLBAR </li>
<li>wxART_MENU </li>
<li>wxART_BUTTON </li>
<li>wxART_FRAME_ICON </li>
<li>wxART_CMN_DIALOG </li>
<li>wxART_HELP_BROWSER </li>
<li>wxART_MESSAGE_BOX </li>
<li>wxART_OTHER (used for all requests that don't fit into any of the categories above) </li>
</ul>
Client ID servers as a hint to wxArtProvider that is supposed to help it to choose the best looking
bitmap. For example it is often desirable to use slightly different icons in menus and toolbars
even though they represent the same action (e.g. wx_ART_FILE_OPEN). Remember that this is really
only a hint for wxArtProvider -- it is common that wxArtProvider::GetBitmap returns identical
bitmap for different client values!
</p>
End Rem
Type wxArtProvider Extends wxObject

	Rem
	bbdoc: Creates a new wxArtProvider.
	End Rem
	Function CreateArtProvider:wxArtProvider()
		Return New wxArtProvider.Create()
	End Function
	
	Rem
	bbdoc: Creates a new wxArtProvider.
	End Rem
	Method Create:wxArtProvider()
		wxObjectPtr = bmx_wxartprovider_create(Self)
		Return Self
	End Method

	Rem
	bbdoc: Query registered providers for bitmap with given ID.
	End Rem
	Function GetBitmap:wxBitmap(id:String, client:String = wxART_OTHER, w:Int = -1, h:Int = -1)
		Return wxBitmap._create(bmx_wxartprovider_getbitmap(id, client, w, h))
	End Function
	
	Rem
	bbdoc: Same as wxArtProvider::GetBitmap, but return a wxIcon object
	End Rem
	Function GetIcon:wxIcon(id:String, client:String = wxART_OTHER, w:Int = -1, h:Int = -1)
		Return wxIcon._create(bmx_wxartprovider_geticon(id, client, w, h))
	End Function
	
	Rem
	bbdoc: Returns a suitable size hint for the given wxArtClient.
	about: If #platformDefault is True, return a size based on the current platform, otherwise return
	the size from the topmost wxArtProvider. wxDefaultSize may be returned if the client doesn't have
	a specified size, like wxART_OTHER for example.
	End Rem
	Function GetSizeHint(client:String, platformDefault:Int = False, width:Int Var, height:Int Var)
		bmx_wxartprovider_getsizehint(client, platformDefault, Varptr width, Varptr height)
	End Function
	
	Rem
	bbdoc: Derived art provider types must override this method to create requested art resource.
	about: Note that returned bitmaps are cached by wxArtProvider and it is therefore not necessary to
	optimize CreateBitmap for speed (e.g. you may create wxBitmap objects from XPMs here).
	<p>
	This is <b>not</b> part of wxArtProvider's public API, use wxArtProvider::GetBitmap or wxArtProvider::GetIcon
	to query wxArtProvider for a resource.
	</p>
	End Rem
	Method CreateBitmap:wxBitmap(id:String, client:String, w:Int, h:Int)
		Return wxNullBitmap
	End Method
	
	' internal callback function
	Function _CreateBitmap:Byte Ptr(obj:Object, id:String, client:String, w:Int, h:Int)
		Return wxArtProvider(obj).CreateBitmap(id, client, w, h).wxObjectPtr
	End Function
	
	Rem
	bbdoc: Delete the given provider.
	End Rem
	Function DeleteProvider:Int(provider:wxArtProvider)
		Return bmx_wxartprovider_deleteprovider(provider.wxObjectPtr)
	End Function
	
	Rem
	bbdoc: Register new art provider and add it to the bottom of providers stack (i.e. it will be queried as the last one).
	End Rem
	Function Insert(provider:wxArtProvider)
		bmx_wxartprovider_insert(provider.wxObjectPtr)
	End Function
	
	Rem
	bbdoc: Remove latest added provider and delete it.
	End Rem
	Function Pop:Int()
		Return bmx_wxartprovider_pop()
	End Function
	
	Rem
	bbdoc: Register new art provider and add it to the top of providers stack (i.e. it will be queried as the first provider).
	End Rem
	Function Push(provider:wxArtProvider)
		bmx_wxartprovider_push(provider.wxObjectPtr)
	End Function

	Rem
	bbdoc: Remove a provider from the stack if it is on it.
	about: The provider is not deleted, unlike when using DeleteProvider().
	End Rem
	Function Remove:Int(provider:wxArtProvider)
		Return bmx_wxartprovider_remove(provider.wxObjectPtr)
	End Function
	
End Type
