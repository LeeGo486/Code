<%option explicit%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridedittable.js"></SCRIPT>
<SCRIPT language="JavaScript">
var rsta=-1;
function gtDoSelect(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	
	parent.id=id;//在客户端共用的单据ID
	var sta=row.getElementsByTagName("input")[0];
	try{
		sta=parseInt(sta.value);
	}catch(ex){}
	if(rsta!=sta){
		switch(sta){
		case 0:
	  	  parent.edit();break;
		case 1:
	  	  parent.chksured();break;
		case 2:
	  	  parent.sured();break;
		default:
	  	  break;
		}
	    rsta=sta;
	}
}

function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	showModalDialog('f22_mx.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

  function gtDoEnter(t){}
</SCRIPT>
<script language="javascript">
function sendcard(id){
  showModalDialog('vip_sendcard_sub.asp?id='+id,'example04','dialogWidth:450px;dialogHeight:150px;center: yes;help:no;resizable:yes;status:no');
}
</script>
<STYLE>.cjol1 {
	BORDER-RIGHT: #708faf 1px solid; BORDER-TOP: #ffffff 1px solid; DISPLAY: inline; FLOAT: left; BORDER-LEFT: #ffffff 1px solid; WIDTH: 90px; BORDER-BOTTOM: 0px solid; POSITION: relative; TOP: 2px; HEIGHT: 16px; BACKGROUND-COLOR: #cbdced
}
.cjol2 {
	BORDER-RIGHT: #708faf 1px solid; BACKGROUND-POSITION: left top; BORDER-TOP: #ffffff 1px solid; Z-INDEX: 3; BORDER-LEFT: #ffffff 1px solid; WIDTH: 150px; BORDER-BOTTOM: 0px solid; BACKGROUND-REPEAT: no-repeat; POSITION: relative; TOP: 1px; HEIGHT: 19px; BACKGROUND-COLOR: #cbdced
}
.cjol3 {
	BORDER-RIGHT: #708faf 1px solid; BORDER-TOP: #cbdced; BORDER-LEFT: #ffffff 1px solid; WIDTH: 100%; BORDER-BOTTOM: #708faf 1px solid; BACKGROUND-COLOR: #cbdced; align: center; valign: top
}
.cjol4 {
	BORDER-RIGHT: #708faf 1px solid; WIDTH: 91px; HEIGHT: 1px; BACKGROUND-COLOR: #ffffff
}
.cjol5 {
	BORDER-RIGHT: #708faf 1px solid; BORDER-LEFT: #ffffff 1px solid; WIDTH: 150px; HEIGHT: 1px; BACKGROUND-COLOR: #cbdced
}
.DIVsrcoll {
	BORDER-RIGHT: #ffffff 1px solid; PADDING-RIGHT: 20px; BORDER-TOP: #a5bbd1 1px solid; OVERFLOW-Y: scroll; PADDING-LEFT: 20px; PADDING-BOTTOM: 20px; BORDER-LEFT: #a5bbd1 1px solid; WIDTH: 100%; PADDING-TOP: 20px; BORDER-BOTTOM: #ffffff 1px solid; HEIGHT: 100%; BACKGROUND-COLOR: #ffffff
}
HR {
	COLOR: #a5bbd1
}
.DIVsrcoll1 {
	BORDER-RIGHT: #ffffff 1px solid; PADDING-RIGHT: 20px; BORDER-TOP: #a5bbd1 1px solid; OVERFLOW-Y: scroll; PADDING-LEFT: 20px; PADDING-BOTTOM: 20px; BORDER-LEFT: #a5bbd1 1px solid; WIDTH: 100%; PADDING-TOP: 20px; BORDER-BOTTOM: #ffffff 1px solid; HEIGHT: 100%; BACKGROUND-COLOR: #ffffff
}
.cjol31 {
	BORDER-RIGHT: #708faf 1px solid; BORDER-TOP: #cbdced; BORDER-LEFT: #ffffff 1px solid; WIDTH: 100%; BORDER-BOTTOM: #708faf 1px solid; BACKGROUND-COLOR: #cbdced; align: center; valign: top
}
.DIVsrcoll11 {
	BORDER-RIGHT: #ffffff 1px solid; PADDING-RIGHT: 20px; BORDER-TOP: #a5bbd1 1px solid; OVERFLOW-Y: scroll; PADDING-LEFT: 20px; PADDING-BOTTOM: 20px; BORDER-LEFT: #a5bbd1 1px solid; WIDTH: 100%; PADDING-TOP: 20px; BORDER-BOTTOM: #ffffff 1px solid; HEIGHT: 100%; BACKGROUND-COLOR: #ffffff
}
.cjol311 {
	BORDER-RIGHT: #708faf 1px solid; BORDER-TOP: #cbdced; BORDER-LEFT: #ffffff 1px solid; WIDTH: 100%; BORDER-BOTTOM: #708faf 1px solid; BACKGROUND-COLOR: #cbdced; align: center; valign: top
}

</STYLE>

</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">&nbsp;</td>
  </tr>
</table>
<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD height=16>
      <TABLE id=cjolTable cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR align=middle height=16>
          <TD class=cjol2 id=tdCreateAccount><INPUT style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; FONT-SIZE: 12px; BORDER-LEFT: 0px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 14px; BACKGROUND-COLOR: #cbdced" type=button value=" 发放生日礼物 "></TD>
        </TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD height=3>
      <TABLE id=linecolor height=3 cellSpacing=0 cellPadding=0 width="100%" 
      border=0>
        <TBODY>
        <TR>
          <TD class=cjol5></TD>
          <TD bgColor=#ffffff></TD>
          <TD bgColor=#ffffff></TD>
          <TD style="BORDER-BOTTOM: #ffffff 1px solid"><IMG height=1 
        src=""></TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD valign="top">
	
      <TABLE id=mainTable height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
        
		<TBODY >
        <TR>
          <TD vAlign=top>
            <TABLE class=cjol311 height="100%" cellSpacing=0 cellPadding=9 
            width="100%" border=0>
              <TBODY>
              <TR>
                <TD 
                style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px" 
                vAlign=top>
				<iframe frameborder="0" scrolling="no" width="100%" height="180" marginheight="0" marginwidth="0" name="a" src="vip_chk.asp" ></iframe>
                  <br>
                  <br>
                  <iframe frameborder="0" scrolling="no" width="100%" height="180" marginheight="0" marginwidth="0" name="b" src="vip_lw.asp" ></iframe></TD>
              </TR></TBODY></TABLE></TD></TR><!--fffffffff-->
				  
		
		</TABLE></TD>
  </TR>
  <TR>
    <TD height=46>&nbsp;      </TD>
  </TR></TBODY></TABLE>


</body>
</html>
