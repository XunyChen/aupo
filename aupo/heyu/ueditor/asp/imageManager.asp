<%@ LANGUAGE="VBSCRIPT" CODEPAGE="936" %> 
<%
    Session.CodePage = 936
    Response.AddHeader "Content-Type", "text/html;charset=gbk"
    SetLocale 2052

    Dim action, path, seperator, fso, folder

    path = "upload/"
    action = Request.Form("action")
    seperator = "ue_separate_ue"

    If action = "get" Then
    	Set fso = Server.CreateObject("Scripting.FileSystemObject")
        If fso.FolderExists(Server.MapPath(path)) = False Then
            Response.Write ""
        Else
        	Set folder = fso.GetFolder(Server.MapPath(path))
        	For Each subFolder In folder.SubFolders
        		For Each file In subFolder.Files
        			Response.Write path + subFolder.Name + "/" + file.Name + seperator
        		Next
        	Next
        End If
    End If
%>