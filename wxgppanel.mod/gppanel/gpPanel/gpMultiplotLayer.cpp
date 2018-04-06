#include <gpMultiplotLayer.h>
#include "mpScaleY.h"
#include "mpScaleX.h"
#include "mpInfoLegend.h"
#include "mpInfoCoord.h"
#include "gpSeries.h"
#include "lineChartLayer.h"
#include "barChartLayer.h"
#include "areaChartLayer.h"

gpSeries * gpMultiPlotLayer::FindSeries(wxString SeriesLabel)
{
	for (unsigned int i = 0; i<m_Series.size(); i++)
	{
		if (m_Series[i]->IsLabel(SeriesLabel))
		{
			return m_Series[i];
		}
	}
	return nullptr;
}

int gpMultiPlotLayer::FindSeriesIndice(wxString SeriesLabel)
{
	for (unsigned int i = 0; i < m_Series.size(); i++)
	{
		if (m_Series[i]->IsLabel(SeriesLabel))
		{
			return i;
		}
	}
	return 0;
}

void gpMultiPlotLayer::type(Type type)
{
	m_type = type;
}

void gpMultiPlotLayer::invertYScale(bool value)
{
	yaxis->invert(value);
}

gpMultiPlotLayer::gpMultiPlotLayer(wxString label, wxString x_label, wxString y_label, Type type)
{
	m_type = type;
	m_XLabel = x_label;
	m_YLabel = y_label;
	wxFont graphFont(11, wxFONTFAMILY_DEFAULT, wxFONTSTYLE_NORMAL,
		wxFONTWEIGHT_NORMAL);
	xaxis = new mpScaleX(x_label, mpALIGN_BOTTOM, false, mpX_NORMAL);
	xaxis->SetFont(graphFont);
	xaxis->SetVisible(true);
	xaxis->SetDrawOutsideMargins(false);
	yaxis = new mpScaleY(y_label, mpALIGN_LEFT, false);
	yaxis->SetFont(graphFont);
	yaxis->SetDrawOutsideMargins(false);
	yaxis->SetVisible(true);
	wxToolTip::Enable(false);
	this->SetDelay(5000);
	this->SetTip(label + _("\n                                                                                                                                            "));
	//default labels for axis
	LabelList[gpCHART_DEFAULT] = label;
	xLabelList[gpCHART_DEFAULT] = x_label;
	yLabelList[gpCHART_DEFAULT] = y_label;
	LabelList[gpCHART_INL] = label;
	xLabelList[gpCHART_INL] = x_label;
	yLabelList[gpCHART_INL] = _("INL");

	LabelList[gpCHART_DNL] = label;
	xLabelList[gpCHART_DNL] = x_label;
	yLabelList[gpCHART_DNL] = _("DNL");

	LabelList[gpCHART_FFT] = label;
	xLabelList[gpCHART_FFT] = _("Frequency");
	yLabelList[gpCHART_FFT] = _("Y");

	LabelList[gpCHART_ACCUMULATION] = label;
	xLabelList[gpCHART_ACCUMULATION] = _("Y");
	yLabelList[gpCHART_ACCUMULATION] = _("Accumulation");

	LabelList[gpCHART_CUSTOM] = label;
	xLabelList[gpCHART_CUSTOM] = _("X");
	yLabelList[gpCHART_CUSTOM] = _("custom");

	this->AddLayer(xaxis);
	this->AddLayer(yaxis);
	samplerate = 1;
	fftlenght = 64;
	gpChart_kind = gpCHART_DEFAULT;
	gpXaxis_type = gpAXIS_CUSTOM;
	gpYaxis_type = gpAXIS_CUSTOM;
	RefreshLabels();
}

gpMultiPlotLayer::~gpMultiPlotLayer()
{
	for (unsigned int i = 0; i< m_Series.size(); i++)
	{
		delete m_Series[i];
	}
}

void gpMultiPlotLayer::myDataPush(double x, double y, wxString SeriesLabel)
{
	gpSeries *pointer = FindSeries(SeriesLabel);
	if (pointer != nullptr)
	{
		pointer->DataPush(x, y);
		m_refreshNeeded = true;
	}
}

void gpMultiPlotLayer::DataClear(wxString SeriesLabel)
{
	gpSeries *pointer = FindSeries(SeriesLabel);
	if (pointer != nullptr)
	{
		pointer->DataClear();
		m_refreshNeeded = true;
	}
}

void gpMultiPlotLayer::RefreshChart(void)
{
	for (unsigned int i = 0; i< m_Series.size(); i++)
	{
		m_Series[i]->RefreshChart(gpChart_kind, 
								  samplerate, 
								  fftlenght,
								  m_customXFormula, 
								  m_customYFormula, 
								  m_customYXFormula,
								  gpXaxis_type, 
								  gpYaxis_type);
	}
}

gpSeries * gpMultiPlotLayer::AddSeriesLayer(wxString label)
{
	gpSeries *Series = new gpSeries(label);
	m_Series.push_back(Series);
	Series->SetContinuity(true);
	Series->SetVisible(true);
	Series->ShowName(false);
	switch (m_type)
	{
	case gpMultiPlotLayer::Type::BAR:
		this->AddLayer(Series->getBarChartLayer());
		break;
	case gpMultiPlotLayer::Type::LINE:
		this->AddLayer(Series->getLineChartLayer());
		break;
	case gpMultiPlotLayer::Type::AREA:
		this->AddLayer(Series->getAreaChartLayer());
		break;
	case gpMultiPlotLayer::Type::POINT:
		this->AddLayer(Series->getPointChartLayer());
		break;
	default:
		break;
	}	
	return Series;
}

void gpMultiPlotLayer::SetPen(wxPen pen, wxString SeriesLabel)
{
	FindSeries(SeriesLabel)->SetPen(pen);
}

void gpMultiPlotLayer::DeleteSeries(wxString SeriesLabel)
{
	int indice;
	gpSeries *pointer = FindSeries(SeriesLabel);
	if (pointer != nullptr)
	{
		DelAllLayers();
		delete pointer;
	}
}

void gpMultiPlotLayer::AddLegendInfo(int x, int y)
{
	wxBrush hatch2(wxColour(163, 208, 212), wxSOLID);
	leg = new mpInfoLegend(wxRect(x, y, 40, 40), &hatch2);
	leg->SetVisible(true);
	this->AddLayer(leg);
}

void gpMultiPlotLayer::AddCoordInfo(int x, int y)
{
	wxBrush hatch(wxColour(200, 200, 200), wxSOLID);
	nfo = new mpInfoCoords(wxRect(x, y, 10, 10), &hatch);
	nfo->SetFormat(m_XLabel + wxT(" = %f\n" + m_YLabel + wxT(" = %f")));
	nfo->SetVisible(true);
	this->AddLayer(nfo);
}

xyMultimap_t gpMultiPlotLayer::GetData(wxString SeriesLabel)
{
	xyMultimap_t result;
	gpSeries *pointer = FindSeries(SeriesLabel);
	if (pointer != nullptr)
	{
		result = pointer->GetData();
	}
	return result;
}

double gpMultiPlotLayer::getMinY()
{
	double min = std::numeric_limits<double>::max();
	for (auto serie : m_Series)
	{
		if (serie->getLineChartLayer()->GetMinY() < min)
		{
			min = serie->getLineChartLayer()->GetMinY();
		}
	}

	return min;
}
