
$(document).ready(function(){

	//插件初始化
	initPlugin();
	
})


function initPlugin()
{
	//tabs
    $("#List").tabs({
		title:'维修列表',
		
		closable:false,
		// pill:true,
		fit:true,
		onClose:function(title,index){
			if(title == "00成衣维修登记"){
				$("#tab_list").datagrid("reload");
			}
		}
	});

	
	//button
	$("#applyCom").linkbutton({
		width:120,
		height:30,
		iconAlign:"left",
		onClick:function(){
			addComTabs();
		}
	})

	$("#applySelf").linkbutton({
		width:120,
		height:30,
		iconAlign:"left",
		onClick:function(){
			addSelfTabs();
		}
	})

	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
                + "&XML=" + GetFormJson([], 'getDataGrid');
	//dataGrid
	initDataGrid(url);
}

function initDataGrid(url)
{

	$("#tab_list").datagrid({
	    // url:GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750'),
	    // queryParams: { "XML": GetGetJson([], 'getDataGrid') },
	    url:url,
        singleSelect: true,
        fit:false,
        columns: [[
            { field: 'wxno', title: '维修单号', width: 100 },
            { field: 'wxstname', title: '维修单类型', width: 100 },
            { field: 'statusname', title: '维修单状态', width: 75 },
            { field: 'respname', title: '店长姓名', width: 100 },
            { field: 'respphone', title: '店长电话', width: 100 },
            { field: 'staffname', title: '受理导购', width: 100 },
            { field: 'staffphone', title: '导购电话', width: 100 },
            { field: 'sku', title: '维修款号', width: 100 },
            { field: 'backdate', title: '退回日期', width: 100 },
            { field: 'question', title: '问题描述', width: 200 }
        ]],
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        onClickRow:function(index,row){
        	if(row.wxstname == "未售维修"){
        		$("#printClient").linkbutton('disable')
        	}
        	else if (row.wxstname == "客户维修"){
        		$("#printClient").linkbutton('enable')
        	}
        },
        onDblClickRow: function(index,row){
            var wxno = row.wxno;
            //跳转页面
            lookoverWX(wxno);
        }
	    });
	    $('#ss').searchbox({
	    	width:200,
	    	prompt:'请输入维修单号或款号',
	    	searcher:function(value,name){
	    		searchWX(value);
	    	}

	    });
	    $("#printDP").linkbutton({
	    	iconCls: 'icon-print',
	    	text:'店铺打印',
	    	plain:true,
	    	onClick:function(){
	    		printWX("DP");
	    	}
	    });
	    $("#printClient").linkbutton({
	    	iconCls: 'icon-print',
	    	text:'顾客打印',
	    	plain:true,
	    	onClick:function(){
	    		printWX("Client");
	    	}
	    });
		//获取生成的搜索框
		var a=$("#testa");
		$(".datagrid-toolbar").append(a);
}

function addComTabs()
{
	var url = "../../WEB/SPWX/SPWX_Apply.html";

	var content = "<iframe id=\"newWx\" scrolling=\"auto\" frameborder=\"0\" src=\""+url+"\"";
	content += " style=\"width:100%;height:95%\"></iframe>";

	window.parent.$('#mainTabs').tabs('add', {
       	title: '总部维修登记',
        content: content,
        iconCls: 'icon-add',
        closable: true
    });     
}


function addSelfTabs(){
	var url = "../../WEB/SPWX/SPWX_Self.html";

	var content = "<iframe id=\"newWx\" scrolling=\"auto\" frameborder=\"0\" src=\""+url+"\"";
	content += " style=\"width:100%;height:95%\"></iframe>";

	window.parent.$('#mainTabs').tabs('add', {
       	title: '本地维修登记',
        content: content,
        iconCls: 'icon-edit',
        closable: true
    });    
}

function lookoverWX(wxno) {
    var url = "../../WEB/SPWX/SPWX_Lookover.html?wxno=" + wxno;

    var content = "<iframe scrolling=\"auto\" frameborder=\"0\" src=\""+url+"\"";
	content += " style=\"width:100%;height:95%\"></iframe>";

	window.parent.$("#mainTabs").tabs('add', {
		title: '成衣维修明细',
        content: content,
        iconCls: 'icon-search',
        closable: true
	});
}

function printWX(Type){
	var printData 
		= $("#tab_list").datagrid("getSelected");

	if (printData == null){
		alert("请在列表中，选择维修单！");
		return;
	};

	if(Type == "DP"){
		DPPrint(printData);
	}
	else if (Type == "Client"){
		ClientPrint(printData);
	}
	
}

function searchWX(value){

	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson([{"name":"txtScreen","value":value}], 'screenDataGrid');

	initDataGrid(url);
}


function DPPrint(data) {
   

    //-----------------Print Start----------------
    LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
    LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");

    	//纸张设置
		LODOP.PRINT_INITA("0mm","0mm","210.1mm","147.9mm","");
		LODOP.SET_PRINT_PAGESIZE(1,2100,1480,"A4");
		//背景设置
		LODOP.ADD_PRINT_SETUP_BKIMG("E:\\Work\\Code\\Vex\\HTML\\image\\SPWX\\wswx.png");
		LODOP.SET_SHOW_MODE("BKIMG_LEFT",1);
		LODOP.SET_SHOW_MODE("BKIMG_TOP",1);
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",721);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",397);
		LODOP.SET_SHOW_MODE("BKIMG_PRINT",true);
		//店铺设置
		LODOP.ADD_PRINT_TEXT("22.5mm","38.4mm","56.1mm","5.6mm",data.depotarea);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("30.2mm","60.6mm","35.2mm","5.3mm",data.depotname);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("37mm","60.9mm","34.7mm","5.3mm",data.respname);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("44.2mm","60.9mm","34.7mm","5.3mm",data.depotphone);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
		LODOP.ADD_PRINT_TEXT("51.1mm","61.1mm","34.7mm","5.3mm",data.staffname);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("58.2mm","61.1mm","34.1mm","5.3mm",data.staffphone);
		//客户设置
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("29.4mm","150mm","35.7mm","5mm",data.wxstname);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("36.5mm","149.8mm","35.5mm","5mm",data.vipname);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("43.7mm","149.8mm","35.7mm","6.4mm",data.vipphone);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("51.3mm","150mm","33.9mm","5mm",data.vipid);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		if(data.collect =="yes"){
			LODOP.ADD_PRINT_TEXT("57.9mm","150.5mm","32.5mm","5mm","是");
		}
		else if (data.collect == "no")
		{
			LODOP.ADD_PRINT_TEXT("57.9mm","150.5mm","32.5mm","5mm","否");
		}
		else{
			LODOP.ADD_PRINT_TEXT("57.9mm","150.5mm","32.5mm","5mm",data.collect);
		}
		
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		//款式信息
		LODOP.ADD_PRINT_TEXT("83.1mm","9mm","49.2mm","5.3mm",data.sku);
		LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
		;
		var size = data.sku.substr(data.sku.length - 1, 1);
		var color = data.sku.substr(data.sku.length - 2, 1);
		var regex = /^[A-Za-z]+$/;
		if (!color.match(regex)) {
			color = data.sku.substr(data.sku.length - 3, 1);
		};
		LODOP.ADD_PRINT_TEXT("83.3mm", "65.6mm", "7.7mm", "5mm", color);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("83.6mm", "84.7mm", "7.9mm", "5mm", size);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("83.3mm","99.2mm","24.1mm","5mm",data.selldate);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("83.3mm","124.6mm","62.2mm","6.9mm",data.question);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",8);
		//物流信息
		LODOP.ADD_PRINT_TEXT("90.8mm","64.8mm","28.3mm","4.8mm",data.expressname);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("90.8mm","128.6mm","41mm","6.4mm",data.expressno);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
		LODOP.ADD_PRINT_TEXT("98.4mm","65.4mm","120.9mm","6.4mm",data.sendaddress);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",10);

		LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
		LODOP.ADD_PRINT_BARCODE(40,21,100,37,"",data.wxno);

		LODOP.ADD_PRINT_TEXT(405,467,100,25,"店长签字：");
		LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
		LODOP.ADD_PRINT_TEXT(403,17,183,25,"备注：将此单与衣物一起寄出 ");
		LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
		LODOP.SET_PRINT_STYLEA(0,"FontColor","#FF0000");
		LODOP.ADD_PRINT_TEXT(441,467,100,26,"退回日期：");
		LODOP.SET_PRINT_STYLEA(0,"FontSize",10);


    LODOP.PREVIEW();    //浏览模式
    //LODOP.PRINT_DESIGN();//设计模式
    //-----------------Print End--------------------
};

function ClientPrint(data){
 
 //-----------------Print Start----------------
    LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
    LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");



	//纸张设置
	LODOP.PRINT_INITA("0mm","0mm","210.1mm","147.9mm","");
	LODOP.SET_PRINT_PAGESIZE(1,2100,1480,"A4");
	//背景设置
	LODOP.ADD_PRINT_SETUP_BKIMG("..//..//image//SPWX//client.png");
	LODOP.SET_SHOW_MODE("BKIMG_WIDTH",767);
	LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",347);
	LODOP.SET_SHOW_MODE("BKIMG_PRINT",true);
	//条码
	LODOP.ADD_PRINT_BARCODE(41,8,113,36,"",data.wxno);
	//款式信息
	LODOP.ADD_PRINT_TEXT(87,151,100,20,data.depotarea);
	LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
	LODOP.ADD_PRINT_TEXT(140,8,131,20,data.sku);
	LODOP.SET_PRINT_STYLEA(0, "FontSize", 10);
	var size = data.sku.substr(data.sku.length - 1, 1);
	var color = data.sku.substr(data.sku.length - 2, 1);
	var regex = /^[A-Za-z]+$/;
	if (!color.match(regex)) {
		color = data.sku.substr(data.sku.length - 3, 1);
	};
	LODOP.ADD_PRINT_TEXT(141, 143, 100, 20, color);
	LODOP.ADD_PRINT_TEXT(140, 253, 100, 20, size);
	LODOP.ADD_PRINT_TEXT(140,402,100,20,data.selldate);
	LODOP.ADD_PRINT_TEXT(135,516,284,25,data.question);

	//店铺信息
	LODOP.ADD_PRINT_TEXT(166,254,136,20,data.depotname);
	LODOP.ADD_PRINT_TEXT(191,254,136,20,data.respname);
	LODOP.ADD_PRINT_TEXT(219,253,136,20,data.staffphone);
	LODOP.ADD_PRINT_TEXT(245,253,136,20,data.staffname);
	//顾客信息
	LODOP.ADD_PRINT_TEXT(169,617,136,20,data.wxstname);
	LODOP.ADD_PRINT_TEXT(192,617,136,20,data.vipphone);
	LODOP.ADD_PRINT_TEXT(220,617,136,20,data.vipid);
	if(data.collect =="yes"){
		LODOP.ADD_PRINT_TEXT("65.1mm","163.2mm","32.5mm","5mm","是");
	}
	else if (data.collect == "no")
	{
		LODOP.ADD_PRINT_TEXT("65.1mm","163.2mm","32.5mm","5mm","否");
	}
	else{
		LODOP.ADD_PRINT_TEXT("65.1mm","163.2mm","32.5mm","5mm",data.collect);
	}

    LODOP.PREVIEW();    //浏览模式
   	//LODOP.PRINT_DESIGN();//设计模式
    //-----------------Print End--------------------

}