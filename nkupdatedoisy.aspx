<%@ Page Language="VB" AutoEventWireup="false" CodeFile="nkupdatedoisy.aspx.vb" Inherits="nkupdatedoisy" %>

<%@ Import Namespace="System.Data.OleDb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Doisy</title>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <%
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
        Dim connection As OleDbConnection = New OleDbConnection(connectionString)
        Dim mname As String = ""
        Dim id As Integer = 0
        
        If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
            id = Request.QueryString("id")

            Dim check As String = "SELECT COUNT(ID) FROM T_DOISY WHERE ID = ?"
            connection.Open()
            Dim checkcmd As New OleDbCommand(check, connection)
            checkcmd.Parameters.Add("@ID", OleDbType.Integer).Value = id
            Dim exists As String = checkcmd.ExecuteScalar()
            connection.Close()
            If exists = 0 Then
                Response.Write("<script>alert('No data found!'); window.close();</script>")
            End If
            
            Try
                connection.Open()
                Dim sql As String = "SELECT a.M_NAME FROM T_BASE a WHERE a.ID = ?"
                Dim cmd As New OleDbCommand(sql, connection)
                cmd.Parameters.Add("@ID", OleDbType.Integer).Value = id
                mname = cmd.ExecuteScalar().ToString()
                connection.Close()
            Catch ex As Exception
                Response.Write(ex.ToString())
            End Try
        End If
        
        If Not String.IsNullOrEmpty(Request.Form("did")) Then
            Dim did As String = Request.Form("did")
            Dim doisy As String = Request.Form("doisy")
            Dim dnum As String = Request.Form("dnum")
            Dim remark As String = Request.Form("remark")
            Dim ended As String = Request.Form("ended")
            
            'Response.Write(Request.Form.ToString())
            Try
                connection.Open()
                    
                Dim sql As String = "UPDATE T_DOISY SET STATUS=?,DNUM=?,REMARKS=?,ENDED=?,L_UPDATE=NOW() WHERE DID = ?"
                Dim cmd As New OleDbCommand(sql, connection)
                cmd.Parameters.Add("@STATUS", OleDbType.Integer).Value = doisy
                    
                If String.IsNullOrEmpty(dnum) Then
                    cmd.Parameters.Add("@DNUM", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@DNUM", OleDbType.VarChar).Value = dnum
                End If
                    
                If String.IsNullOrEmpty(remark) Then
                    cmd.Parameters.Add("@REMARKS", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@REMARKS", OleDbType.VarChar).Value = remark
                End If
                    
                If String.IsNullOrEmpty(ended) Then
                    cmd.Parameters.Add("@ENDED", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@ENDED", OleDbType.Date).Value = ended
                End If
                    
                cmd.Parameters.Add("@did", OleDbType.Integer).Value = did
                cmd.ExecuteNonQuery()

                Dim sql2 As String = ""
                If Not String.IsNullOrEmpty(ended) Then
                    sql2=  "UPDATE T_DOISY SET flag = 1 WHERE DID = ?"
                Else
                    sql2 = "UPDATE T_DOISY SET flag = 0 WHERE DID = ?"
                End If
                
                Dim cmd2 As New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@DID", OleDbType.Integer).Value = did
                cmd2.ExecuteNonQuery()
                
                connection.Close()
                
                If doisy = "2" Then
                    connection.Open()
                    Dim sql3 As String = ""
                    sql3 = "SELECT ID FROM T_DOISY WHERE T_DOISY.DID = ?"
                    Dim cmd3 As New OleDbCommand(sql3, connection)
                    cmd3.Parameters.Add("@DID", OleDbType.Integer).Value = did
                    Dim tbase_id = cmd3.ExecuteScalar()
                    
                    Dim sql4 As String = ""
                    sql4 = "UPDATE T_TENKAI SET DOISY = 0 WHERE ID = ?"
                    Dim cmd4 As New OleDbCommand(sql4, connection)
                    cmd4.Parameters.Add("@ID", OleDbType.Integer).Value = tbase_id
                    cmd4.ExecuteNonQuery()
                    
                    Dim sql5 As String = ""
                    sql5 = "DELETE FROM T_DOISY WHERE ID = ?"
                    Dim cmd5 As New OleDbCommand(sql5, connection)
                    cmd5.Parameters.Add("@ID", OleDbType.Integer).Value = tbase_id
                    cmd5.ExecuteNonQuery()
                    connection.Close()
                    
                ElseIf doisy  = "1" Then
                    connection.Open()
                    Dim sql3 As String = ""
                    sql3 = "SELECT ID FROM T_DOISY WHERE T_DOISY.DID = ?"
                    Dim cmd3 As New OleDbCommand(sql3, connection)
                    cmd3.Parameters.Add("@DID", OleDbType.Integer).Value = did
                    Dim tbase_id = cmd3.ExecuteScalar()
                    
                    Dim sql4 As String = ""
                    sql4 = "UPDATE T_TENKAI SET DOISY = 1 WHERE ID = ?"
                    Dim cmd4 As New OleDbCommand(sql4, connection)
                    cmd4.Parameters.Add("@ID", OleDbType.Integer).Value = tbase_id
                    cmd4.ExecuteNonQuery()
                    connection.Close()
                End If
                
                connection.Open()
                Dim updateTime As String = "UPDATE T_BASE SET L_UPDATE = NOW() WHERE ID = ?"
                Dim cmdUpdate As New OleDbCommand(updateTime, connection)
                cmdUpdate.Parameters.Add("@ID", OleDbType.Integer).Value = id
                cmdUpdate.ExecuteNonQuery()
                connection.Close()
                
                'Response.Write("<script>alert('Edit success')</script>")
                'Response.Write("<div class='alert alert-success'><strong><i class='fa fa-check'></i></strong> Successfully Updated. <i class='fa fa-smile-o'></i></div>")
            Catch ex As Exception
                Response.Write(ex.ToString())
            End Try
        End If
        
        
    %>

    <%
        If String.IsNullOrEmpty(Request.Form("did")) Then
    %>

    <section class="section">
        <div class="row">
            <div class="col-md-12">
                <h3>Doisy Control information update</h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h4><b>Model Name:</b> <% =mname %></h4>
            </div>
        </div>

        <form class="" method="post">

            <table class="table-nkupdate update2">
                <thead>
                    <tr>
                        <th>Having or not</th>
                        <th>Doisy No.</th>
                        <th>Remarks</th>
                        <th>Finished Date</th>
                    </tr>
                    
                </thead>
                <tbody>
                <%
                    If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
                        
                        Dim did As String = ""
                        Dim kanban_no As String = ""
                        Dim doisy As String = ""
                        Dim dnum As String = ""
                        Dim remark As String = ""
                        Dim ended As String = ""
                        Dim l_update As String = ""
                        Dim flag As String = ""
                        
                        Dim sql As String = "SELECT did,ID,STATUS,DNUM,REMARKS,ENDED,l_update,flag FROM T_DOISY WHERE ID = ?"
                        Try
                           
                            connection.Open()
                            Dim cmd As New OleDbCommand(sql, connection)
                            cmd.Parameters.Add("@ID", OleDbType.Integer).Value = id
                            Dim reader = cmd.ExecuteReader
            
                            While reader.Read()
                                did = reader.Item("did").ToString()
                                doisy = reader.Item("STATUS").ToString
                                dnum = reader.Item("DNUM").ToString()
                                remark = reader.Item("REMARKS").ToString()

                                ended = String.Format("{0:yyyy/MM/dd}", reader.Item("ENDED"))
                                l_update = String.Format("{0:yyyy/MM/dd}", reader.Item("l_update"))
                                
                                flag = reader.Item("FLAG").ToString()
                                %>
                                <tr>
                                    <td class="hide"><input type="text" class="form-control" name="did" value="<% =did %>"></td>
                                    <td>
                                        <select name="doisy" class="form-control">
                                            <option value="1">Yes</option>
                                            <option value="2">No</option>
                                        </select>
                                    </td>
                                    <td><input type="text" class="form-control" name="dnum" value="<% =dnum%>"></td>
                                    <td><input type="text" class="form-control" name="remark" value="<% =remark%>"></td>
                                    <td><input type="text" class="form-control" name="ended" value="<% =ended %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                                </tr>
                                <%
                            End While
                            reader.Close()
                            connection.Close()
                        Catch ex As Exception
                            Response.Write(ex.ToString())
                        End Try
                    End If
                %>
                </tbody>
            </table>
            
            <br>
            <input type="submit" class="btn btn-primary" name="submit" value="Save">
            <input type="button" class="btn btn-default" onclick="window.close()" value="Cancel">
        </form>

    </section>

    <%
        End If
    %>

    <%
        If Not String.IsNullOrEmpty(Request.Form("did")) Then
    %>
        <div class="row">
            <div class="col-xs-12 text-center">
                <div class='alert alert-success'>
                    <strong><i class='fa fa-check'></i></strong> 
                    Successfully Updated. <i class='fa fa-smile-o'></i>
                </div>
                <h6>Click the 'close' button to close the window.</h6>
                <a class="btn btn-default" onclick="window.close()">Close</a>
            </div>
        </div>
        
    <%
        End If
    %>

    <script type="text/javascript" src="jquery/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="moment-js/moment.min.js"></script>
    <script type="text/javascript" src="script.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {


        });
    </script>
</body>
</html>
