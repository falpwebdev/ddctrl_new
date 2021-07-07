<%@ Page Language="VB" AutoEventWireup="false" CodeFile="problemFilter.aspx.vb" Inherits="functions_problemFilter" %>

<%@ Import Namespace="System.Data.OleDb" %>
    
    <%
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
        Dim connection As OleDbConnection = New OleDbConnection(connectionString)
        
        Dim car_maker As String = Request.Form("car_maker")
        Dim date_start As String = Request.Form("start")
        Dim date_end As String = Request.Form("end")
        
        
        If Not String.IsNullOrEmpty(Request.Form("car_maker")) Then  
                
            Dim sql As String = ""
            sql = sql + "SELECT "
            sql = sql + "a.ID,"
            sql = sql + "a.T_KUBUN,"
            sql = sql + "a.BUNRUI,"
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
            sql = sql + "WHERE a.BUNRUI <> 'Correction' "
                
            If Not car_maker = "all" Then
                sql = sql + "AND a.MAKER = '" + car_maker + "' "
            End If
                
            sql = sql + "AND (a.P_GENKO BETWEEN #" + date_start + "# AND #" + date_end + "# "
            sql = sql + "OR a.P_TENKAI BETWEEN #" + date_start + "# AND #" + date_end + "#) "
            sql = sql + "AND a.mcir IS NULL "
            sql = sql + "ORDER BY a.MAKER,a.R_NUMBER,a.ID ASC "
            'Response.Write(sql)
            Try
                connection.Open()
                Dim cmd As New OleDbCommand(sql, connection)
                Dim reader = cmd.ExecuteReader
                Dim c As Integer = 1
                
                If reader.HasRows Then
                %>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>ID</th>
                            <th>Request No.</th>
                            <th>Customer</th>
                            <th>Car Type</th>
                            <th>Model Name</th>
                            <th>Type</th>
                            <th>Classifi-<br>cation</th>
                            <th>Tenkai<br>Due Date</th>
                            <th>Due Date</th>
                            <th>Multi circuit</th>
                        </tr>
                    </thead>
                    <tbody>
                <%
                    While reader.Read()
                        Dim id As String = reader.Item("ID").ToString()
                        Dim rnum As String = reader.Item("R_NUMBER").ToString()
                        Dim maker As String = reader.Item("MAKER").ToString()
                        Dim c_type As String = reader.Item("C_TYPE").ToString()
                        Dim mname As String = reader.Item("M_NAME").ToString()
                        Dim type As String = reader.Item("BUNRUI").ToString()
                        Dim t_kubun As String = reader.Item("T_KUBUN").ToString()
                        Dim p_tenkai As String = String.Format("{0:yyyy/MM/dd}", reader.Item("P_TENKAI"))
                        Dim p_genko As String = String.Format("{0:yyyy/MM/dd}", reader.Item("P_GENKO"))
                        
                        If p_genko = "1970/01/01" Then
                            p_genko = "<i>Nothing</i>"
                        End If
                        
                        Dim td As String = "<tr>"
                        td = td + "<td>" & c & "</td>"
                        td = td + "<td>" + id + "</td>"
                        td = td + "<td>" + rnum + "</td>"
                        td = td + "<td>" + maker + "</td>"
                        td = td + "<td>" + c_type + "</td>"
                        td = td + "<td nowrap>" + mname + "</td>"
                        td = td + "<td>" + type + "</td>"
                        td = td + "<td>" + t_kubun + "</td>"
                        td = td + "<td>" + p_tenkai + "</td>"
                        td = td + "<td class='text-center'>" + p_genko +"</td>"
                        td = td + "<td></td>"
                        
                        td = td + "</tr>"
                        
                        c = c + 1
                        
                        Response.Write(td)
                    End While
                    reader.Close()
                %>
                    </tbody>
                <%
                Else
                    Response.Write("<h3>No results found</h3>")
                End If
                connection.Close()
            Catch ex As Exception
                Response.Write(ex.ToString())
            End Try
        Else
            Response.Write("adsd")
        End If
    
    %>

    