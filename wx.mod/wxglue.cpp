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

#include "wxglue.h"

typedef std::map<wxObject*, BBObject*> PeerMap;

static PeerMap peerMap;

void wxbind( wxObject *obj, BBObject *peer ) {
	if( !obj || peer==&bbNullObject ) return;
	peerMap.insert( std::make_pair( obj,peer ) );
	BBRETAIN( peer );
}

BBObject *wxfind( wxObject *obj ){
	if( !obj ) return &bbNullObject;
	PeerMap::iterator it = peerMap.find( obj );
	if( it != peerMap.end() ) return it->second;
	return &bbNullObject;
}

void wxunbind(wxObject *obj) {
	BBObject * peer = wxfind(obj);
	if (peer != &bbNullObject) {
		peerMap.erase(obj);
		BBRELEASE(peer);
	}
}


// Converts a wxString to a BBString
BBString *bbStringFromWxString(const wxString &s ) {
#ifdef WIN32
	return bbStringFromShorts((const BBChar*)s.wc_str(wxConvISO8859_1), s.Length());
#else
	return bbStringFromInts((const int*)s.wc_str(wxConvISO8859_1), s.Length());
#endif
}

// Converts a BBString to a wxString
wxString wxStringFromBBString(BBString * s) {
	return wxString( (char*)s->buf, wxMBConvUTF16(), s->length * 2 );
}

wxArrayString bbStringArrayTowxArrayStr( BBArray *p ){
	int n=p->scales[0];
	BBString **s=(BBString**)BBARRAYDATA( p,p->dims );
	wxString t[n];
	for( int i=0;i<n;++i ){
		t[i]=wxStringFromBBString( s[i] );
	}
	return wxArrayString( n,t );
}

BBArray *wxArrayStringToBBStringArray( wxArrayString t ){
	int n=t.GetCount();
	BBArray *p=bbArrayNew1D( "$",n );
	BBString **s=(BBString**)BBARRAYDATA( p,p->dims );
	for( int i=0;i<n;++i ){
		s[i]=bbStringFromWxString( t[i] );
		BBRETAIN( s[i] );
	}
	return p;
}

wxArrayInt bbIntArrayTowxArrayInt( BBArray *p ){
	int n=p->scales[0];
	int *s=(int*)BBARRAYDATA( p,p->dims );
	wxArrayInt arr;
	arr.Alloc(n);
	for( int i=0;i<n;++i ){
		arr.Add(s[i]);
	}
	return arr;
}

BBArray *wxArrayIntToBBIntArray( wxArrayInt t ){
	int n=t.GetCount();
	BBArray *p=bbArrayNew1D( "i",n );
	int *s=(int*)BBARRAYDATA( p,p->dims );
	for( int i=0;i<n;++i ){
		s[i]=t.Item(i);
	}
	return p;
}


void MaxApp::SetShouldLeave(bool should) {
	mShouldLeave = should;
}


IMPLEMENT_APP_NO_MAIN(MaxApp)
/*
wxMainEventLoop::wxMainEventLoop(MaxApp *maxApp) : wxEventLoop()
{
	mMaxApp = maxApp;
}

void wxMainEventLoop::OnExit()
{
	mMaxApp->SetShouldLeave(true);
}
*/

bool MaxApp::OnInit()
{
    if ( !wxApp::OnInit() ) {
        return false;
	}

    return _wx_wx_wxApp__OnInit();
}

/*
int MaxApp::OnRun()
{
	SetExitOnFrameDelete(true);

	wxMainEventLoop eventLoop(this);
	wxEventLoop::SetActive(&eventLoop);

	m_mainLoop = &eventLoop;

	for ( ; ; ) {

		while (!Pending() && ProcessIdle());

		while (Pending())
		{
			if (!Dispatch())
			{
				mShouldLeave = true;
				break;
			}
		}

		if (mShouldLeave)
		{
			while (Pending())
				Dispatch();
	
			m_mainLoop = NULL;
			return 0;
		}
	
//		if (mFrame)
//			mFrame->RenderFrame();
	
		wxMilliSleep(10); // dont take up 100% of cpu as usual
	}

	m_mainLoop = NULL;
	return 0;
}
*/

// ---------------------------------------------------------------------------------------

MaxMenu::MaxMenu(BBObject * handle, const wxString& title, long style)
	: maxHandle(handle), wxMenu(title, style)
{
	wxbind(this, handle);
}

MaxMenu::~MaxMenu() {
	wxunbind(this);
}


// ---------------------------------------------------------------------------------------

MaxWindow::MaxWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: maxHandle(handle), wxWindow(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxWindow::~MaxWindow() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxBoxSizer::MaxBoxSizer(BBObject * handle, int orient)
	: maxHandle(handle), wxBoxSizer(orient)
{
	wxbind(this, handle);
}

MaxBoxSizer::~MaxBoxSizer() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxColour::MaxColour()
	: colour(wxNullColour)
{
	colour = wxColour();
}

MaxColour::MaxColour(wxColour & col)
{
	colour = wxColour(col);
}

wxColour & MaxColour::Colour() {
	return colour;
}

// ---------------------------------------------------------------------------------------

MaxGridSizer::MaxGridSizer(BBObject * handle, int cols, int vgap, int hgap)
	: maxHandle(handle), wxGridSizer(cols, vgap, hgap)
{
	wxbind(this, handle);
}

MaxGridSizer::~MaxGridSizer() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxFlexGridSizer::MaxFlexGridSizer(BBObject * handle, int cols, int vgap, int hgap)
	: maxHandle(handle), wxFlexGridSizer(cols, vgap, hgap)
{
	wxbind(this, handle);
}

MaxFlexGridSizer::~MaxFlexGridSizer() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------


MaxFont::MaxFont()
	: font(wxNullFont)
{
}

MaxFont::MaxFont(const wxFont & f)
	: font(wxNullFont)
{
	font = wxFont(f);
}

wxFont & MaxFont::Font() {
	return font;
}

MaxFont::~MaxFont() {
//	delete &font;
}


// ---------------------------------------------------------------------------------------


wxDC * MaxDC::GetDC() {
	return dc;
}

void MaxDC::init(wxDC * _dc)
{
	dc = _dc;
}

MaxPaintDC::MaxPaintDC(wxWindow * window)
	: paintDC(window)
{
	MaxDC::init(&paintDC);
}

// ---------------------------------------------------------------------------------------

MaxBrush::MaxBrush()
	: brush(wxNullBrush)
{
	brush = wxBrush();
}

MaxBrush::MaxBrush(wxBrush & b)
{
	brush = wxBrush(b);
}

wxBrush & MaxBrush::Brush() {
	return brush;
}


// ---------------------------------------------------------------------------------------

MaxPen::MaxPen()
	: pen(wxNullPen)
{
	pen = wxPen();
}

MaxPen::MaxPen(wxPen & p)
{
	pen = wxPen(p);
}

wxPen & MaxPen::Pen() {
	return pen;
}


/*****************************************************************************************
	                                  Max interface
******************************************************************************************/

int bmx_app_wxentry() {
	static int i = 0;
	static const char *const empty = "";
	return wxEntry(i, (char **)&empty);
}

int bmx_wxapp_macexitmenuitemid() {
#ifdef __APPLE__
	return wxApp::s_macExitMenuItemId;
#else
	return 0;
#endif
}

void bmx_wxapp_settopwindow(wxWindow * window) {
	wxGetApp().SetTopWindow(window);
}

void bmx_wxapp_setappname(BBString * name) {
	wxGetApp().SetAppName(wxStringFromBBString(name));
}

bool bmx_wxapp_yield(bool onlyIfNeeded) {
	return wxGetApp().Yield(onlyIfNeeded);
}


// *********************************************

bool bmx_wxwindow_show(wxWindow * window, bool value) {
	return window->Show(value);
}

bool bmx_wxwindow_close(wxWindow * window, bool force) {
	return window->Close(force);
}

void bmx_wxwindow_setsizer(wxWindow * window, wxSizer * sizer, bool deleteOld) {
	window->SetSizer(sizer, deleteOld);
}

void bmx_wxwindow_setautolayout(wxWindow * window, bool autoLayout) {
	window->SetAutoLayout(autoLayout);
}

void bmx_wxwindow_delete(wxWindow * window) {
	delete window;
}

wxSizer * bmx_wxwindow_getsizer(wxWindow * window) {
	return window->GetSizer();
}

void bmx_wxwindow_layout(wxWindow * window){
	window->Layout();
}

long bmx_wxwindow_getwindowstyleflag(wxWindow * window) {
	return window->GetWindowStyleFlag();
}

void bmx_wxwindow_getbestsize(wxWindow * window, int * w, int * h) {
	wxSize size = window->GetBestSize();
	*w = size.x;
	*h = size.y;
}

void bmx_wxwindow_setfocus(wxWindow * window) {
	window->SetFocus();
}

void bmx_wxwindow_clearbackground(wxWindow * window) {
	window->ClearBackground();
}

void bmx_wxwindow_clienttoscreen(wxWindow * window, int * x, int * y) {
	window->ClientToScreen(x, y);
}

void bmx_wxwindow_setbackgroundcolour(wxWindow * window, MaxColour * colour) {
	window->SetBackgroundColour(colour->Colour());
}

void bmx_wxwindow_setforegroundcolour(wxWindow * window, MaxColour * colour) {
	window->SetForegroundColour(colour->Colour());
}

void bmx_wxwindow_setfont(wxWindow * window, MaxFont * font) {
	window->SetFont(font->Font());
}

MaxFont * bmx_wxwindow_getfont(wxWindow * window) {
	wxFont f(window->GetFont());
	return new MaxFont(f);
}

BBString * bmx_wxwindow_gethelptext(wxWindow * window) {
	return bbStringFromWxString(window->GetHelpText());
}

int bmx_wxwindow_getid(wxWindow * window) {
	return window->GetId();
}

BBString * bmx_wxwindow_getlabel(wxWindow * window) {
	return bbStringFromWxString(window->GetLabel());
}

void bmx_wxwindow_preparedc(wxWindow * window, MaxDC * dc) {
	window->PrepareDC(*dc->GetDC());
}

void bmx_wxwindow_refresh(wxWindow * window, bool erase) {
	window->Refresh(erase);
}

wxWindow * bmx_wxwindow_getparent(wxWindow * window) {
	return window->GetParent();
}

int bmx_wxwindow_getscrollpos(wxWindow * window, int orientation) {
	return window->GetScrollPos(orientation);
}

int bmx_wxwindow_getscrollrange(wxWindow * window, int orientation) {
	return window->GetScrollRange(orientation);
}

int bmx_wxwindow_getscrollthumb(wxWindow * window, int orientation) {
	return window->GetScrollThumb(orientation);
}

int bmx_wxwindow_getcharheight(wxWindow * window) {
	return window->GetCharHeight();
}

int bmx_wxwindow_getcharwidth(wxWindow * window) {
	return window->GetCharWidth();
}

void bmx_wxwindow_getclientsize(wxWindow * window, int * width, int * height) {
	window->GetClientSize(width, height);
}

MaxColour * bmx_wxwindow_getforegroundcolour(wxWindow * window) {
	wxColour c(window->GetForegroundColour());
	return new MaxColour(c);
}

wxWindow * bmx_wxwindow_getgrandparent(wxWindow * window) {
	return window->GetGrandParent();
}

BBString * bmx_wxwindow_gethelptextatpoint(wxWindow * window, int x, int y, wxHelpEvent::Origin origin) {
	return bbStringFromWxString(window->GetHelpTextAtPoint(wxPoint(x, y), origin));
}

void bmx_wxwindow_getmaxsize(wxWindow * window, int * w, int * h) {
	wxSize s = window->GetMaxSize();
	*w = s.x;
	*h = s.y;
}

void bmx_wxwindow_getminsize(wxWindow * window, int * w, int * h) {
	wxSize s = window->GetMinSize();
	*w = s.x;
	*h = s.y;
}

BBString * bmx_wxwindow_getname(wxWindow * window) {
	return bbStringFromWxString(window->GetName());
}

void bmx_wxwindow_getposition(wxWindow * window, int * x, int * y) {
	window->GetPosition(x, y);
}

void bmx_wxwindow_getrect(wxWindow * window, int * x, int * y, int * w, int * h) {
	wxRect r = window->GetRect();
	*x = r.x;
	*y = r.y;
	*w = r.width;
	*h = r.height;
}

void bmx_wxwindow_getscreenposition(wxWindow * window, int * x, int * y) {
	window->GetScreenPosition(x, y);
}

void bmx_wxwindow_getscreenrect(wxWindow * window, int * x, int * y, int * w, int * h) {
	wxRect r = window->GetScreenRect();
	*x = r.x;
	*y = r.y;
	*w = r.width;
	*h = r.height;
}

void bmx_wxwindow_getsize(wxWindow * window, int * w, int * h) {
	window->GetSize(w, h);
}

void bmx_wxwindow_sethelptext(wxWindow * window, BBString * helpText) {
	window->SetHelpText(wxStringFromBBString(helpText));
}

void bmx_wxwindow_setid(wxWindow * window, int id) {
	window->SetId(id);
}

void bmx_wxwindow_setlabel(wxWindow * window, BBString * label) {
	window->SetLabel(wxStringFromBBString(label));
}

void bmx_wxwindow_setscrollbar(wxWindow * window, int orientation, int position, int thumbsize, int range, bool refresh) {
	window->SetScrollbar(orientation, position, thumbsize, range, refresh);
}

void bmx_wxwindow_setscrollpos(wxWindow * window, int orientation, int pos, bool refresh) {
	window->SetScrollPos(orientation, pos, refresh);
}


// *********************************************

MaxMenu * bmx_wxmenu_create(BBObject * maxHandle, BBString * title, long style) {
	return new MaxMenu(maxHandle, wxStringFromBBString(title), style);
}

void bmx_wxmenu_append(MaxMenu * menu, int id, BBString * item, BBString * helpString, int kind) {
	menu->Append(id, wxStringFromBBString(item), wxStringFromBBString(helpString), kind);
}

void bmx_wxmenu_appendMenu(MaxMenu * menu, int id, BBString * item, MaxMenu * subMenu, BBString * helpString) {
	menu->Append(id, wxStringFromBBString(item), subMenu, wxStringFromBBString(helpString));
}

void bmx_wxmenu_appendseparator(MaxMenu * menu) {
	menu->AppendSeparator();
}

void bmx_wxmenu_appendcheckitem(MaxMenu * menu, int id, BBString * item, BBString * helpString) {
	menu->AppendCheckItem(id, wxStringFromBBString(item), wxStringFromBBString(helpString));
}

void bmx_wxmenu_appendradioitem(MaxMenu * menu, int id, BBString * item, BBString * helpString) {
	menu->AppendRadioItem(id, wxStringFromBBString(item), wxStringFromBBString(helpString));
}

void bmx_wxmenu_break(MaxMenu * menu) {
	menu->Break();
}



// *********************************************

MaxBoxSizer * bmx_wxboxsizer_create(BBObject * maxHandle, int orient) {
	return new MaxBoxSizer(maxHandle, orient);
}

wxSizerItem * bmx_wxsizer_add(wxSizer * sizer, wxWindow * window, int proportion, int flag, int border) {
	return sizer->Add(window, proportion, flag, border);
}

wxSizerItem * bmx_wxsizer_addsizer(wxSizer * sizer, wxSizer * sz, int proportion, int flag, int border) {
	return sizer->Add(sz, proportion, flag, border);
}

bool bmx_wxsizer_detach(wxSizer * sizer, wxWindow * window) {
	return sizer->Detach(window);
}

bool bmx_wxsizer_detachsizer(wxSizer * sizer, wxSizer * sz) {
	return sizer->Detach(sz);
}

wxSizerItem * bmx_wxsizer_insert(wxSizer * sizer, int index, wxWindow * window, int proportion, int flag, int border) {
	return sizer->Insert(index, window, proportion, flag, border);
}

wxSizerItem * bmx_wxsizer_insertsizer(wxSizer * sizer, int index, wxWindow * window, int proportion, int flag, int border) {
	return sizer->Insert(index, window, proportion, flag, border);
}

wxSizerItem * bmx_wxsizer_addcustomspacer(wxSizer * sizer, int width, int height, int proportion, int flag, int border) {
	return sizer->Add(width, height, proportion, flag, border);
}

wxSizerItem * bmx_wxsizer_addspacer(wxSizer * sizer, int size) {
	return sizer->AddSpacer(size);
}

wxSizerItem * bmx_wxsizer_addstretchspacer(wxSizer * sizer, int prop) {
	return sizer->AddStretchSpacer(prop);
}

void bmx_wxsizer_setitemminsize(wxSizer * sizer, int index, int width, int height) {
	sizer->SetItemMinSize(index, width, height);
}

void bmx_wxsizer_setitemminsizewindow(wxSizer * sizer, wxWindow * window, int width, int height) {
	sizer->SetItemMinSize(window, width, height);
}

void bmx_wxsizer_setitemminsizesizer(wxSizer * sizer, wxSizer * sz, int width, int height) {
	sizer->SetItemMinSize(sz, width, height);
}

MaxGridSizer * bmx_wxgridsizer_create(BBObject * maxHandle, int cols, int vgap, int hgap) {
	return new MaxGridSizer(maxHandle, cols, vgap, hgap);
}

int bmx_wxgridsizer_getcols(MaxGridSizer * sizer) {
	return sizer->GetCols();
}

int bmx_wxgridsizer_gethgap(MaxGridSizer * sizer) {
	return sizer->GetHGap();
}

int bmx_wxgridsizer_getrows(MaxGridSizer * sizer) {
	return sizer->GetRows();
}

int bmx_wxgridsizer_getvgap(MaxGridSizer * sizer) {
	return sizer->GetVGap();
}

void bmx_wxgridsizer_setcols(MaxGridSizer * sizer, int cols) {
	sizer->SetCols(cols);
}

void bmx_wxgridsizer_sethgap(MaxGridSizer * sizer, int hgap) {
	sizer->SetHGap(hgap);
}

void bmx_wxgridsizer_setrows(MaxGridSizer * sizer, int rows) {
	sizer->SetRows(rows);
}

void bmx_wxgridsizer_setvgap(MaxGridSizer * sizer, int vgap) {
	sizer->SetVGap(vgap);
}

void bmx_wxsizer_setsizehints(wxSizer * sizer, wxWindow * window) {
	sizer->SetSizeHints(window);
}

MaxFlexGridSizer * bmx_wxflexgridsizer_create(BBObject * maxHandle, int cols, int vgap, int hgap) {
	return new MaxFlexGridSizer(maxHandle, cols, vgap, hgap);
}

void bmx_wxflexgridsizer_addgrowablecol(MaxFlexGridSizer * sizer, int index, int prop) {
	sizer->AddGrowableCol(index, prop);
}

void bmx_wxflexgridsizer_addgrowablerow(MaxFlexGridSizer * sizer, int index, int prop) {
	sizer->AddGrowableRow(index, prop);
}




// *********************************************

wxArrayString * bmx_wxarraystring_create() {
	return new wxArrayString();
}

int bmx_wxarraystring_add(wxArrayString * arr, BBString * str, int copies) {
	return arr->Add(wxStringFromBBString(str), copies);
}

void bmx_wxarraystring_alloc(wxArrayString * arr, int count) {
	arr->Alloc(count);
}

void bmx_wxarraystring_delete(wxArrayString * arr) {
	delete arr;
}


// *********************************************

BBString * bmx_wxcontrol_getlabel(wxControl * control) {
	return bbStringFromWxString(control->GetLabel());
}

BBString * bmx_wxcontrol_getlabeltext(wxControl * control) {
	return bbStringFromWxString(control->GetLabelText());
}

void bmx_wxcontrol_setlabel(wxControl * control, BBString * label) {
	control->SetLabel(wxStringFromBBString(label));
}

// *********************************************

MaxObject::MaxObject(void * handle)
	: maxHandle(handle)
{
}

void * MaxObject::getHandle() {
	return maxHandle;
}


class MaxEventCallBack {
public:
	void EventThunker(wxEvent& event);
};

void MaxEventCallBack::EventThunker(wxEvent& event) {
	MaxObject*   cb = (MaxObject*)event.m_callbackUserData;
	_wx_wx_TEventHandler_eventCallback(event, cb->getHandle());
}


void bmx_wxevthandler_connectnoid(wxEvtHandler * evtHandler, wxEventType eventType, void * data) {

	MaxObject * userData = new MaxObject(data);
	
	evtHandler->Connect(eventType, (wxObjectEventFunction) &MaxEventCallBack::EventThunker, userData);
	
}

void bmx_wxevthandler_connect(wxEvtHandler * evtHandler, int id, wxEventType eventType, void * data) {

	MaxObject * userData = new MaxObject(data);
	
	evtHandler->Connect(id, eventType, (wxObjectEventFunction) &MaxEventCallBack::EventThunker, userData);
	
}

void bmx_wxevthandler_connectrange(wxEvtHandler * evtHandler, int id, int lastId, wxEventType eventType, void * data) {

	MaxObject * userData = new MaxObject(data);
	
	evtHandler->Connect(id, lastId, eventType, (wxObjectEventFunction) &MaxEventCallBack::EventThunker, userData);
	
}

void * bmx_event_geteventobject(wxEvent * evt) {

	MaxObject * data = (MaxObject*)evt->GetEventObject();
	return data;

}



int bmx_eventtype_value(int type) {

	switch(type) {
		case 3: return wxEVT_COMMAND_CHOICE_SELECTED;
		case 9: return wxEVT_COMMAND_MENU_SELECTED;
		case 10: return wxEVT_COMMAND_SLIDER_UPDATED;
		case 11: return wxEVT_COMMAND_RADIOBOX_SELECTED;
		case 12: return wxEVT_COMMAND_RADIOBUTTON_SELECTED;
		case 14: return wxEVT_COMMAND_VLBOX_SELECTED;
		case 15: return wxEVT_COMMAND_COMBOBOX_SELECTED;
		case 16: return wxEVT_COMMAND_TOOL_RCLICKED;
		case 17: return wxEVT_COMMAND_TOOL_ENTER;
		case 50: return wxEVT_SOCKET;
		case 80: return wxEVT_TIMER;
		case 100: return wxEVT_LEFT_DOWN;
		case 101: return wxEVT_LEFT_UP;
		case 102: return wxEVT_MIDDLE_DOWN;
		case 103: return wxEVT_MIDDLE_UP;
		case 104: return wxEVT_RIGHT_DOWN;
		case 105: return wxEVT_RIGHT_UP;
		case 106: return wxEVT_MOTION;
		case 107: return wxEVT_ENTER_WINDOW;
		case 108: return wxEVT_LEAVE_WINDOW;
		case 109: return wxEVT_LEFT_DCLICK;
		case 110: return wxEVT_MIDDLE_DCLICK;
		case 111: return wxEVT_RIGHT_DCLICK;
		case 112: return wxEVT_SET_FOCUS;
		case 113: return wxEVT_KILL_FOCUS;
		case 114: return wxEVT_CHILD_FOCUS;
		case 115: return wxEVT_MOUSEWHEEL;
		case 200: return wxEVT_NC_LEFT_DOWN;
		case 201: return wxEVT_NC_LEFT_UP;
		case 202: return wxEVT_NC_MIDDLE_DOWN;
		case 203: return wxEVT_NC_MIDDLE_UP;
		case 204: return wxEVT_NC_RIGHT_DOWN;
		case 205: return wxEVT_NC_RIGHT_UP;
		case 206: return wxEVT_NC_MOTION;
		case 207: return wxEVT_NC_ENTER_WINDOW;
		case 208: return wxEVT_NC_LEAVE_WINDOW;
		case 209: return wxEVT_NC_LEFT_DCLICK;
		case 210: return wxEVT_NC_MIDDLE_DCLICK;
		case 211: return wxEVT_NC_RIGHT_DCLICK;
		case 212: return wxEVT_CHAR;
		case 213: return wxEVT_CHAR_HOOK;
		case 214: return wxEVT_NAVIGATION_KEY;
		case 215: return wxEVT_KEY_DOWN;
		case 216: return wxEVT_KEY_UP;
		//case 217: return wxEVT_HOTKEY;
		case 230: return wxEVT_SET_CURSOR;
		case 300: return wxEVT_SCROLL_TOP;
		case 301: return wxEVT_SCROLL_BOTTOM;
		case 302: return wxEVT_SCROLL_LINEUP;
		case 303: return wxEVT_SCROLL_LINEDOWN;
		case 304: return wxEVT_SCROLL_PAGEUP;
		case 305: return wxEVT_SCROLL_PAGEDOWN;
		case 306: return wxEVT_SCROLL_THUMBTRACK;
		case 307: return wxEVT_SCROLL_THUMBRELEASE;
		case 308: return wxEVT_SCROLL_CHANGED;
		case 320: return wxEVT_SCROLLWIN_TOP;
		case 321: return wxEVT_SCROLLWIN_BOTTOM;
		case 322: return wxEVT_SCROLLWIN_LINEUP;
		case 323: return wxEVT_SCROLLWIN_LINEDOWN;
		case 324: return wxEVT_SCROLLWIN_PAGEUP;
		case 325: return wxEVT_SCROLLWIN_PAGEDOWN;
		case 326: return wxEVT_SCROLLWIN_THUMBTRACK;
		case 327: return wxEVT_SCROLLWIN_THUMBRELEASE;
		case 400: return wxEVT_SIZE;
		case 401: return wxEVT_MOVE;
		case 402: return wxEVT_CLOSE_WINDOW;
		case 403: return wxEVT_END_SESSION;
		case 404: return wxEVT_QUERY_END_SESSION;
		case 405: return wxEVT_ACTIVATE_APP;
		case 409: return wxEVT_ACTIVATE;
		case 410: return wxEVT_CREATE;
		case 411: return wxEVT_DESTROY;
		case 412: return wxEVT_SHOW;
		case 413: return wxEVT_ICONIZE;
		case 414: return wxEVT_MAXIMIZE;
		case 415: return wxEVT_MOUSE_CAPTURE_CHANGED;
		case 416: return wxEVT_MOUSE_CAPTURE_LOST;
		case 417: return wxEVT_PAINT;
		case 418: return wxEVT_ERASE_BACKGROUND;
		case 419: return wxEVT_NC_PAINT;
		case 420: return wxEVT_PAINT_ICON;
		case 421: return wxEVT_MENU_OPEN;
		case 422: return wxEVT_MENU_CLOSE;
		case 423: return wxEVT_MENU_HIGHLIGHT;
		case 424: return wxEVT_CONTEXT_MENU;
		case 425: return wxEVT_SYS_COLOUR_CHANGED;
		case 426: return wxEVT_DISPLAY_CHANGED;
		case 427: return wxEVT_SETTING_CHANGED;
		case 428: return wxEVT_QUERY_NEW_PALETTE;
		case 429: return wxEVT_PALETTE_CHANGED;
		case 430: return wxEVT_JOY_BUTTON_DOWN;
		case 431: return wxEVT_JOY_BUTTON_UP;
		case 432: return wxEVT_JOY_MOVE;
		case 433: return wxEVT_JOY_ZMOVE;
		case 434: return wxEVT_DROP_FILES;
		case 435: return wxEVT_DRAW_ITEM;
		case 436: return wxEVT_MEASURE_ITEM;
		case 437: return wxEVT_COMPARE_ITEM;
		case 438: return wxEVT_INIT_DIALOG;
		case 439: return wxEVT_IDLE;
		case 440: return wxEVT_UPDATE_UI;
		case 441: return wxEVT_SIZING;
		case 442: return wxEVT_MOVING;
		case 443: return wxEVT_HIBERNATE;
		case 444: return wxEVT_COMMAND_TEXT_COPY;
		case 445: return wxEVT_COMMAND_TEXT_CUT;
		case 446: return wxEVT_COMMAND_TEXT_PASTE;
		case 500: return wxEVT_COMMAND_LEFT_CLICK;
		case 501: return wxEVT_COMMAND_LEFT_DCLICK;
		case 502: return wxEVT_COMMAND_RIGHT_CLICK;
		case 503: return wxEVT_COMMAND_RIGHT_DCLICK;
		case 504: return wxEVT_COMMAND_SET_FOCUS;
		case 505: return wxEVT_COMMAND_KILL_FOCUS;
		case 506: return wxEVT_COMMAND_ENTER;
	}
	
	return 0;
}


int bmx_wxmessagebox(BBString * message, BBString * caption, int style, wxWindow * parent, int x, int y) {
	return wxMessageBox(wxStringFromBBString(message), wxStringFromBBString(caption), style, parent, x, y);
}

BBString * bmx_wxversion_string() {
	return bbStringFromWxString(wxString(wxVERSION_STRING));
}



BBString * bmx_wxgetosdescription() {
	return bbStringFromWxString(wxGetOsDescription());
}


BBString * bmx_wxcommandevent_getstring(wxCommandEvent & event) {
	return bbStringFromWxString(event.GetString());
}

bool bmx_wxcommandevent_ischecked(wxCommandEvent & event) {
	return event.IsChecked();
}


void bmx_wxnotifyevent_allow(wxNotifyEvent & event) {
	event.Allow();
}

void bmx_wxnotifyevent_veto(wxNotifyEvent & event) {
	event.Veto();
}

bool bmx_wxnotifyevent_isallowed(wxNotifyEvent & event) {
	return event.IsAllowed();
}

int bmx_wxcommandevent_getint(wxCommandEvent & event) {
	return event.GetInt();
}

int bmx_wxcommandevent_getselection(wxCommandEvent & event) {
	return event.GetSelection();
}

bool bmx_wxcommandevent_isselection(wxCommandEvent & event) {
	return event.IsSelection();
}

long bmx_wxcommandevent_getextralong(wxCommandEvent & event) {
	return event.GetExtraLong();
}

void bmx_wxmoveevent_getposition(wxMoveEvent & event, int * x, int * y) {
	wxPoint p = event.GetPosition();
	*x = p.x;
	*y = p.y;
}

void bmx_wxevent_skip(wxEvent & event, bool skip) {
	event.Skip(skip);
}

void bmx_wxsizeevent_getsize(wxSizeEvent & event, int * w, int * h) {
	wxSize s = event.GetSize();
	*w = s.x;
	*h = s.y;
}

wxEventType bmx_wxevent_geteventtype(wxEvent & event) {
	return event.GetEventType();
}

int bmx_wxevent_getid(wxEvent & event) {
	return event.GetId();
}

void bmx_wxupdateeventui_check(wxUpdateUIEvent & event, bool value) {
	event.Check(value);
}


// **************************


MaxColour * bmx_wxcolour_create(int r, int g, int b, int a) {
	wxColour c(r, g, b, a);
	return new MaxColour(c);
}

void bmx_wxcolour_delete(MaxColour * col) {
	delete col;
}

bool bmx_wxcolour_isok(MaxColour * col) {
	return col->Colour().IsOk();
}

int bmx_wxcolour_red(MaxColour * col) {
	return (int)col->Colour().Red();
}

int bmx_wxcolour_green(MaxColour * col) {
	return (int)col->Colour().Green();
}

int bmx_wxcolour_blue(MaxColour * col) {
	return (int)col->Colour().Blue();
}

int bmx_wxcolour_alpha(MaxColour * col) {
	return (int)col->Colour().Alpha();
}

BBString * bmx_wxcolour_getasstring(MaxColour * col, int flags) {
	return bbStringFromWxString(col->Colour().GetAsString(flags));
}

MaxColour * bmx_wxcolour_createnamedcolour(BBString * name) {
	wxColour c(wxStringFromBBString(name));
	return new MaxColour(c);
}


// **************************

MaxColour * bmx_wxstockgdi_colour_black() {
	wxColour c(*wxBLACK);
	return new MaxColour(c);
}

MaxColour * bmx_wxstockgdi_colour_blue() {
	wxColour c(*wxBLUE);
	return new MaxColour(c);
}

MaxColour * bmx_wxstockgdi_colour_cyan() {
	wxColour c(*wxCYAN);
	return new MaxColour(c);
}

MaxColour * bmx_wxstockgdi_colour_green() {
	wxColour c(*wxGREEN);
	return new MaxColour(c);
}

MaxColour * bmx_wxstockgdi_colour_lightgrey() {
	wxColour c(*wxLIGHT_GREY);
	return new MaxColour(c);
}

MaxColour * bmx_wxstockgdi_colour_red() {
	wxColour c(*wxRED);
	return new MaxColour(c);
}

MaxColour * bmx_wxstockgdi_colour_white() {
	wxColour c(*wxWHITE);
	return new MaxColour(c);
}

MaxFont * bmx_wxstockgdi_font_italic() {
	wxFont f(*wxITALIC_FONT);
	return new MaxFont(f);
}

MaxFont * bmx_wxstockgdi_font_normal() {
	wxFont f(*wxNORMAL_FONT);
	return new MaxFont(f);
}

MaxFont * bmx_wxstockgdi_font_small() {
	wxFont f(*wxSMALL_FONT);
	return new MaxFont(f);
}

MaxFont * bmx_wxstockgdi_font_swiss() {
	wxFont f(*wxSWISS_FONT);
	return new MaxFont(f);
}


// **************************

void bmx_wxfont_delete(MaxFont * font) {
	delete font;
}

int bmx_wxfont_getpointsize(MaxFont * font) {
	return font->Font().GetPointSize();
}

void bmx_wxfont_setpointsize(MaxFont * font, int size) {
	font->Font().SetPointSize(size);
}

bool bmx_wxfont_isfixedwidth(MaxFont * font) {
	return font->Font().IsFixedWidth();
}

wxFontEncoding bmx_wxfont_getdefaultencoding() {
	return wxFont::GetDefaultEncoding();
}

BBString * bmx_wxfont_getfacename(MaxFont * font) {
	bbStringFromWxString(font->Font().GetFaceName());
}

int bmx_wxfont_getfamily(MaxFont * font) {
	return font->Font().GetFamily();
}

BBString * bmx_wxfont_getfamilystring(MaxFont * font) {
	return bbStringFromWxString(font->Font().GetFamilyString());
}

BBString * bmx_wxfont_getnativefontinfodesc(MaxFont * font) {
	return bbStringFromWxString(font->Font().GetNativeFontInfoDesc());
}

BBString * bmx_wxfont_getnativefontinfouserdesc(MaxFont * font) {
	return bbStringFromWxString(font->Font().GetNativeFontInfoUserDesc());
}

int bmx_wxfont_getstyle(MaxFont * font) {
	return font->Font().GetStyle();
}

bool bmx_wxfont_getunderlined(MaxFont * font) {
	return font->Font().GetUnderlined();
}

int bmx_wxfont_getweight(MaxFont * font) {
	return font->Font().GetWeight();
}

bool bmx_wxfont_isok(MaxFont * font) {
	return font->Font().IsOk();
}

wxFontEncoding bmx_wxfont_getencoding(MaxFont * font) {
	return font->Font().GetEncoding();
}

BBString * bmx_wxfont_getstylestring(MaxFont * font) {
	return bbStringFromWxString(font->Font().GetStyleString());
}

BBString * bmx_wxfont_getweightstring(MaxFont * font) {
	return bbStringFromWxString(font->Font().GetWeightString());
}

void bmx_wxfont_setstyle(MaxFont * font, int style) {
	font->Font().SetStyle(style);
}

void bmx_wxfont_setunderlined(MaxFont * font, bool underlined) {
	font->Font().SetUnderlined(underlined);
}

void bmx_wxfont_setweight(MaxFont * font, int weight) {
	font->Font().SetWeight(weight);
}



// *********************************************

BEGIN_EVENT_TABLE(MaxWindow, wxWindow)
END_EVENT_TABLE()

MaxWindow * bmx_wxwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxWindow(maxHandle, parent, id, x, y, w, h, style);
}

// *********************************************

MaxPaintDC * bmx_wxpaintdc_create(wxWindow * window) {
	return new MaxPaintDC(window);
}

void bmx_wxpaintdc_delete(MaxPaintDC * dc) {
	delete dc;
}

// *********************************************

MaxBrush * bmx_wxbrush_create(BBString * name, int style) {
	wxBrush b(wxStringFromBBString(name), style);
	return new MaxBrush(b);
}

void bmx_wxbrush_delete(MaxBrush * brush) {
	delete brush;
}

// *********************************************

void bmx_wxdc_clear(MaxDC * dc) {
	dc->GetDC()->Clear();
}

void bmx_wxdc_setbackground(MaxDC * dc, MaxBrush * brush) {
	dc->GetDC()->SetBackground(brush->Brush());
}

void bmx_wxdc_drawtext(MaxDC * dc, BBString * text, int x, int y) {
	dc->GetDC()->DrawText(wxStringFromBBString(text), x, y);
}

int bmx_wxdc_getcharheight(MaxDC * dc) {
	return dc->GetDC()->GetCharHeight();
}

void bmx_wxdc_setfont(MaxDC * dc, MaxFont * font) {
	dc->GetDC()->SetFont(font->Font());
}

void bmx_wxdc_settextbackground(MaxDC * dc, MaxColour * colour) {
	dc->GetDC()->SetTextBackground(colour->Colour());
}

void bmx_wxdc_settextforeground(MaxDC * dc, MaxColour * colour) {
	dc->GetDC()->SetTextForeground(colour->Colour());
}

void bmx_wxdc_gettextextent(MaxDC * dc, BBString * text, int * w, int * h) {
	wxSize s = dc->GetDC()->GetTextExtent(wxStringFromBBString(text));
	*w = s.x;
	*h = s.y;
}

void bmx_wxdc_setmapmode(MaxDC * dc, int mode) {
	dc->GetDC()->SetMapMode(mode);
}

void bmx_wxdc_setpen(MaxDC * dc, MaxPen * pen) {
	dc->GetDC()->SetPen(pen->Pen());
}

void bmx_wxdc_setuserscale(MaxDC * dc, double xscale, double yscale) {
	dc->GetDC()->SetUserScale(xscale, yscale);
}

void bmx_wxdc_drawline(MaxDC * dc, int x1, int y1, int x2, int y2) {
	dc->GetDC()->DrawLine(x1, y1, x2, y2);
}

// *********************************************

wxFontEncoding bmx_wxfontmapper_getencoding(int n) {
	return wxFontMapper::GetEncoding(n);
}

BBString * bmx_wxfontmapper_getencodingdescription(wxFontEncoding encoding) {
	return bbStringFromWxString(wxFontMapper::GetEncodingDescription(encoding));
}

BBString * bmx_wxfontmapper_getencodingname(wxFontEncoding encoding) {
	return bbStringFromWxString(wxFontMapper::GetEncodingName(encoding));
}

int bmx_wxfontmapper_getsupportedencodingcount() {
	return wxFontMapper::GetSupportedEncodingsCount();
}

// *********************************************

MaxPen * bmx_wxpen_create(BBString * name, int width, int style) {
	wxPen p(wxStringFromBBString(name), width, style);
	return new MaxPen(p);
}

MaxPen * bmx_wxpen_createfromcolour(MaxColour * colour, int width, int style) {
	wxPen p(colour->Colour(), width, style);
	return new MaxPen(p);
}

void bmx_wxpen_delete(MaxPen * pen) {
	delete pen;
}

// *********************************************

MaxPen * bmx_wxstockgdi_pen_blackdashed() {
	wxPen p(*wxBLACK_DASHED_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_black() {
	wxPen p(*wxBLACK_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_cyan() {
	wxPen p(*wxCYAN_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_green() {
	wxPen p(*wxGREEN_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_grey() {
	wxPen p(*wxGREY_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_lightgrey() {
	wxPen p(*wxLIGHT_GREY_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_mediumgrey() {
	wxPen p(*wxMEDIUM_GREY_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_red() {
	wxPen p(*wxRED_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_transparent() {
	wxPen p(*wxTRANSPARENT_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_white() {
	wxPen p(*wxWHITE_PEN);
	return new MaxPen(p);
}


