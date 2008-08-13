SuperStrict

Framework wx.wxApp
Import wx.wxXmlResource
Import wx.wxButton
Import wx.wxTextCtrl

New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		wxXmlResource.Get().InitAllHandlers()
		wxXmlResource.Get().Load("loadobject.xrc")
		
		' create a new frame. The New() method will do all the work of building it from the xrc.
		Local frame:TestWnd = New TestWnd
		frame.Show(True)
 
		Return True
	End Method

End Type

Type TestWnd Extends wxFrame

	Field A:wxTextCtrl
	Field B:wxButton

	Method New()
		' Call LoadObject for subclasses of a normal type. This way we can populate our custom widget from the xrc.
		wxXmlResource.Get().LoadObject(Self, Null, "TestWnd", "wxFrame")
		
		' create some local references to the frame widgets
		A = wxTextCtrl(XRCCTRL(Self,"A"))
		B = wxButton(XRCCTRL(Self,"B"))

		OnInit()
	End Method

	Method OnInit()
		' A, B already initialised at this point
		A.ChangeValue("Updated in TestWnd::OnInit")
		B.SetLabel("Nice :)")
		
		' we use XRCID() to refer to the widget id, in order to attach it to the event
		Connect(XRCID("B"), wxEVT_COMMAND_BUTTON_CLICKED, OnBPressed)
	End Method

	Function OnBPressed(event:wxEvent)
		wxWindow(event.parent).Close()
	End Function
	
End Type