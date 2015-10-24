<%option explicit
on error resume next%>
<!--#include file="../inc/const.asp" -->
<!--#include file="inc/function.asp"-->
<%dim oldformid,djid
set cn=nothing
oldformid=request("oldformid")
djid=request("djid")%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/f22.css" rel="stylesheet" type="text/css">
<title>单据拷贝</title></head>
<script language="javascript">
function opensub(v){
var s='djcopysub.asp?oldformid=<%=oldformid%>&newformid='+v+'&djid=<%=djid%>';
  document.all.iFrmRef.src=s;
}
</script>
<body> 
<table width="750" border="0" align="center">
  <tr>
    <td><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="159"> 
            <table width="150" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="22"><font class="f12">可以拷贝的单据列表</font></td>
              </tr>
              <tr>
                <td><select name="select" size="20" onDblClick="opensub(this.value)">
                    <option value="1005">1005 订货单</option>
					<option value="1006">1006 补货单</option>
					<!--<option value="1007">1007 铺场计划单</option>-->
					<!--<option value="1008">1008 配货单</option>-->
					<!--<option value="1009">1009 发货单</option>-->
					<option value="1010">1010 收货单</option>
					<option value="1011">1011 退货申请单</option>
					<!--<option value="1012">1012 特殊退货申请单</option>-->
					<!--<option value="1013">1013 退货审批单</option>-->
					<option value="1014">1014 退货发货单</option>
					<!--<option value="1015">1015 退货收货单</option>-->
					<option value="1017">1017 调拨发货单</option>
					<option value="1018">1018 调拨收货单</option>
					<option value="1019">1019 盘点单</option>
					<!--<option value="1020">1020 盘点差异单</option>-->
					<option value="1021">1021 零售单</option>
					<option value="1022">1022 跨区调货单</option>
                  </select></td>
              </tr>
            </table>
          </td>
          <td width="585">
		  <iFrame Name=iFrmRef id=iFrmRef SRC="djcopysub.asp?oldformid=<%=oldformid%>&newformid=&djid=<%=djid%>" width="100%" height="100%" scrolling="auto" frameborder="0"></iFrame>
		  </td>
        </tr>
    </table></td>
  </tr>
</table>
<table width="746" height="32" border="0" align="center" class="tcontent">
  <tr>
    <td width="50%" height="26" align=center><input type="radio" name="copytype" value=0 checked>在原单上累加选中单据的数量
        <input type="radio" name="copytype" value=1>取反数</td>
    <td width="50%" align="center">
	<input type="button" name="Submit1" value="拷贝(C)" onClick="iFrmRef.subm();" accesskey="c">
	<input type="button" name="Submit" value="退出(X)" onClick="window.close();" accesskey="x"></td>
  </tr>
</table>
</body>
</html>