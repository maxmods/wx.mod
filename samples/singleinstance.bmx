SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxSingleInstanceChecker
Import wx.wxLog

New MyApp.run()


Type MyApp Extends wxApp

	Field frame:wxFrame
	Field mChecker:wxSingleInstanceChecker

	Method OnInit:Int()

	    Local name:String = "singleinstance-" + wxGetUserId() 
	    
	    mChecker = New wxSingleInstanceChecker.Create(name)
	    
	    If mChecker.IsAnotherRunning() Then 
	        wxLogError("Another program instance is already running, aborting.") 
	        Return False
	    End If

		frame = wxFrame.CreateFrame(,,"Single Instance", 100, 100)
		frame.show()
    
	    Return True
	End Method
	
End Type

