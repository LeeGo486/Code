

$(document).ready(function(){

    soundReady();

	initScan();
	
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
	});

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
	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson([{"name":"txtExpNo","value":scanNo}], 'checkExpNo');

    $.post(url,function(data){
    	
    	var result = eval("("+data+")");

    	if (result.Error) {
    		$("#scan").textbox('setValue','');
    	}
    	else if (result.rows[0].result == "False") {

    		soundManager.play('wrong');
            $("#scan").textbox('reset');
            $("#scan").focus();
            $("#result").empty().append("无此快递单号！");
        }
        else {
            
           	soundManager.play('right');
           	$("#scan").textbox('reset');
           	$("#scan").focus();
           	$("#result").empty().append("快递已签收！");
        };
    });
}