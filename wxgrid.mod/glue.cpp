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


int bmx_wxgrid_geteventtype(int type) {
	switch(type) {
		case 1580: return wxEVT_GRID_CELL_LEFT_CLICK;
		case 1581: return wxEVT_GRID_CELL_RIGHT_CLICK;
		case 1582: return wxEVT_GRID_CELL_LEFT_DCLICK;
		case 1583: return wxEVT_GRID_CELL_RIGHT_DCLICK;
		case 1584: return wxEVT_GRID_LABEL_LEFT_CLICK;
		case 1585: return wxEVT_GRID_LABEL_RIGHT_CLICK;
		case 1586: return wxEVT_GRID_LABEL_LEFT_DCLICK;
		case 1587: return wxEVT_GRID_LABEL_RIGHT_DCLICK;
		case 1588: return wxEVT_GRID_ROW_SIZE;
		case 1589: return wxEVT_GRID_COL_SIZE;
		case 1590: return wxEVT_GRID_RANGE_SELECT;
		case 1591: return wxEVT_GRID_CELL_CHANGE;
		case 1592: return wxEVT_GRID_SELECT_CELL;
		case 1593: return wxEVT_GRID_EDITOR_SHOWN;
		case 1594: return wxEVT_GRID_EDITOR_HIDDEN;
		case 1595: return wxEVT_GRID_EDITOR_CREATED;
		case 1596: return wxEVT_GRID_CELL_BEGIN_DRAG;
	}
	
	return 0;
}
