SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxTimer
Import BRL.Random

Const NoShape:Int = 0
Const ZShape:Int = 1
Const SShape:Int = 2
Const LineShape:Int = 3
Const TShape:Int = 4
Const SquareShape:Int = 5
Const LShape:Int = 6
Const MirroredLShape:Int = 7

New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		SeedRnd(MilliSecs())
	
		Local tet:Tetris = Tetris(New Tetris.Create(Null, wxID_ANY, ..
			"Tetris", -1, -1, 180, 380))
		tet.Centre()
		tet.Show(True)
 
		Return True
	End Method

End Type

Type Tetris Extends wxFrame
 
	Method OnInit()
		
		Local sb:wxStatusBar = CreateStatusBar()
		sb.SetStatusText("0")
		
		Local brd:Board = Board(New Board.Create(Self,,,,,,wxWANTS_CHARS))
		brd.SetFocus()
		brd.Start()
 
	End Method
	
End Type


Type Board Extends wxPanel

	Field timer:wxTimer
	
	Field isStarted:Int
	Field isPaused:Int
	Field isFallingFinished:Int
	Field curPiece:Shape = New Shape
	Field curX:Int
	Field curY:Int
	Field numLinesRemoved:Int
	Field theBoard:Int[] = New Int[BoardWidth * BoardHeight]
	Field m_stsbar:wxStatusBar


	Method OnInit()
		timer = New wxTimer.Create(Self, 1)
		
		m_stsbar = wxFrame(GetParent()).GetStatusBar()
		isFallingFinished = False
		isStarted = False
		isPaused = False
		numLinesRemoved = 0
		curX = 0
		curY = 0
		
		ClearBoard()
		
		ConnectAny(wxEVT_PAINT, _OnPaint)
		ConnectAny(wxEVT_KEY_DOWN, _OnKeyDown)
		ConnectAny(wxEVT_TIMER, _OnTimer)
	End Method
	
	Const BoardWidth:Int = 10
	Const BoardHeight:Int = 22

	Method ShapeAt:Int(x:Int, y:Int)
		Return theBoard[(y * BoardWidth) + x]
	End Method

	Method SetShapeAt(x:Int, y:Int, shape:Int)
		theBoard[(y * BoardWidth) + x] = shape
	End Method
	
	Method SquareWidth:Int()
		Local width:Int, height:Int
		GetClientSize(width, height)
		Return width / BoardWidth
	End Method
	
	Method SquareHeight:Int()
		Local width:Int, height:Int
		GetClientSize(width, height)
		Return height / BoardHeight
	End Method
	
	Method Start()
		If isPaused Then
			Return
		End If
	
		isStarted = True
		isFallingFinished = False
		numLinesRemoved = 0
		ClearBoard()
		
		NewPiece()
		timer.Start(300)
	End Method
	
	Method Pause()
		If Not isStarted Then
			Return
		End If
	
		isPaused = Not isPaused
		If isPaused Then
			timer.Stop()
			m_stsbar.SetStatusText("paused")
		Else
			timer.Start(300)
			m_stsbar.SetStatusText(numLinesRemoved)
		End If
		Refresh()
	End Method
	
	Function _OnPaint(event:wxEvent)
		Board(event.parent).OnPaint(wxPaintEvent(event))
	End Function
	
	Method OnPaint(event:wxPaintEvent)
		Local dc:wxPaintDC = New wxPaintDC.Create(Self)
		
		Local width:Int, height:Int
		GetClientSize(width, height)
		
		Local boardTop:Int = height - BoardHeight * SquareHeight()
		
		
		For Local i:Int = 0 Until BoardHeight
			For Local j:Int = 0 Until BoardWidth
				Local shape:Int = ShapeAt(j, BoardHeight - i - 1)
				If shape <> NoShape Then
					DrawSquare(dc, 0 + j * SquareWidth(), ..
						boardTop + i * SquareHeight(), shape)
				End If
			Next
		Next
		
		If curPiece.GetShape() <> NoShape Then
			For Local i:Int = 0 Until 4
				Local x:Int = curX + curPiece.x(i)
				Local y:Int = curY - curPiece.y(i)
				DrawSquare(dc, 0 + x * SquareWidth(), boardTop + ..
					(BoardHeight - y - 1) * SquareHeight(), ..
					curPiece.GetShape())
			Next
		End If
		
		dc.Free()
	End Method
	
	Function _OnKeyDown(event:wxEvent)
		Board(event.parent).OnKeyDown(wxKeyEvent(event))
	End Function
	
	Method OnKeyDown(event:wxKeyEvent)

		If Not isStarted Or curPiece.GetShape() = NoShape Then
			event.Skip()
			Return
		End If
		
		Local keycode:Int = event.GetKeyCode()
		
		If keycode = Asc("p") Or keycode = Asc("P") Then
			Pause()
			Return
		End If
		
		If isPaused Then
			Return
		End If
		
		Select keycode
			Case WXK_LEFT
				TryMove(curPiece, curX - 1, curY)
			Case WXK_RIGHT
				TryMove(curPiece, curX + 1, curY)
			Case WXK_DOWN
				TryMove(curPiece.RotateRight(), curX, curY)
			Case WXK_UP
				TryMove(curPiece.RotateLeft(), curX, curY)
			Case WXK_SPACE
				DropDown()
			Case Asc("d"), Asc("D")
				OneLineDown()
			Default
				event.Skip()
		End Select
	
	End Method
	
	Function _OnTimer(event:wxEvent)
		Board(event.parent).OnTimer(wxTimerEvent(event))
	End Function
	
	Method OnTimer(event:wxTimerEvent)
		If isFallingFinished Then
			isFallingFinished = False
			NewPiece()
		Else
			OneLineDown()
		End If
	End Method
	
	Method ClearBoard()
		For Local i:Int = 0 Until BoardHeight * BoardWidth
			theBoard[i] = NoShape
		Next
	End Method
	
	Method DropDown()
		Local newY:Int = curY
		While newY > 0
			If Not TryMove(curPiece, curX, newY - 1)
				Exit
			End If
			newY:- 1
		Wend
		PieceDropped()
	End Method
	
	Method OneLineDown()
		If Not TryMove(curPiece, curX, curY - 1) Then
			PieceDropped()
		End If
	End Method
	
	Method PieceDropped()
		For Local i:Int = 0 Until 4
			Local x:Int = curX + curPiece.x(i)
			Local y:Int = curY - curPiece.y(i)
			SetShapeAt(x, y, curPiece.GetShape())
		Next
		
		RemoveFullLines()
		
		If Not isFallingFinished Then
			NewPiece()
		End If
	End Method
		
	Method RemoveFullLines()
		Local numFullLines:Int = 0
		
		For Local i:Int = BoardHeight - 1 To 0 Step - 1
			Local lineIsFull:Int = True
		
			For Local j:Int = 0 Until BoardWidth
				If ShapeAt(j, i) = NoShape Then
					lineIsFull = False
					Exit
				End If
			Next
		
			If lineIsFull Then
				numFullLines:+ 1
				For Local k:Int = i Until BoardHeight - 1
					For Local j:Int = 0 Until BoardWidth
						SetShapeAt(j, k, ShapeAt(j, k + 1))
					Next
				Next
			End If
		Next
		
		If numFullLines > 0 Then
			numLinesRemoved :+ numFullLines
			m_stsbar.SetStatusText(numLinesRemoved)
		
			isFallingFinished = True
			curPiece.SetShape(NoShape)
			Refresh()
		End If
	End Method
	
	Method NewPiece()
		curPiece.SetRandomShape()
		curX = BoardWidth / 2 + 1
		curY = BoardHeight - 1 + curPiece.MinY()
		
		If Not TryMove(curPiece, curX, curY)
			curPiece.SetShape(NoShape)
			timer.Stop()
			isStarted = False
			m_stsbar.SetStatusText("game over")
		End If
	End Method
	
	Method TryMove:Int(newPiece:Shape, newX:Int, newY:Int)
		For Local i:Int = 0 Until 4
			Local x:Int = newX + newPiece.x(i)
			Local y:Int = newY - newPiece.y(i)
			If x < 0 Or x >= BoardWidth Or y < 0 Or y >= BoardHeight Then
				Return False
			End If
			If ShapeAt(x, y) <> NoShape Then
				Return False
			End If
		Next
		
		curPiece = newPiece
		curX = newX
		curY = newY
		Refresh()
		Return True
	End Method
	
	Method DrawSquare(dc:wxPaintDC, x:Int, y:Int, shape:Int)
	
		Global colors:wxColour [] = [ ..
			New wxColour.Create(0, 0, 0), ..
			New wxColour.Create(204, 102, 102), ..
			New wxColour.Create(102, 204, 102), ..
			New wxColour.Create(102, 102, 204), ..
			New wxColour.Create(204, 204, 102), ..
			New wxColour.Create(204, 102, 204), ..
			New wxColour.Create(102, 204, 204), ..
			New wxColour.Create(218, 170, 0) ]
		
		Global light:wxColour[] = [ ..
			New wxColour.Create(0, 0, 0), ..
			New wxColour.Create(248, 159, 171), ..
			New wxColour.Create(121, 252, 121), ..
			New wxColour.Create(121, 121, 252), ..
			New wxColour.Create(252, 252, 121), ..
			New wxColour.Create(252, 121, 252), ..
			New wxColour.Create(121, 252, 252), ..
			New wxColour.Create(252, 198, 0) ]
		
		Global dark:wxColour[] = [ ..
			New wxColour.Create(0, 0, 0), ..
			New wxColour.Create(128, 59, 59), ..
			New wxColour.Create(59, 128, 59), ..
			New wxColour.Create(59, 59, 128), ..
			New wxColour.Create(128, 128, 59), ..
			New wxColour.Create(128, 59, 128), ..
			New wxColour.Create(59, 128, 128), ..
			New wxColour.Create(128, 98, 0) ]
		
		
		Local pen:wxPen = New wxPen.CreateFromColour(light[shape])
		pen.SetCap(wxCAP_PROJECTING)
		dc.SetPen(pen)
		
		dc.DrawLine(x, y + SquareHeight() - 1, x, y)
		dc.DrawLine(x, y, x + SquareWidth() - 1, y)
		
		Local darkpen:wxPen = New wxPen.CreateFromColour(dark[Int(shape)])
		darkpen.SetCap(wxCAP_PROJECTING)
		dc.SetPen(darkpen)
		
		dc.DrawLine(x + 1, y + SquareHeight() - 1, x + SquareWidth() - 1, ..
			y + SquareHeight() - 1)
		dc.DrawLine(x + SquareWidth() - 1, y + SquareHeight() - 1, ..
			x + SquareWidth() - 1, y + 1)
		
		dc.SetPen(wxTRANSPARENT_PEN())
		dc.SetBrush(New wxBrush.CreateFromColour(colors[shape])) 
		dc.DrawRectangle(x + 1, y + 1, SquareWidth() - 2, SquareHeight() - 2)
	End Method
	
End Type



Type Shape

    Global coordsTable:Int[][][] = [ ..
        [ [ 0, 0 ],   [ 0, 0 ],   [ 0, 0 ],   [ 0, 0 ] ], ..
        [ [ 0, -1 ],  [ 0, 0 ],   [ -1, 0 ],  [ -1, 1 ] ], ..
        [ [ 0, -1 ],  [ 0, 0 ],   [ 1, 0 ],   [ 1, 1 ] ], ..
        [ [ 0, -1 ],  [ 0, 0 ],   [ 0, 1 ],   [ 0, 2 ] ], ..
        [ [ -1, 0 ],  [ 0, 0 ],   [ 1, 0 ],   [ 0, 1 ] ], ..
        [ [ 0, 0 ],   [ 1, 0 ],   [ 0, 1 ],   [ 1, 1 ] ], ..
        [ [ -1, -1 ], [ 0, -1 ],  [ 0, 0 ],   [ 0, 1 ] ], ..
        [ [ 1, -1 ],  [ 0, -1 ],  [ 0, 0 ],   [ 0, 1 ] ] ..
    ]

	Field pieceShape:Int
	Field coords:Int[][] = [ [0,0], [0,0], [0,0], [0,0] ]
	
	Method New()
		SetShape(NoShape)
	End Method
	
	Method SetShape(shape:Int)
		For Local i:Int = 0 Until 4
			For Local j:Int = 0 Until 2
				coords[i][j] = coordsTable[shape][i][j]
			Next
		Next
		pieceShape = shape
	End Method
	
	Method SetRandomShape()
		Local x:Int = Rand(0, 21) Mod 7 + 1
		SetShape(x)
	End Method
	
	Method GetShape:Int()
		Return pieceShape
	End Method
	
	Method x:Int(index:Int)
		Return coords[index][0]
	End Method
	
	Method y:Int(index:Int)
		Return coords[index][1]
	End Method
	
	Method MinX:Int()
		Local m:Int = coords[0][0]
		For Local i:Int = 0 Until 4
			m = Min(m, coords[i][0])
		Next
		Return m
	End Method

	Method MaxX:Int()
		Local m:Int = coords[0][0]
		For Local i:Int = 0 Until 4
			m = Max(m, coords[i][0])
		Next
		Return m
	End Method
	
	Method MinY:Int()
		Local m:Int = coords[0][1]
		For Local i:Int = 0 Until 4
			m = Min(m, coords[i][1])
		Next
		Return m
	End Method

	Method MaxY:Int()
		Local m:Int = coords[0][1]
		For Local i:Int = 0 Until 4
			m = Max(m, coords[i][1])
		Next
		Return m
	End Method
	
	Method RotateLeft:Shape()
		If pieceShape = SquareShape Then
			Return Self
		End If
		
		Local result:Shape = New Shape
		result.pieceShape = pieceShape
		
		For Local i:Int = 0 Until 4
			result.SetX(i, y(i))
			result.SetY(i, -x(i))
		Next
		Return result
	End Method
	
	Method RotateRight:Shape()
		If pieceShape = SquareShape Then
			Return Self
		End If
		
		Local result:Shape = New Shape
		result.pieceShape = pieceShape
		
		For Local i:Int = 0 Until 4
			result.SetX(i, -y(i))
			result.SetY(i, x(i))
		Next
		Return result
	End Method
	
	Method SetX(index:Int, x:Int)
		coords[index][0] = x
	End Method
	
	Method SetY(index:Int, y:Int)
		coords[index][1] = y
	End Method

End Type
