<!--#include file="../inc/function.asp"-->
<%
id = trim(request("id"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<title>扫描</title>
<script type="text/javascript" src="../../../../scripts/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="../../../../js/sound.js"></script>
<script language="javascript">
function clothing(id){
  showModalDialog('../clothing.asp?id='+id,'example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}

function chkkp()
{
  if(event.keyCode<45||event.keyCode>57){event.returnValue = false;}
}

function chkblur(obj)
{ 
  if(isNaN(obj.value))
    {alert('错误类型！');obj.focus();}
  obj.value=Math.floor(obj.value);
  if(obj.value<0)
    {obj.value=1;}
}

$(function(){
	$("#key")
	.keydown(function(){									
			if(event.keyCode==13)
			{
			    if($("#key").val()=='')
				  {$("#key").focus();
				   return false;}
				var clothingid=$("#key").val();
			    $("#clothingid").val(clothingid.toUpperCase());
				$("#key").val('');
				$("#key").select();
				$("#key").focus();
				$("#submit1").click();
				event.keyCode=0;
				return false;
			}
	})
});
  
function submitdata()
{ var str,obj,typ,nums,getdepotid;
  if($("#typ").eq(0).attr('checked'))
    {typ=1;}
  else
    {typ=-1;}
  nums=parseInt($("#nums").val());
  getdepotid=$("#getdepotid").val();
  str = 'id='+$("#id").val()+'&clothingid='+$("#clothingid").val()+'&typ='+typ+'&tmln='+$("#tmln").val()+'&nums='+nums+'&getdepotid='+getdepotid;
  
  obj = chkclothing('2071_msell_save.asp?date()',str);
  if(obj=='true')
  {
     PlayScanSound();
     var i=parseInt($("#calNum").text());
	 i=i+(typ*nums);
     $("#calNum").text(i.toString(10));
	 getjson('GetDataJson.asp?date()','act=d_msellset&id='+$("#id").val());
  }
  else if (obj=='no')
  {
     alert("此货品不在通知单内！");
     $("#key").focus();
	 $("#key").select();
  }
  else if (obj=='nums')
  {
     alert("此货品的发货数量不能超过通知单内的发货数量！");
     $("#key").focus();
	 $("#key").select();
  }
  else if (obj=='StylePower')
  {
     alert("收货方或发货方没有经营此款式的权限！");
     $("#key").focus();
	 $("#key").select();
  }
  else if(obj=='flow'){
    alert("系统已设置为启用记录条码流水号，不能录入重复的条码！");
     $("#key").focus();
		 $("#key").select();
  }
  else
  {
     alert("款号不存在或条码截取位不正确！");
     $("#key").focus();
	 $("#key").select();
  }
}

function chkclothing(url,data)
{
   var html = $.ajax({
        url: url,
        type: "POST",
		dataType: "html",
        data: data,
        async: false
        }).responseText;
        return html;
}

function getjson(url,data)
{
	$.ajax({
	url: url,
	type: "post",
	dataType: "json",
	data: data,
	async: false,
	success: function(msg) {
           var json = msg["data"];
           $("#gridcontent").empty();
		   var zn=0;
		   var zs=0;
           $.each(json,function(i,o){
            var row=$("#sub_template").clone();
			    row.find("#sub_clothingid").html('<a href=javascript:clothing("'+o.clothingid+'")>'+o.clothingid+'</a>');
				row.find("#sub_sname").text(o.s_name);
                row.find("#sub_colorid").text(o.colorid+o.c_name);
                row.find("#sub_sizeid").text(o.sizeid);
                row.find("#sub_nums").text(o.nums);
				row.find("#sub_xprice").text(o.x_price);
				row.appendTo("#gridcontent");
                row.show();
				zn=zn+parseInt(o.nums);
				zs=zs+parseInt(o.nums)*parseFloat(o.x_price);
			});
		   $("#z_nums").text(zn.toString(10));
		   $("#z_xprice").text(zs.toString(10));
		}
	})
}

</script>
</head>

<body onLoad="document.all.key.focus()">
<embed id="soundControl" src="../../../../sound/scan.wav"  mastersound hidden="true" loop="false" autostart="false"></embed>
<table width="100%" border="0" class="bar">
  <tr>
    <td>业务操作 &gt;&gt; 条码跨区调货 </td>
  </tr>
</table> 
<%

set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn

rs.source = "select setchk_sure from d_msell where msellid="&qts(id)
rs.open
if not rs.eof then
if rs(0)>0 then
     response.write("<script>alert('此单已审核，不可以扫描!');history.go(-2);</script>")
	 response.end
end if
end if
rs.close	

sql = "select a.get_depotid,b.d_name as get_depotname,setcr_date from d_msell a,j_depot b where a.get_depotid=b.depotid and msellid="&qts(id)
rs.source = sql
rs.open
if rs.eof then
  response.End()
else
  getdepotid=rs("get_depotid")
  getdptname=rs("get_depotname")
  cr_date=rs("setcr_date")
end if
rs.close
set rs = nothing
cn.close
set cn= nothing
%>
<input type="hidden"  name="getdepotid" id="getdepotid"  value="<%=getdepotid%>"> 
<table width="100%" border="0" class="f14">
  <tr>
    <td>单号: <%=id%> 收货地: <%=getdptname%>(<%=getdepotid%>) 制单日期: <%=cr_date%></td>
  </tr>
</table>
<table width="100%" border="0">
  <tr>
    <td>
      条码:
      <input name="key" type="text" id="key"><input name="clothingid" type="hidden" id="clothingid">
	  <label><input type="radio" name="typ" id="typ" value="1" checked>正</label>
	  <label><input type="radio" name="typ" id="typ" value="-1">负</label>
	  数量 <input type="text" name="nums" id="nums" size="1" value="1" onKeyPress="chkkp()" onBlur="chkblur(this)" onFocus="this.select()">
	  <input type="button" name="submit1" id="submit1" value="确定" onClick="submitdata()">
	  <input name="id" type="hidden" id="id" value="<%=id%>">
	  条码截取<input type="text" name="tmln" id="tmln" size=3 value="<%=session("postm_ln")%>" onKeyPress="chkkp()" onBlur="chkblur(this)" onFocus="this.select()">
    </td>
    <td>计数器 <strong><span id="calNum" style="font-size:18px;color:red">0</span></strong>&nbsp;&nbsp;
       <input name="bu2" type="button" value="计数器清零" onClick="javascript:document.getElementById('calNum').innerText='0';">
	   <input name="bu3" type="button" value="返回查询界面" onClick="javascript:location.href='../search_frame.asp?action=search'">
	</td>
  </tr>
</table>
<table width="100%" border="1" class="f14" bordercolordark="#FFEFEF">
  <thead>
    <tr align="center"><td>款 号</td><td>款式名称</td><td>颜 色</td><td>尺 码</td><td>数 量</td><td>单 价</td></tr>
	<tr bgcolor="#C6E7FF" align="center"><td>合 计</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td id="z_nums"></td><td id="z_xprice"></td></tr>
	<tr align=center id="sub_template"><td id="sub_clothingid"></td><td id="sub_sname"></td><td id="sub_colorid"></td><td id="sub_sizeid"></td><td id="sub_nums"></td><td id="sub_xprice"></td></tr>
  </thead>
  <tbody id="gridcontent"></tbody>
</table>
<script type="text/javascript">
getjson('GetDataJson.asp?date()','act=d_msellset&id='+$("#id").val());
</script>
</body>
</html>
