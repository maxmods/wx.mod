SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxMediaCtrl
Import wx.wxButton
Import wx.wxFileDialog
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local p:Player = Player(New Player.Create(Null, wxID_ANY, "MediaPlayer", -1, -1, 480, 320))
		p.Centre()
		p.Show(True)
 
		Return True
	End Method

End Type

Type Player Extends wxFrame

	Const ID_OPEN:Int = 100
	Const ID_PLAY:Int = 101
	Const ID_STOP:Int = 102
	
	Const ID_MEDIA:Int = 200

	Field mediaCtrl:wxMediaCtrl
	Field btnOpen:wxButton
	Field btnPlay:wxButton
	Field btnStop:wxButton
	
	Field loaded:Int
	Field playing:Int

	Method OnInit()

		Local sizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		

		mediaCtrl = New wxMediaCtrl.Create(Self, ID_MEDIA, Null)
 		sizer.Add(mediaCtrl, 1, wxALL|wxEXPAND, 5)

		Local hSizer:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)

		btnOpen = New wxButton.Create(Self, ID_OPEN, "Open")
 		hSizer.Add(btnOpen, 0, wxALL, 5)

		btnPlay = New wxButton.Create(Self, ID_PLAY, "Play/Pause")
 		hSizer.Add(btnPlay, 0, wxALL, 5)

		btnStop = New wxButton.Create(Self, ID_STOP, "Stop")
 		hSizer.Add(btnStop, 0, wxALL, 5)

 		sizer.AddSizer(hSizer, 0, wxALL, 5)
		
		SetSizer(sizer)
		
		UpdateButtons()
		
		Connect(ID_OPEN, wxEVT_COMMAND_BUTTON_CLICKED, _OnOpen)

		Connect(ID_PLAY, wxEVT_COMMAND_BUTTON_CLICKED, _OnPlay)

		Connect(ID_STOP, wxEVT_COMMAND_BUTTON_CLICKED, _OnStop)
		
		Connect(ID_MEDIA, wxEVT_MEDIA_LOADED, _OnMediaLoaded)
		Connect(ID_MEDIA, wxEVT_MEDIA_PAUSE, _OnMediaPause)
		Connect(ID_MEDIA, wxEVT_MEDIA_STOP, _OnMediaStop)
		Connect(ID_MEDIA, wxEVT_MEDIA_PLAY, _OnMediaPlay)
		Connect(ID_MEDIA, wxEVT_MEDIA_FINISHED, _OnMediaFinished)
	End Method
	
	Function _OnOpen(event:wxEvent)
		Player(event.parent).OnOpen(wxCommandEvent(event))
	End Function
	
	Function _OnPlay(event:wxEvent)
		Player(event.parent).OnPlay(wxCommandEvent(event))
	End Function

	Function _OnStop(event:wxEvent)
		Player(event.parent).OnStop(wxCommandEvent(event))
	End Function

	Function _OnMediaLoaded(event:wxEvent)
		Player(event.parent).OnMediaLoaded(wxMediaEvent(event))
	End Function

	Function _OnMediaPause(event:wxEvent)
		Player(event.parent).OnMediaPause(wxMediaEvent(event))
	End Function

	Function _OnMediaStop(event:wxEvent)
		Player(event.parent).OnMediaStop(wxMediaEvent(event))
	End Function

	Function _OnMediaPlay(event:wxEvent)
		Player(event.parent).OnMediaPlay(wxMediaEvent(event))
	End Function

	Function _OnMediaFinished(event:wxEvent)
		Player(event.parent).OnMediaFinished(wxMediaEvent(event))
	End Function

	Method OnOpen(event:wxCommandEvent)
		Local fd:wxFileDialog = New wxFileDialog.Create(Self)
		
		If fd.ShowModal() = wxID_OK Then
			OpenFile(fd.GetPath())
		End If
		
	End Method

	Method OnPlay(event:wxCommandEvent)
		If playing Then
			mediaCtrl.Pause()
		Else
			mediaCtrl.Play()
		End If
	End Method

	Method OnStop(event:wxCommandEvent)
		mediaCtrl.Stop()
	End Method
	
	Method OnMediaLoaded(event:wxMediaEvent)
		If Not mediaCtrl.Play() Then
            wxMessageBox("Couldn't play movie!")
		Else
			loaded = True
			playing = True
		End If
		
		UpdateButtons()
	End Method

	Method OnMediaPause(event:wxMediaEvent)
		playing = False
		UpdateButtons()
	End Method

	Method OnMediaStop(event:wxMediaEvent)
		playing = False
		UpdateButtons()
	End Method

	Method OnMediaPlay(event:wxMediaEvent)
		playing = True
		UpdateButtons()
	End Method

	Method OnMediaFinished(event:wxMediaEvent)
		playing = False
		UpdateButtons()
	End Method

	Method OpenFile(file:String)
	
		If Not mediaCtrl.Load(file) Then
			wxMessageBox("Couldn't load movie!")
		Else
			loaded = False
			playing = False
		End If
		
		UpdateButtons()
	End Method
	
	Method UpdateButtons()
		If Not loaded Then
			btnPlay.Disable()
			btnStop.Disable()
		Else
			btnPlay.Enable()
			btnStop.Enable()
		End If
		
		If Not playing Then
			btnStop.Disable()
		End If
					
	End Method
	
	
End Type

