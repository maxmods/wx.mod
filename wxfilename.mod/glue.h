/*
  Copyright (c) 2007-2015 Bruce A Henderson
 
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

#ifndef _WX_MAX_FILENAME_H_
#define _WX_MAX_FILENAME_H_

#include "wxglue.h"
#include "wx/filename.h"

class MaxFileName;

extern "C" {

#include <blitz.h>

	MaxFileName * bmx_wxfilename_create(BBString * path, BBString * name, wxPathFormat format);
	void bmx_wxfilename_appenddir(MaxFileName * fname, BBString * dir);
	void bmx_wxfilename_assigncwd(MaxFileName * fname, BBString * volume);
	void bmx_wxfilename_assigndir(MaxFileName * fname, BBString * dir, wxPathFormat format);
	void bmx_wxfilename_assignhomedir(MaxFileName * fname);
	void bmx_wxfilename_clear(MaxFileName * fname);
	void bmx_wxfilename_clearext(MaxFileName * fname);
	int bmx_wxfilename_direxists(BBString * dir);
	MaxFileName * bmx_wxfilename_dirname(BBString * dir, wxPathFormat format);
	int bmx_wxfilename_fileexists(MaxFileName * fname);
	int bmx_wxfilename_ffileexists(BBString * filename);
	MaxFileName * bmx_wxfilename_filename(BBString * file, wxPathFormat format);
	BBString * bmx_wxfilename_getcwd(BBString * volume);
	int bmx_wxfilename_getdircount(MaxFileName * fname);
	BBArray * bmx_wxfilename_getdirs(MaxFileName * fname);
	BBString * bmx_wxfilename_getext(MaxFileName * fname);
	BBString * bmx_wxfilename_getforbiddenchars(wxPathFormat format);
	wxPathFormat bmx_wxfilename_getformat(wxPathFormat format);
	BBString * bmx_wxfilename_getfullname(MaxFileName * fname);
	BBString * bmx_wxfilename_getfullpath(MaxFileName * fname, wxPathFormat format);
	BBString * bmx_wxfilename_gethomedir();
	BBString * bmx_wxfilename_getlongpath(MaxFileName * fname);
	time_t bmx_wxfilename_getmodificationtime(MaxFileName * fname);
	BBString * bmx_wxfilename_getname(MaxFileName * fname);
	BBString * bmx_wxfilename_getpath(MaxFileName * fname, int flags, wxPathFormat format);
	BBString * bmx_wxfilename_getpathseparator(wxPathFormat format);
	BBString * bmx_wxfilename_getpathseparators(wxPathFormat format);
	BBString * bmx_wxfilename_getpathterminators(wxPathFormat format);
	BBString * bmx_wxfilename_getpathwithsep(MaxFileName * fname, wxPathFormat format);
	BBString * bmx_wxfilename_getshortpath(MaxFileName * fname);
	void bmx_wxfilename_getsize(MaxFileName * fname, BBInt64 * size);
	void bmx_wxfilename_fgetsize(BBString * filename, BBInt64 * size);
	BBString * bmx_wxfilename_gethumanreadablesize(MaxFileName * fname, BBString * failmsg, int precision);
	BBString * bmx_wxfilename_fgethumanreadablesize(BBInt64 size, BBString * failmsg, int precision);
	BBString * bmx_wxfilename_gettempdir();
	BBString * bmx_wxfilename_getvolume(MaxFileName * fname);
	BBString * bmx_wxfilename_getvolumeseparator(wxPathFormat format);
	int bmx_wxfilename_hasext(MaxFileName * fname);
	int bmx_wxfilename_hasname(MaxFileName * fname);
	int bmx_wxfilename_hasvolume(MaxFileName * fname);
	void bmx_wxfilename_insertdir(MaxFileName * fname, int before, BBString * dir);
	int bmx_wxfilename_isabsolute(MaxFileName * fname, wxPathFormat format);
	int bmx_wxfilename_iscasesensitive(wxPathFormat format);
	int bmx_wxfilename_isdirreadable(MaxFileName * fname);
	int bmx_wxfilename_fisdirreadable(BBString * dir);
	int bmx_wxfilename_isdirwritable(MaxFileName * fname);
	int bmx_wxfilename_fisdirwritable(BBString * dir);
	int bmx_wxfilename_isfileexecutable(MaxFileName * fname);
	int bmx_wxfilename_fisfileexecutable(BBString * file);
	int bmx_wxfilename_isfilereadable(MaxFileName * fname);
	int bmx_wxfilename_fisfilereadable(BBString * file);
	int bmx_wxfilename_isfilewritable(MaxFileName * fname);
	int bmx_wxfilename_fisfilewritable(BBString * file);
	int bmx_wxfilename_isok(MaxFileName * fname);
	int bmx_wxfilename_ispathseparator(BBString * chr, wxPathFormat format);
	int bmx_wxfilename_isrelative(MaxFileName * fname, wxPathFormat format);
	int bmx_wxfilename_isdir(MaxFileName * fname);
	int bmx_wxfilename_makeabsolute(MaxFileName * fname, BBString * cwd, wxPathFormat format);
	int bmx_wxfilename_makerelativeto(MaxFileName * fname, BBString * pathBase, wxPathFormat format);
	int bmx_wxfilename_mkdir(MaxFileName * fname, int perm, int flags);
	int bmx_wxfilename_fmkdir(BBString * dir, int perm, int flags);
	int bmx_wxfilename_normalize(MaxFileName * fname, int flags, BBString * cwd, wxPathFormat format);
	void bmx_wxfilename_prependdir(MaxFileName * fname, BBString * dir);
	void bmx_wxfilename_removedir(MaxFileName * fname, int pos);
	void bmx_wxfilename_removelastdir(MaxFileName * fname);
	int bmx_wxfilename_rmdir(MaxFileName * fname);
	int bmx_wxfilename_frmdir(BBString * dir);
	int bmx_wxfilename_sameas(MaxFileName * fname, MaxFileName * filename, wxPathFormat format);
	int bmx_wxfilename_setcwd(MaxFileName * fname);
	int bmx_wxfilename_fsetcwd(BBString * dir);
	void bmx_wxfilename_setext(MaxFileName * fname, BBString * ext);
	void bmx_wxfilename_setemptyext(MaxFileName * fname);
	void bmx_wxfilename_setfullname(MaxFileName * fname, BBString * name);
	void bmx_wxfilename_setname(MaxFileName * fname, BBString * name);
	void bmx_wxfilename_setvolume(MaxFileName * fname, BBString * volume);
	int bmx_wxfilename_touch(MaxFileName * fname);
	void bmx_wxfilename_delete(MaxFileName * fname);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFileName
{
public:
	MaxFileName(const wxFileName & b);
	wxFileName & Filename();

private:
	wxFileName filename;

};

#endif // _WX_MAX_FILENAME_H_

