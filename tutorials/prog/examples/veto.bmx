SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxMessageDialog

New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local v:Veto = Veto(New Veto.Create(Null, wxID_ANY, ..
			"Veto", -1, -1, 250, 130))
		v.Show(True)
 
		Return True
	End Method

End Type

Type Veto Extends wxFrame
 
	Method OnInit()
		
		ConnectAny(wxEVT_CLOSE_WINDOW, OnClose)
		
		Centre()
 
	End Method
	
	Function OnClose(event:wxEvent)
		Local dial:wxMessageDialog = New wxMessageDialog.Create(Null, ..
			"Are you sure to quit?", "Question", ..
			wxYES_NO | wxNO_DEFAULT | wxICON_QUESTION)

		Local ret:Int = dial.ShowModal()
		dial.Free()

		If ret = wxID_YES Then
			wxWindow(event.parent).Destroy()
		Else
			wxCloseEvent(event).Veto()
		End If

	End Function

End Type

