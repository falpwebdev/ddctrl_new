<%@ Page Language="VB" AutoEventWireup="false" CodeFile="export_csv_problem.aspx.vb" Inherits="export_csv_problem" %>

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
        
        If Not String.IsNullOrEmpty(Request.QueryString("maker")) Then
            Dim maker As String = Request.QueryString("maker")
            Dim t_kubun As String = Request.QueryString("t_kubun") 'BUNRUI
            Dim duedate As String = Request.QueryString("duedate")
            Dim date_start As String = Request.QueryString("date_start")
            Dim filter As String = Request.QueryString("filter")
            Dim filter_value As String = Request.QueryString("filter_value")
            Dim pcondition As String = Request.QueryString("pcondition")
            Dim np As String = Request.QueryString("np")
            Dim up As String = Request.QueryString("up")
            Dim est As String = Request.QueryString("est")
            Dim mail As String = Request.QueryString("mail")
            Dim etc As String = Request.QueryString("etc")
            
            Dim dt As String = DateTime.Now.ToString()
        
            Dim sql As String = ""
            sql = sql + "SELECT "
            sql = sql + "a.ID,"
            sql = sql + "a.T_KUBUN,"
            sql = sql + "a.BUNRUI,"
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
            sql = sql + "b.pchk1,"
            sql = sql + "b.pchk2 "
                
            sql = sql + "FROM T_BASE a "
            sql = sql + "INNER JOIN T_TENKAI b "
            sql = sql + "ON a.ID = b.ID "
            sql = sql + "WHERE "
            sql = sql + "b.SEC='FALP' "
            sql = sql + "AND a.BUNRUI <> 'Correction' "
            
            If maker <> "all" Then
                sql = sql + "AND a.MAKER='" + maker + "' "
            End If
            
            sql = sql + "AND a.BUNRUI = '" + t_kubun + "' "
            
            If Not duedate = "null" And Not String.IsNullOrEmpty(date_start) Then
                     
                If duedate = "tenkai" Then
                    sql = sql + "AND a.P_TENKAI = #" + date_start + "# "
                ElseIf duedate = "genko" Then
                    sql = sql + "AND a.P_GENKO = #" + date_start + "# "
                ElseIf duedate = "dok" Then
                    sql = sql + "AND a.P_DOK = #" + date_start + "# "
                ElseIf duedate = "hosyou" Then
                    sql = sql + "AND a.P_HOSYOU = #" + date_start + "# "
                End If
                    
            End If
            
            If Not String.IsNullOrEmpty(filter_value) Then
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
            
            sql = sql + "ORDER BY a.MAKER, a.R_NUMBER,a.ID ASC"
            Response.Write(sql)
            connection.Open()
        
            Dim fs, tfile
            fs = Server.CreateObject("Scripting.FileSystemObject")
            'Dim wtf As String = "C:\Users\Ivan-Desu\Documents\Visual Studio 2010\WebSites\duedate\csv\falp_duedate_problem.csv"
            Dim wtf As String = "\\172.25.112.171\ddctrl_new\csv\falp_duedate_problem.csv"
            tfile = fs.CreateTextFile(wtf)
        
            Dim cmd = New OleDbCommand(sql, connection)
            Dim reader = cmd.ExecuteReader
        
            Dim header As New List(Of String)
            header.Add("Sect.")
            header.Add("Request No.")
            header.Add("Customer")
            header.Add("Car Type")
            header.Add("Classification")
            header.Add("Model Name")
            header.Add("Designer")
            header.Add("FALP Due Date")
            header.Add("Send Host")
            header.Add("Guar Due Date")
            header.Add("Entry OK")
            header.Add("Type")
            header.Add("Contents")
            header.Add("Creation Date")
            header.Add("Due Date")
            header.Add("Apply")
            header.Add("Check1")
            header.Add("Check2")
            header.Add("Guar Request")
            header.Add("Finished")
            header.Add("Remarks")
        
            tfile.WriteLine(Strings.Join(header.ToArray, ","))
            While reader.Read()
            
                Dim ID As String = reader.Item("ID").ToString()
            
                Dim list As New List(Of String)
                list.Add(reader.Item("SEC").ToString())
                list.Add(reader.Item("R_NUMBER").ToString())
                list.Add(reader.Item("MAKER").ToString())
                list.Add(reader.Item("C_TYPE").ToString())
                list.Add(reader.Item("T_KUBUN").ToString())
                list.Add(reader.Item("M_NAME").ToString())
                list.Add(reader.Item("T_NAME").ToString())
                list.Add(String.Format("{0:M-dd}", reader.Item("P_TENKAI")))
                list.Add(String.Format("{0:M-dd}", reader.Item("P_GENKO")))
                'If reader.Item("P_HOSYOU") = "1/1/1970" Then
                '    list.Add(String.Format("{0:M-dd}", "~"))
                'Else
                list.Add(String.Format("{0:M-dd}", reader.Item("P_HOSYOU")))
                'End If
                list.Add(String.Format("{0:M-dd}", reader.Item("P_DOK")))
            
                Dim sql2 As String = ""
                
                If Not np = "undefined" Then
                    sql2 = sql2 + "SELECT P_NAME AS Contents, IIF(ID IS NOT NULL,'N/P','') AS TYPE, IIF(ID IS NOT NULL,'New Parts','') AS TITLE, P_MDATE AS C_DATE, P_PDATE AS D_DATE, apply AS answer, check1 AS chk1, check2 AS chk2, chkreq AS guar, ended AS finished, remark AS remarks FROM T_NPARTS "
                    sql2 = sql2 + "WHERE ID = " & ID & " "
                    
                    If Not String.IsNullOrEmpty(pcondition) Then
                        If Not pcondition = "all" Then
                            Select Case pcondition
                                Case "non-a"
                                    sql2 = sql2 + "AND T_NPARTS.apply IS NULL "
                                Case "non-g"
                                    sql2 = sql2 + "AND T_NPARTS.chkreq IS NULL "
                                Case "non-f"
                                    sql2 = sql2 + "AND T_NPARTS.ENDED IS NULL "
                                Case "end"
                                    sql2 = sql2 + "AND T_NPARTS.ENDED IS NOT NULL "
                            End Select
                        End If
                    End If
                    
                    If Not up = "undefined" Or Not est = "undefined" Or Not mail = "undefined" Or Not etc = "undefined" Then
                        sql2 = sql2 + "UNION ALL "
                    End If
                End If
                
                If Not up = "undefined" Then
                    sql2 = sql2 + "SELECT Q_NUMBER AS Contents, IIF(ID IS NOT NULL,'U/P','') AS TYPE, IIF(ID IS NOT NULL,'Unclear Points','') AS TITLE, Q_MDATE AS C_DATE, Q_PDATE AS D_DATE, apply AS answer, check1 AS chk1, check2 AS chk2, chkreq AS guar, ended AS finished, remark AS remarks FROM T_QUERY "
                    sql2 = sql2 + "WHERE ID = " & ID & " "
                    
                    If Not String.IsNullOrEmpty(pcondition) Then
                        If Not pcondition = "all" Then
                            Select Case pcondition
                                Case "non-a"
                                    sql2 = sql2 + "AND T_QUERY.apply IS NULL "
                                Case "non-g"
                                    sql2 = sql2 + "AND T_QUERY.chkreq IS NULL "
                                Case "non-f"
                                    sql2 = sql2 + "AND T_QUERY.ENDED IS NULL "
                                Case "end"
                                    sql2 = sql2 + "AND T_QUERY.ENDED IS NOT NULL "
                            End Select
                        End If
                    End If
                    
                    If Not est = "undefined" Or Not mail = "undefined" Or Not etc = "undefined" Then
                        sql2 = sql2 + "UNION ALL "
                    End If
                End If

                
                If Not est = "undefined" Then
                    sql2 = sql2 + "SELECT R_NUMBER AS Contents, IIF(ID IS NOT NULL,'E/R','') AS TYPE, IIF(ID IS NOT NULL,'Establish Request','') AS TITLE, R_MDATE AS C_DATE, R_PDATE AS D_DATE, apply AS answer, check1 AS chk1, check2 AS chk2, chkreq AS guar, ended AS finished, remark AS remarks FROM T_REPORT "
                    sql2 = sql2 + "WHERE ID = " & ID & " "
                    
                    If Not String.IsNullOrEmpty(pcondition) Then
                        If Not pcondition = "all" Then
                            Select Case pcondition
                                Case "non-a"
                                    sql2 = sql2 + "AND T_REPORT.apply IS NULL "
                                Case "non-g"
                                    sql2 = sql2 + "AND T_REPORT.chkreq IS NULL "
                                Case "non-f"
                                    sql2 = sql2 + "AND T_REPORT.ENDED IS NULL "
                                Case "end"
                                    sql2 = sql2 + "AND T_REPORT.ENDED IS NOT NULL "
                            End Select
                        End If
                    End If
                    
                    If Not mail = "undefined" Or Not etc = "undefined" Then
                        sql2 = sql2 + "UNION ALL "
                    End If
                End If
            
                If Not mail = "undefined" Then
                    sql2 = sql2 + "SELECT N_MAIL AS Contents, IIF(ID IS NOT NULL,'E/M','') AS TYPE, IIF(ID IS NOT NULL,'E-Mail','') AS TITLE, N_MDATE AS C_DATE, N_PDATE AS D_DATE, apply AS answer, check1 AS chk1, check2 AS chk2, chkreq AS guar, ended AS finished, IIF(ID IS NOT NULL,'-','-') AS remarks FROM T_MAIL "
                    sql2 = sql2 + "WHERE ID = " & ID & " "
                    
                    If Not String.IsNullOrEmpty(pcondition) Then
                        If Not pcondition = "all" Then
                            Select Case pcondition
                                Case "non-a"
                                    sql2 = sql2 + "AND T_MAIL.apply IS NULL "
                                Case "non-g"
                                    sql2 = sql2 + "AND T_MAIL.chkreq IS NULL "
                                Case "non-f"
                                    sql2 = sql2 + "AND T_MAIL.ENDED IS NULL "
                                Case "end"
                                    sql2 = sql2 + "AND T_MAIL.ENDED IS NOT NULL "
                            End Select
                        End If
                    End If
                    
                    If Not etc = "undefined" Then
                        sql2 = sql2 + "UNION ALL "
                    End If
                End If
                
                If Not etc = "undefined" Then
                    sql2 = sql2 + "SELECT BUNRUI AS Contents, IIF(ID IS NOT NULL,'O','') AS TYPE, IIF(ID IS NOT NULL,'Others','') AS TITLE, E_MDATE AS C_DATE, E_PDATE AS D_DATE, apply AS answer, check1 AS chk1, check2 AS chk2, chkreq AS guar, ended AS finished, IIF(ID IS NOT NULL,'-','-') AS remarks FROM T_ETC "
                    sql2 = sql2 + "WHERE ID = " & ID & " "
                    
                    If Not String.IsNullOrEmpty(pcondition) Then
                        If Not pcondition = "all" Then
                            Select Case pcondition
                                Case "non-a"
                                    sql2 = sql2 + "AND T_ETC.apply IS NULL "
                                Case "non-g"
                                    sql2 = sql2 + "AND T_ETC.chkreq IS NULL "
                                Case "non-f"
                                    sql2 = sql2 + "AND T_ETC.ENDED IS NULL "
                                Case "end"
                                    sql2 = sql2 + "AND T_ETC.ENDED IS NOT NULL "
                            End Select
                        End If
                    End If
                End If
                
                
                    
                Dim cmd2 As New OleDbCommand(sql2, connection)
            
                Dim cc As Integer = 1
                Dim reader2 = cmd2.ExecuteReader
                If reader2.HasRows Then
                    While reader2.Read()
                    
                        Dim contents As String = reader2.Item("Contents").ToString()
                        Dim remarks As String = reader2.Item("remarks").ToString()
                    
                        If cc <> 1 Then
                            list.Add(Environment.NewLine)
                            For index As Integer = 1 To 10 'generates 10 empty cell
                                list.Add(" ")
                            Next
                        
                            list.Add(reader2.Item("TYPE").ToString())
                            list.Add(contents.Replace(",", "; "))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("C_DATE")))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("D_DATE")))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("answer")))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("chk1")))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("chk2")))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("guar")))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("finished")))
                            list.Add(remarks.Replace(",", "; "))
                        
                        Else
                        
                            list.Add(reader2.Item("TYPE").ToString())
                            list.Add(contents.Replace(",", "; "))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("C_DATE")))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("D_DATE")))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("answer")))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("chk1")))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("chk2")))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("guar")))
                            list.Add(String.Format("{0:M-dd}", reader2.Item("finished")))
                            list.Add(remarks.Replace(",", "; "))
                        
                            'tfile.Write(reader2.Item("TYPE").ToString())
                            'tfile.Write(reader2.Item("Contents").ToString())
                            'tfile.Write(String.Format("{0:M-dd}", reader2.Item("C_DATE")))
                            'tfile.Write(String.Format("{0:M-dd}", reader2.Item("D_DATE")))
                            'tfile.Write(String.Format("{0:M-dd}", reader2.Item("answer")))
                            'tfile.Write(String.Format("{0:M-dd}", reader2.Item("chk1")))
                            'tfile.Write(String.Format("{0:M-dd}", reader2.Item("chk2")))
                            'tfile.Write(String.Format("{0:M-dd}", reader2.Item("guar")))
                            'tfile.Write(String.Format("{0:M-dd}", reader2.Item("finished")))
                            'tfile.Write(String.Format("{0:M-dd}", reader2.Item("remarks")))
                        
                        End If
                    
                        cc = cc + 1
                    
                    End While
                    reader2.Close()
                
                
                    tfile.WriteLine(Strings.Join(list.ToArray, ","))
                    'tfile.WriteLine(ControlChars.Quote & String.Join(ControlChars.Quote & "," & ControlChars.Quote, list.ToArray) & ControlChars.Quote)
                
                End If
                reader2.Close()
            
            
            End While
        
            connection.Close()
            tfile.close()
            tfile = Nothing
            fs = Nothing
            
        End If
    %>

    <script>
//        var wtf = "http://localhost:52900/duedate/csv/falp_duedate_problem.csv"
        var wtf = "http://172.25.112.171:8090/csv/falp_duedate_problem.csv"
        window.open(wtf);
        window.close();
    </script>
</body>
</html>
