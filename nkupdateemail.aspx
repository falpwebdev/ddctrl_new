<%@ Page Language="VB" AutoEventWireup="false" CodeFile="nkupdateemail.aspx.vb" Inherits="nkupdateemail" %>

<%@ Import Namespace="System.Data.OleDb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Confirmation by E-mail</title>
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

            Dim check As String = "SELECT COUNT(ID) FROM T_MAIL WHERE ID = ?"
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
            Dim did() As String = Request.Form.GetValues("did")
            Dim kanban_no() As String = Request.Form.GetValues("kanban_no")
            Dim n_mail() As String = Request.Form.GetValues("n_mail")
            Dim n_mdate() As String = Request.Form.GetValues("n_mdate")
            Dim n_pdate() As String = Request.Form.GetValues("n_pdate")
            Dim apply() As String = Request.Form.GetValues("apply")
            Dim check1() As String = Request.Form.GetValues("check1")
            Dim check2() As String = Request.Form.GetValues("check2")
            Dim chkreq() As String = Request.Form.GetValues("chkreq")
            Dim ended() As String = Request.Form.GetValues("ended")
            
            Try
                Dim temp As Integer = Convert.ToInt32(did.Length) - 1
                connection.Open()
                For i As Integer = 0 To temp
                    
                    Dim sql As String = "UPDATE T_MAIL SET Kanban_No=?,N_MAIL=?,N_MDATE=?,N_PDATE=?,apply=?,check1=?,check2=?,chkreq=?,ended=? WHERE did = ?"
                    Dim cmd As New OleDbCommand(sql, connection)
                    
                    If String.IsNullOrEmpty(apply(i)) Then
                        cmd.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = kanban_no(i)
                    Else
                        cmd.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = 0
                    End If
                    
                    If String.IsNullOrEmpty(n_mail(i)) Then
                        cmd.Parameters.Add("@N_MAIL", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd.Parameters.Add("@N_MAIL", OleDbType.VarChar).Value = n_mail(i)
                    End If
                    
                    If String.IsNullOrEmpty(n_mdate(i)) Then
                        cmd.Parameters.Add("@N_MDATE", OleDbType.Date).Value = DBNull.Value
                    Else
                        cmd.Parameters.Add("@N_MDATE", OleDbType.Date).Value = n_mdate(i)
                    End If
                    
                    If String.IsNullOrEmpty(n_pdate(i)) Then
                        cmd.Parameters.Add("@N_PDATE", OleDbType.Date).Value = DBNull.Value
                    Else
                        cmd.Parameters.Add("@N_PDATE", OleDbType.Date).Value = n_pdate(i)
                    End If
                    
                    If String.IsNullOrEmpty(apply(i)) Then
                        cmd.Parameters.Add("@apply", OleDbType.Date).Value = DBNull.Value
                    Else
                        cmd.Parameters.Add("@apply", OleDbType.Date).Value = apply(i)
                    End If
  
                    If String.IsNullOrEmpty(check1(i)) Then
                        cmd.Parameters.Add("@check1", OleDbType.Date).Value = DBNull.Value
                    Else
                        cmd.Parameters.Add("@check1", OleDbType.Date).Value = check1(i)
                    End If
                    
                    If String.IsNullOrEmpty(check2(i)) Then
                        cmd.Parameters.Add("@check2", OleDbType.Date).Value = DBNull.Value
                    Else
                        cmd.Parameters.Add("@check2", OleDbType.Date).Value = check2(i)
                    End If

                    If String.IsNullOrEmpty(chkreq(i)) Then
                        cmd.Parameters.Add("@chkreq", OleDbType.Date).Value = DBNull.Value
                    Else
                        cmd.Parameters.Add("@chkreq", OleDbType.Date).Value = chkreq(i)
                    End If
                    
                    If String.IsNullOrEmpty(ended(i)) Then
                        cmd.Parameters.Add("@ended", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd.Parameters.Add("@ended", OleDbType.VarChar).Value = ended(i)
                    End If
                    
                    cmd.Parameters.Add("@did", OleDbType.Integer).Value = did(i)
                    cmd.ExecuteNonQuery()
                    
                    Dim sql2 As String = ""
                    If Not String.IsNullOrEmpty(ended(i)) Then
                        sql2 = "UPDATE T_MAIL SET FLAG = 1 WHERE DID = ?"
                    Else
                        sql2 = "UPDATE T_MAIL SET FLAG = 0 WHERE DID = ?"
                    End If
                
                    Dim cmd2 As New OleDbCommand(sql2, connection)
                    cmd2.Parameters.Add("@DID", OleDbType.Integer).Value = did(i)
                    cmd2.ExecuteNonQuery()
                    
                Next
                connection.Close()
                
                connection.Open()
                Dim updateTime As String = "UPDATE T_BASE SET L_UPDATE = NOW() WHERE ID = ?"
                Dim cmdUpdate As New OleDbCommand(updateTime, connection)
                cmdUpdate.Parameters.Add("@ID", OleDbType.Integer).Value = id
                cmdUpdate.ExecuteNonQuery()
                connection.Close()
                
                'Response.Write("<div class='alert alert-success'><strong><i class='fa fa-check'></i></strong> Successfully Added. <i class='fa fa-smile-o'></i></div>")
                'Response.Write("<script>alert('Edit success')</script>")
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
                <h3>Confirmation by E-mail information update</h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h5><strong>Model Name: <% =mname %></strong></h5>
            </div>
        </div>

        <form class="" method="post">

            <table class="table-nkupdate update2">
                <thead>
                    <tr>
                        <th class="th-fw-10">E-mail Title</th>
                        <th>Kanban No</th>
                        <th>E-mail Send Date</th>
                        <th>Due Date</th>
                        <th>Answer</th>
                        <th>Check1</th>
                        <th>Check2</th>
                        <th>Chk Req</th>
                        <th>Finish Date</th>
                    </tr>
                    
                </thead>
                <tbody>
                <%
                    If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
                        
                        Dim did As String = ""
                        Dim kanban_no As String = ""
                        Dim n_mail As String = ""
                        Dim n_mdate As String = ""
                        Dim n_pdate As String = ""
                        Dim ended As String = ""
                        Dim l_update As String = ""
                        Dim flag As String = ""
                        Dim fdate As String = ""
                        Dim apply As String = ""
                        Dim check1 As String = ""
                        Dim check2 As String = ""
                        Dim chkreq As String = ""
                        
                        Dim sql As String = "SELECT did,ID,Kanban_No,N_MAIL,N_MDATE,N_PDATE,ENDED,L_UPDATE,FLAG,apply,check1,check2,chkreq FROM T_MAIL WHERE ID = ? AND FLAG = '0' ORDER BY Kanban_No ASC"
                        Try
                           
                            connection.Open()
                            Dim cmd As New OleDbCommand(sql, connection)
                            cmd.Parameters.Add("@ID", OleDbType.Integer).Value = id
                            Dim reader = cmd.ExecuteReader
            
                            While reader.Read()
                                did = reader.Item("did").ToString()
                                kanban_no = reader.Item("Kanban_No").ToString
                                n_mail = reader.Item("N_MAIL").ToString()
                                
                                n_mdate = String.Format("{0:yyyy/MM/dd}", reader.Item("N_MDATE"))
                                n_pdate = String.Format("{0:yyyy/MM/dd}", reader.Item("N_PDATE"))

                                ended = String.Format("{0:yyyy/MM/dd}", reader.Item("ENDED"))
                                l_update = String.Format("{0:yyyy/MM/dd}", reader.Item("L_UPDATE"))
                                
                                flag = reader.Item("FLAG").ToString()
                                
                                apply = String.Format("{0:yyyy/MM/dd}", reader.Item("apply"))
                                check1 = String.Format("{0:yyyy/MM/dd}", reader.Item("check1"))
                                check2 = String.Format("{0:yyyy/MM/dd}", reader.Item("check2"))
                                chkreq = String.Format("{0:yyyy/MM/dd}", reader.Item("chkreq"))
                                %>
                                <tr>
                                    <td class="hide"><input type="text" class="form-control" name="did" value="<% =did %>"></td>
                                    <td><input type="text" class="form-control" name="n_mail" value="<% =n_mail%>"></td>
                                    <td><input type="text" class="form-control" name="kanban_no" value="<% =kanban_no%>"></td>
                                    <td><input type="text" class="form-control" name="n_mdate" value="<% =n_mdate %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                                    <td><input type="text" class="form-control" name="n_pdate" value="<% =n_pdate%>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                                    <td><input type="text" class="form-control" name="apply" value="<% =apply %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                                    <td><input type="text" class="form-control" name="check1" value="<% =check1 %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                                    <td><input type="text" class="form-control" name="check2" value="<% =check2 %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                                    <td><input type="text" class="form-control" name="chkreq" value="<% =chkreq %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
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
