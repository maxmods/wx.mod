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
        if ( !m_toolbar )
        {
            ReportError("tool only allowed inside a wxToolBar");
            return NULL;
        }

        wxItemKind kind = wxITEM_NORMAL;
        if (GetBool(wxT("radio")))
            kind = wxITEM_RADIO;

        if (GetBool(wxT("toggle")))
        {
            if ( kind != wxITEM_NORMAL )
            {
                ReportParamError
                (
                    "toggle",
                    "tool can't have both <radio> and <toggle> properties"
                );
            }

            kind = wxITEM_CHECK;
        }

        // check whether we have dropdown tag inside
        wxMenu *menu = NULL; // menu for drop down items
        wxXmlNode * const nodeDropdown = GetParamNode("dropdown");
        if ( nodeDropdown )
        {
            if ( kind != wxITEM_NORMAL )
            {
                ReportParamError
                (
                    "dropdown",
                    "drop-down tool can't have neither <radio> nor <toggle> properties"
                );
            }

            kind = wxITEM_DROPDOWN;

            // also check for the menu specified inside dropdown (it is
            // optional and may be absent for e.g. dynamically-created
            // menus)
            wxXmlNode * const nodeMenu = nodeDropdown->GetChildren();
            if ( nodeMenu )
            {
                wxObject *res = CreateResFromNode(nodeMenu, NULL);
                menu = wxDynamicCast(res, wxMenu);
                if ( !menu )
                {
                    ReportError
                    (
                        nodeMenu,
                        "drop-down tool contents can only be a wxMenu"
                    );
                }

                if ( nodeMenu->GetNext() )
                {
                    ReportError
                    (
                        nodeMenu->GetNext(),
                        "unexpected extra contents under drop-down tool"
                    );
                }
            }
        }

        wxToolBarToolBase * const tool =
            m_toolbar->AddTool
                       (
                          GetID(),
                          GetText(wxT("label")),
                          GetBitmap(wxT("bitmap"), wxART_TOOLBAR, m_toolSize),
                          GetBitmap(wxT("bitmap2"), wxART_TOOLBAR, m_toolSize),
                          kind,
                          GetText(wxT("tooltip")),
                          GetText(wxT("longhelp"))
                       );

        if ( GetBool(wxT("disabled")) )
            m_toolbar->EnableTool(GetID(), false);

        if ( GetBool(wxS("checked")) )
        {
            if ( kind == wxITEM_NORMAL )
            {
                ReportParamError
                (
                    "checked",
                    "only <radio> nor <toggle> tools can be checked"
                );
            }
            else
            {
                m_toolbar->ToggleTool(GetID(), true);
            }
        }

        if ( menu )
            tool->SetDropdownMenu(menu);

        return m_toolbar; // must return non-NULL
    }

    else if (m_class == wxT("separator") || m_class == wxT("space"))
    {
        if ( !m_toolbar )
        {
            ReportError("separators only allowed inside wxToolBar");
            return NULL;
        }

        if ( m_class == wxT("separator") )
            m_toolbar->AddSeparator();
        else
            m_toolbar->AddStretchableSpace();

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
        SetupWindow(toolbar);

		toolbar->MaxBind(_wx_wxtoolbar_wxToolBar__xrcNew(toolbar));

        m_toolSize = GetSize(wxT("bitmapsize"));
        if (!(m_toolSize == wxDefaultSize))
            toolbar->SetToolBitmapSize(m_toolSize);
        wxSize margins = GetSize(wxT("margins"));
        if (!(margins == wxDefaultSize))
            toolbar->SetMargins(margins.x, margins.y);
        long packing = GetLong(wxT("packing"), -1);
        if (packing != -1)
            toolbar->SetToolPacking(packing);
        long separation = GetLong(wxT("separation"), -1);
        if (separation != -1)
            toolbar->SetToolSeparation(separation);

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
                    !IsOfClass(n, wxT("space")) &&
                    control != NULL)
                    toolbar->AddControl(control);
            }
            n = n->GetNext();
        }

        m_isInside = false;
        m_toolbar = NULL;

        if (m_parentAsWindow && !GetBool(wxT("dontattachtoframe")))
        {
            wxFrame *parentFrame = wxDynamicCast(m_parent, wxFrame);
            if (parentFrame)
                parentFrame->SetToolBar(toolbar);
        }

        toolbar->Realize();

        return toolbar;
    }
}

bool MaxToolBarXmlHandler::CanHandle(wxXmlNode *node)
{
    return ((!m_isInside && IsOfClass(node, wxT("wxToolBar"))) ||
            (m_isInside && IsOfClass(node, wxT("tool"))) ||
            (m_isInside && IsOfClass(node, wxT("space"))) ||
            (m_isInside && IsOfClass(node, wxT("separator"))));
}


// *********************************************

void bmx_wxtoolbar_injectSelf(MaxToolBar * toolbar, BBObject * handle) {
	toolbar->injectSelf(handle);
}

MaxToolBar * bmx_wxtoolbar_create(BBObject * maxHandle, wxWindow* parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxToolBar(maxHandle, parent, id, x, y, w, h, style);
}

void bmx_wxtoolbar_addcontrol(wxToolBar * toolbar, wxControl * control, BBString * label) {
	toolbar->AddControl(control, wxStringFromBBString(label));
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

int bmx_wxtoolbar_realize(wxToolBar * toolbar) {
	return static_cast<int>(toolbar->Realize());
}

void bmx_wxtoolbar_settoolbitmapsize(wxToolBar * toolbar, int w, int h) {
	toolbar->SetToolBitmapSize(wxSize(w, h));
}


void bmx_wxtoolbar_cleartools(wxToolBar * toolbar) {
	toolbar->ClearTools();
}

int bmx_wxtoolbar_deletetool(wxToolBar * toolbar, int toolId) {
	return static_cast<int>(toolbar->DeleteTool(toolId));
}

int bmx_wxtoolbar_deletetoolbypos(wxToolBar * toolbar, int pos) {
	return static_cast<int>(toolbar->DeleteToolByPos(pos));
}

void bmx_wxtoolbar_enabletool(wxToolBar * toolbar, int toolId, int enable) {
	toolbar->EnableTool(toolId, static_cast<bool>(enable));
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

int bmx_wxtoolbar_gettoolenabled(wxToolBar * toolbar, int toolId) {
	return static_cast<int>(toolbar->GetToolEnabled(toolId));
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

int bmx_wxtoolbar_gettoolstate(wxToolBar * toolbar, int toolId) {
	return static_cast<int>(toolbar->GetToolState(toolId));
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

void bmx_wxtoolbar_toggletool(wxToolBar * toolbar, int id, int toggle) {
	toolbar->ToggleTool(id, static_cast<bool>(toggle));
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


int bmx_wxtoolbartoolbase_isbutton(wxToolBarToolBase * base) {
	return static_cast<int>(base->IsButton());
}

int bmx_wxtoolbartoolbase_iscontrol(wxToolBarToolBase * base) {
	return static_cast<int>(base->IsControl());
}

int bmx_wxtoolbartoolbase_isseparator(wxToolBarToolBase * base) {
	return static_cast<int>(base->IsSeparator());
}

int bmx_wxtoolbartoolbase_getstyle(wxToolBarToolBase * base) {
	return base->GetStyle();
}

wxItemKind bmx_wxtoolbartoolbase_getkind(wxToolBarToolBase * base) {
	return base->GetKind();
}

int bmx_wxtoolbartoolbase_isenabled(wxToolBarToolBase * base) {
	return static_cast<int>(base->IsEnabled());
}

int bmx_wxtoolbartoolbase_istoggled(wxToolBarToolBase * base) {
	return static_cast<int>(base->IsToggled());
}

int bmx_wxtoolbartoolbase_canbetoggled(wxToolBarToolBase * base) {
	return static_cast<int>(base->CanBeToggled());
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

int bmx_wxtoolbartoolbase_enable(wxToolBarToolBase * base, int value) {
	return static_cast<int>(base->Enable(static_cast<bool>(value)));
}

void bmx_wxtoolbartoolbase_toggle(wxToolBarToolBase * base) {
	base->Toggle();
}

int bmx_wxtoolbartoolbase_settoggle(wxToolBarToolBase * base, int value) {
	return static_cast<int>(base->SetToggle(static_cast<bool>(value)));
}

int bmx_wxtoolbartoolbase_setshorthelp(wxToolBarToolBase * base, BBString * help) {
	return static_cast<int>(base->SetShortHelp(wxStringFromBBString(help)));
}

int bmx_wxtoolbartoolbase_setlonghelp(wxToolBarToolBase * base, BBString * help) {
	return static_cast<int>(base->SetLongHelp(wxStringFromBBString(help)));
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
