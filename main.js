$(document).ready(function () {
    var plswait = "";
    function getLoading(){
        var rand = Math.floor(Math.random() * 11); 
        //var rand = 7;
        var w = 150;
        var h = 180;
        switch(rand){
            case 0:
                w = 320;
                h = 160;
                break;
            case 1:
                w = 250;
                h = 250;
                break;
            case 2:
                w = 220;
                h = 120;
                break;
            case 3:
                w = 120;
                h = 190;
                break;
            case 4:
                w = 160;
                h = 160;
                break;
            case 5:
                w = 260;
                h = 130;
                break;
            case 6:
                w = 200;
                h = 200;
                break;
            case 7:
                w = 250;
                h = 180;
                break;
            case 8:
                w = 200;
                h = 200;
                break;
            case 9:
                w = 250;
                h = 160;
                break;
            case 10:
                w = 200;
                h = 140;
                break;
        }

        plswait = "<center><img height='"+h+"' width='"+w+"' src='loader/anime-"+rand+".gif?v="+randomString(10)+"'><br><h5> Loading...</h5></center>"
    }

    function randomString(length) {
        var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghiklmnopqrstuvwxyz'.split('');

        if (! length) {
            length = Math.floor(Math.random() * chars.length);
        }

        var str = '';
        for (var i = 0; i < length; i++) {
            str += chars[Math.floor(Math.random() * chars.length)];
        }
        return str;
    }

    $('.table-problem-wrapper').closest('.panel').addClass('hide');

    var redirectUrl = '';
    $(document).on('click', '.btnStd', function () {
        var q = prompt("Enter the number of models to perform a new registration...");
        if (q != null) {
            if (isNaN(q)) {
                alert("Error. That is not a number.");
            } else {
                PopupCenter('addStd.aspx?qty=' + q, 'xtf', '970', '600');
            }
        }

    });

    $(document).on('click', '.link', function () {
        var id = $(this).closest('tr').data('id');
        var mname = $(this).text();
        var pw = $('input[name="pw"]').val();

        if ($('select[name="mode"]').val() != "Delete") {
            gotoLink(id, $('select[name="mode"]').val(), $('select[name="action"]').val());
        } else {
            if (pw == "") {
                alert("Please enter password.");
            } else {
                if (pw == "fapvsss") {
                    var r = confirm("ID: " + id + "\nModel Name: " + mname + "\nAre you sure you want to delete?");
                    if (r == true) {
                        PopupCenter('functions/deleteModel.aspx?id=' + id, 'xtf', '1190', '600');
                    } else {
                        alert("The process was cancelled.");
                    }
                } else {
                    alert("Password incorrect.");
                }
            }
        }


    });

    $('select[name="mode"]').change(function () {
        checkAction($(this).val(), $('select[name="action"]').val());
    });
    $('select[name="action"]').change(function () {
        checkAction($('select[name="mode"]').val(), $(this).val());
    });

    $(document).on('click', '.td-pr', function () {
        var id = $(this).closest('tr').data('id');
        var problem = $(this).data('problem');
        var pcondition = $('select[name="pcondition"]').val();

        if ($(this).text() != "") {
            console.log(id, problem);
            $('.table-problem-wrapper').html(plswait);
            $('.table-problem-wrapper').closest('.panel').removeClass('hide');
            $.post("functions/getProblemList.aspx", {
                id: id,
                problem: problem,
                pcondition: pcondition
            }, function (response) {
                console.log(response)
                $('.table-problem-wrapper').html(response);
            });
        }

    });

    function gotoLink(id, mode, action) {
        if (id && mode && action) {
            var a = mode + " " + action;
            switch (a) {
                case 'Update Std. info':
                    if ($('input[name="pw"]').val() == "") {
                        PopupCenter('nkupdateinfo.aspx?id=' + id, 'xtf', '1190', '600');
                    } else {
                        if ($('input[name="pw"]').val() == "seigi") {
                            PopupCenter('nkupdateinfo.aspx?id=' + id + '&admin=on', 'xtf', '1190', '600');
                        } else {
                            alert("Password incorrect.");
                        }

                    }

                    break;
                case 'Update Progress':
                    PopupCenter('nkupdate.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                case 'Add New Parts':
                    PopupCenter('nkaddnp.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                case 'Update New Parts':
                    PopupCenter('nkupdatenp.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                case 'Add Unclear':
                    PopupCenter('nkaddup.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                case 'Update Unclear':
                    PopupCenter('nkupdateup.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                case 'Add Est. Request':
                    PopupCenter('nkaddest.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                case 'Update Est. Request':
                    PopupCenter('nkupdateest.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                case 'Add E-mail':
                    PopupCenter('nkaddmail.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                case 'Update E-mail':
                    PopupCenter('nkupdateemail.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                case 'Add Etc':
                    PopupCenter('nkaddetc.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                case 'Update Etc':
                    PopupCenter('nkupdateetc.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                case 'Add Doisy':
                    alert("Invalid Action")
                    //PopupCenter('nkadddoisy.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                case 'Update Doisy':
                    PopupCenter('nkupdatedoisy.aspx?id=' + id, 'xtf', '1190', '600');
                    break;
                default:
                    console.log('Oops');
                    break;
            }
        } else {
            alert("Please select mode of action.");
        }
    }

    function checkAction(mode, action) {
        $(".cancel-model").click();
        disableIssue();
        var action = mode + " " + action;
        console.log(action);
        switch (action) {
            case 'Add Std. info':
                var q = prompt("Enter the number of models to perform a new registration...");
                if (q != null) {
                    if (isNaN(q)) {
                        alert("Error. That is not a number.");
                    } else {
                        PopupCenter('addStd.aspx?qty=' + q, 'xtf', '970', '600');
                    }
                }
                break;
            case 'Add Issue Form':
                issueInit();
                break;
            default:
                console.log('Oops');
                break;
        }
    }

    $('select[name="date_range"]').change(function () {
        if ($(this).val() == "range") {
            $('input[name="date_end"]').closest('.col-xs-4').removeClass('hide');
            $('.range-symbol').removeClass('hide');
        } else {
            $('input[name="date_end"]').closest('.col-xs-4').addClass('hide');
            $('.range-symbol').addClass('hide');
        }
    });

    $('.btn-mcir').click(function (e) {
        e.preventDefault();
        var link = $(this).attr("href");
        PopupCenter(link, 'MCIR SUMMARY', '800', '500');
    });

    $('form[name="form-search"]').submit(function (e) {
        e.preventDefault();

        getLoading();
        var el = $(this);
        $('.table').html(plswait);
        $('.table-problem-wrapper').closest('.panel').addClass('hide');
        el.find('button[type="submit"]').addClass('disabled').text('Searching...');
        $.post("functions/searchFilter.aspx", {
            sect: $('select[name="sect"]').val(),
            bunrui: $('select[name="bunrui"]').val(),
            maker: $('select[name="maker"]').val(),
            duedate: $('select[name="duedate"]').val(),
            date_range: $('select[name="date_range"]').val(),
            date_start: $('input[name="date_start"]').val(),
            date_end: $('input[name="date_end"]').val(),
            rnum: $('input[name="rnum"]:checked').val(),
            mname: $('input[name="mname"]:checked').val(),
            c_type: $('input[name="c_type"]:checked').val(),
            t_name: $('input[name="t_name"]:checked').val(),
            filter_value: $('input[name="filter_value"]').val(),
            display1: $('input[name="display1"]:checked').val(),
            display2: $('input[name="display2"]:checked').val(),
            dcondition: $('select[name="dcondition"]').val(),
            pcondition: $('select[name="pcondition"]').val(),
            kanban_no: $('input[name="kanban_no"]').val(), //secret box
            limit: $('input[name="limit"]').val() //secret box
        }, function (response) {
            console.log(response);
            //HeartsBackground.initialize();
            $('#canvas').fadeIn();

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
        var dcondition = $('select[name="dcondition"]').val();
        var bunrui = $('select[name="bunrui"]').val();
        var link = $(this).attr("href");
        var rnum = $('input[name="rnum"]:checked').val();
        var mname = $('input[name="mname"]:checked').val();
        var c_type = $('input[name="c_type"]:checked').val();
        var t_name = $('input[name="t_name"]:checked').val();
        var filter_value = $('input[name="filter_value"]').val();
        var filter = "";

        var duedate = $('select[name="duedate"]').val();
        var date_range = $('select[name="date_range"]').val();
        var date_start = $('input[name="date_start"]').val();
        var date_end = $('input[name="date_end"]').val();

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


        console.log(maker, link, rnum, mname, c_type, t_name);

        //window.open("http://172.25.112.87:50/" + link + "?maker=" + maker + "&dcondition=" + dcondition + "&bunrui=" + bunrui + "&filter=" + filter + "&filter_value=" + filter_value + "&duedate=" + duedate + "&date_range=" + date_range + "&date_start=" + date_start + "&date_end=" + date_end);
        window.open("http://172.25.112.171:8090/" + link + "?maker=" + maker + "&dcondition=" + dcondition + "&bunrui=" + bunrui + "&filter=" + filter + "&filter_value=" + filter_value + "&duedate=" + duedate + "&date_range=" + date_range + "&date_start=" + date_start + "&date_end=" + date_end);

        //window.open("http://localhost:50/" + link + "?maker=" + maker + "&dcondition=" + dcondition + "&bunrui=" + bunrui + "&filter=" + filter + "&filter_value=" + filter_value + "&duedate=" + duedate + "&date_range=" + date_range + "&date_start=" + date_start + "&date_end=" + date_end);
    });

});