/*
  Copyright (c) 2007-2013 Bruce A Henderson
 
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

MaxToolBar::MaxToolBar(wxWindow * parent, long style, wxWindowID id, const wxString& name)
	: wxToolBar(parent, id, wxDefaultPosition, wxDefaultSize, style, name)
{
}

MaxToolBar::MaxToolBar(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxToolBar(parent, id, wxPoint(x, y), wxSize(w,h), style)
{
	wxbind(this, handle);
}

MaxToolBar::MaxToolBar()
{}

MaxToolBar::~MaxToolBar() {
	wxunbind(this);
}

void MaxToolBar::injectSelf(BBObject * handle) {
	wxbind(this, handle);
}

void MaxToolBar::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxToolBarXmlHandler, wxToolBarXmlHandler)

MaxToolBarXmlHandler::MaxToolBarXmlHandler()
	: wxToolBarXmlHandler(), m_isInside(false), m_toolbar(NULL)
{}


wxObject * MaxToolBarXmlHandler::DoCreateResource()
{
    if (m_class == wxT("tool"))
    {
        wxCHECK_MSG(m_toolbar, NULL, wxT("Incorrect syntax of XRC resource: tool not within a toolbar!"));

        if (GetPosition() != wxDefaultPosition)
        {
            m_toolbar->AddTool(GetID(),
                               GetBitmap(wxT("bitmap"), wxART_TOOLBAR),
                               GetBitmap(wxT("bitmap2"), wxART_TOOLBAR),
                               GetBool(wxT("toggle")),
                               GetPosition().x,
                               GetPosition().y,
                               NULL,
                               GetText(wxT("tooltip")),
                               GetText(wxT("longhelp")));
        }
        else
        {
            wxItemKind kind = wxITEM_NORMAL;
            if (GetBool(wxT("radio")))
                kind = wxITEM_RADIO;
            if (GetBool(wxT("toggle")))
            {
                wxASSERT_MSG( kind == wxITEM_NORMAL,
                              _T("can't have both toggleable and radion button at once") );
                kind = wxITEM_CHECK;
            }
            m_toolbar->AddTool(GetID(),
                               GetText(wxT("label")),
                               GetBitmap(wxT("bitmap"), wxART_TOOLBAR),
                               GetBitmap(wxT("bitmap2"), wxART_TOOLBAR),
                               kind,
                               GetText(wxT("tooltip")),
                               GetText(wxT("longhelp")));

            if ( GetBool(wxT("disabled")) )
                m_toolbar->EnableTool(GetID(), false);
        }
        return m_toolbar; // must return non-NULL
    }

    else if (m_class == wxT("separator"))
    {
        wxCHECK_MSG(m_toolbar, NULL, wxT("Incorrect syntax of XRC resource: separator not within a toolbar!"));
        m_toolbar->AddSeparator();
        return m_toolbar; // must return non-NULL
    }

    else /*<object class="wxToolBar">*/
    {
        int style = GetStyle(wxT("style"), wxNO_BORDER | wxTB_HORIZONTAL);
#ifdef __WXMSW__
        if (!(style & wxNO_BORDER)) style |= wxNO_BORDER;
#endif

        XRC_MAKE_INSTANCE(toolbar, MaxToolBar)

        toolbar->Create(m_parentAsWindow,
                         GetID(),
                         GetPosition(),
                         GetSize(),
                         style,
                         GetName());


		toolbar->MaxBind(_wx_wxtoolbar_wxToolBar__xrcNew(toolbar));

        wxSize bmpsize = GetSize(wxT("bitmapsize"));
        if (!(bmpsize == wxDefaultSize))
            toolbar->SetToolBitmapSize(bmpsize);
        wxSize margins = GetSize(wxT("margins"));
        if (!(margins == wxDefaultSize))
            toolbar->SetMargins(margins.x, margins.y);
        long packing = GetLong(wxT("packing"), -1);
        if (packing != -1)
            toolbar->SetToolPacking(packing);
        long separation = GetLong(wxT("separation"), -1);
        if (separation != -1)
            toolbar->SetToolSeparation(separation);
        if (HasParam(wxT("bg")))
            toolbar->SetBackgroundColour(GetColour(wxT("bg")));

        wxXmlNode *children_node = GetParamNode(wxT("object"));
        if (!children_node)
           children_node = GetParamNode(wxT("object_ref"));

        if (children_node == NULL) return toolbar;

        m_isInside = true;
        m_toolbar = toolbar;

        wxXmlNode *n = children_node;

        while (n)
        {
            if ((n->GetType() == wxXML_ELEMENT_NODE) &&
                (n->GetName() == wxT("object") || n->GetName() == wxT("object_ref")))
            {
                wxObject *created = CreateResFromNode(n, toolbar, NULL);
                wxControl *control = wxDynamicCast(created, wxControl);
                if (!IsOfClass(n, wxT("tool")) &&
                    !IsOfClass(n, wxT("separator")) &&
                    control != NULL)
                    toolbar->AddControl(control);
            }
            n = n->GetNext();
        }

        m_isInside = false;
        m_toolbar = NULL;

        toolbar->Realize();

        if (m_parentAsWindow && !GetBool(wxT("dontattachtoframe")))
        {
            wxFrame *parentFrame = wxDynamicCast(m_parent, wxFrame);
            if (parentFrame)
                parentFrame->SetToolBar(toolbar);
        }

        return toolbar;
    }
}

bool MaxToolBarXmlHandler::CanHandle(wxXmlNode *node)
{
	return ((!m_isInside && IsOfClass(node, wxT("wxToolBar"))) ||
            (m_isInside && IsOfClass(node, wxT("tool"))) ||
            (m_isInside && IsOfClass(node, wxT("separator"))));
}


// *********************************************

void bmx_wxtoolbar_injectSelf(MaxToolBar * toolbar, BBObject * handle) {
	toolbar->injectSelf(handle);
}

MaxToolBar * bmx_wxtoolbar_create(BBObject * maxHandle, wxWindow* parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxToolBar(maxHandle, parent, id, x, y, w, h, style);
}

bool bmx_wxtoolbar_addcontrol(wxToolBar * toolbar, wxControl * control) {
	return toolbar->AddControl(control);
}

void bmx_wxtoolbar_addseparator(wxToolBar * toolbar) {
	toolbar->AddSeparator();
}

wxToolBarToolBase * bmx_wxtoolbar_addtool(wxToolBar * toolbar, int id, BBString * label, MaxBitmap * bitmap1, 
		MaxBitmap * bitmap2, wxItemKind kind, BBString * shortHelp, BBString * longHelp, void * clientData) {

	if (bitmap2) {
		return toolbar->AddTool(id, wxStringFromBBString(label), bitmap1->Bitmap(), bitmap2->Bitmap(), kind, 
			wxStringFromBBString(shortHelp), wxStringFromBBString(longHelp));
	} else {
		return toolbar->AddTool(id, wxStringFromBBString(label), bitmap1->Bitmap(), wxNullBitmap, kind, 
			wxStringFromBBString(shortHelp), wxStringFromBBString(longHelp));
	}
}

bool bmx_wxtoolbar_realize(wxToolBar * toolbar) {
	return toolbar->Realize();
}

void bmx_wxtoolbar_settoolbitmapsize(wxToolBar * toolbar, int w, int h) {
	toolbar->SetToolBitmapSize(wxSize(w, h));
}


void bmx_wxtoolbar_cleartools(wxToolBar * toolbar) {
	toolbar->ClearTools();
}

bool bmx_wxtoolbar_deletetool(wxToolBar * toolbar, int toolId) {
	return toolbar->DeleteTool(toolId);
}

bool bmx_wxtoolbar_deletetoolbypos(wxToolBar * toolbar, int pos) {
	return toolbar->DeleteToolByPos(pos);
}

void bmx_wxtoolbar_enabletool(wxToolBar * toolbar, int toolId, bool enable) {
	toolbar->EnableTool(toolId, enable);
}

int bmx_wxtoolbar_gettoolscount(wxToolBar * toolbar) {
	return toolbar->GetToolsCount();
}

void bmx_wxtoolbar_gettoolsize(wxToolBar * toolbar, int * width, int * height) {
	wxSize m = toolbar->GetToolSize();
	*width = m.x;
	*height = m.y;
}

void bmx_wxtoolbar_gettoolbitmapsize(wxToolBar * toolbar, int * width, int * height) {
	wxSize m = toolbar->GetToolBitmapSize();
	*width = m.x;
	*height = m.y;
}

void bmx_wxtoolbar_getmargins(wxToolBar * toolbar, int * leftRight, int * topBottom) {
	wxSize m = toolbar->GetMargins();
	*leftRight = m.x;
	*topBottom = m.y;
}

bool bmx_wxtoolbar_gettoolenabled(wxToolBar * toolbar, int toolId) {
	return toolbar->GetToolEnabled(toolId);
}

BBString * bmx_wxtoolbar_gettoollonghelp(wxToolBar * toolbar, int toolId) {
	return bbStringFromWxString(toolbar->GetToolLongHelp(toolId));
}

int bmx_wxtoolbar_gettoolpacking(wxToolBar * toolbar) {
	return toolbar->GetToolPacking();
}

int bmx_wxtoolbar_gettoolpos(wxToolBar * toolbar, int toolId) {
	return toolbar->GetToolPos(toolId);
}

int bmx_wxtoolbar_gettoolseparation(wxToolBar * toolbar) {
	return toolbar->GetToolSeparation();
}

BBString * bmx_wxtoolbar_gettoolshorthelp(wxToolBar * toolbar, int toolId) {
	return bbStringFromWxString(toolbar->GetToolShortHelp(toolId));
}

bool bmx_wxtoolbar_gettoolstate(wxToolBar * toolbar, int toolId) {
	return toolbar->GetToolState(toolId);
}


wxToolBarToolBase * bmx_wxtoolbar_addchecktool(wxToolBar * toolbar, int id, BBString * label, MaxBitmap * bitmap1, MaxBitmap * bitmap2,
		BBString * shortHelp, BBString * longHelp, void * clientData) {

	MaxObject * userData;
	if (clientData) {
		userData = new MaxObject(clientData);
	}
	
	if (bitmap2) {
		return toolbar->AddCheckTool(id, wxStringFromBBString(label), bitmap1->Bitmap(), bitmap2->Bitmap(),
			wxStringFromBBString(shortHelp), wxStringFromBBString(longHelp), userData);
	} else {
		return toolbar->AddCheckTool(id, wxStringFromBBString(label), bitmap1->Bitmap(), wxNullBitmap,
			wxStringFromBBString(shortHelp), wxStringFromBBString(longHelp), userData);
	}
}

wxToolBarToolBase * bmx_wxtoolbar_addradiotool(wxToolBar * toolbar, int id, BBString * label, MaxBitmap * bitmap1, MaxBitmap * bitmap2,
		BBString * shortHelp, BBString * longHelp, void * clientData) {

	MaxObject * userData;
	if (clientData) {
		userData = new MaxObject(clientData);
	}
	
	if (bitmap2) {
		return toolbar->AddRadioTool(id, wxStringFromBBString(label), bitmap1->Bitmap(), bitmap2->Bitmap(),
			wxStringFromBBString(shortHelp), wxStringFromBBString(longHelp), userData);
	} else {
		return toolbar->AddRadioTool(id, wxStringFromBBString(label), bitmap1->Bitmap(), wxNullBitmap,
			wxStringFromBBString(shortHelp), wxStringFromBBString(longHelp), userData);
	}
}

wxToolBarToolBase * bmx_wxtoolbar_inserttool(wxToolBar * toolbar, size_t pos, int id, BBString * label, MaxBitmap * bitmap1,
		MaxBitmap * bitmap2, wxItemKind kind, void * clientData, BBString * shortHelp, BBString * longHelp) {

	MaxObject * userData;
	if (clientData) {
		userData = new MaxObject(clientData);
	}

	if (bitmap2) {
		return toolbar->InsertTool(pos, id, wxStringFromBBString(label), bitmap1->Bitmap(), bitmap2->Bitmap(),
			kind, wxStringFromBBString(shortHelp), wxStringFromBBString(longHelp), userData);
	} else {
		return toolbar->InsertTool(pos, id, wxStringFromBBString(label), bitmap1->Bitmap(), wxNullBitmap,
			kind, wxStringFromBBString(shortHelp), wxStringFromBBString(longHelp), userData);
	}
	
}

void bmx_wxtoolbar_setmargins(wxToolBar * toolbar, int leftRight, int topBottom) {
	toolbar->SetMargins(leftRight, topBottom);
}

void bmx_wxtoolbar_settoolclientdata(wxToolBar * toolbar, int id, void * clientData) {
	MaxObject * userData;
	if (clientData) {
		userData = new MaxObject(clientData);
	}
	toolbar->SetToolClientData(id, userData);
}

void bmx_wxtoolbar_settooldisabledbitmap(wxToolBar * toolbar, int id, MaxBitmap * bitmap) {
	toolbar->SetToolDisabledBitmap(id, bitmap->Bitmap());
}

void bmx_wxtoolbar_settoollonghelp(wxToolBar * toolbar, int id, BBString * helpString) {
	toolbar->SetToolLongHelp(id, wxStringFromBBString(helpString));
}

void bmx_wxtoolbar_settoolpacking(wxToolBar * toolbar, int packing) {
	toolbar->SetToolPacking(packing);
}

void bmx_wxtoolbar_settoolshorthelp(wxToolBar * toolbar, int id, BBString * helpString) {
	toolbar->SetToolShortHelp(id, wxStringFromBBString(helpString));
}

void bmx_wxtoolbar_settoolnormalbitmap(wxToolBar * toolbar, int id, MaxBitmap * bitmap) {
	toolbar->SetToolNormalBitmap(id, bitmap->Bitmap());
}

void bmx_wxtoolbar_settoolseparation(wxToolBar * toolbar, int separation) {
	toolbar->SetToolSeparation(separation);
}

void bmx_wxtoolbar_toggletool(wxToolBar * toolbar, int id, bool toggle) {
	toolbar->ToggleTool(id, toggle);
}

wxToolBarToolBase * bmx_wxtoolbar_removetool(wxToolBar * toolbar, int id) {
	return toolbar->RemoveTool(id);
}

void * bmx_wxtoolbar_gettoolclientdata(wxToolBar * toolbar, int id) {
	MaxObject * data = (MaxObject *)toolbar->GetToolClientData(id);
	if (data) {
		return data->getHandle();
	}
	return 0;
}

wxToolBarToolBase * bmx_wxtoolbar_findbyid(wxToolBar * toolbar, int id) {
	return toolbar->FindById(id);
}

wxControl * bmx_wxtoolbar_findcontrol(wxToolBar * toolbar, int id) {
	return toolbar->FindControl(id);
}

wxToolBarToolBase * bmx_wxtoolbar_findtoolforposition(wxToolBar * toolbar, int x, int y) {
	return toolbar->FindToolForPosition(x, y);
}

wxToolBarToolBase * bmx_wxtoolbar_insertcontrol(wxToolBar * toolbar, int pos, wxControl * control) {
	return toolbar->InsertControl(pos, control);
}

wxToolBarToolBase * bmx_wxtoolbar_insertseparator(wxToolBar * toolbar, int pos) {
	return toolbar->InsertSeparator(pos);
}


bool bmx_wxtoolbartoolbase_isbutton(wxToolBarToolBase * base) {
	return base->IsButton();
}

bool bmx_wxtoolbartoolbase_iscontrol(wxToolBarToolBase * base) {
	return base->IsControl();
}

bool bmx_wxtoolbartoolbase_isseparator(wxToolBarToolBase * base) {
	return base->IsSeparator();
}

int bmx_wxtoolbartoolbase_getstyle(wxToolBarToolBase * base) {
	return base->GetStyle();
}

wxItemKind bmx_wxtoolbartoolbase_getkind(wxToolBarToolBase * base) {
	return base->GetKind();
}

bool bmx_wxtoolbartoolbase_isenabled(wxToolBarToolBase * base) {
	return base->IsEnabled();
}

bool bmx_wxtoolbartoolbase_istoggled(wxToolBarToolBase * base) {
	return base->IsToggled();
}

bool bmx_wxtoolbartoolbase_canbetoggled(wxToolBarToolBase * base) {
	return base->CanBeToggled();
}

MaxBitmap * bmx_wxtoolbartoolbase_getnormalbitmap(wxToolBarToolBase * base) {
	wxBitmap b(base->GetNormalBitmap());
	return new MaxBitmap(b);
}

MaxBitmap * bmx_wxtoolbartoolbase_getdisabledbitmap(wxToolBarToolBase * base) {
	wxBitmap b(base->GetDisabledBitmap());
	return new MaxBitmap(b);
}

MaxBitmap * bmx_wxtoolbartoolbase_getbitmap(wxToolBarToolBase * base) {
	wxBitmap b(base->GetBitmap());
	return new MaxBitmap(b);
}

BBString * bmx_wxtoolbartoolbase_getlabel(wxToolBarToolBase * base) {
	return bbStringFromWxString(base->GetLabel());
}

BBString * bmx_wxtoolbartoolbase_getshorthelp(wxToolBarToolBase * base) {
	return bbStringFromWxString(base->GetShortHelp());
}

BBString * bmx_wxtoolbartoolbase_getlonghelp(wxToolBarToolBase * base) {
	return bbStringFromWxString(base->GetLongHelp());
}

BBObject * bmx_wxtoolbartoolbase_getclientdata(wxToolBarToolBase * base) {
	void * data = base->GetClientData();
	if (data) {
		return (BBObject*)data;
	} else {
		return &bbNullObject;
	}
}

bool bmx_wxtoolbartoolbase_enable(wxToolBarToolBase * base, bool value) {
	return base->Enable(value);
}

void bmx_wxtoolbartoolbase_toggle(wxToolBarToolBase * base) {
	base->Toggle();
}

bool bmx_wxtoolbartoolbase_settoggle(wxToolBarToolBase * base, bool value) {
	return base->SetToggle(value);
}

bool bmx_wxtoolbartoolbase_setshorthelp(wxToolBarToolBase * base, BBString * help) {
	return base->SetShortHelp(wxStringFromBBString(help));
}

bool bmx_wxtoolbartoolbase_setlonghelp(wxToolBarToolBase * base, BBString * help) {
	return base->SetLongHelp(wxStringFromBBString(help));
}

void bmx_wxtoolbartoolbase_setnormalbitmap(wxToolBarToolBase * base, MaxBitmap * bitmap) {
	base->SetNormalBitmap(bitmap->Bitmap());
}

void bmx_wxtoolbartoolbase_setdisabledbitmap(wxToolBarToolBase * base, MaxBitmap * bitmap) {
	base->SetDisabledBitmap(bitmap->Bitmap());
}

void bmx_wxtoolbartoolbase_setlabel(wxToolBarToolBase * base, BBString * label) {
	base->SetLabel(wxStringFromBBString(label));
}

void bmx_wxtoolbartoolbase_setclientdata(wxToolBarToolBase * base, BBObject * data) {

	MaxObject * userData = (MaxObject *)base->GetClientData();
	if (userData) {
		delete userData;
		userData = 0;
	}

	if (data) {
		userData = new MaxObject(data);
	}

	base->SetClientData(userData);
}

void bmx_wxtoolbartoolbase_detach(wxToolBarToolBase * base) {
	base->Detach();
}

void bmx_wxtoolbartoolbase_attach(wxToolBarToolBase * base, wxToolBarBase * toolbar) {
	base->Attach(toolbar);
}



int bmx_wxtoolbar_geteventtype(int type) {
	switch(type) {
		case 9: return wxEVT_COMMAND_TOOL_CLICKED;
		case 16: return wxEVT_COMMAND_TOOL_RCLICKED;
		case 17: return wxEVT_COMMAND_TOOL_ENTER;
	}
	
	return 0;
}

// *********************************************

void bmx_wxtoolbar_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxToolBarXmlHandler);
}
