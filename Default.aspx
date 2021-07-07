<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Import Namespace="System.Data.OleDb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Due date control</title>
    <meta http-equiv="content-type" content="text/html; charset=Shift_JIS">
    <link rel="shortcut icon" href="favicon.ico" type="image/ico">
    <link rel="icon" href="favicon.ico" type="image/ico">
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="plugins/animate-css/animate.css" rel="stylesheet" type="text/css" />
    <link href="style.css?v=1" rel="stylesheet" type="text/css" />
</head>

<body>
    <style>
    #canvas{
        position: absolute;
        z-index: -1;
        background: transparent;
        width: 100%;
    }
    </style>
    <canvas id="canvas"></canvas>
    <section class="section">
        <div class="row">
            <div class="col-xs-4">
                <h4>Due Date Control (FALP)</h4>
            </div>
            <div class="col-xs-2">
                <a target="_blank" href="export_csv.aspx" class="btn btn-default btn-sm btn-export">CSV</a>
                <a href="http://172.25.112.171:8090/csv/csvout_format_main.xls">Format</a>
            </div>
            <div class="col-xs-1">
                <!--<span>
                    <a class="btn btn-primary btnStd">Add Std. Info.</a>
                </span>-->
                <select name="mode">
                    <option></option>
                    <option>Add</option>
                    <option>Update</option>
                    <option>Delete</option>
                    <!--<option>Unlock</option>
                    
                    <option>P/N Check</option>-->
                </select>
                <select name="action">
                    <option></option>
                    <option>Std. info</option>
                    <option>Progress</option>
                    <option>New Parts</option>
                    <option>Unclear</option>
                    <option>Est. Request</option>
                    <option>E-mail</option>
                    <option>Etc</option>
                    <option>Doisy</option>
                    <option style="font-size:1px;background-color: #ddd" disabled>&nbsp;</option>
                    <option>Issue Form</option>
                </select>
            </div>
            <div class="col-xs-2">
                <input type="password" name="pw">
            </div>
            <div class="col-xs-1">
                <input type="text" name="kanban_no" class="secret-box" autocomplete="off">
                <input type="text" name="limit" class="secret-box" autocomplete="off">
            </div>
        
         <div class="col-xs-1">
             <select name="dbconnection" id="dbconnection" onchange="trial()" class="dbconnection form-control">
                 <option value="LIVE">LIVE</option>
                 <option value="BACKUP">BACKUP</option>
                </select>
            </div>
                <script>
                    function trial() {
                        $(document).ready(function () {
                          
                            var x = document.getElementById('dbconnection').value;
                            
                            if (x == 'BACKUP') {
                                window.location.href = 'http://172.25.112.171:300/';
                            }
                            
                            

                        });
                    }
                </script>
        </div>
        <div class="no-pad-left">
            <div class="col-xs-12 no-pad-left table-wrapper">
                <table class="table">
                
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                    <form method="post" name="form-search">
                        <div class="row">
                    
                            <div class="col-xs-3">
                                <div class="form-group">
                                    <h7><b>Section</b></h7>
                                    <select name="sect" class="form-control" readonly>
                                        <option>FALP</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-3">
                                <div class="form-group">
                                     <h7><b>Classification</b></h7>
                                    <select name="bunrui" class="form-control">
                                        <option value="TENKAI">TENKAI</option>
                                        <option value="QC">QC</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-4">
                                <div class="form-group">
                                     <h7><b>Customer</b></h7>
                                    <select name="maker" class="form-control">
                                        <option value="null"></option>
                                        <option value="A">A: MAZDA</option>
                                        <option value="B">B: DAIHATSU</option>
                                        <option value="C">C: HONDA</option>
                                        <option value="D">D: TOYOTA</option>
                                        <option value="E">E: SUZUKI</option>
                                        <option value="P">P: NISSAN</option>                                     
					                    <option value="G">G: ISUZU</option>
                                        <option value="Z">Z: OTHERS</option>
                                    </select>
                                </div>
                            </div>
                           </div>

                        
                        <h6><b>Due Date</b></h6>
                        <div class="fieldset-2 col-xs-10">
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
                                <div class="col-xs-2 no-pad-left">
                                    <div class="form-group">
                                        <select class="form-control" name="date_range">
                                            <option value="eq">=</option>
                                            <option value="gt">≧</option>
                                            <option value="lt">≦</option>
                                            <option value="range">～</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-5 no-pad-right">
                                    <div class="form-group">
                                        <input type="text" autocomplete="off" class="form-control" name="date_start" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                                    </div>
                                </div>
                                <div class="col-xs-1 no-pad-left no-pad-right text-center hide range-symbol">
                                    <div class="form-group" style="padding-top: 6px">
                                       ～
                                    </div>
                                </div>
                                <div class="col-xs-4 no-pad-left hide">
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="date_end" pattern="[0-9]{4}/(0[1-9]|1[012])/(0[1-9]|1[0-9]|2[0-9]|3[01])">
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-xs-9">

                            <div class="fieldset-3 col-xs-12">
                                <div class="row">
                                    <div class="col-xs-12 no-pad-right checkbox-ctrl">
                                        <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="rnum" value="rnum"> : RequestNo
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12 no-pad-right checkbox-ctrl">
                                        <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="mname" value="mname"> : Model Name
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12 no-pad-right checkbox-ctrl">
                                        <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="c_type" value="c_type"> : Car Type
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10 no-pad-right">
                                        <div class="form-group">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="t_name" value="t_name"> : Designer
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <input type="text" autocomplete="off" name="filter_value" class="form-control">
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="fieldset-4 col-xs-12">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="form-group">
                                                    <a href="nkproblemlist.aspx" target="_blank" class="btn btn-primary btn-xs">Problem List</a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="form-group">
                                                    <a class="btn btn-primary btn-xs disabled">Worker List</a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="form-group">
                                                    <a href="nkratio.aspx" class="btn btn-primary btn-xs btn-mcir">MCIR List</a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="form-group">
                                                    <a href="http://172.25.116.81:2000/issue/issue.php?form_type=1" target="_blank" class="btn btn-primary btn-xs">Issue List</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-8 no-pad-left">
                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">Design Condition: </label>
                                                <div class="col-xs-9">
                                                    <select class="form-control" name="dcondition">
                                                        <option value="non-f">Non-finished</option>
                                                        <option value="non-sav">Non-send SAV</option>
                                                        <option value="non-sd">Non-send S/D</option>
                                                        <option value="allf">Finished</option>
                                                        <option value="all">All</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">Problem Condition: </label>
                                                <div class="col-xs-9">
                                                    <select class="form-control" name="pcondition">
                                                        <option value="non-a">Non-answer</option>
                                                        <option value="non-g">Non-guarantee</option>
                                                        <option value="non-f">Non-finished</option>
                                                        <option value="all">All Data</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-12 no-pad-right checkbox-ctrl">
                                                <div class="form-group">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" name="display1" value="display1"> : SD/Chk1/Chk2 display
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-12 no-pad-right checkbox-ctrl">
                                                <div class="form-group">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" name="display2" value="display2"> : Event & MT Display
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            
                            </div>

                            <div class="fieldset-5 col-xs-3">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <button type="reset" class="btn btn-default btn-block">Clear</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <button type="submit" name="search" class="btn btn-warning btn-block">Search</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </form>
                    </div>
                </div>
            </div>

            <div class="col-xs-7 no-pad-left">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <span class="no-pad-right no-pad-left col-xs-12 table-problem-wrapper"></span>
                    </div>
                </div>
            </div>

        </div>
    </section>
    <script type="text/javascript" src="jquery/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="plugins/bootstrap-notify/bootstrap-notify.min.js"></script>
    <script type="text/javascript" src="plugins/jquery-snowfall/snowfall.jquery.min.js"></script>
    <!--<script type="text/javascript" src="plugins/sketchjs/sketch.js"></script>-->
    <script type="text/javascript" src="script.js?ver=1"></script>
    <script type="text/javascript" src="main.js?ver=1"></script>
    <script type="text/javascript" src="issue.js?ver=2"></script>

</body>
</html>
