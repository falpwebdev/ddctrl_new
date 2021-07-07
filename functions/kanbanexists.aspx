<%@ Page Language="VB" AutoEventWireup="false" CodeFile="kanbanexists.aspx.vb" Inherits="functions_kanbanexists" %>

<%@ Import Namespace="System.Data.OleDb" %>

<% 

    Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
    Dim connection As OleDbConnection = New OleDbConnection(connectionString)
    Dim kbn As String = Request.Form("kbn")
    Dim maker As String = Request.Form("maker")
    Dim bunrui As String = Request.Form("bunrui")
    Dim result As String = ""
    Try
        connection.Open()
        
        If bunrui = "TENKAI" Then
            Dim sql As String = "SELECT Kanban_No FROM T_BASE a WHERE a.Kanban_No = ? AND a.MAKER = ? AND a.Kanban_No <> 0 AND a.BUNRUI = ?"
        
            Dim cmd As New OleDbCommand(sql, connection)
            cmd.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = kbn
            cmd.Parameters.Add("@MAKER", OleDbType.VarChar).Value = maker
            cmd.Parameters.Add("@BUNRUI", OleDbType.VarChar).Value = bunrui
            result = cmd.ExecuteScalar()
        Else
            Dim sql As String = "SELECT Kanban_No FROM T_BASE a WHERE a.Kanban_No = ? AND a.Kanban_No <> 0 AND a.BUNRUI = ?"
            Dim cmd As New OleDbCommand(sql, connection)
            cmd.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = kbn
            cmd.Parameters.Add("@BUNRUI", OleDbType.VarChar).Value = bunrui
            result = cmd.ExecuteScalar()
        End If
        
        
        Response.Write(result)
        connection.Close()
    Catch ex As Exception
        Response.Write(ex.ToString())
    End Try
%>