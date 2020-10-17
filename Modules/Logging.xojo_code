#tag Module
Protected Module Logging
	#tag Method, Flags = &h0
		Sub Debug(message as string)
		  System.Log(System.LogLevelDebug, "[" + Logging.Prefix + "] " + message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Error(error as RuntimeException)
		  System.Log(System.LogLevelError, "[" + Logging.Prefix + "] " + "ERROR: " + error.Message + " " + error.Reason)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Error(message as string)
		  System.Log(System.LogLevelError, "[" + Logging.Prefix + "] " + "ERROR: " + message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Info(message as string)
		  System.Log(System.LogLevelInformation, "[" + Logging.Prefix + "] " + message)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Prefix As string = "App"
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
	#tag EndViewBehavior
End Module
#tag EndModule
