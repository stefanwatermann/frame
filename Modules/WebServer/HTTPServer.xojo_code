#tag Class
Private Class HTTPServer
Inherits ServerSocket
	#tag Event
		Function AddSocket() As TCPSocket
		  // Create a new HTTPConnection socket
		  // to pass back to the server
		  Dim s As HttpConnection
		  s = New HttpConnection
		  
		  // Be sure to set it's root directory
		  // so that it can serve the pages correctly
		  s.RootDir = rootDir
		  
		  // Hand it back to the server
		  Return s
		End Function
	#tag EndEvent

	#tag Event
		Sub Error(ErrorCode As Integer, err As RuntimeException)
		  // We got some sort of error, so report it
		  // back to the user
		  Logging.Error("Server Error: " + Str(ErrorCode))
		  
		  // Stop listening because we hit an error condition;
		  // we want the user to restart us if they want to
		  Self.StopListening
		  
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h0
		#tag Note
			This holds the root directory that the server is
			holding on to.  All connections will be using this
			as the base directory in which to find the content
		#tag EndNote
		rootDir As FolderItem
	#tag EndProperty


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
			InitialValue=""
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
			Name="Port"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumSocketsAvailable"
			Visible=true
			Group="Behavior"
			InitialValue="2"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaximumSocketsConnected"
			Visible=true
			Group="Behavior"
			InitialValue="10"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
