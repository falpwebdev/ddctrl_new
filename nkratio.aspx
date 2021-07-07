<%@ Page Language="VB" AutoEventWireup="false" CodeFile="nkaddest.aspx.vb" Inherits="nkaddest" %>

<%@ Import Namespace="System.Data.OleDb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Muti-Circuit Summary</title>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .control-label
        {
            font-size: 11px;
            background-color: #B0BEC5;
            text-align: left !important;
        }
    </style>
</head>
<body>
    <%  
        Dim dt As Date = Date.Today
        Dim dt_format = dt.ToString("yyyy'/'MM'/'dd")
    %>
    <section class="section">

        <div class="row">
            <div class="col-xs-8">
                <h4 class="text-center">Muti-Circuit Summary</h4>
                <form method="post" id="form-ratio">
                    <table class="table-nkratio ">
                        <tbody>
                            <tr>
                                <th colspan="3" class="text-center"><strong>Period</strong></th>
                                <th rowspan="2" nowrap>
                                    <div class="checkbox">
                                        <label><input type="checkbox" name="summary" value="non-mcir" checked> Non-input list</label>
                                    </div>
                                    <div class="checkbox">
                                        <label><input type="checkbox" name="summary" value="ratio"> Summary</label>
                                    </div>
                                </th>
                                <th rowspan="2">
                                    <label>Customer</label>
                                    <select name="car_maker">
                                        <option value="all">ALL</option>
                                        <option value="A">A: MAZDA</option>
                                        <option value="B">B: DAIHATSU</option>
                                        <option value="C">C: HONDA</option>
                                        <option value="D">D: TOYOTA</option>
                                        <option value="E">E: SUZUKI</option>
                                        <option value="P">P: NISSAN</option>
                                        <option value="Z">Z: NEXAS</option>
                                    </select>
                                </th>
                                <th rowspan="2">
                                    <label>&nbsp</label>
                                    <p class="form-control-static">
                                        <button class="btn btn-primary btn-xs" type="submit" name="ratio" value="MusicIsLife">Search</button>
                                    </p>
                                </th>
                            </tr>
                            <tr>
                                <th>
                                    <label>Starting Date</label>
                                    <input type="text" class="form-control" name="date_start" value="<%=dt_format %>" required>
                                </th>
                                <th class="text-center">
                                    <label>&nbsp</label>
                                    <p class="form-control-static">～</p>
                                </th>
                                <th>
                                    <label>Finish Date</label>
                                    <input type="text" class="form-control" name="date_end" value="<%=dt_format %>" required>
                                </th>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-10">
                <table class="table table-border tbl-ratio" id="ratio-content">
                
                </table>
            </div>
        </div>

    </section>
    <script type="text/javascript" src="jquery/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="moment-js/moment.min.js"></script>
    <script type="text/javascript" src="bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="script.js"></script>

    <script>
        $(document).ready(function () {
            $('input[name="date_start"]').datetimepicker({
                format: "YYYY/MM/DD"
            });
            $('input[name="date_end"]').datetimepicker({
                format: "YYYY/MM/DD"
            });
            $("#form-ratio").submit(function (e) {
                e.preventDefault();
                var car_maker = $('select[name="car_maker"]').val();
                var date_start = $('input[name="date_start"]').val();
                var date_end = $('input[name="date_end"]').val();
                var summary = $('input[name="summary"]:checked').val();

                if (summary == 'ratio') {
                    $.post('functions/ratioFilter.aspx', {
                        car_maker: car_maker,
                        start: date_start,
                        end: date_end
                    }, function (html) {
                        console.log(html);
                        $("#ratio-content").html(html);
                    });
                } else {
                    $.post('functions/nonMcirList.aspx', {
                        car_maker: car_maker,
                        start: date_start,
                        end: date_end
                    }, function (html) {
                        console.log(html);
                        $("#ratio-content").html(html);
                    });
                } 
            });

            $('input[name="summary"]').click(function () {
                chkboxCtrl($(this));
            });

            function chkboxCtrl(el) {
                $('input[name="summary"]').prop('checked', false);
                el.prop('checked', true);
            }
        });
    </script>
</body>
</html>
