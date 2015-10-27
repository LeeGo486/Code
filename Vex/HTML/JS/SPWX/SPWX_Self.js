$(document).ready(function(){
	initPlugins();
	
})

function initPlugins(){
	//switchButton
	initSwitchBtn();
	//textbox
	initTextBox();
	//hide
	initHide();
	//datebox
	initDateBox();
	//combobox
	initCombobox();
};

function initSwitchBtn(){

	$("#fixPath").switchbutton({
		width:'85',
		onText:'特约维修',
		offText:'驻店维修'
	});
	$("#fixType").switchbutton({
		width:'85',
		onText:'顾客维修',
		offText:'未售维修',
		onChange:function(checked){
			if(checked){
				$("#clientType").switchbutton('enable');
				$("#clientDiv").show();
			}
			else{
				$("#clientType")
					.switchbutton('reset')
					.switchbutton('disable');

				$("#clientDiv").hide();
			};
		}
	});
	$("#clientType").switchbutton({
		onText:'VIP',
		offText:'散客',
		disabled:true,
		onChange:function(checked){
			if(checked){
				$("#vipcode")
					.textbox({required:true,disabled:false,missingMessage:'必填项'})
					.textbox('reset');
				$("#clientPrompt")
					.empty()
					.append('输入顾客卡号后按回车查询');
				$("#SKUPrompt")
					.empty()
					.append('输入款号按回车进行检验')
			}
			else{
				$("#vipcode")
					.textbox({required:false,disabled:true})
					.textbox('reset');
				$("#clientPrompt").empty();
				$("#SKUPrompt").empty();
			};
		}
	});
}

function initTextBox(){
	$("#vipcode").textbox({
		width:'200',
		height:'32',
		disabled:true
	});
	$("#vipname").textbox({
		width:'200',
		height:'32',
		required:true,
		missingMessage:'必填项'
	});
	$("#vipphone").textbox({
		width:'200',
		height:'32',
		required:true,
		missingMessage:'必填项'
	});

	$("#SKU").textbox({
		width:'200',
		height:'32',
		required:true,
		missingMessage:'必填项'
	});

	$("#question").textbox({
		width:'270',
		height:'100',
		required:true,
		missingMessage:'必填项',
		multiline:true
	});
}

function initEvent(){

}

function initHide(){
	$("#clientDiv").hide();
}

function initDateBox(){
	$("#cellDate").datebox({
		width:'200',
		height:'34',
		formatter:function(date){
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			if(m<'10'){
				m = '0'+m;
			};
			var d = date.getDate();
			if(d<'10'){
				d = '0'+d;
			};
			return y+'-'+m+'-'+d;
		},
		parser:function(s){
			var t = Date.parse(s);
			if (!isNaN(t)){
				return new Date(t);
			} else {
				return new Date();
			};
		}
	});
}

function initCombobox(){
	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson([], 'getUrgentLeve');
    $.post(url,function(data){
    	var json = eval("("+data+")");
    	
		$("#urgent").combobox({
			data:json.rows,
			width:'200',
			height:'32',
			panelHeight:'auto',
			valueField:'value',
			textField:'name',
			required:true,
			missingMessage:'必填项'
		});
    });
	

}