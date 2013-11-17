///////////////////////////////////////////////////////////////////////////////
// Name:        sheetsel.h
// Purpose:     wxSheetSelection
// Author:      John Labenski
// Modified by:
// Created:     20/02/2000
// Copyright:   (c) John Labenski, Stefan Neis
// Licence:     wxWidgets licence
///////////////////////////////////////////////////////////////////////////////

#ifndef __WX_SHEETSEL_H__
#define __WX_SHEETSEL_H__

#if defined(__GNUG__) && !defined(NO_GCC_PRAGMA)
    #pragma interface "sheetsel.h"
#endif

#include "wx/sheet/sheetdef.h"

// ----------------------------------------------------------------------------
// wxSheetCoords: location of a cell in the grid
// ----------------------------------------------------------------------------
class WXDLLIMPEXP_SHEET wxSheetCoords
{
public:
    inline wxSheetCoords() : m_row(0), m_col(0) {}
    inline wxSheetCoords( int row, int col ) : m_row(row), m_col(col) {}

    // default copy ctor is ok

    inline int  GetRow() const              { return m_row; }
    inline int  GetCol() const              { return m_col; }

    inline void SetRow( int row )           { m_row = row; }
    inline void SetCol( int col )           { m_col = col; }
    inline void Set( int row, int col )     { m_row = row; m_col = col; }

    inline wxSheetCoords& ShiftRow( int row )         { m_row += row; return *this; }
    inline wxSheetCoords& ShiftCol( int col )         { m_col += col; return *this; }
    inline wxSheetCoords& Shift( int rows, int cols ) { m_row += rows; m_col += cols; return *this; }
    inline void SwapRowCol()                          { int tmp = m_row; m_row = m_col; m_col = tmp; }

    // returns coords shifted by the # of rows and cols
    inline wxSheetCoords GetShifted( int rows, int cols ) const { return wxSheetCoords(m_row+rows, m_col+cols); }
    // return coords with row and col swapped
    inline wxSheetCoords GetSwapped() const { return wxSheetCoords(m_col, m_row); }

    // Get the type of coords as enum for use in a switch statement
    wxSheetCell_Type GetCellCoordsType() const;

    // Helper functions to determine what type of cell it is
    // They do not check the validity against a wxSheet
    inline bool IsGridCell() const        { return (m_row >=  0) && (m_col >=  0); }
    inline bool IsLabelCell() const       { return (m_row >= -1) && (m_col >= -1) &&
                                                  ((m_row == -1) || (m_col == -1)); }
    inline bool IsRowLabelCell() const    { return (m_row >=  0) && (m_col == -1); }
    inline bool IsColLabelCell() const    { return (m_row == -1) && (m_col >=  0); }
    inline bool IsCornerLabelCell() const { return (m_row == -1) && (m_col == -1); }

    // Convert this sheet coords to a row/col/corner label coords
    //  eg. for row labels : sheetCell(-1, 5) -> rowLabelCell(0, 5)
    inline wxSheetCoords SheetToRowLabel()    const { return wxSheetCoords(   m_row, -1-m_col); }
    inline wxSheetCoords SheetToColLabel()    const { return wxSheetCoords(-1-m_row,    m_col); }
    inline wxSheetCoords SheetToCornerLabel() const { return wxSheetCoords(-1-m_row, -1-m_col); }

    // Shift the cell if greater than row/col by numRows/numCols.
    //   if this row/col is < the update row/col do nothing, return false
    //   if this row/col is >= the update row/col + labs(num) then shift by num
    //   if this row/col is >= the update row/col && < row/col + labs(num)
    //      if num > 0 then shift it
    //      if num < 0 it should be deleted, but shift it to row/col - 1
    bool UpdateRows( size_t row, int numRows );
    bool UpdateCols( size_t col, int numCols );

    // operators
    inline wxSheetCoords& operator=(const wxSheetCoords& other) { m_row = other.m_row; m_col = other.m_col; return *this; }

    // arithmetic operations (component wise)
    inline wxSheetCoords operator+(const wxSheetCoords& c) const { return wxSheetCoords(m_row + c.m_row, m_col + c.m_col); }
    inline wxSheetCoords operator-(const wxSheetCoords& c) const { return wxSheetCoords(m_row - c.m_row, m_col - c.m_col); }

    inline wxSheetCoords& operator+=(const wxSheetCoords& c) { m_row += c.m_row; m_col += c.m_col; return *this; }
    inline wxSheetCoords& operator-=(const wxSheetCoords& c) { m_row -= c.m_row; m_col -= c.m_col; return *this; }

    inline bool operator == (const wxSheetCoords& other) const { return (m_row == other.m_row) && (m_col == other.m_col); }
    inline bool operator != (const wxSheetCoords& other) const { return !(*this == other); }
    // > and < operators use row for first comparison then col
    inline bool operator <  (const wxSheetCoords& other) const
        { return (m_row < other.m_row) || ((m_row == other.m_row) && (m_col < other.m_col)); }
    inline bool operator <= (const wxSheetCoords& other) const { return  (*this <  other) || (*this == other); }
    inline bool operator >  (const wxSheetCoords& other) const { return !(*this <= other); }
    inline bool operator >= (const wxSheetCoords& other) const { return !(*this <  other); }

    int m_row;
    int m_col;
};

// wxArraySheetCoords - a wxObjectArray of wxSheetCoords
WX_DECLARE_OBJARRAY_WITH_DECL(wxSheetCoords, wxArraySheetCoords, class WXDLLIMPEXP_SHEET);

// ----------------------------------------------------------------------------
// wxSheetBlock: a rectangular block of cells
// ----------------------------------------------------------------------------

// values of what blocks have been filled by functions wxSheetBlock::SideMatches() and Combine()
enum wxSheetBlockExtra_Type
{
    wxSHEET_BLOCK_NONE   = 0,       // no match
    wxSHEET_BLOCK_TOP    = 0x0001,  // top side or above
    wxSHEET_BLOCK_BOTTOM = 0x0002,  // bottom side or below
    wxSHEET_BLOCK_LEFT   = 0x0004,  // left side or to the left
    wxSHEET_BLOCK_RIGHT  = 0x0008,  // right side or to the right
    wxSHEET_BLOCK_ALL    = 0x0010   // top|bottom|left|right
};

class WXDLLIMPEXP_SHEET wxSheetBlock
{
public:
    inline wxSheetBlock() : m_row(0), m_col(0), m_height(0), m_width(0) {}
    inline wxSheetBlock(int row, int col, int height, int width)
        : m_row(row), m_col(col), m_height(height), m_width(width) {}
    // make a block from two corner coords, block will be upright if make_upright
    wxSheetBlock( const wxSheetCoords& topLeft,
                  const wxSheetCoords& bottomRight, bool make_upright = true );
    // make a block from the top left coords and a height and width
    inline wxSheetBlock( const wxSheetCoords& topLeft, int height, int width )
        : m_row(topLeft.m_row), m_col(topLeft.m_col), m_height(height), m_width(width) {}

    // Get the coord values of the block
    inline int GetLeft()   const { return m_col; }
    inline int GetRight()  const { return m_col + m_width - 1; }
    inline int GetTop()    const { return m_row; }
    inline int GetBottom() const { return m_row + m_height - 1; }
    inline int GetWidth()  const { return m_width; }
    inline int GetHeight() const { return m_height; }

    inline wxSheetCoords GetLeftTop()     const { return wxSheetCoords(m_row, m_col); }
    inline wxSheetCoords GetLeftBottom()  const { return wxSheetCoords(GetBottom(), m_col); }
    inline wxSheetCoords GetRightTop()    const { return wxSheetCoords(m_row, GetRight()); }
    inline wxSheetCoords GetRightBottom() const { return wxSheetCoords(GetBottom(), GetRight()); }

    inline wxSheetCoords GetSize() const { return wxSheetCoords(m_height, m_width); }

    // get an array of coords going left to right, top to bottom
    wxArraySheetCoords GetArrayCoords() const;

    // Set the coord values of the block

    // set the edges, the rest of the block stays in the same place
    inline void SetLeft( int left )     { m_width  += m_col  - left; m_col = left; }
    inline void SetTop( int top )       { m_height += m_row  - top;  m_row = top; }
    inline void SetRight( int right )   { m_width   = right  - m_col + 1; }
    inline void SetBottom( int bottom ) { m_height  = bottom - m_row + 1; }
    inline void SetWidth( int width )   { m_width   = width; }
    inline void SetHeight( int height ) { m_height  = height; }

    inline void SetLeftTop(const wxSheetCoords& lt)     { SetTop(lt.m_row);    SetLeft(lt.m_col); }
    inline void SetLeftBottom(const wxSheetCoords& lb)  { SetBottom(lb.m_row); SetLeft(lb.m_col); }
    inline void SetRightTop(const wxSheetCoords& rt)    { SetTop(rt.m_row);    SetRight(rt.m_col); }
    inline void SetRightBottom(const wxSheetCoords& rb) { SetBottom(rb.m_row); SetRight(rb.m_col); }

    // Set the coords keeping the rest of the block the same, block will shift
    inline void SetLeftCoord( int left )     { m_col = left; }
    inline void SetTopCoord( int top )       { m_row = top; }
    inline void SetRightCoord( int right )   { m_col = right - m_width + 1; }
    inline void SetBottomCoord( int bottom ) { m_row = bottom - m_height + 1; }

    inline void SetLeftTopCoords(const wxSheetCoords& lt)     { SetTopCoord(lt.m_row);    SetLeftCoord(lt.m_col); }
    inline void SetLeftBottomCoords(const wxSheetCoords& lb)  { SetBottomCoord(lb.m_row); SetLeftCoord(lb.m_col); }
    inline void SetRightTopCoords(const wxSheetCoords& rt)    { SetTopCoord(rt.m_row);    SetRightCoord(rt.m_col); }
    inline void SetRightBottomCoords(const wxSheetCoords& rb) { SetBottomCoord(rb.m_row); SetRightCoord(rb.m_col); }

    inline void Set( int row, int col, int height, int width )
        { m_row = row; m_col = col; m_height = height; m_width = width; }
    inline void SetCoords( int top, int left, int bottom, int right )
        { m_row=top; m_col=left; m_height=bottom-top+1; m_width=right-left+1; }
    inline void SetSize(const wxSheetCoords& size) { m_height = size.m_row; m_width = size.m_col; }

    // Get a block of this that is upright
    wxSheetBlock GetAligned() const;

    inline bool IsEmpty() const { return (m_width < 1) || (m_height < 1); }
    inline bool IsOneCell() const { return (m_width == 1) && (m_height == 1); }

    inline bool Contains( int row, int col ) const
        { return (row >= m_row) && (col >= m_col) &&
                 (row <= GetBottom()) && (col <= GetRight()); }
    inline bool Contains( const wxSheetCoords &coord ) const { return Contains(coord.m_row, coord.m_col); }
    inline bool Contains( const wxSheetBlock &b ) const
        { return !IsEmpty() && !b.IsEmpty() &&
                 (m_row <= b.m_row) && (m_col <= b.m_col) &&
                 (b.GetBottom() <= GetBottom()) && (b.GetRight() <= GetRight()); }

    // do these two blocks intersect (overlap) each other
    inline bool Intersects( const wxSheetBlock &b ) const
        { return !Intersect(b).IsEmpty(); }
                 //!IsEmpty() && !b.IsEmpty() &&
                 //(wxMax(m_col, b.m_col) <= wxMin(GetRight(),  b.GetRight())) &&
                 //(wxMax(m_row, b.m_row) <= wxMin(GetBottom(), b.GetBottom())); }
    // returns a block that is an intersection of these two blocks
    wxSheetBlock Intersect( const wxSheetBlock &other ) const;

    // union these two blocks
    wxSheetBlock Union( const wxSheetBlock &other ) const;

    // expands the union of the two, if one block is empty, return other
    wxSheetBlock ExpandUnion( const wxSheetBlock &other ) const;

    // Unlike Intersects this also includes just touching the other block
    inline bool Touches(const wxSheetBlock &block) const
        { return !IsEmpty() && !block.IsEmpty() &&
                 block.Intersects(wxSheetBlock(m_row-1, m_col-1, m_height+2, m_width+2)); }

    // returns a mix of enum wxSheetBlockExtra_Type of what sides of the two
    // blocks are matched
    inline int SideMatches(const wxSheetBlock& block) const
    {
        return (m_row       == block.m_row       ? wxSHEET_BLOCK_TOP    : 0) |
               (m_col       == block.m_col       ? wxSHEET_BLOCK_LEFT   : 0) |
               (GetBottom() == block.GetBottom() ? wxSHEET_BLOCK_BOTTOM : 0) |
               (GetRight()  == block.GetRight()  ? wxSHEET_BLOCK_RIGHT  : 0);
    }

    // Try to combine these blocks, they must touch and fit to make a single larger block
    //    this block is expanded if possible, returns success
    bool Combine(const wxSheetBlock &block);

    // test combining the input block with this one, returning the
    // remainder of block in top, bottom, left, right - each may be IsEmpty()
    // returns enum wxSheetBlockExtra_Type Or'ed together specifying which
    // blocks have been filled or all of the block may be combined
    // returns wxSHEET_BLOCK_NONE if blocks don't touch
    // returns wxSHEET_BLOCK_ALL if this already contains block
    // |---------------------------|
    // |           top             |
    // |---------------------------|
    // |   left  |block|  right    |
    // |---------------------------|
    // |          bottom           |
    // |---------------------------|

    int Combine( const wxSheetBlock &block,
                  wxSheetBlock &top, wxSheetBlock &bottom,
                  wxSheetBlock &left, wxSheetBlock &right ) const;

    // test removal of a portion or all of this contained in block returning the
    // remainder of this in top, bottom, left, right - each may be IsEmpty()
    // returns wxSHEET_BLOCK_NONE if nothing to delete, this cell is not changed
    int Delete( const wxSheetBlock &block,
                 wxSheetBlock &top,  wxSheetBlock &bottom,
                 wxSheetBlock &left, wxSheetBlock &right ) const;

    // shift the block if greater than row/col by numRows/numCols or empty it
    //  if it's inside the deletion
    bool UpdateRows( size_t row, int numRows );
    bool UpdateCols( size_t col, int numCols );

    // operators
    inline bool operator == (const wxSheetBlock& b) const
        { return (m_row == b.m_row) && (m_height == b.m_height) &&
                 (m_col == b.m_col) && (m_width  == b.m_width); }
    inline bool operator != (const wxSheetBlock& b) const { return !(*this == b); }

    // returns -1 if this block is more to the top or equal row and more to left,
    //   0 is equal, 1 if lower and to right
    int CmpTopLeft(const wxSheetBlock& b) const;
    // returns -1 if this block is below or equal row and more to the right,
    //    0 is equal, 1 if to the left and higher
    int CmpBottomRight(const wxSheetBlock& b) const;

    // goes top left to bottom right and then by height and width (allows sorting)
    inline bool operator <  (const wxSheetBlock& b) const
    {
        if (m_row    < b.m_row)    return true; else if (m_row    > b.m_row)    return false;
        if (m_col    < b.m_col)    return true; else if (m_col    > b.m_col)    return false;
        if (m_height < b.m_height) return true; else if (m_height > b.m_height) return false;
        if (m_width  < b.m_width)  return true; //else if (m_width > b.m_width) return false;
        return false;
    }
    inline bool operator <= (const wxSheetBlock& other) const { return  (*this == other) || (*this < other); }
    inline bool operator >  (const wxSheetBlock& other) const { return !(*this <= other); }
    inline bool operator >= (const wxSheetBlock& other) const { return !(*this <  other); }

protected:
    int m_row, m_col, m_height, m_width;
};

// For comparisons...
WXDLLIMPEXP_DATA_SHEET(extern const wxSheetCoords) wxNullSheetCoords;        // (-2, -2)
WXDLLIMPEXP_DATA_SHEET(extern const wxSheetCoords) wxGridCellSheetCoords;    // ( 0,  0)
WXDLLIMPEXP_DATA_SHEET(extern const wxSheetCoords) wxRowLabelSheetCoords;    // ( 0, -1)
WXDLLIMPEXP_DATA_SHEET(extern const wxSheetCoords) wxColLabelSheetCoords;    // (-1,  0)
WXDLLIMPEXP_DATA_SHEET(extern const wxSheetCoords) wxCornerLabelSheetCoords; // (-1, -1)

WXDLLIMPEXP_DATA_SHEET(extern const wxSheetBlock)  wxNullSheetBlock;  // (0, 0, 0, 0)

// wxArraySheetBlock - a wxObjectArray of wxSheetBlocks
WX_DECLARE_OBJARRAY_WITH_DECL(wxSheetBlock, wxArraySheetBlock, class WXDLLIMPEXP_SHEET);

// ----------------------------------------------------------------------------
// wxSheetSelection
// ----------------------------------------------------------------------------

enum wxSheetSelection_Type
{
    wxSHEET_SELECTION_NONE = 0,
    // allow multiple selections to occur, this will cause the
    //    wxSheetSelection::Index to return the first occurance of possibly many
    //    Minimize will not be called.
    wxSHEET_SELECTION_MULTIPLE_SEL = 0x0001
};

class WXDLLIMPEXP_SHEET wxSheetSelection : public wxObject
{
public:
    wxSheetSelection( int options = wxSHEET_SELECTION_NONE );
    wxSheetSelection( const wxSheetSelection& other );
    wxSheetSelection( const wxSheetBlock& block,
                      int options = wxSHEET_SELECTION_NONE );

    // Make a full copy of the source
    void Copy(const wxSheetSelection &source);

    // Get the number of rows and cols
    inline int GetNumberRows() const { return m_numRows; }
    inline int GetNumberCols() const { return m_numCols; }

    // Options are enum wxSheetSelection_Type
    inline int GetOptions() const       { return m_options; }
    inline void SetOptions(int options) { m_options = options; }

    // Is there any selection at all
    inline bool HasSelection() const { return m_blocks.GetCount() != 0; }
    // Get the number of different selections
    inline size_t GetCount() const   { return m_blocks.GetCount(); }
    // Has the selection been minimized, always is unless calling
    //   SelectBlock(... combine_now = false ...)
    inline bool IsMinimzed() const   { return m_minimized; }

    // Clear the selection array and memory
    bool Clear();
    // Empty the selection array preserve mem alloc to array
    bool Empty();

    // Get the array of selected blocks
    inline const wxArraySheetBlock& GetBlockArray() const { return m_blocks; }

    // Get a single block at this index
    const wxSheetBlock& GetBlock( size_t index ) const;
    inline const wxSheetBlock& Item( size_t index ) const { return GetBlock(index); }

    // Get a block that bounds the selection
    inline const wxSheetBlock& GetBoundingBlock() const { return m_bounds; }
    // Set the outer bounds of the current selection
    //   trims or removes currently selected blocks outside of bounding block
    void SetBoundingBlock(const wxSheetBlock& block);

    // do any of the blocks contain the elements
    inline bool Contains( int row, int col ) const { return Index(row,col) != wxNOT_FOUND; }
    inline bool Contains( const wxSheetCoords &c ) const { return Contains(c.GetRow(), c.GetCol()); }
    bool Contains( const wxSheetBlock &b ) const;

    // Get the index of a block that fully contains element or wxNOT_FOUND
    int Index( int row, int col ) const;
    inline int Index( const wxSheetCoords &c ) const { return Index(c.GetRow(), c.GetCol()); }
    int Index( const wxSheetBlock &b ) const;
    // Get the first index of the block that intersects input block or wxNOT_FOUND
    int IndexIntersects( const wxSheetBlock &b ) const;

    // Add the block to the selection, returns false if nothing was done
    //   use combine_now=false to make quick additions, when done call Minimize()
    //   addedBlocks (if !NULL) will be filled with the actual changed selections
    //   by removing the previous selections from the input block
    bool SelectBlock( const wxSheetBlock &block, bool combine_now = true,
                      wxArraySheetBlock *addedBlocks = NULL );

    // Remove the block to the selection, return false if nothing was done
    //   use combine_now=false to make quick additions, when done call Minimize()
    //   deletedBlocks (if !NULL) contains the input block, FIXME
    //    [it should contain only the parts of the input block that were
    //     deleted in the selection, but the speed would greatly suffer,
    //     unlike SelectBlock which uses an array in the selection process]
    bool DeselectBlock( const wxSheetBlock &block, bool combine_now = true,
                        wxArraySheetBlock *deletedBlocks = NULL );

    // Update the number of rows/cols. In numRows/Cols > 0 insert them else
    //  remove them.
    bool UpdateRows( size_t row, int numRows );
    bool UpdateCols( size_t col, int numCols );

    // Operators
    inline wxSheetBlock operator[](size_t index) const { return GetBlock(index); }
    inline wxSheetSelection& operator = (const wxSheetSelection& other) { Copy(other); return *this; }

    // implementation

    // Find where to insert this block
    int IndexForInsert(const wxSheetBlock& block) const;
    // Find the index in the array that starts at this row
    // returns -1 for empty array or start index
    int FindTopRow(int row) const;

    // Combine the blocks if possible and Sort() them, returns if any were combined
    //   only need to call this if you've called (De)SelectBlock(block, false)
    bool Minimize();

protected:
    // Calls DoDoMinimize on array until it returns false
    bool DoMinimize( wxArraySheetBlock &blocks ) const;
    // DoMinimize calls this internally so that it doesn't recurse
    //   generic routine using if (b1.Combine(b2)) remove b2 to cleanup array
    bool DoDoMinimize( wxArraySheetBlock &blocks ) const;

    int  InsertBlock(const wxSheetBlock& block);
    void CalculateBounds();

    wxArraySheetBlock m_blocks;
    wxSheetBlock      m_bounds;
    int  m_numRows, m_numCols;
    bool m_minimized;
    int  m_options;
private:
    void Init();
    DECLARE_ABSTRACT_CLASS(wxSheetSelection);
};

// ----------------------------------------------------------------------------
// wxSheetSelectionIterator - iterates through a wxSheetSelection cell by cell
// ----------------------------------------------------------------------------

enum wxSheetSelectionIter_Type
{
    wxSHEET_SELITER_FORWARD = 0, // iterate left to right by cols and then down by rows
    wxSHEET_SELITER_REVERSE,     // iterate bottom to top by rows and then left by cols
};

enum wxSheetSelectionIterGet_Type
{
    wxSHEET_SELITER_GET_END         = 0,
    wxSHEET_SELITER_GET_LEFTTOP     = 0x0001,
    wxSHEET_SELITER_GET_RIGHTBOTTOM = 0x0002,
    wxSHEET_SELITER_GET_NEXTROW     = 0x0004,
    wxSHEET_SELITER_GET_NEXTCOL     = 0x0008
};

class WXDLLIMPEXP_SHEET wxSheetSelectionIterator
{
public :
    wxSheetSelectionIterator( const wxSheetSelection &sel,
                              wxSheetSelectionIter_Type type = wxSHEET_SELITER_FORWARD );
    wxSheetSelectionIterator( const wxArraySheetBlock &blocks,
                              wxSheetSelectionIter_Type type = wxSHEET_SELITER_FORWARD );

    // resets the iterating to start at the beginning or end depending on type
    void Reset(wxSheetSelectionIter_Type type);
    // What direction are we iterating in
    inline wxSheetSelectionIter_Type GetIterType() const { return m_type; }

    // Get next cell in the selection, returns wxSheetSelectionIterGet_Type, 0 at end
    wxSheetSelectionIterGet_Type GetNext(wxSheetCoords &coords);

    // checks if this row and col are in this selection
    inline bool IsInSelection(const wxSheetCoords &c) const { return IsInSelection(c.m_row, c.m_col); }
    bool IsInSelection( int row, int col ) const;

protected :
    wxSheetSelectionIterGet_Type GetNextForward(wxSheetCoords &coords);
    wxSheetSelectionIterGet_Type GetNextReverse(wxSheetCoords &coords);

    int m_block_index;
    wxSheetSelectionIter_Type m_type;
    wxSheetCoords m_coords;
    wxArraySheetBlock m_blocks;
};

#endif  // __WXSHEETSEL_H__
