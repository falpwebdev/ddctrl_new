<%@ Page Language="VB" AutoEventWireup="false" CodeFile="problemFilter.aspx.vb" Inherits="functions_problemFilter" %>

<%@ Import Namespace="System.Data.OleDb" %>

    <%
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
        Dim connection As OleDbConnection = New OleDbConnection(connectionString)
        
        If Not String.IsNullOrEmpty(Request.Form("sect")) Then
            'Response.Write(Request.Form("t_kubun"))
            Dim sql As String = ""
                
            sql = sql + "SELECT "
            sql = sql + "a.ID,"
            sql = sql + "a.T_KUBUN,"
            sql = sql + "a.REMARK,"
            sql = sql + "a.R_NUMBER,"
            sql = sql + "a.MAKER,"
            sql = sql + "a.BUNRUI,"
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
            sql = sql + "b.pdd,"
            sql = sql + "b.wsdc,"
            sql = sql + "b.pgdd,"
            sql = sql + "b.argdd,"
            sql = sql + "b.phr,"
            sql = sql + "b.G_END,"
            sql = sql + "b.SOK_END,"
            sql = sql + "b.ENDED,"
            sql = sql + "b.tstart,"
            sql = sql + "b.chk1,"
            sql = sql + "b.chk2 "
            
            sql = sql + "FROM T_BASE a "
            sql = sql + "INNER JOIN T_TENKAI b "
            sql = sql + "ON a.ID = b.ID "
            
            'If Request.Form("t_kubun") = "QC" Then
            '    sql = sql + "WHERE a.Kanban_No = 0 "
            'Else
            '    sql = sql + "WHERE a.Kanban_No <> 0 "
            'End If
            
            sql = sql + "WHERE a.Kanban_No IS NOT NULL "
            
            sql = sql + "AND b.SEC='FALP' "
            sql = sql + "AND a.BUNRUI <> 'Correction' "
            
            If Not Request.Form("maker") = "null" Then
                sql = sql + "AND a.MAKER='" + Request.Form("maker") + "' "
            End If
            
            sql = sql + "AND a.BUNRUI = '" + Request.Form("t_kubun") + "' "
            
            If Not Request.Form("duedate") = "null" And Not String.IsNullOrEmpty(Request.Form("date_start")) Then
                If Not Request.Form("date_range") = "range" Then
                        
                    If Request.Form("duedate") = "tenkai" Then
                        sql = sql + "AND P_TENKAI = #" + Request.Form("date_start") + "# "
                    ElseIf Request.Form("duedate") = "genko" Then
                        sql = sql + "AND P_GENKO = #" + Request.Form("date_start") + "# "
                    ElseIf Request.Form("duedate") = "dok" Then
                        sql = sql + "AND P_DOK = #" + Request.Form("date_start") + "# "
                    ElseIf Request.Form("duedate") = "hosyou" Then
                        sql = sql + "AND P_HOSYOU = #" + Request.Form("date_start") + "# "
                    End If
                    
                End If
            End If
            
            If Not String.IsNullOrEmpty("filter_value") Then
                If Not String.IsNullOrEmpty(Request.Form("rnum")) Then
                    sql = sql + "AND a.R_NUMBER LIKE '" + Request.Form("filter_value") + "%' "
                ElseIf Not String.IsNullOrEmpty(Request.Form("mname")) Then
                    sql = sql + "AND a.M_NAME LIKE '" + Request.Form("filter_value") + "%' "
                ElseIf Not String.IsNullOrEmpty(Request.Form("c_type")) Then
                    sql = sql + "AND a.C_TYPE LIKE '" + Request.Form("filter_value") + "%' "
                ElseIf Not String.IsNullOrEmpty(Request.Form("t_name")) Then
                    sql = sql + "AND b.T_NAME LIKE '" + Request.Form("filter_value") + "%' "
                End If
            End If
            
            sql = sql + "ORDER BY a.MAKER, a.R_NUMBER,a.Kanban_No ASC"
            
            Response.Write(sql)
            Try
                connection.Open()
                Dim cmd As New OleDbCommand(sql, connection)
                Dim reader = cmd.ExecuteReader
                Dim c As Integer = 1
                If reader.HasRows Then
                    %>
                    <thead>
                        <tr>
                            <th class='text-center'>#</th>
                            <th class='text-center'>ID</th>
                            <th class='text-center'>Request<br>No.</th>
                            <th class='text-center'>Cust-<br>omer</th>
                            <th class='text-center'>Car Type</th>
                            <th class='text-center'>Classi-<br>fication</th>
                            <th class='text-center'>Kan-<br>ban<br>No</th>
                            <th class='text-center'>Model Name</th>
                            <th class='text-center'>Designer</th>
                            <th class='text-center'>Falp<br>Due Date</th>
                            <th class='text-center'>Send<br>Data Host</th>
                            <th class='text-center'>Guarantee<br>Due<br>Date</th>
                            <th class='text-center'>Entry OK</th>
                            <th class='text-center'>Type</th>
                            <th class='text-center'>Contents</th>
                            <th class='text-center'>Creation<br>Date</th>
                            <th class='text-center'>Due Date</th>
                            <th class='text-center'>Apply<br>/Ans.</th>
                            <th class='text-center'>Check1</th>
                            <th class='text-center'>Check2</th>
                            <th class='text-center'>Guar Request</th>
                            <th class='text-center'>Finished</th>
                            <th class='text-center'>Remarks</th>
                        </tr>
                    
                    </thead>
                    <tbody>
                        <%
                While reader.Read()
                    
                    Dim id As Integer = reader.Item("ID").ToString()
                    Dim td As String = ""
                    td = td + "<tr data-id='" & id & "' >"
                    td = td + "<td class='rr-1'>" & c & "</td>"
                    td = td + "<td class='rr-1'>" + reader.Item("ID").ToString() + "</td>"
                    td = td + "<td class='rr-1' nowrap>" + reader.Item("R_NUMBER").ToString() + "</td>"
                    td = td + "<td class='rr-1'>" + reader.Item("MAKER").ToString() + "</td>"
                    td = td + "<td class='rr-1' nowrap>" + reader.Item("C_TYPE").ToString() + "</td>"
                    td = td + "<td class='rr-1' nowrap>" + reader.Item("T_KUBUN").ToString() + "</td>"
                    td = td + "<td class='rr-1'>" + reader.Item("Kanban_No").ToString() + "</td>"
                    td = td + "<td class='rr-1' nowrap>" + reader.Item("M_NAME").ToString() + "</td>"
                    td = td + "<td class='rr-1'>" + reader.Item("T_NAME").ToString() + "</td>"
                    td = td + "<td class='rr-1' nowrap>" + String.Format("{0:M-dd}", reader.Item("P_TENKAI")) + "</td>"
                    td = td + "<td class='rr-1' nowrap>" + String.Format("{0:M-dd}", reader.Item("P_GENKO")) + "</td>"
                    td = td + "<td class='rr-1' nowrap>" + String.Format("{0:M-dd}", reader.Item("P_HOSYOU")) + "</td>"
                    td = td + "<td class='rr-1' nowrap>" + String.Format("{0:M-dd}", reader.Item("P_DOK")) + "</td>"
                    
                    'Dim sql2 As String = "SELECT Kanban_No,P_NAME,P_TYPE,P_MDATE,P_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_NPARTS WHERE T_NPARTS.ID = ?"
                    
                    Dim sql2 As String = ""
                    
                    If Not String.IsNullOrEmpty(Request.Form("np")) Then
                        sql2 = sql2 + "SELECT P_NAME AS Contents, IIF(ID IS NOT NULL,'N/P','') AS TYPE, IIF(ID IS NOT NULL,'New Parts','') AS TITLE, P_MDATE AS C_DATE, P_PDATE AS D_DATE, apply AS answer, check1 AS chk1, check2 AS chk2, chkreq AS guar, ended AS finished, remark AS remarks FROM T_NPARTS "
                        sql2 = sql2 + "WHERE ID = " & id & " "
                        
                        If Not String.IsNullOrEmpty(Request.Form("pcondition")) Then
                            If Not Request.Form("pcondition") = "all" Then
                                Select Case Request.Form("pcondition")
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
                    End If

                    If Not String.IsNullOrEmpty(Request.Form("up")) Then
                        If Not String.IsNullOrEmpty(Request.Form("np")) Then
                            sql2 = sql2 + "UNION ALL "
                        End If
                        
                        sql2 = sql2 + "SELECT Q_NUMBER AS Contents, IIF(ID IS NOT NULL,'U/P','') AS TYPE, IIF(ID IS NOT NULL,'Unclear Points','') AS TITLE, Q_MDATE AS C_DATE, Q_PDATE AS D_DATE, apply AS answer, check1 AS chk1, check2 AS chk2, chkreq AS guar, ended AS finished, remark AS remarks FROM T_QUERY "
                        sql2 = sql2 + "WHERE ID = " & id & " "
                        
                        If Not String.IsNullOrEmpty(Request.Form("pcondition")) Then
                            If Not Request.Form("pcondition") = "all" Then
                                Select Case Request.Form("pcondition")
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
                    End If
                    
                    If Not String.IsNullOrEmpty(Request.Form("est")) Then
                        If Not String.IsNullOrEmpty(Request.Form("np")) Or Not String.IsNullOrEmpty(Request.Form("up")) Then
                            sql2 = sql2 + "UNION ALL "
                        End If
                        
                        sql2 = sql2 + "SELECT R_NUMBER AS Contents, IIF(ID IS NOT NULL,'E/R','') AS TYPE, IIF(ID IS NOT NULL,'Establish Request','') AS TITLE, R_MDATE AS C_DATE, R_PDATE AS D_DATE, apply AS answer, check1 AS chk1, check2 AS chk2, chkreq AS guar, ended AS finished, remark AS remarks FROM T_REPORT "
                        sql2 = sql2 + "WHERE ID = " & id & " "
                        
                        If Not String.IsNullOrEmpty(Request.Form("pcondition")) Then
                            If Not Request.Form("pcondition") = "all" Then
                                Select Case Request.Form("pcondition")
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
                    End If
                    
                    If Not String.IsNullOrEmpty(Request.Form("mail")) Then
                        If Not String.IsNullOrEmpty(Request.Form("np")) Or Not String.IsNullOrEmpty(Request.Form("up")) Or Not String.IsNullOrEmpty(Request.Form("est")) Then
                            sql2 = sql2 + "UNION ALL "
                        End If
                        
                        sql2 = sql2 + "SELECT N_MAIL AS Contents, IIF(ID IS NOT NULL,'E/M','') AS TYPE, IIF(ID IS NOT NULL,'E-Mail','') AS TITLE, N_MDATE AS C_DATE, N_PDATE AS D_DATE, apply AS answer, check1 AS chk1, check2 AS chk2, chkreq AS guar, ended AS finished, IIF(ID IS NOT NULL,'-','-') AS remarks FROM T_MAIL "
                        sql2 = sql2 + "WHERE ID = " & id & " "
                        
                        If Not String.IsNullOrEmpty(Request.Form("pcondition")) Then
                            If Not Request.Form("pcondition") = "all" Then
                                Select Case Request.Form("pcondition")
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
                    End If
                    
                    If Not String.IsNullOrEmpty(Request.Form("etc")) Then
                        If Not String.IsNullOrEmpty(Request.Form("np")) Or Not String.IsNullOrEmpty(Request.Form("up")) Or Not String.IsNullOrEmpty(Request.Form("est")) Or Not String.IsNullOrEmpty(Request.Form("mail")) Then
                            sql2 = sql2 + "UNION ALL "
                        End If
                        
                        sql2 = sql2 + "SELECT BUNRUI AS Contents, IIF(ID IS NOT NULL,'O','') AS TYPE, IIF(ID IS NOT NULL,'Others','') AS TITLE, E_MDATE AS C_DATE, E_PDATE AS D_DATE, apply AS answer, check1 AS chk1, check2 AS chk2, chkreq AS guar, ended AS finished, IIF(ID IS NOT NULL,'-','-') AS remarks FROM T_ETC "
                        sql2 = sql2 + "WHERE ID = " & id & " "
                        
                        If Not String.IsNullOrEmpty(Request.Form("pcondition")) Then
                            If Not Request.Form("pcondition") = "all" Then
                                Select Case Request.Form("pcondition")
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
                    'cmd2.Parameters.Add("@T_NPARTS.ID", OleDbType.Integer).Value = id
                    'cmd2.Parameters.Add("@T_QUERY.ID", OleDbType.Integer).Value = id
                    'cmd2.Parameters.Add("@T_REPORT.ID", OleDbType.Integer).Value = id
                    'cmd2.Parameters.Add("@T_MAIL.ID", OleDbType.Integer).Value = id
                    'cmd2.Parameters.Add("@T_ETC.ID", OleDbType.Integer).Value = id
                    
                    Dim cc As Integer = 1
                    Dim reader2 = cmd2.ExecuteReader
                    If reader2.HasRows Then
                        While reader2.Read()
                            
                            If cc <> 1 Then
                                td = td + "<tr>"
                                For index As Integer = 1 To 13 'generates 13 empty td
                                    td = td + "<td></td>"
                                Next
                                
                                td = td + "<td class='text-center' nowrap> <acronym title='" + reader2.Item("TITLE").ToString() + "'>" + reader2.Item("TYPE").ToString() + "</acronym> </td>"
                                td = td + "<td class='' nowrap> " + reader2.Item("Contents").ToString() + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("C_DATE")) + "</td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("D_DATE")) + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("answer")) + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("chk1")) + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("chk2")) + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("guar")) + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("finished")) + " </td>"
                                td = td + "<td class='' nowrap> " + String.Format("{0:M-dd}", reader2.Item("remarks")) + " </td>"
                                
                                'td = td + "<td> <acronym title='New Parts'>NP</acronym> </td>" 'type
                                'td = td + "<td>" + reader2.Item("P_NAME").ToString() + "</td>" 'contents
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("P_MDATE")) + "</td>" 'creation date
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("P_PDATE")) + "</td>" 'due date
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("apply")) + "</td>" 'apply
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("check1")) + "</td>" 'check1
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("check2")) + "</td>" 'check2
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("chkreq")) + "</td>" 'guar request
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("ENDED")) + "</td>" 'finished
                                'td = td + "<td>" + reader2.Item("remark").ToString() + "</td>" 'remarks
                    
                                td = td + "</tr>"
                            Else
                                td = td + "<td class='text-center' nowrap> <acronym title='" + reader2.Item("TITLE").ToString() + "'>" + reader2.Item("TYPE").ToString() + "</acronym> </td>"
                                td = td + "<td class='' nowrap> " + reader2.Item("Contents").ToString() + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("C_DATE")) + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("D_DATE")) + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("answer")) + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("chk1")) + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("chk2")) + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("guar")) + " </td>"
                                td = td + "<td class='text-center' nowrap> " + String.Format("{0:M-dd}", reader2.Item("finished")) + " </td>"
                                td = td + "<td class='' nowrap> " + String.Format("{0:M-dd}", reader2.Item("remarks")) + " </td>"
                                'td = td + "<td>" + reader2.Item("P_NAME").ToString() + "</td>" 'contents
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("P_MDATE")) + "</td>" 'creation date
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("P_PDATE")) + "</td>" 'due date
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("apply")) + "</td>" 'apply
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("check1")) + "</td>" 'check1
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("check2")) + "</td>" 'check2
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("chkreq")) + "</td>" 'guar request
                                'td = td + "<td>" + String.Format("{0:M-dd}", reader2.Item("ENDED")) + "</td>" 'finished
                                'td = td + "<td>" + reader2.Item("remark").ToString() + "</td>" 'remarks
                    
                                td = td + "</tr>"
                            End If
                            
                            cc = cc + 1
                        End While
                        reader2.Close()
                        
                        c = c + 1
                        Response.Write(td)
                    End If
                    reader2.Close()
                    
                    
                End While
                            reader.Close()
                        Else
                            Response.Write("<h3>No results found</h3>")
                        End If
                reader.Close()  
                connection.Close()
            Catch ex As Exception
                Response.Write(ex.ToString())
            End Try
        %>
    </tbody>

    <%
    End If
    
    %>