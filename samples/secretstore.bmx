'
' wxSecretStore example
'
' .
'
'
SuperStrict

Framework wx.wxApp
Import wx.wxSecretStore
Import BRL.StandardIO

Const EXIT_SYNTAX:Int = 2
Const EXIT_FAILURE:Int = -1

If AppArgs.length < 3 Or (AppArgs[1] = "save" And AppArgs.length = 4) Or AppArgs.length <> 3 Then
	Print  "Usage: " + AppArgs[0] + " save <service> <user>~n" + ..
                  "   or  " + AppArgs[0] + " {load|delete|selftest} <service>~n" + ..
                  "~n" + ..
                  "Sample showing wxSecretStore class functionality.~n" + ..
                  "Specify one of the commands to perform the corresponding~n" + ..
                  "function call. The ~qservice~q argument is mandatory for~n" + ..
                  "all commands, ~qsave~q also requires ~quser~q and will\n" + ..
                  "prompt for password.~n"
	Return EXIT_SYNTAX
End If

New MyApp.run()

Type MyApp Extends wxApp

	Method OnInit:Int()

		Local store:wxSecretStore = wxSecretStore.GetDefault()
	    If Not store.IsOk() Then
	        Print "Failed to create default secret store."
	        Return EXIT_FAILURE
	    End If
	
		Local operation:String = AppArgs[1]
		Local service:String = AppArgs[2]
		
		Local ok:Int
		
		Select operation
			Case "save"
			Case "load"
			Case "delete"
			Case "selftest"
				ok = SelfTest(store, service)
			Default
				Print "Unknown operation " + operation + ", expected ~qsave~q, ~qload~q or ~qdelete~q.~n"
        Return EXIT_SYNTAX
		End Select
	End Method

	Method PrintResult:Int(ok:Int)
		If ok Then
			Print "    ok"
		Else
			Print "    error"
		End If
		Return ok
	End Method

	Method SelfTest:Int(store:wxSecretStore, service:String)
		Print "Running the tests...~n"
		
		Local userTest:String = "test"
		Local secret1:wxSecretValue = New wxSecretValue.Create("secret")
		
		Print "Storing the password:"
		Local ok:Int = store.Save(service, userTest, secret1)
		If Not PrintResult(ok) Then
			' The rest of the tests will probably fail too, no need To Continue.
			Print "Bailing out.~n"
			Return False
		End If
		
		Print "Loading the password:"
		Local secret:wxSecretValue = New wxSecretValue.CreateEmpty()
		Local user:String
		ok = PrintResult(store.Load(service, user, secret) And user = userTest And secret.Equals(secret1))
		
		' Overwriting the password should work.
		Local secret2:wxSecretValue = New wxSecretValue.Create("privet")
		
		Print "Changing the password:"
		If PrintResult(store.Save(service, user, secret2)) Then
			Print "Reloading the password:"
			If Not PrintResult(store.Load(service, user, secret) And secret.Equals(secret2)) Then
				ok = False
			End If
		Else
			ok = False
		End If

		Print "Removing the password:"
		If Not PrintResult(store.Remove(service)) Then
			ok = False
		End If
		
		' This is supposed To fail now.
		Print "Removing it again:"
		If Not PrintResult(Not store.Remove(service)) Then
			ok = False
		End If
		
		' And loading should fail too.
		Print "Loading after removing:"
		If Not PrintResult(Not store.Load(service, user, secret)) Then
			ok = False
		End If
		
		If ok Then
			Print "All tests passed!~n"
		End If
		
		Return ok
	End Method
	
End Type

