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
bbdoc: wxURI
End Rem
Module wx.wxURI

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
bbdoc: wxURI is used to extract information from a URI (Uniform Resource Identifier).
about: For information about URIs, see RFC 3986.
<p>
In short, a URL is a URI. In other words, URL is a subset of a URI - all acceptable URLs are also
acceptable URIs.
</p>
<p>
wxURI automatically escapes invalid characters in a string, so there is no chance of wxURI 
"failing" on construction/creation.
</p>
End Rem
Type wxURI Extends wxObject

	Rem
	bbdoc: 
	End Rem
	Function CreateURI:wxURI(uri:String = Null)
		Return New wxURI.Create(uri)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxURI(uri:String = Null)
		wxObjectPtr = bmx_wxuri_create(uri)
		Return Self
	End Method

	Rem
	bbdoc: Builds the URI from its individual components and adds proper separators.
	about: If the URI is not a reference or is not resolved, the URI that is returned from Get is the same one passed to Create.
	End Rem
	Method BuildURI:String()
		Return bmx_wxuri_builduri(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Builds the URI from its individual components, adds proper separators, and returns escape sequences to normal characters.
	about: Note that it is preferred to call this over Unescape(BuildURI()) since BuildUnescapedURI performs
	some optimizations over the plain method.
	End Rem
	Method BuildUnescapedURI:String()
		Return bmx_wxuri_buildunescapeduri(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Obtains the fragment of this URI.
	about: The fragment of a URI is the last value of the URI, and is the value after a '' character after the path of the URI.
	<pre>
	http://mysite.com/mypath#&lt;fragment&gt;
	</pre>
	End Rem
	Method GetFragment:String()
		Return bmx_wxuri_getfragment(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Obtains the host type of this URI, which is of type wxURI::HostType:
	End Rem
	Method GetHostType:Int()
		Return bmx_wxuri_gethostyype(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the password part of the userinfo component of this URI.
	about: Note that this is explicitly depreciated by RFC 1396 and should generally be avoided if possible.
	<pre>
	http://&lt;user&gt;:&lt;password&gt;@mysite.com/mypath
	</pre>
	End Rem
	Method GetPassword:String()
		Return bmx_wxuri_getpassword(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the (normalized) path of the URI.
	about: The path component of a URI comes directly after the scheme component if followed by zero or one slashes ('/'), or after the server/port component.
	<p>
	Absolute paths include the leading '/' character.
	<pre>
	http://mysite.com&lt;path&gt;
	</pre>
	</p>
	End Rem
	Method GetPath:String()
		Return bmx_wxuri_getpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a string representation of the URI's port.
	about: The Port of a URI is a value after the server, and must come after a colon (:).
	<pre>
	http://mysite.com:&lt;port&gt;
	</pre>
	Note that you can easily get the numeric value of the port by using String.ToInt().
	End Rem
	Method GetPort:String()
		Return bmx_wxuri_getport(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the Query component of the URI.
	about: The query component is what is commonly passed to a cgi application, and must come after the path component, and after a '?' character.
	<pre>
	http://mysite.com/mypath?&lt;query&gt;
	</pre>
	End Rem
	Method GetQuery:String()
		Return bmx_wxuri_getquery(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the Scheme component of the URI.
	about: The first part of the uri.
	<pre>
	&lt;scheme&gt;://mysite.com
	</pre>
	End Rem
	Method GetScheme:String()
		Return bmx_wxuri_getscheme(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the Server component of the URI.
	about: The server of the uri can be a server name or a type of ip address. See GetHostType for the possible values
	for the host type of the server component.
	<pre>
	http://&lt;server&gt;/mypath
	</pre>
	End Rem
	Method GetServer:String()
		Return bmx_wxuri_getserver(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the username part of the userinfo component of this URI.
	about: Note that this is explicitly depreciated by RFC 1396 and should generally be avoided if possible.
	<pre>
	http://&lt;user&gt;:&lt;password&gt;@mysite.com/mypath
	</pre>
	End Rem
	Method GetUser:String()
		Return bmx_wxuri_getuser(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the UserInfo component of the URI.
	about: The component of a URI before the server component that is postfixed by a '@' character.
	<pre>
	http://&lt;userinfo&gt;@mysite.com/mypath
	</pre>
	End Rem
	Method GetUserInfo:String()
		Return bmx_wxuri_getuserinfo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the Fragment component of the URI exists.
	End Rem
	Method HasFragment:Int()
		Return bmx_wxuri_hasfragment(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the Path component of the URI exists.
	End Rem
	Method HasPath:Int()
		Return bmx_wxuri_haspath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the Port component of the URI exists.
	End Rem
	Method HasPort:Int()
		Return bmx_wxuri_hasport(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the Query component of the URI exists.
	End Rem
	Method HasQuery:Int()
		Return bmx_wxuri_hasquery(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the Scheme component of the URI exists.
	End Rem
	Method HasScheme:Int()
		Return bmx_wxuri_hasscheme(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the Server component of the URI exists.
	End Rem
	Method HasServer:Int()
		Return bmx_wxuri_hasserver(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if a valid [absolute] URI, otherwise this URI is a URI reference and not a full URI, and IsReference returns false.
	End Rem
	Method IsReference:Int()
		Return bmx_wxuri_isreference(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Compares this URI to another URI, and returns true if this URI is equal, otherwise it returns false.
	End Rem
	Method Equals:Int(uri:wxURI)
		Return bmx_wxuri_equals(wxObjectPtr, uri.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Inherits this URI from a base URI.
	about: Components that do not exist in this URI are copied from the base, and if this URI's path is not an absolute path (prefixed by a '/'), then this URI's path is merged with the base's path.
	<p>
	For instance, resolving "../mydir" from "http://mysite.com/john/doe" results in the scheme (http) and server
	(mysite.com) being copied into this URI, since they do not exist. In addition, since the path of this URI is not
	absolute (does not begin with '/'), the path of the base's is merged with this URI's path, resulting in the URI
	"http://mysite.com/john/mydir".
	</p>
	base
	Base URI to inherit from. Must be a full URI and not a reference
	flags
	Currently either wxURI_STRICT or 0, in non-strict mode some compatibility layers are enabled to allow loopholes from RFCs prior to 2396
	End Rem
	Method Resolve(base:wxURI, flags:Int = wxURI_STRICT)
		bmx_wxuri_resolve(wxObjectPtr, base.wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: Translates all escape sequences (normal characters and returns the result.
	about: This is the preferred over deprecated wxURL::ConvertFromURI.
	<p>
	If you want to unescape an entire wxURI, use BuildUnescapedURI instead, as it performs some optimizations over
	this method.
	</p>
	uri
	string with escaped characters to convert
	End Rem
	Function Unescape:String(uri:String)
		Return bmx_wxuri_unescape(uri)
	End Function
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxuri_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: wxURL is a specialization of wxURI for parsing URLs.
about: Please look at wxURI documentation for more info about the functions you can use to
retrieve the various parts of the URL (scheme, server, port, etc).
End Rem
Type wxURL Extends wxURI

End Type

