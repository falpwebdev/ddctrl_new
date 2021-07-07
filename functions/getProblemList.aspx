<%@ Page Language="VB" AutoEventWireup="false" CodeFile="getProblemList.aspx.vb" Inherits="functions_getProblemList" %>

<%@ Import Namespace="System.Data.OleDb" %>

<% 

    Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
    Dim connection As OleDbConnection = New OleDbConnection(connectionString)
    Dim id As String = Request.Form("id")
    Dim problem As String = Request.Form("problem")
    Dim pcondition As String = Request.Form("pcondition")
    Dim mname As String = ""
    Dim sql As String = ""
    
    Try
        connection.Open()
        sql = "SELECT a.M_NAME FROM T_BASE a WHERE a.ID = ?"
        Dim cmd As New OleDbCommand(sql, connection)
        cmd.Parameters.Add("@ID", OleDbType.Integer).Value = id
        mname = cmd.ExecuteScalar().ToString()
        connection.Close()
    Catch ex As Exception
        Response.Write(ex.ToString())
    End Try
    
    If Not String.IsNullOrEmpty(Request.Form("id")) Then
        Dim sql2 As String = ""
        
        Select Case problem
            Case "np"
                Dim symb = "<i class='fa fa-check-circle'></i>"
                'Response.Write("New Parts")
                
                sql2 = "SELECT did,ID,Kanban_No,P_NAME,P_TYPE,P_MDATE,P_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_NPARTS WHERE ID = ? ORDER BY Kanban_No ASC"
                
                Select Case pcondition
                    Case "non-a"
                        sql2 = "SELECT did,ID,Kanban_No,P_NAME,P_TYPE,P_MDATE,P_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_NPARTS WHERE ID = ? AND apply IS NULL ORDER BY Kanban_No ASC"
                    Case "non-f"
                        sql2 = "SELECT did,ID,Kanban_No,P_NAME,P_TYPE,P_MDATE,P_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_NPARTS WHERE ID = ? AND ENDED IS NULL ORDER BY Kanban_No ASC"
                    Case "all"
                        sql2 = "SELECT did,ID,Kanban_No,P_NAME,P_TYPE,P_MDATE,P_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_NPARTS WHERE ID = ? ORDER BY Kanban_No ASC"
                End Select
                
                connection.Open()
                Dim cmd2 As New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                Dim reader = cmd2.ExecuteReader
                If reader.HasRows Then
                    %>
                <h6><b>Model Name: <% =mname %></b></h6>
                <table class="table-problem">
                    <thead>
                        <th>ID</th>
                        <th>Kanban No.</th>
                        <th>Parts Name</th>
                        <th>Type</th>
                        <th>Issue</th>
                        <th>Due</th>
                        <th>Answer</th>
                        <th>Check1</th>
                        <th>Check2</th>
                        <th>Guar Request</th>
                        <th>Remarks</th>
                        <th>Finished</th>
                        <th>Last Update</th>
                        <th>Registration Date</th>
                    </thead>
                    <tbody>
                <%
                
                    While reader.Read()
                        Dim td As String = ""
                        td = td + "<tr>"
                        td = td + "<td nowrap>" + reader.Item("did").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("Kanban_No").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("P_NAME").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("P_TYPE").ToString() + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("P_MDATE")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("P_PDATE")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("apply")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("check1")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("check2")) + "</td>"
                        td = td + "<td>" + String.Format("{0:M-dd}", reader.Item("chkreq")) + "</td>"
                        td = td + "<td nowrap>" + reader.Item("remark") + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("ENDED")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd HH:mm:ss}", reader.Item("L_UPDATE")) + "</td>"
                        td = td + "<td nowrap>" + symb + "</td>"
                        td = td + "</tr>"
                        Response.Write(td)
                    End While
                    reader.Close()
                Else
                    Response.Write("<h5>No results found. Please check your <b>problem condition</b></h5>")
                End If
                reader.Close()
                connection.Close()
                %>
                    </tbody>
                </table>
                <%
            Case "up"
                Dim symb = "<i class='fa fa-check-circle'></i>"
                'Response.Write("Unclear Points")
                
                    sql2 = "SELECT did,ID,Kanban_No,Q_VNUMBER,Q_NUMBER,Q_MDATE,Q_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq,ngterm,sfas FROM T_QUERY WHERE ID = ? ORDER BY Kanban_No ASC"
                    Select Case pcondition
                        Case "non-a"
                            sql2 = "SELECT did,ID,Kanban_No,Q_VNUMBER,Q_NUMBER,Q_MDATE,Q_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq,ngterm,sfas FROM T_QUERY WHERE ID = ? AND apply IS NULL ORDER BY Kanban_No ASC"
                        Case "non-f"
                            sql2 = "SELECT did,ID,Kanban_No,Q_VNUMBER,Q_NUMBER,Q_MDATE,Q_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq,ngterm,sfas FROM T_QUERY WHERE ID = ? AND ENDED IS NULL ORDER BY Kanban_No ASC"
                        Case "all"
                            sql2 = "SELECT did,ID,Kanban_No,Q_VNUMBER,Q_NUMBER,Q_MDATE,Q_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq,ngterm,sfas FROM T_QUERY WHERE ID = ? ORDER BY Kanban_No ASC"
                    End Select
                    
                connection.Open()
                Dim cmd2 As New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                Dim reader = cmd2.ExecuteReader
                    If reader.HasRows Then
                        %>
                <h6><b>Model Name: <% =mname %></b></h6>
                <table class="table-problem">
                    <thead>
                        <th>ID</th>
                        <th>Kanban No.</th>
                        <th>Base №</th>
                        <th>Issue №</th>
                        <th>Created by</th>
                        <th>Due date</th>
                        <th>Answer</th>
                        <th>Check1</th>
                        <th>Check2</th>
                        <th>Guar Request</th>
                        <th>Remarks</th>
                        <th>NG Terminal</th>
                        <th>Email sending date to FAS</th>
                        <th>Finished</th>
                        <th>Last Update</th>
                        <th>Registration Date</th>
                    </thead>
                    <tbody>
                <%
                    
                    While reader.Read()
                        Dim td As String = ""
                        td = td + "<tr>"
                        td = td + "<td nowrap>" + reader.Item("did").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("Kanban_No").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("Q_VNUMBER").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("Q_NUMBER").ToString() + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("Q_MDATE")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("Q_PDATE")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("apply")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("check1")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("check2")) + "</td>"
                        td = td + "<td>" + String.Format("{0:M-dd}", reader.Item("chkreq")) + "</td>"
                        td = td + "<td nowrap>" + reader.Item("remark") + "</td>"
                        td = td + "<td nowrap>" + reader.Item("ngterm") + "</td>"
                        td = td + "<td nowrap>" + reader.Item("sfas") + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("ENDED")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd HH:mm:ss}", reader.Item("L_UPDATE")) + "</td>"
                        td = td + "<td nowrap>" + symb + "</td>"
                        td = td + "</tr>"
                        Response.Write(td)
                    End While
                    reader.Close()
                Else
    Response.Write("<h5>No results found. Please check your <b>problem condition</b></h5>")
                End If
                reader.Close()
                connection.Close()
                %>
                    </tbody>
                </table>
                <%
            Case "er"
                Dim symb = "<i class='fa fa-check-circle'></i>"
                    'Response.Write("Establish Request")
                    sql2 = "SELECT did,ID,Kanban_No,R_TYPE,R_NUMBER,R_MDATE,R_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_REPORT WHERE ID = ? ORDER BY Kanban_No ASC"
                    
                    sql2 = "SELECT did,ID,Kanban_No,Q_VNUMBER,Q_NUMBER,Q_MDATE,Q_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq,ngterm,sfas FROM T_QUERY WHERE ID = ? ORDER BY Kanban_No ASC"
                    Select Case pcondition
                        Case "non-a"
                            sql2 = "SELECT did,ID,Kanban_No,R_TYPE,R_NUMBER,R_MDATE,R_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_REPORT WHERE ID = ? AND apply IS NULL ORDER BY Kanban_No ASC"
                        Case "non-f"
                            sql2 = "SELECT did,ID,Kanban_No,R_TYPE,R_NUMBER,R_MDATE,R_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_REPORT WHERE ID = ? AND ENDED IS NULL ORDER BY Kanban_No ASC"
                        Case "all"
                            sql2 = "SELECT did,ID,Kanban_No,R_TYPE,R_NUMBER,R_MDATE,R_PDATE,remark,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_REPORT WHERE ID = ? ORDER BY Kanban_No ASC"
                    End Select
                    
                connection.Open()
                Dim cmd2 As New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                Dim reader = cmd2.ExecuteReader
                    If reader.HasRows Then
                        %>
                <h6><b>Model Name: <% =mname %></b></h6>
                <table class="table-problem">
                    <thead>
                        <th>ID</th>
                        <th>Kanban No.</th>
                        <th>Type</th>
                        <th>Base №</th>
                        <th>Created by</th>
                        <th>Due date</th>
                        <th>Answer</th>
                        <th>Check1</th>
                        <th>Check2</th>
                        <th>Guar Request</th>
                        <th>Remarks</th>
                        <th>Finished</th>
                        <th>Last Update</th>
                        <th>Registration Date</th>
                    </thead>
                    <tbody>
                <%
                    
                    While reader.Read()
                        Dim td As String = ""
                        td = td + "<tr>"
                        td = td + "<td nowrap>" + reader.Item("did").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("Kanban_No").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("R_TYPE").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("R_NUMBER").ToString() + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("R_MDATE")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("R_PDATE")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("apply")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("check1")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("check2")) + "</td>"
                        td = td + "<td>" + String.Format("{0:M-dd}", reader.Item("chkreq")) + "</td>"
                        td = td + "<td nowrap>" + reader.Item("remark") + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("ENDED")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd HH:mm:ss}", reader.Item("L_UPDATE")) + "</td>"
                        td = td + "<td nowrap>" + symb + "</td>"
                        td = td + "</tr>"
                        Response.Write(td)
                    End While
                    reader.Close()
                Else
    Response.Write("<h5>No results found. Please check your <b>problem condition</b></h5>")
                End If
                reader.Close()
                connection.Close()
                %>
                    </tbody>
                </table>
                <%
            Case "mail"
                    Dim symb = "<i class='fa fa-check-circle'></i>"
                    'Response.Write("Mail")
                    sql2 = "SELECT did,ID,Kanban_No,N_MAIL,N_MDATE,N_PDATE,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_MAIL WHERE ID = ? ORDER BY Kanban_No ASC"

                    Select Case pcondition
                        Case "non-a"
                            sql2 = "SELECT did,ID,Kanban_No,N_MAIL,N_MDATE,N_PDATE,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_MAIL WHERE ID = ? AND apply IS NULL ORDER BY Kanban_No ASC"
                        Case "non-f"
                            sql2 = "SELECT did,ID,Kanban_No,N_MAIL,N_MDATE,N_PDATE,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_MAIL WHERE ID = ? AND ENDED IS NULL ORDER BY Kanban_No ASC"
                        Case "all"
                            sql2 = "SELECT did,ID,Kanban_No,N_MAIL,N_MDATE,N_PDATE,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_MAIL WHERE ID = ? ORDER BY Kanban_No ASC"
                    End Select
                    
                connection.Open()
                Dim cmd2 As New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                Dim reader = cmd2.ExecuteReader
                    If reader.HasRows Then
                        %>
                <h6><b>Model Name: <% =mname %></b></h6>
                <table class="table-problem">
                    <thead>
                        <th>ID</th>
                        <th>Kanban No.</th>
                        <th>Contents</th>
                        <th>Sending Date</th>
                        <th>Due date</th>
                        <th>Answer</th>
                        <th>Check1</th>
                        <th>Check2</th>
                        <th>Guar Request</th>
                        <th>Finished</th>
                        <th>Last Update</th>
                        <th>Registration Date</th>
                    </thead>
                    <tbody>
                <%
                    
                    While reader.Read()
                        Dim td As String = ""
                        td = td + "<tr>"
                        td = td + "<td nowrap>" + reader.Item("did").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("Kanban_No").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("N_MAIL").ToString() + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("N_MDATE")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("N_PDATE")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("apply")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("check1")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("check2")) + "</td>"
                        td = td + "<td>" + String.Format("{0:M-dd}", reader.Item("chkreq")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("ENDED")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd HH:mm:ss}", reader.Item("L_UPDATE")) + "</td>"
                        td = td + "<td nowrap>" + symb + "</td>"
                        td = td + "</tr>"
                        Response.Write(td)
                    End While
                    reader.Close()
                Else
                    Response.Write("<h5>No results found. Please check your <b>problem condition</b></h5>")
                End If
                reader.Close()
                connection.Close()
                %>
                    </tbody>
                </table>
                <%
            Case "etc"
                    Dim symb = "<i class='fa fa-check-circle'></i>"
                    'Response.Write("Etc")
                    sql2 = "SELECT did,ID,Kanban_No,BUNRUI,NAIYO,E_MDATE,E_PDATE,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_ETC WHERE ID = ? ORDER BY Kanban_No ASC"

                    Select Case pcondition
                        Case "non-a"
                            sql2 = "SELECT did,ID,Kanban_No,BUNRUI,NAIYO,E_MDATE,E_PDATE,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_ETC WHERE ID = ? AND apply IS NULL ORDER BY Kanban_No ASC"
                        Case "non-f"
                            sql2 = "SELECT did,ID,Kanban_No,BUNRUI,NAIYO,E_MDATE,E_PDATE,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_ETC WHERE ID = ? AND ENDED IS NULL ORDER BY Kanban_No ASC"
                        Case "all"
                            sql2 = "SELECT did,ID,Kanban_No,BUNRUI,NAIYO,E_MDATE,E_PDATE,ENDED,L_UPDATE,FLAG,fdate,apply,check1,check2,chkreq FROM T_ETC WHERE ID = ? ORDER BY Kanban_No ASC"
                    End Select
                    
                connection.Open()
                Dim cmd2 As New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                Dim reader = cmd2.ExecuteReader
    If reader.HasRows Then
    %>
                <h6><b>Model Name: <% =mname %></b></h6>
                <table class="table-problem">
                    <thead>
                        <th>ID</th>
                        <th>Kanban No.</th>
                        <th>Classifications</th>
                        <th>Contents</th>
                        <th>Contact date</th>
                        <th>Due date</th>
                        <th>Answer</th>
                        <th>Check1</th>
                        <th>Check2</th>
                        <th>Guar Request</th>
                        <th>Finished</th>
                        <th>Last Update</th>
                        <th>Registration Date</th>
                    </thead>
                    <tbody>
                <%

                    While reader.Read()
                        Dim td As String = ""
                        td = td + "<tr>"
                        td = td + "<td nowrap>" + reader.Item("did").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("Kanban_No").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("BUNRUI").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("NAIYO").ToString() + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("E_MDATE")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("E_PDATE")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("apply")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("check1")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("check2")) + "</td>"
                        td = td + "<td>"+ String.Format("{0:M-dd}", reader.Item("chkreq")) +"</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("ENDED")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd HH:mm:ss}", reader.Item("L_UPDATE")) + "</td>"
                        td = td + "<td nowrap>" +symb+ "</td>"
                        td = td + "</tr>"
                        Response.Write(td)
    End While
    reader.Close()
Else
Response.Write("<h5>No results found. Please check your <b>problem condition</b></h5>")
End If
reader.Close()
connection.Close()
                %>
                    </tbody>
                </table>
                <%
            Case "doisy"
                Dim symb = "<i class='fa fa-check-circle'></i>"
                    'Response.Write("Doisy")
                sql2 = "SELECT did,ID,STATUS,DNUM,REMARKS,ENDED,L_UPDATE FROM T_DOISY WHERE ID = ?"
                    
                connection.Open()
                Dim cmd2 As New OleDbCommand(sql2, connection)
                cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = id
                Dim reader = cmd2.ExecuteReader
    If reader.HasRows Then
    %>
                <h6><b>Model Name: <% =mname %></b></h6>
                <table class="table-problem">
                    <thead>
                        <th>ID</th>
                        <th>Having or not</th>
                        <th>Dosiy No.</th>
                        <th>Remarks</th>
                        <th>Finished</th>
                        <th>Last Update</th>
                    </thead>
                    <tbody>
                <%
 
                    While reader.Read()
                        Dim hav As String = ""
                        If reader.Item("STATUS").ToString() = "1" Then
                            hav = "YES"
                        Else
                            hav = "NO"
                        End If
                        Dim td As String = ""
                        td = td + "<tr>"
                        td = td + "<td nowrap>" + reader.Item("did").ToString() + "</td>"
                        td = td + "<td nowrap>" + hav + "</td>"
                        td = td + "<td nowrap>" + reader.Item("DNUM").ToString() + "</td>"
                        td = td + "<td nowrap>" + reader.Item("REMARKS").ToString() + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd}", reader.Item("ENDED")) + "</td>"
                        td = td + "<td nowrap>" + String.Format("{0:M-dd HH:mm:ss}", reader.Item("L_UPDATE")) + "</td>"
                        td = td + "</tr>"
                        Response.Write(td)
    End While
    reader.Close()
Else
    Response.Write("<h5>No results found. Please check your <b>problem condition</b></h5>")
End If
reader.Close()
connection.Close()
                %>
                    </tbody>
                </table>
                <%
        End Select
            
    End If
    
    
%>