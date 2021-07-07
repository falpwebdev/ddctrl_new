<%@ Page Language="VB" AutoEventWireup="false" CodeFile="nkproblemlist.aspx.vb" Inherits="nkproblemlist" %>

<%@ Import Namespace="System.Data.OleDb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Problem Point List</title>
    <meta http-equiv="content-type" content="text/html; charset=Shift_JIS">
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <style>
        .checkbox-ctrl
        {
            margin-top: 0px;
            margin-bottom: 0px;
        }
        h5
        {
            margin-top: 5px;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    
    <section class="section">
        <div class="row">
            <div class="col-xs-6">
                <h4>Due date control &lt;Problem List&gt;</h4>
            </div>
            <div class="col-xs-2">
                <a target="_blank" href="export_csv_problem.aspx" class="btn btn-default btn-sm btn-export">CSV</a>
                <a href="http://172.25.112.171:8090/csv/csvout_format_problem.xls">Format</a>
            </div>
        </div>

        <div class="no-pad-left">
            <div class="col-xs-12 no-pad-left table-wrapper">
                <table class="table">
                
                </table>
            </div>
        </div>

        <form method="post" name="form-search">
            <div class="row">
                <div class="col-xs-4">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-4 no-pad-right">
                                    <div class="form-group">
                                        <label>Section</label>
                                        <select name="sect" class="form-control" readonly>
                                            <option>FALP</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xs-4 no-pad-right">
                                    <div class="form-group">
                                        <label>Classification</label>
                                        <select name="t_kubun" class="form-control">
                                            <option>TENKAI</option>
                                            <option>QC</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xs-4">
                                    <div class="form-group">
                                        <label>Customer</label>
                                        <select name="maker" class="form-control">
                                            <option value="null"></option>
                                            <option value="A">A: MAZDA</option>
                                            <option value="B">B: DAIHATSU</option>
                                            <option value="C">C: HONDA</option>
                                            <option value="D">D: TOYOTA</option>
                                            <option value="E">E: SUZUKI</option>
                                            <option value="P">P: NISSAN</option>
                                            <option value="Z">Z: NEXAS</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                        
                            <h5>Due Date</h5>
                            <div class="fieldset-2 col-xs-12">
                                <div class="row">
                                    <div class="col-xs-5 no-pad-right">
                                        <div class="form-group">
                                            <select class="form-control" name="duedate">
                                                <option value="null"></option>
                                                <option value="tenkai">TENKAI</option>
                                                <option value="genko">Send data</option>
                                                <option value="dok">Entry host</option>
                                                <option value="hosyou">Guarantee Check</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-xs-7">
                                        <div class="form-group">
                                            <input type="text" class="form-control" autocomplete="off" name="date_start" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="row">
                        <div class="fieldset-2 col-xs-12" style="margin-bottom: 13px">
                            <div class="row">
                                <div class="col-xs-4 no-pad-right">
                                    <div class="form-group">
                                        <div class="checkbox checkbox-ctrl">
                                            <label>
                                                <input type="checkbox" name="np" value="np" checked> : New Parts
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-5 no-pad-left">
                                    <div class="form-group">
                                        <div class="checkbox checkbox-ctrl">
                                            <label>
                                                <input type="checkbox" name="up" value="up" checked> : Unclear Point
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-5 no-pad-right">
                                    <div class="form-group">
                                        <div class="checkbox checkbox-ctrl">
                                            <label>
                                                <input type="checkbox" name="est" value="est" checked> : Establish Request
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-3 no-pad-left no-pad-right">
                                    <div class="form-group">
                                        <div class="checkbox checkbox-ctrl">
                                            <label>
                                                <input type="checkbox" name="mail" value="mail" checked> : E-mail
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-3 no-pad-left no-pad-right">
                                    <div class="form-group">
                                        <div class="checkbox checkbox-ctrl">
                                            <label>
                                                <input type="checkbox" name="etc" value="etc" checked> : Others
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="fieldset-2 col-xs-12">
                            <div class="row">
                                <div class="col-xs-4 no-pad-right">
                                    <div class="form-group">
                                        <div class="checkbox checkbox-ctrl">
                                            <label>
                                                <input type="checkbox" name="rnum" value="rnum"> : Request №
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-4 no-pad-left">
                                    <div class="form-group">
                                        <div class="checkbox checkbox-ctrl">
                                            <label>
                                                <input type="checkbox" name="mname" value="mname"> : Model name
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-4 no-pad-left">
                                    <div class="form-group">
                                        <div class="checkbox checkbox-ctrl">
                                            <label>
                                                <input type="checkbox" name="c_type" value="mname"> : Car type
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-4 no-pad-right">
                                    <div class="form-group">
                                        <div class="checkbox checkbox-ctrl">
                                            <label>
                                                <input type="checkbox" name="t_name" value="rnum"> : Designer
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="form-group">
                                        <div class="">
                                            <input type="text" name="filter_value" class="form-control" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xs-3">
                    <div class="row">
                        <div class="col-xs-5">
                            <select class="form-control" name="pcondition">
                                <option value="non-a">Non-Answer</option>
                                <option value="non-g">Non-Guar</option>
                                <option value="non-f">Non-finished</option>
                                <option value="end">Finished</option>
                                <option value="all">All</option>
                            </select>
                        </div>
                    </div>
                    <!--<div class="row">
                        <div class="col-xs-3 no-pad-right">
                            <select class="form-control">
                                <option>ON</option>
                                <option>OFF</option>
                            </select>
                        </div>
                        <div class="col-xs-7 no-pad-left">
                            <p class="form-control-static">：FAS Issue Num. display </p>
                        </div>
                    </div>-->
                    <div class="row">
                        <div class="col-xs-4" style="padding-bottom: 4px">
                            <button type="reset" class="btn btn-default">Reset</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-4">
                            <button type="submit" class="btn btn-primary">Search</button>
                        </div>
                    </div>
                </div>

            </div>
        </form>
    </section>
    <script type="text/javascript" src="jquery/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="script.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //var plswait = "<h4>Chotto matte kudasai &hearts;...</h4>";
            var plswait = "<h4>Loading, Please wait...</h4>";

            $('form[name="form-search"]').submit(function (e) {
                e.preventDefault();
                var el = $(this);
                $('.table').html(plswait);
                $('.table-problem-wrapper').closest('.panel').addClass('hide');
                el.find('button[type="submit"]').addClass('disabled').text('Searching...');
                $.post("functions/problemFilter.aspx", {
                    sect: $('select[name="sect"]').val(),
                    t_kubun: $('select[name="t_kubun"]').val(),
                    maker: $('select[name="maker"]').val(),
                    duedate: $('select[name="duedate"]').val(),
                    date_start: $('input[name="date_start"]').val(),
                    np: $('input[name="np"]:checked').val(),
                    up: $('input[name="up"]:checked').val(),
                    est: $('input[name="est"]:checked').val(),
                    mail: $('input[name="mail"]:checked').val(),
                    etc: $('input[name="etc"]:checked').val(),
                    rnum: $('input[name="rnum"]:checked').val(),
                    mname: $('input[name="mname"]:checked').val(),
                    c_type: $('input[name="c_type"]:checked').val(),
                    t_name: $('input[name="t_name"]:checked').val(),
                    filter_value: $('input[name="filter_value"]').val(),
                    pcondition: $('select[name="pcondition"]').val()
                }, function (response) {
                    console.log(response);

                    $('.table').html(response);
                    el.find('button[type="submit"]').removeClass('disabled').text('Search');
                    $("html, body").animate({ scrollTop: 0 }, "fast");
                });

            });

            $('input[name="rnum"]').click(function () {
                onCheck($(this));
            });

            $('input[name="mname"]').click(function () {
                onCheck($(this));
            });

            $('input[name="c_type"]').click(function () {
                onCheck($(this));
            });

            $('input[name="t_name"]').click(function () {
                onCheck($(this));
            });

            function onCheck(el) {
                if (!el.is(':checked')) {
                    $(el).prop("checked", false);
                } else {
                    $('input[name="rnum"]').prop("checked", false);
                    $('input[name="mname"]').prop("checked", false);
                    $('input[name="c_type"]').prop("checked", false);
                    $('input[name="t_name"]').prop("checked", false);
                    el.prop("checked", true);
                }
            }

            $(".btn-export").click(function (e) {
                e.preventDefault();
                var maker = $('select[name="maker"]').val();
                var link = $(this).attr("href");
                var t_kubun = $('select[name="t_kubun"]').val();
                var duedate = $('select[name="duedate"]').val();
                var date_start = $('input[name="date_start"]').val();
                var pcondition = $('select[name="pcondition"]').val();
                var np = $('input[name="np"]:checked').val();
                var up = $('input[name="up"]:checked').val();
                var est = $('input[name="est"]:checked').val();
                var mail = $('input[name="mail"]:checked').val();
                var etc = $('input[name="etc"]:checked').val();
                var rnum = $('input[name="rnum"]:checked').val();
                var mname = $('input[name="mname"]:checked').val();
                var c_type = $('input[name="c_type"]:checked').val();
                var t_name = $('input[name="t_name"]:checked').val();
                var filter_value = $('input[name="filter_value"]').val();
                //                pcondition: $('select[name="pcondition"]').val()

                var filter = "";

                if (rnum !== undefined) {
                    filter = 'rnum';
                }

                if (mname !== undefined) {
                    filter = 'mname';
                }

                if (c_type !== undefined) {
                    filter = 'c_type';
                }

                if (t_name !== undefined) {
                    filter = 't_name';
                }

                console.log(maker, link)

                if (maker == "null") {
                    maker = "all";
                }


                window.open("http://172.25.112.171:8090/" + link + "?maker=" + maker + "&t_kubun=" + t_kubun + "&duedate=" + duedate + "&date_start=" + date_start + "&filter=" + filter + "&filter_value=" + filter_value + "&np=" + np + "&up=" + up + "&est=" + est + "&mail=" + mail + "&etc=" + etc + "&pcondition=" + pcondition);

            });

        });
    </script>
</body>
</html>
