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
		
		Local frame:TestWnd = New TestWnd
		frame.Show(True)
 
		Return True
	End Method

End Type


Type TestWnd_Base Extends wxFrame

	Field A:wxTextCtrl
	Field B:wxButton

	Method New()
		wxXmlResource.Get().LoadObject(Self, Null, "TestWnd", "wxFrame")
		A = wxTextCtrl(XRCCTRL(Self,"A"))
		B = wxButton(XRCCTRL(Self,"B"))
		
		OnInit()
	End Method

End Type

Type TestWnd Extends TestWnd_Base

	Method OnInit()
		' A, B already initialised at this point
		A.SetLabel("Updated in TestWnd::OnInit")
		B.SetLabel("Nice :)")
	End Method

End Type