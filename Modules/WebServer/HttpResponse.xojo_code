#tag Class
Protected Class HttpResponse
	#tag Method, Flags = &h0
		Sub Constructor(status as integer)
		  Self.Status = MapStatus(status)
		  Self.ContentType = "text/plain"
		  Self.StringData = ""
		  Self.BinaryData = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(status as integer, textMessage as string)
		  Self.Status = MapStatus(status)
		  Self.ContentType = "text/plain"
		  Self.StringData = textMessage
		  Self.BinaryData = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(status as integer, contentType as string, binaryData as MemoryBlock)
		  Self.Status = MapStatus(status)
		  Self.ContentType = contentType
		  Self.StringData = ""
		  Self.BinaryData = binaryData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(status as integer, contentType as string, stringData as string)
		  Self.Status = MapStatus(status)
		  Self.ContentType = contentType
		  Self.StringData = stringData
		  Self.BinaryData = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MapStatus(status as integer) As string
		  Select Case status
		    
		  Case 200
		    Return "200 OK"
		    
		  Case 404
		    Return "404 Not Found"
		    
		  Case 415
		    return "415 Unsupported Media Type"
		    
		  Case 500
		    Return "500 Server Error"
		    
		  Else
		    Return "501 not implemented"
		  End
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		BinaryData As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h0
		ContentType As String = "text/html"
	#tag EndProperty

	#tag Property, Flags = &h0
		Status As String = "200"
	#tag EndProperty

	#tag Property, Flags = &h0
		StringData As String
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
		#tag ViewProperty
			Name="ContentType"
			Visible=false
			Group="Behavior"
			InitialValue="text/html"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Status"
			Visible=false
			Group="Behavior"
			InitialValue="200"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StringData"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
