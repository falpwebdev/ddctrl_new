<%@ Page Language="VB" AutoEventWireup="false" CodeFile="nkupdateinfo.aspx.vb" Inherits="nkupdateinfo" Debug="true"%>

<%@ Import Namespace="System.Data.OleDb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Std. Info</title>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <%
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
        Dim connection As OleDbConnection = New OleDbConnection(connectionString)
        Dim id As Integer = 0
        Dim maker As String = ""
        Dim kanban_no As String = ""
        Dim c_type As String = ""
        Dim bunrui As String = ""
        Dim rnum As String = ""
        Dim revision As String = ""
        Dim t_kubun As String = ""
        Dim evnt As String = ""
        Dim mt As String = ""
        Dim p_tenkai As String = ""
        Dim p_hosyou As String = ""
        Dim p_genko As String = ""
        Dim p_dok As String = ""
        Dim mname As String = ""
        Dim mcir As String = ""
        Dim remark As String = ""
        Dim doisy As String = ""
        Dim dnum As String = ""
        Dim cremark As String = ""
        
        Dim c1 As String = ""
        Dim c2 As String = ""
        Dim c3 As String = ""
        Dim c4 As String = ""
        Dim it1 As String = "text"
        Dim it2 As String = "text"
        Dim it3 As String = "text"
        Dim it4 As String = "text"
        Dim ro_doisy As String = "readonly"
        
        Dim ro_tenkai As String = ""
        Dim ro_genko As String = ""
        Dim ro_hosyou As String = ""
        Dim ro_dok As String = ""
        
        Dim admin As String = ""
        Dim dt As String = String.Format("{0:M/dd}", DateTime.Now)
        Dim cremark_sig As String = dt
        
        
        If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
            id = Request.QueryString("id")
            
            Dim check As String = "SELECT COUNT(ID) FROM T_BASE WHERE ID = ?"
            connection.Open()
            Dim checkcmd As New OleDbCommand(check, connection)
            checkcmd.Parameters.Add("@ID", OleDbType.Integer).Value = id
            Dim exists As String = checkcmd.ExecuteScalar()
            connection.Close()
            If exists = 0 Then
                Response.Write("<script>alert('No data found!'); window.close();</script>")
            End If
            
            Dim sql As String = "SELECT ID,M_NAME,MAKER,Kanban_No,C_TYPE,BUNRUI,R_NUMBER,revision,T_KUBUN,event,mt,P_GENKO,P_HOSYOU,P_TENKAI,P_DOK,mcir,remark,cremark FROM T_BASE WHERE ID = ?"
            Try
                connection.Open()
                Dim cmd As New OleDbCommand(sql, connection)
                cmd.Parameters.Add("@ID", OleDbType.Integer).Value = id
                Dim reader = cmd.ExecuteReader
            
                While reader.Read()
                    mname = reader.Item("M_NAME").ToString
                    maker = reader.Item("MAKER").ToString
                    kanban_no = reader.Item("Kanban_No").ToString
                    c_type = reader.Item("C_TYPE").ToString
                    rnum = reader.Item("R_NUMBER").ToString
                    bunrui = reader.Item("BUNRUI").ToString
                    revision = reader.Item("revision").ToString
                    t_kubun = reader.Item("T_KUBUN").ToString
                    evnt = reader.Item("event").ToString
                    mt = reader.Item("mt").ToString
                    mcir = reader.Item("mcir").ToString
                    remark = reader.Item("remark").ToString
                    cremark = reader.Item("cremark").ToString
                    
                    p_tenkai = String.Format("{0:yyyy/MM/dd}", reader.Item("P_TENKAI"))
                    p_genko = String.Format("{0:yyyy/MM/dd}", reader.Item("P_GENKO"))
                    p_hosyou = String.Format("{0:yyyy/MM/dd}", reader.Item("P_HOSYOU"))
                    p_dok = String.Format("{0:yyyy/MM/dd}", reader.Item("P_DOK"))
                    
                    ro_tenkai = p_tenkai
                    ro_genko = p_genko
                    ro_hosyou = p_hosyou
                    ro_dok = p_dok
                    
                    If Not IsDBNull(reader.Item("P_TENKAI")) Then 'this means date is nothing
                        Dim tenkai_cast As DateTime = Convert.ToDateTime(reader.Item("P_TENKAI"))
                        If tenkai_cast = Convert.ToDateTime("1970/01/01") Then
                            c1 = "checked"
                            it1 = "hidden"
                            ro_tenkai = "<i>Nothing</i>"
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("P_GENKO")) Then
                        Dim genko_cast As DateTime = Convert.ToDateTime(reader.Item("P_GENKO"))
                        If genko_cast = Convert.ToDateTime("1970/01/01") Then
                            c2 = "checked"
                            it2 = "hidden"
                            ro_genko = "<i>Nothing</i>"
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("P_HOSYOU")) Then
                        Dim hosyou_cast As DateTime = Convert.ToDateTime(reader.Item("P_HOSYOU"))
                        If hosyou_cast = Convert.ToDateTime("1970/01/01") Then
                            c3 = "checked"
                            it3 = "hidden"
                            ro_hosyou = "<i>Nothing</i>"
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("P_DOK")) Then
                        Dim dok_cast As DateTime = Convert.ToDateTime(reader.Item("P_DOK"))
                        If dok_cast = Convert.ToDateTime("1970/01/01") Then
                            c4 = "checked"
                            it4 = "hidden"
                            ro_dok = "<i>Nothing</i>"
                        End If
                    End If
                End While
                reader.Close()
                connection.Close()
                
                connection.Open()
                Dim sql2 As String = "SELECT DOISY FROM T_TENKAI WHERE T_TENKAI.ID = ?"
                Dim cmd2 As New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                doisy = cmd2.ExecuteScalar()
                
                If doisy = 1 Then
                    ro_doisy = ""
                    Dim sql3 As String = "SELECT DNUM FROM T_DOISY WHERE T_DOISY.ID = ?"
                    Dim cmd3 As New OleDbCommand(sql3, connection)
                    cmd3.Parameters.Add("@ID", OleDbType.Integer).Value = id
                    Dim result As Object = cmd3.ExecuteScalar()
                    
                    If result Is Nothing Then
                        dnum = ""
                    Else
                        dnum = result.ToString()
                    End If
                    
                End If
                
                connection.Close()
                
            Catch ex As Exception
                Response.Write(ex.ToString())
            End Try
        End If
        
        If Not String.IsNullOrEmpty(Request.Form("submit")) Then
            'Response.Write(Request.Form().ToString())
            
            maker = Request.Form("maker")
            kanban_no = Request.Form("kanban_no")
            c_type = Request.Form("c_type")
            bunrui = Request.Form("bunrui")
            rnum = Request.Form("rnum")
            revision = Request.Form("revision")
            t_kubun = Request.Form("t_kubun")
            evnt = Request.Form("event")
            mt = Request.Form("mt")
            doisy = Request.Form("doisy")
            dnum = Request.Form("dnum")
            mname = Request.Form("mname")
            p_tenkai = Request.Form("p_tenkai")
            p_genko = Request.Form("p_genko")
            p_hosyou = Request.Form("p_hosyou")
            p_dok = Request.Form("p_dok")
            mcir = Request.Form("mcir")
            remark = Request.Form("remark")
            cremark = Request.Form("cremark")
            
            
            Try
                connection.Open()
                Dim sql As String = "UPDATE T_BASE SET MAKER=?,Kanban_No=?,C_TYPE=?,BUNRUI=?,R_NUMBER=?,revision=?,T_KUBUN=?,event=?,mt=?,M_NAME=?,P_TENKAI=?,P_GENKO=?,P_HOSYOU=?,P_DOK=?,mcir=?,remark=Ucase(?),cremark=Ucase(?),L_UPDATE=NOW() WHERE ID = ?"
                Dim cmd As New OleDbCommand(sql, connection)
                
                If String.IsNullOrEmpty(maker) Then
                    cmd.Parameters.Add("@MAKER", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@MAKER", OleDbType.VarChar).Value = maker
                End If
                
                If String.IsNullOrEmpty(kanban_no) Then
                    cmd.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = kanban_no
                End If

                If String.IsNullOrEmpty(c_type) Then
                    cmd.Parameters.Add("@C_TYPE", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@C_TYPE", OleDbType.VarChar).Value = c_type
                End If
                
                If String.IsNullOrEmpty(bunrui) Then
                    cmd.Parameters.Add("@BUNRUI", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@BUNRUI", OleDbType.VarChar).Value = bunrui
                End If
                
                If String.IsNullOrEmpty(rnum) Then
                    cmd.Parameters.Add("@R_NUMBER", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@R_NUMBER", OleDbType.VarChar).Value = rnum
                End If
                
                If String.IsNullOrEmpty(revision) Then
                    cmd.Parameters.Add("@revision", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@revision", OleDbType.VarChar).Value = revision
                End If
                
                If String.IsNullOrEmpty(t_kubun) Then
                    cmd.Parameters.Add("@T_KUBUN", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@T_KUBUN", OleDbType.VarChar).Value = t_kubun
                End If

                If String.IsNullOrEmpty(evnt) Then
                    cmd.Parameters.Add("@event", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@event", OleDbType.VarChar).Value = evnt
                End If
                
                If String.IsNullOrEmpty(mt) Then
                    cmd.Parameters.Add("@mt", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@mt", OleDbType.VarChar).Value = mt
                End If
                
                If String.IsNullOrEmpty(mname) Then
                    cmd.Parameters.Add("@M_NAME", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@M_NAME", OleDbType.VarChar).Value = mname
                End If
                
                If String.IsNullOrEmpty(p_tenkai) Then
                    cmd.Parameters.Add("@P_TENKAI", OleDbType.DBDate).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@P_TENKAI", OleDbType.DBDate).Value = p_tenkai
                End If
                
                If String.IsNullOrEmpty(p_genko) Then
                    cmd.Parameters.Add("@P_GENKO", OleDbType.DBDate).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@P_GENKO", OleDbType.DBDate).Value = p_genko
                End If
                
                If String.IsNullOrEmpty(p_hosyou) Then
                    cmd.Parameters.Add("@P_HOSYOU", OleDbType.DBDate).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@P_HOSYOU", OleDbType.DBDate).Value = p_hosyou
                End If
                
                If String.IsNullOrEmpty(p_dok) Then
                    cmd.Parameters.Add("@P_DOK", OleDbType.DBDate).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@P_DOK", OleDbType.DBDate).Value = p_dok
                End If
                
                If String.IsNullOrEmpty(mcir) Then
                    cmd.Parameters.Add("@mcir", OleDbType.Integer).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@mcir", OleDbType.Integer).Value = mcir
                End If
                
                If String.IsNullOrEmpty(remark) Then
                    cmd.Parameters.Add("@remark", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@remark", OleDbType.VarChar).Value = remark
                End If
                
                If String.IsNullOrEmpty(cremark) Then
                    cmd.Parameters.Add("@cremark", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@cremark", OleDbType.VarChar).Value = cremark
                End If
                
                cmd.Parameters.Add("@ID", OleDbType.VarChar).Value = id
                cmd.ExecuteNonQuery()
                connection.Close()
                
                If doisy = 1 Then
                    connection.Open()
                    Dim sql2 As String = "SELECT COUNT(ID) FROM T_DOISY WHERE ID = ?"
                    Dim cmd2 As New OleDbCommand(sql2, connection)
                    cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                    Dim rcount As Integer = cmd2.ExecuteScalar()
                    connection.Close()
                    
                    connection.Open()
                    If rcount = 0 Then
                        Dim sql3 As String = "INSERT INTO T_DOISY (ID,STATUS,DNUM) VALUES(?,?,?)"
                        Dim cmd3 As New OleDbCommand(sql3, connection)
                        cmd3.Parameters.Add("@ID", OleDbType.Integer).Value = id
                        cmd3.Parameters.Add("@STATUS", OleDbType.Integer).Value = 1 'doisy yes is 1
                        
                        If String.IsNullOrEmpty(dnum) Then
                            cmd3.Parameters.Add("@DNUM", OleDbType.VarChar).Value = DBNull.Value
                        Else
                            cmd3.Parameters.Add("@DNUM", OleDbType.VarChar).Value = dnum
                        End If
                        
                        cmd3.ExecuteNonQuery()
                    Else
                        Dim sql3 As String = "UPDATE T_DOISY SET DNUM=? WHERE ID = ?"
                        Dim cmd3 As New OleDbCommand(sql3, connection)
                        
                        If String.IsNullOrEmpty(dnum) Then
                            cmd3.Parameters.Add("@DNUM", OleDbType.VarChar).Value = DBNull.Value
                        Else
                            cmd3.Parameters.Add("@DNUM", OleDbType.VarChar).Value = dnum
                        End If
                        
                        cmd3.Parameters.Add("@ID", OleDbType.Integer).Value = id
                        cmd3.ExecuteNonQuery()
                    End If
                    
                    connection.Close()
                Else
                    connection.Open()
                    Dim sql2 As String = "DELETE FROM T_DOISY WHERE ID = ?"
                    Dim cmd2 As New OleDbCommand(sql2, connection)
                    cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                    cmd2.ExecuteNonQuery()
                    connection.Close()
                End If
                
                connection.Open()
                Dim sql5 As String = "UPDATE T_TENKAI SET DOISY=? WHERE ID = ?"
                Dim cmd5 As New OleDbCommand(sql5, connection)
                        
                cmd5.Parameters.Add("@DOISY", OleDbType.Integer).Value = doisy
                cmd5.Parameters.Add("@ID", OleDbType.Integer).Value = id
                
                cmd5.ExecuteNonQuery()
                connection.Close()
                
                connection.Open()
                If bunrui = "CORRECTION" Then
                    Dim sql10 As String = "UPDATE T_BASE SET Kanban_No = 0 WHERE ID = ?"
                    Dim cmd10 As New OleDbCommand(sql10, connection)
                    cmd10.Parameters.Add("@ID", OleDbType.Integer).Value = id
                    cmd10.ExecuteNonQuery()
                    
                    Dim sql11 As String = "UPDATE T_TENKAI SET Kanban_No = 0 WHERE ID = ?"
                    Dim cmd11 As New OleDbCommand(sql11, connection)
                    cmd11.Parameters.Add("@ID", OleDbType.Integer).Value = id
                    cmd11.ExecuteNonQuery()
                End If
                connection.Close()
                
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
        If String.IsNullOrEmpty(Request.Form("submit")) Then
    %>

    <section class="section">
        <div class="row">
            <div class="col-md-12">
                <h3>Base information update　
                <%
                    If Not String.IsNullOrEmpty(Request.QueryString("admin")) Then
                        Response.Write("(In charge of customer update Mode)")
                    Else
                        Response.Write("(Normal update Mode)")
                    End If
                %>
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h5><strong>Model Name:</strong> <% = mname%></h5>
            </div>
        </div>

        <form class="" method="post">

            <div class="row">
                <div class="col-xs-1 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Customer</label>
                        <input type="text" class="form-control" name="maker" value="<% =maker %>" required>
                    </div>
                </div>
                <%
                    Dim kbro As String = "readonly"
                    If Not String.IsNullOrEmpty(Request.QueryString("admin")) Then
                        kbro = ""
                    End If
                %>
                <div class="col-xs-1 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Kanban No.</label>
                        <input type="text" class="form-control" name="kanban_no"  value="<% =kanban_no %>" <% =kbro %>>
                    </div>
                </div>
                <div class="col-xs-2 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Car Type</label>
                        <input type="text" class="form-control" name="c_type"  value="<% =c_type %>" required>
                    </div>
                </div>
                <div class="col-xs-1 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Classification</label>
                        <%
                            Dim opt_bunrui = ""
                            If bunrui = "TENKAI" Then
                                opt_bunrui = "<option>QC</option><option selected>TENKAI</option><option>CORRECTION</option>"
                            ElseIf bunrui = "QC" Then
                                opt_bunrui = "<option selected>QC</option><option>TENKAI</option><option>CORRECTION</option>"
                            End If
                        %>
                        <select name="bunrui" class="form-control">
                            <% = opt_bunrui%>
                        </select>
                    </div>
                </div>
                <div class="col-xs-2 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Request No.</label>
                        <input type="text" class="form-control" name="rnum"  value="<% =rnum %>" required>
                    </div>
                </div>
                <div class="col-xs-1 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Revision</label>
                        <input type="text" class="form-control" name="revision"  value="<% =revision %>">
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="form-group">
                        <label class="nk-label">Type</label>

                        <%
                            Dim opt_kubun As String = ""
                            Select Case t_kubun
                                Case "NEW"
                                    opt_kubun = "<option selected>NEW</option><option>SIMILARITY</option><option>SIMILARITY(APPROVAL)</option><option>DRAWING</option><option>MEMO</option><option>COMPARISON</option><option>NEW R.D</option><option>SIMILARITY R.D</option><option>DRAWING R.D</option><option>MEMO R.D</option> <option>SIMILARITY(APPROVAL) R.D</option>"
                                Case "SIMILARITY"
                                    opt_kubun = "<option>NEW</option><option selected>SIMILARITY</option><option>SIMILARITY(APPROVAL)</option><option>DRAWING</option><option>MEMO</option><option>COMPARISON</option><option>NEW R.D</option><option>SIMILARITY R.D</option><option>DRAWING R.D</option><option>MEMO R.D</option> <option>SIMILARITY(APPROVAL) R.D</option>"
                                Case "SIMILARITY(APPROVAL)"
                                    opt_kubun = "<option>NEW</option><option>SIMILARITY</option><option selected>SIMILARITY(APPROVAL)</option><option>DRAWING</option><option>MEMO</option><option>COMPARISON</option><option>NEW R.D</option><option>SIMILARITY R.D</option><option>DRAWING R.D</option><option>MEMO R.D</option> <option>SIMILARITY(APPROVAL) R.D</option>"
                                Case "DRAWING"
                                    opt_kubun = "<option>NEW</option><option>SIMILARITY</option><option>SIMILARITY(APPROVAL)</option><option selected>DRAWING</option><option>MEMO</option><option>COMPARISON</option><option>NEW R.D</option><option>SIMILARITY R.D</option><option>DRAWING R.D</option><option>MEMO R.D</option> <option>SIMILARITY(APPROVAL) R.D</option>"
                                Case "MEMO"
                                    opt_kubun = "<option>NEW</option><option>SIMILARITY</option><option>SIMILARITY(APPROVAL)</option><option>DRAWING</option><option selected>MEMO</option><option>COMPARISON</option><option>NEW R.D</option><option>SIMILARITY R.D</option><option>DRAWING R.D</option><option>MEMO R.D</option> <option>SIMILARITY(APPROVAL) R.D</option>"
                                Case "COMPARISON"
                                    opt_kubun = "<option>NEW</option><option>SIMILARITY</option><option>SIMILARITY(APPROVAL)</option><option>DRAWING</option><option>MEMO</option><option selected>COMPARISON</option><option>NEW R.D</option><option>SIMILARITY R.D</option><option>DRAWING R.D</option><option>MEMO R.D</option> <option>SIMILARITY(APPROVAL) R.D</option>"
  
                                Case "NEW R.D"
                                    opt_kubun = "<option>NEW</option><option>SIMILARITY</option><option>SIMILARITY(APPROVAL)</option><option>DRAWING</option><option>MEMO</option><option>COMPARISON</option><option selected>NEW R.D</option><option>SIMILARITY R.D</option><option>DRAWING R.D</option><option>MEMO R.D</option> <option>SIMILARITY(APPROVAL) R.D</option>"
                                Case "SIMILARITY R.D"
                                    opt_kubun = "<option>NEW</option><option>SIMILARITY</option><option>SIMILARITY(APPROVAL)</option><option>DRAWING</option><option>MEMO</option><option>COMPARISON</option><option>NEW R.D</option><option selected>SIMILARITY R.D</option><option>DRAWING R.D</option><option>MEMO R.D</option> <option>SIMILARITY(APPROVAL) R.D</option>"
                                Case "DRAWING R.D"
                                    opt_kubun = "<option>NEW</option><option>SIMILARITY</option><option>SIMILARITY(APPROVAL)</option><option>DRAWING</option><option>MEMO</option><option>COMPARISON</option><option>NEW R.D</option><option>SIMILARITY R.D</option><option selected>DRAWING R.D</option><option>MEMO R.D</option> <option>SIMILARITY(APPROVAL) R.D</option>"
                                Case "MEMO R.D"
                                    opt_kubun = "<option>NEW</option><option>SIMILARITY</option><option>SIMILARITY(APPROVAL)</option><option>DRAWING</option><option>MEMO</option><option>COMPARISON</option><option>NEW R.D</option><option>SIMILARITY R.D</option><option>DRAWING R.D</option><option selected>MEMO R.D</option> <option>SIMILARITY(APPROVAL) R.D</option>"
                                Case "SIMILARITY(APPROVAL) R.D"
                                    opt_kubun = "<option>NEW</option><option>SIMILARITY</option><option>SIMILARITY(APPROVAL)</option><option>DRAWING</option><option>MEMO</option><option>COMPARISON</option><option>NEW R.D</option><option>SIMILARITY R.D</option><option>DRAWING R.D</option><option>MEMO R.D</option> <option selected>SIMILARITY(APPROVAL) R.D</option>"
                           
                            End Select
                                
                        %>

                        <select name="t_kubun" class="form-control" required>
                            <% =opt_kubun %>
                        </select>
                    </div>
                </div>
                
            </div>
            <div class="row">
                <div class="col-xs-2 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Event</label>
                        <input type="text" class="form-control" name="event" value="<% =evnt %>" required>
                    </div>
                </div>
                <div class="col-xs-1 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">MT Check</label>
                        <%
                            Dim opt_mt = ""
                            If mt = "YES" Then
                                opt_mt = "<option>NO</option><option selected>YES</option>"
                            Else
                                opt_mt = "<option selected>NO</option><option>YES</option>"
                            End If
                        %>
                        <select name="mt" class="form-control" required>
                            <% =opt_mt %>
                        </select>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="nk-label">Doisy</label>
                        <% 
                            If maker = "C" Then
                                
                                Dim opt_doisy As String = ""
                                
                                If doisy = 1 Then
                                    opt_doisy = "<option value='1' selected>Yes</option><option value='0'>No</option>"
                                Else
                                    opt_doisy = "<option value='1'>Yes</option><option value='0' selected>No</option>"
                                End If
                                
                        %>
                        <div class="row">
                            <div class="col-xs-4 no-pad-right">
                                <select name="doisy" class="form-control">
                                    <% =opt_doisy %>
                                </select>
                            </div>
                            <div class="col-xs-8">
                                <input type="number" class="form-control" name="dnum" value="<% =dnum %>" <% =ro_doisy %>>
                            </div>
                        </div>
                        <%
                        Else
                            Response.Write("<input type='hidden' name='doisy' value='0'>")
                        End If
                        %>
                        
                    </div>
                </div>
                
            </div>
            <div class="row">
                <div class="col-xs-5 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Model Name</label>
                        <input type="text" class="form-control" name="mname" value="<% =mname %>" required>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-2 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">TENKAI Due Date</label>
                        <% 
                            If Not String.IsNullOrEmpty(Request.QueryString("admin")) Then
                        %>
                            <input type="<% =it1 %>" class="form-control" name="p_tenkai" value="<% =p_tenkai %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                            <div class="checkbox">
                              <label><input type="checkbox" name="checkbox_nothing" <% =c1 %>>: Nothing</label>
                            </div>
                        <%
                            Else
                        %>
                            <p class="form-control-static"><% =ro_tenkai %></p>
                            <input type="hidden" name="p_tenkai" value="<% =p_tenkai %>">
                        <%    
                            End If
                        %>
                    </div>
                </div>
                <div class="col-xs-2 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Send Host Due Date</label>
                        <% 
                            If Not String.IsNullOrEmpty(Request.QueryString("admin")) Then
                        %>
                            <input type="<% =it2 %>" class="form-control" name="p_genko" value="<% =p_genko %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                            <div class="checkbox">
                              <label><input type="checkbox" name="checkbox_nothing" <% =c2 %>>: Nothing</label>
                            </div>
                        <%
                            Else
                        %>
                            <p class="form-control-static"><% =ro_genko %></p>
                            <input type="hidden" name="p_genko" value="<% =p_genko %>">
                        <%    
                            End If
                        %>
                    </div>
                </div>
                <div class="col-xs-2 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Guarantee Due Date</label>
                        <% 
                            If Not String.IsNullOrEmpty(Request.QueryString("admin")) Then
                        %>
                            <input type="<% =it3 %>" class="form-control" name="p_hosyou" value="<% =p_hosyou %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                            <div class="checkbox">
                              <label><input type="checkbox" name="checkbox_nothing" <% =c3 %>>: Nothing</label>
                            </div>
                        <%
                            Else
                        %>
                            <p class="form-control-static"><% =ro_hosyou %></p>
                            <input type="hidden" name="p_hosyou" value="<% =p_hosyou %>">
                        <%    
                            End If
                        %>
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="form-group">
                        <label class="nk-label">Entry OK</label>
                        <% 
                            If Not String.IsNullOrEmpty(Request.QueryString("admin")) Then
                        %>
                            <input type="<% =it4 %>" class="form-control" name="p_dok" value="<% =p_dok %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                            <div class="checkbox">
                              <label><input type="checkbox" name="checkbox_nothing" <% =c4 %>>: Nothing</label>
                            </div>
                        <%
                            Else
                        %>
                            <p class="form-control-static"><% =ro_dok %></p>
                            <input type="hidden" name="p_dok" value="<% =p_dok %>">
                        <%    
                            End If
                        %>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-2 no-pad-right hide">
                    <div class="form-group">
                        <label class="nk-label">Multi Circuit</label>
                        <input type="text" class="form-control" name="mcir" value="<% =mcir %>">
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="nk-label">Remarks</label>
                        <input type="text" class="form-control" name="remark" value="<% =remark %>">
                    </div>
                </div>
            </div>

            <% 
                If Not String.IsNullOrEmpty(Request.QueryString("admin")) Then
            %>
            <div class="row">
                <div class="col-xs-8">
                    <div class="form-group">
                        <label class="nk-label">In charge of customer instruction</label>
                        <input type="text" class="form-control" name="cremark" value="<% =cremark %><% =cremark_sig %>">
                    </div>
                </div>
            </div>
            <%
            Else
                Response.Write("<input type='hidden' class='form-control' name='cremark' value='" + cremark+ "'>")
            End If
            %>

            <input type="submit" class="btn btn-primary" name="submit" value="Save">
            <input type="button" class="btn btn-default" onclick="window.close()" value="Cancel">
        </form>

    </section>

    <%
        End If
    %>

    <%
        If Not String.IsNullOrEmpty(Request.Form("submit")) Then
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
            $('input[name="checkbox_nothing"]').click(function () {
                if ($(this).is(':checked')) {
                    $(this).closest('.checkbox').prev().attr('type','hidden').val('1970-01-01');
                } else {
                    $(this).closest('.checkbox').prev().attr('type', 'text').val('');
                }
            });

            $('select[name="doisy"]').change(function () {
                if ($(this).val() == 1) {
                    $('input[name="dnum"]').prop("readonly",false);
                } else {
                    $('input[name="dnum"]').prop("readonly", true);
                }
            });

        });
    </script>
</body>
</html>
