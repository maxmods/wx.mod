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

#include "glue.h"

// ---------------------------------------------------------------------------------------



// *********************************************


int bmx_wxlistctrl_geteventtype(int type) {
	switch(type) {
		case 700: return wxEVT_COMMAND_LIST_BEGIN_DRAG;
		case 701: return wxEVT_COMMAND_LIST_BEGIN_RDRAG;
		case 702: return wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT;
		case 703: return wxEVT_COMMAND_LIST_END_LABEL_EDIT;
		case 704: return wxEVT_COMMAND_LIST_DELETE_ITEM;
		case 705: return wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS;
		case 708: return wxEVT_COMMAND_LIST_ITEM_SELECTED;
		case 709: return wxEVT_COMMAND_LIST_ITEM_DESELECTED;
		case 710: return wxEVT_COMMAND_LIST_KEY_DOWN;
		case 711: return wxEVT_COMMAND_LIST_INSERT_ITEM;
		case 712: return wxEVT_COMMAND_LIST_COL_CLICK;
		case 713: return wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK;
		case 714: return wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK;
		case 715: return wxEVT_COMMAND_LIST_ITEM_ACTIVATED;
		case 716: return wxEVT_COMMAND_LIST_CACHE_HINT;
		case 717: return wxEVT_COMMAND_LIST_COL_RIGHT_CLICK;
		case 718: return wxEVT_COMMAND_LIST_COL_BEGIN_DRAG;
		case 719: return wxEVT_COMMAND_LIST_COL_DRAGGING;
		case 720: return wxEVT_COMMAND_LIST_COL_END_DRAG;
		case 721: return wxEVT_COMMAND_LIST_ITEM_FOCUSED;
	}
	
	return 0;
}
