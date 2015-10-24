<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<html> 
	<head>
		<title>订货会SKC排名</title>
		<link rel="stylesheet" href="./css/common.css" type="text/css"></link>
		<link rel="stylesheet" href="./css/jquery.dataTables.css" type="text/css"></link>
		<script type="text/javascript" src="./js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="./js/jquery.dataTables.min.js"></script>
		<script type="text/javascript">
			var PL = "";
			var oTable;
			
			$(document).ready(function(){
				createTable();
				getSelector();
			});
			
			function createTable(){
				$('#pm tbody tr').click(function(e){
					$('#pm tbody tr').removeClass('select_row');
					$(this).addClass('select_row');
				});
				
				oTable = $('#pm').dataTable({
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
			
			function getSelector() {
				createXMLHttpRequest();
				xmlHttp.onreadystatechange = getSelectorProcessor;
				xmlHttp.open("GET","AjaxServlet?action=GetSelector&tm="+new Date().toString());
				xmlHttp.send(null);
			}
			
			function getSelectorProcessor() {
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
						
						if (obj.BTN1 != null) {
							$('#category #1').addClass('enable');
						}
						if (obj.BTN2 != null) {
							$('#category #2').addClass('enable');
						}
						if (obj.BTN3 != null) {
							$('#category #3').addClass('enable');
						}
						if (obj.BTN4 != null) {
							$('#category #4').addClass('enable');
						}
						if (obj.BTN5 != null) {
							$('#category #5').addClass('enable');
						}
						if (obj.BTN6 != null) {
							$('#category #6').addClass('enable');
						}
						if (obj.BTN7 != null) {
							$('#category #7').addClass('enable');
						}
						if (obj.BTN8 != null) {
							$('#category #8').addClass('enable');
						}
						if (obj.BTN9 != null) {
							$('#category #9').addClass('enable');
						}
						if (obj.BTNG != null) {
							$('#category #G').addClass('enable');
						}
						if (obj.BTNM != null) {
							$('#category #M').addClass('enable');
						}
						if (obj.BTNN != null) {
							$('#category #N').addClass('enable');
						}
						if (obj.BTNP != null) {
							$('#category #P').addClass('enable');
						}
						if (obj.BTNQ != null) {
							$('#category #Q').addClass('enable');
						}
						if (obj.BTNY != null) {
							$('#category #Y').addClass('enable');
						}
						if (obj.BTNB != null) {
							$('#category #B').addClass('enable');
						}
						if (obj.BTND != null) {
							$('#category #D').addClass('enable');
						}
						if (obj.BTNF != null) {
							$('#category #F').addClass('enable');
						}
						if (obj.BTNH != null) {
							$('#category #H').addClass('enable');
						}
						if (obj.BTNI != null) {
							$('#category #I').addClass('enable');
						}
						if (obj.BTNJ != null) {
							$('#category #J').addClass('enable');
						}
						if (obj.BTNO != null) {
							$('#category #O').addClass('enable');
						}
						if (obj.BTNR != null) {
							$('#category #R').addClass('enable');
						}
						if (obj.BTNS != null) {
							$('#category #S').addClass('enable');
						}
						if (obj.BTNU != null) {
							$('#category #U').addClass('enable');
						}
						if (obj.BTNW != null) {
							$('#category #W').addClass('enable');
						}
						if (obj.BTNX != null) {
							$('#category #X').addClass('enable');
						}
						if (obj.BTNZ != null) {
							$('#category #Z').addClass('enable');
						}
					}
				}
			}
			
			function getPM() {
				if (PL == "") {
					alert("请先选择品类...");
					return;
				}
				
				$('.load').show();
				createXMLHttpRequest();
				xmlHttp.onreadystatechange = getPMProcessor;
				xmlHttp.open("GET","AjaxServlet?action=GetPM&PL="+PL+"&tm="+new Date().toString());
				xmlHttp.send(null);
			}
			
			function getPMProcessor() {
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
								html = html + "<td class='skc'>"+item.skc+"</td>";
								html = html + "<td class='img'><img alt='"+item.skc+"' src='http://192.168.0.36:8010/"+item.skc+".jpg' onerror='"+"this.src=&quot;./image/error.gif&quot;;'></td>";
								html = html + "<td class='band'>"+item.shangDate+"</td>";
								html = html + "<td class='series'>"+item.series+"</td>";
								html = html + "<td class='style'>"+item.styleType+"</td>";
								html = html + "<td class='color'>"+item.colorName+"</td>";
								html = html + "<td class='price'>"+item.sellPrice+"</td>";
								html = html + "<td class='totalNum'>"+item.fsNums+"</td>";
								html = html + "<td class='depotNum'>"+item.dpNum+"</td>";
								html = html + "<td class='avgNum'>"+item.ddpNum+"</td>";
								html = html + "<td class='num'>"+item.fcmSum+"</td>";
								html = html + "<td class='operator' onclick='doOrder(&quot;"+item.skc+"&quot;);'>&nbsp;</td>";
								html = html + "</tr>";
							});
						}
						$('#ranking #pm tbody').html(html);
						createTable();
						$('.load').hide();
					}
				}
			}
			
			function doOrder(skc){
				location.href='./ranking.do?skc='+skc;
			}
		</script>
	</head>
	<body>
		<div id="bg">
			<div id="ranking">
				<div id="title">
					<div id="pmTitle">SKC订货量排名(请先选择品类)</div>
					<div id="selector"></div>
					<div id="refresh"></div>
					<div id="back" onclick="location.href='./ranking.do'"></div>
					<div class="clear"></div>
				</div>
				<div id="container">
					<table id="pm" cellpadding="0" cellspacing="0">
						<thead>
							<tr>
								<th class="index">序号</th>
								<th class="skc">SKC</th>
								<th class="img">款图</th>
								<th class="band">波段</th>
								<th class="series">系列</th>
								<th class="style">款式名称</th>
								<th class="color">颜色</th>
								<th class="price">零售价</th>
								<th class="totalNum">订货数量</th>
								<th class="depotNum">订货店铺</th>
								<th class="avgNum">平均单店定量</th>
								<th class="num">本店订货数量</th>
								<th class="operator">下订单</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
				</div>
				<html:form action="/ranking">
				</html:form>
			</div>
			<div class="load"><img alt="load" src="./image/load.gif"></div>
			<div id="category">
				<div id="greyBg"></div>
				<div id="panel">
					<div id="categoryTitle">品类选择</div>
					<div id="cy">
						<div id="cyTitle">成衣</div>
						<div id="cyBtn">
							<div>
								<div id="1" class="btn" title="外套类"></div>
								<div id="2" class="btn" title="衬衫类"></div>
								<div id="3" class="btn" title="裙子类"></div>
								<div id="4" class="btn" title="连衣裙类"></div>
								<div id="5" class="btn" title="针织衫类"></div>
								<div class="clear"></div>
							</div>
							<div>
								<div id="6" class="btn" title="裤子类"></div>
								<div id="7" class="btn" title="风衣类"></div>
								<div id="8" class="btn" title="大衣类"></div>
								<div id="9" class="btn" title="毛衫类"></div>
								<div id="G" class="btn" title="工作服类"></div>
								<div class="clear"></div>
							</div>
							<div>
								<div id="M" class="btn" title="棉服类"></div>
								<div id="N" class="btn" title="尼克服类"></div>
								<div id="P" class="btn" title="皮衣类"></div>
								<div id="Q" class="btn" title="裘皮类"></div>
								<div id="Y" class="btn" title="羽绒服类"></div>
								<div class="clear"></div>
							</div>
						</div>
						<div class="clear"></div>
					</div>		
					<img class="split" alt="" src="./image/split1.png">
					<div id="sp">
						<div id="spTitle">饰品</div>
						<div id="spBtn">
							<div>
								<div id="B" class="btn" title="包类"></div>
								<div id="D" class="btn" title="皮带类"></div>
								<div id="F" class="btn" title="胸花类"></div>
								<div id="H" class="btn" title="帽子类"></div>
								<div id="I" class="btn" title="耳环类"></div>
								<div class="clear"></div>
							</div>
							<div>
								<div id="J" class="btn" title="眼镜类"></div>
								<div id="O" class="btn" title="发夹类"></div>
								<div id="R" class="btn" title="手镯类"></div>
								<div id="S" class="btn" title="手套类"></div>
								<div id="U" class="btn" title="袜子类"></div>
								<div class="clear"></div>
							</div>
							<div>
								<div id="W" class="btn" title="围巾类"></div>
								<div id="X" class="btn" title="鞋子类"></div>
								<div id="Z" class="btn" title="项链类"></div>
								<div class="clear"></div>
							</div>
							<div>
								<div id="close"></div>
								<div class="clear"></div>
							</div>
						</div>
						<div class="clear"></div>
					</div>	
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$('#ranking #title #selector').click(function(){
				$('#category').show();
			});
			
			$('#category #close').click(function(){
				$('#category').hide();
			});
			
			$('#category div.btn').click(function(){
				$('#ranking #title #pmTitle').text('['+$(this).attr('title')+']SKC订货量排名');
				$('#category').hide();
				PL = $(this).attr('id');
				getPM();
			});
			
			$('#ranking #title #refresh').click(function(){
				getPM();
			});
		</script>
	</body>		
</html>

