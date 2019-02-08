' Copyright (c) 2007-2018 Bruce A Henderson
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

Module wx.wxSecretStore

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2018 Bruce A Henderson"


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

?Not linux
Import "common.bmx"

Rem
bbdoc: A collection of secrets, sometimes called a key chain.
about: This type provides access to the secrets stored in the OS-provided facility, e.g. credentials manager under
MSW, keychain under OS X or Freedesktop-compliant password storage mechanism such as GNOME keyring under Unix systems.

Currently only the access to the default keychain/ring is provided using #GetDefault() method, support for other ones could be added in
the future. After calling this method just call #Save() to store a password entered by user and then call #Load() to retrieve it during next
program execution. See Secret Store Sample for an example of using this type.

The @service parameter of the methods in this class should describe the purpose of the password and be unique to your program, e.g.
it could be "MyCompany/MyProgram/SomeServer". Note that the server name must be included in the string to allow storing passwords for more than one server.

Notice that this type is always available under MSW (except when using MinGW32 which doesn't provide the required wincred.h header)
and OS X but requires libsecret (see https://developer.gnome.org/libsecret/) under Unix and may not be compiled in if it wasn't found.
You can check wxUSE_SECRETSTORE to test for this. Moreover, retrieving the default secret store may also fail under Unix during run-time
if the desktop environment doesn't provide one, so don't forget to call #IsOk() to check for this too.
End Rem
Type wxSecretStore

	Field storePtr:Byte Ptr
	
	Function _create:wxSecretStore(storePtr:Byte Ptr)
		If storePtr Then
			Local this:wxSecretStore = New wxSecretStore
			this.storePtr = storePtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Checks if this object is valid.
	End Rem
	Method IsOk:Int()
		Return bmx_wxsecretstore_isok(storePtr)
	End Method
	
	Rem
	bbdoc: Stores a username/password combination.
	about: The service name should be user readable and unique.

	If a secret with the same service name already exists, it will be overwritten with the new value. In particular,
	notice that it is not currently allowed to store passwords for different usernames for the same service, even if
	the underlying platform API supports this (as is the case for macOS but not MSW).

	Returns #False after logging an error message if an error occurs, otherwise returns true indicating that the secret has been
	stored and can be retrieved by calling Load() later.
	End Rem
	Method Save:Int(service:String, username:String, password:wxSecretValue)
		Return bmx_wxsecretstore_save(storePtr, service, username, password.valuePtr)
	End Method
	
	Rem
	bbdoc: Looks up the username/password for the given service.
	about: If no username/password is found for the given service, #False is returned.

	Otherwise the method returns #True and updates the provided username and password arguments.
	End Rem
	Method Load:Int(service:String, username:String Var, password:wxSecretValue)
		Return bmx_wxsecretstore_load(storePtr, service, username, password.valuePtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Remove:Int(service:String)
		Return bmx_wxsecretstore_remove(storePtr, service)
	End Method

	Method Delete()
		If storePtr Then
			bmx_wxsecretstore_free(storePtr)
			storePtr = Null
		End If
	End Method
	
	Rem
	bbdoc: Returns the default secrets collection to use.
	about: Call #IsOk() on the returned object to check if this method succeeded.
	End Rem
	Function GetDefault:wxSecretStore()
		Return _create(bmx_wxsecretstore_default())
	End Function
	
End Type

Rem
bbdoc: Represents the value of a secret in #wxSecretStore.
about: Immutable value-like type which tries to ensure that the secret value will be removed once it's not needed any more.
End Rem
Type wxSecretValue

	Field valuePtr:Byte Ptr
	
	Rem
	bbdoc: Creates a secret value from the given string.
	about: The secret argument may contain NUL bytes.
	The secret value will stored serialized in UTF-8 encoding.
	End Rem
	Method Create:wxSecretValue(secret:String)
		valuePtr = bmx_wxsecretvalue_create(secret)
		Return Self
	End Method

	Rem
	bbdoc: Creates an empty secret value (not the same as an empty password).
	End Rem
	Method CreateEmpty:wxSecretValue()
		valuePtr = bmx_wxsecretvalue_createempty()
		Return Self
	End Method

	Rem
	bbdoc: Creates a secret value from the given data.
	about: The data argument may contain NUL bytes and doesn't need to be NUL-terminated.

	Notice that at least under MSW the maximal size of the secret is limited. The exact limit depends on the OS version and is e.g. 2560 for Windows 7.
	End Rem
	Method CreateWithData:wxSecretValue(size:Int, data:Byte Ptr)
		valuePtr = bmx_wxsecretvalue_createwithdata(size, data)
		Return Self
	End Method

	Rem
	bbdoc: Checks if a secret is not empty.
	End Rem
	Method IsOk:Int()
		Return bmx_wxsecretvalue_isok(valuePtr)
	End Method
	
	Rem
	bbdoc: Gets the size, in bytes, of the secret data.
	about: May return 0.
	End Rem
	Method GetSize:Int()
		Return bmx_wxsecretvalue_getsize(valuePtr)
	End Method
	
	Rem
	bbdoc: Gets read-only access to the secret data.
	about: Don't assume it is NUL-terminated, use GetSize() instead.
	End Rem
	Method GetData:Byte Ptr()
		Return bmx_wxsecretvalue_getdata(valuePtr)
	End Method
	
	Rem
	bbdoc: Compares with another secret for equality.
	End Rem
	Method Equals:Int(other:wxSecretValue)
		Return bmx_wxsecretvalue_isequal(valuePtr, other.valuePtr)
	End Method
	
	Method Delete()
		If valuePtr Then
			bmx_wxsecretvalue_free(valuePtr)
			valuePtr = Null
		End If
	End Method
	
	Rem
	bbdoc: Erases the given area of memory overwriting its presumably sensitive content.
	End Rem
	Function Wipe(size:Int, data:Byte Ptr)
		bmx_wxsecretvalue_wipe(size, data)
	End Function
	
End Type
?
