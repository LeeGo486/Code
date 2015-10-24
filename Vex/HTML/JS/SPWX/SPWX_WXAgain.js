
/*
Logic
0.get Wxno
1.ajax get wxinfo
2.ajax get combobox and textbox value
*/
$(document).ready(function(){
	init();
	var param 
		= window.location.href.split('?');
	var wxno 
		= param[1].split('=')[1];

	if(wxno.length != 0)
	{
		getInfo(wxno);
	};
})

function getInfo(wxno){

	var url = GetWSRRURL("3a9cf88e-fc42-485d-9dff-96c35a8a1750")
		+"&XML=" + GetFormJson([{"name":"txtWxno","value":wxno}], 'getWXList');
	
	$.messager.progress({ title: '请稍后', msg: '查询中' });
	$.post(url,function(data){
	    var rst = eval("(" + data + ")");

	    if(rst.rows.length >0){
	    	//维修单号
	    	$("#wxno").empty()
	    		.append(rst.rows[0].wxno);

			//紧急程度
			var urgentColor = "";
			if(rst.rows[0].urgentlevel == "L0"){
				//高
				urgentColor = "<span style=\"background-color:#CC0033; "
					+ " width:10px; height:10px; float:left;"
					+ " margin:6px 10px;\"></span>" 
					+ "<span>高</span>";
			}else if (rst.rows[0].urgentlevel == "L1"){
				//中
				urgentColor = "<span style=\"background-color:#FFCC33; "
					+ " width:10px; height:10px; float:left;"
					+ " margin:6px 10px;\"></span>"
					+ "<span>中</span>";
			}else if (rst.rows[0].urgentlevel == "L2"){
				//低
			    urgentColor = "<span style=\"background-color:#00CC33; "
					+ " width:10px; height:10px; float:left;"
					+ " margin:6px 10px;\"></span>"
					+ "<span>低</span>";
			};

			$("#urgentlevel").empty().append(urgentColor);
			$("#warehouse").empty()
				.append(rst.rows[0].warehousename);
			$("#nature").empty()
				.append(rst.rows[0].wxstname);
			$("#status").empty()
				.append(rst.rows[0].statusname);

			var sku = rst.rows[0].sku;
            $("#sku").empty().append(sku);

            var size = sku.substr(sku.length-1,1);
            var color = sku.substr(sku.length-2,1);

            $("#color").empty().append(color);
            $("#size").empty().append(size);

            $("#question").empty()
            	.append(rst.rows[0].question);

            if(rst.rows[0].remark.length ==0){
            	$("#remark").empty()
            		.append("无备注信息.");
            }
            else{
            	$("#remark").empty()
            		.append(rst.rows[0].remark);
            };

            //判定信息
            $("#dmname").empty()
                	.append(rst.rows[0].dmname);
            $("#drname").empty()
                	.append(rst.rows[0].drname);
            //其他信息
            if(rst.rows[0].ftname.length !=0){
				$("#other").empty()
            		.append(rst.rows[0].ftname);
            };
            if(rst.rows[0].whname.length !=0){
                $("#other").empty()
                	.append("等级:"+rst.rows[0].whname+"退仓单号:"+rst.rows[0].returnno);
            };
            //主要原因
            var fo = rst.rows[0].firstorigin;
            if(fo == 'accClient'){
            	//顾客
				changeStyle("mainQuestion","main0");
				
			}
            else if(fo == 'accOutSide'){
            	//外部
				changeStyle("mainQuestion","main1");
				
            } 
			else if(fo == 'accInSide'){
				//内部
				changeStyle("mainQuestion","main2");
				
            };
            //问题
            getQuestion("mainQuestion",fo);
            //现象
			var url = GetComboxWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750',"", "value", "name") 
    			+ "&XML=" 
    			+ GetFormJson([{"name":"txtFartherVal","value":rst.rows[0].firstqust}],'getQuestion');
        	$("#phenomenon").combobox({
		        required: true,
		        url: url,
		        type: 'post',
		        valueField: 'id',
		        textField: 'text',
		        panelHeight: 'auto',
		        editable: false,
		        onSelect:function(record){
		        	if(record.id >'t11'){
		        		$("#otherInfo").textbox('setValue','').textbox('disable');
		        	}
		        	else{
		        		$("#otherInfo").textbox('setValue','').textbox('enable');
		        	};
		        }
		    });
			    
			if(rst.rows[0].fixlength.length ==0){
            	$("#otherInfo")
            		.textbox('setValue',rst.rows[0].fpname);
            }
            else{
				$("#otherInfo")
            		.textbox('setValue',rst.rows[0].fixlength+"cm");
            }
        	$("#describe").textbox('setValue',rst.rows[0].firstdecide);
        	$("#describe1").textbox('setValue',rst.rows[0].seconddecide);
        	$("#describe2").textbox('setValue',rst.rows[0].thirddecide);

			$("#qstComb")
				.combobox('setValue',rst.rows[0].firstqust);
			$("#phenomenon")
				.combobox('setValue',rst.rows[0].firstphen);

                            
            //次要原因
            if(rst.rows[0].secondorigin.length != 0){
            	 var so = rst.rows[0].secondorigin;
            if(so == 'accClient'){
            	//顾客
				changeStyle("secQuestion","secon0");
				
			}
            else if(so == 'accOutSide'){
            	//外部
				changeStyle("secQuestion","secon1");
				
            } 
			else if(so == 'accInSide'){
				//内部
				changeStyle("secQuestion","secon2");
				
            };
            //问题
            getQuestion("secQuestion",so);
            //现象
			var url = GetComboxWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750',"", "value", "name") 
    			+ "&XML=" 
    			+ GetFormJson([{"name":"txtFartherVal","value":rst.rows[0].secondqust}],'getQuestion');
			$("#secphenomenon").combobox({
		        required: true,
		        url: url,
		        type: 'post',
		        valueField: 'id',
		        textField: 'text',
		        panelHeight: 'auto',
		        editable: false,
		        onSelect:function(record){
		        	if(record.id >'t11'){
		        		$("#secOtherInfo").textbox('setValue','').textbox('disable');
		        	}
		        	else{
		        		$("#secOtherInfo").textbox('setValue','').textbox('enable');
		        	};
		        }
		    });
			    
			if(rst.rows[0].fixlength.length ==0){
            	$("#secOtherInfo")
            		.textbox('setValue',rst.rows[0].fpname);
            }
            else{
				$("#secOtherInfo")
            		.textbox('setValue',rst.rows[0].fixlength+"cm");
            };
        	
			$("#secqstComb")
				.combobox('setValue',rst.rows[0].secondqust);
			$("#secphenomenon")
				.combobox('setValue',rst.rows[0].secondphen);
            };

            $("#dmname").empty()
            	.append(rst.rows[0].dmname);
            $("#drname").empty()
            	.append(rst.rows[0].drname);
            //其他信息
            if(rst.rows[0].ftname.length !=0){
				$("#other").empty()
            		.append(rst.rows[0].ftname);
            };
            if(rst.rows[0].whname.length !=0){
                $("#other").empty()
                	.append("等级:"+rst.rows[0].whname+"退仓单号:"+rst.rows[0].returnno);
            };
            if(rst.rows[0].suppliername.length !=0){
            	$("#other").empty()
                	.append("供应商:"+rst.rows[0].suppliername);
            };

            //完成信息
            if(rst.rows[0].isfinish.length == 0){
                    $("#finDiv").hide();
            }
            else{
                $("#finDiv").show();
                $("#finPnt").empty().append(rst.rows[0].finpntname);
                $("#finMan").empty().append(rst.rows[0].finmanname);
                $("#finDate").empty().append(rst.rows[0].finishdate);
                $("#finMon").empty().append(rst.rows[0].finishmoney);
                $("#isFin").empty().append(rst.rows[0].isfinish);
            };

            $("#dpname").empty()
            	.append(rst.rows[0].depotname + '-'+rst.rows[0].depotphone);
            $("#staff").empty()
            	.append(rst.rows[0].respname + '-'+rst.rows[0].respphone);

            $("#resp").empty()
            	.append(rst.rows[0].staffname + '-'+rst.rows[0].staffphone);

            $("#vipname").empty().append(rst.rows[0].vipname);
            $("#vipphone").empty().append(rst.rows[0].vipphone);
            $("#cost").empty().append(rst.rows[0].collect);
		
			var urlSup = GetWSRRURL("3a9cf88e-fc42-485d-9dff-96c35a8a1750")
				+"&XML=" 
				+ GetFormJson([{"name":"txtSKU","value":sku}], 'getSupplier');
            $.post(urlSup,function(data){
            	$.messager.progress('close');
	
				var rstSup = eval("(" + data + ")");

	    		//供应商加载数据
		    	$("#supplier").combobox({
		    	    data: rstSup.rows,
		    	    type: 'post',
		    	    editable: false,
		    	    valueField: 'supplierid',
		    	    textField: 'shutname',
		    	    panelHeight: 'auto'
		    	}).combobox('setValue',rst.rows[0].supplierid);
            });
	    };
	});
}

function init(){
	initTextBox();
	initAcc();
	initCombobox();
	initLinkButton();
}

function initCombobox(){
	$("#qstComb").combobox({
		required:true,
        editable:false
	});
	$("#phenomenon").combobox({
		required:true,
        editable:false
	});
	$("#supplier").combobox({
		required:true,
        editable:false
	});
}

function initLinkButton(){
	$("#submit").linkbutton({
		iconCls: 'icon-save',
		plain:true,
		text:'提交',
		onClick:function(){
			submit();
		}
	});
}

function initTextBox(){
	$("#describe").textbox({
		required:true,
		width:350,
		height:60,
		multiline:true,
		type:'text',
		prompt:'请输入描述信息'
	}).textbox('setValue',"");

	$("#describe1").textbox({
		required:false,
		width:350,
		height:60,
		multiline:true,
		type:'text',
		prompt:'请输入描述信息'
	}).textbox('setValue',"");
	$("#describe2").textbox({
		required:false,
		width:350,
		height:60,
		multiline:true,
		type:'text',
		prompt:'请输入描述信息'
	}).textbox('setValue',"");

	$("#otherInfo").textbox({
		required:false,
		prompt:'可输入长度或维修点'
	}).textbox('setValue','');

	$("#secOtherInfo").textbox({
		required:false,
		prompt:'可输入长度或维修点'
	}).textbox('setValue','');
}


/*
	logic：
	1.onclick: 初始化问题，
		改变样式，并且把所有combobox全部置空。
		把otherInfo set disabled.
*/
function initAcc(){
	$("#main0").unbind('click')
		.bind('click',function(e){
			getQuestion("mainQuestion","accClient");
			changeStyle("mainQuestion","main0");

			$("#otherInfo")
				.textbox('setValue','')
				.textbox('disable');
			$("#phenomenon")
				.combobox('setValue','')
				.combobox('loadData',[]);

			$("#day").empty();
			$("#money").empty();
		});
	$("#main1").unbind('click')
		.bind('click',function(){
			getQuestion("mainQuestion","accOutSide");
			changeStyle("mainQuestion","main1");

			$("#otherInfo")
				.textbox('setValue','')
				.textbox('disable');
			$("#phenomenon")
				.combobox('setValue','')
				.combobox('loadData',[]);

			$("#day").empty();
			$("#money").empty();
		});
	$("#main2").unbind('click')
		.bind('click',function(){
			getQuestion("mainQuestion","accInSide");
			changeStyle("mainQuestion","main2");

			$("#otherInfo")
				.textbox('setValue','')
				.textbox('disable');
			$("#phenomenon")
				.combobox('setValue','')
				.combobox('loadData',[]);

			$("#day").empty();
			$("#money").empty();
		});

	$("#secon0").unbind('click')
		.bind('click',function(){
			getQuestion("secQuestion","accClient");
			changeStyle("secQuestion","secon0");

			$("#secOtherInfo")
				.textbox('setValue','')
				.textbox('disable');
			$("#secphenomenon")
				.combobox('setValue','')
				.combobox('loadData',[]);
		});
	$("#secon1").unbind('click')
		.bind('click',function(){
			getQuestion("secQuestion","accOutSide");
			changeStyle("secQuestion","secon1");

			$("#secOtherInfo")
					.textbox('setValue','')
					.textbox('disable');
			$("#secphenomenon")
					.combobox('setValue','')
					.combobox('loadData',[]);
		});
	$("#secon2").unbind('click')
		.bind('click',function(){
			getQuestion("secQuestion","accInSide");
			changeStyle("secQuestion","secon2");

			$("#secOtherInfo")
					.textbox('setValue','')
					.textbox('disable');
			$("#secphenomenon")
					.combobox('setValue','')
					.combobox('loadData',[]);
		});
}

/*
逻辑：
1.改变样式
2.改变判断选项
*/
function initRst(){
	$("#dec0").unbind('click')
		.bind('click',function(){
			changeStyle("rst","dec0");
		$("#otherInfo").textbox('setValue','').textbox('disable');
	});
	$("#dec1").unbind('click')
		.bind('click',function(){
			changeStyle("rst","dec1");
		$("#otherInfo").textbox('setValue','').textbox('disable');
	});
	$("#dec2").unbind('click')
		.bind('click',function(){
			changeStyle("rst","dec2");
		$("#otherInfo").textbox('setValue','').textbox('disable');
	});
}
// 获取问题下拉值
function getQuestion(area,value){

	if(area == "mainQuestion"){
		$('#qstComb').combobox({
	        required: true,
	        url: GetComboxWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750',
	        	"", "value", "name") + "&XML=" 
	        	+ GetFormJson([{"name":"txtFartherVal","value":value}],'getQuestion'), 
	        type: 'post',
	        editable: false,
	        valueField: 'id',
	        textField: 'text',
	        panelHeight: 'auto',
	        onLoadSuccess:function(){
	        	
				$("#day").empty();
				$("#money").empty();
	        },
	        onSelect:function(record){
	        	$("#otherInfo").textbox('setValue','').textbox('disable');

	        	var url = GetComboxWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750',"", "value", "name") 
	        			+ "&XML=" + GetFormJson([{"name":"txtFartherVal","value":record.id}],'getQuestion');
	        	$("#phenomenon").combobox({
			        required: true,
			        url: url,
			        type: 'post',
			        editable: false,
			        valueField: 'id',
			        textField: 'text',
			        panelHeight: 'auto',
			        onLoadSuccess:function(){
			        	$("#phenomenon").combobox('enable');
			        	$("#day").empty();
						$("#money").empty();
			        },
			        onSelect:function(record){
			        	if(record.id == 't11'
			        		||record.id == 't12'
			        		||record.id == 't13'
			        		||record.id == 't14'
			        		||record.id == 't15'){
			        		$("#otherInfo").textbox('setValue','').textbox('disable');
			        	}
			        	else{
			        		$("#otherInfo").textbox('setValue','').textbox('enable');
			        	}

			        	getDayMoney(record.id);
			        }
			    });
			}
		});
	}else{
		$('#secqstComb').combobox({
	        required: true,
	        url: GetComboxWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750',"", "value", "name") 
	        	+ "&XML=" + GetFormJson([{"name":"txtFartherVal","value":value}],'getQuestion'), 
	        type: 'post',
	        editable: false,
	        valueField: 'id',
	        textField: 'text',
	        panelHeight: 'auto',
	        onSelect:function(record){
	        	var url = GetComboxWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750',"", "value", "name") 
	        			+ "&XML=" + GetFormJson([{"name":"txtFartherVal","value":record.id}],'getQuestion');
	        	$("#secphenomenon").combobox({
			        required: true,
			        url: url,
			        type: 'post',
			        editable: false,
			        valueField: 'id',
			        textField: 'text',
			        panelHeight: 'auto',
			        onLoadSuccess:function(){
			        	$("#secphenomenon").combobox('clear').combobox('enable');
			        },
			        onSelect:function(record){
			        	if(record.id == 't11'
			        		||record.id == 't12'
			        		||record.id == 't13'
			        		||record.id == 't14'
			        		||record.id == 't15'){
			        		$("#secOtherInfo").textbox('setValue','').textbox('disable');
			        	}
			        	else{
			        		$("#secOtherInfo").textbox('setValue','').textbox('enable');
			        	};
			        }
			    });
			}
		});
	};
}

//变更样式
function changeStyle(area,id){
	var tag = area + " a";

	$("#"+tag).each(function(){
		if(this.id == id){
			$("#" + this.id).attr("class","marginR30 isNature");
		}
		else{
			$("#" + this.id).attr("class","marginR30 nature");
		};
	});
}

function getDayMoney(secph){

	var dataXML = [{"name":"txtSecph","value":secph}];

	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson(dataXML, 'GetDayMoney');

	$.post(url, function (data) {
	    var rst = eval("(" + data + ")");

	    if (rst.rows[0].day.length > 0) {
	        $("#day").empty().append("需要" + rst.rows[0].day + "天维修,");
	        $("#money").empty().append("费用区间为" + rst.rows[0].money + "元");
	    };
	});
}


function submit(){
	var data = [];

	data.push({"name":"txtWXNo","value":$("#wxno").text()});
	
	var len = data.length;
		eachCss(data,"mainQuestion");
	var newLen = data.length;

    if (len == newLen){
    	$.messager.alert("警告","请选择破损原因","warning");
    	return;
    };

    //检验主要问题必填项
	if (!isVaild("formMainQst", "主要问题")) {
	   return;
	};

	data.push({"name":"txtFirstQust","value":$("#qstComb").combobox('getValue')});
	data.push({"name":"txtFirstPhen","value":$("#phenomenon").combobox('getValue')});
	data.push({"name":"txtFirstDecide","value":$("#describe").textbox('getValue')});
	data.push({"name":"txtSecondDecide","value":$("#describe1").textbox('getValue')});
	data.push({"name":"txtThirdDecide","value":$("#describe2").textbox('getValue')});
	data.push({"name":"txtSupplierId","value":$("#supplier").combobox('getValue')});
	data.push({"name":"txtSupplierName","value":$("#supplier").combobox('getText')});
	data.push({"name": "txtFixLength", "value": $("#otherInfo").textbox('getValue')});
	
	//次要问题
	var len = data.length;
		eachCss(data,"secQuestion");
	var newLen = data.length;

	if(newLen > len ){//true 代表有选择次要问题

		if (!isVaild("formSecQst","次要问题信息")) {
				return;
		};

		data.push({"name":"txtSecondQust","value":$("#secqstComb").combobox('getValue')});
		data.push({"name": "txtSecondPhen", "value": $("#secphenomenon").combobox('getValue')});
		data.push({"name": "txtSecFixLen", "value": $("#secOtherInfo").textbox('getValue')});

	};

	//return;

	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + escape(GetFormJson(data, 'updateFix'));

    $.messager.progress({ title: '请稍后', msg: '保存中' });
    
    $.post(url,function(data){
    	$.messager.progress('close');
    	
    	var rst = eval("("+data+")");

        if (rst.Error) {
            
            $.messager.alert("系统错误", rst.Error, 'error');
        }
        else if (rst.rows[0].result == "False") {
          
            $.messager.alert("错误", rst.rows[0].message, 'error');
        }
        else {
            $.messager.alert("提示",rst.rows[0].message, 'ok');
           	window.parent.$("#mainTabs").tabs('close','维修单再判定');
        };
    });
}

function isVaild(formName, msg) {

    var isVaild 
        = $('#'+ formName).form('validate');

    if (!isVaild) {
        alert("请将" + msg + "填写完整");
        return false;
    } else {
        return true;
    };

}


function eachJson(data, jsonObj) {

    for (var o in jsonObj) {
        data.push(
            {"name":jsonObj[o].name
            ,"value":jsonObj[o].value}
        );
    };
    return data;
}

function eachCss(data,idName){
		//根据css的变化来取值
    var cause = $("#"+idName).children();
    $.each(cause, function () {
    	if($.trim(this.className) == "marginR30 isNature"){
    		var id = this.id;
    		switch(id){
    			case "main0":
    				data.push({"name":"txtFirstOrigin","value":"accClient"});
    				break;
    			case "main1":
    				data.push({"name":"txtFirstOrigin","value":"accOutSide"});
    				break;
    			case "main2":
    				data.push({"name":"txtFirstOrigin","value":"accInSide"});
    				break;
    			case "secon0":
    				data.push({"name":"txtSecondOrigin","value":"accClient"});
    				break;
    			case "secon1":
    				data.push({"name":"txtSecondOrigin","value":"accOutSide"});
    				break;
    			case "secon2":
    				data.push({"name":"txtSecondOrigin","value":"accInSide"});
    				break;
    			case "dec0":
    				data.push({"name":"txtDecideRst","value":"rst0"});
    				break;
    			case "dec1":
    				data.push({"name":"txtDecideRst","value":"rst1"});
    				break;
    			case "dec2":
    				data.push({"name":"txtDecideRst","value":"rst2"});
    				break;
    		};
    	};
    });
}


function getDayMoney(secph){

	var dataXML = [{"name":"txtSecph","value":secph}];

	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson(dataXML, 'GetDayMoney');

	$.post(url, function (data) {
	    var rst = eval("(" + data + ")");

	    if (rst.rows[0].day.length > 0) {
	        $("#day").empty().append("需要" + rst.rows[0].day + "天维修,");
	        $("#money").empty().append("费用区间为" + rst.rows[0].money + "元");
	    };
	});


		
}