<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>市场活动审批</title>
    <script type="text/javascript" src="./js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="./js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="./js/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="./css/common.css" type="text/css"></link>
  	<link rel="stylesheet" href="./dataTables/css/jquery.dataTables.css" type="text/css"></link>
  	<link rel="stylesheet" href="./jquery-ui/jquery.ui.all.css" type="text/css"></link>
  	<script type="text/javascript">
  		var oTable,pTable;
  		var xmlHttp1,xmlHttp2,xmlHttp3,xmlHttp4,xmlHttp5,xmlHttp6,xmlHttp7,xmlHttp8,xmlHttp9,xmlHttp10;
  		var id,type,detail,depot,supervisor,begin,end;
  		
  		$(document).ready(function(){
  			oTable = $("#listData").dataTable({
				"bFilter": false,
				"bSort": true,
				"bAutoWidth": true,
				"bLengthChange": false,
				"bInfo": false,
				"bProcessing": true,
				"bScrollInfinite": true,
				"sScrollY": "320px",
		        "sScrollX": "1800px",
		        "oLanguage": {
			      "sEmptyTable": "没有记录"
			    }
			});
			
			pTable = $("#productData").dataTable({
				"bFilter": false,
				"bSort": true,
				"bAutoWidth": true,
				"bLengthChange": false,
				"bInfo": false,
				"bProcessing": true,
				"bScrollInfinite": true,
				"sScrollY": "220px",
		        "sScrollX": "840px",
		        "oLanguage": {
			      "sEmptyTable": "没有记录"
			    }
			});
			
			$("#s_button").button();
			
			$("#dialog").dialog({
				autoOpen: false,
				resizable: false,
				width:350,
				height:180,
				modal: true,
				buttons: {
					"提交": function() {
						var cmpg_id = "";
						var num = 0;
						
						if ($("#dialog input:checked").length==0)
							alert("请选择审批状态");
						else
						{
							$(this).dialog("close");
							num = $("#listData input:checked:visible").length;
							$("#listData input:checked:visible").each(function(i){
								$(this).parent().parent().hide();
								if (i != num-1)
									cmpg_id = cmpg_id + $(this).parent().parent().find(".a_id").text() + ",";
								else
									cmpg_id = cmpg_id + $(this).parent().parent().find(".a_id").text();
							});
							doCheck(cmpg_id,$("#dialog input:checked").val());
						}
					},
					"取消": function() {
						$(this).dialog("close");
					}
				}
			});
			
  			getManage();
  			getYear();
  			getType();
  			//getFlag();
  			if ($("#search div select#s_flag").val() == 1) {
				getStage();
			}
  			getList("","","","",1,"","","","");
  			
			$("#s_begin").datepicker();
			$("#s_end").datepicker();
			
			$("#search div #s_depot").autocomplete({
			    source: function(request, response) {
			        $.ajax({
			            url: "AjaxServlet",
			            dataType: "json",
			            data: {
			                action: "getDepot",
			                dept: $("#search div #s_depot").val()
			            },
			            success: function(data) {
			            	response( $.map( data.Depot, function( item ) {
								return {
									label: item.Value,
									value: item.Value
								}
							}));
			            }
			        });
			    }
			});						
		});
		
		function createXMLHttpRequest() {
			if (window.ActiveXObject) {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} else if (window.XMLHttpRequest) {
				xmlHttp = new XMLHttpRequest();
			}
			return xmlHttp;
		}
		
		function getManage() {			
			xmlHttp1 = createXMLHttpRequest();
			xmlHttp1.onreadystatechange = getManageProcessor;
			xmlHttp1.open("GET","AjaxServlet?action=getManage&tm="+new Date().toString());
			xmlHttp1.send(null);
		}
		
		function getManageProcessor() {
			if (xmlHttp1.readyState == 4) {
				if (xmlHttp1.status == 200) {
					var obj = eval('('+xmlHttp1.responseText+')');
					
					if (obj['1'] == null)
						$("#manageType .m_type#1").text("待审批的活动(0)");
					else
						$("#manageType .m_type#1").text("待审批的活动("+obj['1']+")");
						
					if (obj['2'] == null && obj['4'] == null)
						$("#manageType .m_type#4").text("已审批的活动(0)");
					else if (obj['2'] == null)
						$("#manageType .m_type#4").text("已审批的活动("+(obj['4'])+")");
					else if (obj['4'] == null)
						$("#manageType .m_type#4").text("已审批的活动("+(obj['2'])+")");
					else
						$("#manageType .m_type#4").text("已审批的活动("+(obj['2']+obj['4'])+")");
						
					if (obj['0'] == null)
						$("#manageType .m_type#0").text("未提交的活动(0)");
					else
						$("#manageType .m_type#0").text("未提交的活动("+obj['0']+")");
				}
			}
		}
		
		function getList(year,type,detail,stage,flag,subFlag,begin,name,depot,end) {			
			xmlHttp2 = createXMLHttpRequest();
			xmlHttp2.onreadystatechange = getListProcessor;
			xmlHttp2.open("GET","AjaxServlet?action=getList&year="+year+"&type="+type+"&detail="+detail+"&stage="+stage+"&flag="+flag+"&subFlag="+subFlag+"&begin="+begin+"&end="+end+"&name="+name+"&depot="+depot+"&tm="+new Date().toString());
			xmlHttp2.send(null);
		}
		
		function getListProcessor() {
			var html = "";
			if (xmlHttp2.readyState == 4) {
				if (xmlHttp2.status == 200) {
					oTable.fnDestroy();
					var obj = eval('('+xmlHttp2.responseText+')');
					
					for (var i = 0;i < obj.List.length;i++) {
						html = html + "<tr>";
						html = html + "<td class='sel'>";
						if (obj.List[i].ISPASSED == "null" || obj.List[i].ISPASSED == "")
							html = html + "<input type='checkbox'>";
						html = html + "</td>";
						html = html + "<td class='a_name'>"+obj.List[i].CMPGNAME+"</td>";
						html = html + "<td class='dq'>"+obj.List[i].DQ+"</td>";
						html = html + "<td class='d_name'>"+obj.List[i].DEPOT+"</td>";
						html = html + "<td class='m_supervisor'>"+obj.List[i].DD+"</td>";
						html = html + "<td class='a_type'>"+obj.List[i].TYPE+"</td>";
						html = html + "<td class='a_detail'>"+obj.List[i].DETAIL+"</td>";
						html = html + "<td class='begin'>"+obj.List[i].START+"</td>";
						html = html + "<td class='end'>"+obj.List[i].END+"</td>";
						html = html + "<td class='a_scheme'>"+obj.List[i].NAME+"</td>";
						html = html + "<td class='min_goal'>"+obj.List[i].MIN+"</td>";
						html = html + "<td class='max_goal'>"+obj.List[i].MAX+"</td>";
						html = html + "<td class='cost'>"+obj.List[i].COST+"</td>";
						html = html + "<td class='return'>"+obj.List[i].RETURN+"</td>";
						html = html + "<td class='isPassed'>"+obj.List[i].ISPASSED+"</td>";
						html = html + "<td class='a_id'>"+obj.List[i].ID+"</td>";
						html = html + "</tr>";
					}
					$("#listData tbody").html(html);

					$("#list tbody tr").dblclick(function(){
						type = $(this).find(".a_type").text();
						detail = $(this).find(".a_detail").text();
						depot = $(this).find(".d_name").text();
						supervisor = $(this).find(".m_supervisor").text();
						begin = $(this).find(".begin").text();
						end = $(this).find(".end").text();
						getListDetail($(this).find(".a_id").text());
						getProduct($(this).find(".a_id").text());
					});
					
					$("#list thead .sel").click(function(){
						if ($("#list tbody .sel input").not(":checked").length == 0) {
							$("#list tbody .sel input").attr("checked",false);
						} else {
							$("#list tbody .sel input").attr("checked",true);
						}
					});
					
					oTable = $("#listData").dataTable({
						"bFilter": false,
						"bSort": true,
						"bAutoWidth": true,
						"bLengthChange": false,
						"bInfo": false,
						"bProcessing": true,
						"bPaginate": false,
						"bScrollInfinite": true,
						"sScrollY": "320px",
				        "sScrollX": "1800px",
				        "oLanguage": {
					      "sEmptyTable": "没有记录"
					    }
					});
					$("#progress").hide();
				}
			}
		}
		
		function getYear() {		
			xmlHttp3 = createXMLHttpRequest();
			xmlHttp3.onreadystatechange = getYearProcessor;
			xmlHttp3.open("GET","AjaxServlet?action=getYear&tm="+new Date().toString());
			xmlHttp3.send(null);
		}
		
		function getYearProcessor() {
			var html = "";
			if (xmlHttp3.readyState == 4) {
				if (xmlHttp3.status == 200) {
					var obj = eval('('+xmlHttp3.responseText+')');
					
					for (var i = 0;i < obj.Year.length;i++) {
						html = html + "<option value='"+obj.Year[i].Key+"'>"+obj.Year[i].Value+"</option>";
					}
					$("#search div select#s_year").html(html);
				}
			}
		}
		
		function getType() {		
			xmlHttp4 = createXMLHttpRequest();
			xmlHttp4.onreadystatechange = getTypeProcessor;
			xmlHttp4.open("GET","AjaxServlet?action=getType&tm="+new Date().toString());
			xmlHttp4.send(null);
		}
		
		function getTypeProcessor() {
			var html = "";
			if (xmlHttp4.readyState == 4) {
				if (xmlHttp4.status == 200) {
					var obj = eval('('+xmlHttp4.responseText+')');
					
					for (var i = 0;i < obj.Type.length;i++) {
						html = html + "<option value='"+obj.Type[i].Key+"'>"+obj.Type[i].Value+"</option>";
					}
					$("#search div select#s_type").html(html);
					getDetail();
				}
			}
		}
		
		function getDetail() {		
			xmlHttp5 = createXMLHttpRequest();
			xmlHttp5.onreadystatechange = getDetailProcessor;
			xmlHttp5.open("GET","AjaxServlet?action=getDetail&type="+$("#search div select#s_type").val()+"&tm="+new Date().toString());
			xmlHttp5.send(null);
		}
		
		function getDetailProcessor() {
			var html = "";
			if (xmlHttp5.readyState == 4) {
				if (xmlHttp5.status == 200) {
					var obj = eval('('+xmlHttp5.responseText+')');
					
					for (var i = 0;i < obj.Detail.length;i++) {
						html = html + "<option value='"+obj.Detail[i].Key+"'>"+obj.Detail[i].Value+"</option>";
					}
					$("#search div select#s_detail").html(html);
				}
			}
		}
		
		function getStage() {		
			xmlHttp6 = createXMLHttpRequest();
			xmlHttp6.onreadystatechange = getStageProcessor;
			xmlHttp6.open("GET","AjaxServlet?action=getStage&tm="+new Date().toString());
			xmlHttp6.send(null);
		}
		
		function getStageProcessor() {
			var html = "";
			if (xmlHttp6.readyState == 4) {
				if (xmlHttp6.status == 200) {
					var obj = eval('('+xmlHttp6.responseText+')');
					
					for (var i = 0;i < obj.Stage.length;i++) {
						html = html + "<option value='"+obj.Stage[i].Key+"'>"+obj.Stage[i].Value+"</option>";
					}
					$("#search div select#s_stage").html(html);
				}
			}
		}
		
		function getFlag() {		
			xmlHttp7 = createXMLHttpRequest();
			xmlHttp7.onreadystatechange = getFlagProcessor;
			xmlHttp7.open("GET","AjaxServlet?action=getFlag&tm="+new Date().toString());
			xmlHttp7.send(null);
		}
		
		function getFlagProcessor() {
			var html = "";
			if (xmlHttp7.readyState == 4) {
				if (xmlHttp7.status == 200) {
					var obj = eval('('+xmlHttp7.responseText+')');
					
					for (var i = 0;i < obj.Flag.length;i++) {
						html = html + "<option value='"+obj.Flag[i].Key+"'>"+obj.Flag[i].Value+"</option>";
					}
					$("#search div select#s_flag").html(html);
				}
			}
		}
		
		function getListDetail(id) {		
			xmlHttp8 = createXMLHttpRequest();
			xmlHttp8.onreadystatechange = getListDetailProcessor;
			xmlHttp8.open("GET","AjaxServlet?action=getListDetail&id="+id+"&tm="+new Date().toString());
			xmlHttp8.send(null);
		}
		
		function getListDetailProcessor() {
			if (xmlHttp8.readyState == 4) {
				if (xmlHttp8.status == 200) {
					var obj = eval('('+xmlHttp8.responseText+')');

					$("#detail #d_year").text("年份："+obj.YEAR);
					$("#detail #d_type").text("活动类型："+type);
					$("#detail #d_detail").text("活动明细："+detail);
					$("#detail #d_depot").text("店铺："+depot);
					$("#detail #d_supervisor").text("督导："+supervisor);
					$("#detail #d_tel").text("电话："+obj.TEL);
					$("#detail #d_begin").text("开始时间："+begin);
					$("#detail #d_end").text("结束时间："+end);
					$("#detail #d_hpBegin").text("开始范围："+obj.HPBEGIN);
					$("#detail #d_hpEnd").text("结束范围："+obj.HPEND);
					$("#detail #d_hpLevel").text("款式等级："+obj.HPLEVEL);
					$("#detail #d_hpBrand").text("品牌："+obj.HPBRAND);
					$("#detail #d_hpType").text("品类："+obj.HPTYPE);
					$("#detail #d_hpYear").text("年份："+obj.HPYEAR);
					$("#detail #d_hpSeason").text("季节："+obj.HPSEASON);
					$("#detail #d_hpDate").text("波段："+obj.HPDATE);
					$("#detail #d_hpType1").text("促销类型："+obj.HPTYPE1);
					$("#detail #d_hpWay").text("优惠方式："+obj.HPWAY);
					$("#detail #d_hpPrice").text("优惠折扣/金额："+obj.HPPRICE);
					$("#detail #d_hpUse").text("使用方式："+obj.HPUSE);
					$("#detail #d_giveNum").text("赠送品类数量："+obj.GIVENUM);
					$("#detail #d_isCustom").text("是否制定促销款式："+obj.ISCUSTOM);
					$("#detail #d_isVip").text("是否只允许VIP："+obj.ISVIP);
					$("#detail #d_isDiscount").text("是否VIP折上折："+obj.ISDISCOUNT);
					$("#detail #d_comment").text("备注："+obj.COMMENT);
					$("#detail #d_maxGoal").text("攀登目标："+obj.MAXGOAL);
					$("#detail #d_minGoal").text("必保目标："+obj.MINGOAL);
					$("#detail #d_pos").text("销售录入POS："+obj.POS);
					$("#detail #d_cost").text("活动费用预算："+obj.COST);
					$("#detail #d_gift").text("礼品支持："+obj.GIFT);
					$("#detail #d_return").text("合同回款："+obj.RETURN);
					$("#detail #d_finish").text("实际完成："+obj.FINISH);
					$("#detail #d_avgPrice").text("平均客单价："+obj.AVGPRICE);
					$("#detail #d_avgNum").text("平均客单件："+obj.AVGNUM);
					$("#detail #d_maxNum").text("最高客单件："+obj.MAXNUM);
					$("#detail #d_vipPrice").text("VIP消费金额："+obj.VIPPRICE);
					$("#detail #d_vipNum").text("VIP消费人数："+obj.VIPNUM);
				}
			}
		}
		
		function doCheck(id,val) {		
			xmlHttp9 = createXMLHttpRequest();
			xmlHttp9.onreadystatechange = doCheckProcessor;
			xmlHttp9.open("GET","AjaxServlet?action=doCheck&id="+id+"&val="+val+"&tm="+new Date().toString());
			xmlHttp9.send(null);
		}
		
		function doCheckProcessor() {
			if (xmlHttp9.readyState == 4) {
				if (xmlHttp9.status == 200) {
					var obj = eval('('+xmlHttp9.responseText+')');
					
					if (obj.error != null)
						alert(obj.error);
					else {
						getManage();

  						//getList($("#s_year").val(),$("#s_type").val(),$("#s_detail").val(),$("#s_stage").val(),id,$("#s_flag").val(),$("#s_begin").val(),$("#s_name").val(),$("#s_depot").val(),$("#s_end").val());
					}
						
				}
			}
		}
		
		function getProduct(id) {		
			xmlHttp10 = createXMLHttpRequest();
			xmlHttp10.onreadystatechange = getProductProcessor;
			xmlHttp10.open("GET","AjaxServlet?action=getProduct&id="+id+"&tm="+new Date().toString());
			xmlHttp10.send(null);
		}
		
		function getProductProcessor() {
			var html = "";
			if (xmlHttp10.readyState == 4) {
				if (xmlHttp10.status == 200) {
					pTable.fnDestroy();
					var obj = eval('('+xmlHttp10.responseText+')');
					
					for (var i = 0;i < obj.List.length;i++) {
						html = html + "<tr>";
						html = html + "<td class='pt'>"+obj.List[i].PT+"</td>";
						html = html + "<td class='pt_skc'>"+obj.List[i].PTSKC+"</td>";
						html = html + "<td class='pt_year'>"+obj.List[i].PTYEAR+"</td>";
						html = html + "<td class='pt_season'>"+obj.List[i].PTSEASON+"</td>";
						html = html + "<td class='pt_type'>"+obj.List[i].PTTYPE+"</td>";
						html = html + "<td class='pt_big'>"+obj.List[i].PTBIG+"</td>";
						html = html + "<td class='pt_small'>"+obj.List[i].PTSMALL+"</td>";
						html = html + "<td class='pt_price'>"+obj.List[i].PTPRICE+"</td>";
						html = html + "</tr>";
					}
					$("#productData tbody").html(html);
			
					pTable = $("#productData").dataTable({
						"bFilter": false,
						"bSort": true,
						"bAutoWidth": true,
						"bLengthChange": false,
						"bInfo": false,
						"bProcessing": true,
						"bPaginate": false,
						"bScrollInfinite": true,
						"sScrollY": "220px",
				        "sScrollX": "840px",
				        "oLanguage": {
					      "sEmptyTable": "没有记录"
					    }
					});
				}
			}
		}
  	</script>
  </head>
  
  <body>
    <div id="title">
    	<div id="sign">CRM Assistant</div>
    	<div id="titleName">市场活动</div>
    </div>
    <div id="main">
    	<div id="manage">
    		<div id="manageTitle">待处理活动</div>
    		<div id="manageType">
    			<div id="1" class="m_type">待审批的活动</div>
    			<div id="4" class="m_type">已审批的活动</div>
    			<div id="0" class="m_type">未提交的活动</div>
    		</div>
    	</div>
    	<div id="data">
    		<div id="search">
    			<div id="searchTitle">
    				<div id="check"></div>
					<div id="checkText">批量审批</div>
					<div id="search_close" class="close"><img src="./image/close.png"></img></div>
					<div class="clear"></div>
    			</div>
    			<div>
    				<div class="condition">
	    				<div class="left">活动年份:</div>
	    				<select class="left" id="s_year">
	    				</select>
    				</div>
    				<div class="condition">
	    				<div class="left">活动类型:</div>
	    				<select class="left" id="s_type">
	    				</select>
    				</div>
    				<div class="condition">
	    				<div class="left">类型明细:</div>
	    				<select class="left" id="s_detail">
	    				</select>
    				</div>
    				<div class="condition" style="width: 100px;">
    					<input type="button" class="left" id="s_button" value="查询"/>
    				</div>
    				<div class="clear"></div>
    			</div>
    			<div>
    				<div class="condition">
	    				<div class="left">审批状态:</div>
	    				<select class="left" id="s_flag">
	    				</select>
    				</div>
    				<div class="condition">
	    				<div class="left">审批阶段:</div>
	    				<select class="left" id="s_stage">
    					</select>
    				</div>
    				<div class="condition">
	    				<div class="left">开始时间:</div>
	    				<input type="text" class="left" id="s_begin">
	    				</input>
    				</div>
    				<div class="clear"></div>
    			</div>
    			<div>
    				<div class="condition">
	    				<div class="left">活动名称:</div>
	    				<input type="text" class="left" id="s_name">
	    				</input>
    				</div>
    				<div class="condition">
	    				<div class="left">店铺名称:</div>
	    				<input type="text" class="left" id="s_depot">
	    				</input>
    				</div>
    				<div class="condition">
	    				<div class="left">结束时间:</div>
	    				<input type="text" class="left" id="s_end">
	    				</input>
    				</div>
    				<div class="clear"></div>
    			</div>
    		</div>
    		<div id="list">
    			<table id="listData" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<th class="sel">全选</th>
							<th class="a_name">活动名称</th>
							<th class="dq">分公司</th>
							<th class="d_name">店铺名</th>
							<th class="m_supervisor">督导</th>
							<th class="a_type">活动类型</th>
							<th class="a_detail">活动明细</th>
							<th class="begin">开始时间</th>
							<th class="end">结束时间</th>
							<th class="a_scheme">活动方案</th>
							<th class="min_goal">必保目标</th>
							<th class="max_goal">攀登目标</th>
							<th class="cost">活动费用预算</th>
							<th class="return">活动回款</th>
							<th class="isPassed">是否审核通过</th>
							<th class="a_id">ID</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
    		</div>
    		<div id="dialog" title="审批">
    			<div id="checkButton">
    				<div class="checkLabel">审批意见</div>
    				<div class="checkArea">
	    				<input type="radio" name="check" value="1001"/>批准
	    				<input type="radio" name="check" value="1002"/>不批准（驳回）
    				</div>
    				<div class="clear"></div>
    			</div>
    		</div>
    		<div id="detail">
    			<div id="detailTitle" style="margin: 0;">
    				活动明细
    				<div id="detail_close" class="close"><img src="./image/close.png"></img></div>
    			</div>
    			<div id="detail_1">
    				<div id="d_year" class="left long">年份：</div>
    				<div id="d_type" class="left long">活动类型：</div>
    				<div id="d_detail" class="left long">活动明细：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_2">
    				<div id="d_depot" class="left long">店铺：</div>
    				<div id="d_supervisor" class="left short">督导：</div>
    				<div id="d_tel" class="left short">电话：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_3">活动方案</div>
    			<div id="detail_4">
    				<div id="d_begin" class="left long">开始时间：</div>
    				<div id="d_end" class="left long">结束时间：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_5">
    				<div id="d_hpType1" class="left long">促销类型：</div>
    				<div id="d_hpBegin" class="left long">开始范围：</div>
    				<div id="d_hpEnd" class="left long">结束范围：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_6">
    				<div id="d_hpBrand" class="left long">品牌：</div>
    				<div id="d_hpYear" class="left long">年份：</div>
    				<div id="d_hpSeason" class="left long">季节：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_7">
    				<div id="d_hpDate" class="left long">波段：</div>
    				<div id="d_hpType" class="left long">品类：</div>
    				<div id="d_hpLevel" class="left long">款式等级：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_8">
    				<div id="d_hpWay" class="left long">优惠方式：</div>
    				<div id="d_hpPrice" class="left long">优惠折扣/金额：</div>
    				<div id="d_hpUse" class="left long">使用方式：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_9">
    				<div id="d_giveNum" class="left long">赠送品类数量：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_10">
    				<div id="d_isCustom" class="left long">是否制定促销款式：</div>
    				<div id="d_isVip" class="left long">是否只允许VIP：</div>
    				<div id="d_isDiscount" class="left long">是否VIP折上折：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_11">
    				<div id="d_comment" class="left">备注：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_18">
    				方案明细
    				<div id="pt_close" class="close"><img src="./image/close.png"></img></div>
    			</div>
    			<div id="detail_19">
    				<table id="productData" cellpadding="0" cellspacing="0">
						<thead>
							<tr>
								<th class="pt">产品</th>
								<th class="pt_skc">产品编号</th>
								<th class="pt_year">年份</th>
								<th class="pt_season">季节</th>
								<th class="pt_type">种类</th>
								<th class="pt_big">大类</th>
								<th class="pt_small">小类</th>
								<th class="pt_price">零售现价</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
    			</div>
    			<div id="detail_12">活动目标</div>
    			<div id="detail_13">
    				<div id="d_maxGoal" class="left long">攀登目标：</div>
    				<div id="d_minGoal" class="left long">必保目标：</div>
    				<div id="d_pos" class="left long">销售录入POS：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_14">
    				<div id="d_cost" class="left long">活动费用预算：</div>
    				<div id="d_gift" class="left long">礼品支持：</div>
    				<div id="d_return" class="left long">合同回款：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_15">活动结果</div>
    			<div id="detail_16">
    				<div id="d_finish" class="left long">实际完成：</div>
    				<div id="d_avgPrice" class="left long">平均客单价：</div>
    				<div id="d_avgNum" class="left long">平均客单件：</div>
    				<div id="d_maxNum" class="left long">最高客单件：</div>
    				<div class="clear"></div>
    			</div>
    			<div id="detail_17">
    				<div id="d_vipPrice" class="left long">VIP消费金额：</div>
    				<div id="d_vipNum" class="left long">VIP消费人数：</div>
    				<div class="clear"></div>
    			</div>
    		</div>
    	</div>
    	<div class="clear"></div>
    </div>
    <div id="progress">
    	<div id="background"></div>
    </div>
    <script type="text/javascript">
    	$("#search div select#s_type").change(function(){
			getDetail();
		});
		
		//$("#search div select#s_flag").change(function(){
		//	if ($("#search div select#s_flag").val() == 1) {
		//		getStage();
		//	} else {
		//		$("#search div select#s_stage").html("");
		//	}
		//});
		
		$(".m_type").click(function(){
			var html = "";
			$("#progress").show();
			id = $(this).attr("id");
			getList("","","","",id,"","","","","");
			
			if (id == "1") {
				html = html + "<option value='null'>未审核</option>";
				html = html + "<option value='1001'>通过</option>";
				html = html + "<option value='1002'>未通过</option>";
				$("#search div select#s_flag").html(html);
			} else if (id == "4") {
				html = html + "<option value='1001'>通过</option>";
				html = html + "<option value='1002'>未通过</option>";
				$("#search div select#s_flag").html(html);
			}
		});
		
		$("#s_button").click(function(){
			$("#progress").show();

			getList($("#s_year").val(),$("#s_type").val(),$("#s_detail").val(),$("#s_stage").val(),id,$("#s_flag").val(),$("#s_begin").val(),$("#s_name").val(),$("#s_depot").val(),$("#s_end").val());
		});
		
		$("#check").click(function() {
			$("#dialog").dialog("open");
		});
		
		$("#search_close").click(function(){
			if ($(this).attr("class")=="close") {
				$(this).removeClass("close");
				$(this).addClass("open");
				$(this).find("img").attr("src","./image/open.png");
				$(".condition").parent().hide();
				$("#manage").height($("#data").height());
			} else {
				$(this).removeClass("open");
				$(this).addClass("close");
				$(this).find("img").attr("src","./image/close.png");
				$(".condition").parent().show();
				$("#manage").height($("#data").height());
			}
			
		});
		
		$("#detail_close").click(function(){
			if ($(this).attr("class")=="close") {
				$(this).removeClass("close");
				$(this).addClass("open");
				$(this).find("img").attr("src","./image/open.png");
				$(this).parent().parent().find("div").not("#detailTitle").hide();
				$("#detailTitle div").show();
				$("#manage").height($("#data").height());
			} else {
				$(this).removeClass("open");
				$(this).addClass("close");
				$(this).find("img").attr("src","./image/close.png");
				$(this).parent().parent().find("div").show();
				$("#manage").height($("#data").height());
			}
			
		});
		
		$("#pt_close").click(function(){
			if ($(this).attr("class")=="close") {
				$(this).removeClass("close");
				$(this).addClass("open");
				$(this).find("img").attr("src","./image/open.png");
				$("#detail_19").hide();
				$("#manage").height($("#data").height());
			} else {
				$(this).removeClass("open");
				$(this).addClass("close");
				$(this).find("img").attr("src","./image/close.png");
				$("#detail_19").show();
				$("#manage").height($("#data").height());
			}
			
		});
    </script>
  </body>
</html>
