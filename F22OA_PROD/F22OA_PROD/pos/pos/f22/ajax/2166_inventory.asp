<!--#include file="../inc/function.asp"-->
<%
id = trim(request("id"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<title>�̵�ɨ��</title>
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
	
	$("#submit1").click(submitdata);
	
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
    {alert('�������ͣ�');obj.focus();}
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
  
	obj = chkclothing('2166_inventory_save.asp?date()',str);

  if(obj=='true')
  {
     PlayScanSound();
     var i=parseInt($("#calNum").text());
		 i=i+(typ*nums);
     $("#calNum").text(i.toString(10));
			//if($("#gridcontent").html())
			//	getRow(clothingid);		//������¼
			//else
				getRow();
  }
  else
  {
     alert("��Ų����ڻ������ȡλ����ȷ��");
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
	
	//������������
	$("#gridcontent").load(url,{'format': 'html','act': act,'id':id,'record':record});	
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

</script>
</head>

<body onLoad="document.all.key.focus()">
<embed id="soundControl" src="../../../../sound/scan.wav"  mastersound hidden="true" loop="false" autostart="false"></embed>
<table width="100%" border="0" class="bar">
  <tr>
    <td>ҵ����� &gt;&gt; �̵����ɨ��</td>
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
     response.Write("<script>alert('��������ˣ�');history.go(-2);</script>")
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
    <td>����: <%=id%> �Ƶ�����: <%=cr_date%></td>
  </tr>
</table>
<table width="100%" border="0">
  <tr>
    <td>
      ����:
      <input name="key" type="text" id="key"><input name="clothingid" type="hidden" id="clothingid">
	  <label><input type="radio" name="typ" id="typ" value="1" checked>��</label>
	  <label><input type="radio" name="typ" id="typ" value="-1">��</label>
	  ���� <input type="text" name="nums" id="nums" size="1" value="1" onKeyPress="chkkp()" onBlur="chkblur(this)" onFocus="this.select()">
	  <input type="button" name="submit1" id="submit1" value="ȷ��" />
	  <input name="id" type="hidden" id="id" value="<%=id%>">
	  �����ȡ��<input type="text" name="tmln" id="tmln" size=3 value="<%=session("postm_ln")%>" onKeyPress="chkkp()" onBlur="chkblur(this)" onFocus="this.select()">
    ��ʾ������ <input type="text" name="record" id="record" size="1" value="5"
    title="0Ϊ��ʾ����ɨ���¼
    ��Ϊ���ɨ���ٶȣ����鲻ȫ����ʾ��"
     onKeyPress="chkkp()" onBlur="chkblur(this)" onFocus="this.select()"
      onKeyDown="if(event.keyCode==13){getRow();event.keyCode=0;return false;}">
    </td>
    <td>������ <strong><span id="calNum" style="font-size:18px;color:red">0</span></strong>&nbsp;&nbsp;
       <input name="bu2" type="button" value="����������" onClick="javascript:document.getElementById('calNum').innerText='0';">
	   <input name="bu3" type="button" value="���ز�ѯ����" onClick="javascript:location.href='../search_frame.asp?action=search'">
	</td>
  </tr>
</table>
<table width="98%" border="0" class="jsongrid" cellpadding="3" cellspacing="1" align="center">
  <thead>
    <tr><th>�� ��</th><th>��ʽ����</th><th>�� ɫ</th><th>�� ��</th><th>�� ��</th><th>�� ��</th><th>�� ��</th></th>
  </thead>
  <tbody id="gridcontent"></tbody>
</table>
</body>
</html>
