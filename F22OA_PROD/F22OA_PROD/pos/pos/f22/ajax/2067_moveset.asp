<!--#include file="../inc/function.asp"-->
<%
dim get_depotid
id = trim(request("id"))
get_depotid = trim(request("get_depotid"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<title>ɨ��</title>
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
    {alert('�������ͣ�');obj.focus();}
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
{ var str,obj,typ,nums;
  if($("#typ").eq(0).attr('checked'))
    {typ=1;}
  else
    {typ=-1;}
  nums=parseInt($("#nums").val());
  str = 'id='+$("#id").val()+'&clothingid='+$("#clothingid").val()+'&typ='+typ+'&tmln='+$("#tmln").val()+'&nums='+nums+'&get_depotid='+$("#get_depotid").val();
 

  obj = chkclothing('2067_moveset_save.asp?date()',str);
  if(obj=='true')
  {
     PlayScanSound();
     var i=parseInt($("#calNum").text());
	 i=i+(typ*nums);
     $("#calNum").text(i.toString(10));
	 getjson('GetDataJson.asp?date()','act=d_movesetjh&id='+$("#id").val());
  }
  else if (obj=='StylePower')
  {
     alert("�ջ����򷢻���û�о�Ӫ�˿�ʽ��Ȩ�ޣ�");
     $("#key").focus();
	 $("#key").select();
  }else if (obj=='no')
  {
     alert("�˻�Ʒ����֪ͨ���ڣ�");
     $("#key").focus();
	 $("#key").select();
  }
  else if (obj=='nums')
  {
     alert("�˻�Ʒ�ļ���������ܳ���֪ͨ����֪ͨ����������");
     $("#key").focus();
	 $("#key").select();
  }
  else if(obj=='flow'){
    alert("ϵͳ������Ϊ���ü�¼������ˮ�ţ�����¼���ظ������룡");
     $("#key").focus();
		 $("#key").select();
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
 	       var tn=0;
		   var jn=0;
		   var cn=0;
		   var zs=0;
           $.each(json,function(i,o){
            var row=$("#sub_template").clone();
			    row.find("#sub_clothingid").html('<a href=javascript:clothing("'+o.clothingid+'")>'+o.clothingid+'</a>');
				row.find("#sub_sname").text(o.s_name);
                row.find("#sub_colorid").text(o.colorid+o.c_name);
                row.find("#sub_sizeid").text(o.sizeid);
			    row.find("#sub_tnums").text(o.tz_nums);
                //row.find("#sub_nums").text(o.nums);
			    row.find("#sub_jnums").text(o.jnums);
				row.find("#sub_cnums").text(o.diff_nums);
				row.find("#sub_xprice").text(o.x_price);
				row.find("#sub_comment").html(o.comment+' ');
				noticeid=o.noticeid;
				row.appendTo("#gridcontent");
                row.show();
				tn=tn+parseInt(o.tz_nums);
				zn=zn+parseInt(o.nums);
				jn=jn+parseInt(o.jnums);
				cn=cn+parseInt(o.diff_nums);
				zs=zs+parseInt(o.nums)*parseFloat(o.x_price);
				if (o.noticeid==''){
					row.find("#sub_tnums").hide();
		   			row.find("#sub_cnums").hide();
 				    row.find("#sub_jnums").hide();
				}else{
					row.find("#sub_tnums").show();
		   			row.find("#sub_cnums").show();				
				 	row.find("#sub_jnums").show();
				}
			});
		   $("#z_nums").text(zn.toString(10));
 	       $("#t_nums").text(tn.toString(10));
		   $("#j_nums").text(jn.toString(10));
		   $("#c_nums").text(cn.toString(10));
		   $("#z_xprice").text(zs.toString(10));
		   if (noticeid==''){
		       $("#t_nums").hide();
		       $("#c_nums").hide();
			   $("#j_nums").hide();
		       $("#t_numstitle").hide();
		       $("#c_numstitle").hide()
			   $("#j_numstitle").hide()
		   }else{
		   	   $("#t_nums").show();
		       $("#c_nums").show();
   			   $("#j_nums").show();
		       $("#t_numstitle").show();
		       $("#c_numstitle").show()
			   $("#j_numstitle").show()			   
		   }		  
		}
	})
}
//ͬ������
function Syncnums()
{
    if (!confirm("ȷ���������������������?�����󷢻�����ͬ���ɼ����.")){return false;}
	var url='2067_moveset_Sync.asp?date()';
	data = 'id='+$("#id").val();
 	var html = $.ajax({
    url: url,
    type: "POST",
    dataType: "html",
    data: data,
    async: false
    }).responseText;
	getjson('GetDataJson.asp?date()','act=d_movesetjh&id='+$("#id").val());
}
</script>
</head>

<body onLoad="document.all.key.focus()">
<embed id="soundControl" src="../../../../sound/scan.wav"  mastersound hidden="true" loop="false" autostart="false"></embed>
<table width="100%" border="0" class="bar">
  <tr>
    <td>ҵ����� &gt;&gt; ���η������ </td>
  </tr>
</table> 
<%

set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn

rs.source = "select setchk_sure from d_move where moveid="&qts(id)
rs.open
if not rs.eof then
if rs(0)>0 then
     response.write("<script>alert('�˵�����ˣ�������ɨ��!');history.go(-2);</script>")
	 response.end
end if
end if
rs.close

sql = "select a.get_depotid,b.d_name,a.crdate from d_move a,j_depot b where a.moveid="&qts(id)&" and a.get_depotid=b.depotid"
rs.source = sql
rs.open
if rs.eof then
  response.End()
else
  setdepotid=rs("get_depotid")
  setdptname=rs("d_name")
  cr_date=rs("crdate")
end if
rs.close
set rs = nothing
cn.close
set cn= nothing
%>
<table width="100%" border="0" class="f14">
  <tr>
    <td>����: <%=id%> �ջ���: <%=setdptname%>(<%=setdepotid%>) �Ƶ�����: <%=cr_date%></td>
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
	  <input type="button" name="submit1" id="submit1" value="ȷ��" onClick="submitdata()">
	  <input name="id" type="hidden" id="id" value="<%=id%>">
	   <input name="id" type="hidden" id="get_depotid" value="<%=get_depotid%>">
	  �����ȡ<input type="text" name="tmln" id="tmln" size=3 value="<%=session("postm_ln")%>" onKeyPress="chkkp()" onBlur="chkblur(this)" onFocus="this.select()">
    </td>
    <td align="left">
	  ������ <strong><span id="calNum" style="font-size:18px;color:red">0</span></strong>&nbsp;&nbsp;
       <input name="bu2" type="button" value="����������" onClick="javascript:document.getElementById('calNum').innerText='0';">
	   <input name="bu3" type="button" value="���ز�ѯ����" onClick="javascript:location.href='../search_frame.asp?action=search'">
	</td>
  </tr>
</table>
<table width="100%" border="1" class="f14" bordercolordark="#FFEFEF">
  <thead>
    <tr align="center">
	<td>�� ��</td>
	<td>��ʽ����</td>
	<td>�� ɫ</td>
	<td>�� ��</td>
	<td id="t_numstitle" style="display:none">֪ͨ����</td>
	<td id="j_numstitle" style="display:none">�������</td>
	<td id="c_numstitle" style="display:none">��������</td>
	<td>�� ��</td>
	<td>���ע</td>
	</tr>
	<tr bgcolor="#C6E7FF" align="center">
	<td>�� ��</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td id="t_nums" style="display:none"></td>
	<td id="z_nums"></td>
	<td id="j_nums" style="display:none"></td>
	<td id="c_nums" style="display:none"></td>
	<td id="z_xprice"></td>
	<td>&nbsp;</td>
	</tr>
	<tr align=center id="sub_template">
	<td id="sub_clothingid"></td>
	<td id="sub_sname"></td>
	<td id="sub_colorid"></td>
	<td id="sub_sizeid"></td>
	<td id="sub_tnums" style="display:none"></td>
	<td id="sub_jnums" style="display:none"></td>
	<td id="sub_cnums" style="display:none"></td>
	<td id="sub_xprice"></td>
	<td id="sub_comment"></td>
	</tr>
  </thead>
  <tbody id="gridcontent"></tbody>
</table>
<script type="text/javascript">
getjson('GetDataJson.asp?date()','act=d_movesetjh&id='+$("#id").val());
</script>
</body>
</html>
