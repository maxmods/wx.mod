'
' A sample to show wxBZipInputStream and wxBZipOutputSream usage
'
' 2008 Bruce A Henderson
'

SuperStrict

Framework wx.wxApp
Import wx.wxBZipStream
Import BRL.StandardIO

New MyApp.run()


Type MyApp Extends wxApp

	Method OnInit:Int()

		' load in some text
		Local in:wxInputStream = New wxFileInputStream.Create("ovid.txt")
		
		If in Then

			' open a new file
			Local out:wxOutputStream = New wxFileOutputStream.Create("ovid.bz2")
			
			' the file will contain a bzip data stream
			Local bzipOut:wxBZipOutputStream = New wxBZipOutputStream.Create(out)
		
		
			Local buffer:Byte[1024]
			Local bytesRead:Int
			
			Repeat
			
				bytesRead = in.Read(buffer, 1024).LastRead()
			
				If bytesRead > 0 Then
					bzipOut.Write(buffer, bytesRead)
				End If
				
			Until bytesRead <> 1024
			
			' remember to close the output streams
			bzipOut.Close()
			out.Close()
			
			' free up the stream objects!
			bzipOut.Free()
			out.Free()
			in.Free()
			
		
		End If
		
		
		' now to load it back, and output to the console
		
		' open an input stream
		in = New wxFileInputStream.Create("ovid.bz2")
		
		If in Then
		
			' create a bzip stream from the file
			Local bzipIn:wxBZipInputStream = New wxBZipInputStream.Create(in)
			
			' create a text stream from the bzip stream
			Local text:wxTextInputStream = New wxTextInputStream.Create(bzipIn)
			
			Repeat
			
				Print text.ReadLine()
			
			Until Not bZipIn.LastRead()
		
			' free up the stream objects!
			text.Free()
			bzipIn.Free()
			in.Free()
		
		End If
		
	
		Return False
	
	End Method

End Type







