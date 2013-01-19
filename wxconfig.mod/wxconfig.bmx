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
bbdoc: wxConfig
End Rem
Module wx.wxConfig

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
bbdoc: wxConfigBase type defines the basic interface of all config classes.
about: It can not be used by itself (it is an abstract base type) and you will always use one
of its derivations: wxFileConfig, wxRegConfig or any other.
End Rem
Type wxConfigBase

	Field wxObjectPtr:Byte Ptr
	
	Function _create:wxConfigBase(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxConfigBase = New wxConfigBase
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Sets the config object as the current one, returns the previous current object (both the parameter and returned value may be NULL)
	End Rem
	Function Set:wxConfigBase(config:wxConfigBase)
		If config Then
			Return wxConfigBase._create(bmx_wxconfigbase_set(config.wxObjectPtr))
		Else
			Return wxConfigBase._create(bmx_wxconfigbase_set(Null))
		End If
	End Function
	
	Rem
	bbdoc: Get the current config object.
	End Rem
	Function Get:wxConfigBase(onDemand:Int = True)
		Return wxConfigBase._create(bmx_wxconfigbase_get(onDemand))
	End Function
	
	Rem
	bbdoc: Calling this method will prevent Get() from automatically creating a new config object if the current one is NULL.
	about: It might be useful to call it near the program end to prevent "accidental" creation
	of a new config object.
	End Rem
	Method DontCreateOnDemand()
		bmx_wxconfigbase_dontcreateondemand(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Delete the whole underlying object (disk file, registry key, ...).
	about: Primarly for use by uninstallation routine.
	End Rem
	Method DeleteAll:Int()
		Return bmx_wxconfigbase_deleteall(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Deletes the specified entry and the group it belongs to if it was the last key in it and the second parameter is true.
	End Rem
	Method DeleteEntry:Int(key:String, deleteGroupIfEmpty:Int = True)
		Return bmx_wxconfigbase_deleteentry(wxObjectPtr, key, deleteGroupIfEmpty)
	End Method
	
	Rem
	bbdoc: Delete the group (with all subgroups).
	about: If the current path is under the group being deleted it is changed to its deepest
	still existing component. E.g. if the current path is /A/B/C/D and the group C is deleted
	the path becomes /A/B.
	End Rem
	Method DeleteGroup:Int(key:String)
		Return bmx_wxconfigbase_deletegroup(wxObjectPtr, key)
	End Method
	
	Rem
	bbdoc: Returns true if either a group or an entry with a given name exists
	End Rem
	Method Exists:Int(name:String)
		Return bmx_wxconfigbase_exists(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Permanently writes all changes (otherwise, they're only written from object's destructor)
	End Rem
	Method Flush:Int(currentOnly:Int = False)
		Return bmx_wxconfigbase_flush(wxObjectPtr, currentOnly)
	End Method
	
	Rem
	bbdoc: Returns the application name.
	End Rem
	Method GetAppName:String()
		Return bmx_wxconfigbase_getappname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the type of the given entry or Unknown if the entry doesn't exist.
	about: This method should be used to decide which version of Read() should be used because
	some of wxConfig implementations will complain about type mismatch otherwise: e.g., an attempt
	to read a string value from an integer key with wxRegConfig will fail.
	<p>
	The result can be one of:
	Type_Unknown, Type_String, Type_Boolean, Type_Integer or Type_Float.
	</p>
	End Rem
	Method GetEntryType:Int(name:String)
		Return bmx_wxconfigbase_getentrytype(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Gets the first group.
	End Rem
	Method GetFirstGroup:String(index:Int Var, cont:Int Var)
		Return bmx_wxconfigbase_getfirstgroup(wxObjectPtr, Varptr index, Varptr cont)
	End Method
	
	Rem
	bbdoc: Gets the first entry.
	End Rem
	Method GetFirstEntry:Int(name:String, index:Int Var)
		Return bmx_wxconfigbase_getfirstentry(wxObjectPtr, name, Varptr index)
	End Method
	
	Rem
	bbdoc: Gets the next group.
	End Rem
	Method GetNextGroup:String(index:Int Var, cont:Int Var)
		Return bmx_wxconfigbase_getnextgroup(wxObjectPtr, Varptr index, Varptr cont)
	End Method
	
	Rem
	bbdoc: Gets the next entry.
	End Rem
	Method GetNextEntry:Int(name:String, index:Int Var)
		Return bmx_wxconfigbase_getnextentry(wxObjectPtr, name, Varptr index)
	End Method
	
	Rem
	bbdoc: Gets the number of entries.
	End Rem
	Method GetNumberOfEntries:Int(recursive:Int = False)
		Return bmx_wxconfigbase_getnumberofentries(wxObjectPtr, recursive)
	End Method
	
	Rem
	bbdoc: Get number of entries/subgroups in the current group, with or without its subgroups.
	End Rem
	Method GetNumberOfGroups:Int(recursive:Int = False)
		Return bmx_wxconfigbase_getnumberofgroups(wxObjectPtr, recursive)
	End Method
	
	Rem
	bbdoc: Retrieve the current path (always as absolute path).
	End Rem
	Method GetPath:String()
		Return bmx_wxconfigbase_getpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the vendor name.
	End Rem
	Method GetVendorName:String()
		Return bmx_wxconfigbase_getvendorname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the entry by this name exists
	End Rem
	Method HasEntry:Int(name:String)
		Return bmx_wxconfigbase_hasentry(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Returns true if the group by this name exists
	End Rem
	Method HasGroup:Int(name:String)
		Return bmx_wxconfigbase_hasgroup(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Returns true if we are expanding environment variables in key values.
	End Rem
	Method IsExpandingEnvVars:Int()
		Return bmx_wxconfigbase_isexpandingenvvars(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if we are writing defaults back to the config file.
	End Rem
	Method IsRecordingDefaults:Int()
		Return bmx_wxconfigbase_isrecordingdefaults(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Read a string from the key.
	about: The default value is returned if the key was not found.
	End Rem
	Method ReadString:String(key:String, defaultValue:String)
		Return bmx_wxconfigbase_readstring(wxObjectPtr, key, defaultValue)
	End Method
	
	Rem
	bbdoc: Read an int from the key.
	about: The default value is returned if the key was not found.
	End Rem
	Method ReadInt:Int(key:String, defaultValue:Int)
		Return bmx_wxconfigbase_readint(wxObjectPtr, key, defaultValue)
	End Method
	
	Rem
	bbdoc: Read a bool from the key.
	about: The default value is returned if the key was not found.
	End Rem
	Method ReadBool:Int(key:String, defaultValue:Int)
		Return bmx_wxconfigbase_readbool(wxObjectPtr, key, defaultValue)
	End Method
	
	Rem
	bbdoc: Read a double from the key.
	about: The default value is returned if the key was not found.
	End Rem
	Method ReadDouble:Double(key:String, defaultValue:Double)
		Return bmx_wxconfigbase_readdouble(wxObjectPtr, key, defaultValue)
	End Method
	
	Rem
	bbdoc: Renames an entry in the current group.
	returns: False if oldName doesn't exist or if newName already exists.
	about: The entries names (both the old and the new one) shouldn't contain backslashes,
	i.e. only simple names and not arbitrary paths are accepted by this method.
	End Rem
	Method RenameEntry:Int(oldName:String, newName:String)
		Return bmx_wxconfigbase_renameentry(wxObjectPtr, oldName, newName)
	End Method
	
	Rem
	bbdoc: Renames a subgroup of the current group.
	returns: False if oldName doesn't exist or if newName already exists.
	about: The subgroup names (both the old and the new one) shouldn't contain backslashes,
	i.e. only simple names and not arbitrary paths are accepted by this method.
	End Rem
	Method RenameGroup:Int(oldName:String, newName:String)
		Return bmx_wxconfigbase_renamegroup(wxObjectPtr, oldName, newName)
	End Method
	
	Rem
	bbdoc: Determine whether we wish to expand environment variables in key values.
	End Rem
	Method SetExpandEnvVars(doIt:Int = True)
		bmx_wxconfigbase_setexpandenvvars(wxObjectPtr, doIt)
	End Method
	
	Rem
	bbdoc: Set current path
	about: If the first character is '/', it is the absolute path, otherwise it is a relative
	path. '..' is supported. If strPath doesn't exist it is created.
	End Rem
	Method SetPath(path:String)
		bmx_wxconfigbase_setpath(wxObjectPtr, path)
	End Method
	
	Rem
	bbdoc: Sets whether defaults are recorded to the config file whenever an attempt to read the value which is not present in it is done.
	about: If on (default is off) all default values for the settings used by the program are
	written back to the config file. This allows the user to see what config options may be
	changed and is probably useful only for wxFileConfig.
	End Rem
	Method SetRecordDefaults(doIt:Int = True)
		bmx_wxconfigbase_setrecorddefaults(wxObjectPtr, doIt)
	End Method
	
	Rem
	bbdoc: Writes the specified value to the config and return true on success.
	End Rem
	Method WriteString:Int(key:String, value:String)
		Return bmx_wxconfigbase_writestring(wxObjectPtr, key, value)
	End Method
	
	Rem
	bbdoc: Writes the specified value to the config and return true on success.
	End Rem
	Method WriteInt:Int(key:String, value:Int)
		Return bmx_wxconfigbase_writeint(wxObjectPtr, key, value)
	End Method
	
	Rem
	bbdoc: Writes the specified value to the config and return true on success.
	End Rem
	Method WriteBool:Int(key:String, value:Int)
		Return bmx_wxconfigbase_writebool(wxObjectPtr, key, value)
	End Method
	
	Rem
	bbdoc: Writes the specified value to the config and return true on success.
	End Rem
	Method WriteDouble:Int(key:String, value:Double)
		Return bmx_wxconfigbase_writedouble(wxObjectPtr, key, value)
	End Method

	Rem
	bbdoc: Free the config, automatically storing the information.
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxconfigbase_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type


