#include "mpPointLayer.h"
#include "mpWindow.h"
#include "mpFXY.h"

/**
mpPointLayer by Jussi Vatjus-Anttila
09.2009
*/
IMPLEMENT_DYNAMIC_CLASS(mpPointLayer, mpLayer)

mpPointLayer::mpPointLayer(mpLayer *parent)
{
	m_brush = *wxTRANSPARENT_BRUSH;
	mpParent = parent;
	m_EnableModify = false;
	m_defined = false;
	m_SecondPointLayer = 0;
}

mpPointLayer::mpPointLayer(mpLayer         *mplayer,
	wxString        layerName,
	const wxBrush   *brush,
	wxWindow        *wxparent,
	long int        eventid
)
{
	m_name = layerName;
	this->ShowName(true);
	SetBrush(*brush);
	m_type = mpLayer_POINT;
	m_visible = true;
	//this->SetDrawingOrder(0);

	mpParent = mplayer;
	m_EnableModify = true;
	m_DragOnlyPoint = true;
	m_defined = false;

	wxParent = wxparent;
	eventId = eventid;
	m_drawOutsideMargins = false;

	m_shape = mpCIRCLE;
	m_diagonal = 7;
	m_taggline = 0;

	m_ShowShadows = 1;
	m_tooltip = 0;
	m_externalObject = 0;
	m_SecondPointLayer = 0;

	m_taggPen = wxPen(*wxBLACK, 1, wxPENSTYLE_DOT); //default taggpen

	int idd;
	wxMenu *submenu = new wxMenu();
	submenu->Append(idd = wxNewId(), _("Disable point"), _(""));
	//Connect( idd,wxEVT_COMMAND_MENU_SELECTED,(wxObjectEventFunction)&mpPointLayer::OnMenuItemGraphLockEvent);
	m_popmenu.Append(wxNewId(), _("Edit"), submenu, _("Edit"));

	//Call from parent:
	//Connect(eventid, wxEVT_MOTION, eventfunction)  called when mouse move
	//Connect(eventid, wxEVT_LEFT_UP, eventfunction) called when mouse left up.
}
mpPointLayer::~mpPointLayer()
{
}
void mpPointLayer::SetSecondPoint(mpPointLayer* layer)
{
	m_SecondPointLayer = layer;
}

/**
*  The function will return true if the point x,y is inside the polygon, or
*  NO if it is not.  If the point is exactly on the edge of the polygon,
*  then the function may return true or false.
*
*  @param x   Xpoint to be tested
*  @param y   Ypoint to be tested
*  @return true if inside, other false
*
*  Note that division by zero is avoided because the division is protected
*  by the "if" clause which surrounds it.
*  http://alienryderflex.com/polygon/
*/
bool mpPointLayer::pointInPolygon(int x, int y)
{
	int polySides = m_polygon.size();

	int     i, j = polySides - 1;
	bool    oddNodes = false;

	for (i = 0; i<polySides; i++)
	{
		wxPoint polygoni = *(wxPoint*)m_polygon.Item(i)->GetData();
		wxPoint polygonj = *(wxPoint*)m_polygon.Item(j)->GetData();
		if ((polygoni.y<y && polygonj.y >= y) || (polygonj.y<y && polygoni.y >= y)) {
			if (polygoni.x + (y - polygoni.y) / (polygonj.y - polygoni.y)*(polygonj.x - polygoni.x)<x) {
				oddNodes = !oddNodes;
			}
		}
		j = i;
	}
	return oddNodes;
}
void mpPointLayer::UpdatePoint(mpWindow& w, wxEvent& event)
{

	int xi = ((wxMouseEvent&)event).GetX();
	int yi = ((wxMouseEvent&)event).GetY();

	if (m_DragOnlyPoint) //if automatic modify enable.
	{
		if (((wxMouseEvent&)event).m_leftDown)
		{
			if (pointInPolygon(xi, yi) || !m_defined)
				m_cursorInside = true;

		}
		else m_cursorInside = false;
	}

	//be sure update is allowed by enduser
	if ((m_cursorInside || !m_DragOnlyPoint) && m_EnableModify)
	{

		double  xd = w.p2x(xi),
			yd = w.p2y(yi);

		//if there is graph in parent layer get coordinate
		if (mpParent->GetNearestCoord(w, xd, yd))
		{

			SetPosition(xd, yd);
			//coordinate founded

			if (wxParent) //if wxParent is set, post event to it
			{
				event.SetEventType(wxEVT_LEFT_UP);
				event.SetId(eventId);
				wxPostEvent(wxParent, event);
			}

			/*
			wxString toolTipContent;
			toolTipContent.Printf(_("X = %f\nY = %f"), xd, yd);
			wxRect rectBounds(w.x2p(xd),w.x2p(yd), 5, 5);
			if(!m_tooltip) m_tooltip = new wxTipWindow(&w, toolTipContent, 100, NULL, &rectBounds);
			else
			{
			m_tooltip->SetBoundingRect(rectBounds);
			}*/

		}
		else
		{
			m_defined = false;
		}

	}
}
void mpPointLayer::UpdateMouseCoord(mpWindow& w, wxEvent& event)
{
	//event type is valid, but is it inside diagram
	int xi = ((wxMouseEvent&)event).GetX();
	int yi = ((wxMouseEvent&)event).GetY();
	double  xd = w.p2x(xi),
		yd = w.p2y(yi);

	//if there is graph in parent layer get coordinate
	if (mpParent->GetNearestCoord(w, xd, yd))
	{
		mouseX = xd;
		mouseY = yd;
		m_mouseDefined = true;
		//m_cursorInside = pointInPolygon(xi,yi);

		if (wxParent)
		{
			event.SetEventType(wxEVT_MOTION);
			event.SetId(eventId);
			wxPostEvent(wxParent, event);
		}
	}
	else m_mouseDefined = false;
}
bool mpPointLayer::GetPosition(double &x, double &y)
{
	if (m_defined)
	{
		//if position is set
		x = m_x; y = m_y;
		return true;
	}
	return false;
}
bool mpPointLayer::SetPosition(double & x, double & y)
{
	m_x = x; m_y = y;
	m_defined = true;
	return false;
}
void mpPointLayer::UnDefine()
{
	m_defined = false;
}
void mpPointLayer::SetShape(mpShape shape)
{
	m_shape = shape;
}
void mpPointLayer::SetShapeSize(int diagonal)
{
	m_diagonal = diagonal;
}
bool mpPointLayer::GetCursorPosition(double &x, double &y)
{
	if (m_mouseDefined)
	{
		x = mouseX;
		y = mouseY;
		return true;
	}
	return false;
}
void mpPointLayer::Plot(wxDC & dc, mpWindow & w)
{
	/**
	* polygon shape is used, as the location of
	* the mouse can be easily identified inside a polygon
	*    bool Inside(wxPoint)
	*    wxPoint is wxDC coordinate,
	*    example from wxMouseEvent
	*
	*  m_polygon is wxDC coordiante
	*/
	if (this->m_visible && m_defined)
	{
		wxCoord startPx = m_drawOutsideMargins ? 0 : w.GetMarginLeft();
		wxCoord endPx = m_drawOutsideMargins ? w.GetScrX() : w.GetScrX() - w.GetMarginRight();
		wxCoord minYpx = m_drawOutsideMargins ? 0 : w.GetMarginTop();
		wxCoord maxYpx = m_drawOutsideMargins ? w.GetScrY() : w.GetScrY() - w.GetMarginBottom();


		wxPoint coord(w.x2p(m_x), w.y2p(m_y));
		dc.SetBrush(m_brush);
		dc.SetPen(m_pen);

		m_polygon.clear();
		//m_polygon.DeleteContents(true);

		/*
		if(coord.x < startPx) return;
		if(coord.x > endPx) return;
		if(coord.y < minYpx) return;
		if(coord.y > maxYpx) return;
		*/

		if (m_shape == mpCIRCLE)
		{
			for (double t = 0; t<2 * M_PI; t += 0.4)
			{
				m_polygon.Append(new wxPoint(coord.x + (int)(m_diagonal*cos(t)), (int)(coord.y + m_diagonal*sin(t))));

			}
		}
		else if (m_shape == mpSQUARE)
		{
			m_polygon.Append(new wxPoint(coord.x - m_diagonal, coord.y - m_diagonal));
			m_polygon.Append(new wxPoint(coord.x - m_diagonal, coord.y + m_diagonal));
			m_polygon.Append(new wxPoint(coord.x + m_diagonal, coord.y + m_diagonal));
			m_polygon.Append(new wxPoint(coord.x + m_diagonal, coord.y - m_diagonal));
			m_polygon.Append(new wxPoint(coord.x - m_diagonal, coord.y - m_diagonal));

		}
		else if (m_shape == mpDIAMOND)
		{
			m_polygon.Append(new wxPoint(coord.x, coord.y - m_diagonal));
			m_polygon.Append(new wxPoint(coord.x - m_diagonal, coord.y));
			m_polygon.Append(new wxPoint(coord.x, coord.y + m_diagonal));
			m_polygon.Append(new wxPoint(coord.x + m_diagonal, coord.y));
			m_polygon.Append(new wxPoint(coord.x, coord.y - m_diagonal));
		}
		else if (m_shape == mpELLIPSE)
		{
			for (double t = 0; t<2 * M_PI; t += 0.4)
			{
				m_polygon.Append(new wxPoint(coord.x + (int)(m_diagonal*cos(t)), (int)(coord.y + 2 * m_diagonal*sin(t))));
			}
		}
		else if (m_shape == mpARROW_UP)
		{
			m_polygon.Append(new wxPoint(coord.x, coord.y));
			m_polygon.Append(new wxPoint(coord.x - m_diagonal, coord.y + m_diagonal));
			m_polygon.Append(new wxPoint(coord.x + m_diagonal, coord.y + m_diagonal));
			m_polygon.Append(new wxPoint(coord.x, coord.y));
		}
		else if (m_shape == mpARROW_DOWN)
		{
			m_polygon.Append(new wxPoint(coord.x, coord.y));
			m_polygon.Append(new wxPoint(coord.x - m_diagonal, coord.y - m_diagonal));
			m_polygon.Append(new wxPoint(coord.x + m_diagonal, coord.y - m_diagonal));
			m_polygon.Append(new wxPoint(coord.x, coord.y));
		}
		else if (m_shape == mpARROW_UPDOWN)
		{
			//up arrow
			m_polygon.Append(new wxPoint(coord.x, coord.y));
			m_polygon.Append(new wxPoint(coord.x - m_diagonal, coord.y + m_diagonal));
			m_polygon.Append(new wxPoint(coord.x + m_diagonal, coord.y + m_diagonal));
			m_polygon.Append(new wxPoint(coord.x, coord.y));
			//down arrow
			m_polygon.Append(new wxPoint(coord.x, coord.y));
			m_polygon.Append(new wxPoint(coord.x - m_diagonal, coord.y - m_diagonal));
			m_polygon.Append(new wxPoint(coord.x + m_diagonal, coord.y - m_diagonal));
			m_polygon.Append(new wxPoint(coord.x, coord.y));
		}

		dc.SetPen(m_pen);

#if wxCHECK_VERSION(3, 0, 0)
		// 2.9< -> void wxDC::DrawPolygon	(	const wxPointList *points,wxCoord 	xoffset = 0,wxCoord 	yoffset = 0,wxPolygonFillMode 	fill_style = wxODDEVEN_RULE )
		dc.DrawPolygon(&m_polygon);
#elif wxCHECK_VERSION(2, 8, 0)
		// 2.8.x -> void DrawPolygon(wxList *points, wxCoord xoffset = 0, wxCoord yoffset = 0, int fill_style = wxODDEVEN_RULE)
		dc.DrawPolygon((wxList*)&m_polygon);
#else
		#warning NOT SUPPOTED
#endif


			if (m_taggline && coord.x > startPx && coord.x < endPx)
			{
				// wxDOT_DASH / wxDOT / wxSHORT_DASH
				dc.SetPen(m_taggPen);

				if (m_taggline&mpVERTICAL_LINE)
				{   //draw vertical line over the window
					dc.DrawLine(coord.x, minYpx, coord.x, maxYpx);
				}
				if (m_taggline&mpHORIZONTAL_LINE)
				{   //draw vertical line over the window
					dc.DrawLine(startPx, coord.y, endPx, coord.y);
				}
				if (m_taggline&mpCROSS_LINES)
				{   //draw vertical line over the window
					dc.DrawLine(coord.x - 50, coord.y + 50, coord.x + 50, coord.y - 50);
					dc.DrawLine(coord.x - 50, coord.y - 50, coord.x + 50, coord.y + 50);
				}
				dc.SetPen(m_pen);
			}


		if (m_SecondPointLayer)
		{
			double x, y;
			int px, py;
			if (m_SecondPointLayer->GetPosition(x, y))
			{
				wxPoint coord2(w.x2p(x), w.y2p(y));
				wxPen tmp(*wxBLUE, 10);
				if (x < m_x)
					tmp.SetColour(*wxRED);

				if (coord.x < startPx) coord.x = startPx;
				else if (coord.x > endPx) coord.x = endPx;

				if (coord2.x < startPx) coord2.x = startPx;
				else if (coord2.x > endPx) coord2.x = endPx;

				dc.SetPen(tmp);
				dc.DrawLine(coord.x, maxYpx, coord2.x, maxYpx);

				dc.SetPen(m_pen);

				//if show shadows..
				// drawn between the points reflecting the average of the shading
				if (!m_externalObject && m_ShowShadows && m_x < x) //show shading only when P1 < P2
				{
					if (m_ShowShadows == 1)
					{
						//draw bar, wich are y value height
						bool ok = false;
						double x2, y2, x0 = m_x;
						int width;
						dynamic_cast<mpFXY*>(mpParent)->Rewind();
						while (dynamic_cast<mpFXY*>(mpParent)->GetNextXY(x2, y2))
						{
							if (!ok)
							{
								if (x2 == m_x)ok = true; //first
								else continue;
							}
							px = w.x2p(x2);
							py = w.y2p(y2);
							width = py - w.x2p(x0);

							dc.GradientFillLinear(wxRect(px, py, width, maxYpx - py),
								wxColour(150, 150, 200),
								wxColour(255, 255, 255),
								wxDirection(wxDOWN));
							x0 = x2;

							if (x2 == x)break;

						}
					}
					if (m_ShowShadows == 2)
					{
						bool ok = false;
						double x2, y2;
						double sumy = 0;
						double n = 0;
						dynamic_cast<mpFXY*>(mpParent)->Rewind();
						while (dynamic_cast<mpFXY*>(mpParent)->GetNextXY(x2, y2))
						{
							if (!ok)
							{
								if (x2 == m_x)ok = true; //first
								else continue;
							}
							sumy += y2;
							n++;

							if (x2 == x)break;
						}
						y2 = sumy / n;

						px = w.x2p(m_x);
						if (px<startPx)px = startPx;
						if (px>endPx)px = endPx;
						py = w.y2p(y2);
						int width = w.x2p(x2) - px;
						dc.GradientFillLinear(wxRect(px, py, width, maxYpx - py),
							wxColour(150, 150, 200),
							wxColour(255, 255, 255),
							wxDirection(wxDOWN));

					}
				}

				if (m_externalObject)
				{
					m_externalObject->customPlot(dc, w, m_x, m_y, x, y, coord, coord2, maxYpx);
				}
			}
		}


		if (!m_name.IsEmpty() && m_showName)
		{
			dc.SetFont(m_font);
			dc.DrawText(GetName(), coord.x - 5, coord.y + 20);
		}

	}
}