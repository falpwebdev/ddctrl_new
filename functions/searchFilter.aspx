    <%@ Page Language="VB" AutoEventWireup="false" CodeFile="searchFilter.aspx.vb" Inherits="functions_searchFilter" %>

    <%@ Import Namespace="System.Web.Script.Services" %>
    <%@ Import Namespace="System.Web.Services" %>
    <%@ Import Namespace="System.Data.OleDb" %>
    <%

        Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
        Dim connection As OleDbConnection = New OleDbConnection(connectionString)
    
        If Not String.IsNullOrEmpty(Request.Form("sect")) Then
            'Response.Write("BUNRUI: " + Request.Form("limit"))
        
            'If String.IsNullOrEmpty(Request.Form("asd").ToString()) Then
            '    Response.Write("asd")
            'End If
        
            Dim disp1 As String = ""
            Dim disp2 As String = ""
            Dim disp3 As String = ""
            Dim disp4 As String = ""
            Dim limit As Integer = 0
        
            If Not String.IsNullOrEmpty(Request.Form("limit")) Then
                limit = Request.Form("limit")
            End If
        
            If String.IsNullOrEmpty(Request.Form("display1")) Then
                disp1 = "hide"
            End If
        
            If String.IsNullOrEmpty(Request.Form("display2")) Then
                disp2 = "hide"
            End If
        
            If Request.Form("bunrui") = "QC" Then
                disp3 = "hide"
            End If
        
            If Request.Form("bunrui") = "TENKAI" Then
                disp4 = "hide"
            End If
            
        
            Dim sql As String = ""
                
            sql = sql + "SELECT "
            If Not limit = 0 Then
                sql = sql + "TOP " & limit & " "
            End If
            sql = sql + "a.ID,"
            sql = sql + "a.T_KUBUN,"
            sql = sql + "a.REMARK,"
            sql = sql + "a.cremark,"
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
            sql = sql + "b.pdd,"
            sql = sql + "b.wsdc,"
            sql = sql + "b.pgdd,"
            sql = sql + "b.argdd,"
            sql = sql + "b.phr,"
            sql = sql + "b.G_END,"
            sql = sql + "b.SOK_END,"
            sql = sql + "b.ENDED,"
            sql = sql + "b.tstart,"
            sql = sql + "b.psd,"
            sql = sql + "b.chk1,"
            sql = sql + "b.chk2 "
                
            sql = sql + "FROM T_BASE a "
            sql = sql + "INNER JOIN T_TENKAI b "
            sql = sql + "ON a.ID = b.ID "
        
            If String.IsNullOrEmpty(Request.Form("kanban_no")) Then
                sql = sql + "WHERE (a.Kanban_No "
                
                If Not String.IsNullOrEmpty(Request.Form("dcondition")) Then
                    If Request.Form("dcondition") = "allf" Then
                        sql = sql + "= 0) "
                    ElseIf Request.Form("dcondition") = "all" Or Request.Form("dcondition") = "non-f" Then
                        sql = sql + "IS NOT NULL OR a.Kanban_No = 0) "
                    Else
                        sql = sql + ">= 0) "
                    End If
                End If
            Else
                sql = sql + "WHERE a.Kanban_No = " + Request.Form("kanban_no") + " "
            End If
        
            sql = sql + "AND b.SEC='FALP' "

            sql = sql + "AND a.BUNRUI <> 'Correction' "
            sql = sql + "AND a.BUNRUI = '" + Request.Form("bunrui") + "' "
        
        
            If Not Request.Form("maker") = "null" Then
                sql = sql + "AND a.MAKER='" + Request.Form("maker") + "' "
            End If
                
            If Not Request.Form("duedate") = "null" And Not String.IsNullOrEmpty(Request.Form("date_start")) Then
                If Not Request.Form("date_range") = "range" Then
                        
                    If Request.Form("duedate") = "tenkai" Then
                        Select Case Request.Form("date_range")
                            Case "eq"
                                sql = sql + "AND P_TENKAI = #" + Request.Form("date_start") + "# "
                            Case "gt"
                                sql = sql + "AND P_TENKAI >= #" + Request.Form("date_start") + "# "
                            Case "lt"
                                sql = sql + "AND P_TENKAI <= #" + Request.Form("date_start") + "# "
                        End Select
                    ElseIf Request.Form("duedate") = "genko" Then
                        Select Case Request.Form("date_range")
                            Case "eq"
                                sql = sql + "AND P_GENKO = #" + Request.Form("date_start") + "# "
                            Case "gt"
                                sql = sql + "AND P_GENKO >= #" + Request.Form("date_start") + "# "
                            Case "lt"
                                sql = sql + "AND P_GENKO <= #" + Request.Form("date_start") + "# "
                        End Select
                    ElseIf Request.Form("duedate") = "dok" Then
                        Select Case Request.Form("date_range")
                            Case "eq"
                                sql = sql + "AND P_DOK = #" + Request.Form("date_start") + "# "
                            Case "gt"
                                sql = sql + "AND P_DOK >= #" + Request.Form("date_start") + "# "
                            Case "lt"
                                sql = sql + "AND P_DOK <= #" + Request.Form("date_start") + "# "
                        End Select
                    ElseIf Request.Form("duedate") = "hosyou" Then
                        Select Case Request.Form("date_range")
                            Case "eq"
                                sql = sql + "AND P_HOSYOU = #" + Request.Form("date_start") + "# "
                            Case "gt"
                                sql = sql + "AND P_HOSYOU >= #" + Request.Form("date_start") + "# "
                            Case "lt"
                                sql = sql + "AND P_HOSYOU <= #" + Request.Form("date_start") + "# "
                        End Select
                    End If
                        
                Else
                        
                    If Not String.IsNullOrEmpty(Request.Form("date_end")) Then
                        If Request.Form("duedate") = "tenkai" Then
                            sql = sql + "AND (P_TENKAI BETWEEN #" + Request.Form("date_start") + "# AND #" + Request.Form("date_end") + "#) "
                        ElseIf Request.Form("duedate") = "genko" Then
                            sql = sql + "AND (P_GENKO BETWEEN #" + Request.Form("date_start") + "# AND #" + Request.Form("date_end") + "#) "
                        ElseIf Request.Form("duedate") = "dok" Then
                            sql = sql + "AND (P_DOK BETWEEN #" + Request.Form("date_start") + "# AND #" + Request.Form("date_end") + "#) "
                        ElseIf Request.Form("duedate") = "hosyou" Then
                            sql = sql + "AND (P_HOSYOU BETWEEN #" + Request.Form("date_start") + "# AND #" + Request.Form("date_end") + "#) "
                        End If
                    End If
                        
                End If
            End If
                
            If Not String.IsNullOrEmpty("filter_value") Then
                If Not String.IsNullOrEmpty(Request.Form("rnum")) Then
                    sql = sql + "AND a.R_NUMBER LIKE '%" + Request.Form("filter_value") + "%' "
                ElseIf Not String.IsNullOrEmpty(Request.Form("mname")) Then
                    sql = sql + "AND a.M_NAME LIKE '%" + Request.Form("filter_value") + "%' "
                ElseIf Not String.IsNullOrEmpty(Request.Form("c_type")) Then
                    sql = sql + "AND a.C_TYPE LIKE '%" + Request.Form("filter_value") + "%' "
                ElseIf Not String.IsNullOrEmpty(Request.Form("t_name")) Then
                    sql = sql + "AND b.T_NAME LIKE '%" + Request.Form("filter_value") + "%' "
                End If
            End If
                
            If Not String.IsNullOrEmpty(Request.Form("dcondition")) Then
                If Not Request.Form("dcondition") = "all" Then
                    Select Case Request.Form("dcondition")
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
            End If
                
            'If Not String.IsNullOrEmpty(Request.Form("pcondition")) Then
            '    If Not Request.Form("pcondition") = "all" Then
            '        Select Case Request.Form("pcondition")
            '            Case "non-a"
                                
            '            Case "non-g"
                                
            '            Case "non-f"
                                
            '        End Select
            '    End If
            'End If
        
            If Request.Form("bunrui") = "QC" Then
                sql = sql + "ORDER BY a.MAKER,a.R_NUMBER,a.ID ASC "
            Else
                sql = sql + "ORDER BY a.MAKER,a.R_NUMBER,a.ID ASC "
            End If
            
            'Response.Write(sql)
        
            Try
                connection.Open()
                Dim cmd As New OleDbCommand(sql, connection)
                Dim reader = cmd.ExecuteReader
                Dim c As Integer = 1
                If reader.HasRows Then
                    Dim colspanProgress As Integer = 10
                    Dim colspanRemark As Integer = 9
                    Dim colspanCremark As Integer = 18
                    If Request.Form("bunrui") = "QC" Then
                        colspanProgress = 8
                        colspanRemark = 7
                        colspanCremark = 13
                    End If
    %>
    <thead>
        <tr>
            <th rowspan="2" class='text-center p-2 hide'>
                <input type="checkbox" id="ck_all" />
            </th>
            <th rowspan="2" class='text-center p-2'>
                #
            </th>
            <!--<th rowspan="2">ID</th>-->
            <th rowspan="2" class='text-center'>
                Issue<br>
                No.
            </th>
            <th rowspan="2" class='text-center'>
                Cust-<br>
                omer
            </th>
            <th rowspan="2" class='text-center'>
                Car Type
            </th>
            <th rowspan="2" class='text-center'>
                Classi-<br>
                fication
            </th>
            <th rowspan="2" class=' text-center'>
                Kan-<br>
                ban<br>
                No
            </th>
            <th rowspan="2" class="<% =disp2 %> text-center">
                Event
            </th>
            <th rowspan="2" class="<% =disp2 %> text-center">
                MT
            </th>
            <th rowspan="2" class="<% =disp2 %> text-center">
                WCSD
            </th>
            <th rowspan="2">
                Model Name
            </th>
            <th rowspan="2" class="<% =disp1 %> text-center">
                Start Design
            </th>
            <th rowspan="2" class="<% =disp1 %> text-center">
                Check 1
            </th>
            <th rowspan="2" class="<% =disp1 %> text-center">
                Check 2
            </th>
            <th rowspan="2" class='text-center <% =disp3 %>'>
                Falp<br>
                Due<br>
                Date
            </th>
            <th rowspan="2" class='text-center'>
                W<br>
                Start
            </th>
            <th rowspan="2" class='<% =disp4 %>'>
                Create<br>
                Due<br>
                Date
            </th>
            <th rowspan="2" class='text-center'>
                Send<br>
                Data<br>
                Host
            </th>
            <th rowspan="2" class='text-center'>
                Guarantee<br>
                Due<br>
                Date
            </th>
            <th rowspan="2" class='<% =disp3 %> text-center'>
                Entry<br>
                OK
            </th>
            <th class='<% =disp3 %> text-center'>
                Host<br>
                RQT
            </th>
            <th class='text-center'>
                Doi<br>
                sy
            </th>
            <th class='text-center'>
                SAV
            </th>
            <th class='<% =disp3 %> text-center'>
                SOK
            </th>
            <th class='<% =disp3 %> text-center'>
                S/D
            </th>
            <th class='text-center'>
                End
            </th>
            <th class=''>
                Workers
            </th>
            <th class=''>
                Checkers
            </th>
            <th class=''>
                Rechecker
            </th>
            <th class='text-center'>
                I/C
            </th>
            <th class="<% =disp3 %> th-fw-1 text-center">
                N/P
            </th>
            <th class=' text-center'>
                U/P
            </th>
            <th class='<% =disp3 %> text-center'>
                E/R
            </th>
            <th class='text-center'>
                M
            </th>
            <th class='text-center'>
                E
            </th>
            <th class='text-center'>
                D
            </th>
            <th class='text-center'>
                Need<br>Approval
            </th>
            <th class='text-center'>
                Up
            </th>
        </tr>
        <tr>
            <th colspan="<% =colspanProgress %>">
                Progress
            </th>
            <th colspan="<% =colspanRemark %>">
                Remarks
            </th>
        </tr>
    </thead>
    <tbody>
        <%
            While reader.Read()
                Dim id As String = reader.Item("ID").ToString()
                        
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
                       
                Dim sql22 As String = "SELECT COUNT(ID) FROM T_NPARTS WHERE ID = ? "
                Dim cmd22 As New OleDbCommand(sql22, connection)
                cmd22.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
                Dim result22 As String = cmd22.ExecuteScalar()
                        
                Dim sql33 As String = "SELECT COUNT(ID) FROM T_QUERY WHERE ID = ? "
                Dim cmd33 As New OleDbCommand(sql33, connection)
                cmd33.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
                Dim result33 As String = cmd33.ExecuteScalar()
                        
                Dim sql44 As String = "SELECT COUNT(ID) FROM T_REPORT WHERE ID = ? "
                Dim cmd44 As New OleDbCommand(sql44, connection)
                cmd44.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
                Dim result44 As String = cmd44.ExecuteScalar()
                        
                Dim sql55 As String = "SELECT COUNT(ID) FROM T_MAIL WHERE ID = ? "
                Dim cmd55 As New OleDbCommand(sql55, connection)
                cmd55.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
                Dim result55 As String = cmd55.ExecuteScalar()
                        
                Dim sql66 As String = "SELECT COUNT(ID) FROM T_ETC WHERE ID = ? "
                Dim cmd66 As New OleDbCommand(sql66, connection)
                cmd66.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
                Dim result66 As String = cmd66.ExecuteScalar()
                        
                Dim sql77 As String = "SELECT COUNT(ID) FROM T_DOISY WHERE ID = ? "
                Dim cmd77 As New OleDbCommand(sql77, connection)
                cmd77.Parameters.Add("@ID", OleDbType.Integer).Value = reader.Item("ID").ToString()
                Dim result77 As String = cmd77.ExecuteScalar()
                    
                Dim showrow As Boolean = False
                    
                Dim totalProblems As Integer = Convert.ToInt32(result22) + Convert.ToInt32(result33) + Convert.ToInt32(result44) + Convert.ToInt32(result55) + Convert.ToInt32(result66) + Convert.ToInt32(result77)
                Dim totalProblemsFlag As Integer = Convert.ToInt32(result2) + Convert.ToInt32(result3) + Convert.ToInt32(result4) + Convert.ToInt32(result5) + Convert.ToInt32(result6) + Convert.ToInt32(result7)
                If Not String.IsNullOrEmpty(Request.Form("dcondition")) Then
                    If Request.Form("dcondition") = "non-f" Then
                        If IsDBNull(reader.Item("ENDED")) Then
                            showrow = True
                        Else
                            If totalProblemsFlag > 0 Then
                                showrow = True
                            End If
                        End If
                    ElseIf Request.Form("dcondition") = "allf" Then
                        If Not IsDBNull(reader.Item("ENDED")) Then
                            If totalProblemsFlag = 0 Then
                                showrow = True
                            End If
                        End If
                    Else
                        showrow = True
                    End If
                End If
                    
                Dim ddcolor As String = ""
                Dim color2 As String = ""
                Dim color3 As String = ""
                Dim color4 As String = ""
                Dim color5 As String = ""
                Dim color6 As String = ""
                Dim color7 As String = ""
                        
                Dim fin As String = "_"
                        
                If result2 = 0 Then 'np
                    result2 = ""
                            
                    Dim sqlb As String = "SELECT COUNT(ID) FROM T_NPARTS WHERE ID = ? "
                    Dim cmdb As New OleDbCommand(sqlb, connection)
                    cmdb.Parameters.Add("@ID", OleDbType.Integer).Value = id
                    Dim resultb As Integer = cmdb.ExecuteScalar()
                            
                    If resultb > 0 Then
                        result2 = fin
                        color2 = "fin"
                    End If

                Else
                    color2 = "np"
                End If
                        
                If result3 = 0 Then 'up
                    result3 = ""
                            
                    Dim sqlc As String = "SELECT COUNT(ID) FROM T_QUERY WHERE ID = ? "
                    Dim cmdc As New OleDbCommand(sqlc, connection)
                    cmdc.Parameters.Add("@ID", OleDbType.Integer).Value = id
                    Dim resultc As Integer = cmdc.ExecuteScalar()
                            
                    If resultc > 0 Then
                        result3 = fin
                        color3 = "fin"
                    End If
                Else
                    color3 = "up"
                End If
                        
                If result4 = 0 Then 'er
                    result4 = ""
                            
                    Dim sqld As String = "SELECT COUNT(ID) FROM T_REPORT WHERE ID = ? "
                    Dim cmdd As New OleDbCommand(sqld, connection)
                    cmdd.Parameters.Add("@ID", OleDbType.Integer).Value = id
                    Dim resultd As Integer = cmdd.ExecuteScalar()
                            
                    If resultd > 0 Then
                        result4 = fin
                        color4 = "fin"
                    End If
                Else
                    color4 = "er"
                End If
                        
                If result5 = 0 Then 'mail
                    result5 = ""
                            
                    Dim sqle As String = "SELECT COUNT(ID) FROM T_MAIL WHERE ID = ? "
                    Dim cmde As New OleDbCommand(sqle, connection)
                    cmde.Parameters.Add("@ID", OleDbType.Integer).Value = id
                    Dim resulte As Integer = cmde.ExecuteScalar()
                            
                    If resulte > 0 Then
                        result5 = fin
                        color5 = "fin"
                    End If
                Else
                    color5 = "mail"
                End If
                        
                If result6 = 0 Then 'etc
                    result6 = ""
                            
                    Dim sqlf As String = "SELECT COUNT(ID) FROM T_ETC WHERE ID = ? "
                    Dim cmdf As New OleDbCommand(sqlf, connection)
                    cmdf.Parameters.Add("@ID", OleDbType.Integer).Value = id
                    Dim resultf As Integer = cmdf.ExecuteScalar()
                            
                    If resultf > 0 Then
                        result6 = fin
                        color6 = "fin"
                    End If
                Else
                    color6 = "etc"
                End If
                        
                If result7 = 0 Then 'doisy
                    result7 = ""
                            
                    Dim sqlg As String = "SELECT COUNT(ID) FROM T_DOISY WHERE ID = ? "
                    Dim cmdg As New OleDbCommand(sqlg, connection)
                    cmdg.Parameters.Add("@ID", OleDbType.Integer).Value = id
                    Dim resultg As Integer = cmdg.ExecuteScalar()
                            
                    If resultg > 0 Then
                        result7 = fin
                        color7 = "fin"
                    End If
                Else
                    color7 = "doisy"
                End If
                        
                If Not IsDBNull(reader.Item("P_GENKO")) Then
                            
                    Dim dd As DateTime = Convert.ToDateTime(reader.Item("P_GENKO"))
                    Dim dn As DateTime = Convert.ToDateTime(DateValue(Now))
                    Dim ts As TimeSpan = dn.Subtract(dd)
                            
                    'dd-1 dd=now (yellow)
                    'dd-2 dd=delay (pink)
                    'dd-3 dd is tomorrow (green)
                            
                    If Not dd = Convert.ToDateTime("1970/01/01") Then
                        If Convert.ToInt32(ts.Days) = -1 Then
                            ddcolor = "dd-3"
                        ElseIf Convert.ToInt32(ts.Days) = 0 Then
                            ddcolor = "dd-1"
                        ElseIf Convert.ToInt32(ts.Days) > 0 Then
                            ddcolor = "dd-2"
                        End If
                    End If
                            
                End If
                        
                Dim hostrqt As String = ""
                Dim doisy As String = ""
                Dim sav As String = ""
                Dim sok As String = ""
                Dim sd As String = ""
                Dim endtd As String = ""
                        
                Dim symb As String = "<i class='fa fa-check-circle'></i>"
                Dim symb2 As String = "<i class='fa fa-times'></i>"
                        
                If Not IsDBNull(reader.Item("phr")) Then 'host no. reg
                    If Convert.ToDateTime(reader.Item("phr")) = Convert.ToDateTime("1999/01/01") Or Convert.ToDateTime(reader.Item("phr")) = Convert.ToDateTime("1970/01/01") Then
                        hostrqt = symb2
                    Else
                        hostrqt = symb
                    End If
                End If
                        
                If reader.Item("DOISY") = "0" Then 'doisy
                    doisy = symb2
                Else
                    doisy = symb
                End If
                        
                'If Not IsDBNull(reader.Item("P_DOK")) Then 'SOK
                '    sok = symb
                'End If
                        
                If Not IsDBNull(reader.Item("G_END")) Then 'present process
                    If Convert.ToDateTime(reader.Item("G_END")) = Convert.ToDateTime("1999/01/01") Or Convert.ToDateTime(reader.Item("G_END")) = Convert.ToDateTime("1970/01/01") Then
                        sd = symb2
                    Else
                        sd = symb
                    End If
                            
                End If
                        
                'If Not IsDBNull(reader.Item("pdd")) And Not IsDBNull(reader.Item("wsdc")) And Not IsDBNull(reader.Item("pgdd")) _
                '   And Not IsDBNull(reader.Item("argdd")) And Not IsDBNull(reader.Item("phr")) And Not IsDBNull(reader.Item("g_end")) _
                '   And Not IsDBNull(reader.Item("sok_end")) And Not IsDBNull(reader.Item("ended")) Then
                '    sok = symb
                'End If
                        
                If Not IsDBNull(reader.Item("SOK_END")) Then 'send model
                    If Convert.ToDateTime(reader.Item("SOK_END")) = Convert.ToDateTime("1999/01/01") Or Convert.ToDateTime(reader.Item("SOK_END")) = Convert.ToDateTime("1970/01/01") Then
                        sav = symb2
                        sok = symb2
                    Else
                        sav = symb
                        sok = symb
                    End If
                End If
                        
                If Not IsDBNull(reader.Item("ENDED")) Then 'finished
                    If Convert.ToDateTime(reader.Item("ENDED")) = Convert.ToDateTime("1999/01/01") Or Convert.ToDateTime(reader.Item("ENDED")) = Convert.ToDateTime("1970/01/01") Then
                        endtd = symb2
                    Else
                        endtd = symb
                    End If
                End If
                        
                Dim progress As String = reader.Item("SIN_INFO").ToString()
                If IsDBNull(reader.Item("SIN_INFO")) Then
                    progress = "&nbsp;&nbsp;&nbsp;&nbsp;"
                End If
                        
                Dim tenkai_date As String = ""
                Dim genko_date As String = ""
                Dim hosyou_date As String = ""
                Dim dok_date As String = ""
                Dim xmark As String = "<i class='fa fa-times x-mark'></i>"
                        
                If Not IsDBNull(reader.Item("P_TENKAI")) Then
                    Dim tenkai_cast As DateTime = Convert.ToDateTime(reader.Item("P_TENKAI"))
                    If tenkai_cast = Convert.ToDateTime("1970/01/01") Then
                        tenkai_date = xmark
                    Else
                        tenkai_date = String.Format("{0:M-dd}", reader.Item("P_TENKAI"))
                    End If
                End If
                        
                If Not IsDBNull(reader.Item("P_GENKO")) Then
                    Dim genko_cast As DateTime = Convert.ToDateTime(reader.Item("P_GENKO"))
                    If genko_cast = Convert.ToDateTime("1970/01/01") Then
                        genko_date = xmark
                    Else
                        genko_date = String.Format("{0:M-dd}", reader.Item("P_GENKO"))
                    End If
                End If
                        
                If Not IsDBNull(reader.Item("P_HOSYOU")) Then
                    Dim hosyou_cast As DateTime = Convert.ToDateTime(reader.Item("P_HOSYOU"))
                    If hosyou_cast = Convert.ToDateTime("1970/01/01") Then
                        hosyou_date = xmark
                    Else
                        hosyou_date = String.Format("{0:M-dd}", reader.Item("P_HOSYOU"))
                    End If
                End If
                        
                If Not IsDBNull(reader.Item("P_DOK")) Then
                    Dim dok_cast As DateTime = Convert.ToDateTime(reader.Item("P_DOK"))
                    If dok_cast = Convert.ToDateTime("1970/01/01") Then
                        dok_date = xmark
                    Else
                        dok_date = String.Format("{0:M-dd}", reader.Item("P_DOK"))
                    End If
                End If
                        
                        
                Dim rcolor As String = ""
                Dim rsymb As String = ""
                Dim ts2 As TimeSpan
                If Not IsDBNull(reader.Item("L_UPDATE")) Then
                    Dim dd2 As DateTime = Convert.ToDateTime(reader.Item("L_UPDATE"))
                    Dim dn2 As DateTime = Convert.ToDateTime(DateTime.Now)
                    ts2 = dn2.Subtract(dd2)
                    If ts2.Days < 1 Then
                        If Convert.ToInt32(ts2.Hours) < 12 Then
                            rcolor = "rr-1"
                            rsymb = "⊿"
                        End If
                    End If
                End If
                        
                Dim rev As String = ""
                        
                If Not IsDBNull(reader.Item("revision")) Then
                    If reader.Item("revision") <> 0 Then
                        rev = "⊿" & reader.Item("revision")
                    End If
                End If
                        
                Dim rs As String = 2
                        
                If Not IsDBNull(reader.Item("cremark")) Then
                    rs = 3
                End If
                    
                    
                'Revision 1.0 - Ryo
                Dim mtvar As String
                If reader.Item("mt") = "0" Then
                    mtvar = "NO"
                ElseIf reader.Item("mt") = "1" Then
                    mtvar = "YES"
                ElseIf reader.Item("mt") = "YES" Then
                    mtvar = "YES"
                ElseIf reader.Item("mt") = "NO" Then
                    mtvar = "NO"
                Else
                        
                End If
                    
                Dim td As String = ""
                td = td + "<tr data-id='" + id + "' class='" + rcolor + "' timespan='" + ts2.Hours.ToString + "' data-model='" + reader.Item("M_NAME").ToString() + "' data-present='" + String.Format("{0:yyyy/MM/dd}", reader.Item("P_GENKO")) + "' data-designer='" + reader.Item("T_NAME") + "' data-carkind='" + reader.Item("C_TYPE").ToString() + "' data-maker='" + reader.Item("MAKER").ToString() + "' data-event='" + reader.Item("event").ToString() + "' data-rnum='" + reader.Item("R_NUMBER").ToString() + "'>"
                td = td + "<td nowrap rowspan='" + rs + "' class='text-center hide'><input type='checkbox' name='ck_item[]' ></td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='text-center'>" & c & "</td>"
                'td = td + "<td nowrap rowspan='2'>" + reader.Item("ID").ToString() + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='text-center'>" + reader.Item("R_NUMBER").ToString() + "" + rev + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='text-center'>" + reader.Item("MAKER").ToString() + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='text-center'>" + reader.Item("C_TYPE").ToString() + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='text-center'>" + reader.Item("T_KUBUN").ToString() + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='text-center'>" + reader.Item("Kanban_No").ToString() + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='" + disp2 + " text-center'>" + String.Format("{0:M-dd}", reader.Item("event")) + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='" + disp2 + " text-center'>" + String.Format("{0:M-dd}", mtvar) + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='" + disp2 + " text-center'>" + String.Format("{0:M-dd}", reader.Item("wcsd")) + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='text-center'><a title='ID: " + reader.Item("ID").ToString() + "' href='javascript:void(0)' class='link'>" + reader.Item("M_NAME").ToString() + "</a></td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='" + disp1 + " text-center'>" + String.Format("{0:M-dd}", reader.Item("tstart")) + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='" + disp1 + " text-center'>" + String.Format("{0:M-dd}", reader.Item("chk1")) + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='" + disp1 + " text-center'>" + String.Format("{0:M-dd}", reader.Item("chk2")) + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='" + disp3 + " text-center'>" + tenkai_date + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='text-center'></td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='" + disp4 + " text-center'>" + tenkai_date + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='" + ddcolor + " text-center'>" + genko_date + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='text-center'>" + hosyou_date + "</td>"
                td = td + "<td nowrap rowspan='" + rs + "' class='" + disp3 + " text-center'>" + dok_date + "</td>"
                td = td + "<td class='" + disp3 + " text-center bd-2' title='" + String.Format("{0:M-dd}", reader.Item("phr")) + "'>" + hostrqt + "</td>" 'host
                td = td + "<td class='text-center bd-2' title='" + reader.Item("DOISY").ToString + "'>" + doisy + "</td>" 'doisy
                td = td + "<td class='text-center bd-2' title='" + String.Format("{0:M-dd}", reader.Item("SOK_END")) + "'>" + sav + "</td>" 'sav
                td = td + "<td class='" + disp3 + " text-center bd-2' title='" + String.Format("{0:M-dd}", reader.Item("SOK_END")) + "'>" + sok + "</td>" 'sok
                td = td + "<td class='" + disp3 + " text-center bd-2' title='" + String.Format("{0:M-dd}", reader.Item("psd")) + "'>" + sd + "</td>" 's/d
                td = td + "<td class='bd-2' title='" + String.Format("{0:M-dd}", reader.Item("G_END")) + "'>" + endtd + "</td>" 'end
                td = td + "<td nowrap class='bd-2'>" + reader.Item("T_NAME") + "</td>" 'workers
                td = td + "<td nowrap class='bd-2'>" + reader.Item("S_NAME") + "</td>" 'checkers
                td = td + "<td nowrap class='bd-2'>" + reader.Item("3_NAME") + "</td>" 'rechecker
                td = td + "<td class='bd-2 text-center'></td>" 'i/c
                td = td + "<td class='td-pr " + disp3 + " " + color2 + " text-center bd-2' data-problem='np'>" + result2 + "</td>" 'n/p
                td = td + "<td class='td-pr " + color3 + " text-center bd-2' data-problem='up'>" + result3 + "</td>" 'u/p
                td = td + "<td class='td-pr " + disp3 + " " + color4 + " text-center bd-2' data-problem='er'>" + result4 + "</td>" 'e/r
                td = td + "<td class='td-pr " + color5 + " text-center bd-2' data-problem='mail'>" + result5 + "</td>" 'm
                td = td + "<td class='td-pr " + color6 + " text-center bd-2' data-problem='etc'>" + result6 + "</td>" 'e
                td = td + "<td class='td-pr " + color7 + " text-center bd-2' data-problem='doisy'>" + result7 + "</td>" 'd
                td = td + "<td class='td-pr text-center bd-2' data-problem='doisy'></td>" 'na
                td = td + "<td class='bd-2 text-center'><acronym title='" + reader.Item("L_UPDATE") + "'>" + rsymb + "</acronym></td>" 'up
                td = td + "</tr>"
                td = td + "<tr class='" + rcolor + "'>"
                td = td + "<td nowrap colspan='" + colspanProgress.ToString() + "' class='bd-1'>" + progress + "</td>"
                td = td + "<td nowrap colspan='" + colspanRemark.ToString() + "' class='bd-1'>" + reader.Item("REMARK").ToString() + "</td>"
                td = td + "</tr>"
                        
                If Not IsDBNull(reader.Item("cremark")) Then
                    td = td + "<tr>"
                    td = td + "<td nowrap colspan='" + colspanCremark.ToString() + "' class='bd-1 cremark'>" + reader.Item("cremark").ToString() + "</td>"
                    td = td + "</tr>"
                End If
                    
                    
                If showrow = True Then
                    c = c + 1
                    Response.Write(td)
                End If
                    
                    
                        
            End While
            reader.Close()
        Else
            Response.Write("<b>Query: </b><br>")
            Response.Write("<code>" + sql + "</code>")
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