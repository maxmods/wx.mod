#ifndef _MP_POINTLAYER_H_
#define _MP_POINTLAYER_H_

#include "mpLayer.h"


class WXDLLIMPEXP_MATHPLOT mpPointLayer : public mpLayer
{
public:
	/** Default constructor. */
	mpPointLayer() {}
	mpPointLayer(mpLayer *parent);
	/**
	Complete constructor.
	@param mpLayer    	Layer pointer of point
	@param layerName	Layer name
	@param brush 		pointer to a fill brush. Default is transparent
	@param wxWindow		parent window because wan't know where event will be send
	@param int			event type, default
	@param long			event unique id
	*/
	mpPointLayer(mpLayer         *mplayer,
		wxString        layerName = wxT("P"),
		const wxBrush   *brush = wxTRANSPARENT_BRUSH,
		wxWindow        *wxparent = NULL,
		long int        eventid = wxNewId()
	);
	/** Destructor */
	virtual ~mpPointLayer();


	virtual bool   HasBBox() { return FALSE; }
	/** Specifies that this is an Info box layer.
	@return true if modify is enabled
	@sa mpLayer::IsPointEnabled */
	bool IsPointModifiable() { return m_EnableModify; }
	bool IsDraggingOnlyFromPoint() { return m_DragOnlyPoint; }
	/** Check if point is defined */
	bool IsPointDefined() { return m_defined; }
	/** If parent is defined becouse of events
	*  function return event ID for Connect() */
	int  GetEventId() { return eventId; }
	/** Specifies that this is an point layer.
	@return always \a TRUE
	@sa mpLayer::IsPointLayer */
	virtual bool IsPointLayer() { return true; }

	/** Updates point. Shold be overidden by derived classes.
	@param w parent mpWindow from which to obtain information
	@param event The event which called the update. */
	virtual void UpdatePoint(mpWindow& w, wxEvent& event);
	/** Update mouse coordinates
	@param w parent mpWindow from which to obtain information
	@param event The event which called the update. */
	virtual void UpdateMouseCoord(mpWindow& w, wxEvent& event);

	void SetParent(wxWindow *parent) { wxParent = parent; }
	void SetSecondPoint(mpPointLayer* layer);

	void SetShape(mpShape shape);
	void SetShapeSize(int diagonal);
	void SetTaggingShape(int shape) { m_taggline = shape; }
	void SetTaggingPen(wxPen pen) { m_taggPen = pen; }

	/** Returns the position of point
	@param	x[out] 	point x-position
	@param 	y[out]	point y-position
	@return true if it spesific */
	bool GetPosition(double &x, double &y);
	/** Set the position of point
	@param	x[in] 	point x-position
	@param 	y[in]	point y-position
	@return true if allowed*/
	bool SetPosition(double &x, double &y);
	/** Undefine point */
	void UnDefine();
	/** Returns the nearest graph position at cursor
	@param	x[out] 	cursor x-position
	@param 	y[out]	graph  y-position
	@return  true if spesific*/
	bool GetCursorPosition(double &x, double &y);

	/**
	Point is possible to move with mouseleft buttom
	@param t	enable modifity */
	void EnableModify(bool t = true) { m_EnableModify = t; }

	void DragOnlyPoint(bool t = true) { m_DragOnlyPoint = t; }

	/** mpPoint Layer plot handler.
	This implementation will plot point to the visible area. */
	virtual void Plot(wxDC & dc, mpWindow & w);

	virtual bool Inside(const wxPoint& point) { return pointInPolygon(point.x, point.y); }


	bool pointInPolygon(int x, int y);

	/** Get reference to context menu of the plot canvas.
	@return Pointer to menu. The menu can be modified.
	*/
	wxMenu* GetPopupMenu() { return &m_popmenu; }

	void popup(wxWindow& win, wxMouseEvent& event)
	{
		win.PopupMenu(&m_popmenu, event.GetX(), event.GetY());
	}

	void ShowShadows(int shadow) { m_ShowShadows = shadow; }
	/**
	* Set object that generate middle text.
	* Object must derived form mpPointDeriveClass and there must be
	* virtual function:
	*  virtual wxString GenerateString(double x0, double x1, double y0, double y1)
	*/
	void SetExternalObject(mpPointDeriveClass *obj) { m_externalObject = obj; }

protected:



	//for event using
	wxWindow        *wxParent;
	long int        eventId;

	mpShape         m_shape;            //!< point shape
	int             m_diagonal;			//!< point shape diagonal size

	int             m_taggline;			//!< Tagging line type
	wxPen           m_taggPen;


	//for mp/point layers
	mpLayer         *mpParent;		    //!< parent layer where get the points
	double          m_x, m_y;            //!< The bounding rectangle of the box. It may be resized dynamicaly by the Plot method.



	bool            m_defined;          //!< only true if point is defined
	bool            m_mouseDefined;     //!< only true if mouse is inside graph

	bool            m_EnableModify;		//!< If user wan't change point place with mouse
	bool            m_cursorInside;
	double          mouseX, mouseY;		//!< contains mouse coordinates
	bool            m_DragOnlyPoint;    //!< If true, point modifing is allways possible, but only when mouse draq point

	wxPointList     m_polygon;

	//second point variables
	mpPointLayer*   m_SecondPointLayer;		//!< pointer to 2. mpPointLayer. ex. Calculate distance of 2 points.
	int				m_ShowShadows;			//!< show shadows betweeb 2 points
	mpPointDeriveClass *m_externalObject;			//!< text shown in middle of 2 points.

	wxTipWindow*    m_tooltip;
	wxMenu          m_popmenu;              //!< user handled popupmenu when clicked the point shape
											//bool            m_showHelpLine;
	DECLARE_DYNAMIC_CLASS(mpPointLayer)
};

#endif