<%@ Page Language="VB" AutoEventWireup="false" CodeFile="export_csv.aspx.vb" Inherits="export_csv" %>

<%@ Import Namespace="System.Collections.Generic" %>

<%@ Import Namespace="System.IO" %>

<%@ Import Namespace="System.Data" %>

<%@ Import Namespace="System.Data.OleDb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <%
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
        Dim connection As OleDbConnection = New OleDbConnection(connectionString)
        
        Dim dt As String = DateTime.Now.ToString()
        Dim maker As String = Request.QueryString("maker")
        Dim dcondition As String = Request.QueryString("dcondition")
        Dim bunrui As String = Request.QueryString("bunrui")
        Dim filter As String = Request.QueryString("filter")
        Dim filter_value As String = Request.QueryString("filter_value")
        Dim duedate As String = Request.QueryString("duedate")
        Dim date_range As String = Request.QueryString("date_range")
        Dim date_start As String = Request.QueryString("date_start")
        Dim date_end As String = Request.QueryString("date_end")
        
        Dim sql As String = ""
        sql = sql + "SELECT "
        sql = sql + "a.ID,"
        sql = sql + "a.T_KUBUN,"
        sql = sql + "a.REMARK,"
        sql = sql + "a.R_NUMBER,"
        sql = sql + "a.MAKER,"
        sql = sql + "a.C_TYPE,"
        sql = sql + "a.M_NAME,"
        sql = sql + "a.P_TENKAI,"
        sql = sql + "a.P_GENKO,"
        sql = sql + "a.P_HOSYOU,"
        sql = sql + "a.P_DOK,"
        sql = sql + "a.revision,"
        sql = sql + "a.Kanban_No,"
        sql = sql + "a.event,"
        sql = sql + "a.mt,"
        sql = sql + "a.wcsd,"
        sql = sql + "a.L_UPDATE,"
                
        sql = sql + "b.SIN_INFO,"
        sql = sql + "b.T_NAME,"
        sql = sql + "b.S_NAME,"
        sql = sql + "b.[3_NAME],"
        sql = sql + "b.phr,"
        sql = sql + "b.DOISY,"
        sql = sql + "b.G_END,"
        sql = sql + "b.SOK_END,"
        sql = sql + "b.SEC,"
        sql = sql + "b.ENDED,"
        sql = sql + "b.DOK_REQ,"
        sql = sql + "b.phr,"
        sql = sql + "b.pdd,"
        sql = sql + "b.wsdc,"
        sql = sql + "b.pgdd,"
        sql = sql + "b.prgdd,"
        sql = sql + "b.argdd,"
        sql = sql + "b.phr,"
        sql = sql + "b.DOISY,"
        sql = sql + "b.G_END,"
        sql = sql + "b.psmo,"
        sql = sql + "b.SOK_END,"
        sql = sql + "b.ENDED,"
        sql = sql + "b.tstart,"
        sql = sql + "b.psd,"
        sql = sql + "b.chk1,"
        sql = sql + "b.chk2,"
        sql = sql + "b.chk3,"
        sql = sql + "b.pchk1,"
        sql = sql + "b.pchk2,"
        sql = sql + "b.pchk3,"
        sql = sql + "b.C_plan,"
        sql = sql + "b.C_actual,"
        sql = sql + "b.P_Plan,"
        sql = sql + "b.P_Actual,"
        sql = sql + "b.MT_Plan,"
        sql = sql + "b.MT_Actual "
                
        sql = sql + "FROM T_BASE a "
        sql = sql + "INNER JOIN T_TENKAI b "
        sql = sql + "ON a.ID = b.ID "
        sql = sql + "WHERE (a.Kanban_No "
        
        If Not String.IsNullOrEmpty(Request.QueryString("dcondition")) Then
            If Request.QueryString("dcondition") = "allf" Then
                sql = sql + "= 0) "
            ElseIf Request.QueryString("dcondition") = "all" Or Request.QueryString("dcondition") = "non-f" Then
                sql = sql + "IS NOT NULL OR a.Kanban_No = 0) "
            Else
                sql = sql + ">= 0) "
            End If
        End If
        
        sql = sql + "AND b.SEC='FALP' "
        sql = sql + "AND a.BUNRUI <> 'Correction' "
        sql = sql + "AND a.BUNRUI = '" + bunrui + "' "
        
        If Not Request.QueryString("maker") = "null" Then
            sql = sql + "AND a.MAKER='" + Request.QueryString("maker") + "' "
        End If
        
        If Not duedate = "null" And Not String.IsNullOrEmpty(date_start) Then
            If Not date_range = "range" Then
                        
                If duedate = "tenkai" Then
                    Select Case date_range
                        Case "eq"
                            sql = sql + "AND P_TENKAI = #" + date_start + "# "
                        Case "gt"
                            sql = sql + "AND P_TENKAI >= #" + date_start + "# "
                        Case "lt"
                            sql = sql + "AND P_TENKAI <= #" + date_start + "# "
                    End Select
                ElseIf duedate = "genko" Then
                    Select Case date_range
                        Case "eq"
                            sql = sql + "AND P_GENKO = #" + date_start + "# "
                        Case "gt"
                            sql = sql + "AND P_GENKO >= #" + date_start + "# "
                        Case "lt"
                            sql = sql + "AND P_GENKO <= #" + date_start + "# "
                    End Select
                ElseIf duedate = "dok" Then
                    Select Case date_range
                        Case "eq"
                            sql = sql + "AND P_DOK = #" + date_start + "# "
                        Case "gt"
                            sql = sql + "AND P_DOK >= #" + date_start + "# "
                        Case "lt"
                            sql = sql + "AND P_DOK <= #" + date_start + "# "
                    End Select
                ElseIf duedate = "hosyou" Then
                    Select Case date_range
                        Case "eq"
                            sql = sql + "AND P_HOSYOU = #" + date_start + "# "
                        Case "gt"
                            sql = sql + "AND P_HOSYOU >= #" + date_start + "# "
                        Case "lt"
                            sql = sql + "AND P_HOSYOU <= #" + date_start + "# "
                    End Select
                End If
                        
            Else
                        
                If Not String.IsNullOrEmpty(date_end) Then
                    If duedate = "tenkai" Then
                        sql = sql + "AND (P_TENKAI BETWEEN #" + date_start + "# AND #" + date_end + "#) "
                    ElseIf duedate = "genko" Then
                        sql = sql + "AND (P_GENKO BETWEEN #" + date_start + "# AND #" + date_end + "#) "
                    ElseIf duedate = "dok" Then
                        sql = sql + "AND (P_DOK BETWEEN #" + date_start + "# AND #" + date_end + "#) "
                    ElseIf duedate = "hosyou" Then
                        sql = sql + "AND (P_HOSYOU BETWEEN #" + date_start + "# AND #" + date_end + "#) "
                    End If
                End If
                        
            End If
        End If
        
        If Not String.IsNullOrEmpty(filter) And Not String.IsNullOrEmpty(filter_value) Then
            If filter = "rnum" Then
                sql = sql + "AND a.R_NUMBER LIKE '%" + filter_value + "%' "
            ElseIf filter = "mname" Then
                sql = sql + "AND a.M_NAME LIKE '%" + filter_value + "%' "
            ElseIf filter = "c_type" Then
                sql = sql + "AND a.C_TYPE LIKE '%" + filter_value + "%' "
            ElseIf filter = "t_name" Then
                sql = sql + "AND b.T_NAME LIKE '%" + filter_value + "%' "
            End If
        End If
        
        If Not Request.QueryString("dcondition") = "all" Then
            Select Case Request.QueryString("dcondition")
                Case "non-f"
                    sql = sql + ""
                    'sql = sql + "AND (b.SOK_END IS NULL OR b.SOK_END IS NOT NULL) OR (b.ENDED IS NULL OR b.ENDED IS NOT NULL) OR (b.G_END IS NULL OR b.G_END IS NOT NULL) "
                    'sql = sql + "AND ((b.SOK_END IS NULL OR b.SOK_END IS NOT NULL) OR (b.ENDED IS NULL OR b.ENDED IS NOT NULL) OR (b.G_END IS NULL OR b.G_END IS NOT NULL)) "
                Case "non-sav"
                    sql = sql + "AND b.SOK_END IS NULL "
                Case "non-sd"
                    sql = sql + "AND b.G_END IS NULL "
                Case "allf"
                    sql = sql + "AND b.ENDED IS NOT NULL "
            End Select
        End If
        
        'sql = sql + "WHERE b.ENDED IS NULL OR b.SOK_END IS NULL OR b.G_END IS NULL "
        If bunrui = "QC" Then
            sql = sql + "ORDER BY a.MAKER, a.R_NUMBER, a.ID ASC"
        Else
            sql = sql + "ORDER BY a.MAKER, a.R_NUMBER, a.ID ASC"
        End If
        
        connection.Open()
        
        Dim fs, tfile
        fs = Server.CreateObject("Scripting.FileSystemObject")
        
        Dim wtf As String = "\\172.25.112.171\System Group\ddctrl_new\csv\falp_duedate.csv"
        ' Dim wtf As String = "C:\Users\Ivan-Desu\Documents\Visual Studio 2010\WebSites\duedate\csv\falp_duedate.csv"
        tfile = fs.CreateTextFile(wtf)
        
        Dim cmd = New OleDbCommand(sql, connection)
        Dim reader = cmd.ExecuteReader
        
        Dim header As New List(Of String)
        header.Add("Request No.")
        header.Add("Customer")
        header.Add("Car Type")
        header.Add("Classification")
        header.Add("Model Name")
        header.Add("Kanban Number")
        If Not bunrui = "QC" Then
            header.Add("Comparison")
            header.Add("Actual")
            header.Add("Preparation")
            header.Add("Actual")
        End If
        
        header.Add("Start Design")
        header.Add("Actual")
        header.Add("Check1")
        header.Add("Actual")
        header.Add("Check2")
        header.Add("Actual")
        header.Add("Check3")
        header.Add("Actual")
        If Not bunrui = "QC" Then
            header.Add("MT")
            header.Add("Actual")
        End If
        header.Add("FALP Due Date")
        header.Add("Actual")
        'header.Add("Wstart")
        'header.Add("Actual")
        If Not bunrui = "QC" Then
            header.Add("Host Registration")
            header.Add("Actual")
            header.Add("Doisy")
            header.Add("Actual")
        End If
        header.Add("Present")
        header.Add("Actual")
        header.Add("Guarantee")
        header.Add("Actual")
        header.Add("Re-Gua Due Date")
        header.Add("Actual")
        If Not bunrui = "QC" Then
            header.Add("Server&OK")
            header.Add("Actual")
        End If
        header.Add("Finished")
        header.Add("Progress")
        header.Add("Designer")
        header.Add("Checker")
        header.Add("Rechecker")
        header.Add("Important Check")
        header.Add("Unclear point")
        If Not bunrui = "QC" Then
            header.Add("New Parts")
            header.Add("Establish Request")
        End If
        header.Add("E-mail")
        header.Add("Others")
        If Not bunrui = "QC" Then
            header.Add("Doisy")
        End If
        header.Add("Remarks")
        
        tfile.WriteLine(Strings.Join(header.ToArray, ","))
        While reader.Read()
            
            Dim sql2 As String = "SELECT COUNT(ID) FROM T_NPARTS WHERE ID = ? AND FLAG = '0' "
            Dim cmd2 As New OleDbCommand(sql2, connection)
            cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
            Dim result2 As String = cmd2.ExecuteScalar()
                        
            Dim sql3 As String = "SELECT COUNT(ID) FROM T_QUERY WHERE ID = ? AND FLAG = '0' "
            Dim cmd3 As New OleDbCommand(sql3, connection)
            cmd3.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
            Dim result3 As String = cmd3.ExecuteScalar()
                        
            Dim sql4 As String = "SELECT COUNT(ID) FROM T_REPORT WHERE ID = ? AND FLAG = '0' "
            Dim cmd4 As New OleDbCommand(sql4, connection)
            cmd4.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
            Dim result4 As String = cmd4.ExecuteScalar()
                        
            Dim sql5 As String = "SELECT COUNT(ID) FROM T_MAIL WHERE ID = ? AND FLAG = '0' "
            Dim cmd5 As New OleDbCommand(sql5, connection)
            cmd5.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
            Dim result5 As String = cmd5.ExecuteScalar()
                        
            Dim sql6 As String = "SELECT COUNT(ID) FROM T_ETC WHERE ID = ? AND FLAG = '0' "
            Dim cmd6 As New OleDbCommand(sql6, connection)
            cmd6.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
            Dim result6 As String = cmd6.ExecuteScalar()
                        
            Dim sql7 As String = "SELECT COUNT(ID) FROM T_DOISY WHERE ID = ? AND FLAG = '0' AND STATUS = 1"
            Dim cmd7 As New OleDbCommand(sql7, connection)
            cmd7.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
            Dim result7 As String = cmd7.ExecuteScalar()
            
            Dim sql8 As String = "SELECT DNUM FROM T_DOISY WHERE T_DOISY.ID = ? "
            Dim cmd8 As New OleDbCommand(sql8, connection)
            cmd8.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
            Dim result8 As Object = cmd8.ExecuteScalar()
            
            Dim showrow As Boolean = False
            Dim totalProblems As Integer = Convert.ToInt32(result2) + Convert.ToInt32(result3) + Convert.ToInt32(result4) + Convert.ToInt32(result5) + Convert.ToInt32(result6) + Convert.ToInt32(result7)
            
            If result8 Is Nothing Then
                result8 = "..."
            Else
                result8 = result8.ToString()
            End If
            
            If Request.QueryString("dcondition") = "non-f" Then
                If IsDBNull(reader.Item("ENDED")) Then
                    showrow = True
                Else
                    If totalProblems > 0 Then
                        showrow = True
                    End If
                End If
            ElseIf Request.QueryString("dcondition") = "allf" Then
                If Not IsDBNull(reader.Item("ENDED")) Then
                    If totalProblems = 0 Then
                        showrow = True
                    End If
                End If
            Else
                showrow = True
            End If
            
            Dim list As New List(Of String)
            list.Add(reader.Item("R_NUMBER").ToString() + "⊿" + reader.Item("revision").ToString())
            list.Add(reader.Item("MAKER").ToString())
            list.Add(reader.Item("C_TYPE").ToString())
            list.Add(reader.Item("T_KUBUN").ToString())
            list.Add(reader.Item("M_NAME").ToString())
            list.Add(reader.Item("Kanban_No").ToString())
            
            If Not bunrui = "QC" Then
                'C_PLAN
                If Not String.IsNullOrEmpty(reader.Item("C_plan").ToString) Then
                    If reader.Item("C_plan") = "1970/01/01" Then
                        list.Add("~")
                    Else
                        list.Add(String.Format("{0:M-dd}", reader.Item("C_plan")))
                    End If
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("C_plan")))
                End If
                'C_ACTUAL
                If Not String.IsNullOrEmpty(reader.Item("C_actual").ToString) Then
                    If reader.Item("C_actual") = "1970/01/01" Then
                        list.Add("~")
                    Else
                        list.Add(String.Format("{0:M-dd}", reader.Item("C_actual")))
                    End If
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("C_actual")))
                End If
                'P_PLAN
                If Not String.IsNullOrEmpty(reader.Item("P_Plan").ToString) Then
                    If reader.Item("P_Plan") = "1970/01/01" Then
                        list.Add("~")
                    Else
                        list.Add(String.Format("{0:M-dd}", reader.Item("P_Plan")))
                    End If
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("P_Plan")))
                End If
                'P_Actual
                If Not String.IsNullOrEmpty(reader.Item("P_Actual").ToString) Then
                    If reader.Item("P_Actual") = "1970/01/01" Then
                        list.Add("~")
                    Else
                        list.Add(String.Format("{0:M-dd}", reader.Item("P_Actual")))
                    End If
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("P_Actual")))
                End If
            End If
            
            'TSTART
            If Not String.IsNullOrEmpty(reader.Item("tstart").ToString) Then
                If reader.Item("tstart") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("tstart")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("tstart")))
            End If
            'PSD
            If Not String.IsNullOrEmpty(reader.Item("psd").ToString) Then
                If reader.Item("psd") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("psd")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("psd")))
            End If
            'CHK1
            If Not String.IsNullOrEmpty(reader.Item("chk1").ToString) Then
                If reader.Item("chk1") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("chk1")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("chk1")))
            End If
            'PCHK1
            If Not String.IsNullOrEmpty(reader.Item("pchk1").ToString) Then
                If reader.Item("pchk1") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("pchk1")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("pchk1")))
            End If
            'CHK2
            If Not String.IsNullOrEmpty(reader.Item("chk2").ToString) Then
                If reader.Item("chk2") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("chk2")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("chk2")))
            End If
            'PCHK2
            If Not String.IsNullOrEmpty(reader.Item("pchk2").ToString) Then
                If reader.Item("pchk2") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("pchk2")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("pchk2")))
            End If
            'CHK3
            If Not String.IsNullOrEmpty(reader.Item("chk3").ToString) Then
                If reader.Item("chk3") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("chk3")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("chk3")))
            End If
            'PCHK3
            If Not String.IsNullOrEmpty(reader.Item("pchk3").ToString) Then
                If reader.Item("pchk3") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("pchk3")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("pchk3")))
            End If
            
            If Not bunrui = "QC" Then
                'MT_PLAN
                If Not String.IsNullOrEmpty(reader.Item("MT_Plan").ToString) Then
                    If reader.Item("MT_Plan") = "1970/01/01" Then
                        list.Add("~")
                    Else
                        list.Add(String.Format("{0:M-dd}", reader.Item("MT_Plan")))
                    End If
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("MT_Plan")))
                End If
                'MT_ACTUAL
                If Not String.IsNullOrEmpty(reader.Item("MT_Actual").ToString) Then
                    If reader.Item("MT_Actual") = "1970/01/01" Then
                        list.Add("~")
                    Else
                        list.Add(String.Format("{0:M-dd}", reader.Item("MT_Actual")))
                    End If
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("MT_Actual")))
                End If
            End If
            
            'P_TENKAI
            If Not String.IsNullOrEmpty(reader.Item("P_TENKAI").ToString) Then
                If reader.Item("P_TENKAI") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("P_TENKAI")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("P_TENKAI")))
            End If
            'PDD
            If Not String.IsNullOrEmpty(reader.Item("pdd").ToString) Then
                If reader.Item("pdd") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("pdd")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("pdd")))
            End If
            'list.Add("...")
            'list.Add("...")
            'DOK_REQ
            If Not bunrui = "QC" Then
                If Not String.IsNullOrEmpty(reader.Item("DOK_REQ").ToString) Then
                    If reader.Item("DOK_REQ") = "1970/01/01" Then
                        list.Add("~")
                    Else
                        list.Add(String.Format("{0:M-dd}", reader.Item("DOK_REQ")))
                    End If
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("DOK_REQ")))
                End If
                'PHR
                If Not String.IsNullOrEmpty(reader.Item("phr").ToString) Then
                    If reader.Item("phr") = "1970/01/01" Then
                        list.Add("~")
                    Else
                        list.Add(String.Format("{0:M-dd}", reader.Item("phr")))
                    End If
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("phr")))
                End If
                'DOISY
                If reader.Item("DOISY") = 1 Then
                    list.Add("YES")
                Else
                    list.Add("NO")
                End If
            
                list.Add(result8)
            End If
            'P_GENKO
            If Not String.IsNullOrEmpty(reader.Item("P_GENKO").ToString) Then
                If reader.Item("P_GENKO") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("P_GENKO")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("P_GENKO")))
            End If
            'G_END
            If Not String.IsNullOrEmpty(reader.Item("G_END").ToString) Then
                If reader.Item("G_END") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("G_END")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("G_END")))
            End If
            'P_HOSYOU
            If Not String.IsNullOrEmpty(reader.Item("P_HOSYOU").ToString) Then
                If reader.Item("P_HOSYOU") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("P_HOSYOU")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("P_HOSYOU")))
            End If
            'PGDD
            If Not String.IsNullOrEmpty(reader.Item("pgdd").ToString) Then
                If reader.Item("pgdd") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("pgdd")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("pgdd")))
            End If
            'PRGDD
            If Not String.IsNullOrEmpty(reader.Item("prgdd").ToString) Then
                If reader.Item("prgdd") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("prgdd")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("prgdd")))
            End If
            'ARGDD
            If Not String.IsNullOrEmpty(reader.Item("argdd").ToString) Then
                If reader.Item("argdd") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("argdd")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("argdd")))
            End If
            
            If Not bunrui = "QC" Then
                'PSMO
                If Not String.IsNullOrEmpty(reader.Item("psmo").ToString) Then
                    If reader.Item("psmo") = "1970/01/01" Then
                        list.Add("~")
                    Else
                        list.Add(String.Format("{0:M-dd}", reader.Item("psmo")))
                    End If
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("psmo")))
                End If
                'SOK_END
                If Not String.IsNullOrEmpty(reader.Item("SOK_END").ToString) Then
                    If reader.Item("SOK_END") = "1970/01/01" Then
                        list.Add("~")
                    Else
                        list.Add(String.Format("{0:M-dd}", reader.Item("SOK_END")))
                    End If
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("SOK_END")))
                End If
            End If
            
            'ENDED
            If Not String.IsNullOrEmpty(reader.Item("ENDED").ToString) Then
                If reader.Item("ENDED") = "1970/01/01" Then
                    list.Add("~")
                Else
                    list.Add(String.Format("{0:M-dd}", reader.Item("ENDED")))
                End If
            Else
                list.Add(String.Format("{0:M-dd}", reader.Item("ENDED")))
            End If
            
            list.Add(reader.Item("SIN_INFO").ToString())
            list.Add(reader.Item("T_NAME").ToString())
            list.Add(reader.Item("S_NAME").ToString())
            list.Add(reader.Item("3_NAME").ToString())
            list.Add("...")
            If Not bunrui = "QC" Then
                If result2 = 0 Then
                    list.Add("")
                Else
                    list.Add(result2)
                End If
            End If
            
            If result3 = 0 Then
                list.Add("")
            Else
                list.Add(result3)
            End If
            
            If Not bunrui = "QC" Then
                If result4 = 0 Then
                    list.Add("")
                Else
                    list.Add(result4)
                End If
            End If
            
            
            If result5 = 0 Then
                list.Add("")
            Else
                list.Add(result5)
            End If
            If result6 = 0 Then
                list.Add("")
            Else
                list.Add(result6)
            End If
            If Not bunrui = "QC" Then
                If result7 = 0 Then
                    list.Add("")
                Else
                    list.Add(result7)
                End If
            End If
            'list.Add(result2)
            'list.Add(result3)
            'list.Add(result4)
            'list.Add(result5)
            'list.Add(result6)
            'list.Add(result7)
            list.Add(reader.Item("REMARK").ToString())
            
            If showrow = True Then
                Try
                    tfile.WriteLine(Strings.Join(list.ToArray, ","))
                Catch ex As Exception
                    tfile.WriteLine(ex.ToString())
                End Try
                
            End If
            
        End While
        
        connection.Close()
        tfile.close()
        tfile = Nothing
        fs = Nothing
        
    %>

    <script>
       var wtf = "http://172.25.112.171:8090/csv/falp_duedate.csv"
        // var wtf = "http://localhost:50/csv/falp_duedate.csv"
        window.open(wtf);
        window.close();
    </script>
</body>
</html>
