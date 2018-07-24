#include "gpSeries.h"
#include "lineChartLayer.h"
#include "barChartLayer.h"
#include "areaChartLayer.h"

/*!
 *  \brief Constructor
 */
gpSeries::gpSeries( wxString label )
{
    m_lineLayer = new lineChartLayer( label );
	m_barLayer = new barChartLayer(label);
	m_areaLayer = new areaChartLayer(label);
	m_pointLayer = new lineChartLayer(label);
	m_barLayer->SetGradientBackColour(false);
	m_pointLayer->SetPointType(mpCIRCLE);
	m_pointLayer->SetContinuity(false);

    m_Label = label;
}


/*!
 *  \brief Destructor
 */
gpSeries::~gpSeries( void )
{
    /*delete m_lineLayer;
	delete m_barLayer;
	delete m_areaLayer;*/
}


/*!
 *  \brief Calls a function to push data to m_Data
 *
 *  \param x
 *  The x value to push
 *
 *  \param y
 *  The y value to push
 */
void gpSeries::DataPush( double x, double y )
{
    m_Data.DataPush( x , y );
}


/*!
 *  \brief Refreshes the data from m_Data into m_Layer
 */
void gpSeries::RefreshChart( gpCHART_KIND gpChart_kind, double samplerate,
            int fftlenght, wxString customXFormula, wxString customYFormula,
            wxString customYXFormula, gpAXIS_SCALE gpXaxis_type,
            gpAXIS_SCALE gpYaxis_type )
{
	m_lineLayer->DataSet( m_Data.GetData() );
	m_barLayer->DataSet(m_Data.GetData());
	m_areaLayer->DataSet(m_Data.GetData());
	m_pointLayer->DataSet(m_Data.GetData());
}

/*!
 *  \brief Checks to see if a label is the same as the label for this series.
 *
 *  \param CompareLabel
 *  The label to check
 *
 *  \return
 *  True is the labels match.  False if they do not.
 */
bool gpSeries::IsLabel( wxString CompareLabel )
{
    if( CompareLabel == m_Label )
    {
        return true;
    }
    else
    {
        return false;
    }
}


/*!
 *  \brief Calls the SetContinuity function of m_Layer
 */
void gpSeries::SetContinuity( bool continuity )
{
	m_lineLayer->SetContinuity( continuity );
	m_barLayer->SetContinuity(continuity);
	m_areaLayer->SetContinuity(continuity);
}


/*!
 *  \brief Calls the SetVisible function of m_Layer
 */
void gpSeries::SetVisible( bool show )
{
	m_lineLayer->SetVisible( show );
	m_barLayer->SetVisible(show);
	m_areaLayer->SetVisible(show);
	m_pointLayer->SetVisible(show);
}


/*!
 *  \brief Calls the ShowName function of m_Layer
 */
void gpSeries::ShowName( bool show )
{
	m_lineLayer->ShowName( show );
	m_barLayer->ShowName(show);
	m_areaLayer->ShowName(show);
	m_pointLayer->ShowName(show);
}


lineChartLayer* gpSeries::getLineChartLayer( void )
{
    return m_lineLayer;
}

barChartLayer * gpSeries::getBarChartLayer()
{
	return m_barLayer;
}

areaChartLayer * gpSeries::getAreaChartLayer()
{
	return m_areaLayer;
}

lineChartLayer * gpSeries::getPointChartLayer()
{
	return m_pointLayer;
}

/*!
 *  \brief Calls the SetPen function of m_Layer
 */
void gpSeries::SetPen( wxPen pen )
{
	m_lineLayer->SetPen( pen );
	m_barLayer->SetPen(pen);
	m_areaLayer->SetPen(pen);
	m_pointLayer->SetPen(pen);
}

void gpSeries::SetBrush(wxBrush brush)
{
	m_lineLayer->SetBrush(brush);
	m_barLayer->SetBrush(brush);
	m_areaLayer->SetBrush(brush);
	m_pointLayer->SetBrush(brush);
}

/*!
 *  \brief Calls the DataClear function of m_Data
 */
void gpSeries::DataClear( void )
{
    m_Data.DataClear();
	m_lineLayer->DataClear();
	m_barLayer->DataClear();
	m_areaLayer->DataClear();
	m_pointLayer->DataClear();
}

void gpSeries::invert(bool value)
{
	m_lineLayer->invert(value);
	m_barLayer->invert(value);
	m_areaLayer->invert(value);
	m_pointLayer->invert(value);
}

/*!
 *  \brief Gets the multimap data from m_Data
 *
 *  \return
 *  A multimap of the data
 */
xyMultimap_t gpSeries::GetData( void )
{
    return m_Data.GetData();
}
