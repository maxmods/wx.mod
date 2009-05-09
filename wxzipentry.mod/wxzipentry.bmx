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
bbdoc: wxZipEntry
End Rem
Module wx.wxZipEntry

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
bbdoc: Holds the meta-data for an entry in a zip.
End Rem
Type wxZipEntry Extends wxArchiveEntry

	Function _create:wxZipEntry(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxZipEntry = New wxZipEntry
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: A short comment for this entry.
	End Rem
	Method GetComment:String()
		Return bmx_wxzipentry_getcomment(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: The compressed size of this entry in bytes.
	End Rem
	Method GetCompressedSize:Int()
		Return bmx_wxzipentry_getcompressedsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: CRC32 for this entry's data.
	End Rem
	Method GetCrc:Int()
		Return bmx_wxzipentry_getcrc(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: The entry's timestamp.
	End Rem
	Method GetDateTime:wxDateTime()
		Return wxDateTime._create(bmx_wxzipentry_getdatetime(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: The extra field from the entry's central directory record.
	about: The extra field is used to store platform or application specific data. See Pkware's document
	'appnote.txt' for information on its format.
	End Rem
	Method GetExtra:Byte Ptr()
		Return bmx_wxzipentry_getextra(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the length of the extra field data.
	End Rem
	Method GetExtraLen:Int()
		Return bmx_wxzipentry_getextralen(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Retrieves entry external attributes
	about: The low 8 bits are always the DOS/Windows file attributes for this entry. The values of these attributes
	are given in the enumeration wxZipAttributes.
	<p>
	The remaining bits can store platform specific permission bits or attributes, and their meaning depends on the
	value of SetSystemMadeBy(). If IsMadeByUnix() is true then the high 16 bits are unix mode bits.
	</p>
	End Rem
	Method GetExternalAttributes:Int()
		Return bmx_wxzipentry_getexternalattributes(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a combination of the bits flags in the enumeration wxZipFlags.
	End Rem
	Method GetFlags:Int()
		Return bmx_wxzipentry_getflags(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the path format used internally within the archive to store filenames.
	End Rem
	Method GetInternalFormat:Int()
		Return bmx_wxzipentry_getinternalformat(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the entry's filename in the internal format used within the archive.
	about: The name can include directory components, i.e. it can be a full path.
	<p>
	The names of directory entries are returned without any trailing path separator. This gives a canonical name that
	can be used in comparisons.
	</p>
	End Rem
	Method GetInternalName:String()
		Return bmx_wxzipentry_getinternalname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: The extra field from the entry's local record.
	about: The extra field is used to store platform or application specific data. See Pkware's document
	'appnote.txt' for information on its format.
	End Rem
	Method GetLocalExtra:Byte Ptr()
		Return bmx_wxzipentry_getlocalextra(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the length of the local record extra field data.
	End Rem
	Method GetLocalExtraLen:Int()
		Return bmx_wxzipentry_getlocalextralen(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: The compression method.
	about: The enumeration wxZipMethod lists the possible values.
	<p>
	The default constructor sets this to wxZIP_METHOD_DEFAULT, which allows wxZipOutputStream to choose the method when
	writing the entry.
	</p>
	End Rem
	Method GetMethod:Int()
		Return bmx_wxzipentry_getmethod(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: If IsMadeByUnix() is true then returns the unix permission bits stored in GetExternalAttributes(), otherwise synthesises them from the DOS attributes.
	End Rem
	Method GetMode:Int()
		Return bmx_wxzipentry_getmode(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: The entry's name, by default in the native format.
	about: The name can include directory components, i.e. it can be a full path.
	<p>
	If this is a directory entry, (i.e. if IsDir() is true) then GetName() returns the name with a trailing path separator.
	</p>
	End Rem
	Method GetName:String(format:Int = wxPATH_NATIVE)
		Return bmx_wxzipentry_getname(wxObjectPtr, format)
	End Method
	
	Rem
	bbdoc: Returns true if GetSystemMadeBy() is a flavour of unix.
	End Rem
	Method IsMadeByUnix:Int()
		Return bmx_wxzipentry_ismadebyunix(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Indicates that this entry's data is text in an 8-bit encoding.
	End Rem
	Method IsText:Int()
		Return bmx_wxzipentry_istext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetName(name:String, format:Int = wxPATH_NATIVE)
		bmx_wxzipentry_setname(wxObjectPtr, name, format)
	End Method
	
	Rem
	bbdoc: Returns a numeric value unique to the entry within the archive.
	End Rem
	Method GetOffset:Int()
		Return bmx_wxzipentry_getoffset(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: The size of the entry's data in bytes.
	End Rem
	Method GetSize:Int()
		Return bmx_wxzipentry_getsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSystemMadeBy:Int()
		Return bmx_wxzipentry_getsystemmadeby(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the short comment for this entry.
	End Rem
	Method SetComment(comment:String)
		bmx_wxzipentry_setcomment(wxObjectPtr, comment)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetExtra(extra:Byte Ptr, length:Int)
		bmx_wxzipentry_setextra(wxObjectPtr, extra, length)
	End Method
	
	Rem
	bbdoc: Sets the external attributes
	End Rem
	Method SetExternalAttributes(attr:Int)
		bmx_wxzipentry_setexternalattributes(wxObjectPtr, attr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetIsText(text:Int = True)
		bmx_wxzipentry_setistext(wxObjectPtr, text)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLocalExtra(extra:Byte Ptr, length:Int)
		bmx_wxzipentry_setlocalextra(wxObjectPtr, extra, length)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMethod(meth:Int)
		bmx_wxzipentry_setmethod(wxObjectPtr, meth)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMode(mode:Int)
		bmx_wxzipentry_setmode(wxObjectPtr, mode)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSize(size:Int)
		bmx_wxzipentry_setsize(wxObjectPtr, size)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSystemMadeBy(system:Int)
		bmx_wxzipentry_setsystemmadeby(wxObjectPtr, system)
	End Method
	
	Rem
	bbdoc: Returns True if this entry is a dir.
	End Rem
	Method IsDir:Int()
		Return bmx_wxzipentry_isdir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets this entry to a dir.
	End Rem
	Method SetIsDir(dir:Int = True)
		bmx_wxzipentry_setisdir(wxObjectPtr, dir)
	End Method
	
	Rem
	bbdoc: Returns True if this entry is read only.
	End Rem
	Method IsReadOnly:Int()
		Return bmx_wxzipentry_isreadonly(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets this entry's read only status.
	End Rem
	Method SetIsReadOnly(readOnly:Int = True)
		bmx_wxzipentry_setisreadonly(wxObjectPtr, readOnly)
	End Method

End Type
