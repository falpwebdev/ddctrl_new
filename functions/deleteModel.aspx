<%@ Page Language="VB" AutoEventWireup="false" CodeFile="deleteModel.aspx.vb" Inherits="functions_deleteModel" %>

<%@ Import Namespace="System.Data.OleDb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Delete Model</title>
    <meta http-equiv="content-type" content="text/html; charset=Shift_JIS">
    <link href="../font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <%
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
        Dim connection As OleDbConnection = New OleDbConnection(connectionString)
        
        If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
            Dim id As Integer = Request.QueryString("id")
            connection.Open()
            Try
                Dim sql As String = "DELETE FROM T_BASE WHERE ID = ?"
                Dim cmd As New OleDbCommand(sql, connection)
                cmd.Parameters.Add("@ID", OleDbType.Integer).Value = id
                cmd.ExecuteNonQuery()
                
                Dim sql2 As String = "DELETE FROM T_TENKAI WHERE ID = ?"
                Dim cmd2 As New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                cmd2.ExecuteNonQuery()
                
                sql2 = "DELETE FROM T_NPARTS WHERE ID = ?"
                cmd2 = New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                cmd2.ExecuteNonQuery()
                
                sql2 = "DELETE FROM T_QUERY WHERE ID = ?"
                cmd2 = New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                cmd2.ExecuteNonQuery()
                
                sql2 = "DELETE FROM T_REPORT WHERE ID = ?"
                cmd2 = New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                cmd2.ExecuteNonQuery()
                
                sql2 = "DELETE FROM T_MAIL WHERE ID = ?"
                cmd2 = New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                cmd2.ExecuteNonQuery()
                
                sql2 = "DELETE FROM T_ETC WHERE ID = ?"
                cmd2 = New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                cmd2.ExecuteNonQuery()
                
                sql2 = "DELETE FROM T_DOISY WHERE ID = ?"
                cmd2 = New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                cmd2.ExecuteNonQuery()
                connection.Close()
                
                %>

                <div class="row">
                    <div class="col-xs-12 text-center">
                        <div class='alert alert-success'>
                            <strong><i class='fa fa-check'></i></strong> 
                            Successfully Deleted. <i class='fa fa-smile-o'></i>
                        </div>
                        <h6>Click the 'close' button to close the window.</h6>
                        <a class="btn btn-default" onclick="window.close()">Close</a>
                    </div>
                </div>

                <%
            Catch ex As Exception
                Response.Write(ex.ToString())
            End Try
            
        End If
    %>
</body>
</html>
