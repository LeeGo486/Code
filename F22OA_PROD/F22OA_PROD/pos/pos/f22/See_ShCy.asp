<!--#include file="inc/function.asp"-->
<!--#include file="report/inc/class.asp"-->
<%Dim act
act=request.QueryString("act")
if cint(act)=1 then
  response.ContentType ="application/vnd.ms-excel"
end if

types=request("types")
id=request("id")
formid=request("formid")%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�鿴�ջ����졪<%=id%></title>
<link href="report/css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="report/inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="report/inc/gridtable.js"></SCRIPT>
<script type="text/javascript">
function expe()
{
   window.location.href="see_shcy.asp?formid=<%=formid%>&id=<%=id%>&types=1&act=1";
}
</script>
</head>

<body>
<%
if types="" then
   response.write("<iframe  name=is src='see_shcy.asp?formid="&formid&"&id="&id&"&types=1' width=100% height=100% frameborder=0></iframe>")
else
select case formid
case 2062 sql="select a.clothingid,a.styleid,c.s_name,a.colorid,d.c_name,a.sizeid,"&_
              "a.set_nums,b.nums as get_nums,isnull(a.set_nums,0)-isnull(b.nums,0) as ce "&_
              "from d_sellsub a left join (select * from webtmp_barcodeget where id='"&id&"') b on a.sellid=b.id and a.clothingid=b.clothingid "&_
              "inner join j_style c on a.styleid=c.styleid inner join j_color d on a.colorid=d.colorid "&_
              "where a.sellid='"&id&"' order by a.clothingid"
case 2068 sql="select a.clothingid,a.styleid,c.s_name,a.colorid,d.c_name,a.sizeid,"&_
              "a.set_nums,b.nums as get_nums,isnull(a.set_nums,0)-isnull(b.nums,0) as ce "&_
              "from d_movesub a left join (select * from webtmp_barcodeget where id='"&id&"') b on a.moveid=b.id and a.clothingid=b.clothingid "&_
              "inner join j_style c on a.styleid=c.styleid inner join j_color d on a.colorid=d.colorid "&_
              "where a.moveid='"&id&"' order by a.clothingid"
case 2069 sql="select a.clothingid,a.styleid,c.s_name,a.colorid,d.c_name,a.sizeid,"&_
              "a.set_nums,b.nums as get_nums,isnull(a.set_nums,0)-isnull(b.nums,0) as ce "&_
              "from d_msellsub a left join (select * from webtmp_barcodeget where id='"&id&"') b on a.msellid=b.id and a.clothingid=b.clothingid "&_
              "inner join j_style c on a.styleid=c.styleid inner join j_color d on a.colorid=d.colorid "&_
              "where a.msellid='"&id&"' order by a.clothingid"
end select
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
t.SetField "clothingid","���","100",3
t.SetField "styleid","��ʽ���","80",0
t.SetField "s_name","��ʽ����","100",4
t.SetField "colorid","ɫ��","50",4
t.SetField "c_name","ɫ��","60",4
t.SetField "sizeid","����","50",4
t.SetField "set_nums","��������","60",1
t.SetField "get_nums","�������","60",1
t.SetField "ce","�ջ�����","60",1
t.height="93%"
t.show
set t = nothing%>
<script language="javascript">
try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
<table width="100%" border="0" cellpadding="0" cellspacing="1">
  <tr align="center">
    <td><input type="button" name="exp" value="����Excel" onClick="expe()">
	<input type="button" value=" �� �� " onClick="window.close()"></td>
  </tr>
</table>
<%end if%>
</body>
</html>
