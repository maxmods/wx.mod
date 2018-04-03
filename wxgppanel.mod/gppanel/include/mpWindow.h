//-----------------------------------------------------------------------------
// mpWindow
//-----------------------------------------------------------------------------

#include "mpLayer.h"
#include "mpInfoLayer.h"

#define mpLN10 2.3025850929940456840179914546844

// Legend margins
#define mpLEGEND_MARGIN 5
#define mpLEGEND_LINEWIDTH 10

/** @name Constants defining mouse modes for mpWindow
@{*/

/** Mouse panning drags the view. Mouse mode for mpWindow. */
#define mpMOUSEMODE_DRAG    0
/** Mouse panning creates a zoom box. Mouse mode for mpWindow. */
#define mpMOUSEMODE_ZOOMBOX 1

/*@}*/
/** Define the type for the list of layers inside mpWindow */
//WX_DECLARE_HASH_MAP( int, mpLayer*, wxIntegerHash, wxIntegerEqual, wxLayerList );
typedef std::deque<mpLayer*> wxLayerList;

/** Canvas for plotting mpLayer implementations.

This class defines a zoomable and moveable 2D plot canvas. Any number
of mpLayer implementations (scale rulers, function plots, ...) can be
attached using mpWindow::AddLayer.

The canvas window provides a context menu with actions for navigating the view.
The context menu can be retrieved with mpWindow::GetPopupMenu, e.g. for extending it
externally.

Since wxMathPlot version 0.03, the mpWindow incorporate the following features:
- DoubleBuffering (Default=disabled): Can be set with EnableDoubleBuffer
- Mouse based pan/zoom (Default=enable): Can be set with EnableMousePanZoom.

The mouse commands can be visualized by the user through the popup menu, and are:
- Mouse Move+CTRL: Pan (Move)
- Mouse Wheel: Vertical scroll
- Mouse Wheel+SHIFT: Horizontal scroll
- Mouse Wheel UP+CTRL: Zoom in
- Mouse Wheel DOWN+CTRL: Zoom out

*/
class WXDLLIMPEXP_MATHPLOT mpWindow : public wxWindow
{
public:
	mpWindow();
	mpWindow(wxWindow *parent, wxWindowID id,
		const wxPoint &pos = wxDefaultPosition,
		const wxSize &size = wxDefaultSize,
		long flags = 0, const wxString& name = wxT("mathplot"));
	virtual ~mpWindow();

	//mínimo e máximo de Y no eixo para todos os gráficos.
	double getChartAxisMinY() { return m_minY; }
	double getChartAxisMaxY() { return m_maxY; }


	/** Init popup menu.
	@todo It might be possible to format the menu outside of class some how...
	*/
	void InitPopupMenu();

	/** Get reference to context menu of the plot canvas.
	@return Pointer to menu. The menu can be modified.
	*/
	wxMenu* GetPopupMenu() { return &m_popmenu; }

	/** Add a plot layer to the canvas.
	@param layer Pointer to layer. The mpLayer object will get under control of mpWindow,
	i.e. it will be delete'd on mpWindow destruction
	@param refreshDisplay States whether to refresh the display (UpdateAll) after adding the layer.
	@retval TRUE Success
	@retval FALSE Failure due to out of memory.
	*/
	bool AddLayer(mpLayer* layer, bool refreshDisplay = true);

	double getMinWLayersY();

	/** Remove a plot layer from the canvas.
	@param layer Pointer to layer. The mpLayer object will be destructed using delete.
	@param alsoDeleteObject If set to true, the mpLayer object will be also "deleted", not just removed from the internal list.
	@param refreshDisplay States whether to refresh the display (UpdateAll) after removing the layer.
	@return true if layer is deleted correctly

	N.B. Only the layer reference in the mpWindow is deleted, the layer object still exists!
	*/
	bool DelLayer(mpLayer* layer, bool alsoDeleteObject = false, bool refreshDisplay = true);

	/** Remove all layers from the plot.
	@param alsoDeleteObject If set to true, the mpLayer objects will be also "deleted", not just removed from the internal list.
	@param refreshDisplay States whether to refresh the display (UpdateAll) after removing the layers.
	*/
	void DelAllLayers(bool alsoDeleteObject, bool refreshDisplay = true);


	/*! Get the layer in list position indicated.
	N.B. You <i>must</i> know the index of the layer inside the list!
	@param position position of the layer in the layers list
	@return pointer to mpLayer
	*/
	mpLayer* GetLayer(int position);

	/*! Get the layer by its name (case sensitive).
	@param name The name of the layer to retrieve
	@return A pointer to the mpLayer object, or NULL if not found.
	*/
	mpLayer* GetLayer(const wxString &name);

	/**
	*   CHange drawing order of layer.
	*/
	void SetLayerPosition(mpLayer* layer, int position);
	void SetLayerBottom(mpLayer* layer);
	void SetLayerTop(mpLayer* layer);

	/** Get current view's X scale.
	See @ref mpLayer::Plot "rules for coordinate transformation"
	@return Scale
	*/
	double GetXscl() { return m_scaleX; }
	double GetScaleX(void) const { return m_scaleX; }; // Schaling's method: maybe another method esists with the same name

													   /** Get current view's Y scale.
													   See @ref mpLayer::Plot "rules for coordinate transformation"
													   @return Scale
													   */
	double GetYscl() const { return m_scaleY; }
	double GetScaleY(void) const { return m_scaleY; } // Schaling's method: maybe another method esists with the same name

													  /** Get current view's X position.
													  See @ref mpLayer::Plot "rules for coordinate transformation"
													  @return X Position in layer coordinate system, that corresponds to the center point of the view.
													  */
	double GetXpos() const { return m_posX; }
	double GetPosX(void) const { return m_posX; }

	/** Get current view's Y position.
	See @ref mpLayer::Plot "rules for coordinate transformation"
	@return Y Position in layer coordinate system, that corresponds to the center point of the view.
	*/
	double GetYpos() const { return m_posY; }
	double GetPosY(void) const { return m_posY; }

	/** Get current view's X dimension in device context units.
	Usually this is equal to wxDC::GetSize, but it might differ thus mpLayer
	implementations should rely on the value returned by the function.
	See @ref mpLayer::Plot "rules for coordinate transformation"
	@return X dimension.
	*/
	int GetScrX(void) const { return m_scrX; }
	int GetXScreen(void) const { return m_scrX; }

	/** Get current view's Y dimension in device context units.
	Usually this is equal to wxDC::GetSize, but it might differ thus mpLayer
	implementations should rely on the value returned by the function.
	See @ref mpLayer::Plot "rules for coordinate transformation"
	@return Y dimension.
	*/
	int GetScrY(void) const { return m_scrY; }
	int GetYScreen(void) const { return m_scrY; }

	/** Set current view's X scale and refresh display.
	@param scaleX New scale, must not be 0.
	*/
	void SetScaleX(double scaleX);

	/** Set current view's Y scale and refresh display.
	@param scaleY New scale, must not be 0.
	*/
	void SetScaleY(double scaleY) { if (scaleY != 0) m_scaleY = scaleY; UpdateAll(); }

	/** Set current view's X position and refresh display.
	@param posX New position that corresponds to the center point of the view.
	*/
	void SetPosX(double posX) { m_posX = posX; UpdateAll(); }

	/** Set current view's Y position and refresh display.
	@param posY New position that corresponds to the center point of the view.
	*/
	void SetPosY(double posY) { m_posY = posY; UpdateAll(); }

	/** Set current view's X and Y position and refresh display.
	@param posX New position that corresponds to the center point of the view.
	@param posY New position that corresponds to the center point of the view.
	*/
	void SetPos(double posX, double posY) { m_posX = posX; m_posY = posY; UpdateAll(); }

	/** Set current view's dimensions in device context units.
	Needed by plotting functions. It doesn't refresh display.
	@param scrX New position that corresponds to the center point of the view.
	@param scrY New position that corresponds to the center point of the view.
	*/
	void SetScr(int scrX, int scrY) { m_scrX = scrX; m_scrY = scrY; }

	/** Set mouse zoom mode
	*/
	void SetMouseZoomMode(mpMouseZoomType t) { m_mouseZoomMode = t; }

	/** Get mouse zoom mode
	*/
	mpMouseZoomType GetMouseZoomMode() { return m_mouseZoomMode; }

	/** Converts mpWindow (screen) pixel coordinates into graph (floating point) coordinates, using current mpWindow position and scale.
	* @sa p2y,x2p,y2p */
	//     double p2x(wxCoord pixelCoordX, bool drawOutside = true ); // { return m_posX + pixelCoordX/m_scaleX; }
	inline double p2x(wxCoord pixelCoordX) { return m_posX + pixelCoordX / m_scaleX; }

	/** Converts mpWindow (screen) pixel coordinates into graph (floating point) coordinates, using current mpWindow position and scale.
	* @sa p2x,x2p,y2p */
	//     double p2y(wxCoord pixelCoordY, bool drawOutside = true ); //{ return m_posY - pixelCoordY/m_scaleY; }
	inline double p2y(wxCoord pixelCoordY) { return m_posY - pixelCoordY / m_scaleY; }

	/** Converts graph (floating point) coordinates into mpWindow (screen) pixel coordinates, using current mpWindow position and scale.
	* @sa p2x,p2y,y2p */
	//     wxCoord x2p(double x, bool drawOutside = true); // { return (wxCoord) ( (x-m_posX) * m_scaleX); }
	inline wxCoord x2p(double x) { return (wxCoord)((x - m_posX) * m_scaleX); }

	/** Converts graph (floating point) coordinates into mpWindow (screen) pixel coordinates, using current mpWindow position and scale.
	* @sa p2x,p2y,x2p */
	//     wxCoord y2p(double y, bool drawOutside = true); // { return (wxCoord) ( (m_posY-y) * m_scaleY); }
	inline wxCoord y2p(double y) { return (wxCoord)((m_posY - y) * m_scaleY); }


	/** Enable/disable the double-buffering of the window, eliminating the flicker (default=disabled).
	*/
	void EnableDoubleBuffer(bool enabled) { m_enableDoubleBuffer = enabled; }

	/** Enable/disable the feature of pan/zoom with the mouse (default=enabled)
	*/
	void EnableMousePanZoom(bool enabled) { m_enableMouseNavigation = enabled; }
	/** Enable/disable the feature of popup with the mouse (default=enabled)
	*/
	void EnableMousePopup(bool enabled) { m_enableMousePopup = enabled; }

	/** Enable or disable X/Y scale aspect locking for the view.
	@note Explicit calls to mpWindow::SetScaleX and mpWindow::SetScaleY will set
	an unlocked aspect, but any other action changing the view scale will
	lock the aspect again.
	*/
	void LockAspect(bool enable = TRUE);

	void SetBoundLockMinY(bool lock) { m_lockBoundMinY = lock; }
	void SetBoundLockMaxY(bool lock) { m_lockBoundMaxY = lock; }
	void SetBoundLockMinX(bool lock) { m_lockBoundMinX = lock; }
	void SetBoundLockMaxX(bool lock) { m_lockBoundMaxX = lock; }

	/** Checks whether the X/Y scale aspect is locked.
	@retval TRUE Locked
	@retval FALSE Unlocked
	*/
	inline bool IsAspectLocked() { return m_lockaspect; }

	/** Set view to fit global bounding box of all plot layers and refresh display.
	Scale and position will be set to a show all attached mpLayers.
	The X/Y scale aspect lock is taken into account.
	*/
	void Fit();

	/** Set view to fit a given bounding box and refresh display.
	The X/Y scale aspect lock is taken into account.
	If provided, the parameters printSizeX and printSizeY are taken as the DC size, and the
	pixel scales are computed accordingly. Also, in this case the passed borders are not saved
	as the "desired borders", since this use will be invoked only when printing.
	*/
	void Fit(double xMin, double xMax, double yMin, double yMax, wxCoord *printSizeX = NULL, wxCoord *printSizeY = NULL);

	/** Zoom into current view and refresh display
	* @param centerPoint The point (pixel coordinates) that will stay in the same position on the screen after the zoom (by default, the center of the mpWindow).
	*/
	void ZoomIn(const wxPoint& centerPoint = wxDefaultPosition);

	/** Zoom out current view and refresh display
	* @param centerPoint The point (pixel coordinates) that will stay in the same position on the screen after the zoom (by default, the center of the mpWindow).
	*/
	void ZoomOut(const wxPoint& centerPoint = wxDefaultPosition);

	/** Zoom in current view along X and refresh display */
	void ZoomInX();
	/** Zoom out current view along X and refresh display */
	void ZoomOutX();
	/** Zoom in current view along Y and refresh display */
	void ZoomInY();
	/** Zoom out current view along Y and refresh display */
	void ZoomOutY();

	/** Zoom view fitting given coordinates to the window (p0 and p1 do not need to be in any specific order) */
	void ZoomRect(wxPoint p0, wxPoint p1);

	/** Refresh display */
	void UpdateAll();

	// Added methods by Davide Rondini

	/** Counts the number of plot layers, excluding axes or text: this is to count only the layers which have a bounding box.
	\return The number of profiles plotted.
	*/
	unsigned int CountLayers();

	/** Counts the number of plot layers, whether or not they have a bounding box.
	\return The number of layers in the mpWindow. */
	unsigned int CountAllLayers() { return m_layers.size(); };

	/** Draws the mpWindow on a page for printing
	\param print the mpPrintout where to print the graph */
	//void PrintGraph(mpPrintout *print);


	/** Returns the left-border layer coordinate that the user wants the mpWindow to show (it may be not exactly the actual shown coordinate in the case of locked aspect ratio).
	* @sa Fit
	*/
	double GetDesiredXmin() { return m_desiredXmin; }

	/** Returns the right-border  layer coordinate that the user wants the mpWindow to show (it may be not exactly the actual shown coordinate in the case of locked aspect ratio).
	* @sa Fit
	*/
	double GetDesiredXmax() { return m_desiredXmax; }

	/** Returns the bottom-border  layer coordinate that the user wants the mpWindow to show (it may be not exactly the actual shown coordinate in the case of locked aspect ratio).
	* @sa Fit
	*/
	double GetDesiredYmin() { return m_desiredYmin; }

	/** Returns the top layer-border  coordinate that the user wants the mpWindow to show (it may be not exactly the actual shown coordinate in the case of locked aspect ratio).
	* @sa Fit
	*/
	double GetDesiredYmax() { return m_desiredYmax; }

	/** Returns the bounding box coordinates
	@param bbox Pointer to a 6-element double array where to store bounding box coordinates. */
	void GetBoundingBox(double* bbox);

	/** Enable/disable scrollbars
	@param status Set to true to show scrollbars */
	void SetMPScrollbars(bool status);

	/** Get scrollbars status.
	@return true if scrollbars are visible */
	bool GetMPScrollbars() { return m_enableScrollBars; };

	/** Draw the window on a wxBitmap, then save it to a file.
	@param filename File name where to save the screenshot
	@param type image type to be saved: see wxImage output file types for flags
	@param imageSize Set a size for the output image. Default is the same as the screen size
	@param fit Decide whether to fit the plot into the size*/
	bool SaveScreenshot(const wxString& filename, wxBitmapType type = wxBITMAP_TYPE_BMP, wxSize imageSize = wxDefaultSize, bool fit = false);

	/** This value sets the zoom steps whenever the user clicks "Zoom in/out" or performs zoom with the mouse wheel.
	*  It must be a number above unity. This number is used for zoom in, and its inverse for zoom out. Set to 1.5 by default. */
	static double zoomIncrementalFactor;

	//void SetMaximumXZoomLevel(double level){ m_MaximumXZoomLevel = level; }

	/** Set window margins, creating a blank area where some kind of layers cannot draw. This is useful for example to draw axes outside the area where the plots are drawn.
	@param top Top border
	@param right Right border
	@param bottom Bottom border
	@param left Left border */
	void SetMargins(int top, int right, int bottom, int left);

	/** Set the top margin. @param top Top Margin */
	void SetMarginTop(int top) { m_marginTop = top; };
	/** Set the right margin. @param right Right Margin */
	void SetMarginRight(int right) { m_marginRight = right; };
	/** Set the bottom margin. @param bottom Bottom Margin */
	void SetMarginBottom(int bottom) { m_marginBottom = bottom; };
	/** Set the left margin. @param left Left Margin */
	void SetMarginLeft(int left) { m_marginLeft = left; };

	/** Get the top margin. @param top Top Margin */
	int GetMarginTop() { return m_marginTop; };
	/** Get the right margin. @param right Right Margin */
	int GetMarginRight() { return m_marginRight; };
	/** Get the bottom margin. @param bottom Bottom Margin */
	int GetMarginBottom() { return m_marginBottom; };
	/** Get the left margin. @param left Left Margin */
	int GetMarginLeft() { return m_marginLeft; };

	/** Enable / disable gradien backcolour */
	void SetGradienBackColour(bool b) { m_gradienBackColour = b; }
	/** Set gradien background initial colour */
	void SetGradienInitialColour(wxColour colour) { m_gradienInitialColour = colour; }
	/** Set gradien background destination colour */
	void SetGradienDestColour(wxColour colour) { m_gradienDestColour = colour; }
	/**
	*   Set gradien background direction
	* wxUP | wxLEFT | ?wxRIGHT | ?wxUP | ?wxDOWN | ?wxTOP | ?wxBOTTOM | ?wxNORTH | ?wxSOUTH | ?wxWEST | ?wxEAST | ?wxALL
	*/
	void SetGradienDirect(wxDirection direct) { m_gradienDirect = direct; }



	/** Sets whether to show coordinate tooltip when mouse passes over the plot. \param value true for enable, false for disable */
	// void EnableCoordTooltip(bool value = true);
	/** Gets coordinate tooltip status. \return true for enable, false for disable */
	// bool GetCoordTooltip() { return m_coordTooltip; };

	/** Check if a given point is inside the area of a mpInfoLayer and eventually returns its pointer.
	@param point The position to be checked
	@return If an info layer is found, returns its pointer, NULL otherwise */
	mpInfoLayer* IsInsideInfoLayer(wxPoint& point);

	mpPointLayer* IsInsidePointLayer(wxPoint& point);

	/** Sets the visibility of a layer by its name.
	@param name The layer name to set visibility
	@param viewable the view status to be set */
	void SetLayerVisible(const wxString &name, bool viewable);

	/** Check whether a layer with given name is visible
	@param name The layer name
	@return layer visibility status */
	bool IsLayerVisible(const wxString &name);

	/** Sets the visibility of a layer by its position in layer list.
	@param position The layer position in layer list
	@param viewable the view status to be set */
	void SetLayerVisible(const unsigned int position, bool viewable);

	/** Check whether the layer at given position is visible
	@param position The layer position in layer list
	@return layer visibility status */
	bool IsLayerVisible(const unsigned int position);
	/** Set Color theme. Provide colours to set a new colour theme.
	@param bgColour Background colour
	@param drawColour The colour used to draw all elements in foreground, axes excluded
	@param axesColour The colour used to draw axes (but not their labels) */
	void SetColourTheme(const wxColour& bgColour, const wxColour& drawColour, const wxColour& axesColour);

	/** Get axes draw colour
	@return reference to axis colour used in theme */
	const wxColour& GetAxesColour() { return m_axColour; };


	void SetHelpString(wxString msg, wxString title) { OnMouseHelpString = msg; OnMouseHelpStringTitle = title; }

protected:
	void OnPaint(wxPaintEvent     &event); //!< Paint handler, will plot all attached layers
	void OnSize(wxSizeEvent      &event); //!< Size handler, will update scroll bar sizes
										  // void OnScroll2       (wxScrollWinEvent &event); //!< Scroll handler, will move canvas

	void OnCenter(wxCommandEvent   &event); //!< Context menu handler
	void OnFit(wxCommandEvent   &event); //!< Context menu handler
	void OnZoomIn(wxCommandEvent   &event); //!< Context menu handler
	void OnZoomOut(wxCommandEvent   &event); //!< Context menu handler
	void OnLockAspect(wxCommandEvent   &event); //!< Context menu handler
	void OnMouseHelp(wxCommandEvent   &event); //!< Context menu handler
	void OnMouseWheel(wxMouseEvent     &event); //!< Mouse handler for the wheel
	void OnMouseMove(wxMouseEvent     &event); //!< Mouse handler for mouse motion (for pan)
	bool checkPoint(int mouseX, int mouseY, int centerX, int centerY, int r);
	void OnMouseLeftDown(wxMouseEvent     &event); //!< Mouse left click (for rect zoom)
	void OnMouseLeftRelease(wxMouseEvent  &event); //!< Mouse left click (for rect zoom)
	void OnMouseRightDown(wxMouseEvent     &event); //!< Mouse handler, for detecting when the user drags with the right button or just "clicks" for the menu
	void OnMouseRightRelease(wxMouseEvent  &event); //!< Mouse right up
	void OnMouseMiddleDown(wxMouseEvent     &event); //!< Mouse middle down
	void OnMouseMiddleRelease(wxMouseEvent  &event); //!< Mouse middle up
	void OnShowPopupMenu(wxMouseEvent     &event); //!< Mouse handler, will show context menu
	void OnMouseLeaveWindow(wxMouseEvent   &event); //!< Mouse leaves window

	void OnScrollThumbTrack(wxScrollWinEvent &event); //!< Scroll thumb on scroll bar moving
	void OnScrollPageUp(wxScrollWinEvent &event); //!< Scroll page up
	void OnScrollPageDown(wxScrollWinEvent &event); //!< Scroll page down
	void OnScrollLineUp(wxScrollWinEvent &event); //!< Scroll line up
	void OnScrollLineDown(wxScrollWinEvent &event); //!< Scroll line down
	void OnScrollTop(wxScrollWinEvent &event); //!< Scroll to top
	void OnScrollBottom(wxScrollWinEvent &event); //!< Scroll to bottom

	void DoScrollCalc(const int position, const int orientation);

	void DoZoomInXCalc(const int         staticXpixel);
	void DoZoomInYCalc(const int         staticYpixel);
	void DoZoomOutXCalc(const int         staticXpixel);
	void DoZoomOutYCalc(const int         staticYpixel);

	/** Recalculate global layer bounding box, and save it in m_minX,...
	* \return true if there is any valid BBox information.
	*/
	virtual bool UpdateBBox();

	//wxList m_layers;    //!< List of attached plot layers
	wxLayerList m_layers; //!< List of attached plot layers
	wxMenu m_popmenu;   //!< Canvas' context menu
	bool   m_lockaspect;//!< Scale aspect is locked or not

	bool   m_lockBoundMinY; //!< this lock Y min axis so user cannot move chart over this.
	bool   m_lockBoundMaxY; //!< this lock Y max axis so user cannot move chart over this.
	bool   m_lockBoundMinX; //!< this lock X min axis so user cannot move chart over this.
	bool   m_lockBoundMaxX; //!< this lock X max axis so user cannot move chart over this.


							// bool   m_coordTooltip; //!< Selects whether to show coordinate tooltip
	wxColour m_bgColour;	//!< Background Colour
	wxColour m_fgColour;	//!< Foreground Colour
	wxColour m_axColour;	//!< Axes Colour


	double m_minX;    //!< Global layer bounding box, left border incl.
	double m_maxX;      //!< Global layer bounding box, right border incl.
	double m_minY;     //!< Global layer bounding box, bottom border incl.
	double m_maxY;     //!< Global layer bounding box, top border incl.
	double m_scaleX;    //!< Current view's X scale
	double m_scaleY;    //!< Current view's Y scale

						/*double m_scaleXmin;    //!< X scale minimum value
						double m_scaleXmax;    //!< X scale maximum value
						double m_scaleYmin;    //!< Y scale minimum value
						double m_scaleYmax;    //!< Y scale maximum value
						bool   m_scaleBoundsEnable; //!< enable scale bounds*/

	double m_posX;      //!< Current view's X position
	double m_posY;      //!< Current view's Y position
	int    m_scrX;      //!< Current view's X dimension
	int    m_scrY;      //!< Current view's Y dimension
	int    m_clickedX;  //!< Last mouse click X position, for centering and zooming the view
	int    m_clickedY;  //!< Last mouse click Y position, for centering and zooming the view

						/** These are updated in Fit() only, and may be different from the real borders (layer coordinates) only if lock aspect ratio is true.
						*/
	double m_desiredXmin, m_desiredXmax, m_desiredYmin, m_desiredYmax;

	int m_marginTop, m_marginRight, m_marginBottom, m_marginLeft;

	int         m_last_lx, m_last_ly;   //!< For double buffering
	wxMemoryDC  m_buff_dc;             //!< For double buffering
	wxBitmap    *m_buff_bmp;            //!< For double buffering
	bool        m_enableDoubleBuffer;  //!< For double buffering
	bool        m_enableMouseNavigation;  //!< For pan/zoom with the mouse.
	bool        m_mouseDownHasHappened;     //!< For filtering mouse release event without having had a mouse down event.
	bool        m_enableMousePopup;         //!< For popup menu
	bool        m_mouseMovedAfterRightClick;
	bool        m_mouseMovedAfterMiddleClickWithCtrl;
	int         m_mousePosition_X, m_mousePosition_Y; //!< current mouse position
	int         m_mouseRClick_X, m_mouseRClick_Y; //!< For the right button "drag" feature
	int         m_mouseLClick_X, m_mouseLClick_Y; //!< Starting coords for rectangular zoom selection
	int         m_mouseMClick_X, m_mouseMClick_Y; //!< Starting coords for rectangular zoom selection
	bool        m_enableScrollBars;
	int         m_scrollX, m_scrollY;
	mpInfoLayer* m_movingInfoLayer;      //!< For moving info layers over the window area
	mpPointLayer* m_movingPointLayer;    //!< For moving point layers over the graph line

	mpMouseZoomType m_mouseZoomMode;        //!< Default mouse zoom works 2-dimensionsly x+y
											//double      m_MaximumXZoomLevel;         //!< Maximum zoom level.

	bool        m_gradienBackColour;
	wxColour    m_gradienInitialColour;
	wxColour    m_gradienDestColour;
	wxDirection m_gradienDirect;
	wxRect      *m_zoomingRect;
	bool        m_zoomingHorizontally;

	wxString    OnMouseHelpString;
	wxString    OnMouseHelpStringTitle;


	DECLARE_DYNAMIC_CLASS(mpWindow)
	DECLARE_EVENT_TABLE()
};