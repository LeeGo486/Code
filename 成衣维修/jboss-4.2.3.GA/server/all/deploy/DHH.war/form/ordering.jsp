<%@page import="com.dhh.utils.Constants"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<html> 
	<head>
		<title>订货会订货主界面</title>
		<script type="text/javascript" src="./js/jquery-1.7.2.min.js"></script>
		<link rel="stylesheet" href="./css/common.css" type="text/css"></link>
		<script type="text/javascript">
			
			var selecti,selectCol;
			var sellPrice,checkf,checkbig;
			var fWid,fSkcRFID,fSkc,fColorID,fColorName,fSeries,fstyleType,fshangDate,facc,fSizeGroup;
			var sfcm01p,sfcm02p,sfcm03p,sfcm04p,sfcm05p,sfcm06p,sfcm07p,sfcm08p,sfcm09p,sfcmfp;
			var num01,num02,num03,num04,num05,num06,num07,num08,num09,numf;
			var xmlHttp1,xmlHttp2,xmlHttp3,xmlHttp4,xmlHttp5,xmlHttp6;
			var PARAMTER_VALUE = null;   
			
			function getParamter(paramName) {   
			    if(!PARAMTER_VALUE) {   //第一次初始化   
			        PARAMTER_VALUE = new Array();   
			        var paramStr = location.search.substring(1);   
			        var paramArr = paramStr.split("&");   
			        var len = paramArr.length;   
			        var tempArr;   
			        for(var i = 0; i < len; i++) {   
			            tempArr = paramArr[i].split("=");   
			            PARAMTER_VALUE[tempArr[0]] = tempArr[1];   
			        }   
			    }   
			    var paramValue = PARAMTER_VALUE[paramName];   
			    if(paramValue) {   
			        return paramValue;   
			    } else {
			    	return "";
			    }   
			}
			
			function createXMLHttpRequest() {
				var xmlHttp;
				if (window.ActiveXObject) {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xmlHttp = new XMLHttpRequest();
				}
				return xmlHttp;
			}
			
			function getSum() {
				xmlHttp1 = createXMLHttpRequest();
				xmlHttp1.onreadystatechange = getSumProcessor;
				xmlHttp1.open("GET","AjaxServlet?action=GetSum&tm="+new Date().toString());
				xmlHttp1.send(null);
			}
			
			function getSumProcessor() {
				if (xmlHttp1.readyState == 4) {
					if (xmlHttp1.status == 200) {
						var obj = eval('('+xmlHttp1.responseText+')');
						if (obj.session != null) {
							alert(obj.session);
							window.location.href="";
							return;
						}
						if (obj.error != null) {
							alert(obj.error);
							return;
						} else {
							$('table .row .mb').eq(0).text(obj.nums);
							$('table .row .mb').eq(1).text('￥'+obj.targetprice.toFixed(2));
							$('table .row .mb').eq(2).text(obj.c_nums);
							$('table .row .mb').eq(3).text('￥'+obj.C_TargetPrice.toFixed(2));
							$('table .row .cy').eq(0).text(obj.NewNum);
							$('table .row .sp').eq(0).text(obj.SPnum);
							$('table .row .bd').eq(0).text(obj.OldNum);
							$('table .row .hj').eq(0).text(obj.AllNUM1);
							$('table .row .cy').eq(1).text('￥'+obj.NewJe.toFixed(2));
							$('table .row .sp').eq(1).text('￥'+obj.SPJE.toFixed(2));
							$('table .row .bd').eq(1).text('￥'+obj.Oldje.toFixed(2));
							$('table .row .hj').eq(1).text('￥'+obj.ALLJE1.toFixed(2));
							
							if (obj.targetprice != 0) {
								$('table .row .cyl').eq(1).text((obj.NewJe/(obj.targetprice*(1-obj.SP_Percent))*100).toFixed(2)+'%');
							}
							
							if (obj.nums != 0) {
								$('table .row .cyl').eq(0).text((obj.NewNum/(obj.nums*(1-obj.SP_Percent))*100).toFixed(2)+'%');
							}
							
							if (obj.targetprice != 0 && obj.SP_Percent != 0) {
								$('table .row .spl').eq(1).text((obj.SPJE/(obj.targetprice*obj.SP_Percent)*100).toFixed(2)+'%');
							}
							
							if (obj.nums != 0 && obj.SP_Percent != 0) {
								$('table .row .spl').eq(0).text((obj.SPnum/(obj.nums*obj.SP_Percent)*100).toFixed(2)+'%');
							}
							
							$('table .row .cy').eq(2).text(obj.MNewNum);
							$('table .row .sp').eq(2).text(obj.MSpnum);
							$('table .row .bd').eq(2).text(obj.MOldNum);
							$('table .row .hj').eq(2).text(obj.MAllnum);
							$('table .row .cy').eq(3).text('￥'+obj.MNewJe.toFixed(2));
							$('table .row .sp').eq(3).text('￥'+obj.MSpje.toFixed(2));
							$('table .row .bd').eq(3).text('￥'+obj.MOldje.toFixed(2));
							$('table .row .hj').eq(3).text('￥'+obj.MAllje.toFixed(2));
							
							if (obj.C_TargetPrice != 0) {
								$('table .row .cyl').eq(1).text((obj.MNewJe/(obj.C_TargetPrice*(1-obj.SP_Percent))*100).toFixed(2)+'%');
							}
							
							if (obj.c_nums != 0) {
								$('table .row .cyl').eq(0).text((obj.MNewNum/(obj.c_nums*(1-obj.SP_Percent))*100).toFixed(2)+'%');
							}
							
							if (obj.C_TargetPrice != 0 && obj.SP_Percent != 0) {
								$('table .row .spl').eq(1).text((obj.MSpje/(obj.C_TargetPrice*obj.SP_Percent)*100).toFixed(2)+'%');
							}
							
							if (obj.c_nums != 0 && obj.SP_Percent != 0) {
								$('table .row .spl').eq(0).text((obj.MSpnum/(obj.c_nums*obj.SP_Percent)*100).toFixed(2)+'%');
							}
						}
					}
				}
			}

			function getStyleColor(rfid) {
				xmlHttp2 = createXMLHttpRequest();
				xmlHttp2.onreadystatechange = getStyleColorProcessor;
				xmlHttp2.open("GET","AjaxServlet?action=GetStyleColor&rfid="+rfid+"&tm="+new Date().toString());
				xmlHttp2.send(null);
			}
			
			function getStyleColorProcessor() {
				if (xmlHttp2.readyState == 4) {
					if (xmlHttp2.status == 200) {
						var obj = eval('('+xmlHttp2.responseText+')');
						if (obj.session != null) {
							alert(obj.session);
							window.location.href="";
							return;
						}
						if (obj.error != null) {
							alert(obj.error);
							return;
						} else {
							$('#edit input').eq(0).val(obj.FStyleAddColor);
							getStyleInfo(obj.FStyleAddColor);
						}
					}
				}
			}
			
			function getStyleInfo(styleColor) {
				xmlHttp3 = createXMLHttpRequest();
				xmlHttp3.onreadystatechange = getStyleInfoProcessor;
				xmlHttp3.open("GET","AjaxServlet?action=GetStyleInfo&styleColor="+styleColor+"&tm="+new Date().toString());
				xmlHttp3.send(null);
			}
			
			function getStyleInfoProcessor() {
				if (xmlHttp3.readyState == 4) {
					if (xmlHttp3.status == 200) {
						var obj = eval('('+xmlHttp3.responseText+')');
						if (obj.session != null) {
							alert(obj.session);
							window.location.href="";
							return;
						}
						if (obj.error != null) {
							alert(obj.error);
							return;
						} else {
							fwid = obj.Fid;
					        fSkcRFID = obj.frfid;
					        fSkc = obj.FStyleAddColor;
					        fColorID = obj.Fcolor;
					        fColorName = obj.fColorName;
					        fSeries = obj.FSeries;
					        fstyleType = obj.FStyleType;
					        fshangDate = obj.FShangDate;
					        facc = obj.facc;
					        fSizeGroup = obj.fSizeGroup;
							
							$('#clothingInfo #text #skc').text('SKC:'+obj.FStyleAddColor);
							$('#clothingInfo #text #color').text('颜色：'+obj.fColorName);
							$('#clothingInfo #text #price').text('价格：'+obj.FSellingPrice);
							$('#clothingInfo #text #series').text('系列：'+obj.FSeries);
							$('#clothingInfo #text #type').text('款式类别：'+obj.FStyleType);
							$('#clothingInfo #text #date').text('上货日期：'+obj.FShangDate);
							
							if (obj.checkSP == "成衣") {
								sellPrice = (obj.FSellingPrice * <%=session.getAttribute("DISCOUNT")%>).toFixed(2);
							} else if (obj.checkSP == "饰品") {
								sellPrice = (obj.FSellingPrice * <%=session.getAttribute("SPDISCOUNT")%>).toFixed(2);
							}
							
							checkbig = obj.checkbig;
							$('#orderingNum .row .color').text(obj.fColorName);
							
							if (obj.FCM01 == '0') {
								$('#orderingNum .num01').hide();
								$('#orderingNum td.num01 input').val('0');
							} else {
								$('#orderingNum .num01').show();
								$('#orderingNum th.num01').text(obj.FCM01);
								$('#orderingNum td.num01 input').val('0');
							}

							if (obj.FCM02 == '0') {
								$('#orderingNum .num02').hide();
								$('#orderingNum td.num02 input').val('0');
							} else {
								$('#orderingNum .num02').show();
								$('#orderingNum th.num02').text(obj.FCM02);
								$('#orderingNum td.num02 input').val('0');
							}
							
							if (obj.FCM03 == '0') {
								$('#orderingNum .num03').hide();
								$('#orderingNum td.num03 input').val('0');
							} else {
								$('#orderingNum .num03').show();
								$('#orderingNum th.num03').text(obj.FCM03);
								$('#orderingNum td.num03 input').val('0');
							}
							
							if (obj.FCM04 == '0') {
								$('#orderingNum .num04').hide();
								$('#orderingNum td.num04 input').val('0');
							} else {
								$('#orderingNum .num04').show();
								$('#orderingNum th.num04').text(obj.FCM04);
								$('#orderingNum td.num04 input').val('0');
							}
							
							if (obj.FCM05 == '0') {
								$('#orderingNum .num05').hide();
								$('#orderingNum td.num05 input').val('0');
							} else {
								$('#orderingNum .num05').show();
								$('#orderingNum th.num05').text(obj.FCM05);
								$('#orderingNum td.num05 input').val('0');
							}
							
							if (obj.FCM06 == '0') {
								$('#orderingNum .num06').hide();
								$('#orderingNum td.num06 input').val('0');
							} else {
								$('#orderingNum .num06').show();
								$('#orderingNum th.num06').text(obj.FCM06);
								$('#orderingNum td.num06 input').val('0');
							}
							
							if (obj.FCM07 == '0') {
								$('#orderingNum .num07').hide();
								$('#orderingNum td.num07 input').val('0');
							} else {
								$('#orderingNum .num07').show();
								$('#orderingNum th.num07').text(obj.FCM07);
								$('#orderingNum td.num07 input').val('0');
							}
							
							if (obj.FCM08 == '0') {
								$('#orderingNum .num08').hide();
								$('#orderingNum td.num08 input').val('0');
							} else {
								$('#orderingNum .num08').show();
								$('#orderingNum th.num08').text(obj.FCM08);
								$('#orderingNum td.num08 input').val('0');
							}
							
							if (obj.FCM09 == '0') {
								$('#orderingNum .num09').hide();
								$('#orderingNum td.num09 input').val('0');
							} else {
								$('#orderingNum .num09').show();
								$('#orderingNum th.num09').text(obj.FCM09);
								$('#orderingNum td.num09 input').val('0');
							}
							
							if (obj.FCMF == '0') {
								$('#orderingNum .numf').hide();
								$('#orderingNum td.numf input').val('0');
								checkf = "0";
							} else {
								$('#orderingNum .numf').show();
								$('#orderingNum th.numf').text(obj.FCMF);
								$('#orderingNum td.numf input').val('0');
								checkf = "1";
							}
							
							var rate;
							var imgaddress = "http://192.168.0.36:8020/"+obj.FStyleAddColor+".jpg";
							$('.pic img').attr('src',imgaddress);
							$('.pic img').css('display','inline');
							rate = $('.pic img').width()/$('.pic img').height();
							if ($('.pic img').width()/198 > $('.pic img').height()/218) {
								$('.pic img').width('198px');
								$('.pic img').height(Math.round(198/rate)+'px');
							} else {
								$('.pic img').height('218px');
								$('.pic img').width(Math.round(218*rate)+'px');
							}
							
							$('#orderingArea #saveText').text("提示：订货中...");
							$('#orderingArea #saveText').css('color','yellow');
							
							$('#orderingNum .row input').removeClass('sel');
							selectCol = "";
							selecti = "0";
							
							$('#orderingArea #numBtn div').removeClass('disable');
							
							if (checkf == "1") {
								sfcm01p = 0;
						        sfcm02p = 0;
						        sfcm03p = 0;
						        sfcm04p = 0;
						        sfcm05p = 0;
						        sfcm06p = 0;
						        sfcm07p = 0;
						        sfcm08p = 0;
						        sfcm09p = 0;
						        sfcmfp = 1;
						        getOrderNum();
							} else {
								getSales();
							}
						}
					}
				}
			}
			
			function getSales() {
				xmlHttp4 = createXMLHttpRequest();
				xmlHttp4.onreadystatechange = getSalesProcessor;
				xmlHttp4.open("GET","AjaxServlet?action=GetSales&sortid="+checkbig+"&tm="+new Date().toString());
				xmlHttp4.send(null);
			}
			
			function getSalesProcessor() {
				if (xmlHttp4.readyState == 4) {
					if (xmlHttp4.status == 200) {
						var obj = eval('('+xmlHttp4.responseText+')');
						if (obj.session != null) {
							alert(obj.session);
							window.location.href="";
							return;
						}
						if (obj.error != null) {
							alert(obj.error);
							return;
						} else {
							sfcm01p = obj.FCM01;
					        sfcm02p = obj.FCM02;
					        sfcm03p = obj.FCM03;
					        sfcm04p = obj.FCM04;
					        sfcm05p = obj.FCM05;
					        sfcm06p = obj.FCM06;
					        sfcm07p = obj.FCM07;
					        sfcm08p = obj.FCM08;
					        sfcm09p = obj.FCM09;
					        sfcmfp = obj.FCMF;
						}
						getOrderNum();
					}
				}
			}
			
			function getOrderNum() {
				xmlHttp5 = createXMLHttpRequest();
				xmlHttp5.onreadystatechange = getOrderNumProcessor;
				xmlHttp5.open("GET","AjaxServlet?action=GetOrderNum&fskc="+fSkc+"&tm="+new Date().toString());
				xmlHttp5.send(null);
			}
			
			function getOrderNumProcessor() {
				if (xmlHttp5.readyState == 4) {
					if (xmlHttp5.status == 200) {
						var obj = eval('('+xmlHttp5.responseText+')');
						if (obj.session != null) {
							alert(obj.session);
							window.location.href="";
							return;
						}
						if (obj.error != null) {
							alert(obj.error);
							return;
						} else {
							$('#orderingNum td.num01 input').val(parseInt(obj.FCM01));
							$('#orderingNum td.num02 input').val(parseInt(obj.FCM02));
							$('#orderingNum td.num03 input').val(parseInt(obj.FCM03));
							$('#orderingNum td.num04 input').val(parseInt(obj.FCM04));
							$('#orderingNum td.num05 input').val(parseInt(obj.FCM05));
							$('#orderingNum td.num06 input').val(parseInt(obj.FCM06));
							$('#orderingNum td.num07 input').val(parseInt(obj.FCM07));
							$('#orderingNum td.num08 input').val(parseInt(obj.FCM08));
							$('#orderingNum td.num09 input').val(parseInt(obj.FCM09));
							$('#orderingNum td.numf input').val(parseInt(obj.FCMF));
							sumDH();
						}
					}
				}
			}
			
			function saveOrderNum() {
				xmlHttp6 = createXMLHttpRequest();
				xmlHttp6.onreadystatechange = saveOrderNumProcessor;
				xmlHttp6.open("GET","AjaxServlet?action=SaveOrderNum"
						+"&fwid="+fwid
				        +"&fSkcRFID="+fSkcRFID
				        +"&fSkc="+fSkc
				        +"&fColorID="+fColorID
				        +"&fColorName="+fColorName
				        +"&fSeries="+fSeries
				        +"&fstyleType="+fstyleType
				        +"&fshangDate="+fshangDate
				        +"&facc="+facc
				        +"&fSizeGroup="+fSizeGroup
				        +"&sellPrice="+sellPrice
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
				xmlHttp6.send(null);
			}
			
			function saveOrderNumProcessor() {
				if (xmlHttp6.readyState == 4) {
					if (xmlHttp6.status == 200) {
						var obj = eval('('+xmlHttp6.responseText+')');
						if (obj.session != null) {
							alert(obj.session);
							window.location.href="";
							return;
						}
						if (obj.error != null) {
							alert(obj.error);
							return;
						} else if (obj.info != null) {
							alert(obj.info);
							getSum();
						} else if (obj.success != null) {
							$('#orderingArea #saveText').text(obj.success);
							$('#orderingArea #saveText').css('color','red');
							getSum();
						}
					}
				}
			}
			
			$(function () {
				getSum();

				var skc = getParamter('skc');
				if (skc != "") {
					$('#edit input').eq(0).val(skc);
					getStyleInfo(skc);
				}
				
				var ischanged = "";
	            function getRfidData() {
	                //不能用Jquery的方法获取 $("#RFIDReader")
	                var rfid = (document.getElementById("RFIDReader").CardNum);
	                if (ischanged == rfid) return;
	                ischanged = rfid;
	
					$('#image #rfid input').val(ischanged);
					getStyleColor(ischanged);
	            }
	            setInterval(getRfidData, 500);
	        });
		</script>
	</head>
	<body>
		<div id="bg">
			<div id="ordering">
				<div id="info" class="order">
					<div id="clothingInfo" class="left">
						<div id="image" class="left">
							<div class="pic">
								<img alt="" src="" onerror="this.src='./image/error.gif';"/>
							</div>
							<div id="rfid">
								<div class="text left">RFID号：</div>
								<%if (session.getAttribute("rfidType").toString().equalsIgnoreCase("greyRFID")) {%>
									<object id="RFIDReader" classid="clsid:0CBD6597-3953-4B88-8C9F-F58B1B023413" 
								        codebase="RFID/RFIDREADER.cab">
								    </object>
								<%} else {%>
									<object id="RFIDReader" classid="clsid:E6A15262-D581-4AA3-98D3-5B9F83920EFE" 
								        codebase="RFID/RFIDREADER.cab">
								    </object>
								<%} %>
							    <input type="text" id="rfid" class="value" disabled="disabled"/>
							    <div class="clear"></div>
						    </div>
						</div>
						<div id="text" class="left">
							<div id="title">款式信息</div>
							<div id="skc">SKC:</div>
							<div id="color">颜色：</div>
							<div id="price">价格：</div>
							<div id="series">系列：</div>
							<div id="type">款式类别：</div>
							<div id="date">上货日期：</div>
							<div id="prompt1" class="prompt">提示：订单必须保存后才生效</div>
						</div>
						<div class="clear"></div>
					</div>
					<div id="orderingInfo">
						<div id="DP"><%=session.getAttribute("CAPTION") %></div>
						<div id="count">
							<table id="DP" cellpadding="0" cellspacing="0">
								<tr class="head">
									<th class="type">&nbsp;</th>
									<th class="cy">成衣</th>
									<th class="sp">服饰品</th>
									<th class="hj">合计</th>
									<th class="mb">目标</th>
									<th class="cyl">成衣达成率</th>
									<th class="spl">饰品达成率</th>
									<th class="bd">补订款</th>
								</tr>
								<tr class="row odd">
									<td class="type">单店订货数量（件）</td>
									<td class="cy">0</td>
									<td class="sp">0</td>
									<td class="hj">0</td>
									<td class="mb">0</td>
									<td class="cyl">0.0%</td>
									<td class="spl">0.0%</td>
									<td class="bd">0</td>
								</tr>
								<tr class="row even">
									<td class="type">单店订货金额（万元）</td>
									<td class="cy">￥0</td>
									<td class="sp">￥0</td>
									<td class="hj">￥0</td>
									<td class="mb">￥0</td>
									<td class="cyl">￥0.0%</td>
									<td class="spl">￥0.0%</td>
									<td class="bd">￥0</td>
								</tr>
								<tr class="row odd">
									<td class="type">客户订货数量（件）</td>
									<td class="cy">0</td>
									<td class="sp">0</td>
									<td class="hj">0</td>
									<td class="mb">0</td>
									<td class="cyl">0.0%</td>
									<td class="spl">0.0%</td>
									<td class="bd">0</td>
								</tr>
								<tr class="row even">
									<td class="type">客户订货金额（万元）</td>
									<td class="cy">￥0</td>
									<td class="sp">￥0</td>
									<td class="hj">￥0</td>
									<td class="mb">￥0</td>
									<td class="cyl">￥0.0%</td>
									<td class="spl">￥0.0%</td>
									<td class="bd">￥0</td>
								</tr>
							</table>
						</div>
						<div id="prompt2" class="prompt">提示：成衣达成率和饰品达成率达到100%，才可以审单！</div>
						<div id="btn">
							<div id="pm" onclick="location.href='./ordering.do?page=pm'"></div>
							<div id="dd" onclick="location.href='./ordering.do?page=dd'"></div>
							<div id="bb"></div>
							<div id="close" onclick="window.close();"></div>
							<div class="clear"></div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
				<div id="split"></div>
				<div id="edit">
					<div class="title">
						<div class="title">SKC:</div>
						<input type="text" id="skc" class="value"/>
						<div class="clear"></div>
					</div>
					<div class="title">
						<div class="title">拟定货量:</div>
						<input type="text" id="nnum" class="value" readonly="readonly"/>
						<%if (session.getAttribute("ISSALES").toString().equalsIgnoreCase("0")) {%>
							<script type="text/javascript">
								$('#edit #nnum').attr('disabled','disabled');
							</script>
						<%} %>
						<div class="clear"></div>
					</div>
					<div class="title order">
						<div class="title">本款订货量:</div>
						<input type="text" id="bnum" class="value" disabled="disabled"/>
						<div class="clear"></div>
					</div>
					<div class="title order">
						<div class="title">本款订货金额:</div>
						<input type="text" id="bprice" class="value" disabled="disabled"/>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
				<div id="orderingArea">
					<div id="data">
						<html:form action="/ordering">
							<table id="orderingNum" cellpadding="0" cellspacing="0">
								<tr class="head">
									<th class="color">颜色</th>
									<th class="num01">01[XS]</th>
									<th class="num02">02[S]</th>
									<th class="num03">03[M]</th>
									<th class="num04">04[L]</th>
									<th class="num05">05[XL]</th>
									<th class="num06">06[XXL]</th>
									<th class="num07">07[3XL]</th>
									<th class="num08">08[4XL]</th>
									<th class="num09">09[5XL]</th>
									<th class="numf">F[均码]</th>
								</tr>
								<tr class="row odd">
									<td class="color">&nbsp;</td>
									<td class="num01"><html:text property="num01" value="0" readonly="true"/></td>
									<td class="num02"><html:text property="num02" value="0" readonly="true"/></td>
									<td class="num03"><html:text property="num03" value="0" readonly="true"/></td>
									<td class="num04"><html:text property="num04" value="0" readonly="true"/></td>
									<td class="num05"><html:text property="num05" value="0" readonly="true"/></td>
									<td class="num06"><html:text property="num06" value="0" readonly="true"/></td>
									<td class="num07"><html:text property="num07" value="0" readonly="true"/></td>
									<td class="num08"><html:text property="num08" value="0" readonly="true"/></td>
									<td class="num09"><html:text property="num09" value="0" readonly="true"/></td>
									<td class="numf"><html:text property="numf" value="0" readonly="true"/></td>
								</tr>
							</table>
						</html:form>
						<div id="save"></div>
						<div class="clear"></div>
					</div>
					<div id="saveText">提示：订货中...</div>
					<div id="numBtn">
						<div id="num1" class="disable" onclick="numKey(1);"></div>
						<div id="num2" class="disable" onclick="numKey(2);"></div>
						<div id="num3" class="disable" onclick="numKey(3);"></div>
						<div id="num4" class="disable" onclick="numKey(4);"></div>
						<div id="num5" class="disable" onclick="numKey(5);"></div>
						<div id="num6" class="disable" onclick="numKey(6);"></div>
						<div id="num7" class="disable" onclick="numKey(7);"></div>
						<div id="num8" class="disable" onclick="numKey(8);"></div>
						<div id="num9" class="disable" onclick="numKey(9);"></div>
						<div id="num0" class="disable" onclick="numKey(0);"></div>
						<div id="clear" class="disable" ></div>
						<div id="back" class="disable" ></div>
						<div class="clear"></div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$('#orderingNum .row input').click(function(){
				$('#orderingNum .row input').removeClass('sel');
				$(this).addClass('sel');
				selectCol = $(this).attr('name');
				selecti = "0";
				
				$('#orderingArea #saveText').text("提示：订货中...");
				$('#orderingArea #saveText').css('color','yellow');
			});
			
			$('#orderingArea #numBtn div').focusin(function(){
				if ($(this).hasClass('disable')) {
					return;
				}
				$(this).addClass('active');
			});
			
			$('#orderingArea #numBtn div').focusout(function(){
				if ($(this).hasClass('disable')) {
					return;
				}
				$(this).removeClass('active');
			});
			
			$('#orderingInfo #btn div').focusin(function(){
				if ($(this).hasClass('disable')) {
					return;
				}
				$(this).addClass('active');
			});
			
			$('#orderingInfo #btn div').focusout(function(){
				if ($(this).hasClass('disable')) {
					return;
				}
				$(this).removeClass('active');
			});
			
			$('#orderingInfo #btn div#bb').mouseup(function(){
				window.location.href=<%=session.getAttribute("WebUrl")%>+'?bs=true';
			});
			
			$('#orderingArea #save').focusin(function(){
				$(this).addClass('active');
			});
			
			$('#orderingArea #save').focusout(function(){
				$(this).removeClass('active');
			});
			
			$('#edit input').eq(0).keyup(function(){
				if ($(this).val().length >= 11) {
					getStyleInfo($(this).val());
				}
			});
			
			$('#edit input').eq(1).click(function(){
				$('#orderingArea #saveText').text("提示：订货中...");
				$('#orderingArea #saveText').css('color','yellow');
				
				selectCol = "99";
				selecti = "0";
			});
			
			function sumEdit(){
				if ($('#edit input').eq(1).val() != "" && $('#edit input').eq(1).val() > 0) {
					var num = $('#edit input').eq(1).val();
					if (checkf == "1") {
						$('#orderingNum td.numf input').val(num);
					} else {
						if ($('#orderingNum td.num01 input').is(':visible')) {
							$('#orderingNum td.num01 input').val(Math.round(num * sfcm01p));
						} else {
							$('#orderingNum td.num01 input').val('0');
						}
						
						if ($('#orderingNum td.num02 input').is(':visible')) {
							$('#orderingNum td.num02 input').val(Math.round(num * sfcm02p));
						} else {
							$('#orderingNum td.num02 input').val('0');
						}
						
						if ($('#orderingNum td.num03 input').is(':visible')) {
							$('#orderingNum td.num03 input').val(Math.round(num * sfcm03p));
						} else {
							$('#orderingNum td.num04 input').val('0');
						}
						
						if ($('#orderingNum td.num04 input').is(':visible')) {
							$('#orderingNum td.num04 input').val(Math.round(num * sfcm04p));
						} else {
							$('#orderingNum td.num04 input').val('0');
						}
						
						if ($('#orderingNum td.num05 input').is(':visible')) {
							$('#orderingNum td.num05 input').val(Math.round(num * sfcm05p));
						} else {
							$('#orderingNum td.num05 input').val('0');
						}
						
						if ($('#orderingNum td.num06 input').is(':visible')) {
							$('#orderingNum td.num06 input').val(Math.round(num * sfcm06p));
						} else {
							$('#orderingNum td.num06 input').val('0');
						}
						
						if ($('#orderingNum td.num07 input').is(':visible')) {
							$('#orderingNum td.num07 input').val(Math.round(num * sfcm07p));
						} else {
							$('#orderingNum td.num07 input').val('0');
						}
						
						if ($('#orderingNum td.num08 input').is(':visible')) {
							$('#orderingNum td.num08 input').val(Math.round(num * sfcm08p));
						} else {
							$('#orderingNum td.num08 input').val('0');
						}
						
						if ($('#orderingNum td.num09 input').is(':visible')) {
							$('#orderingNum td.num09 input').val(Math.round(num * sfcm09p));
						} else {
							$('#orderingNum td.num09 input').val('0');
						}
					}
				}
			}
			
			function numKey(num){
				if ($('#orderingArea #numBtn #num'+num).hasClass('disable')) {
					return;
				}
				
				if (selectCol == "") {
					alert("请选择对应尺码组的输入框....");
					return;
				}
				
				if (selectCol == "99") {
					if (selecti == "0") {
						$('#edit #nnum').val(num);
						selecti = parseInt(selecti) + parseInt(num);
					} else {
						if (parseInt($('#edit #nnum').val()+num) > <%=session.getAttribute("TOTALNUM")%>) {
							alert("订货量不能超过"+<%=session.getAttribute("TOTALNUM")%>+"件，请检查....");
						} else {
							$('#edit #nnum').val(parseInt($('#edit #nnum').val()+num));
							selecti = $('#edit #nnum').val();
						}
					}
					sumEdit();
				} else {
					if (selecti == "0") {
						$('#orderingNum .row input.sel').val(num);
						selecti = parseInt(selecti) + parseInt(num);
					} else {
						if (parseInt($('#orderingNum .row input.sel').val()+num) > <%=session.getAttribute("TOTALNUM")%>) {
							alert("订货量不能超过"+<%=session.getAttribute("TOTALNUM")%>+"件，请检查....");
						} else {
							$('#orderingNum .row input.sel').val(parseInt($('#orderingNum .row input.sel').val()+num));
							selecti = $('#orderingNum .row input.sel').val();
						}					
					}
				}
				sumDH();
			}
			
			$('#orderingArea #numBtn #clear').click(function(){
				if ($(this).hasClass('disable')) {
					return;
				}
				
				if (selectCol == "") {
					alert("请选择对应尺码组的输入框....");
					return;
				}
				
				if (selectCol == "99") {
					$('#edit #nnum').val('0');
					selecti = "0";
					sumEdit();
				} else {
					$('#orderingNum .row input.sel').val('0');
					selecti = "0";
				}
				
				sumDH();
			});
			
			$('#orderingArea #numBtn #back').click(function(){
				if ($(this).hasClass('disable')) {
					return;
				}
				
				if (selectCol == "") {
					alert("请选择对应尺码组的输入框....");
					return;
				}
				
				var num;
				
				if (selectCol == "99") {
					num = $('#edit #nnum').val();
					num = num.substring(0,num.length-1);
					if (num == "") {
						num = "0";
					}
					$('#edit #nnum').val(num);
					selecti = num;
					sumEdit();
				} else {
					num = $('#orderingNum .row input.sel').val();
					num = num.substring(0,num.length-1);
					if (num == "") {
						num = "0";
					}
					$('#orderingNum .row input.sel').val(num);
					selecti = num;
				}
				sumDH();
			});
			
			function sumDH(){
				var num = 0;
				
				$('#orderingNum input').each(function(i){
					if ($(this).is(':visible')) {
						num = num + parseInt($(this).val());
					} else {
						num = num;
					} 
				});
				
				$('#edit input').eq(2).val(num);
				$('#edit input').eq(3).val(parseInt(num) * parseInt(sellPrice));
			}
			
			$('#orderingArea #save').click(function(){
				if ($('#edit input').eq(2).val() == "") {
					alert("没有选取订货款式，不能下订单...");
					return;
				}
				
				if ($('#orderingNum td.num01 input').is(':visible')) {
					if ($('#orderingNum td.num01 input').val() == "") {
						num01 = 0;
					} else {
						num01 = parseInt($('#orderingNum td.num01 input').val());
					}
				} else {
					num01 = 0;
				}
				
				if ($('#orderingNum td.num02 input').is(':visible')) {
					if ($('#orderingNum td.num02 input').val() == "") {
						num02 = 0;
					} else {
						num02 = parseInt($('#orderingNum td.num02 input').val());
					}
				} else {
					num02 = 0;
				}
				
				if ($('#orderingNum td.num03 input').is(':visible')) {
					if ($('#orderingNum td.num03 input').val() == "") {
						num03 = 0;
					} else {
						num03 = parseInt($('#orderingNum td.num03 input').val());
					}
				} else {
					num03 = 0;
				}
				
				if ($('#orderingNum td.num04 input').is(':visible')) {
					if ($('#orderingNum td.num04 input').val() == "") {
						num04 = 0;
					} else {
						num04 = parseInt($('#orderingNum td.num04 input').val());
					}
				} else {
					num04 = 0;
				}
				
				if ($('#orderingNum td.num05 input').is(':visible')) {
					if ($('#orderingNum td.num05 input').val() == "") {
						num05 = 0;
					} else {
						num05 = parseInt($('#orderingNum td.num05 input').val());
					}
				} else {
					num05 = 0;
				}
				
				if ($('#orderingNum td.num06 input').is(':visible')) {
					if ($('#orderingNum td.num06 input').val() == "") {
						num06 = 0;
					} else {
						num06 = parseInt($('#orderingNum td.num06 input').val());
					}
				} else {
					num06 = 0;
				}
				
				if ($('#orderingNum td.num07 input').is(':visible')) {
					if ($('#orderingNum td.num07 input').val() == "") {
						num07 = 0;
					} else {
						num07 = parseInt($('#orderingNum td.num07 input').val());
					}
				} else {
					num07 = 0;
				}
				
				if ($('#orderingNum td.num08 input').is(':visible')) {
					if ($('#orderingNum td.num08 input').val() == "") {
						num08 = 0;
					} else {
						num08 = parseInt($('#orderingNum td.num08 input').val());
					}
				} else {
					num08 = 0;
				}
				
				if ($('#orderingNum td.num09 input').is(':visible')) {
					if ($('#orderingNum td.num09 input').val() == "") {
						num09 = 0;
					} else {
						num09 = parseInt($('#orderingNum td.num09 input').val());
					}
				} else {
					num09 = 0;
				}
				
				if ($('#orderingNum td.numf input').is(':visible')) {
					if ($('#orderingNum td.numf input').val() == "") {
						numf = 0;
					} else {
						numf = parseInt($('#orderingNum td.numf input').val());
					}
				} else {
					numf = 0;
				}
				
				if ((num01 + num02 + num03 + num04 + num05 + num06 + num07 + num08 + num09 + numf) > <%=session.getAttribute("TOTALNUM")%>) {
					alert("本款订货数量，大于"+<%=session.getAttribute("TOTALNUM")%>+"件，请检查...");
					return;
				}
				
				saveOrderNum();
			});	
		</script>
	</body>
</html>

