<%@ Page Language="VB" AutoEventWireup="false" CodeFile="problemFilter.aspx.vb" Inherits="functions_problemFilter" %>

<%@ Import Namespace="System.Data.OleDb" %>

    <%
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
        Dim connection As OleDbConnection = New OleDbConnection(connectionString)
        
        Dim car_maker As String = Request.Form("car_maker")
        Dim date_start As String = Request.Form("start")
        Dim date_end As String = Request.Form("end")
        
        Dim A1 As Object = 0
        Dim A2 As Object = 0
        Dim A3 As Object = 0
        Dim A4 As Object = 0
        Dim A5 As Object = 0
        Dim A6 As Object = 0
        Dim A7 As Object = 0
        
        Dim B1 As Object = 0
        Dim B2 As Object = 0
        Dim B3 As Object = 0
        Dim B4 As Object = 0
        Dim B5 As Object = 0
        Dim B6 As Object = 0
        Dim B7 As Object = 0
        
        Dim C1 As Object = 0
        Dim C2 As Object = 0
        Dim C3 As Object = 0
        Dim C4 As Object = 0
        Dim C5 As Object = 0
        Dim C6 As Object = 0
        Dim C7 As Object = 0
        
        Dim D1 As Object = 0
        Dim D2 As Object = 0
        Dim D3 As Object = 0
        Dim D4 As Object = 0
        Dim D5 As Object = 0
        Dim D6 As Object = 0
        Dim D7 As Object = 0
        
        Dim Z1 As Object = 0
        Dim Z2 As Object = 0
        Dim Z3 As Object = 0
        Dim Z4 As Object = 0
        Dim Z5 As Object = 0
        Dim Z6 As Object = 0
        Dim Z7 As Object = 0
        
        Dim ATotal As Object = 0
        Dim BTotal As Object = 0
        Dim CTotal As Object = 0
        Dim DTotal As Object = 0
        Dim ZTotal As Object = 0
        
        Dim NewTotal As Object = 0
        Dim SimiTotal As Object = 0
        Dim DwgTotal As Object = 0
        Dim MemoTotal As Object = 0
        Dim CompTotal As Object = 0
        Dim QCNewTotal As Object = 0
        Dim QCDCTotal As Object = 0
        
        Dim SuperTotal As Object = 0
        
        Dim result1 As Object = 0
        Dim result2 As Object = 0
        Dim result3 As Object = 0
        Dim result4 As Object = 0
        Dim result5 As Object = 0
        Dim result6 As Object = 0
        Dim result7 As Object = 0
        
        Dim resultTotal As Object = 0
        Dim resultNewTotal As Object = 0
        Dim resultSimiTotal As Object = 0
        Dim resultDwgTotal As Object = 0
        Dim resultMemoTotal As Object = 0
        Dim resultCompTotal As Object = 0
        Dim resultQCNewTotal As Object = 0
        Dim resultQCDCTotal As Object = 0
        Dim resultSuperTotal As Object = 0
        
        If Not String.IsNullOrEmpty(Request.Form("car_maker")) Then
            Try
                
                connection.Open()
                If car_maker = "all" Then
                    
                    'MAZDA
                    Dim sqlA1 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'A' AND T_KUBUN = 'NEW' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdA1 As New OleDbCommand(sqlA1, connection)
                    A1 = cmdA1.ExecuteScalar()
                
                    Dim sqlA2 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'A' AND T_KUBUN = 'SIMILARITY' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdA2 As New OleDbCommand(sqlA2, connection)
                    A2 = cmdA2.ExecuteScalar()
                
                    Dim sqlA3 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'A' AND T_KUBUN = 'DRAWING' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdA3 As New OleDbCommand(sqlA3, connection)
                    A3 = cmdA3.ExecuteScalar()
                
                    Dim sqlA4 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'A' AND T_KUBUN = 'MEMO' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdA4 As New OleDbCommand(sqlA4, connection)
                    A4 = cmdA4.ExecuteScalar()
                
                    Dim sqlA5 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'A' AND T_KUBUN = 'COMPARISON' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdA5 As New OleDbCommand(sqlA5, connection)
                    A5 = cmdA5.ExecuteScalar()
                    
                    Dim sqlA6 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'A' AND (T_KUBUN = 'NEW' OR T_KUBUN = 'SIMILARITY') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdA6 As New OleDbCommand(sqlA6, connection)
                    A6 = cmdA6.ExecuteScalar()
                    
                    Dim sqlA7 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'A' AND (T_KUBUN = 'DRAWING' OR T_KUBUN = 'MEMO') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdA7 As New OleDbCommand(sqlA7, connection)
                    A7 = cmdA7.ExecuteScalar()
                    
                    'TOTAL
                    Dim sqlATotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'A' AND BUNRUI <> 'Correction' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdATotal As New OleDbCommand(sqlATotal, connection)
                    ATotal = cmdATotal.ExecuteScalar()
                    
                    'DAIHATSU
                    Dim sqlB1 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'B' AND T_KUBUN = 'NEW' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdB1 As New OleDbCommand(sqlB1, connection)
                    B1 = cmdB1.ExecuteScalar()
                
                    Dim sqlB2 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'B' AND T_KUBUN = 'SIMILARITY' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND BUNRUI <> 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdB2 As New OleDbCommand(sqlB2, connection)
                    B2 = cmdB2.ExecuteScalar()
                
                    Dim sqlB3 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'B' AND T_KUBUN = 'DRAWING' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdB3 As New OleDbCommand(sqlB3, connection)
                    B3 = cmdB3.ExecuteScalar()
                
                    Dim sqlB4 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'B' AND T_KUBUN = 'MEMO' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdB4 As New OleDbCommand(sqlB4, connection)
                    B4 = cmdB4.ExecuteScalar()
                
                    Dim sqlB5 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'B' AND T_KUBUN = 'COMPARISON' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdB5 As New OleDbCommand(sqlB5, connection)
                    B5 = cmdB5.ExecuteScalar()
                    
                    Dim sqlB6 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'B' AND (T_KUBUN = 'NEW' OR T_KUBUN = 'SIMILARITY') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdB6 As New OleDbCommand(sqlB6, connection)
                    B6 = cmdB6.ExecuteScalar()
                    
                    Dim sqlB7 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'B' AND (T_KUBUN = 'DRAWING' OR T_KUBUN = 'MEMO') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdB7 As New OleDbCommand(sqlB7, connection)
                    B7 = cmdB7.ExecuteScalar()
                    
                    'TOTAL
                    Dim sqlBTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'B' AND BUNRUI <> 'Correction' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdBTotal As New OleDbCommand(sqlBTotal, connection)
                    BTotal = cmdBTotal.ExecuteScalar()
                    
                    'HONDA
                    Dim sqlC1 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'C' AND T_KUBUN = 'NEW' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdC1 As New OleDbCommand(sqlC1, connection)
                    C1 = cmdC1.ExecuteScalar()
                
                    Dim sqlC2 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'C' AND T_KUBUN = 'SIMILARITY' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdC2 As New OleDbCommand(sqlC2, connection)
                    C2 = cmdC2.ExecuteScalar()
                
                    Dim sqlC3 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'C' AND T_KUBUN = 'DRAWING' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdC3 As New OleDbCommand(sqlC3, connection)
                    C3 = cmdC3.ExecuteScalar()
                
                    Dim sqlC4 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'C' AND T_KUBUN = 'MEMO' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdC4 As New OleDbCommand(sqlC4, connection)
                    C4 = cmdC4.ExecuteScalar()
                
                    Dim sqlC5 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'C' AND T_KUBUN = 'COMPARISON' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdC5 As New OleDbCommand(sqlC5, connection)
                    C5 = cmdC5.ExecuteScalar()
                    
                    Dim sqlC6 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'C' AND (T_KUBUN = 'NEW' OR T_KUBUN = 'SIMILARITY') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdC6 As New OleDbCommand(sqlC6, connection)
                    C6 = cmdC6.ExecuteScalar()
                    
                    Dim sqlC7 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'C' AND (T_KUBUN = 'DRAWING' OR T_KUBUN = 'MEMO') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdC7 As New OleDbCommand(sqlC7, connection)
                    C7 = cmdC7.ExecuteScalar()
                    
                    'TOTAL
                    Dim sqlCTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'C' AND BUNRUI <> 'Correction' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdCTotal As New OleDbCommand(sqlCTotal, connection)
                    CTotal = cmdCTotal.ExecuteScalar()
                    
                    'TOYOTA
                    Dim sqlD1 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'D' AND T_KUBUN = 'NEW' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdD1 As New OleDbCommand(sqlD1, connection)
                    D1 = cmdD1.ExecuteScalar()
                
                    Dim sqlD2 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'D' AND T_KUBUN = 'SIMILARITY' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdD2 As New OleDbCommand(sqlD2, connection)
                    D2 = cmdD2.ExecuteScalar()
                
                    Dim sqlD3 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'D' AND T_KUBUN = 'DRAWING' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdD3 As New OleDbCommand(sqlD3, connection)
                    D3 = cmdD3.ExecuteScalar()
                
                    Dim sqlD4 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'D' AND T_KUBUN = 'MEMO' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdD4 As New OleDbCommand(sqlD4, connection)
                    D4 = cmdD4.ExecuteScalar()
                
                    Dim sqlD5 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'D' AND T_KUBUN = 'COMPARISON' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdD5 As New OleDbCommand(sqlD5, connection)
                    D5 = cmdD5.ExecuteScalar()
                    
                    Dim sqlD6 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'D' AND (T_KUBUN = 'NEW' OR T_KUBUN = 'SIMILARITY') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdD6 As New OleDbCommand(sqlD6, connection)
                    D6 = cmdD6.ExecuteScalar()
                    
                    Dim sqlD7 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'D' AND (T_KUBUN = 'DRAWING' OR T_KUBUN = 'MEMO') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdD7 As New OleDbCommand(sqlD7, connection)
                    D7 = cmdD7.ExecuteScalar()
                    
                    'TOTAL
                    Dim sqlDTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'D' AND BUNRUI <> 'Correction' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdDTotal As New OleDbCommand(sqlDTotal, connection)
                    DTotal = cmdDTotal.ExecuteScalar()
                    
                    'NEXAS
                    Dim sqlZ1 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'Z' AND T_KUBUN = 'NEW' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdZ1 As New OleDbCommand(sqlZ1, connection)
                    Z1 = cmdZ1.ExecuteScalar()
                
                    Dim sqlZ2 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'Z' AND T_KUBUN = 'SIMILARITY' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdZ2 As New OleDbCommand(sqlZ2, connection)
                    Z2 = cmdZ2.ExecuteScalar()
                
                    Dim sqlZ3 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'Z' AND T_KUBUN = 'DRAWING' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdZ3 As New OleDbCommand(sqlZ3, connection)
                    Z3 = cmdZ3.ExecuteScalar()
                
                    Dim sqlZ4 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'Z' AND T_KUBUN = 'MEMO' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdZ4 As New OleDbCommand(sqlZ4, connection)
                    Z4 = cmdD4.ExecuteScalar()
                
                    Dim sqlZ5 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'Z' AND T_KUBUN = 'COMPARISON' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdZ5 As New OleDbCommand(sqlZ5, connection)
                    Z5 = cmdZ5.ExecuteScalar()
                    
                    Dim sqlZ6 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'Z' AND (T_KUBUN = 'NEW' OR T_KUBUN = 'SIMILARITY') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdZ6 As New OleDbCommand(sqlZ6, connection)
                    Z6 = cmdZ6.ExecuteScalar()
                    
                    Dim sqlZ7 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'Z' AND (T_KUBUN = 'DRAWING' OR T_KUBUN = 'MEMO') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdZ7 As New OleDbCommand(sqlZ7, connection)
                    Z7 = cmdZ7.ExecuteScalar()
                    
                    'TOTAL
                    Dim sqlZTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = 'Z' AND BUNRUI <> 'Correction' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdZTotal As New OleDbCommand(sqlDTotal, connection)
                    ZTotal = cmdZTotal.ExecuteScalar()
                    
                    'TOTAL T_KUBUN
                    Dim sqlNewTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE T_KUBUN = 'NEW' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdNewTotal As New OleDbCommand(sqlNewTotal, connection)
                    NewTotal = cmdNewTotal.ExecuteScalar()
                    
                    Dim sqlSimiTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE T_KUBUN = 'SIMILARITY' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdSimiTotal As New OleDbCommand(sqlSimiTotal, connection)
                    SimiTotal = cmdSimiTotal.ExecuteScalar()
                    
                    Dim sqlDwgTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE T_KUBUN = 'DRAWING' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdDwgTotal As New OleDbCommand(sqlDwgTotal, connection)
                    DwgTotal = cmdDwgTotal.ExecuteScalar()
                    
                    Dim sqlMemoTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE T_KUBUN = 'MEMO' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdMemoTotal As New OleDbCommand(sqlMemoTotal, connection)
                    MemoTotal = cmdMemoTotal.ExecuteScalar()
                    
                    Dim sqlCompTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE T_KUBUN = 'COMPARISON' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdCompTotal As New OleDbCommand(sqlCompTotal, connection)
                    CompTotal = cmdCompTotal.ExecuteScalar()
                    
                    Dim sqlQCNewTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE (T_KUBUN = 'NEW' OR T_KUBUN = 'SIMILARITY') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdQCNewTotal As New OleDbCommand(sqlQCNewTotal, connection)
                    QCNewTotal = cmdQCNewTotal.ExecuteScalar()
                    
                    Dim sqlQCDCTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE (T_KUBUN = 'DRAWING' OR T_KUBUN = 'MEMO') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdQCDCTotal As New OleDbCommand(sqlQCDCTotal, connection)
                    QCDCTotal = cmdQCDCTotal.ExecuteScalar()
                    
                    Dim sqlSuperTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE BUNRUI <> 'Correction' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdSuperTotal As New OleDbCommand(sqlSuperTotal, connection)
                    SuperTotal = cmdSuperTotal.ExecuteScalar()
                    
                Else
                    Dim sql1 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND T_KUBUN = 'NEW' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI'  AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmd1 As New OleDbCommand(sql1, connection)
                    cmd1.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    result1 = cmd1.ExecuteScalar()
                    
                    Dim sql2 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND T_KUBUN = 'SIMILARITY' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI'  AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmd2 As New OleDbCommand(sql2, connection)
                    cmd2.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    result2 = cmd2.ExecuteScalar()
                    
                    Dim sql3 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND T_KUBUN = 'DRAWING' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI'  AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmd3 As New OleDbCommand(sql3, connection)
                    cmd3.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    result3 = cmd3.ExecuteScalar()
                    
                    Dim sql4 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND T_KUBUN = 'MEMO' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI'  AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmd4 As New OleDbCommand(sql4, connection)
                    cmd4.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    result4 = cmd4.ExecuteScalar()
                    
                    Dim sql5 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND T_KUBUN = 'COMPARISON' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI'  AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmd5 As New OleDbCommand(sql5, connection)
                    cmd5.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    result5 = cmd5.ExecuteScalar()
                    
                    Dim sql6 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND (T_KUBUN = 'NEW' OR T_KUBUN = 'SIMILARITY') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmd6 As New OleDbCommand(sql6, connection)
                    cmd6.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    result6 = cmd6.ExecuteScalar()
                    
                    Dim sql7 As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND (T_KUBUN = 'DRAWING' OR T_KUBUN = 'MEMO') AND BUNRUI <> 'Correction' AND BUNRUI = 'QC' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmd7 As New OleDbCommand(sql7, connection)
                    cmd7.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    result7 = cmd7.ExecuteScalar()
                    
                    'Total
                    Dim sqlResultTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND BUNRUI <> 'Correction' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    Dim cmdResultTotal As New OleDbCommand(sqlResultTotal, connection)
                    cmdResultTotal.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    resultTotal = cmdResultTotal.ExecuteScalar()
                    
                    'Total T_KUBUN
                    'Dim sqlResultNewTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND T_KUBUN = 'NEW' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    'Dim cmdResultNewTotal As New OleDbCommand(sqlResultNewTotal, connection)
                    'cmdResultNewTotal.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    'resultNewTotal = cmdResultNewTotal.ExecuteScalar()
                    
                    'Dim sqlResultSimiTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND T_KUBUN = 'SIMILARITY' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    'Dim cmdResultSimiTotal As New OleDbCommand(sqlResultSimiTotal, connection)
                    'cmdResultSimiTotal.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    'resultSimiTotal = cmdResultSimiTotal.ExecuteScalar()
                    
                    'Dim sqlResultDwgTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND T_KUBUN = 'DRAWING' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    'Dim cmdResultDwgTotal As New OleDbCommand(sqlResultDwgTotal, connection)
                    'cmdResultDwgTotal.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    'resultDwgTotal = cmdResultDwgTotal.ExecuteScalar()
                    
                    'Dim sqlResultMemoTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND T_KUBUN = 'MEMO' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    'Dim cmdResultMemoTotal As New OleDbCommand(sqlResultMemoTotal, connection)
                    'cmdResultMemoTotal.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    'resultMemoTotal = cmdResultMemoTotal.ExecuteScalar()
                    
                    'Dim sqlResultCompTotal As String = "SELECT SUM(mcir) FROM T_BASE INNER JOIN T_TENKAI ON T_BASE.ID = T_TENKAI.ID WHERE MAKER = ? AND T_KUBUN = 'COMPARISON' AND BUNRUI <> 'Correction' AND BUNRUI = 'TENKAI' AND ENDED BETWEEN #" + date_start + "# AND #" + date_end + "# "
                    'Dim cmdResultCompTotal As New OleDbCommand(sqlResultCompTotal, connection)
                    'cmdResultCompTotal.Parameters.Add("@MAKER", OleDbType.VarChar).Value = car_maker
                    'resultCompTotal = cmdResultCompTotal.ExecuteScalar()
                    
                End If
                
                
                connection.Close()
            Catch ex As Exception
                Response.Write(ex.ToString())
            End Try
        Else
            Response.Write("adsd")
        End If
    
    %>

    <tbody>
        <tr>
            <th class="th-fw-1" nowrap style="padding-right: 0px;">Customer</th>
            <th class="th-fw-1">NEW</th>
            <th class="th-fw-1">SIMI</th>
            <th class="th-fw-1">DWG</th>
            <th class="th-fw-1">MEMO</th>
            <th class="th-fw-1">COMP</th>
            <th class="th-fw-1">QC (NEW)</th>
            <th class="th-fw-1" nowrap>QC (DESIGN CHANGE)</th>
            <th class="th-fw-1">Total</th>
        </tr>
        <%
            If car_maker = "all" Then
        %>
            <tr>
                <td>A</td>
                <td><% = A1%></td>
                <td><% = A2%></td>
                <td><% = A3%></td>
                <td><% = A4%></td>
                <td><% = A5%></td>
                <td><% = A6%></td>
                <td><% = A7%></td>
                <td><% = ATotal %></td>
            </tr>
            <tr>
                <td>B</td>
                <td><% = B1%></td>
                <td><% = B2%></td>
                <td><% = B3%></td>
                <td><% = B4%></td>
                <td><% = B5%></td>
                <td><% = B6%></td>
                <td><% = B7%></td>
                <td><% = BTotal%></td>
            </tr>
            <tr>
                <td>C</td>
                <td><% = C1%></td>
                <td><% = C2%></td>
                <td><% = C3%></td>
                <td><% = C4%></td>
                <td><% = C5%></td>
                <td><% = C6%></td>
                <td><% = C7%></td>
                <td><% = CTotal%></td>
            </tr>
            <tr>
                <td>D</td>
                <td><% = D1%></td>
                <td><% = D2%></td>
                <td><% = D3%></td>
                <td><% = D4%></td>
                <td><% = D5%></td>
                <td><% = D6%></td>
                <td><% = D7%></td>
                <td><% = DTotal %></td>
            </tr>
        <%
        ElseIf car_maker = "A" Then
        %>
            <tr>
                <td>A</td>
                <td><% = result1%></td>
                <td><% = result2%></td>
                <td><% = result3%></td>
                <td><% = result4%></td>
                <td><% = result5%></td>
                <td><% = result6%></td>
                <td><% = result7%></td>
                <td><% = resultTotal %></td>
            </tr>
        <%
        ElseIf car_maker = "B" Then
        %>
            <tr>
                <td>B</td>
                <td><% = result1%></td>
                <td><% = result2%></td>
                <td><% = result3%></td>
                <td><% = result4%></td>
                <td><% = result5%></td>
                <td><% = result6%></td>
                <td><% = result7%></td>
                <td><% = resultTotal%></td>
            </tr>
        <%
        ElseIf car_maker = "C" Then
        %>
            <tr>
                <td>C</td>
                <td><% = result1%></td>
                <td><% = result2%></td>
                <td><% = result3%></td>
                <td><% = result4%></td>
                <td><% = result5%></td>
                <td><% = result6%></td>
                <td><% = result7%></td>
                <td><% = resultTotal%></td>
            </tr>
        <% 
        ElseIf car_maker = "D" Then
        %>
            <tr>
                <td>D</td>
                <td><% = result1%></td>
                <td><% = result2%></td>
                <td><% = result3%></td>
                <td><% = result4%></td>
                <td><% = result5%></td>
                <td><% = result6%></td>
                <td><% = result7%></td>
                <td><% = resultTotal%></td>
            </tr>
        <%
        ElseIf car_maker = "Z" Then
        %>
            <tr>
                <td>Z</td>
                <td><% = result1%></td>
                <td><% = result2%></td>
                <td><% = result3%></td>
                <td><% = result4%></td>
                <td><% = result5%></td>
                <td><% = result6%></td>
                <td><% = result7%></td>
                <td><% = resultTotal%></td>
            </tr>
        <%
        End If
        %>

        <%
        If car_maker = "all" Then
        %>
            <tr>
                <td class="text-center">Total</td>
                <td><% =NewTotal %></td> <!--NEW-->
                <td><% =SimiTotal %></td> <!--SIMI-->
                <td><% =DwgTotal %></td> <!--DWG-->
                <td><% =MemoTotal %></td> <!--MEMO-->
                <td><% =CompTotal %></td> <!--COMP-->
                <td><% =QCNewTotal %></td> <!--QC NEW-->
                <td><% =QCDCTotal %></td> <!--QC DC-->
                <td><% =SuperTotal %></td> <!--TOTAL-->
            </tr>
        <%
        End If
        %>
    </tbody>