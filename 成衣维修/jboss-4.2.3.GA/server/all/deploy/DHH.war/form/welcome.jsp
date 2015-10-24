<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
 
<html> 
	<head>
		<title>RFID网络订货系统</title>
		<link rel="shortcut icon" href="../image/logo.ico" type="image/x-icon">
		<link rel="stylesheet" href="./css/common.css" type="text/css"></link>
		<script type="text/javascript" src="./js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript">
	    </script>
	</head>
	<body>
		<div id="bgcolor"></div>
		<div id="bg">
			<div id="welcome">
				<div id="img">
					<div id="greyRFID" class="img"></div>
					<div id="blueRFID" class="img"></div>
					<div class="clear"></div>
				</div>
				<div id="txt">请刷用户卡...</div>
				<div id="exit" onclick="window.close();">点击此处退出重新选择</div>
				<html:form action="/welcome">
					<html:hidden property="username"></html:hidden><br/>
					<html:hidden property="type"></html:hidden><br/>
				</html:form>
				<div id="rfid"></div>
				<% if (request.getAttribute("error") != null) { %>	
					<script type="text/javascript">
						alert('<%=request.getAttribute("error")%>');
					</script>
				<%}%>
			</div>
		</div>
		<script type="text/javascript">
            $('.img').click(function(){
            	$('.img').css('border','1px solid grey');
            	$(this).css('border','1px solid yellow');
            	$('.img').not(this).hide();
            	$('input').eq(1).val($(this).attr('id'));
            	$('#txt').show();
            	$('#exit').show();
            	if ($(this).attr('id')=='greyRFID') {
            		$('#rfid').html("<object id='RFIDReader' classid='clsid:0CBD6597-3953-4B88-8C9F-F58B1B023413' codebase='RFID/RFIDREADER.cab'></object>");
            	} else {
            		$('#rfid').html("<object id='RFIDReader' classid='clsid:E6A15262-D581-4AA3-98D3-5B9F83920EFE' codebase='RFID/RFIDREADER.cab'></object>");
            	}
            	clearInterval(getRfidData);
            	setInterval(getRfidData, 500);
            });
            
            var ischanged = "";
            function getRfidData() {
                //不能用Jquery的方法获取 $("#RFIDReader")
                var rfid = (document.getElementById("RFIDReader").CardNum);
                if (ischanged == rfid) return;
                ischanged = rfid;

				$('input').eq(0).val(ischanged);
				document.forms[0].submit();
            }
	    </script>
	</body>
</html>

