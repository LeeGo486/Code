<!--#include file="../inc/function.asp"-->
<%
id = trim(request("id"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<title>盘点扫描</title>
<style type="text/css">
.jsongrid{
	text-align:center;
	background:#C6E7FF;
	}
.jsongrid th{
	}
.jsongrid td{
	background:#fff;
	}
</style>
<script type="text/javascript" src="../../../../scripts/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="../../../../js/sound.js"></script>
<script language="javascript">
$(function(){
	$("#key")
	.keydown(function(){
			if(event.keyCode==13)
			{ 
			     
			   	   if($("#key").val()=='')
				   {

						$("#key").focus();
						return false;
					}
					
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
	
	//$("#submit1").click(submitdata);
	
	getRow()
	
});

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

function submitdata()
{ 
   
  var str,obj,typ,nums,id,clothingid;
  typ= $("input:checked[@name=typ]").val()
  id = $("#id").val()
  clothingid = $("#clothingid").val()
  nums=parseInt($("#nums").val());
  str = 'id='+id+'&clothingid='+clothingid+'&typ='+typ+'&tmln='+$("#tmln").val()+'&nums='+nums;

  obj = chkclothing('2066_inventory_save.asp?date()',str);

  if(obj=='true')
  {
     PlayScanSound();
     var i=parseInt($("#calNum").text());
		 i=i+(typ*nums);
     $("#calNum").text(i.toString(10));
			//if($("#gridcontent").html())
			//	getRow(clothingid);		//单条记录
			//else
				getRow();
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

function getRow(clothingid)
{
	var act = 'd_inventory';
	var url = "GetDataJson.asp";
	var id = $("#id").val();
	var record = $("#record").val();
	
	//加载所有数据
	$("#gridcontent").load(url,{'format': 'html','act': act,'id':id,'record':record});	
	
/*	if(clothingid)
	{
		if($("#"+clothingid).length==0){
			$("#gridcontent").prepend('<tr id="'+clothingid+'"></tr>')
		}
		else
		{
			setTotal(clothingid,-1)
		}
		//加载单个款的值
		$("#"+clothingid).load(url,
													 {'format': 'html','act': act,'id':id,'clothingid':clothingid,'record':4},
													 function(){
															setTotal(clothingid,1)
													});	
	}
	else
	{
	}
*/
}

//
function setTotal(clothingid,n)
{
	if($("#"+clothingid).html()==''){
		$("#"+clothingid).remove();
	}else{
		var ttd = $("#totaltr td");
		var ctd = $("#"+clothingid+" td");
		ttd.eq(4).text(parseFloat(ttd.eq(4).text())+(parseFloat(ctd.eq(4).text())*n));
		ttd.eq(5).text(parseFloat(ttd.eq(5).text())+(parseFloat(ctd.eq(5).text())*n));
		ttd.eq(6).text(parseFloat(ttd.eq(6).text())+(parseFloat(ctd.eq(6).text())*n));
	}
}

/*
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
*/
</script>
</head>

<body onLoad="document.all.key.focus()">
<embed id="soundControl" src="../../../../sound/scan.wav"  mastersound hidden="true" loop="false" autostart="false"></embed>
<table width="100%" border="0" class="bar">
  <tr>
    <td>业务操作 &gt;&gt; 盘点扫描</td>
  </tr>
</table> 
<%

set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn

sql = "select depotid,crdate,chk_sure from d_inventory where inventoryid="&qts(id)
rs.source = sql
rs.open
if rs.eof then
  response.End()
else
  if cint(rs("chk_sure"))>0 then
     response.Write("<script>alert('单据已审核！');history.go(-2);</script>")
     response.end
  end if
  setdepotid=rs("depotid")
  cr_date=rs("crdate")
end if
rs.close
set rs = nothing
cn.close
set cn= nothing
%>
<table width="100%" border="0" class="f14">
  <tr>
    <td>单号: <%=id%> 制单日期: <%=cr_date%></td>
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
	  条码截取：<input type="text" name="tmln" id="tmln" size=3 value="<%=session("postm_ln")%>" onKeyPress="chkkp()" onBlur="chkblur(this)" onFocus="this.select()">
    显示条数： <input type="text" name="record" id="record" size="1" value="5"
    title="0为显示所有扫描记录
    （为提高扫描速度，建议不全部显示）"
     onKeyPress="chkkp()" onBlur="chkblur(this)" onFocus="this.select()"
      onKeyDown="if(event.keyCode==13){getRow();event.keyCode=0;return false;}">
    </td>
    <td>计数器 <strong><span id="calNum" style="font-size:18px;color:red">0</span></strong>&nbsp;&nbsp;
       <input name="bu2" type="button" value="计数器清零" onClick="javascript:document.getElementById('calNum').innerText='0';">
	   <input name="bu3" type="button" value="返回查询界面" onClick="javascript:location.href='../search_frame.asp?action=search'">
	</td>
  </tr>
</table>
<table width="98%" border="0" class="jsongrid" cellpadding="3" cellspacing="1" align="center">
  <thead>
    <tr><th>款 号</th><th>款式名称</th><th>颜 色</th><th>尺 码</th><th>数 量</th><th>单 价</th><th>总 额</th></th>
  </thead>
  <tbody id="gridcontent"></tbody>
</table>
</body>
</html>
