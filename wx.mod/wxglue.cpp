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

#include "wxglue.h"

#undef EVENTS_DEBUG

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
#ifndef BMX_NG
		_wx_wx_wxObject__Free(peer);
#else
		wx_wx_base_wxObject__Free(peer);
#endif
		BBRELEASE(peer);
	}
}


// Converts a wxString to a BBString
BBString *bbStringFromWxString(const wxString &s ) {
#ifdef WIN32
	return bbStringFromShorts((const BBChar*)s.wc_str(wxConvISO8859_1), s.Length());
#else
#ifdef wxUSE_UNICODE_UTF8
	return bbStringFromInts((const int*)s.wc_str(wxConvISO8859_1), s.Length());
#else
	return bbStringFromInts((const int*)s.wc_str(wxConvISO8859_1).data(), s.Length());
#endif
#endif
}

// Converts a BBString to a wxString
wxString wxStringFromBBString(BBString * s) {
	return wxString( (char*)s->buf, wxMBConvUTF16(), s->length * 2 );
}

wxArrayString bbStringArrayTowxArrayStr( BBArray *p ){
	int n=p->scales[0];
	BBString **s=(BBString**)BBARRAYDATA( p,p->dims );
	wxArrayString arr;
	arr.Alloc(n);
	for( int i=0;i<n;++i ){
		arr.Add(wxStringFromBBString( s[i] ));
	}
	return arr;
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

wxArrayDouble bbDoubleArrayTowxArrayDouble( BBArray *p ){
	int n=p->scales[0];
	double *s=(double*)BBARRAYDATA( p,p->dims );
	wxArrayDouble arr;
	arr.Alloc(n);
	for( int i=0;i<n;++i ){
		arr.Add(s[i]);
	}
	return arr;
}

BBArray *wxArrayDoubleToBBDoubleArray( wxArrayDouble t ){
	int n=t.GetCount();
	BBArray *p=bbArrayNew1D( "d",n );
	double *s=(double*)BBARRAYDATA( p,p->dims );
	for( int i=0;i<n;++i ){
		s[i]=t.Item(i);
	}
	return p;
}

wxIMPLEMENT_APP_NO_MAIN(MaxApp);

bool MaxApp::OnInit()
{
#ifdef EVENTS_DEBUG
	printf("MaxApp::OnInit()\n");fflush(stdout);
#endif
    if ( !wxApp::OnInit() ) {
        return false;
	}

    return CB_PREF(wx_wxapp_wxApp__OnInit)();
}

int MaxApp::OnExit()
{
#ifdef EVENTS_DEBUG
	printf("MaxApp::OnExit()\n");fflush(stdout);
#endif
	return CB_PREF(wx_wxapp_wxApp__OnExit)();
}


bool MaxApp::ownMain = false;


int MaxApp::MainLoop() {
	if (!ownMain) {
		return wxApp::MainLoop();
	}
	
	SetExitOnFrameDelete(true);
	eventLoop = m_mainLoop = GetTraits()->CreateEventLoop();
	wxEventLoopBase::SetActive(m_mainLoop);
	
	return CB_PREF(wx_wxapp_wxAppMain__MainLoop)();
}

#ifdef __WXOSX__
void MaxApp::MacOpenFiles(const wxArrayString & fileNames) {
	
}
#endif

#ifdef __WXOSX__
#include "wx/osx/private.h"
#endif

void doEmitEvent(wxEvent& event) {
	bool checkEvent = false;

#ifdef __APPLE__

//	if (CGDisplayIsCaptured( kCGDirectMainDisplay )) {
//		checkEvent = true;
//	}
#endif

	if (checkEvent) {
	
		// nothing to see here! - yet...
	
	}
}

static int _oldX;
static int _oldY;
static bool _oldLeftDown = false;
static bool _oldMiddleDown = false;
static bool _oldRightDown = false;
static bool _mods;

#define _MOUSEMOVE  0x0001
#define _MOUSELDOWN 0x0002
#define _MOUSEMDOWN 0x0004
#define _MOUSERDOWN 0x0008
#define _MOUSELUP   0x0010
#define _MOUSEMUP   0x0020
#define _MOUSERUP   0x0040

void bmx_wxapp_pollevents() {
	int eventsRequired = 0;

	wxMouseState state = wxGetMouseState();
	
	if (_oldX != state.GetX() || _oldY != state.GetY()) {
		_oldX = state.GetX();
		_oldY = state.GetY();
		eventsRequired |= _MOUSEMOVE;
	}
	
	if (_oldLeftDown != state.LeftDown()) {
		if (_oldLeftDown) {
			eventsRequired |= _MOUSELUP;
		} else {
			eventsRequired |= _MOUSELDOWN;
		}
		_oldLeftDown = !_oldLeftDown;
	}

	if (_oldMiddleDown != state.MiddleDown()) {
		if ( _oldMiddleDown) {
			eventsRequired |= _MOUSEMUP;
		} else {
			eventsRequired |= _MOUSEMDOWN;
		}
		_oldMiddleDown = !_oldMiddleDown;
	}

	if (_oldRightDown != state.RightDown()) {
		if (_oldRightDown) {
			eventsRequired |= _MOUSERUP;
		} else {
			eventsRequired |= _MOUSERDOWN;
		}
		_oldRightDown = !_oldRightDown;
	}

	if (!eventsRequired) return;
	
	_mods = 0;
	if (state.ShiftDown()) _mods |= 1;
	if (state.ControlDown()) _mods |= 2;
	if (state.AltDown()) _mods |= 4;
	if (state.CmdDown()) _mods |= 8;

	if (	eventsRequired & _MOUSEMOVE) {
		bbSystemEmitEvent( BBEVENT_MOUSEMOVE,&bbNullObject,
			(_oldLeftDown) ? 1 : (_oldRightDown) ? 2 : (_oldMiddleDown) ? 3 : 0,
			_mods,_oldX,_oldY,&bbNullObject );
	}
	if (	eventsRequired & _MOUSELDOWN) {
		bbSystemEmitEvent( BBEVENT_MOUSEDOWN,&bbNullObject,1,_mods,_oldX,_oldY,&bbNullObject );
	}
	if (	eventsRequired & _MOUSERDOWN) {
		bbSystemEmitEvent( BBEVENT_MOUSEDOWN,&bbNullObject,2,_mods,_oldX,_oldY,&bbNullObject );
	}
	if (	eventsRequired & _MOUSEMDOWN) {
		bbSystemEmitEvent( BBEVENT_MOUSEDOWN,&bbNullObject,3,_mods,_oldX,_oldY,&bbNullObject );
	}
	if (	eventsRequired & _MOUSELUP) {
		bbSystemEmitEvent( BBEVENT_MOUSEUP,&bbNullObject,1,_mods,_oldX,_oldY,&bbNullObject );
	}
	if (	eventsRequired & _MOUSERUP) {
		bbSystemEmitEvent( BBEVENT_MOUSEUP,&bbNullObject,2,_mods,_oldX,_oldY,&bbNullObject );
	}
	if (	eventsRequired & _MOUSEMUP) {
		bbSystemEmitEvent( BBEVENT_MOUSEUP,&bbNullObject,3,_mods,_oldX,_oldY,&bbNullObject );
	}
}

/*
void bbSystemEmitOSEvent( NSEvent *event,NSView *view,BBObject *source ){
	int inView;
	NSEventType type;
	NSString *characters;
	int ev=0,data=0,x=0,y=0,oldMods,mask;
	float f;

	type=[event type];

	switch( type ){
	case NSKeyDown:
		if( data=bbSystemTranslateKey( [event keyCode] ) ){
			ev=[event isARepeat] ? BBEVENT_KEYREPEAT : BBEVENT_KEYDOWN;
			bbSystemEmitEvent( ev,source,data,bbSystemTranslateMods(mods),0,0,&bbNullObject );
		}
		characters=[event characters];
		if( [characters length]!=1 ) return;
		data=[characters characterAtIndex:0];
		if( data>=0xf700 && data<=0xf8ff ) return;
		ev=BBEVENT_KEYCHAR;
		data=bbSystemTranslateChar( data );
		break;
	case NSKeyUp:
		data=bbSystemTranslateKey( [event keyCode] );
		if( !data ) return;
		ev=BBEVENT_KEYUP;
		break;
	case NSFlagsChanged:
		oldMods=mods;
		mods=[event modifierFlags];
		deltaMods=mods^oldMods;
		if( deltaMods & (mask=LSHIFTMASK) ) data=KEY_LSHIFT;
		else if( deltaMods & (mask=RSHIFTMASK) ) data=KEY_RSHIFT;
		else if( deltaMods & (mask=LCTRLMASK) ) data=KEY_LCONTROL;
		else if( deltaMods & (mask=RCTRLMASK) ) data=KEY_RCONTROL;
		else if( deltaMods & (mask=LALTMASK) ) data=KEY_LALT;
		else if( deltaMods & (mask=RALTMASK) ) data=KEY_RALT;
		else if( deltaMods & (mask=LSYSMASK) ) data=KEY_LSYS;
		else if( deltaMods & (mask=RSYSMASK) ) data=KEY_RSYS;
		if( !data ) return;
		ev=(mods & mask) ? BBEVENT_KEYDOWN : BBEVENT_KEYUP;
		break;
	case NSLeftMouseDown:
	case NSRightMouseDown:
	case NSOtherMouseDown:
		inView=mouseViewPos( view,&x,&y );
		if( !inView ) return;
		setMouseView( view,x,y,source );
		capturedView=mouseView;
		ev=BBEVENT_MOUSEDOWN;
		data=(type==NSLeftMouseDown) ? 1 : (type==NSRightMouseDown ? 2 : 3);
		break;
	case NSLeftMouseUp:
	case NSRightMouseUp:
	case NSOtherMouseUp:
		inView=mouseViewPos( view,&x,&y );
		if( !inView && !capturedView ) return;
		capturedView=0;
		ev=BBEVENT_MOUSEUP;
		data=(type==NSLeftMouseUp) ? 1 : (type==NSRightMouseUp ? 2 : 3);
		break;
	case NSMouseMoved:
	case NSLeftMouseDragged:
	case NSRightMouseDragged:
	case NSOtherMouseDragged:
		inView=mouseViewPos( view,&x,&y );
		setMouseView( inView ? view : 0,x,y,source );
		if( !inView && !capturedView ) return;
		ev=BBEVENT_MOUSEMOVE;
		data=(type==NSLeftMouseDragged) ? 1 : (type==NSRightMouseDragged ? 2 : (type==NSOtherMouseDragged ? 3 : 0));
		break;
	case NSScrollWheel:
		inView=mouseViewPos( view,&x,&y );
		if( !inView && view!=capturedView ) return;
		ev=BBEVENT_MOUSEWHEEL;
		f=[event deltaY];
		data=f>0 ? ceil(f) : floor(f);
		break;
	default:
		return;
	}
	bbSystemEmitEvent( ev,source,data,bbSystemTranslateMods(mods),x,y,&bbNullObject );
}
*/

int MaxApp::FilterEvent(wxEvent& event) {
	if (!ownMain) {
		return -1;
	}
	
	doEmitEvent(event);
	
	return -1;
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

MaxColour::MaxColour()
	: colour(wxNullColour)
{
	colour = wxColour();
}

MaxColour::MaxColour(wxColour & col)
	: colour(col)
{
}

wxColour & MaxColour::Colour() {
	return colour;
}

// ---------------------------------------------------------------------------------------


MaxFont::MaxFont()
	: font(wxNullFont)
{
}

MaxFont::MaxFont(const wxFont & f)
	: font(f)
{
}

wxFont & MaxFont::Font() {
	return font;
}

MaxFont::~MaxFont() {
//	delete &font;
}


// ---------------------------------------------------------------------------------------

MaxDC::MaxDC()
{
}

MaxDC::MaxDC(wxDC & dc)
{
	init(&dc);
}

wxDC * MaxDC::GetDC() {
	return dc;
}

void MaxDC::init(wxDC * _dc)
{
	dc = _dc;
	owner = false;
}

MaxPaintDC::MaxPaintDC(wxWindow * window)
	: paintDC(window)
{
	MaxDC::init(&paintDC);
}

//MaxWindowDC::MaxWindowDC()
//	: windowDC(NULL)
//{}

MaxWindowDC::MaxWindowDC(wxWindow * window)
	: windowDC(window)
{
	MaxDC::init(&windowDC);
}

MaxDC::MaxDC(wxDC * _dc)
{
	dc = _dc;
	owner = true;
}

MaxDC::~MaxDC() {
	if (owner) {
		delete dc;
	}
}

// ---------------------------------------------------------------------------------------

MaxRect::MaxRect(const wxRect & r)
{
	rect = r;
}

wxRect & MaxRect::Rect() {
	return rect;
}

MaxRect::~MaxRect() {
}

// ---------------------------------------------------------------------------------------

BEGIN_EVENT_TABLE(MaxEvtHandler, wxEvtHandler)
END_EVENT_TABLE()

MaxEvtHandler::MaxEvtHandler(BBObject * handle)
{
	wxbind(this, handle);
}

MaxEvtHandler::~MaxEvtHandler() {
	wxunbind(this);
}

/*****************************************************************************************
	                                  Max interface
******************************************************************************************/

BEGIN_EVENT_TABLE(MaxApp, wxApp)
END_EVENT_TABLE()


int bmx_app_wxentry() {
#ifdef EVENTS_DEBUG
	printf("bmx_app_wxentry()\n");fflush(stdout);
#endif
	static int i = 0;
	static const char *const empty = "";
	return wxEntry(i, (char **)&empty);
}

int bmx_app_wxentrystart() {
#ifdef EVENTS_DEBUG
	printf("bmx_app_wxentrystart()\n");fflush(stdout);
#endif
	static int i = 0;
	static const char *const empty = "";
	int res = wxEntryStart(i, (char **)&empty);
	wxTheApp->CallOnInit();
	return res;
}

int bmx_wxapp_macexitmenuitemid() {
#ifdef __APPLE__
	return wxID_EXIT;
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

void bmx_wxapp_setownmain() {
	MaxApp::ownMain = true;
}

bool bmx_wxapp_dispatch() {
	return wxGetApp().Dispatch();
}

int bmx_wxapp_pending() {
	return wxGetApp().Pending();
}

bool bmx_wxapp_processidle() {
	return wxGetApp().ProcessIdle();
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


MaxObject::MaxObject(void * handle)
	: maxHandle(handle)
{
}

MaxObject::~MaxObject()
{
#ifndef BMX_NG
	_wx_wx_TEventHandler__nullref(maxHandle);
#else
	wx_wx_events_TEventHandler__nullref(maxHandle);
#endif
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
#ifndef BMX_NG
	_wx_wx_TEventHandler_eventCallback(event, cb->getHandle());
#else
	wx_wx_events_TEventHandler_eventCallback(event, cb->getHandle());
#endif
}


void bmx_wxevthandler_connectnoid(wxEvtHandler * evtHandler, wxEventType eventType, MaxObject * data) {

	evtHandler->Connect(eventType, (wxObjectEventFunction) &MaxEventCallBack::EventThunker, data);
	
}

void bmx_wxevthandler_connect(wxEvtHandler * evtHandler, int id, wxEventType eventType, MaxObject * data) {

	evtHandler->Connect(id, eventType, (wxObjectEventFunction) &MaxEventCallBack::EventThunker, data);
	
}

void bmx_wxevthandler_connectrange(wxEvtHandler * evtHandler, int id, int lastId, wxEventType eventType, MaxObject * data) {

	evtHandler->Connect(id, lastId, eventType, (wxObjectEventFunction) &MaxEventCallBack::EventThunker, data);
	
}

void bmx_wxevthandler_addpendingevent(wxEvtHandler * evtHandler, wxEvent & event) {
	evtHandler->AddPendingEvent(event);
}

int bmx_wxevthandler_processevent(wxEvtHandler * evtHandler, wxEvent & event) {
	return static_cast<int>(evtHandler->ProcessEvent(event));
}


void * bmx_event_geteventobject(wxEvent * evt) {

	MaxObject * data = (MaxObject*)evt->GetEventObject();
	return data;

}

MaxObject * bmx_wxevthandler_newref(void * data) {
	return new MaxObject(data);
}

void bmx_wxevthandler_freeref(MaxObject * obj) {
	delete obj;
}

int bmx_wxevthandler_disconnectnoid(wxEvtHandler * evtHandler, wxEventType eventType, MaxObject * data) {
	return static_cast<int>(evtHandler->Disconnect(eventType, (wxObjectEventFunction)&MaxEventCallBack::EventThunker, data));
}

int bmx_wxevthandler_disconnect(wxEvtHandler * evtHandler, int id, wxEventType eventType, MaxObject * data) {
	return static_cast<int>(evtHandler->Disconnect(id, eventType, (wxObjectEventFunction)&MaxEventCallBack::EventThunker, data));
}

int bmx_wxevthandler_disconnectrange(wxEvtHandler * evtHandler, int id, int lastId, wxEventType eventType, MaxObject * data) {
	return static_cast<int>(evtHandler->Disconnect(id, lastId, eventType, (wxObjectEventFunction)&MaxEventCallBack::EventThunker, data));
}

int bmx_eventtype_value(int type) {

	switch(type) {
		case 9: return wxEVT_COMMAND_MENU_SELECTED;
		case 10: return wxEVT_COMMAND_SLIDER_UPDATED;
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
/*		case 200: return wxEVT_NC_LEFT_DOWN;
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
		case 211: return wxEVT_NC_RIGHT_DCLICK; */
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
#ifdef wxHAS_POWER_EVENTS
		case 406: return wxEVT_POWER_SUSPENDING;
		case 407: return wxEVT_POWER_SUSPENDED;
		case 408: return wxEVT_POWER_SUSPEND_CANCEL;
		case -444: return wxEVT_POWER_RESUME;
#endif
		case 409: return wxEVT_ACTIVATE;
		case 410: return wxEVT_CREATE;
		case 411: return wxEVT_DESTROY;
		case 412: return wxEVT_SHOW;
		case 413: return wxEVT_ICONIZE;
		case 415: return wxEVT_MOUSE_CAPTURE_CHANGED;
		case 416: return wxEVT_MOUSE_CAPTURE_LOST;
		case 417: return wxEVT_PAINT;
		case 418: return wxEVT_ERASE_BACKGROUND;
		case 419: return wxEVT_NC_PAINT;
//		case 420: return wxEVT_PAINT_ICON;
		//case 421: return wxEVT_MENU_OPEN;
		//case 422: return wxEVT_MENU_CLOSE;
		//case 423: return wxEVT_MENU_HIGHLIGHT;
		case 424: return wxEVT_CONTEXT_MENU;
		case 425: return wxEVT_SYS_COLOUR_CHANGED;
		case 426: return wxEVT_DISPLAY_CHANGED;
//		case 427: return wxEVT_SETTING_CHANGED;
		case 428: return wxEVT_QUERY_NEW_PALETTE;
		case 429: return wxEVT_PALETTE_CHANGED;
		case 430: return wxEVT_JOY_BUTTON_DOWN;
		case 431: return wxEVT_JOY_BUTTON_UP;
		case 432: return wxEVT_JOY_MOVE;
		case 433: return wxEVT_JOY_ZMOVE;
		case 434: return wxEVT_DROP_FILES;
//		case 435: return wxEVT_DRAW_ITEM;
//		case 436: return wxEVT_MEASURE_ITEM;
//		case 437: return wxEVT_COMPARE_ITEM;
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

void * bmx_wxcommandevent_getclientdata(wxCommandEvent & event) {
	return event.GetClientData();
}

void bmx_wxcommandevent_setclientdata(wxCommandEvent & event, void * data) {
	event.SetClientData(data);
}

void bmx_wxcommandevent_setstring(wxCommandEvent & event, BBString * value) {
	event.SetString(wxStringFromBBString(value));
}

void bmx_wxcommandevent_setint(wxCommandEvent & event, int value) {
	event.SetInt(value);
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

bool bmx_wxevent_getskipped(wxEvent & event) {
	return event.GetSkipped();
}

long bmx_wxevent_gettimestamp(wxEvent & event) {
	return event.GetTimestamp();
}

bool bmx_wxevent_iscommandevent(wxEvent & event) {
	return event.IsCommandEvent();
}

void bmx_wxevent_resumepropagation(wxEvent & event, int propagationLevel) {
	event.ResumePropagation(propagationLevel);
}

bool bmx_wxevent_shouldpropagate(wxEvent & event) {
	return event.ShouldPropagate();
}

int bmx_wxevent_stoppropagation(wxEvent & event) {
	return event.StopPropagation();
}

wxObject * bmx_wxevent_geteventobject(wxEvent & event) {
	return event.GetEventObject();
}


void bmx_wxupdateeventui_check(wxUpdateUIEvent & event, bool value) {
	event.Check(value);
}

void bmx_wxupdateeventui_enable(wxUpdateUIEvent & event, bool value) {
	event.Enable(value);
}

void bmx_wxupdateeventui_show(wxUpdateUIEvent & event, bool value) {
	event.Show(value);
}

int bmx_wxscrollevent_getorientation(wxScrollEvent & event) {
	return event.GetOrientation();
}

int bmx_wxscrollevent_getposition(wxScrollEvent & event) {
	return event.GetPosition();
}

void bmx_wxcontextmenuevent_getposition(wxContextMenuEvent & event, int * x, int * y) {
	wxPoint p = event.GetPosition();
	*x = p.x;
	*y = p.y;
}

void bmx_wxcontextmenuevent_setposition(wxContextMenuEvent & event, int x, int y) {
	event.SetPosition(wxPoint(x, y));
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

void bmx_wxcolour_set(MaxColour * col, int r, int g, int b, int a) {
	col->Colour().Set(r, g, b, a);
}

bool bmx_wxcolour_setasnamedcolour(MaxColour * col, BBString * name) {
	return col->Colour().Set(wxStringFromBBString(name));
}

MaxColour * bmx_wxcolour_null() {
	wxColour c(wxNullColour);
	return new MaxColour(c);
}

bool bmx_wxcolour_equals(MaxColour * col, MaxColour * other) {
	return col->Colour() == other->Colour();
}

void bmx_wxcolour_getrgb(MaxColour * col, int * r, int * g, int * b) {
	*r = col->Colour().Red();
	*g = col->Colour().Green();
	*b = col->Colour().Blue();
}

void bmx_wxcolour_getrgba(MaxColour * col, int * r, int * g, int * b, int * a) {
	*r = col->Colour().Red();
	*g = col->Colour().Green();
	*b = col->Colour().Blue();
	*a = col->Colour().Alpha();
}

MaxColour * bmx_wxcolour_copy(MaxColour * col) {
	wxColour c(col->Colour());
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

MaxFont * bmx_wxfont_create() {
	wxFont f;
	return new MaxFont(f);
}

MaxFont * bmx_wxfont_createattr(int pointSize, wxFontFamily family, int style, wxFontWeight weight,
		int underline, BBString * faceName, wxFontEncoding encoding) {

	wxFont f(pointSize, family, style, weight, static_cast<bool>(underline), wxStringFromBBString(faceName), encoding);
	return new MaxFont(f);

}

void bmx_wxfont_delete(MaxFont * font) {
	delete font;
}

int bmx_wxfont_getpointsize(MaxFont * font) {
	return font->Font().GetPointSize();
}

void bmx_wxfont_setpointsize(MaxFont * font, int size) {
	font->Font().SetPointSize(size);
}

int bmx_wxfont_isfixedwidth(MaxFont * font) {
	return static_cast<int>(font->Font().IsFixedWidth());
}

wxFontEncoding bmx_wxfont_getdefaultencoding() {
	return wxFont::GetDefaultEncoding();
}

BBString * bmx_wxfont_getfacename(MaxFont * font) {
	return bbStringFromWxString(font->Font().GetFaceName());
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

int bmx_wxfont_getunderlined(MaxFont * font) {
	return static_cast<int>(font->Font().GetUnderlined());
}

int bmx_wxfont_getweight(MaxFont * font) {
	return font->Font().GetWeight();
}

int bmx_wxfont_isok(MaxFont * font) {
	return static_cast<int>(font->Font().IsOk());
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

void bmx_wxfont_setunderlined(MaxFont * font, int underlined) {
	font->Font().SetUnderlined(static_cast<bool>(underlined));
}

void bmx_wxfont_setweight(MaxFont * font, int weight) {
	font->Font().SetWeight(weight);
}

void bmx_wxfont_setdefaultencoding(wxFontEncoding encoding) {
	wxFont::SetDefaultEncoding(encoding);
}

int bmx_wxfont_setfacename(MaxFont * font, BBString * name) {
	return static_cast<int>(font->Font().SetFaceName(wxStringFromBBString(name)));
}

void bmx_wxfont_setfamily(MaxFont * font, int family) {
	font->Font().SetFamily(family);
}

int bmx_wxfont_setnativefontinfo(MaxFont * font, BBString * info) {
	return static_cast<int>(font->Font().SetNativeFontInfo(wxStringFromBBString(info)));
}

int bmx_wxfont_setnativefontinfouserdesc(MaxFont * font, BBString * info) {
	return static_cast<int>(font->Font().SetNativeFontInfoUserDesc(wxStringFromBBString(info)));
}

void bmx_wxfont_setencoding(MaxFont * font, wxFontEncoding encoding) {
	font->Font().SetEncoding(encoding);
}

MaxFont * bmx_wxfont_copy(MaxFont * font) {
	wxFont f(font->Font());
	return new MaxFont(f);
}

MaxFont * bmx_wxfont_null() {
	return new MaxFont(wxNullFont);
}

void bmx_wxfont_getpixelsize(MaxFont * font, int * w, int * h) {
	wxSize s(font->Font().GetPixelSize());
	*w = s.GetWidth();
	*h = s.GetHeight();
}

void bmx_wxfont_setpixelsize(MaxFont * font, int w, int h) {
	font->Font().SetPixelSize(wxSize(w, h));
}

int bmx_wxfont_getstrikethrough(MaxFont * font) {
	return static_cast<int>(font->Font().GetStrikethrough());
}

void bmx_wxfont_setstrikethrough(MaxFont * font, int strikethrough) {
	font->Font().SetStrikethrough(static_cast<bool>(strikethrough));
}

// *********************************************

MaxPaintDC * bmx_wxpaintdc_create(wxWindow * window) {
	return new MaxPaintDC(window);
}

void bmx_wxpaintdc_delete(MaxPaintDC * dc) {
	delete dc;
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

MaxEvtHandler * bmx_wxevthandler_create(BBObject * maxHandle) {
	return new MaxEvtHandler(maxHandle);
}


void bmx_wxstreambase_getlength(wxStreamBase * stream, BBInt64 * i) {
	*i = stream->GetLength();
}

int bmx_wxstreambase_getlasterror(wxStreamBase * stream) {
	return stream->GetLastError();
}

int bmx_wxstreambase_getsize(wxStreamBase * stream) {
	return stream->GetSize();
}

bool bmx_wxstreambase_isok(wxStreamBase * stream) {
	return stream->IsOk();
}

bool bmx_wxstreambase_isseekable(wxStreamBase * stream) {
	return stream->IsSeekable();
}

// *********************************************

int bmx_wxisalnum(int code) {
	return wxIsalnum(code);
}

int bmx_wxisprint(int code) {
	return wxIsprint(code);
}

void bmx_wxinitallimagehandlers() {
	wxInitAllImageHandlers();
}

bool bmx_wxlaunchdefaultbrowser(BBString * url, int flags) {
	return wxLaunchDefaultBrowser(wxStringFromBBString(url), flags);
}

// *********************************************


bool bmx_wxkeyevent_altdown(wxKeyEvent & event) {
	return event.AltDown();
}

bool bmx_wxkeyevent_cmddown(wxKeyEvent & event) {
	return event.CmdDown();
}

bool bmx_wxkeyevent_controldown(wxKeyEvent & event) {
	return event.ControlDown();
}

int bmx_wxkeyevent_getkeycode(wxKeyEvent & event) {
	return event.GetKeyCode();
}

int bmx_wxkeyevent_getmodifiers(wxKeyEvent & event) {
	return event.GetModifiers();
}

void bmx_wxkeyevent_getposition(wxKeyEvent & event, int * x, int * y) {
	event.GetPosition(x, y);
}

int bmx_wxkeyevent_getrawkeycode(wxKeyEvent & event) {
	return event.GetRawKeyCode();
}

int bmx_wxkeyevent_getrawkeyflags(wxKeyEvent & event) {
	return event.GetRawKeyFlags();
}

BBString * bmx_wxkeyevent_getunicodekey(wxKeyEvent & event) {
	return bbStringFromWxString(wxString(event.GetUnicodeKey()));
}

long bmx_wxkeyevent_getx(wxKeyEvent & event) {
	return event.GetX();
}

long bmx_wxkeyevent_gety(wxKeyEvent & event) {
	return event.GetY();
}

bool bmx_wxkeyevent_hasmodifiers(wxKeyEvent & event) {
	return event.HasModifiers();
}

bool bmx_wxkeyevent_metadown(wxKeyEvent & event) {
	return event.MetaDown();
}

bool bmx_wxkeyevent_shiftdown(wxKeyEvent & event) {
	return event.ShiftDown();
}

// *********************************************

bool bmx_wxcloseevent_canveto(wxCloseEvent & event) {
	return event.CanVeto();
}

bool bmx_wxcloseevent_getloggingoff(wxCloseEvent & event) {
	return event.GetLoggingOff();
}

void bmx_wxcloseevent_setcanveto(wxCloseEvent & event, bool canVeto) {
	event.SetCanVeto(canVeto);
}

void bmx_wxcloseevent_setloggingoff(wxCloseEvent & event, bool loggingOff) {
	event.SetLoggingOff(loggingOff);
}

void bmx_wxcloseevent_veto(wxCloseEvent & event, bool value) {
	event.Veto(value);
}

// *********************************************

MaxRect * bmx_wxrect_create(int x, int y, int w, int h) {
	wxRect r(x, y, w, h);
	return new MaxRect(r);
}

MaxRect * bmx_wxrect_centrein(MaxRect * rect, MaxRect * r, int dir) {
	wxRect rr(rect->Rect().CentreIn(r->Rect(), dir));
	return new MaxRect(rr);
}

MaxRect * bmx_wxrect_centerin(MaxRect * rect, MaxRect * r, int dir) {
	wxRect rr(rect->Rect().CenterIn(r->Rect(), dir));
	return new MaxRect(rr);
}

bool bmx_wxrect_contains(MaxRect * rect, int x, int y) {
	return rect->Rect().Contains(x, y);
}

bool bmx_wxrect_containsrect(MaxRect * rect, MaxRect * r) {
	return rect->Rect().Contains(r->Rect());
}

void bmx_wxrect_deflate(MaxRect * rect, int dx, int dy) {
	rect->Rect().Deflate(dx, dy);
}

int bmx_wxrect_getbottom(MaxRect * rect) {
	return rect->Rect().GetBottom();
}

int bmx_wxrect_getheight(MaxRect * rect) {
	return rect->Rect().GetHeight();
}

int bmx_wxrect_getleft(MaxRect * rect) {
	return rect->Rect().GetLeft();
}

void bmx_wxrect_getposition(MaxRect * rect, int * x, int * y) {
	wxPoint p(rect->Rect().GetPosition());
	*x = p.x;
	*y = p.y;
}

void bmx_wxrect_gettopleft(MaxRect * rect, int * x, int * y) {
	wxPoint p(rect->Rect().GetTopLeft());
	*x = p.x;
	*y = p.y;
}

void bmx_wxrect_gettopright(MaxRect * rect, int * x, int * y) {
	wxPoint p(rect->Rect().GetTopRight());
	*x = p.x;
	*y = p.y;
}

void bmx_wxrect_getbottomleft(MaxRect * rect, int * x, int * y) {
	wxPoint p(rect->Rect().GetBottomLeft());
	*x = p.x;
	*y = p.y;
}

void bmx_wxrect_getbottomright(MaxRect * rect, int * x, int * y) {
	wxPoint p(rect->Rect().GetBottomRight());
	*x = p.x;
	*y = p.y;
}

int bmx_wxrect_getright(MaxRect * rect) {
	return rect->Rect().GetRight();
}

void bmx_wxrect_getsize(MaxRect * rect, int * w, int * h) {
	wxSize s(rect->Rect().GetSize());
	*w = s.x;
	*h = s.y;
}

int bmx_wxrect_gettop(MaxRect * rect) {
	return rect->Rect().GetTop();
}

int bmx_wxrect_getwidth(MaxRect * rect) {
	return rect->Rect().GetWidth();
}

int bmx_wxrect_getx(MaxRect * rect) {
	return rect->Rect().GetX();
}

int bmx_wxrect_gety(MaxRect * rect) {
	return rect->Rect().GetY();
}

void bmx_wxrect_inflate(MaxRect * rect, int dx, int dy) {
	rect->Rect().Inflate(dx, dy);
}

bool bmx_wxrect_intersects(MaxRect * rect, MaxRect * r) {
	return rect->Rect().Intersects(r->Rect());
}

bool bmx_wxrect_isempty(MaxRect * rect) {
	return rect->Rect().IsEmpty();
}

void bmx_wxrect_offset(MaxRect * rect, int dx, int dy) {
	rect->Rect().Offset(dx, dy);
}

void bmx_wxrect_setheight(MaxRect * rect, int height) {
	rect->Rect().SetHeight(height);
}

void bmx_wxrect_setsize(MaxRect * rect, int w, int h) {
	rect->Rect().SetSize(wxSize(w, h));
}

void bmx_wxrect_setwidth(MaxRect * rect, int width) {
	rect->Rect().SetWidth(width);
}

void bmx_wxrect_setx(MaxRect * rect, int x) {
	rect->Rect().SetX(x);
}

void bmx_wxrect_sety(MaxRect * rect, int y) {
	rect->Rect().SetY(y);
}

MaxRect * bmx_wxrect_union(MaxRect * rect, MaxRect * r) {
	wxRect rr(rect->Rect().Union(r->Rect()));
	return new MaxRect(rr);
}

void bmx_wxrect_delete(MaxRect * rect) {
	delete rect;
}

// *********************************************

void bmx_gdi_wxclientdisplayrect(int * x, int * y, int * width, int * height) {
	wxClientDisplayRect(x, y, width, height);
}

bool bmx_gdi_wxcolourdisplay() {
	return wxColourDisplay();
}

int bmx_gdi_wxdisplaydepth() {
	return wxDisplayDepth();
}

void bmx_gdi_wxdisplaysize(int * width, int * height) {
	wxDisplaySize(width, height);
}

void bmx_gdi_wxdisplaysizemm(int * width, int * height) {
	wxDisplaySizeMM(width, height);
}

MaxRect * bmx_gdi_wxgetclientdisplayrect() {
	return new MaxRect(wxGetClientDisplayRect());
}

// *********************************************

BBString * bmx_wxgetemailaddress() {
	return bbStringFromWxString(wxGetEmailAddress());
}

void bmx_wxgetfreememory(BBInt64 * mem) {
	*mem = wxGetFreeMemory().GetValue();
}

BBString * bmx_wxgetfullhostname() {
	return bbStringFromWxString(wxGetFullHostName());
}

BBString * bmx_wxgethomedir() {
	return bbStringFromWxString(wxGetHomeDir());
}

BBString * bmx_wxgethostname() {
	return bbStringFromWxString(wxGetHostName());
}

wxOperatingSystemId bmx_wxgetosversion(int * major, int * minor) {
	return wxGetOsVersion(major, minor);
}

bool bmx_wxisplatformlittleendian() {
	return wxIsPlatformLittleEndian();
}

bool bmx_wxisplatform64bit() {
	return wxIsPlatform64Bit();
}

BBString * bmx_wxgetuserhome(BBString * user) {
	return bbStringFromWxString(wxString(wxGetUserHome(wxStringFromBBString(user))));
}

BBString * bmx_wxgetuserid() {
	return bbStringFromWxString(wxGetUserId());
}

BBString * bmx_wxgetusername() {
	return bbStringFromWxString(wxGetUserName());
}

// *********************************************

wxEventType bmx_wxneweventtype() {
	return wxNewEventType();
}

void bmx_wxevent_seteventobject(wxEvent & event, wxObject * obj) {
	event.SetEventObject(obj);
}

void bmx_wxevent_delete(wxEvent * event) {
	delete event;
}

wxCommandEvent * bmx_wxcommandevent_create(wxEventType type, int winId) {
	return new wxCommandEvent(type, winId);
}

wxEvent & bmx_wxevent_getcustref(wxEvent * customEventPtr) {
	return *customEventPtr;
}

// *********************************************

int bmx_wxinputstream_lastread(wxInputStream * s) {
	return s->LastRead();
}

wxInputStream * bmx_wxinputstream_read(wxInputStream * s, void * buffer, int size) {
	return &s->Read(buffer, size);
}

bool bmx_wxinputstream_canread(wxInputStream * s) {
	return s->CanRead();
}

bool bmx_wxinputstream_eof(wxInputStream * s) {
	return s->Eof();
}

// *********************************************

wxTextInputStream * bmx_wxtextinputstream_create(wxInputStream * inp, BBString * separators) {
	return new wxTextInputStream(*inp, wxStringFromBBString(separators));
}

int bmx_wxtextinputstream_read8(wxTextInputStream * s, int base) {
	return static_cast<int>(s->Read8(base));
}

int bmx_wxtextinputstream_read8s(wxTextInputStream * s, int base) {
	return static_cast<int>(s->Read8S(base));
}

int bmx_wxtextinputstream_read16(wxTextInputStream * s, int base) {
	return static_cast<int>(s->Read16(base));
}

int bmx_wxtextinputstream_read16s(wxTextInputStream * s, int base) {
	return static_cast<int>(s->Read16S(base));
}

int bmx_wxtextinputstream_read32(wxTextInputStream * s, int base) {
	return static_cast<int>(s->Read32(base));
}

int bmx_wxtextinputstream_read32s(wxTextInputStream * s, int base) {
	return s->Read32S(base);
}

int bmx_wxtextinputstream_getchar(wxTextInputStream * s) {
	return static_cast<int>(s->GetChar());
}

double bmx_wxtextinputstream_readdouble(wxTextInputStream * s) {
	return s->ReadDouble();
}

BBString * bmx_wxtextinputstream_readline(wxTextInputStream * s) {
	return bbStringFromWxString(s->ReadLine());
}

BBString * bmx_wxtextinputstream_readword(wxTextInputStream * s) {
	return bbStringFromWxString(s->ReadWord());
}

void bmx_wxtextinputstream_setstringseparators(wxTextInputStream * s, BBString * separators) {
	s->SetStringSeparators(wxStringFromBBString(separators));
}

void bmx_wxtextinputstream_delete(wxTextInputStream * s) {
	delete s;
}

// *********************************************

bool bmx_wxoutputstream_close(wxOutputStream * s) {
	return s->Close();
}

int bmx_wxoutputstream_lastwrite(wxOutputStream * s) {
	return s->LastWrite();
}

wxOutputStream * bmx_wxoutputstream_write(wxOutputStream * s, void * buffer, int size) {
	return &s->Write(buffer, size);
}

// *********************************************

wxFileOutputStream * bmx_wxfileoutputstream_create(BBString * filename) {
	return new wxFileOutputStream(wxStringFromBBString(filename));
}

bool bmx_wxfileoutputstream_isok(wxFileOutputStream * stream) {
	return stream->IsOk();
}

void bmx_wxfileoutputstream_free(wxFileOutputStream * stream) {
	delete stream;
}

// *********************************************

wxFileInputStream * bmx_wxfileinputstream_create(BBString * filename) {
	return new wxFileInputStream(wxStringFromBBString(filename));
}

bool bmx_wxfileinputstream_isok(wxFileInputStream * stream) {
	return stream->IsOk();
}

void bmx_wxfileinputstream_free(wxFileInputStream * stream) {
	delete stream;
}

// *********************************************

void bmx_wxfilterinputstream_free(wxFilterInputStream * stream) {
	delete stream;
}

// *********************************************

long bmx_wxnewid() {
	return wxNewId();
}

void bmx_wxregisterid(long id) {
	wxRegisterId(id);
}

void bmx_wxenabletoplevelwindows(bool enable) {
	wxEnableTopLevelWindows(enable);
}

void bmx_wxgetmouseposition(int * x, int * y) {
	wxPoint p = wxGetMousePosition();
	*x = p.x;
	*y = p.y;
}

// *********************************************

//long bmx_wxgetelapsedtime(bool resetTimer) {
//	return wxGetElapsedTime(resetTimer);
//}

long bmx_wxgetlocaltime() {
	return wxGetLocalTime();
}

void bmx_wxgetlocaltimemillis(BBInt64 * time) {
	wxLongLong t = wxGetLocalTimeMillis();
	*time = t.GetValue();
}

long bmx_wxgetutctime() {
	return wxGetUTCTime();
}

void bmx_wxmicrosleep(unsigned long microseconds) {
	wxMicroSleep(microseconds);
}

void bmx_wxmillisleep(unsigned long milliseconds) {
	wxMilliSleep(milliseconds);
}

BBString * bmx_wxnow() {
	return bbStringFromWxString(wxNow());
}

void bmx_wxsleep(int secs) {
	wxSleep(secs);
}

//void bmx_wxstarttimer() {
//	wxStartTimer();
//}

// *********************************************

wxTextOutputStream * bmx_wxtextoutputstream_create(wxOutputStream * out, wxEOL mode) {
	return new wxTextOutputStream(*out, mode);
}

wxEOL bmx_wxtextoutputstream_getmode(wxTextOutputStream * s) {
	return s->GetMode();
}

void bmx_wxtextoutputstream_setmode(wxTextOutputStream * s, wxEOL mode) {
	s->SetMode(mode);
}

void bmx_wxtextoutputstream_write8(wxTextOutputStream * s, int value) {
	s->Write8(static_cast<wxUint8>(value));
}

void bmx_wxtextoutputstream_write16(wxTextOutputStream * s, int value) {
	s->Write16(static_cast<wxUint16>(value));
}

void bmx_wxtextoutputstream_write32(wxTextOutputStream * s, int value) {
	s->Write32(value);
}

void bmx_wxtextoutputstream_writedouble(wxTextOutputStream * s, double value) {
	s->WriteDouble(value);
}

void bmx_wxtextoutputstream_writestring(wxTextOutputStream * s, BBString * value) {
	s->WriteString(wxStringFromBBString(value));
}

void bmx_wxtextoutputstream_delete(wxTextOutputStream * s) {
	delete s;
}


// *********************************************

#ifdef wxHAS_POWER_EVENTS
void bmx_wxpowerevent_veto(wxPowerEvent & event) {
	event.Veto();
}
#else
void bmx_wxpowerevent_veto(wxEvent & WXUNUSED(event)) {
}
#endif

// *********************************************

bool bmx_wxactivateevent_getactive(wxActivateEvent & event) {
	return event.GetActive();
}

bool bmx_wxiconizeevent_iconized(wxIconizeEvent & event) {
	return event.Iconized();
}

// *********************************************

void bmx_wxbell() {
	wxBell();
}

int bmx_wxyield() {
	return static_cast<int>(wxYield());
}

