/*
  Copyright (c) 2007 Bruce A Henderson
 
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

#include "wxglue.h"
#include "wx/treectrl.h"
#include "wx/imaglist.h"

class MaxTreeCtrl;
class MaxTreeItem;

extern "C" {

#include <blitz.h>

	MaxTreeCtrl * bmx_wxtreectrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	MaxTreeItem * bmx_wxtreectrl_addroot(MaxTreeCtrl * tree, BBString * text, int image, int selImage, wxTreeItemData * data);
	MaxTreeItem * bmx_wxtreectrl_appenditem(MaxTreeCtrl * tree, MaxTreeItem * parent, BBString * text, int image, int selImage, wxTreeItemData * data);
	void bmx_wxtreectrl_assignimagelist(MaxTreeCtrl * tree, wxImageList * list);
	void bmx_wxtreectrl_expand(MaxTreeCtrl * tree, MaxTreeItem * item);
	

	void bmx_maxtreeitem_delete(MaxTreeItem * item);
	int bmx_wxtreectrl_geteventtype(int type);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxTreeCtrl : public wxTreeCtrl
{
public:
	MaxTreeCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxTreeCtrl();
	
private:
	BBObject * maxHandle;

};

class MaxTreeItem
{
public :
	MaxTreeItem(wxTreeItemId treeItem);
	wxTreeItemId Item();

private :
	wxTreeItemId item;
};
