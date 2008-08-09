SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxListBox
Import wx.wxTextEntryDialog
 
Const ID_RENAME:Int = 1
Const ID_LISTBOX:Int = 5

New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local lb:TListbox = TListbox(New TListbox.Create(Null, wxID_ANY, ..
			"Simple", -1, -1, 270, 200))
		lb.Show(True)
 
		Return True
	End Method

End Type

Type TListbox Extends wxFrame

	Field listbox:wxListBox
	Field btnPanel:MyPanel
 
	Method OnInit()
		
		Local panel:wxPanel = New wxPanel.Create(Self, -1)
		
		Local hbox:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		
		listbox = New wxListBox.Create(panel, ID_LISTBOX, ..
			Null, -1, -1, -1, -1)
		
		hbox.Add(listbox, 3, wxEXPAND | wxALL, 20)		
		btnPanel = MyPanel(New MyPanel.Create(panel))
		hbox.Add(btnPanel, 2, wxEXPAND | wxRIGHT, 10)
		
		ConnectAny(wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, OnDblClick)
		
		panel.SetSizer(hbox)

		Centre()
 
	End Method
	
	Function OnDblClick(event:wxEvent)
		Local lb:TListBox = TListBox(event.parent)
	
		Local renamed:String
		
		Local sel:Int = lb.listbox.GetSelection()
		If sel <> -1 Then
		    renamed = wxGetTextFromUser("Rename item", ..
				"Rename dialog", lb.listbox.GetString(sel))
		End If
		
		If renamed Then
		    lb.listbox.DeleteItem(sel)
		    lb.listbox.Insert(renamed, sel)
		End If
	End Function
	
End Type

Type MyPanel Extends wxPanel

	Field m_lb:wxListBox
	
	Field m_newb:wxButton
	Field m_renameb:wxButton
	Field m_clearb:wxButton
	Field m_deleteb:wxButton

	Method OnInit()
		Local vbox:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		
		Local lb:TListbox = TListbox(GetParent().GetParent())
		m_lb = lb.listbox
		
		m_newb = New wxButton.Create(Self, wxID_NEW, "New")
		m_renameb = New wxButton.Create(Self, ID_RENAME, "Rename")
		m_deleteb = New wxButton.Create(Self, wxID_DELETE, "Delete")
		m_clearb = New wxButton.Create(Self, wxID_CLEAR, "Clear")
		
		Connect(wxID_NEW, wxEVT_COMMAND_BUTTON_CLICKED, OnNew)
		Connect(ID_RENAME, wxEVT_COMMAND_BUTTON_CLICKED, OnRename)
		Connect(wxID_CLEAR, wxEVT_COMMAND_BUTTON_CLICKED, OnClear)
		Connect(wxID_DELETE, wxEVT_COMMAND_BUTTON_CLICKED, OnDelete)
		
		vbox.AddCustomSpacer(-1, 20)
		vbox.Add(m_newb)
		vbox.Add(m_renameb, 0, wxTOP, 5)
		vbox.Add(m_deleteb, 0, wxTOP, 5)
		vbox.Add(m_clearb, 0, wxTOP, 5)
		
		SetSizer(vbox)
	End Method
	
	Function OnNew(event:wxEvent)
		Local s:String = wxGetTextFromUser("Add new item")
		If s Then
			MyPanel(event.parent).m_lb.Append(s)
		End If
	End Function

	Function OnRename(event:wxEvent)
		Local pnl:MyPanel = MyPanel(event.parent)

		Local renamed:String
		
		Local sel:Int = pnl.m_lb.GetSelection()
		If sel <> -1 Then
			renamed = wxGetTextFromUser("Rename item", ..
				"Rename dialog", pnl.m_lb.GetString(sel))
		End If
		
		If renamed Then
			pnl.m_lb.DeleteItem(sel)
			pnl.m_lb.Insert(renamed, sel)
		End If
	End Function

	Function OnClear(event:wxEvent)
		MyPanel(event.parent).m_lb.Clear()
	End Function

	Function OnDelete(event:wxEvent)
		Local pnl:MyPanel = MyPanel(event.parent)
	
		Local sel:Int = pnl.m_lb.GetSelection()
		If sel <> -1 Then
			pnl.m_lb.DeleteItem(sel)
		End If
	End Function
	
End Type
