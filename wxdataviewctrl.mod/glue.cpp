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

#include "glue.h"

// ---------------------------------------------------------------------------------------



// *********************************************


MaxDataViewItem * bmx_wxdataviewctrl_getselection(wxDataViewCtrl * view) {
	return new MaxDataViewItem(view->GetSelection());
}


int bmx_wxdataviewctrl_geteventtype(int eventType) {

	switch (eventType) {
		case -361: return wxEVT_COMMAND_DATAVIEW_SELECTION_CHANGED;
		case -362: return wxEVT_COMMAND_DATAVIEW_ITEM_ACTIVATED;
		case -363: return wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSED;
		case -364: return wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDED;
		case -365: return wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSING;
		case -366: return wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDING;
		case -367: return wxEVT_COMMAND_DATAVIEW_ITEM_START_EDITING;
		case -368: return wxEVT_COMMAND_DATAVIEW_ITEM_EDITING_STARTED;
		case -369: return wxEVT_COMMAND_DATAVIEW_ITEM_EDITING_DONE;
		case -370: return wxEVT_COMMAND_DATAVIEW_ITEM_VALUE_CHANGED;
		case -371: return wxEVT_COMMAND_DATAVIEW_ITEM_CONTEXT_MENU;
		case -372: return wxEVT_COMMAND_DATAVIEW_COLUMN_HEADER_CLICK;
		case -373: return wxEVT_COMMAND_DATAVIEW_COLUMN_HEADER_RIGHT_CLICK;
		case -374: return wxEVT_COMMAND_DATAVIEW_COLUMN_SORTED;
		case -375: return wxEVT_COMMAND_DATAVIEW_COLUMN_REORDERED;
		case -376: return wxEVT_COMMAND_DATAVIEW_CACHE_HINT;
		case -377: return wxEVT_COMMAND_DATAVIEW_ITEM_BEGIN_DRAG;
		case -378: return wxEVT_COMMAND_DATAVIEW_ITEM_DROP_POSSIBLE;
		case -379: return wxEVT_COMMAND_DATAVIEW_ITEM_DROP;
	}

}

// *********************************************

MaxDataViewItem * bmx_wxdataviewevent_getitem(wxDataViewEvent & event) {
	return new MaxDataViewItem(event.GetItem());
}

