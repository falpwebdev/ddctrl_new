<%@ Page Language="VB" AutoEventWireup="false" CodeFile="nkupdate.aspx.vb" Inherits="nkupdate" %>

<%@ Import Namespace="System.Data.OleDb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>TENKAI Progress</title>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <style> 
        .checkbox-nothing
        {
            margin-top: 5px;
            margin-bottom: 3px;
            text-align: center;
        }
    </style>
</head>
<body>
    <%
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
        Dim connection As OleDbConnection = New OleDbConnection(connectionString)
        
        Dim mname As String = ""
        Dim bunrui As String = ""
        Dim p_tenkai As String = ""
        Dim p_hosyou As String = ""
        Dim p_genko As String = ""
        Dim sec As String = ""
        Dim sin_info As String = "" 'sin_info
        Dim design As String = "" 't_name
        Dim check1 As String = "" 's_name
        Dim check2 As String = "" '3_name
        Dim tstart As String = ""
        Dim comp1_name As String = ""
        Dim comp2_name As String = ""
        Dim chk1 As String = ""
        Dim chk2 As String = ""
        Dim chk2_p2 As String = ""
        Dim chk2_p3 As String = ""
        Dim psd As String = "" 'actual start design
        Dim pchk1 As String = ""
        Dim pchk2 As String = ""
        Dim pchk2_p2 As String = ""
        Dim pchk2_p3 As String = ""
        Dim chk3 As String = ""
        Dim pchk3 As String = ""
        Dim chk3_Nothing As String = ""
        
        Dim c_plan As String = ""
        Dim c_nothing As String = ""
        Dim c_actual As String = ""
        Dim c_coma As String = ""
        Dim c_comb As String = ""
        Dim c_mdwg As String = ""
        Dim p_plan As String = ""
        Dim p_nothing As String = ""
        Dim p_actual As String = ""
        Dim p_prec As String = ""
        Dim p_pred As String = ""
        Dim p_mdwg As String = ""
        Dim mt_plan As String = ""
        Dim mt_nothing As String = ""
        Dim mt_actual As String = ""
        Dim prgdd As String = ""
        Dim pdd As String = "" 'falp due date
        Dim wsdc As String = "" 'w start
        Dim pgdd As String = "" 'actual gua due date
        Dim argdd As String = "" 'actual re-gua due date
        Dim dok_req As String = ""
        Dim psmo As String = ""
        Dim ended As String = ""
        Dim phr As String = ""
        Dim g_end As String = ""
        Dim sok_end As String = ""
        Dim kanban_no As String = ""
        Dim mcir As String = ""
        Dim mcirdate As String = ""
        
        'Dim xmark As String = "<i class='fa fa-times x-mark'></i>"
        Dim xmark As String = "<i>Nothing</i>"
        Dim c1 As String = ""
        Dim c2 As String = ""
        Dim c3 As String = ""
        Dim tstart_nothing As String = ""
        Dim chk1_nothing As String = ""
        Dim chk2_nothing As String = ""
        
        Dim it1 As String = "text"
        Dim it2 As String = "text"
        Dim it3 As String = "text"
        
        Dim c_it As String = "text"
        Dim p_it As String = "text"
        Dim tstart_it As String = "text"
        Dim chk1_it As String = "text"
        Dim chk2_it As String = "text"
        Dim mt_it As String = "text"
        Dim chk3_it As String = "text"
        
        Dim chkbox_comp As String = ""
        Dim chkbox_prep As String = ""
        Dim chkbox_c2 As String = ""
        Dim pchk2_ro As String = ""
        Dim ended_ro As String = ""
        
        Dim isQC As Boolean = False
        Dim qcShow As String = "hide"
        Dim assyShow As String = ""
        Dim qcDisabled As String = "disabled"
        Dim assyDisabled As String = ""
        Dim qcCheck As String = ""
        Dim qcReadonly As String = "readonly"
        
        If Not String.IsNullOrEmpty(Request.Form("submit")) Then
            'Response.Write(Request.Form(""))
            Dim p_id As String = Request.QueryString("id")
            sin_info = Request.Form("sin_info")
            design = Request.Form("t_name")
            check1 = Request.Form("s_name")
            check2 = Request.Form("check2")
            
            comp1_name = Request.Form("comp1_name")
            comp2_name = Request.Form("comp2_name")

            tstart = Request.Form("tstart")
            chk1 = Request.Form("chk1")
            chk2 = Request.Form("chk2")
            
            chk2_p2 = Request.Form("chk2_p2")
            chk2_p3 = Request.Form("chk2_p3")
            
            psd = Request.Form("psd")
            pchk1 = Request.Form("pchk1")
            pchk2 = Request.Form("pchk2")
            
            pchk2_p2 = Request.Form("pchk2_p2")
            pchk2_p3 = Request.Form("pchk2_p3")
            
            chk3 = Request.Form("chk3")
            pchk3 = Request.Form("pchk3")
            chk3_Nothing = Request.Form("chk3_Nothing")
            
            c_plan = Request.Form("c_plan")
            c_nothing = Request.Form("c_nothing")
            c_actual = Request.Form("c_actual")
            c_coma = Request.Form("c_coma")
            c_comb = Request.Form("c_comb")
            c_mdwg = Request.Form("c_mdwg")
            p_plan = Request.Form("p_plan")
            p_nothing = Request.Form("p_nothing")
            p_actual = Request.Form("p_actual")
            p_prec = Request.Form("p_prec")
            p_pred = Request.Form("p_pred")
            p_mdwg = Request.Form("p_mdwg")
            mt_plan = Request.Form("mt_plan")
            mt_nothing = Request.Form("mt_nothing")
            mt_actual = Request.Form("mt_actual")
            prgdd = Request.Form("prgdd")
            pdd = Request.Form("pdd")
            wsdc = Request.Form("wsdc")
            pgdd = Request.Form("pgdd")
            argdd = Request.Form("argdd")
            dok_req = Request.Form("dok_req")
            psmo = Request.Form("psmo")
            ended = Request.Form("ended")
            phr = Request.Form("phr")
            g_end = Request.Form("g_end")
            sok_end = Request.Form("sok_end")
            mcir = Request.Form("mcir")
            mcirdate = Request.Form("mcirdate")
            
            Try
                connection.Open()
                Dim sql As String = "UPDATE T_TENKAI SET tstart=?,SIN_INFO=Ucase(?),T_NAME=Ucase(?),S_NAME=Ucase(?),[3_NAME]=Ucase(?),chk1=?,chk2=?,pchk1=?,pchk2=?,psd=?,C_plan=?,C_Nothing=?,C_actual=?,C_ComA=?,C_ComB=?,C_MDwg=?,P_Plan=?,P_Nothing=?,P_Actual=?,P_PreC=?,P_PreD=?,P_MDwg=?,MT_Plan=?,MT_Nothing=?,MT_Actual=?,prgdd=?,pdd=?,wsdc=?,pgdd=?,argdd=?,dok_req=?,psmo=?,ended=?,phr=?,G_END=?,SOK_END=?,comp1_name=Ucase(?),comp2_name=Ucase(?),chk2_p2=?,pchk2_p2=?,chk2_p3=?,pchk2_p3=?, chk3=?, pchk3=?, chk3_Nothing=? WHERE ID = ?"
                Dim cmd As New OleDbCommand(sql, connection)
                
                If String.IsNullOrEmpty(tstart) Then
                    cmd.Parameters.Add("@tstart", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@tstart", OleDbType.Date).Value = tstart
                End If
                
                If String.IsNullOrEmpty(sin_info) Then
                    cmd.Parameters.Add("@SIN_INFO", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@SIN_INFO", OleDbType.VarChar).Value = sin_info
                End If
                
                If String.IsNullOrEmpty(design) Then
                    cmd.Parameters.Add("@T_NAME", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@T_NAME", OleDbType.VarChar).Value = design
                End If

                If String.IsNullOrEmpty(check1) Then
                    cmd.Parameters.Add("@S_NAME", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@S_NAME", OleDbType.VarChar).Value = check1
                End If
                
                If String.IsNullOrEmpty(check2) Then
                    cmd.Parameters.Add("@3_NAME", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@3_NAME", OleDbType.VarChar).Value = check2
                End If
                
                If String.IsNullOrEmpty(chk1) Then
                    cmd.Parameters.Add("@chk1", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@chk1", OleDbType.Date).Value = chk1
                End If
                
                If String.IsNullOrEmpty(chk2) Then
                    cmd.Parameters.Add("@chk2", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@chk2", OleDbType.Date).Value = chk2
                End If
                
                If String.IsNullOrEmpty(pchk1) Then
                    cmd.Parameters.Add("@pchk1", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@pchk1", OleDbType.Date).Value = pchk1
                End If
                
                If String.IsNullOrEmpty(pchk2) Then
                    cmd.Parameters.Add("@pchk2", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@pchk2", OleDbType.Date).Value = pchk2
                End If
                
                If String.IsNullOrEmpty(psd) Then
                    cmd.Parameters.Add("@psd", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@psd", OleDbType.Date).Value = psd
                End If
                
                If String.IsNullOrEmpty(c_plan) Then
                    cmd.Parameters.Add("@C_plan", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@C_plan", OleDbType.Date).Value = c_plan
                End If
                
                If c_nothing = "off" Or String.IsNullOrEmpty(c_nothing) Then
                    cmd.Parameters.Add("@C_Nothing", OleDbType.Boolean).Value = "False"
                Else
                    cmd.Parameters.Add("@C_Nothing", OleDbType.Boolean).Value = "True"
                End If
                
                If String.IsNullOrEmpty(c_actual) Then
                    cmd.Parameters.Add("@C_actual", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@C_actual", OleDbType.Date).Value = c_actual
                End If
                
                If c_coma = "off" Or String.IsNullOrEmpty(c_coma) Then
                    cmd.Parameters.Add("@C_ComA", OleDbType.Boolean).Value = "False"
                Else
                    cmd.Parameters.Add("@C_ComA", OleDbType.Boolean).Value = "True"
                End If
                
                If c_comb = "off" Or String.IsNullOrEmpty(c_comb) Then
                    cmd.Parameters.Add("@C_ComB", OleDbType.Boolean).Value = "False"
                Else
                    cmd.Parameters.Add("@C_ComB", OleDbType.Boolean).Value = "True"
                End If
                
                If c_mdwg = "off" Or String.IsNullOrEmpty(c_mdwg) Then
                    cmd.Parameters.Add("@C_MDwg", OleDbType.Boolean).Value = "False"
                Else
                    cmd.Parameters.Add("@C_MDwg", OleDbType.Boolean).Value = "True"
                End If
                
                If String.IsNullOrEmpty(p_plan) Then
                    cmd.Parameters.Add("@P_Plan", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@P_Plan", OleDbType.Date).Value = p_plan
                End If
                
                If p_nothing = "off" Or String.IsNullOrEmpty(p_nothing) Then
                    cmd.Parameters.Add("@P_Nothing", OleDbType.Boolean).Value = "False"
                Else
                    cmd.Parameters.Add("@P_Nothing", OleDbType.Boolean).Value = "True"
                End If
                
                If String.IsNullOrEmpty(p_actual) Then
                    cmd.Parameters.Add("@P_Actual", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@P_Actual", OleDbType.Date).Value = p_actual
                End If
                
                If p_prec = "off" Or String.IsNullOrEmpty(p_prec) Then
                    cmd.Parameters.Add("@P_PreC", OleDbType.Boolean).Value = "False"
                Else
                    cmd.Parameters.Add("@P_PreC", OleDbType.Boolean).Value = "True"
                End If
                
                If p_pred = "off" Or String.IsNullOrEmpty(p_pred) Then
                    cmd.Parameters.Add("@P_PreD", OleDbType.Boolean).Value = "False"
                Else
                    cmd.Parameters.Add("@P_PreD", OleDbType.Boolean).Value = "True"
                End If
                
                If p_mdwg = "off" Or String.IsNullOrEmpty(p_mdwg) Then
                    cmd.Parameters.Add("@P_MDwg", OleDbType.Boolean).Value = "False"
                Else
                    cmd.Parameters.Add("@P_MDwg", OleDbType.Boolean).Value = "True"
                End If
                
                If String.IsNullOrEmpty(mt_plan) Then
                    cmd.Parameters.Add("@MT_Plan", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@MT_Plan", OleDbType.Date).Value = mt_plan
                End If
                
                If mt_nothing = "off" Or String.IsNullOrEmpty(mt_nothing) Then
                    cmd.Parameters.Add("@MT_Nothing", OleDbType.Boolean).Value = "False"
                Else
                    cmd.Parameters.Add("@MT_Nothing", OleDbType.Boolean).Value = "True"
                End If
                
                If String.IsNullOrEmpty(mt_actual) Then
                    cmd.Parameters.Add("@MT_Actual", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@MT_Actual", OleDbType.Date).Value = mt_actual
                End If
                
                If String.IsNullOrEmpty(prgdd) Then
                    cmd.Parameters.Add("@prgdd", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@prgdd", OleDbType.Date).Value = prgdd
                End If
                
                If String.IsNullOrEmpty(pdd) Then
                    cmd.Parameters.Add("@pdd", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@pdd", OleDbType.Date).Value = pdd
                End If
                
                If String.IsNullOrEmpty(wsdc) Then
                    cmd.Parameters.Add("@wsdc", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@wsdc", OleDbType.Date).Value = wsdc
                End If
                
                If String.IsNullOrEmpty(pgdd) Then
                    cmd.Parameters.Add("@pgdd", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@pgdd", OleDbType.Date).Value = pgdd
                End If
                
                If String.IsNullOrEmpty(argdd) Then
                    cmd.Parameters.Add("@argdd", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@argdd", OleDbType.Date).Value = argdd
                End If

                If String.IsNullOrEmpty(dok_req) Then
                    cmd.Parameters.Add("@dok_req", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@dok_req", OleDbType.Date).Value = dok_req
                End If
                
                If String.IsNullOrEmpty(psmo) Then
                    cmd.Parameters.Add("@psmo", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@psmo", OleDbType.Date).Value = psmo
                End If
                
                If String.IsNullOrEmpty(ended) Then
                    cmd.Parameters.Add("@ended", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@ended", OleDbType.Date).Value = ended
                End If
                
                If String.IsNullOrEmpty(phr) Then
                    cmd.Parameters.Add("@phr", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@phr", OleDbType.Date).Value = phr
                End If
                
                If String.IsNullOrEmpty(g_end) Then
                    cmd.Parameters.Add("@g_end", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@g_end", OleDbType.Date).Value = g_end
                End If
                
                If String.IsNullOrEmpty(sok_end) Then
                    cmd.Parameters.Add("@sok_end", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@sok_end", OleDbType.Date).Value = sok_end
                End If
                
                If String.IsNullOrEmpty(comp1_name) Then
                    cmd.Parameters.Add("@comp1_name", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@comp1_name", OleDbType.VarChar).Value = comp1_name
                End If
                
                If String.IsNullOrEmpty(comp2_name) Then
                    cmd.Parameters.Add("@comp2_name", OleDbType.VarChar).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@comp2_name", OleDbType.VarChar).Value = comp2_name
                End If
                
                If String.IsNullOrEmpty(chk2_p2) Then
                    cmd.Parameters.Add("@chk2_p2", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@chk2_p2", OleDbType.Date).Value = chk2_p2
                End If
                
                If String.IsNullOrEmpty(pchk2_p2) Then
                    cmd.Parameters.Add("@pchk2_p2", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@pchk2_p2", OleDbType.Date).Value = pchk2_p2
                End If
                
                If String.IsNullOrEmpty(chk2_p3) Then
                    cmd.Parameters.Add("@chk2_p3", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@chk2_p2", OleDbType.Date).Value = chk2_p3
                End If
                
                If String.IsNullOrEmpty(pchk2_p3) Then
                    cmd.Parameters.Add("@pchk2_p3", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@pchk2_p3", OleDbType.Date).Value = pchk2_p3
                End If
                
                If String.IsNullOrEmpty(chk3) Then
                    cmd.Parameters.Add("@chk3", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@chk3", OleDbType.Date).Value = chk3
                End If
                
                If String.IsNullOrEmpty(pchk3) Then
                    cmd.Parameters.Add("@pchk3", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd.Parameters.Add("@pchk3", OleDbType.Date).Value = pchk3
                End If
                
                If mt_nothing = "off" Or String.IsNullOrEmpty(chk3_Nothing) Then
                    cmd.Parameters.Add("@chk3_Nothing", OleDbType.Boolean).Value = "False"
                Else
                    cmd.Parameters.Add("@chk3_Nothing", OleDbType.Boolean).Value = "True"
                End If
                
                cmd.Parameters.Add("@ID", OleDbType.Integer).Value = p_id
                
                cmd.ExecuteNonQuery()
                connection.Close()
                
                connection.Open()
                
                Dim sql_mcir As String = "UPDATE T_BASE SET mcir = ? WHERE ID = ?"
                Dim cmd_mcir As New OleDbCommand(sql_mcir, connection)
                If String.IsNullOrEmpty(mcir) Then
                    cmd_mcir.Parameters.Add("@mcir", OleDbType.Integer).Value = DBNull.Value
                Else
                    cmd_mcir.Parameters.Add("@mcir", OleDbType.Integer).Value = mcir
                End If
                cmd_mcir.Parameters.Add("@ID", OleDbType.Integer).Value = p_id
                cmd_mcir.ExecuteNonQuery()
                
                connection.Close()
                
                
                                
                connection.Open()
                
                Dim sql_mcirdate As String = "UPDATE T_BASE SET mcirdate = ? WHERE ID = ?"
                Dim cmd_mcirdate As New OleDbCommand(sql_mcirdate, connection)
                If String.IsNullOrEmpty(mcirdate) Then
                    cmd_mcirdate.Parameters.Add("@mcirdate", OleDbType.Date).Value = DBNull.Value
                Else
                    cmd_mcirdate.Parameters.Add("@mcirdate", OleDbType.Date).Value = mcirdate
                End If
                cmd_mcirdate.Parameters.Add("@ID", OleDbType.Integer).Value = p_id
                cmd_mcirdate.ExecuteNonQuery()
                
                connection.Close()
                
                connection.Open()
                If Not String.IsNullOrEmpty(ended) Then
                    
                    Dim sql2 As String = "UPDATE T_BASE SET Kanban_No = 0 WHERE ID = ?"
                    Dim cmd2 As New OleDbCommand(sql2, connection)
                    cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = p_id
                    cmd2.ExecuteNonQuery()
                    
                    Dim sql3 As String = "UPDATE T_TENKAI SET Kanban_No = 0 WHERE ID = ?"
                    Dim cmd3 As New OleDbCommand(sql3, connection)
                    cmd3.Parameters.Add("@ID", OleDbType.Integer).Value = p_id
                    cmd3.ExecuteNonQuery()
                End If
                connection.Close()
                
                connection.Open()
                Dim sql4 As String = ""
                If mt_nothing = "on" Then
                    If mt_plan = "1970-01-01" Then
                        sql4 = "UPDATE T_BASE SET FLAG = 0 WHERE ID = ?"
                    Else
                        sql4 = "UPDATE T_BASE SET FLAG = 0 WHERE ID = ?"
                    End If
                Else
                    sql4 = "UPDATE T_BASE SET FLAG = 1 WHERE ID = ?"
                End If


                Dim cmd4 As New OleDbCommand(sql4, connection)
                cmd4.Parameters.Add("@ID", OleDbType.Integer).Value = p_id
                cmd4.ExecuteNonQuery()
                connection.Close()
                
                connection.Open()
                Dim MTQuery As String = ""
                If mt_nothing = "off" Or String.IsNullOrEmpty(mt_nothing) Then
                    MTQuery = "UPDATE T_BASE SET mt = 'YES' WHERE ID = ?"
                Else
                    MTQuery = "UPDATE T_BASE SET mt = 'NO' WHERE ID = ?"
                End If
                Dim cmdMT As New OleDbCommand(MTQuery, connection)
                cmdMT.Parameters.Add("@ID", OleDbType.Integer).Value = p_id
                cmdMT.ExecuteNonQuery()
                connection.Close()
                
                connection.Open()
                Dim updateTime As String = "UPDATE T_BASE SET L_UPDATE = NOW() WHERE ID = ?"
                Dim cmdUpdate As New OleDbCommand(updateTime, connection)
                cmdUpdate.Parameters.Add("@ID", OleDbType.Integer).Value = p_id
                cmdUpdate.ExecuteNonQuery()
                connection.Close()
                
                'Response.Write("Edit Success")
                'Response.Write("<script>alert('Edit Success');</script>")
            Catch ex As Exception
                Response.Write(ex.ToString())
            End Try
        End If
        
        If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
            
            Dim id As Integer = Request.QueryString("id")
            
            Dim check As String = "SELECT COUNT(ID) FROM T_BASE WHERE ID = ?"
           	connection.Close()
            connection.Open()
            Dim checkcmd As New OleDbCommand(check, connection)
            checkcmd.Parameters.Add("@ID", OleDbType.Integer).Value = id
            Dim exists As String = checkcmd.ExecuteScalar()
            
            If exists = 0 Then
                Response.Write("<script>alert('No data found!'); window.close();</script>")
            End If
            
            
            Dim sql As String = "SELECT ID,M_NAME,BUNRUI,P_GENKO,P_HOSYOU,P_TENKAI,Kanban_No,mcir,mcirdate FROM T_BASE WHERE ID = ?"
            Try
                connection.Close()
                connection.Open()
                Dim cmd As New OleDbCommand(sql, connection)
                cmd.Parameters.Add("@ID", OleDbType.Integer).Value = id
                Dim reader = cmd.ExecuteReader
                
                While reader.Read()
                    mname = reader.Item("M_NAME").ToString()
                    
                    p_tenkai = String.Format("{0:yyyy/MM/dd}", reader.Item("P_TENKAI"))
                    p_genko = String.Format("{0:yyyy/MM/dd}", reader.Item("P_GENKO"))
                    p_hosyou = String.Format("{0:yyyy/MM/dd}", reader.Item("P_HOSYOU"))
                    kanban_no = reader.Item("Kanban_No").ToString
                    mcir = reader.Item("mcir").ToString
                    bunrui = reader.Item("bunrui").ToString
                    mcirdate = String.Format("{0:yyyy/MM/dd}", reader.Item("mcirdate"))
                    
                    If Not IsDBNull(reader.Item("P_TENKAI")) Then 'this means date is nothing
                        Dim tenkai_cast As DateTime = Convert.ToDateTime(reader.Item("P_TENKAI"))
                        If tenkai_cast = Convert.ToDateTime("1970/01/01") Then
                            p_tenkai = xmark
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("P_GENKO")) Then
                        Dim genko_cast As DateTime = Convert.ToDateTime(reader.Item("P_GENKO"))
                        If genko_cast = Convert.ToDateTime("1970/01/01") Then
                            p_genko = xmark
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("P_HOSYOU")) Then 'this means date is nothing
                        Dim hosyou_cast As DateTime = Convert.ToDateTime(reader.Item("P_HOSYOU"))
                        If hosyou_cast = Convert.ToDateTime("1970/01/01") Then
                            p_hosyou = xmark
                        End If
                    End If
                   
                    
                End While
                reader.Close()
                connection.Close()
            Catch ex As Exception
                Response.Write(ex.ToString())
            End Try
            connection.Close()
            Dim sql2 As String = "SELECT ID,tstart,SEC,SIN_INFO,T_NAME,S_NAME,[3_NAME],chk1,chk2,pchk1,pchk2,psd,C_plan,C_Nothing,C_actual,C_ComA,C_ComB,C_MDwg,P_Plan,P_Nothing,P_Actual,P_PreC,P_PreD,P_MDwg,MT_Plan,MT_Nothing,MT_Actual,prgdd,pdd,wsdc,pgdd,argdd,dok_req,psmo,ended,phr,G_END,SOK_END,comp1_name,comp2_name,chk2_p2,pchk2_p2,chk2_p3,pchk2_p3,chk3,pchk3,chk3_Nothing FROM T_TENKAI WHERE ID = ?"
            Try
                connection.Open()
                Dim cmd2 As New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                Dim reader = cmd2.ExecuteReader
            
                While reader.Read()
                    sec = reader.Item("SEC")
                    tstart = String.Format("{0:yyyy/MM/dd}", reader.Item("tstart"))
                    sin_info = reader.Item("SIN_INFO").ToString
                    design = reader.Item("T_NAME").ToString
                    check1 = reader.Item("S_NAME").ToString
                    check2 = reader.Item("3_NAME").ToString
                    comp1_name = reader.Item("comp1_name").ToString
                    comp2_name = reader.Item("comp2_name").ToString
                    chk1 = String.Format("{0:yyyy/MM/dd}", reader.Item("chk1"))
                    chk2 = String.Format("{0:yyyy/MM/dd}", reader.Item("chk2"))
                    chk2_p2 = String.Format("{0:yyyy/MM/dd}", reader.Item("chk2_p2"))
                    chk2_p3 = String.Format("{0:yyyy/MM/dd}", reader.Item("chk2_p3"))
                    pchk1 = String.Format("{0:yyyy/MM/dd}", reader.Item("pchk1"))
                    pchk2 = String.Format("{0:yyyy/MM/dd}", reader.Item("pchk2"))
                    pchk2_p2 = String.Format("{0:yyyy/MM/dd}", reader.Item("pchk2_p2"))
                    pchk2_p3 = String.Format("{0:yyyy/MM/dd}", reader.Item("pchk2_p3"))
                    
                    chk3 = String.Format("{0:yyyy/MM/dd}", reader.Item("chk3"))
                    pchk3 = String.Format("{0:yyyy/MM/dd}", reader.Item("pchk3"))
                    chk3_Nothing = String.Format("{0:yyyy/MM/dd}", reader.Item("chk3_Nothing"))
                    
                    psd = String.Format("{0:yyyy/MM/dd}", reader.Item("psd"))
                    c_plan = String.Format("{0:yyyy/MM/dd}", reader.Item("C_plan"))
                    c_nothing = reader.Item("C_Nothing").ToString()
                    c_actual = String.Format("{0:yyyy/MM/dd}", reader.Item("C_Actual"))
                    c_coma = reader.Item("C_ComA").ToString()
                    c_comb = reader.Item("C_ComB").ToString()
                    c_mdwg = reader.Item("C_MDwg").ToString()
                    p_plan = String.Format("{0:yyyy/MM/dd}", reader.Item("P_Plan"))
                    p_nothing = reader.Item("P_Nothing").ToString()
                    p_actual = String.Format("{0:yyyy/MM/dd}", reader.Item("P_Actual"))
                    p_prec = reader.Item("P_PreC").ToString()
                    p_pred = reader.Item("P_PreD").ToString()
                    p_mdwg = reader.Item("P_MDwg").ToString()
                    mt_plan = String.Format("{0:yyyy/MM/dd}", reader.Item("MT_PLAN"))
                    mt_nothing = reader.Item("MT_Nothing").ToString()
                    mt_actual = String.Format("{0:yyyy/MM/dd}", reader.Item("MT_Actual"))
                    pdd = String.Format("{0:yyyy/MM/dd}", reader.Item("pdd"))
                    
                    prgdd = String.Format("{0:yyyy/MM/dd}", reader.Item("prgdd"))
                    argdd = String.Format("{0:yyyy/MM/dd}", reader.Item("argdd"))
                    
                    dok_req = String.Format("{0:yyyy/MM/dd}", reader.Item("DOK_REQ"))
                    phr = String.Format("{0:yyyy/MM/dd}", reader.Item("phr"))
                    
                    psmo = String.Format("{0:yyyy/MM/dd}", reader.Item("psmo"))
                    sok_end = String.Format("{0:yyyy/MM/dd}", reader.Item("SOK_END"))
                    
                    ended = String.Format("{0:yyyy/MM/dd}", reader.Item("ENDED"))
                    g_end = String.Format("{0:yyyy/MM/dd}", reader.Item("G_END"))
                    wsdc = String.Format("{0:yyyy/MM/dd}", reader.Item("wsdc"))
                    pgdd = String.Format("{0:yyyy/MM/dd}", reader.Item("pgdd"))
                    
                    If Not IsDBNull(reader.Item("prgdd")) Then
                        Dim a As DateTime = Convert.ToDateTime(reader.Item("prgdd"))
                        If a = Convert.ToDateTime("1970/01/01") Then
                            prgdd = "1970/01/01"
                            argdd = "1970/01/01"
                            c1 = "checked"
                            it1 = "hidden"
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("dok_req")) Then
                        Dim b As DateTime = Convert.ToDateTime(reader.Item("dok_req"))
                        If b = Convert.ToDateTime("1970/01/01") Then
                            dok_req = "1970/01/01"
                            phr = "1970/01/01"
                            c2 = "checked"
                            it2 = "hidden"
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("psmo")) Then
                        Dim c As DateTime = Convert.ToDateTime(reader.Item("sok_end"))
                        If c = Convert.ToDateTime("1970/01/01") Then
                            psmo = "1970/01/01"
                            sok_end = "1970/01/01"
                            c3 = "checked"
                            it3 = "hidden"
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("tstart")) Then
                        Dim c As DateTime = Convert.ToDateTime(reader.Item("tstart"))
                        If c = Convert.ToDateTime("1970/01/01") Then
                            tstart = "1970/01/01"
                            psd = "1970/01/01"
                            tstart_nothing = "checked"
                            tstart_it = "hidden"
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("chk1")) Then
                        Dim c As DateTime = Convert.ToDateTime(reader.Item("chk1"))
                        If c = Convert.ToDateTime("1970/01/01") Then
                            chk1 = "1970/01/01"
                            pchk1 = "1970/01/01"
                            chk1_nothing = "checked"
                            chk1_it = "hidden"
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("chk2")) Then
                        Dim c As DateTime = Convert.ToDateTime(reader.Item("chk2"))
                        If c = Convert.ToDateTime("1970/01/01") Then
                            chk2 = "1970/01/01"
                            pchk2 = "1970/01/01"
                            chk2_nothing = "checked"
                            chk2_it = "hidden"
                            chkbox_c2 = "hide"
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("chk2_p2")) Then
                        Dim c As DateTime = Convert.ToDateTime(reader.Item("chk2_p2"))
                        If c = Convert.ToDateTime("1970/01/01") Then
                            chk2 = "1970/01/01"
                            pchk2 = "1970/01/01"
                            chk2_nothing = "checked"
                            chk2_it = "hidden "
                            chkbox_c2 = "hide"
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("pchk2_p2")) Then
                        Dim c As DateTime = Convert.ToDateTime(reader.Item("pchk2_p2"))
                        If c = Convert.ToDateTime("1970/01/01") Then
                            chk2 = "1970/01/01"
                            pchk2 = "1970/01/01"
                            chk2_nothing = "checked"
                            chk2_it = "hidden"
                            chkbox_c2 = "hide"
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("chk2_p3")) Then
                        Dim c As DateTime = Convert.ToDateTime(reader.Item("chk2_p3"))
                        If c = Convert.ToDateTime("1970/01/01") Then
                            chk2 = "1970/01/01"
                            pchk2 = "1970/01/01"
                            chk2_nothing = "checked"
                            chk2_it = "hidden "
                            chkbox_c2 = "hide"
                        End If
                    End If
                    
                    If Not IsDBNull(reader.Item("pchk2_p3")) Then
                        Dim c As DateTime = Convert.ToDateTime(reader.Item("pchk2_p3"))
                        If c = Convert.ToDateTime("1970/01/01") Then
                            chk2 = "1970/01/01"
                            pchk2 = "1970/01/01"
                            chk2_nothing = "checked"
                            chk2_it = "hidden"
                            chkbox_c2 = "hide"
                        End If
                    End If
                    
                End While
                reader.Close()
                connection.Close()

                If c_nothing = False Then
                    c_nothing = ""
                    
                    If c_coma = False Then
                        c_coma = ""
                    Else
                        c_coma = "checked"
                    End If
                
                    If c_comb = False Then
                        c_comb = ""
                    Else
                        c_comb = "checked"
                    End If
                
                    If c_mdwg = False Then
                        c_mdwg = ""
                    Else
                        c_mdwg = "checked"
                    End If
                    
                Else
                    c_nothing = "checked"
                    chkbox_comp = "hide"
                    c_it = "hidden"
                End If
                
                
                If p_nothing = False Then
                    p_nothing = ""
                    
                    If p_prec = False Then
                        p_prec = ""
                    Else
                        p_prec = "checked"
                    End If
                
                    If p_pred = False Then
                        p_pred = ""
                    Else
                        p_pred = "checked"
                    End If
                
                    If p_mdwg = False Then
                        p_mdwg = ""
                    Else
                        p_mdwg = "checked"
                    End If
                Else
                    p_nothing = "checked"
                    chkbox_prep = "hide"
                    p_it = "hidden"
                End If
                
                
                If mt_nothing = False Then
                    mt_nothing = ""
                Else
                    mt_nothing = "checked"
                    mt_it = "hidden"
                End If
                
                If chk3_Nothing = False Then
                    chk3_Nothing = ""
                Else
                    chk3_Nothing = "checked"
                    chk3_it = "hidden"
                End If
                
                If p_pred = "" Or p_mdwg = "" Then
                    pchk2_ro = "readonly"
                    'pchk2 = ""
                End If
                
                If String.IsNullOrEmpty(mcir) Then
                    ended_ro = "readonly"
                End If
                
                If bunrui = "QC" Then
                    qcShow = ""
                    assyShow = "hide"
                    qcDisabled = ""
                    assyDisabled = "disabled"
                    qcCheck = "checked"
                    pchk2_ro = ""
                End If
                
            Catch ex As Exception
                Response.Write(ex.ToString())
            End Try
            
            qcShow = ""
            assyShow = "hide"
            qcDisabled = ""
            assyDisabled = "disabled"
            qcCheck = "checked"
            pchk2_ro = ""
        End If
    %>

    <%
        If String.IsNullOrEmpty(Request.Form("submit")) Then
    %>

    <section class="section">
        <div class="row">
            <div class="col-md-12">
                <h3>TENKAI Progress Information Update <% Response.Write("(" & bunrui & ")")%></h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h5><strong>Model Name: <% =mname %></strong></h5>
            </div>
        </div>

        <form class="" method="post">
            <div class="row">
                <div class="col-xs-2 no-pad-right">
                    <div class="form-group">
                        <label>Section</label>
                        <input type="text" class="form-control" name="sec" readonly value="<% =sec %>">
                    </div>
                </div>
                <div class="col-xs-2 no-pad-right">
                    <div class="form-group">
                        <label>Kanban No.</label>
                        <input type="text" class="form-control" name="kanban_no"  value="<% =kanban_no %>" readonly>
                    </div>
                </div>
                <div class="col-xs-4 no-pad-right">
                    <div class="form-group">
                        <label>Progress</label>
                        <input type="text" class="form-control" name="sin_info"  value="<% =sin_info %>">
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="form-group">
                        <label>Compare Person</label>
                        <input type="text" class="form-control" name="comp1_name"  value="<% = comp1_name%>">
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="form-group">
                        <label>&nbsp;&nbsp;</label>
                        <input type="text" class="form-control" name="comp2_name"  value="<% = comp2_name%>">
                    </div>
                </div>
                
            </div>

            <div class="row">
                <div class="col-xs-4 no-pad-right">
                    <div class="form-group">
                        <label>Designer</label>
                        <input type="text" class="form-control" name="t_name" value="<% =design %>">
                    </div>
                </div>
                <div class="col-xs-4 no-pad-right">
                    <div class="form-group">
                        <label>Checker</label>
                        <input type="text" class="form-control" name="s_name" value="<% =check1 %>">
                    </div>
                </div>
                <div class="col-xs-4">
                    <div class="form-group">
                        <label>Rechecker</label>
                        <input type="text" class="form-control" name="check2" value="<% =check2 %>">
                    </div>
                </div>
            </div>

            <table class="table-nkupdate">
                <thead>
                    <th class="th-fw-3"></th>
                    <th class="th-fw-6">Comparison</th>
                    <th class="th-fw-6 <% =assyShow %>">Preparation</th>
                    <th class="th-fw-6">Input</th> <!--Start Design-->
                    <th class="th-fw-6">Check1</th>
                    <th class="th-fw-6">Check2</th>
                    <th class="th-fw-6">MT Check by DF</th>
                </thead>
                <tbody>
                    <tr>
                        <td class="plan">Plan</td>
                        <td>
                            <input type="<% =c_it %>" class="form-control" name="c_plan" value="<% =c_plan %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                            <div class="checkbox">
                                <label><input type="checkbox" name="c_nothing" <% =c_nothing %>><i>Nothing</i></label>
                            </div>
                            <div class="checkbox <% =chkbox_comp %>">
                                <label><input type="checkbox" name="c_coma" <% =c_coma %>>C1</label>
                            </div>
                            <div class="checkbox <% =chkbox_comp %>">
                                <label><input type="checkbox" name="c_comb" <% =c_comb %>>C2</label>
                            </div>
                            <div class="checkbox <% =chkbox_comp %>">
                                <label><input type="checkbox" name="c_mdwg" <% =c_mdwg %>>C3</label>
                            </div>
                        </td>
                        <td class="<% =assyShow %>">
                            <input type="<% =p_it %>" class="form-control" name="p_plan" value="<% =p_plan %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" <% =assyDisabled %>>
                            <div class="checkbox">
                                <label><input type="checkbox" name="p_nothing" <% =p_nothing %>><i>Nothing</i></label>
                            </div>
                            <!--<div class="checkbox <% =chkbox_prep %>">-->
                            <div class="checkbox hide">
                                <label><input type="checkbox" name="p_prec" <% =p_prec %>>P1</label>
                            </div>
                            <%--<div class="checkbox <% =chkbox_prep %>">
                                <label><input type="checkbox" name="p_pred" <% =p_pred %>>P2</label>
                            </div>
                            <div class="checkbox <% =chkbox_prep %>">
                                <label><input type="checkbox" name="p_mdwg" <% =p_mdwg %>>P3</label>
                            </div>--%>
                        </td>
                        <td>
                            <div class="row <% =qcShow %>">
                                <div class="col-xs-3">
                                        <label class="label-ctrl">PD</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =p_it %>" class="form-control" name="p_plan" value="<% =p_plan %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" <% =qcDisabled %>>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-3 no-pad-right no-pad-left">
                                    <label class="label-ctrl">Inp Fin</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =tstart_it %>" class="form-control" name="tstart" value="<% =tstart %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                                </div>
                            </div>

                            <div class="checkbox checkbox-nothing">
                                <label><input type="checkbox" name="tstart_nothing" <% =tstart_nothing %>><i>Nothing</i></label>
                            </div>
                        </td>
                        <td>
                            <div class="row <% =qcShow %>">
                                <div class="col-xs-3">
                                    <label class="label-ctrl">P1</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =chk2_it %>" class="form-control" name="chk2_p2" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" value="<% =chk2_p2 %>" <% =qcDisabled %>>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-3 no-pad-right no-pad-left">
                                    <label class="label-ctrl">C1 OK</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =chk1_it %>" class="form-control" name="chk1" value="<% =chk1 %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                                </div>
                            </div>

                            <div class="checkbox checkbox-nothing">
                                <label><input type="checkbox" name="chk1_n" <% =chk1_nothing %>><i>Nothing</i></label>
                            </div>
                        </td>
                        <td>
                            <div class="row <% =assyShow %>">
                                <div class="col-xs-3">
                                    <label class="label-ctrl">P2</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =chk2_it %>" class="form-control" name="chk2_p2" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" value="<% =chk2_p2 %>" <% =assyDisabled %>>
                                </div>
                            </div>

                            <div class="row <% =qcShow %>">
                                <div class="col-xs-3">
                                    <label class="label-ctrl">P2</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =chk2_it %>" class="form-control" name="chk2_p3" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" value="<% =chk2_p3 %>" <% =qcDisabled %>>
                                </div>
                            </div>

                            <div class="row <% =assyShow %>">
                                <div class="col-xs-3">
                                    <div class="checkbox <% =chkbox_c2 %>">
                                        <label><input type="checkbox" name="p_mdwg" <% =p_mdwg %>>P3</label>
                                    </div>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =chk2_it %>" class="form-control" name="chk2_p3" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" value="<% =chk2_p3 %>" <% =assyDisabled %>>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-3 no-pad-right no-pad-left">
                                    <label class="label-ctrl <% =chkbox_c2 %>">C2 OK</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =chk2_it %>" class="form-control" name="chk2" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" value="<% =chk2 %>">
                                </div>
                            </div>

                            <div class="checkbox checkbox-nothing">
                                <label><input type="checkbox" name="chk2_n" <% =chk2_nothing %>><i>Nothing</i></label>
                            </div>
                        </td>
                        <td>
                            <input type="<% =mt_it %>" class="form-control" name="mt_plan" value="<% =mt_plan %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                            <div class="checkbox checkbox-nothing">
                                <label><input type="checkbox" name="mt_nothing" <% =mt_nothing %>><i>Nothing</i></label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="actual">Actual</td>
                        <td><input type="<% =c_it %>" class="form-control" name="c_actual" value="<% =c_actual %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                        <td class="<% =assyShow %>"><input type="<% =p_it %>" class="form-control" name="p_actual" value="<% =p_actual %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" <% =assyDisabled %>></td>
                        <td>
                            <div class="row <% =qcShow %>">
                                <div class="col-xs-3">
                                    <label class="label-ctrl <% =chkbox_c2 %>">PD</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =p_it %>" class="form-control" name="p_actual" value="<% =p_actual %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" <% =qcDisabled %>>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-3 no-pad-right no-pad-left">
                                    <label class="label-ctrl">Input Fin</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =tstart_it %>" class="form-control" name="psd" value="<% =psd %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                                </div>
                            </div>

                            
                        </td>
                        <td>
                            <div class="row <% =qcShow %>">
                                <div class="col-xs-3">
                                    <label class="label-ctrl <% =chkbox_c2 %>">P1</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =chk2_it %>" class="form-control" name="pchk2_p2" value="<% =pchk2_p2 %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" <% =qcDisabled %>>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-3 no-pad-right no-pad-left">
                                    <label class="label-ctrl">C1 OK</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =chk1_it %>" class="form-control" name="pchk1" value="<% =pchk1 %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                                </div>
                            </div>
                            
                        </td>
                        <td>
                            <div class="row <% =assyShow %>">
                                <div class="col-xs-3">
                                    <label class="label-ctrl <% =chkbox_c2 %>">P2</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =chk2_it %>" class="form-control" name="pchk2_p2" value="<% =pchk2_p2 %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" <% =assyDisabled %>>
                                </div>
                            </div>

                            <div class="row <% =qcShow %>">
                                <div class="col-xs-3">
                                    <label class="label-ctrl">P2</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =chk2_it %>" class="form-control" name="pchk2_p3" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" value="<% =pchk2_p3 %>" <% =qcDisabled %>>
                                </div>
                            </div>

                            <div class="row <% =assyShow %>">
                                <div class="col-xs-3">
                                    <label class="label-ctrl <% =chkbox_c2 %>">P3</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =chk2_it %>" class="form-control" name="pchk2_p3" value="<% =pchk2_p3 %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" <%=pchk2_ro %> <%=assyDisabled %>>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-3 no-pad-right no-pad-left">
                                    <label class="label-ctrl <% =chkbox_c2 %>">C2 OK</label>
                                </div>
                                <div class="col-xs-9 pt-1">
                                    <input type="<% =chk2_it %>" class="form-control" name="pchk2" value="<% =pchk2 %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" <%=pchk2_ro %>>
                                </div>
                            </div>
                        </td>
                        <td><input type="<% =mt_it %>" class="form-control" name="mt_actual" value="<% =mt_actual %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                    </tr>
                </tbody>
            </table>
                
            <table class="table-nkupdate">
                <thead>
                    <th class="th-fw-3"></th>
                    <th class="th-fw-6">FALP Due Date</th>
                    <th class="th-fw-6">Check3</th>
                    <th class="th-fw-6">Gua Due Date</th>
                    <th class="th-fw-6">Re-Gua Due Date</th>
                </thead>
                <tbody>
                    <tr>
                        <td class="plan">Plan</td>
                        <td class="text-center"><% =p_tenkai %></td>
                        <td>
                            <input type="<% =chk3_it %>" class="form-control" name="chk3" value="<% =chk3 %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                            <div class="checkbox checkbox-nothing">
                              <label><input type="checkbox" name="chk3_Nothing" <% =chk3_Nothing %>>: <i>Nothing</i></label>
                            </div>
                        </td>
                        <td class="text-center"><% =p_hosyou %></td>
                        <td>
                            <input type="<% =it1 %>" class="form-control" name="prgdd" value="<% =prgdd %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                            <div class="checkbox checkbox-nothing">
                              <label><input type="checkbox" name="prgdd_n" <% =c1 %>>: <i>Nothing</i></label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="actual">Actual</td>
                        <td><input type="text" class="form-control" name="pdd" value="<% =pdd %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                        <td><input type="<% =chk3_it %>" class="form-control" name="pchk3" value="<% =pchk3 %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                        <td><input type="text" class="form-control" name="pgdd" value="<% =pgdd %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                        <td><input type="<% =it1 %>" class="form-control" name="argdd" value="<% =argdd %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                    </tr>
                </tbody>
            </table>

            <table class="table-nkupdate">
                <thead>
                    <th class="th-fw-3"></th>
                    <th class="th-fw-6">Host No. Registration</th>
                    <th class="th-fw-6">Present Process</th>
                    <th class="th-fw-6">Send Model/SAV</th>
                    <th class="th-fw-6">MCIR/Finished</th>
                </thead>
                <tbody>
                    <tr>
                        <td class="plan">Plan</td>
                        <td>
                            <input type="<% =it2 %>" class="form-control" name="dok_req" value="<% =dok_req %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                            <div class="checkbox checkbox-nothing ">
                              <label><input type="checkbox" name="dok_req_n" <% =c2 %>>: <i>Nothing</i></label>
                            </div>

                            <%--<input type="hidden" class="form-control" name="dok_req" value="1970-01-01" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" <% =qcDisabled %>>
                            <div class="checkbox checkbox-nothing <% =qcShow %>">
                              <label><input type="checkbox" name="dok_req_n" checked>: <i>Nothing</i></label>
                            </div>--%>
                        </td>
                        <td class="text-center"><% =p_genko %></td>
                        <td>
                            <input type="<% =it3 %>" class="form-control" name="psmo" value="<% =psmo %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                            <div class="checkbox checkbox-nothing">
                              <label><input type="checkbox" name="psmo_n" <% =c3 %>>: <i>Nothing</i></label>
                            </div>
                        </td>
                        <td>
                            <input type="number" class="form-control" name="mcir" placeholder="MCIR" autocomplete="off" style="margin-bottom: 5px" value="<%=mcir %>">
                            <input type="text" class="form-control" name="mcirdate" value="<% =mcirdate %>" style="margin-bottom: 5px" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                            <input type="text" class="form-control" name="ended" value="<% =ended %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])" <%=ended_ro %>>
                        </td>
                    </tr>
                    <tr>
                        <td class="actual">Actual</td>
                        <td>
                            <input type="<% =it2 %>" class="form-control" name="phr" value="<% =phr %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                        </td>
                        <td><input type="text" class="form-control" name="g_end" value="<% =g_end %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                        <td><input type="<% =it3 %>" class="form-control" name="sok_end" value="<% =sok_end %>" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])"></td>
                        <td></td>
                    </tr>
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
    <script type="text/javascript" src="bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="script.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //            $('.dt-picker').datetimepicker({
            //                format: "YYYY/MM/DD"
            //            });
            $('input').prop('autocomplete','off');

            $('input[name="c_nothing"]').click(function () {
                if ($(this).is(':checked')) {
                    $('input[name="c_plan"]').attr('type', 'hidden').val('');
                    $('input[name="c_actual"]').attr('type', 'hidden').val('');
                    $('input[name="c_coma"]').prop('checked', false).closest('.checkbox').addClass('hide');
                    $('input[name="c_comb"]').prop('checked', false).closest('.checkbox').addClass('hide');
                    $('input[name="c_mdwg"]').prop('checked', false).closest('.checkbox').addClass('hide');
                } else {
                    $('input[name="c_plan"]').attr('type', 'text').val('');
                    $('input[name="c_actual"]').attr('type', 'text').val('');
                    $('input[name="c_coma"]').prop('checked', false).closest('.checkbox').removeClass('hide');
                    $('input[name="c_comb"]').prop('checked', false).closest('.checkbox').removeClass('hide');
                    $('input[name="c_mdwg"]').prop('checked', false).closest('.checkbox').removeClass('hide');
                }
            });

            $('input[name="p_nothing"]').click(function () {
                if ($(this).is(':checked')) {
                    $('input[name="p_plan"]').attr('type', 'hidden').val('');
                    $('input[name="p_actual"]').attr('type', 'hidden').val('');
                    $('input[name="p_prec"]').prop('checked', false).closest('.checkbox').addClass('hide');
                } else {
                    $('input[name="p_plan"]').attr('type', 'text').val('');
                    $('input[name="p_actual"]').attr('type', 'text').val('');
                    $('input[name="p_prec"]').prop('checked', false).closest('.checkbox').removeClass('hide');
                }
            });

            $('input[name="tstart_nothing"]').click(function () {
                if ($(this).is(':checked')) {
                    $('input[name="tstart"]').attr('type', 'hidden').val('1970-01-01');
                    $('input[name="psd"]').attr('type', 'hidden').val('1970-01-01');
                } else {
                    $('input[name="tstart"]').attr('type', 'text').val('');
                    $('input[name="psd"]').attr('type', 'text').val('');
                }
            });

            $('input[name="chk1_n"]').click(function () {
                if ($(this).is(':checked')) {
                    $('input[name="chk1"]').attr('type', 'hidden').val('1970-01-01');
                    $('input[name="pchk1"]').attr('type', 'hidden').val('1970-01-01');
                } else {
                    $('input[name="chk1"]').attr('type', 'text').val('');
                    $('input[name="pchk1"]').attr('type', 'text').val('');
                }
            });

            $('input[name="chk2_n"]').click(function () {
                if ($(this).is(':checked')) {
                    $('input[name="chk2"]').attr('type', 'hidden').val('1970-01-01');
                    $('input[name="chk2"]').closest('.row').find('label').addClass('hide');
                    $('input[name="chk2_p2"]').attr('type', 'hidden').val('1970-01-01');
                    $('input[name="chk2_p3"]').attr('type', 'hidden').val('1970-01-01');

                    $('input[name="pchk2"]').attr('type', 'hidden').val('1970-01-01');
                    $('input[name="pchk2"]').closest('.row').find('label').addClass('hide');
                    $('input[name="pchk2_p2"]').attr('type', 'hidden').val('1970-01-01');
                    $('input[name="pchk2_p2"]').closest('.row').find('label').addClass('hide');
                    $('input[name="pchk2_p3"]').attr('type', 'hidden').val('1970-01-01');
                    $('input[name="pchk2_p3"]').closest('.row').find('label').addClass('hide');

                    $('input[name="p_pred"]').prop('checked', false).closest('.checkbox').addClass('hide');
                    $('input[name="p_mdwg"]').prop('checked', false).closest('.checkbox').addClass('hide');
                } else {
                    $('input[name="chk2"]').closest('.row').find('label').removeClass('hide');
                    $('input[name="chk2"]').attr('type', 'text').val('');
                    $('input[name="chk2_p2"]').attr('type', 'text').val('');
                    $('input[name="chk2_p3"]').attr('type', 'text').val('');

                    $('input[name="pchk2"]').attr('type', 'text').val('');
                    $('input[name="pchk2"]').closest('.row').find('label').removeClass('hide');
                    $('input[name="pchk2_p2"]').attr('type', 'text').val('');
                    $('input[name="pchk2_p2"]').closest('.row').find('label').removeClass('hide');
                    $('input[name="pchk2_p3"]').attr('type', 'text').val('');
                    $('input[name="pchk2_p3"]').closest('.row').find('label').removeClass('hide');

                    $('input[name="p_pred"]').prop('checked', false).closest('.checkbox').removeClass('hide');
                    $('input[name="p_mdwg"]').prop('checked', false).closest('.checkbox').removeClass('hide');
                }
            });

            $('input[name="mt_nothing"]').click(function () {
                if ($(this).is(':checked')) {
                    $('input[name="mt_plan"]').attr('type', 'hidden').val('1970-01-01');
                    $('input[name="mt_actual"]').attr('type', 'hidden').val('1970-01-01');
                } else {
                    $('input[name="mt_plan"]').attr('type', 'text').val('');
                    $('input[name="mt_actual"]').attr('type', 'text').val('');
                }
            });

            $('input[name="chk3_Nothing"]').click(function () {
                if ($(this).is(':checked')) {
                    $('input[name="chk3"]').attr('type', 'hidden').val('1970-01-01');
                    $('input[name="pchk3"]').attr('type', 'hidden').val('1970-01-01');
                } else {
                    $('input[name="chk3"]').attr('type', 'text').val('');
                    $('input[name="pchk3"]').attr('type', 'text').val('');
                }
            });

            $('input[name="c_mdwg"]').click(function () {
                if ($(this).is(':checked')) {
                    $('input[name="c_actual"]').val(moment().format('YYYY/MM/DD'));
                } else {
                    $('input[name="c_actual"]').val('');
                }
            });

            //            $('input[name="p_pred"]').click(function () {
            //                if ($(this).is(':checked') && $('input[name="p_mdwg"]').is(':checked')) {
            //                    $('input[name="chk2_p2"]').val(moment().format('YYYY/MM/DD'));

            //                    $('input[name="pchk2"]').attr('readonly', false);
            //                    $('input[name="pchk2_p3"]').attr('readonly', false);
            //                    $('input[name="chk2_p3"]').val(moment().format('YYYY/MM/DD'));
            //                } else {

            //                    $('input[name="pchk2"]').attr('readonly', true).val('');
            //                    $('input[name="pchk2_p3"]').attr('readonly', true).val('');
            //                    $('input[name="chk2_p3"]').val('');
            //                }
            //            });

            $('input[name="p_mdwg"]').click(function () {
                if ($(this).is(':checked')) {
                    $('input[name="pchk2"]').attr('readonly', false);
                    $('input[name="pchk2_p3"]').attr('readonly', false);
                    if ($('input[name="chk2_p2"]').val() != '') {
                        $('input[name="chk2_p3"]').val($('input[name="chk2_p2"]').val());
                    } else {
                        $('input[name="chk2_p3"]').val(moment().format('YYYY/MM/DD'));
                        $('input[name="chk2_p2"]').val(moment().format('YYYY/MM/DD'))
                    }
                    
                } else {
                    $('input[name="pchk2"]').attr('readonly', true).val('');
                    $('input[name="pchk2_p3"]').attr('readonly', true).val('');
                    $('input[name="chk2_p3"]').val('');
                }
            });

            $('input[name="prgdd_n"]').click(function () {
                if ($(this).is(':checked')) {
                    $('input[name="prgdd"]').attr('type', 'hidden').val('1970-01-01');
                    $('input[name="argdd"]').attr('type', 'hidden').val('1970-01-01');
                } else {
                    $('input[name="prgdd"]').attr('type', 'text').val('');
                    $('input[name="argdd"]').attr('type', 'text').val('');
                }
            });

            $('input[name="dok_req_n"]').click(function () {
                if ($(this).is(':checked')) {
                    $('input[name="dok_req"]').attr('type', 'hidden').val('1970-01-01');
                    $('input[name="phr"]').attr('type', 'hidden').val('1970-01-01');
                } else {
                    $('input[name="dok_req"]').attr('type', 'text').val('');
                    $('input[name="phr"]').attr('type', 'text').val('');
                }
            });

            $('input[name="psmo_n"]').click(function () {
                if ($(this).is(':checked')) {
                    $('input[name="psmo"]').attr('type', 'hidden').val('1970-01-01');
                    $('input[name="sok_end"]').attr('type', 'hidden').val('1970-01-01');
                } else {
                    $('input[name="psmo"]').attr('type', 'text').val('');
                    $('input[name="sok_end"]').attr('type', 'text').val('');
                }
            });

            $('input[name="mcir"]').keyup(function () {
                if ($(this).val() != '') {
                    $('input[name="ended"]').prop('readonly', false);
                } else {
                    $('input[name="ended"]').prop('readonly', true);
                }
            });

        });
    </script>
</body>
</html>
