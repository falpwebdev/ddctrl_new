<%@ Page Language="VB" AutoEventWireup="false" CodeFile="nkaddmail.aspx.vb" Inherits="nkaddmail" %>

<%@ Import Namespace="System.Data.OleDb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Confirmation by E-mail</title>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .control-label
        {
            font-size: 11px;
            background-color: #B0BEC5;
            text-align: left !important;
        }
    </style>
</head>
<body>
    <%  
        Dim mname As String = ""
        Dim uid As Integer = 0
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
        Dim connection As OleDbConnection = New OleDbConnection(connectionString)
        
        If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
            uid = Request.QueryString("id")
        
            Try
                Dim sql As String = "SELECT M_NAME FROM T_BASE a WHERE a.ID = ?"
                connection.Open()
                Dim cmd As New OleDbCommand(sql, connection)
                cmd.Parameters.Add("@ID", OleDbType.Integer).Value = uid
                Dim result = cmd.ExecuteScalar()
                mname = result
                connection.Close()
            Catch ex As Exception
                Response.Write(ex.ToString())
            End Try
        
            If Not String.IsNullOrEmpty(Request.Form("submit")) Then
            
            End If
        End If
        
        
        If Not String.IsNullOrEmpty(Request.Form("submit")) Then
            'Response.Write(Request.Form.ToString())
            uid = Request.QueryString("id")
            Dim kanban_no As String = Request.Form("kanban_no")
            Dim n_mail As String = Request.Form("n_mail")
            Dim n_mdate As String = Request.Form("n_mdate")
            Dim n_pdate As String = Request.Form("n_pdate")
            
            Try
                connection.Open()
                Dim sql As String = "INSERT INTO T_MAIL (ID, Kanban_No, N_MAIL, N_MDATE, N_PDATE, L_UPDATE) VALUES (?,?,?,?,?,NOW())"
                Dim cmd As New OleDbCommand(sql, connection)
                cmd.Parameters.Add("@ID", OleDbType.Integer).Value = uid
                cmd.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = kanban_no
                cmd.Parameters.Add("@N_MAIL", OleDbType.VarChar).Value = n_mail
                cmd.Parameters.Add("@N_MDATE", OleDbType.Date).Value = n_mdate
                cmd.Parameters.Add("@N_PDATE", OleDbType.Date).Value = n_pdate
                
                cmd.ExecuteNonQuery()
                connection.Close()
                Response.Write("<div class='alert alert-success'><strong><i class='fa fa-check'></i></strong> Successfully Added. <i class='fa fa-smile-o'></i></div>")
            Catch ex As Exception
                Response.Write(ex.ToString())
            End Try
            
        End If
    %>
    <section class="section">
        <div class="row">
            <div class="col-md-12">
                <h4>Confirmation by E-mail Data Entry</h4>
            </div>
        </div>

        <div class="">
            <div class="col-xs-8">
                <form class="form-horizontal" method="post">
                    <div class="form-group">
                        <label class="control-label col-xs-3 no-pad-right" for="">Model Name:</label>
                        <div class="col-xs-9">
                            <p class="form-control-static"><% = mname%></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-xs-3 no-pad-right" for="">ID:</label>
                        <div class="col-xs-9">
                            <p class="form-control-static"><% =uid %></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-xs-3 no-pad-right" for="">Kanban No.</label>
                        <div class="col-xs-9">
                            <input type="number" name="kanban_no" class="form-control input-sm" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-xs-3 no-pad-right" for="">E-mail title</label>
                        <div class="col-xs-9">
                            <input type="text" name="n_mail" class="form-control input-sm" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-xs-3 no-pad-right" for="">Issue Date</label>
                        <div class="col-xs-9">
                            <input type="text" name="n_mdate" class="form-control input-sm" required pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-xs-3 no-pad-right" for="">Answer Due Date</label>
                        <div class="col-xs-9">
                            <input type="text" name="n_pdate" class="form-control input-sm" required pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                        </div>
                    </div>

                    <div class="pull-right">
                        <div class="col-xs-12 no-pad-right">
                            <input type="button" class="btn btn-default btn-sm" onclick="window.close()" value="Cancel">
                            <input type="submit" class="btn btn-primary btn-sm" name="submit" value="Submit">
                        </div>
                    </div>
                </form>
            </div>
        </div>

    </section>
    <script type="text/javascript" src="jquery/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="moment-js/moment.min.js"></script>
    <script type="text/javascript" src="script.js"></script>
</body>
</html>
