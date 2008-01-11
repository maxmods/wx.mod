/*
  Copyright (c) 2007,2008 Bruce A Henderson
 
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/ 

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxFileName::MaxFileName(const wxFileName& f)
{
	filename = f;
}

wxFileName & MaxFileName::Filename() {
	return filename;
}

// *********************************************

MaxFileName * bmx_wxfilename_create(BBString * path, BBString * name, wxPathFormat format) {
	return new MaxFileName(wxFileName(wxStringFromBBString(path), wxStringFromBBString(name), format));
}

void bmx_wxfilename_appenddir(MaxFileName * fname, BBString * dir) {
	fname->Filename().AppendDir(wxStringFromBBString(dir));
}

void bmx_wxfilename_assigncwd(MaxFileName * fname, BBString * volume) {
	fname->Filename().AssignCwd(wxStringFromBBString(volume));
}

void bmx_wxfilename_assigndir(MaxFileName * fname, BBString * dir, wxPathFormat format) {
	fname->Filename().AssignDir(wxStringFromBBString(dir), format);
}

void bmx_wxfilename_assignhomedir(MaxFileName * fname) {
	fname->Filename().AssignHomeDir();
}

void bmx_wxfilename_clear(MaxFileName * fname) {
	fname->Filename().Clear();
}

void bmx_wxfilename_clearext(MaxFileName * fname) {
	fname->Filename().ClearExt();
}

bool bmx_wxfilename_direxists(BBString * dir) {
	return wxFileName::DirExists(wxStringFromBBString(dir));
}

MaxFileName * bmx_wxfilename_dirname(BBString * dir, wxPathFormat format) {
	return new MaxFileName(wxFileName::DirName(wxStringFromBBString(dir), format));
}

bool bmx_wxfilename_fileexists(MaxFileName * fname) {
	return fname->Filename().FileExists();
}

bool bmx_wxfilename_ffileexists(BBString * filename) {
	return wxFileName::FileExists(wxStringFromBBString(filename));
}

MaxFileName * bmx_wxfilename_filename(BBString * file, wxPathFormat format) {
	return new MaxFileName(wxFileName::FileName(wxStringFromBBString(file), format));
}

BBString * bmx_wxfilename_getcwd(BBString * volume) {
	return bbStringFromWxString(wxFileName::GetCwd(wxStringFromBBString(volume)));
}

int bmx_wxfilename_getdircount(MaxFileName * fname) {
	return fname->Filename().GetDirCount();
}

BBArray * bmx_wxfilename_getdirs(MaxFileName * fname) {
	return wxArrayStringToBBStringArray(fname->Filename().GetDirs());
}

BBString * bmx_wxfilename_getext(MaxFileName * fname) {
	return bbStringFromWxString(fname->Filename().GetExt());
}

BBString * bmx_wxfilename_getforbiddenchars(wxPathFormat format) {
	return bbStringFromWxString(wxFileName::GetForbiddenChars(format));
}

wxPathFormat bmx_wxfilename_getformat(wxPathFormat format) {
	return wxFileName::GetFormat(format);
}

BBString * bmx_wxfilename_getfullname(MaxFileName * fname) {
	return bbStringFromWxString(fname->Filename().GetFullName());
}

BBString * bmx_wxfilename_getfullpath(MaxFileName * fname, wxPathFormat format) {
	return bbStringFromWxString(fname->Filename().GetFullPath(format));
}

BBString * bmx_wxfilename_gethomedir() {
	return bbStringFromWxString(wxFileName::GetHomeDir());
}

BBString * bmx_wxfilename_getlongpath(MaxFileName * fname) {
	return bbStringFromWxString(fname->Filename().GetLongPath());
}

time_t bmx_wxfilename_getmodificationtime(MaxFileName * fname) {
	wxDateTime t = fname->Filename().GetModificationTime();
	return t.GetTicks();
}

BBString * bmx_wxfilename_getname(MaxFileName * fname) {
	return bbStringFromWxString(fname->Filename().GetName());
}

BBString * bmx_wxfilename_getpath(MaxFileName * fname, int flags, wxPathFormat format) {
	return bbStringFromWxString(fname->Filename().GetPath(flags, format));
}

BBString * bmx_wxfilename_getpathseparator(wxPathFormat format) {
	return bbStringFromWxString(wxString(wxFileName::GetPathSeparator(format)));
}

BBString * bmx_wxfilename_getpathseparators(wxPathFormat format) {
	return bbStringFromWxString(wxFileName::GetPathSeparators(format));
}

BBString * bmx_wxfilename_getpathterminators(wxPathFormat format) {
	return bbStringFromWxString(wxFileName::GetPathTerminators(format));
}

BBString * bmx_wxfilename_getpathwithsep(MaxFileName * fname, wxPathFormat format) {
	return bbStringFromWxString(fname->Filename().GetPathWithSep(format));
}

BBString * bmx_wxfilename_getshortpath(MaxFileName * fname) {
	return bbStringFromWxString(fname->Filename().GetShortPath());
}

void bmx_wxfilename_getsize(MaxFileName * fname, BBInt64 * size) {
	*size = fname->Filename().GetSize().GetValue();
}

void bmx_wxfilename_fgetsize(BBString * filename, BBInt64 * size) {
	*size = wxFileName::GetSize(wxStringFromBBString(filename)).GetValue();
}

BBString * bmx_wxfilename_gethumanreadablesize(MaxFileName * fname, BBString * failmsg, int precision) {
	return bbStringFromWxString(fname->Filename().GetHumanReadableSize(wxStringFromBBString(failmsg), precision));
}

BBString * bmx_wxfilename_fgethumanreadablesize(BBInt64 size, BBString * failmsg, int precision) {
//	return bbStringFromWxString(
}

BBString * bmx_wxfilename_gettempdir() {
	return bbStringFromWxString(wxFileName::GetTempDir());
}

BBString * bmx_wxfilename_getvolume(MaxFileName * fname) {
	return bbStringFromWxString(fname->Filename().GetVolume());
}

BBString * bmx_wxfilename_getvolumeseparator(wxPathFormat format) {
	return bbStringFromWxString(wxFileName::GetVolumeSeparator(format));
}

bool bmx_wxfilename_hasext(MaxFileName * fname) {
	return fname->Filename().HasExt();
}

bool bmx_wxfilename_hasname(MaxFileName * fname) {
	return fname->Filename().HasName();
}

bool bmx_wxfilename_hasvolume(MaxFileName * fname) {
	return fname->Filename().HasVolume();
}

void bmx_wxfilename_insertdir(MaxFileName * fname, int before, BBString * dir) {
	fname->Filename().InsertDir(before, wxStringFromBBString(dir));
}

bool bmx_wxfilename_isabsolute(MaxFileName * fname, wxPathFormat format) {
	return fname->Filename().IsAbsolute(format);
}

bool bmx_wxfilename_iscasesensitive(wxPathFormat format) {
	return wxFileName::IsCaseSensitive(format);
}

bool bmx_wxfilename_isdirreadable(MaxFileName * fname) {
	return fname->Filename().IsDirReadable();
}

bool bmx_wxfilename_fisdirreadable(BBString * dir) {
	return wxFileName::IsDirReadable(wxStringFromBBString(dir));
}

bool bmx_wxfilename_isdirwritable(MaxFileName * fname) {
	return fname->Filename().IsDirWritable();
}

bool bmx_wxfilename_fisdirwritable(BBString * dir) {
	return wxFileName::IsDirWritable(wxStringFromBBString(dir));
}

bool bmx_wxfilename_isfileexecutable(MaxFileName * fname) {
	return fname->Filename().IsFileExecutable();
}

bool bmx_wxfilename_fisfileexecutable(BBString * file) {
	return wxFileName::IsFileExecutable(wxStringFromBBString(file));
}

bool bmx_wxfilename_isfilereadable(MaxFileName * fname) {
	return fname->Filename().IsFileReadable();
}

bool bmx_wxfilename_fisfilereadable(BBString * file) {
	return wxFileName::IsFileReadable(wxStringFromBBString(file));
}

bool bmx_wxfilename_isfilewritable(MaxFileName * fname) {
	return fname->Filename().IsFileWritable();
}

bool bmx_wxfilename_fisfilewritable(BBString * file) {
	return wxFileName::IsFileWritable(wxStringFromBBString(file));
}

bool bmx_wxfilename_isok(MaxFileName * fname) {
	return fname->Filename().IsOk();
}

bool bmx_wxfilename_ispathseparator(BBString * chr, wxPathFormat format) {
	return wxFileName::IsPathSeparator(wxStringFromBBString(chr).GetChar(0), format);
}

bool bmx_wxfilename_isrelative(MaxFileName * fname, wxPathFormat format) {
	return fname->Filename().IsRelative(format);
}

bool bmx_wxfilename_isdir(MaxFileName * fname) {
	return fname->Filename().IsDir();
}

#ifdef __APPLE__
bool bmx_wxfilename_macfinddefaulttypeandcreator(BBString * ext, wxUint32 * ftype, wxUint32 * creator) {
	return wxFileName::MacFindDefaultTypeAndCreator(wxStringFromBBString(ext), ftype, creator);
}

void bmx_wxfilename_macregisterdefaulttypeandcreator(BBString * ext, wxUint32 ftype, wxUint32 creator) {
	wxFileName::MacRegisterDefaultTypeAndCreator(wxStringFromBBString(ext), ftype, creator);
}

bool bmx_wxfilename_macsetdefaulttypeandcreator(MaxFileName * fname) {
	return fname->Filename().MacSetDefaultTypeAndCreator();
}
#endif

bool bmx_wxfilename_makeabsolute(MaxFileName * fname, BBString * cwd, wxPathFormat format) {
	return fname->Filename().MakeAbsolute(wxStringFromBBString(cwd), format);
}

bool bmx_wxfilename_makerelativeto(MaxFileName * fname, BBString * pathBase, wxPathFormat format) {
	return fname->Filename().MakeRelativeTo(wxStringFromBBString(pathBase), format);
}

bool bmx_wxfilename_mkdir(MaxFileName * fname, int perm, int flags) {
	return fname->Filename().Mkdir(perm, flags);
}

bool bmx_wxfilename_fmkdir(BBString * dir, int perm, int flags) {
	return wxFileName::Mkdir(wxStringFromBBString(dir), perm, flags);
}

bool bmx_wxfilename_normalize(MaxFileName * fname, int flags, BBString * cwd, wxPathFormat format) {
	return fname->Filename().Normalize(flags, wxStringFromBBString(cwd), format);
}

void bmx_wxfilename_prependdir(MaxFileName * fname, BBString * dir) {
	fname->Filename().PrependDir(wxStringFromBBString(dir));
}

void bmx_wxfilename_removedir(MaxFileName * fname, int pos) {
	fname->Filename().RemoveDir(pos);
}

void bmx_wxfilename_removelastdir(MaxFileName * fname) {
	fname->Filename().RemoveLastDir();
}

bool bmx_wxfilename_rmdir(MaxFileName * fname) {
	return fname->Filename().Rmdir();
}

bool bmx_wxfilename_frmdir(BBString * dir) {
	return wxFileName::Rmdir(wxStringFromBBString(dir));
}

bool bmx_wxfilename_sameas(MaxFileName * fname, MaxFileName * filename, wxPathFormat format) {
	return fname->Filename().SameAs(filename->Filename(), format);
}

bool bmx_wxfilename_setcwd(MaxFileName * fname) {
	return fname->Filename().SetCwd();
}

bool bmx_wxfilename_fsetcwd(BBString * dir) {
	return wxFileName::SetCwd(wxStringFromBBString(dir));
}

void bmx_wxfilename_setext(MaxFileName * fname, BBString * ext) {
	fname->Filename().SetExt(wxStringFromBBString(ext));
}

void bmx_wxfilename_setemptyext(MaxFileName * fname) {
	fname->Filename().SetEmptyExt();
}

void bmx_wxfilename_setfullname(MaxFileName * fname, BBString * name) {
	fname->Filename().SetFullName(wxStringFromBBString(name));
}

void bmx_wxfilename_setname(MaxFileName * fname, BBString * name) {
	fname->Filename().SetName(wxStringFromBBString(name));
}

void bmx_wxfilename_setvolume(MaxFileName * fname, BBString * volume) {
	fname->Filename().SetVolume(wxStringFromBBString(volume));
}

bool bmx_wxfilename_touch(MaxFileName * fname) {
	return fname->Filename().Touch();
}

void bmx_wxfilename_delete(MaxFileName * fname) {
	delete fname;
}


