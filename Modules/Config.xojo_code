#tag Module
Protected Module Config
	#tag Method, Flags = &h0
		Sub ReadConfig()
		  
		  Try
		    Var configFile As FolderItem = SpecialFolder.Resources.Child(kConfigFileName)
		    
		    If configFile <> Nil And configFile.Exists And Not configFile.IsFolder Then
		      
		      Var json As String = configFile.ReadAllText()
		      Var config As New JSONItem
		      config.Load(json)
		      
		      If config.HasName("WebServerPort") Then
		        WebServerPort = config.Value("WebServerPort").IntegerValue
		      End
		      
		      If config.HasName("PicturesFolder") Then
		        Var folderName As String = config.Value("PicturesFolder").StringValue.Trim
		        PicturesFolder = New FolderItem(folderName, FolderItem.PathModes.Native)
		      End
		      
		      If config.HasName("FadePictures") Then
		        FadePictures = config.Value("FadePictures").BooleanValue
		      End
		      
		      If config.HasName("ShowClock") Then
		        ShowClock = config.Value("ShowClock").BooleanValue
		      End
		      
		      If StringValueNotEmpty(config, "ClockColor") Then
		        ClockColor = config.Value("ClockColor").ColorValue
		      End
		      
		      If config.HasName("ClockFont") Then
		        ClockFont = config.Value("ClockFont").StringValue
		      End
		      
		      If config.HasName("ClockSize") Then
		        ClockSize = config.Value("ClockSize").IntegerValue
		      End
		      
		      If config.HasName("ClockLeft") Then
		        ClockLeft = config.Value("ClockLeft").IntegerValue
		      End
		      
		      If config.HasName("ClockTop") Then
		        ClockTop = config.Value("ClockTop").IntegerValue
		      End
		      
		      If config.HasName("FadeTimer") Then
		        FadeTimer = config.Value("FadeTimer").IntegerValue
		      End
		      
		      If config.HasName("PictureChangeIntervalSec") Then
		        PictureChangeIntervalSec = config.Value("PictureChangeIntervalSec").IntegerValue
		      End
		      
		      If StringValueNotEmpty(config, "ScreenOffCommand") Then
		        ScreenOffCommand = config.Value("ScreenOffCommand").StringValue
		      End
		      
		      If StringValueNotEmpty(config, "ScreenOnCommand") Then
		        ScreenOnCommand = config.Value("ScreenOnCommand").StringValue
		      End
		      
		      If StringValueNotEmpty(config, "ShutdownCommand") Then
		        ShutdownCommand = config.Value("ShutdownCommand").StringValue
		      End
		      
		      If StringValueNotEmpty(config, "RebootCommand") Then
		        RebootCommand = config.Value("RebootCommand").StringValue
		      End
		      
		    Else
		      Logging.Error("Cannot read config-file '" + configFile.NativePath + "'.")
		    End
		    
		  Catch e As RuntimeException
		    Logging.Error(e)
		  End
		  
		  Logging.Info("PicturesFolder: " + PicturesFolder.NativePath)
		  Logging.Info("PictureChangeIntervalSec: " + Str(PictureChangeIntervalSec))
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function StringValueNotEmpty(item as JSONItem, name as string) As Boolean
		  Return (item.HasName(name) And item.Value(name).StringValue.Length > 0)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ClockColor As Color = &c0f0f0f
	#tag EndProperty

	#tag Property, Flags = &h0
		ClockFont As string = "Arial"
	#tag EndProperty

	#tag Property, Flags = &h0
		ClockLeft As Integer = 300
	#tag EndProperty

	#tag Property, Flags = &h0
		ClockSize As Integer = 50
	#tag EndProperty

	#tag Property, Flags = &h0
		ClockTop As Integer = 300
	#tag EndProperty

	#tag Property, Flags = &h0
		FadePictures As Boolean = true
	#tag EndProperty

	#tag Property, Flags = &h0
		FadeTimer As Integer = 20
	#tag EndProperty

	#tag Property, Flags = &h0
		PictureChangeIntervalSec As Integer = 5
	#tag EndProperty

	#tag Property, Flags = &h0
		PicturesFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		RebootCommand As String = "sudo reboot"
	#tag EndProperty

	#tag Property, Flags = &h0
		ScreenOffCommand As String = "sudo bash -c ""echo 1 > /sys/class/backlight/rpi_backlight/bl_power"""
	#tag EndProperty

	#tag Property, Flags = &h0
		ScreenOnCommand As String = "sudo bash -c ""echo 0 > /sys/class/backlight/rpi_backlight/bl_power"""
	#tag EndProperty

	#tag Property, Flags = &h0
		ShowClock As Boolean = true
	#tag EndProperty

	#tag Property, Flags = &h0
		ShutdownCommand As String = "sudo shutdown -h now"
	#tag EndProperty

	#tag Property, Flags = &h0
		WebServerPort As Integer = 9001
	#tag EndProperty


	#tag Constant, Name = kConfigFileName, Type = String, Dynamic = False, Default = \"RaspiFrame.config", Scope = Public
	#tag EndConstant


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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PictureChangeIntervalSec"
			Visible=false
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClockColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c0f0f0f"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClockFont"
			Visible=false
			Group="Behavior"
			InitialValue="Arial"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClockSize"
			Visible=false
			Group="Behavior"
			InitialValue="50"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowClock"
			Visible=false
			Group="Behavior"
			InitialValue="true"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClockLeft"
			Visible=false
			Group="Behavior"
			InitialValue="300"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClockTop"
			Visible=false
			Group="Behavior"
			InitialValue="300"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FadeTimer"
			Visible=false
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RebootCommand"
			Visible=false
			Group="Behavior"
			InitialValue="sudo reboot"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScreenOffCommand"
			Visible=false
			Group="Behavior"
			InitialValue="sudo bash -c """"echo 1 > /sys/class/backlight/rpi_backlight/bl_power"""""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScreenOnCommand"
			Visible=false
			Group="Behavior"
			InitialValue="sudo bash -c """"echo 0 > /sys/class/backlight/rpi_backlight/bl_power"""""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShutdownCommand"
			Visible=false
			Group="Behavior"
			InitialValue="sudo shutdown -h now"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WebServerPort"
			Visible=false
			Group="Behavior"
			InitialValue="9001"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
