var m_checked;

$(document).ready(function(){

    soundReady();

	initScan();

    initSwitch();
	
    initkeyDown();
	$("#scan").focus();
});


function initScan(){

	$("#scan").textbox({
		width:300,
		height:40,
		iconCls:'icon-search',
		iconAlign:'left',
		prompt:"请稍描快递单号",
		type:"text"
	}).textbox('clear');

	
}

function initkeyDown(){
    $("#scan").textbox('textbox')
        .bind('keydown', function(e){
            if (e.keyCode == 13){   
                // when press ENTER key,get Express No.
                var scanNo 
                    = $("#scan").textbox('getValue');
                checkExpNo(scanNo)
            };
    }).focus();
}

function soundReady() {

    soundManager.url = 'swf';

    soundManager.onload = function () {
        m_soundRight = soundManager.createSound({
            id: 'right',
            url: '../../resource/Sound/right.wav',
            autoPlay: false
        });
        m_soundWrong = soundManager.createSound({
            id: 'wrong',
            url: '../../resource/Sound/wrong.wav',
            autoPlay: false,
            onfinish: function () {
            }
        });
    };
}

function checkExpNo(scanNo){
    var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750');
    
    if(m_checked){
        url += "&XML=" + GetFormJson([{"name":"txtWxNo","value":scanNo}], 'checkExpNo');
    }else{
        url += "&XML=" + GetFormJson([{"name":"txtExpNo","value":scanNo}], 'checkExpNo');
    };

    $.post(url,function(data){
    	
    	var result = eval("("+data+")");

    	if (result.Error) {
    		$("#scan").textbox('setValue','');
    	}
    	else if (result.rows[0].result == "False") {
            soundManager.play('wrong');
            $("#scan").textbox('reset');
            $("#scan").focus();
            if(m_checked){
                $("#result").empty().append("无此维修单号！");
            }else{
                $("#result").empty().append("无此快递单号！");
            };
        }
        else {
           	soundManager.play('right');
           	$("#scan").textbox('reset');
           	$("#scan").focus();
            if(m_checked){
           	    $("#result").empty().append("维修单已签收！");
            }else{
                $("#result").empty().append("快递已签收！");
            }
        };
    });
}

function initSwitch(){
    $("#switch").switchbutton({
        width:'80',
        onText:'维修单',
        offText:'快递单',
        onChange:function(checked){
            m_checked = checked;

            if(checked){
                $("#scan").textbox({
                    prompt:"请稍描维修单号",
                    value:''
                }).textbox('reset');
                initkeyDown();
                $("#scan").focus();
            }else{
                $("#scan").textbox({
                    prompt:"请稍描快递单号",
                    value:''
                }).textbox('reset');
                initkeyDown();
                $("#scan").focus();
            };
        }
    })
}