
$(document).ready(function(){
	getWXInfo();
	getWXHistory();
	
})


function getWXInfo(){

	var parameter = location.search;
	var wxno = parameter.split('=')[1]; 

	var url = GetWSRRURL("3a9cf88e-fc42-485d-9dff-96c35a8a1750")
			+ "&XML=" + GetFormJson([{ "name": "txtWxno", "value": wxno }], 'GETWXLIST');
	
	$.messager.progress({ title: '请稍后', msg: '正在加载数据' });
	    $.post(url,function(data){
	    	$.messager.progress('close');
	    	var rst = eval("("+data+")");
	    	$("#sku").empty().append(rst.rows[0].sku);
	    	$("#question").empty().append(rst.rows[0].question);
	    	$("#warehouse").empty().append(rst.rows[0].warehousename);
	    	$("#remark").empty().append(rst.rows[0].remark);
	    	$("#wxNo").empty().append(rst.rows[0].wxno);
	    	$("#wxstatus").empty().append(rst.rows[0].wxstname);
	    	$("#danger").empty().append(rst.rows[0].ulname);
	    	if(rst.rows[0].vipid.length == 0){
	    		$("#vipinfo").hide();
	    	}else{
	    		$("#vipinfo").show();
				$("#vipcode").empty().append(rst.rows[0].vipid);
		    	$("#vipname").empty().append(rst.rows[0].vipname);
		    	$("#vipphone").empty().append(rst.rows[0].vipphone);
		    	$("#respname").empty().append(rst.rows[0].respname);
		    	$("#respphone").empty().append(rst.rows[0].respphone);
	    	}
	    		
	    	
	    	$("#collect").empty().append(rst.rows[0].collect);
	    	$("#drname").empty().append(rst.rows[0].drname);
	    	$("#IsFinish").empty().append(rst.rows[0].isfinish);
	    	$("#FinishDate").empty().append(rst.rows[0].finishdate);
	    	$("#DpExpName").empty().append(rst.rows[0].dpexpname+rst.rows[0].dpexpno);
	    	$("#TakeMan").empty().append(rst.rows[0].takeman);
	    	$("#TakePhone").empty().append(rst.rows[0].takemanphone);

	    	if(rst.rows[0].zbexpname.length == 0){
	    		$("#ZBExp").hide();
	    	}
	    	else{
				$("#ZBExp").show();
				$("#ZBExpName").empty().append(rst.rows[0].zbexpname
					+rst.rows[0].zbexpno);
	    	};

	    	$("#SendAddress").empty().append(rst.rows[0].sendaddress);
	    	$("#TakeAddress").empty().append(rst.rows[0].takeaddress);
	    });
}

function getWXHistory(){
	var parameter = location.search;
	var wxno = parameter.split('=')[1]; 

	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson([{"name":"txtWxno","value":wxno}], 'getHistory');
	
	$.messager.progress({ title: '请稍后', msg: '正在加载数据' });
    $.post(url,function(data){
    	$.messager.progress('close');
    	var rst = eval("("+data+")");

    	if(rst.rows[0].result = "True"){
    		$("#flowInfo").empty().append(rst.rows[0].message);
    	};
    });
}