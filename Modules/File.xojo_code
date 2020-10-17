#tag Module
Protected Module File
	#tag Method, Flags = &h0
		Function Extension(extends f as FolderItem) As string
		  Var ext As String = "." + f.name.NthField(".", f.name.CountFields("."))
		  return ext
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadAllData(Extends f as FolderItem) As MemoryBlock
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadAllText(extends file as FolderItem) As string
		  return file.ReadAllText(Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadAllText(extends file as FolderItem, encoding as TextEncoding) As string
		  Var t As TextInputStream
		  Var result As String
		  t = TextInputStream.Open(file)
		  t.Encoding = Encoding
		  result = t.ReadAll
		  t.Close
		  Return result
		End Function
	#tag EndMethod


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
