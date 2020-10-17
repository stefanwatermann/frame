#tag Class
Private Class HTTPConnection
Inherits TCPSocket
	#tag Event
		Sub DataAvailable()
		  // Read in everything from the internal buffers
		  // and process the data
		  ProcessHeaders(Self.ReadAll)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SendComplete(userAborted as Boolean)
		  #Pragma Unused userAborted
		  
		  // Due to the HTTP spec we adhere to, we're
		  // required to close the connection once we've
		  // finished sending you the page.
		  Self.Close
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function ConvertURLString(url As String) As String
		  Dim x As Integer
		  Dim temp, encStr As String
		  
		  // covert out hex values from the url string
		  temp = url
		  Do
		    x = InStr(temp, "%") // hex values start with '%'
		    If x = 0 Then // no encoding found
		      Exit
		    End If
		    
		    encStr = Mid(temp, x + 1, 2)
		    encStr = Chr(Val("&h" + encStr))
		    
		    temp = Left(temp, x - 1) + encStr + Mid(temp, x + 3)
		  Loop
		  
		  Return temp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ProcessHeaders(headers as string)
		  Dim temp, cmd, param As String
		  
		  // parse out the header data
		  temp = NthField(headers, Chr(13), 1)
		  cmd = NthField(temp, " ", 1)
		  param = NthField(temp, " ", 2)
		  
		  If cmd = "GET" Then // we got a get command
		    
		    Var data As String
		    Var status As String = "200 OK"
		    Var contentType As String = "text/html"
		    
		    If ProcessRequest <> Nil Then
		      Var response As WebServer.HttpResponse = ProcessRequest.Invoke(param)
		      status = response.Status
		      contentType = response.ContentType
		      If response.BinaryData <> Nil Then
		        data = response.BinaryData
		      Else
		        data = response.StringData
		      End
		    End
		    
		    // Add HTTP headers
		    Self.Write("HTTP/1.1 " + status + Chr(13) + Chr(10))
		    Self.Write("Content-Type: " + contentType + Chr(13) + Chr(10))
		    Self.Write("Content-Length: " + Str(data.Length) + Chr(13) + Chr(10))
		    Self.Write("Connection: close" + Chr(13) + Chr(10) + Chr(13) + Chr(10))
		    
		    // Write out the contents of the file to the remote side
		    Self.Write(data)
		    
		  End
		  
		  If cmd = "POST" Then
		    Var data As String = temp
		    Logging.Info("data received")
		  End
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		RootDir As FolderItem
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
			Name="Address"
			Visible=true
			Group="Behavior"
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
	#tag EndViewBehavior
End Class
#tag EndClass
