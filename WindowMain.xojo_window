#tag Window
Begin Window WindowMain
   Backdrop        =   0
   BackgroundColor =   &c00000000
   Composite       =   False
   DefaultLocation =   "2"
   FullScreen      =   False
   HasBackgroundColor=   True
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   400
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   False
   Title           =   "RaspiFrame"
   Type            =   "4"
   Visible         =   True
   Width           =   600
   Begin Canvas canvasScreen
      AllowAutoDeactivate=   False
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   400
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   600
   End
   Begin Timer TimerChangePicture
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   3000
      RunMode         =   "2"
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Timer TimerFadePicture
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   20
      RunMode         =   "2"
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Timer TimerClock
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   1000
      RunMode         =   "2"
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  If Asc(key) = 27 Then
		    Self.Close
		  End
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  Init
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function BuildInfoString() As string
		  Var hostname As String
		  If Helper.ExecuteCommand("hostname") = 0 Then
		    hostname = Helper.LastCommandResult
		  End
		  
		  Var uptime As String
		  If Helper.ExecuteCommand("uptime -p") = 0 Then
		    uptime = Helper.LastCommandResult
		  End
		  
		  Var availableMemory As String
		  If Helper.ExecuteCommand("grep 'MemFree' /proc/meminfo") = 0 Then
		    availableMemory = Helper.LastCommandResult
		  End
		  
		  Return hostname + " - " + availableMemory + " - " + uptime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DeleteCurrentPicture() As string
		  Var f As FolderItem = Config.PicturesFolder.Child(CurrentPictureName)
		  If f <> Nil And f.Exists And Not f.IsFolder Then
		    f.Remove
		    Return "OK"
		  Else
		    Return "File '" + CurrentPictureName + "' not found, delete failed."
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExecuteRemoteCommand(query as string) As WebServer.HttpResponse
		  Var q As String = query.Lowercase.Trim
		  
		  Logging.Info("request query: " + q)
		  
		  Try
		    If q.BeginsWith("/api/?") Then
		      // process api command
		      
		      Var cmd As String = q.Replace("/api/?", "")
		      
		      Select Case cmd
		        
		        // reorder pictures
		      Case "shuffle"
		        RandomizePictures
		        Return New WebServer.HttpResponse(200, "text/plain", Str(PictureFiles.Count))
		        
		        // load pictures
		      Case "reload"
		        ReadFiles
		        Return New WebServer.HttpResponse(200, "text/plain", Str(PictureFiles.Count))
		        
		        // show next picture
		      Case "next"
		        NextPicture
		        Return New WebServer.HttpResponse(200, "text/plain", CurrentPictureName)
		        
		        // read and apply config and load pictures
		      Case "config"
		        Init
		        Return New WebServer.HttpResponse(200)
		        
		        // shutdown raspberry
		      Case "shutdown"
		        If Helper.ExecuteCommand(Config.ShutdownCommand) <> 0 Then
		          Return New WebServer.HttpResponse(500, "text/plain", Helper.LastCommandResult)
		        End
		        Return New WebServer.HttpResponse(200)
		        
		        // reboot raspberry
		      Case "reboot"
		        If Helper.ExecuteCommand(Config.RebootCommand) <> 0 Then
		          Return New WebServer.HttpResponse(500, "text/plain", Helper.LastCommandResult)
		        End
		        Return New WebServer.HttpResponse(200)
		        
		        // turn screen on
		      Case "screenon"
		        If Helper.ExecuteCommand(Config.ScreenOnCommand) <> 0 Then
		          Return New WebServer.HttpResponse(500, "text/plain", Helper.LastCommandResult)
		        End
		        Return New WebServer.HttpResponse(200)
		        
		        // turn screen off
		      Case "screenoff"
		        If Helper.ExecuteCommand(Config.ScreenOffCommand) <> 0 Then
		          Return New WebServer.HttpResponse(500, "text/plain", Helper.LastCommandResult)
		        End
		        Return New WebServer.HttpResponse(200)
		        
		        // quit app
		      Case "quit"
		        Self.Close
		        Return New WebServer.HttpResponse(200)
		        
		        // return raspberry status
		      Case "info"
		        Return New WebServer.HttpResponse(200, "text/plain", BuildInfoString)
		        
		        // delete current picture file 
		      Case "deletecurrent"
		        Var r As String = DeleteCurrentPicture
		        If r = "OK" Then
		          Return New WebServer.HttpResponse(200, "text/plain", r)
		        Else
		          Return New WebServer.HttpResponse(500, "text/plain", r)
		        End
		        
		        // return error
		      Else
		        Return New WebServer.HttpResponse(404, "text/plain", "unknown API command")
		        
		      End
		      
		    Else
		      // return file data
		      
		      Var docRoot As folderitem = SpecialFolder.Resources
		      
		      If docRoot <> Nil And docRoot.IsFolder Then
		        If query = "/" Then query = "index.html"
		        
		        Var f As FolderItem = docroot.Child(query)
		        
		        If f <> Nil And f.Exists Then
		          Select Case f.Extension.Lowercase
		            
		          Case ".htm", ".html"
		            Var data As String = f.ReadAllText 
		            Return New WebServer.HttpResponse(200, "text/html", data)
		            
		          Case ".js"
		            Var data As String = f.ReadAllText 
		            Return New WebServer.HttpResponse(200, "application/javascript", data)
		            
		          Case ".css"
		            Var data As String = f.ReadAllText 
		            Return New WebServer.HttpResponse(200, "text/css", data)
		            
		          Case ".png"
		            Var data As MemoryBlock = f.ReadAllData 
		            Return New WebServer.HttpResponse(200, "image/png", data)
		            
		          Else
		            // unsupported media type
		            Return New WebServer.HttpResponse(415) 
		            
		          End
		        Else
		          Logging.Debug("Document " + query + " not found.")
		          Return New WebServer.HttpResponse(404, "text/plain", query)
		        End
		      Else
		        Logging.Error("DocRoot not found.")
		        Return New WebServer.HttpResponse(500, "text/plain", "DocRoot not found " + docRoot.NativePath)
		      End
		      
		    End 
		    
		  Catch e As RuntimeException
		    Return New WebServer.HttpResponse(500, "Failure: " + e.Message + " " + e.Reason)
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Init()
		  Self.MouseCursor = System.Cursors.InvisibleCursor
		  
		  Config.ReadConfig
		  
		  Logging.Prefix = "RaspberryFrame"
		  
		  #If Not DebugBuild Then
		    Self.FullScreen = True
		  #EndIf
		  
		  Self.Top = 0
		  
		  ReadFiles
		  
		  NextPicture
		  
		  TimerChangePicture.Period = 1000 * Config.PictureChangeIntervalSec
		  TimerChangePicture.Enabled = True
		  TimerFadePicture.Period = Config.FadeTimer
		  
		  TimerClock.Enabled = Config.ShowClock
		  
		  StartWebServer
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NextPicture()
		  If PictureFiles <> Nil And PictureFiles.Count > 0 Then
		    
		    TimerChangePicture.Enabled = False
		    
		    Try
		      
		      Var f As FolderItem = New Folderitem(PictureFiles(CurrentPictureIndex), FolderItem.PathModes.Native)
		      
		      Logging.Info("Current picture: " + f.Name)
		      
		      CurrentPictureName = f.Name
		      
		      If Config.FadePictures Then
		        NextPicture = ReadScaledPicture(f)
		        TimerFadePicture.Enabled = True
		      Else
		        CurrentPicture = ReadScaledPicture(f)
		        canvasScreen.Refresh
		        TimerFadePicture.Enabled = False
		      End
		      
		      f = Nil
		      
		      CurrentPictureIndex = CurrentPictureIndex + 1
		      If CurrentPictureIndex >= PictureFiles.Count Then
		        CurrentPictureIndex = 0
		        RandomizePictures
		      End
		      
		    Catch e As RuntimeException
		      Logging.Error("Cannot create picture. " + e.Message + " " + e.Reason)
		    End
		    
		    TimerChangePicture.Enabled = True
		    
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PaintClock(g as Graphics)
		  g.FontName = Config.ClockFont
		  g.FontSize = Config.ClockSize
		  
		  Var d As DateTime = DateTime.Now
		  Var time As String = Str(d.Hour, "00") + ":" + Str(d.Minute, "00")
		  Var tw As Double = g.TextWidth(time)
		  Var tx As Double = Config.ClockLeft
		  Var ty As Double = Config.ClockTop
		  
		  Var td As Integer = 8
		  g.Transparency = 60
		  g.DrawingColor = &cfefefe
		  g.FillRoundRectangle(tx - td, ty - g.FontSize + td, tw + 2*td, g.FontSize, td, td) 
		  
		  g.Transparency = 0
		  g.DrawingColor = Config.ClockColor
		  g.DrawText(time, tx, ty)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PaintPicture(g as Graphics, p as picture, transparency as Double)
		  Var w As Integer = g.Width
		  Var h As Integer = (p.Height * g.Width / p.Width)
		  
		  Var x As Integer = (g.Width/2 - w/2)
		  Var y As Integer = (g.Height/2 - h/2)
		  
		  g.Transparency = transparency
		  
		  g.DrawPicture(p, x, y, w, h, 0, 0, p.Width, p.Height)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RandomizePictures()
		  PictureFiles.Shuffle
		  
		  Logging.Info("Pictures ranomized.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReadFiles()
		  If Config.PicturesFolder <> Nil And Config.PicturesFolder.Exists Then
		    
		    PictureFiles.RemoveAllRows
		    
		    For Each  f As folderitem In Config.PicturesFolder.Children
		      If Not f.name.BeginsWith(".") Then
		        If f.Extension.Lowercase = ".png" Or f.Extension.Lowercase = ".jpg" Or f.Extension.Lowercase = ".jpeg" Then 
		          PictureFiles.AddRow(f.NativePath)
		        End
		      End
		    Next
		    
		    Logging.Info(Str(PictureFiles.Count) + " files found.")
		    
		    RandomizePictures
		    
		  End
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadScaledPicture(f as FolderItem) As Picture
		  Var p As picture = Picture.Open(f)
		  
		  Var sp As Picture = New Picture(Screen(0).Width, Screen(0).Height)
		  PaintPicture(sp.Graphics, p, 0)
		  
		  p = Nil
		  
		  Return sp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartWebServer()
		  WebServer.StartWebServer(Config.WebServerPort)
		  WebServer.ProcessRequest = AddressOf ExecuteRemoteCommand
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private CurrentPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private CurrentPictureIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private CurrentPictureName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NextPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PictureFiles() As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Transparency As Double = 100
	#tag EndProperty


	#tag Enum, Name = TcpCommand, Type = Integer, Flags = &h21
		Shuffle = 100
		  Reload = 200
		Current = 300
	#tag EndEnum


#tag EndWindowCode

#tag Events canvasScreen
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  If CurrentPicture <> Nil Then
		    PaintPicture(g, CurrentPicture, 0.0)
		  End
		  
		  If NextPicture <> Nil and Config.FadePictures Then
		    PaintPicture(g, NextPicture, Transparency)
		  End
		  
		  If Config.ShowClock Then
		    PaintClock(g)
		  End
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  NextPicture
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events TimerChangePicture
	#tag Event
		Sub Action()
		  NextPicture
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TimerFadePicture
	#tag Event
		Sub Action()
		  Transparency = Transparency - 5
		  
		  If Transparency <= 0 Then
		    Logging.Info("FadeTimer off.")
		    Transparency = 100
		    TimerFadePicture.Enabled = False
		    CurrentPicture = NextPicture
		    NextPicture = Nil
		  End
		  
		  canvasScreen.Refresh
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TimerClock
	#tag Event
		Sub Action()
		  canvasScreen.Invalidate
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
