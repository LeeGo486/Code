<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
 
<html> 
	<head>
		<title>读卡器选择</title>
		<link rel="stylesheet" href="./css/common.css" type="text/css"></link>
		<script type="text/javascript" src="./js/jquery-1.7.2.min.js"></script>
	</head>
	<body>
		<jsp:include page="close.jsp"></jsp:include>
		<div class="page">
		<html:form action="/rfid">
			<html:hidden property="rfidType"/>
			<div class="check">
				<div class="rfid">
					<div>
						<img class="reader" src="./image/rfid1.bmp" id="greyRFID" alt="灰色读卡器">
					</div>
					<div class="text">读卡器一（灰色）</div>
				</div>
				<div class="rfid">
					<div>
						<img class="reader" src="./image/rfid2.bmp" id="blueRFID" alt="蓝色读卡器">
					</div>
					<div class="text">读卡器二（蓝色）</div>
				</div>
				<div class="info">请根据手中读卡器的颜色和样式选择相应的读卡器，登录系统</div>
				<div class="clear"></div>
			</div>
		</html:form>
		</div>
		<script type="text/javascript">
			$('.reader').click(function(){
				$('input').val($(this).attr('id'));
				document.forms[0].submit();
			});
		</script>
	</body>
</html>

