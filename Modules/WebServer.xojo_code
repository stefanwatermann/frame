#tag Module
Protected Module WebServer
	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ProcessRequestDelegate(query as string) As WebServer.HttpResponse
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub StartWebServer(port as integer)
		  If mWebServer = Nil Then
		    mWebServer = New HttpServer
		  End If
		  
		  mWebServer.Port = port
		  mWebServer.MinimumSocketsAvailable = 10
		  mWebServer.Listen
		  
		  Logging.Info("Web-Server listening on port " + Str(mWebServer.Port))
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mWebServer As WebServer.HTTPServer
	#tag EndProperty

	#tag Property, Flags = &h0
		ProcessRequest As ProcessRequestDelegate
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
