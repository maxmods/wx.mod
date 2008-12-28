'
' A sample to show processing of a .tar.gz file using class factories.
'
' 2008 Bruce A Henderson
'

SuperStrict

Framework wx.wxApp
Import wx.wxArchiveClassFactory
Import wx.wxFilterClassFactory
Import wx.wxArchive
Import BRL.StandardIO

New MyApp.run()


Type MyApp Extends wxApp

	Method OnInit:Int()

		Local filename:String = "example.tar.gz"

		' load in some text
		Local in:wxInputStream = New wxFileInputStream.Create(filename)
		
		If in And in.IsOk() Then
		
			' look for a filter handler, e.g. for '.gz'
			Local fcf:wxFilterClassFactory = wxFilterClassFactory.Find(filename, wxSTREAM_FILEEXT)
			
			If fcf Then
				in = fcf.NewInputStream(in)
				' pop the extension, so if it was '.tar.gz' it is now just '.tar'
				filename = fcf.PopExtension(filename)
			End If
			
			' look for a archive handler, e.g. for '.zip' or '.tar'
			Local acf:wxArchiveClassFactory = wxArchiveClassFactory.Find(filename, wxSTREAM_FILEEXT)
			
			If acf Then
			
				Local arc:wxArchiveInputStream = acf.NewInputStream(in)
				Local entry:wxArchiveEntry = arc.GetNextEntry()
				
				' list the contents of the archive
				While entry
					Local name:String = entry.GetName()

					If entry.IsDir() Then
						name :+ " <---- is a directory"
					Else
						' read the data
						Local size:Int = entry.GetSize()
						Local buf:Byte[] = New Byte[size]
					
						arc.Read(buf, size)
					End If
					
					Print name
					
					entry = arc.GetNextEntry()
				Wend
			
			Else
				DebugLog "Can't handle '" + filename + "'"
			End If
		
		End If
		
	
		Return False
	
	End Method

End Type







