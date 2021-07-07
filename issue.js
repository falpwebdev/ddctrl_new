var models = [];

function issueInit() {
    console.log(models);
    
    enableIssue();

    $.notifyClose();
    $.notify({
        // options
        title: 'Select model to issue',
    }, {
        // settings
        type: 'info',
        delay: 0,
        timer: 0,
        newest_on_top: true,
        animate: {
            enter: 'animated slideInRight',
            exit: 'animated slideOutRight'
        },
        template: '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0} alert-issue" role="alert">' +
		        '<span data-notify="icon"></span> ' +
		        '<span data-notify="title"><h4>{1}</h4></span> ' +
		        '<span><h5>Click <strong>OK</strong> to confirm selected model(s)</h5></span>' +
                '<div>'+ 
                '<ul class="alert-model-list">' +
                '</ul>' +
                '</div>'+

                '<div class="form-group"><label> Form issue type: ' +
                '<select name="issue_type">' +
                '<option value="" selected>-select form-</option>' +
                '<optgroup label="Registration Request"></optgroup>' +
                '<!--<option value="np" disabled>2: New Parts Registration</option>-->' +
                '<option value="comm">16-1: Comment Registration</option>' +
                '<option value="trans">16-2: Customer Note Translation</option>' +
                '<option value="sym">17: Symbol Register Form</option>' +
                '<option value="fig">18: Figure Register Form</option>' +
                '<optgroup label="Establisment Request"></optgroup>' +
                '<!--<option value="c/h" disabled>C/H Setting Request</option>-->' +
                '<optgroup label="UCP"></optgroup>' +
                '<option value="ucpa">For not terminal rubber</option>' +
                '<optgroup label="Confirmation"></optgroup>' +
                '<option value="cfa">Model Name Confirmation</option>' +
                '</select>' +
                '</label></div>' +

                '<div class="form-group"><label>Designer: &nbsp;</label>' +
                '<input type="text" name="designer"></div>' +

		        '<p><a href="javascript:void(0)" class="btn btn-sm btn-primary ok-model">OK</a>' +
                '<a href="javascript:void(0)" class="btn btn-sm btn-default cancel-model" data-notify="dismiss">Cancel</a>' +
                '</p>' +
	        '</div>'
    });
}

$(document).on('click', '#ck_all', function () {
        if ($(this).is(":checked")) {
            $('input[name="ck_item[]"]').prop("checked", true);
        } else {
            $('input[name="ck_item[]"]').prop("checked", false);
            models = [];
        }

        getCheckedModels();
    });

$(document).on('click', 'input[name="ck_item[]"]', function () {
    if($(this).is(':checked')){
        $(this).closest('tr').css('background-color', '#cda3db');
    }else{
        $(this).closest('tr').css('background-color','');
        if($('input[name="ck_item[]"]:checked').length==0){
            $('.table tbody tr').css('background-color','');
        }
        
    }
    getCheckedModels();
});

$(document).on('click','.cancel-model', function(){
    disableIssue();
});

function getCheckedModels() {
    models = [];
    $('input[name="ck_item[]"]:checked').each(function () {
        var temp = {
            id: $(this).closest('tr').data('id'),
            model: $(this).closest('tr').data('model'),
            present: $(this).closest('tr').data('present'),
            designer: $(this).closest('tr').data('designer'),
            carkind: $(this).closest('tr').data('carkind'),
            maker: $(this).closest('tr').data('maker'),
            event: $(this).closest('tr').data('event'),
            rnum: $(this).closest('tr').data('rnum'),
        }
        models.push(temp);

        
    });
    console.log(models);

    $(".alert-model-list").empty();
    for(var i=0;i<models.length;i++){
        $(".alert-model-list").append('<li>'+models[i].model+'</li>');
    }

    checkSisterModel();
}

function checkSisterModel(){
    $.each(models, function(i){
        var harness_range = getHarnessRange(i);

        console.log(harness_range);

        $.each($('input[name="ck_item[]"]:not(:checked)'), function(){
            var thisModel = $(this).closest('tr').data('model');
            var thisMaker = $(this).closest('tr').data('maker');
            var a = thisModel.substring(0,thisModel.indexOf('-'));
            if(thisMaker!='A'){
                harness_name = a.substring(2);

                if(harness_range.includes(parseInt(harness_name))){
                    $(this).closest('tr').css('background-color','#f0caca');
                    console.log(harness_name+' is sister');
                }else{
                    $(this).closest('tr').css('background-color','');
                }
            }else{
                a = thisModel.substring(0,thisModel.indexOf('-'));
                if( harness_range.includes(a) ){
                    $(this).closest('tr').css('background-color','#f0caca');
                }else{
                    $(this).closest('tr').css('background-color','');
                }
            }
            
        });
    });
}

function getHarnessRange(i){
    var sisters = [];

    var model_name = models[i].model;
    var maker = models[i].maker;
    var a = model_name.substring(0,model_name.indexOf('-'));
    var harness_name = '';
    if(maker!='A'){
        harness_name = a.substring(2);
        var sister_start = harness_name.substring(0,(harness_name.length-1))+"0";

        for(var i=0;i<10;i++){
            sisters.push(parseInt(sister_start)+i);
        }
    }else{
        harness_name = model_name.substring(0,model_name.indexOf('-'));
        sisters.push(harness_name);
    }

    return sisters;
}

function enableIssue(){
    $('.table thead tr th #ck_all').closest('th').removeClass('hide');
    $('.table tbody tr td input[name="ck_item[]"]').closest('td').removeClass('hide');
    models = [];
    console.log("asdasd");
}

function disableIssue(){
    $('.table thead tr th #ck_all').closest('th').addClass('hide');
    $('.table thead tr th #ck_all').prop("checked", false);
    $('.table tbody tr td input[name="ck_item[]"]').closest('td').addClass('hide');
    $('.table tbody tr td input[name="ck_item[]"]').prop("checked", false);
    $.each($('input[name="ck_item[]"]'), function(){
        $(this).closest('tr').css('background-color','');
    });
    models = [];
}


$(document).on('click','.ok-model', function(){
    var issue_type = $('select[name="issue_type"]').val();
    var designer = $('input[name="designer"]').val();
    var server = 'http://172.25.112.171:2000/issue';
    var scheduler = 'http://172.25.112.171:120/functions/controller.php';

    $.post(scheduler,{
		request: 'getAccountOnPasscode',
		passcode: designer
	}, function(response){
		console.log(response.nickname);
        if(response.nickname != undefined){
            var designer_name = response.nickname.toUpperCase();
            var param = JSON.stringify(models);
            if (models.length != 0) {
                if(designer != ""){
                    if(issue_type!=""){
                        switch(issue_type){
                            case 'ucpa':
                                PopupCenter(server+'/addUCPA.php?data='+param+'&designer='+designer_name, 'Issue Form', '1190', '600');
                            break;
                            case 'c/h':
                                PopupCenter(server+'/addCH.php?data='+param+'&designer='+designer_name, 'Issue Form', '1190', '600');
                            break;
                            case 'np':
                                PopupCenter(server+'/addNP.php?data='+param+'&designer='+designer_name, 'Issue Form', '1190', '600');
                            break;
                            case 'comm':
                                PopupCenter(server+'/addComm.php?data='+param+'&designer='+designer_name, 'Issue Form', '1190', '600');
                            break;
                            case 'trans':
                                PopupCenter(server+'/addTrans.php?data='+param+'&designer='+designer_name, 'Issue Form', '1190', '600');
                            break;
                            case 'sym':
                                PopupCenter(server+'/addSym.php?data='+param+'&designer='+designer_name, 'Issue Form', '1190', '600');
                            break;
                            case 'fig':
                                PopupCenter(server+'/addFig.php?data='+param+'&designer='+designer_name, 'Issue Form', '1190', '600');
                            break;
                            case 'cfa':
                                if(models.length > 1){
                                    alert('Cannot select 2 or more models in this form. \nPls choose only one.');
                                }else{
                                    PopupCenter(server+'/addCF.php?data='+param+'&designer='+designer_name, 'Issue Form', '1190', '600');
                                }
                            break;
                            default:
                
                        }
                        //disableIssue();
                    }else{
                        alert("Pls select a form ");
                    }
                }else{
                    alert("Pls input designer");   
                }
            } else {
                alert("Pls select a model");
            }
        }else{
            alert("Designer code not registered.");
        }
    });

    
});


$(document).on('keyup', 'input[name="designer"]', function(e){
    if (e.keyCode == 13) {
        console.log("enter");
        $('.ok-model').click();
    }
});
