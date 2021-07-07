<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Import Namespace="System.Data.OleDb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <style>
            .checkbox
            {
                margin-top: 5px;
                text-align: center;
            }
    </style>
</head>
<body>
    <%
        If Not String.IsNullOrEmpty(Request.Form("submit")) Then
            Dim rnum As String = Request.Form("rnum")
            Dim revision As String = Request.Form("revision")
            Dim sect As String = Request.Form("sect") 't_tenkai
            Dim maker As String = Request.Form("maker")
            Dim c_type As String = Request.Form("c_type")
            Dim bunrui As String = Request.Form("bunrui")
            Dim t_kubun As String = Request.Form("t_kubun")
            Dim evnt As String = Request.Form("event")
            Dim mt As String = Request.Form("mt")
            Dim p_tenkai As String = Request.Form("p_tenkai")
            Dim p_hosyou As String = Request.Form("p_hosyou")
            Dim p_genko As String = Request.Form("p_genko")
            Dim p_dok As String = Request.Form("p_dok")
            Dim doisy As String = "0"
            doisy = Request.Form("doisy") 't_tenkai
            Dim dnum As String = Request.Form("dnum") 'DOISY VALUE
            Dim remarks As String = Request.Form("remarks")
            Dim kanban_no() As String = Request.Form.GetValues("kanban_no")
            Dim qc As String = Request.Form("qc")
            Dim mname() As String = Request.Form.GetValues("m_name")
            Dim mcir() As String = Request.Form.GetValues("mcir")

            'GET THE LAST ID FROM DB
            Dim connectionString As String = ConfigurationManager.ConnectionStrings("OLEDbConnection").ToString
            Dim connection As OleDbConnection = New OleDbConnection(connectionString)
            
            Try
                
                Dim temp As Integer = mname.Length-1
                For i As Integer = 0 To temp
                    connection.Open()
                    Dim sql As String = "SELECT TOP 1 ID FROM T_BASE ORDER BY ID DESC"
                    Dim cmd As New OleDbCommand(sql, connection)
                    Dim lastId = Convert.ToInt32(cmd.ExecuteScalar) + 1

                    'Dim sql2 As String = "INSERT INTO T_BASE (ID,MAKER,C_TYPE,R_NUMBER,revision,T_KUBUN,event,mt,M_NAME,P_TENKAI, P_GENKO, REMARK, KANBAN_NO, mcir, QC) VALUES (@)"
                    Dim sql2 As String = "INSERT INTO T_BASE (ID,MAKER,C_TYPE,BUNRUI,R_NUMBER,revision,T_KUBUN,event,mt,M_NAME,P_TENKAI,P_GENKO,P_DOK,P_HOSYOU, REMARK, KANBAN_NO, mcir, QC) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
                    Dim cmd2 As New OleDbCommand(sql2, connection)
                    
                    cmd2.Parameters.Add("@ID", OleDbType.Integer).Value = lastId
                    
                    If String.IsNullOrEmpty(maker) Then
                        cmd2.Parameters.Add("@MAKER", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@MAKER", OleDbType.VarChar).Value = maker
                    End If
                    
                    If String.IsNullOrEmpty(c_type) Then
                        cmd2.Parameters.Add("@C_TYPE", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@C_TYPE", OleDbType.VarChar).Value = c_type
                    End If
                    
                    If String.IsNullOrEmpty(bunrui) Then
                        cmd2.Parameters.Add("@BUNRUI", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@BUNRUI", OleDbType.VarChar).Value = bunrui
                    End If
                    
                    If String.IsNullOrEmpty(rnum) Then
                        cmd2.Parameters.Add("@R_NUM", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@R_NUM", OleDbType.VarChar).Value = rnum
                    End If
                    
                    If String.IsNullOrEmpty(revision) Then
                        cmd2.Parameters.Add("@revision", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@revision", OleDbType.VarChar).Value = revision
                    End If
                    
                    If String.IsNullOrEmpty(t_kubun) Then
                        cmd2.Parameters.Add("@T_KUBUN", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@T_KUBUN", OleDbType.VarChar).Value = t_kubun
                    End If
                    
                    If String.IsNullOrEmpty(evnt) Then
                        cmd2.Parameters.Add("@event", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@event", OleDbType.VarChar).Value = evnt
                    End If
                    
                    If String.IsNullOrEmpty(mt) Then
                        cmd2.Parameters.Add("@mt", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@mt", OleDbType.VarChar).Value = mt
                    End If
                    
                    If String.IsNullOrEmpty(mname(i)) Then
                        cmd2.Parameters.Add("@M_NAME", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@M_NAME", OleDbType.VarChar).Value = mname(i)
                    End If
                    
                    If String.IsNullOrEmpty(p_tenkai) Then
                        cmd2.Parameters.Add("@P_TENKAI", OleDbType.Date).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@P_TENKAI", OleDbType.Date).Value = p_tenkai
                    End If
                    
                    If String.IsNullOrEmpty(p_genko) Then
                        cmd2.Parameters.Add("@P_GENKO", OleDbType.Date).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@P_GENKO", OleDbType.Date).Value = p_genko
                    End If
                    
                    If String.IsNullOrEmpty(p_dok) Then
                        cmd2.Parameters.Add("@P_DOK", OleDbType.Date).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@P_DOK", OleDbType.Date).Value = p_dok
                    End If
                    
                    If String.IsNullOrEmpty(p_hosyou) Then
                        cmd2.Parameters.Add("@P_HOSYOU", OleDbType.Date).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@P_HOSYOU", OleDbType.Date).Value = p_hosyou
                    End If
                    
                    If String.IsNullOrEmpty(remarks) Then
                        cmd2.Parameters.Add("@REMARK", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@REMARK", OleDbType.VarChar).Value = remarks
                    End If
                    
                    If String.IsNullOrEmpty(kanban_no(i)) Then
                        cmd2.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = 0
                    Else
                        If kanban_no(i) = "N/A" Then
                            cmd2.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = 0    
                        Else
                            cmd2.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = kanban_no(i)
                        End If
                    End If
                    
                    If String.IsNullOrEmpty(mcir(i)) Then
                        cmd2.Parameters.Add("@mcir", OleDbType.Integer).Value = DBNull.Value
                    Else
                        cmd2.Parameters.Add("@mcir", OleDbType.Integer).Value = mcir(i)
                    End If
                    
                    If bunrui = "QC" Then
                        cmd2.Parameters.Add("@QC", OleDbType.Boolean).Value = "True"
                    Else
                        cmd2.Parameters.Add("@QC", OleDbType.Boolean).Value = "False"
                    End If
                    
                    cmd2.ExecuteNonQuery()
                    
                    Dim sql3 As String = "INSERT INTO T_TENKAI (ID,Kanban_No,SEC,DOISY,C_Nothing,MT_Nothing) VALUES (?,?,?,?,?,?)"
                    Dim cmd3 As New OleDbCommand(sql3, connection)
                    cmd3.Parameters.Add("@ID", OleDbType.Integer).Value = lastId
                    
                    If String.IsNullOrEmpty(kanban_no(i)) Then
                        cmd3.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = 0
                    Else
                        If kanban_no(i) = "N/A" Then
                            cmd3.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = 0
                        Else
                            cmd3.Parameters.Add("@Kanban_No", OleDbType.Integer).Value = kanban_no(i)
                        End If
                    End If
                    
                    If String.IsNullOrEmpty(sect) Then
                        cmd3.Parameters.Add("@SEC", OleDbType.VarChar).Value = DBNull.Value
                    Else
                        cmd3.Parameters.Add("@SEC", OleDbType.VarChar).Value = sect
                    End If
                    
                    If String.IsNullOrEmpty(doisy) Then
                        cmd3.Parameters.Add("@DOISY", OleDbType.Integer).Value = 0
                    Else
                        cmd3.Parameters.Add("@DOISY", OleDbType.Integer).Value = doisy
                    End If
                    
                    If t_kubun = "NEW" Or t_kubun = "MEMO" Then
                        cmd3.Parameters.Add("@C_Nothing", OleDbType.Boolean).Value = "True"
                    Else
                        cmd3.Parameters.Add("@C_Nothing", OleDbType.Boolean).Value = "False"
                    End If
                    
                    If mt = "0" Then
                        cmd3.Parameters.Add("@MT_Nothing", OleDbType.Boolean).Value = "True"
                    Else
                        cmd3.Parameters.Add("@MT_Nothing", OleDbType.Boolean).Value = "False"
                    End If
                    
                    cmd3.ExecuteNonQuery()
                    connection.Close()
                    
                    connection.Open()
                    Dim sql4 As String = ""
                    If mt = "1" Then
                        sql4 = "UPDATE T_BASE SET FLAG = 1 AND mt='YES' WHERE ID = ?"
                    Else
                        sql4 = "UPDATE T_BASE SET FLAG = 0 AND mt='NO' WHERE ID = ?"
                    End If
                
                    Dim cmd4 As New OleDbCommand(sql4, connection)
                    cmd4.Parameters.Add("@ID", OleDbType.VarChar).Value = lastId
                    cmd4.ExecuteNonQuery()
                    connection.Close()
                    
                    If Not String.IsNullOrEmpty(doisy) Then
                        If doisy = "1" Then
                            connection.Open()
                            Dim sql5 As String = ""
                            sql5 = "INSERT INTO T_DOISY (ID,STATUS,l_update) VALUES(?,?,NOW())"
                            Dim cmd5 As New OleDbCommand(sql5, connection)
                            cmd5.Parameters.Add("@ID", OleDbType.Integer).Value = lastId
                            cmd5.Parameters.Add("@DOISY", OleDbType.Integer).Value = doisy
                            cmd5.ExecuteNonQuery()
                            connection.Close()
                        End If
                    End If
                Next
                'Response.Write("INSERT SUCCESS")
                Response.Write("<script>alert('Successfully Added!\nThe window will close.'); window.close();</script>")
            Catch ex As Exception
                'Response.Write(ex.ToString())
                Response.Write(ex.ToString())
            End Try
            
            
        End If
    %>

    <section class="section">
        <div class="row">
            <div class="col-md-12">
                <h4>Basic Information New Data Entry</h4>
            </div>
        </div>

        <form class="" method="post">
            <div class="row">
                <div class="col-xs-3 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Request No.</label>
                        <input type="text" class="form-control" name="rnum" autofocus="true" autocomplete="off" required >
                    </div>
                </div>
                <div class="col-xs-3 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Revision</label>
                        <input type="number" class="form-control" name="revision" min="0" autocomplete="off">
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group no-pad-right">
                        <label class="nk-label">Section</label>
                        <input type="text" class="form-control" name="sect" value="FALP" autocomplete="off" required readonly>
                    </div>
                </div>
            </div> 
            <div class="row">
                <div class="col-xs-3 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Customer</label>
                        <select class="form-control" name="maker">
                            <option value="A">A: MAZDA</option>
                            <option value="B">B: DAIHATSU</option>
                            <option value="C">C: HONDA</option>
                            <option value="D">D: TOYOTA</option>
                            <option value="E">E: SUZUKI</option>
                            <option value="P">P: NISSAN</option>
                            <option value="Z">Z: NEXAS</option>
 			    <option value="G">G: ISUZU</option>
                            <!--<option value="E">E: IVAN</option>-->
                        </select>
                    </div>
                </div>
                <div class="col-xs-3 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Car Type</label>
                        <input type="text" class="form-control" name="c_type" autocomplete="off" autocomplete="off" required>
                    </div>
                </div>
                <div class="col-xs-3 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Type</label>
                        <select class="form-control" name="bunrui" required>
                            <option>TENKAI</option>
                            <option>QC</option>
                        </select>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="nk-label">Classification</label>
                        <select name="t_kubun" class="form-control" autocomplete="off" required>
                            <option>NEW</option>
                            <option>SIMILARITY</option>
                            <option>SIMILARITY(APPROVAL)</option>
                            <option>DRAWING</option>
                            <option>MEMO</option>
                            <option>COMPARISON</option>

                            <option>NEW R.D</option>
                            <option>SIMILARITY R.D</option>           
                            <option>DRAWING R.D</option>
                            <option>MEMO R.D</option>
                            <option>SIMILARITY(APPROVAL) R.D</option>

                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-3 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Event</label>
                        <input type="text" class="form-control" name="event" autocomplete="off" required>
                    </div>
                </div>
                <div class="col-xs-3 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">MT Check</label>
                        <select name="mt" class="form-control" required>
                            <option value="0">NO</option>
                            <option value="1">YES</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-3 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">TENKAI Due Date</label>
                        <input type="text" class="form-control" name="p_tenkai" autocomplete="off">
                        <div class="checkbox">
                          <label><input type="checkbox" name="checkbox_nothing">: Nothing</label>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Guarantee Due Date</label>
                        <input type="text" class="form-control" name="p_hosyou" autocomplete="off">
                        <div class="checkbox">
                          <label><input type="checkbox" name="checkbox_nothing">: Nothing</label>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Send Host</label>
                        <input type="text" class="form-control" name="p_genko" autocomplete="off">
                        <div class="checkbox">
                          <label><input type="checkbox" name="checkbox_nothing">: Nothing</label>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="nk-label">Entry</label>
                        <input type="text" class="form-control" name="p_dok" autocomplete="off">
                        <div class="checkbox">
                          <label><input type="checkbox" name="checkbox_nothing">: Nothing</label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-3 no-pad-right">
                    <div class="form-group">
                        <label class="nk-label">Doisy</label>
                        <div class="row">
                            <div class="col-xs-4 no-pad-right">
                                <select name="doisy" class="form-control">
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                </select>
                            </div>
                            <div class="col-xs-8">
                                <input type="number" class="form-control" readonly name="dnum" autocomplete="off">
                            </div>
                        </div>
                        
                    </div>
                </div>
                <div class="col-xs-9">
                    <div class="form-group">
                        <label class="nk-label">Remarks</label>
                        <input type="text" class="form-control" name="remarks" autocomplete="off">
                    </div>
                </div>
            </div>

            <!--<div class="row">
                <div class="col-xs-1 no-pad-right">
                    <div class="form-group">
                        <label>   </label>
                        <div class="radio">
                          <label><input type="radio" name="qc">QC</label>
                        </div>
                    </div>
                </div>
                <div class="col-xs-1 no-pad-right">
                    <div class="form-group">
                        <label>   </label>
                        <div class="radio">
                          <label><input type="radio" name="qc">KU</label>
                        </div>
                    </div>
                </div>
                <div class="col-xs-1 no-pad-right">
                    <div class="form-group">
                        <label>   </label>
                        <div class="radio">
                          <label><input type="radio" name="qc">SI</label>
                        </div>
                    </div>
                </div>
                <div class="col-xs-1 no-pad-right">
                    <div class="form-group">
                        <label>   </label>
                        <div class="radio">
                          <label><input type="radio" name="qc">OP</label>
                        </div>
                    </div>
                </div>
                <div class="col-xs-1 no-pad-right">
                    <div class="form-group">
                        <label>   </label>
                        <div class="radio">
                          <label><input type="radio" name="qc" value="" checked>N-QC</label>
                        </div>
                    </div>
                </div>
            </div>-->
            <div class="row">
                <div class="col-xs-12">
                    <h4 class="nk-header">Model Name</h4>
                </div>
            </div>
            <div class="row">

                <%
                    If Not String.IsNullOrEmpty(Request.QueryString("qty")) Then
                        Dim qty As String = Request.QueryString("qty")
                        
                        For q As Double = 1 To qty Step 1
                        %>
                            <div class="col-xs-3 no-pad-right">
                                <div class="form-group">
                                    <label class="nk-label">Model Name <% Response.Write(q) %></label>
                                    <input type="text" name="m_name" class="form-control" required placeholder="Model Name" autocomplete="off">
                                    <span>
                                        <input type="number" name="kanban_no" min="1" max="300" class="form-control" required placeholder="Kanban No" autocomplete="off">
                                        <p class="help-block hide">Kanban no. already exists.</p>
                                    </span>
                                    <input type="number" name="mcir" min="1" class="form-control" placeholder="MCIR" autocomplete="off" required>
                                    <input type="hidden" name="mcir" autocomplete="off">
                                </div>
                            </div>
                        <%
                        Next
                    End If
                    
                   
                %>
                
            </div>
            <input type="submit" class="btn btn-primary" name="submit" value="Submit">
            <input type="button" class="btn btn-default" onclick="window.close()" value="Cancel">
        </form>

    </section>
    <script type="text/javascript" src="jquery/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="moment-js/moment.min.js"></script>
    <script type="text/javascript" src="script.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            checkDoisy();

            $('input[name="kanban_no"]').keyup(function () {
                if ($('select[name="bunrui"]').val() != "") {

                    var el = $(this);
                    //$('input[name="kanban_no"]').closest('span').removeClass('has-error');
                    //$('.help-block').addClass('hide');

                    el.closest('span').removeClass('has-error');
                    el.next('.help-block').addClass('hide');

                    $('input[name="kanban_no"]').each(function () {
                        var el2 = $(this);
                        if (!el.is(el2)) {
                            if (el.val() != 0 && el2.val() != 0) {
                                if (el.val() != "" && el2.val() != "") {
                                    if (el.val() == el2.val()) {
                                        el.closest('span').addClass('has-error');
                                        el.next('.help-block').removeClass('hide');
                                        el2.closest('span').addClass('has-error');
                                        el2.next('.help-block').removeClass('hide');
                                    } else {
                                        //if (!el.closest('span').hasClass('has-error')) {
                                        el.closest('span').removeClass('has-error');
                                        el.next('.help-block').addClass('hide');
                                        //}

                                        //if (!el2.closest('span').hasClass('has-error')) {
                                        el2.closest('span').removeClass('has-error');
                                        el2.next('.help-block').addClass('hide');
                                        //}

                                    }
                                }
                            }
                        }

                    });

                    if ($('span.has-error').length != 0) {
                        $('form input[name="submit"]').addClass('disabled').removeAttr('type').attr('type', 'button');
                    } else {
                        $('form input[name="submit"]').removeClass('disabled').removeAttr('type').attr('type', 'submit');
                        kanbanExists(el);
                    }
                }

            });

            function kanbanExists(el) {
                console.log(el.val(), $('select[name="maker"]').val(), $('select[name="bunrui"]').val());
                if (el.val() != "") {
                    $.post('functions/kanbanexists.aspx', {
                        kbn: el.val(),
                        maker: $('select[name="maker"]').val(),
                        bunrui: $('select[name="bunrui"]').val()
                    }, function (response) {
                        console.log(response);
                        if (response) {
                            el.closest('span').addClass('has-error');
                            el.next('.help-block').removeClass('hide');
                        } else {
                            el.closest('span').removeClass('has-error');
                            el.next('.help-block').addClass('hide');
                        }

                        if ($('span.has-error').length != 0) {
                            $('form input[name="submit"]').addClass('disabled').removeAttr('type').attr('type', 'button');
                        } else {
                            $('form input[name="submit"]').removeClass('disabled').removeAttr('type').attr('type', 'submit');
                        }

                    });

                }
            }

            $('input[name="submit"]').click(function () {
                $('input[name="kanban_no"]').each(function () {
                    kanbanExists($(this).val(), $('select[name="maker"]').val());
                });
            });

            $('select[name="maker"]').change(function () {
                checkDoisy();
            });

            $('select[name="doisy"]').change(function () {
                checkDnum();
            });
            function checkDoisy() {
                if ($('select[name="maker"]').val() != "C") {
                    $('select[name="doisy"] option[value="No"]').attr('selected', true);
                    $('select[name="doisy"] option[value="Yes"]').removeAttr('selected');
                    $('select[name="doisy"]').attr('disabled', true);
                } else {
                    $('select[name="doisy"]').removeAttr('disabled');
                    $('select[name="doisy"] option[value="No"]').removeAttr('selected');
                    $('select[name="doisy"] option[value="Yes"]').attr('selected', true);
                }

                checkDnum();
            }
            function checkDnum() {
                if ($('select[name="doisy"]').val() == "Yes") {
                    $('input[name="dnum"]').removeAttr('readonly');
                } else {
                    $('input[name="dnum"]').attr('readonly', true).val('');
                }
            }
            $('input[name="qc"]').click(function () {
                if ($(this).is(':checked')) {
                    if ($(this).val() != "") {
                        $('input[name="kanban_no"]').attr('readonly', true).val('');
                    } else {
                        $('input[name="kanban_no"]').removeAttr('readonly');
                    }

                } else {
                    $('input[name="kanban_no"]').removeAttr('readonly');
                }
            });

            $('input[name="checkbox_nothing"]').click(function () {
                if ($(this).is(':checked')) {
                    $(this).closest('.checkbox').prev().attr('type', 'hidden').val('1970-01-01');
                } else {
                    $(this).closest('.checkbox').prev().attr('type', 'text').val('');
                }
            });

            //            $('select[name="bunrui"]').change(function () {
            //                if ($(this).val() == "QC") {
            //                    $('input[name="kanban_no"]').prop("readonly", true).prop("type", "text").val('N/A');
            //                } else {
            //                    $('input[name="kanban_no"]').prop("readonly", false).val('').prop("type", "number");
            //                }
            //            });

        });
    </script>
</body>
</html>
