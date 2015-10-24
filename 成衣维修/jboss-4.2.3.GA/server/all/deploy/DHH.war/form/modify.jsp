<%@page import="com.dhh.utils.Constants"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
 
<html> 
	<head>
		<title>订货会订单修改</title>
		<link rel="stylesheet" href="./css/common.css" type="text/css"></link>
		<link rel="stylesheet" href="./css/jquery.dataTables.css" type="text/css"></link>
		<script type="text/javascript" src="./js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="./js/jquery.dataTables.min.js"></script>
		<script type="text/javascript">
			var oTable;
			var size;
			var num;
			var skc;
			var num01,num02,num03,num04,num05,num06,num07,num08,num09,numf;
			
			$(document).ready(function(){				
				getSize();
				createTable();
			});
			
			function createTable(){
				$('#dd tbody td').click(function(e){
					$('#dd tbody td').removeClass('select_td');
					$(this).parent().find('td').addClass('select_td');
					$(this).removeClass('select_td');
					
					size = $(this).attr('class');
					skc = $(this).parent().find('td.skc').text();
					
					switch(size) {
					case "num01":
					case "num02":
					case "num03":
					case "num04":
					case "num05":
					case "num06":
					case "num07":
					case "num08":
					case "num09":
					case "numf":
						num = $(this).text();
						getStyleSize();
						break;
					default:
						$('#modifyNum').hide();
						break;
					}
				});
				
				oTable = $('#dd').dataTable({
					"bFilter": false,
					"bSort": true,
					"bAutoWidth": false,
					"iDisplayLength": 10,
					"bLengthChange": false,
					"bPaginate": true,
					"bInfo": true,
					"sPaginationType": "full_numbers",
					"bProcessing": true,
					"oLanguage": {
						"sZeroRecords": "对不起，查询不到任何相关数据",
						"sInfoEmtpy": "找不到相关数据",
						"sProcessing": "正在加载中...",
						"sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
						"oPaginate": {
	                        "sFirst": "第一页",
	                        "sPrevious": " 上一页 ",
	                        "sNext": " 下一页 ",
	                        "sLast": " 最后一页 "
	                    }
					}
				});
			}
			
			function createXMLHttpRequest() {
				if (window.ActiveXObject) {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xmlHttp = new XMLHttpRequest();
				}
			}
			
			function getSize() {
				createXMLHttpRequest();
				xmlHttp.onreadystatechange = getSizeProcessor;
				xmlHttp.open("GET","AjaxServlet?action=GetSize&tm="+new Date().toString());
				xmlHttp.send(null);
			}
			
			function getSizeProcessor() {
				if (xmlHttp.readyState == 4) {
					if (xmlHttp.status == 200) {
						var obj = eval('('+xmlHttp.responseText+')');
						
						if (obj.session != null) {
							alert(obj.session);
							window.location.href="";
							return;
						}
						if (obj.error != null) {
							alert(obj.error);
							return;
						}
						
						$.each(obj.root,function(i,item){
							if (item.fCMBH == "fCM01") {
								$('#modify th.num01').text(item.fCMNMC + item.fCMNMA);
							}
							
							if (item.fCMBH == "fCM02") {
								$('#modify th.num02').text(item.fCMNMC + item.fCMNMA);
							}
							
							if (item.fCMBH == "fCM03") {
								$('#modify th.num03').text(item.fCMNMC + item.fCMNMA);
							}
							
							if (item.fCMBH == "fCM04") {
								$('#modify th.num04').text(item.fCMNMC + item.fCMNMA);
							}
							
							if (item.fCMBH == "fCM05") {
								$('#modify th.num05').text(item.fCMNMC + item.fCMNMA);
							}
							
							if (item.fCMBH == "fCM06") {
								$('#modify th.num06').text(item.fCMNMC + item.fCMNMA);
							}
							
							if (item.fCMBH == "fCM07") {
								$('#modify th.num07').text(item.fCMNMC + item.fCMNMA);
							}
							
							if (item.fCMBH == "fCM08") {
								$('#modify th.num08').text(item.fCMNMC + item.fCMNMA);
							}
							
							if (item.fCMBH == "fCM09") {
								$('#modify th.num09').text(item.fCMNMC + item.fCMNMA);
							}
							
							if (item.fCMBH == "fCMF") {
								$('#modify th.numf').text(item.fCMNMC + item.fCMNMA);
							}
						});
					
						showColumns();
					}
				}
			}
			
			function showColumns() {
				
				if ($('#modify th.num01').text() == "") {
					$('#modify .num01').hide();
				}
				if ($('#modify th.num02').text() == "") {
					$('#modify .num02').hide();
				}
				if ($('#modify th.num03').text() == "") {
					$('#modify .num03').hide();
				}
				if ($('#modify th.num04').text() == "") {
					$('#modify .num04').hide();
				}
				if ($('#modify th.num05').text() == "") {
					$('#modify .num05').hide();
				}
				if ($('#modify th.num06').text() == "") {
					$('#modify .num06').hide();
				}
				if ($('#modify th.num07').text() == "") {
					$('#modify .num07').hide();
				}
				if ($('#modify th.num08').text() == "") {
					$('#modify .num08').hide();
				}
				if ($('#modify th.num09').text() == "") {
					$('#modify .num09').hide();
				}
				if ($('#modify th.numf').text() == "") {
					$('#modify .numf').hide();
				}
				
				var brand = <%="'" + session.getAttribute("DHHBRAND").toString() + "'"%>
				if (brand == "DoubleLove") {
					$('#modify .num07').hide();
					$('#modify .num08').hide();
					$('#modify .num09').hide();
				}
				if (brand == "TBF") {
					$('#modify .num07').hide();
					$('#modify .num08').hide();
					$('#modify .num09').hide();
				}
				if (brand == "EP") {
					$('#modify .num01').hide();
					$('#modify .num08').hide();
					$('#modify .num09').hide();
				}
				if (brand == "F5") {
					$('#modify .num01').hide();
					$('#modify .num08').hide();
					$('#modify .num09').hide();
				}
			}
			
			function getDetail() {
				$('.load').show();
				
				$('#modifyNum').hide();
				createXMLHttpRequest();
				xmlHttp.onreadystatechange = getDetailProcessor;
				xmlHttp.open("GET","AjaxServlet?action=GetDetail&skc="+$('#modify div input#skc').val()+"&tm="+new Date().toString());
				xmlHttp.send(null);
			}
			
			function getDetailProcessor() {
				var html = "";
				
				if (xmlHttp.readyState == 4) {
					if (xmlHttp.status == 200) {
						var obj = eval('('+xmlHttp.responseText+')');
						
						if (obj.session != null) {
							alert(obj.session);
							window.location.href="";
							return;
						}
						oTable.fnDestroy();
						if (obj.error != null) {
							alert(obj.error);
						}
						if (obj.info == null) {
							$.each(obj.root,function(i,item){
								html = html + "<tr>";
								html = html + "<td class='index'>"+(i+1)+"</td>";
								html = html + "<td class='skc'>"+item.fSKC+"</td>";
								html = html + "<td class='img'><img alt='"+item.fSKC+"' src='http://192.168.0.36:8010/"+item.fSKC+".jpg' onerror='"+"this.src=&quot;./image/error.gif&quot;;'></td>";
								html = html + "<td class='color'>"+item.fcolorname+"</td>";
								html = html + "<td class='series'>"+item.fSeries+"</td>";
								html = html + "<td class='style'>"+item.fStyleType+"</td>";
								html = html + "<td class='band'>"+item.fShangDate+"</td>";
								html = html + "<td class='price'>"+'￥'+item.FSellingPrice.toFixed(2)+"</td>";
								html = html + "<td class='num01'>"+item.fCM01+"</td>";
								html = html + "<td class='num02'>"+item.fCM02+"</td>";
								html = html + "<td class='num03'>"+item.fCM03+"</td>";
								html = html + "<td class='num04'>"+item.fCM04+"</td>";
								html = html + "<td class='num05'>"+item.fCM05+"</td>";
								html = html + "<td class='num06'>"+item.fCM06+"</td>";
								html = html + "<td class='num07'>"+item.fCM07+"</td>";
								html = html + "<td class='num08'>"+item.fCM08+"</td>";
								html = html + "<td class='num09'>"+item.fCM09+"</td>";
								html = html + "<td class='numf'>"+item.fCMF+"</td>";
								html = html + "<td class='numTotal'>"+item.sumCm+"</td>";
								html = html + "<td class='delete' onclick='doDelete(&quot;"+item.fSKC+"&quot;);'>&nbsp;</td>";
								html = html + "</tr>";
							});
						}
						$('#modify #dd tbody').html(html);
						showColumns();
						createTable();
						getDepotSum();
						$('.load').hide();
					}
				}
			}
			function getDepotSum() {
				createXMLHttpRequest();
				xmlHttp.onreadystatechange = getDepotSumProcessor;
				xmlHttp.open("GET","AjaxServlet?action=GetDepotSum&tm="+new Date().toString());
				xmlHttp.send(null);
			}
			
			function getDepotSumProcessor() {
				if (xmlHttp.readyState == 4) {
					if (xmlHttp.status == 200) {
						var obj = eval('('+xmlHttp.responseText+')');
						if (obj.session != null) {
							alert(obj.session);
							window.location.href="";
							return;
						}
						if (obj.error != null) {
							alert(obj.error);
							return;
						}
						
						$('#modify div input').eq(0).val(obj.allnum);
						$('#modify div input').eq(1).val('￥'+obj.allje.toFixed(2));
					}
				}
			}			
			
			function doDelete(skc){
				createXMLHttpRequest();
				xmlHttp.onreadystatechange = doDeleteProcessor;
				xmlHttp.open("GET","AjaxServlet?action=doDelete&skc="+skc+"&tm="+new Date().toString());
				xmlHttp.send(null);
			}
			
			function doDeleteProcessor() {
				if (xmlHttp.readyState == 4) {
					if (xmlHttp.status == 200) {
						var obj = eval('('+xmlHttp.responseText+')');
					
						if (obj.session != null) {
							alert(obj.session);
							window.location.href="";
							return;
						}
						if (obj.error != null) {
							alert(obj.error);
							return;
						}
						
						getDetail();
					}
				}
			}
			
			function getStyleSize() {
				createXMLHttpRequest();
				xmlHttp.onreadystatechange = getStyleSizeProcessor;
				xmlHttp.open("GET","AjaxServlet?action=GetStyleSize&skc="+skc+"&tm="+new Date().toString());
				xmlHttp.send(null);
			}
			
			function getStyleSizeProcessor() {
				if (xmlHttp.readyState == 4) {
					if (xmlHttp.status == 200) {
						var obj = eval('('+xmlHttp.responseText+')');
						if (obj.session != null) {
							alert(obj.session);
							window.location.href="";
							return;
						}
						if (obj.error != null) {
							alert(obj.error);
							return;
						}
						
						if (size == "num01" && obj.fcm01 != "0") {
							$('#modifyNum').show();
						} else if (size == "num02" && obj.fcm02 != "0") {
							$('#modifyNum').show();
						} else if (size == "num03" && obj.fcm03 != "0") {
							$('#modifyNum').show();
						} else if (size == "num04" && obj.fcm04 != "0") {
							$('#modifyNum').show();
						} else if (size == "num05" && obj.fcm05 != "0") {
							$('#modifyNum').show();
						} else if (size == "num06" && obj.fcm06 != "0") {
							$('#modifyNum').show();
						} else if (size == "num07" && obj.fcm07 != "0") {
							$('#modifyNum').show();
						} else if (size == "num08" && obj.fcm08 != "0") {
							$('#modifyNum').show();
						} else if (size == "num09" && obj.fcm09 != "0") {
							$('#modifyNum').show();
						} else if (size == "numf" && obj.fcmf != "0") {
							$('#modifyNum').show();
						} else {
							$('#modifyNum').hide();
						}
						
					}
				}
			}	
			
			function modifyOrder() {	
				num01 = parseInt($('#dd tbody td.select_td').parent().find('.num01').text());
				num02 = parseInt($('#dd tbody td.select_td').parent().find('.num02').text());
				num03 = parseInt($('#dd tbody td.select_td').parent().find('.num03').text());
				num04 = parseInt($('#dd tbody td.select_td').parent().find('.num04').text());
				num05 = parseInt($('#dd tbody td.select_td').parent().find('.num05').text());
				num06 = parseInt($('#dd tbody td.select_td').parent().find('.num06').text());
				num07 = parseInt($('#dd tbody td.select_td').parent().find('.num07').text());
				num08 = parseInt($('#dd tbody td.select_td').parent().find('.num08').text());
				num09 = parseInt($('#dd tbody td.select_td').parent().find('.num09').text());
				numf = parseInt($('#dd tbody td.select_td').parent().find('.numf').text());
				
				if (parseInt($('#dd tbody td.select_td').parent().find('.numTotal').text()) > <%=session.getAttribute("TOTALNUM")%>) {
					alert("本款订货数量，大于"+<%=session.getAttribute("TOTALNUM")%>+"件，请检查...");
					return;
				}
				
				createXMLHttpRequest();
				xmlHttp.onreadystatechange = modifyOrderProcessor;
				xmlHttp.open("GET","AjaxServlet?action=ModifyOrder"
				        +"&fSkc="+skc
						+"&num01="+num01
						+"&num02="+num02
						+"&num03="+num03
						+"&num04="+num04
						+"&num05="+num05
						+"&num06="+num06
						+"&num07="+num07
						+"&num08="+num08
						+"&num09="+num09
						+"&numf="+numf
						+"&tm="+new Date().toString());
				xmlHttp.send(null);
			}
			
			function modifyOrderProcessor() {
				if (xmlHttp.readyState == 4) {
					if (xmlHttp.status == 200) {
						var obj = eval('('+xmlHttp.responseText+')');
						if (obj.session != null) {
							alert(obj.session);
							window.location.href="";
							return;
						}
						if (obj.error != null) {
							alert(obj.error);
							return;
						}
						getDepotSum();
					}
				}
			}	
		</script>
	</head>
	<body>
		<div id="bg">
			<div id="modify">
				<div id="title">
					<div class="title">
						<div class="title">订货数量（件）:</div>
						<input type="text" id="num" class="value" disabled="disabled" value="0"/>
						<div class="clear"></div>
					</div>
					<div class="title">
						<div class="title">订货总金额（万元）:</div>
						<input type="text" id="cost" class="value" disabled="disabled" value="￥0.00"/>
						<div class="clear"></div>
					</div>
					<div id="ddTitle">本店已下单明细</div>
					<div class="title">
						<div class="title">款式查找:</div>
						<input type="text" id="skc" class="value"/>
						<div class="clear"></div>
					</div>
					<div id="refresh"></div>
					<div id="back" onclick="location.href='./modify.do'"></div>
					<div class="clear"></div>
				</div>
				<div id="container">
					<table id="dd" cellpadding="0" cellspacing="0">
						<thead>
							<tr>
								<th class="index">序号</th>
								<th class="skc">SKC</th>
								<th class="img">款图</th>
								<th class="color">颜色</th>
								<th class="series">系列</th>
								<th class="style">款式类别</th>
								<th class="band">波段</th>
								<th class="price">结算价</th>
								<th class="num01"></th>
								<th class="num02"></th>
								<th class="num03"></th>
								<th class="num04"></th>
								<th class="num05"></th>
								<th class="num06"></th>
								<th class="num07"></th>
								<th class="num08"></th>
								<th class="num09"></th>
								<th class="numf"></th>
								<th class="numTotal">合计</th>
								<th class="delete">删除</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
				</div>
				<html:form action="/modify">
				</html:form>
			</div>
			<div class="load"><img alt="load" src="./image/load.gif"></div>
			<div id="modifyNum">
				<div>
					<div id="num1" class="btn" onclick="numKey('1');"></div>
					<div id="num2" class="btn" onclick="numKey('2');"></div>
					<div id="num3" class="btn" onclick="numKey('3');"></div>
					<div id="num4" class="btn" onclick="numKey('4');"></div>
					<div class="clear"></div>
				</div>
				<div>
					<div id="num5" class="btn" onclick="numKey('5');"></div>
					<div id="num6" class="btn" onclick="numKey('6');"></div>
					<div id="num7" class="btn" onclick="numKey('7');"></div>
					<div id="num8" class="btn" onclick="numKey('8');"></div>
					<div class="clear"></div>
				</div>
				<div>
					<div id="num9" class="btn" onclick="numKey('9');"></div>
					<div id="num0" class="btn" onclick="numKey('0');"></div>
					<div id="clear" class="btn"></div>
					<div id="sure" class="btn"></div>
					<div class="clear"></div>
				</div>
				<div id="text">按【确认】键保存数量并隐藏数字界面！</div>
			</div>
		</div>
		<script type="text/javascript">
			$('#modify #title #refresh').click(function(){
				getDetail();
			});
			
			$('#modifyNum .btn').focusin(function(){
				$(this).addClass('active');
			});
			
			
			$('#modifyNum .btn').focusout(function(){
				$(this).removeClass('active');
			});
			
			function numKey(i) { 
				if (num == "0") {
					$('#dd tbody td.select_td').parent().find('.'+size).text(i);
					num = i;
				} else {
					if (parseInt(num + i) > <%=session.getAttribute("TOTALNUM")%>) {
						alert("订货量不能超过"+<%=session.getAttribute("TOTALNUM")%>+"件，请检查....");
					} else {
						$('#dd tbody td.select_td').parent().find('.'+size).text(num + i);
						num = num + i;
					}
				}
				
				sumColumn();
			}
			
			function sumColumn() {
				$('#dd tbody td.select_td').parent().find('.numTotal').text(
						parseInt($('#dd tbody td.select_td').parent().find('.num01').text()) + 
						parseInt($('#dd tbody td.select_td').parent().find('.num02').text()) +
						parseInt($('#dd tbody td.select_td').parent().find('.num03').text()) +
						parseInt($('#dd tbody td.select_td').parent().find('.num04').text()) +
						parseInt($('#dd tbody td.select_td').parent().find('.num05').text()) +
						parseInt($('#dd tbody td.select_td').parent().find('.num06').text()) +
						parseInt($('#dd tbody td.select_td').parent().find('.num07').text()) +
						parseInt($('#dd tbody td.select_td').parent().find('.num08').text()) +
						parseInt($('#dd tbody td.select_td').parent().find('.num09').text()) +
						parseInt($('#dd tbody td.select_td').parent().find('.numf').text()));
			}
			
			$('#modifyNum #clear').click(function(){
				$('#dd tbody td.select_td').parent().find('.'+size).text("0");
				num = "0";
				sumColumn();
			});
			
			$('#modifyNum #sure').click(function(){
				modifyOrder();
				$('#modifyNum').hide();
			});
		</script>
	</body>
</html>

