<%@ page language="C#" autoeventwireup="true" inherits="OA_isprit_Module_selectdepart, App_Web_selectdepart.aspx.a91202c5" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    		<title>选择人员</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<LINK href="table.css" type="text/css" rel="STYLESHEET">
		<base target="_self">
<script language="JavaScript">
//var parent_window = parent.dialogArguments;

var fid = top.Ext.getCmp("doc-body").getActiveTab().title;
fid = "iframe-" + fid;
var prt = top.document;
var parent_window = prt.frames ? prt.frames[fid].document : prt.getElementById(fid).contentDocument;

function click_user(user_id){
	var toId   = parent_window.getElementById("TO_ID3");
	var toName = parent_window.getElementById("TO_NAME3");
	
	targetelement=window.document.getElementById(user_id);
	user_name=targetelement.innerHTML;

	//转换格式
	var userid = user_id+",";
	var username = user_name+",";

	//判断该内容是否存在，如果不存在，则增加
  if(toId.value.indexOf(","+userid)<0 && toId.value.indexOf(userid)!=0){
	toId.value   += userid;
	toName.value += username;
	borderize_on(targetelement);
  }else{
	toId.value   = toId.value.replace(userid,"");
	toName.value = toName.value.replace(username,"");
	borderize_off(targetelement);
  }
}

function borderize_on(targetelement){
 color="#003FBF";
 targetelement.style.borderColor="black";
 targetelement.style.backgroundColor=color;
 targetelement.style.color="white";
 targetelement.style.fontWeight="bold";
}

function borderize_off(targetelement)
{
  targetelement.style.backgroundColor="";
  targetelement.style.borderColor="";
  targetelement.style.color="";
  targetelement.style.fontWeight="";
}

function begin_set(){
//获取TO_ID的值
var TO_VAL=parent_window.getElementById("TO_ID3").value;
//遍历所有标签
var tn = document.getElementsByTagName("*");
	for(var i=0; i<tn.length; i++){
		//遍历所有class名称为menulines的
		if(tn[i].className=="menulines"){
			//已经选择的
			if(TO_VAL.indexOf(","+tn[i].id+",")>0 || TO_VAL.indexOf(tn[i].id+",")==0){
				//改变已选择的样式
				borderize_on(tn[i]);
			}
		}
	}
}

function add_all(){
	var TO_VAL=parent_window.getElementById("TO_ID3").value;
	var tn = document.getElementsByTagName("*");
	for (i=0; i<tn.length; i++){
	if(tn[i].className=="menulines"){
       if(TO_VAL.indexOf(","+tn[i].id+",")<0 && TO_VAL.indexOf(tn[i].id+",")!=0){
		   click_user(tn[i].id);
	   }
    }
  }
}

function del_all(){
	var TO_VAL=parent_window.getElementById("TO_ID3").value;
	var tn = document.getElementsByTagName("*");
	for (i=0; i<tn.length; i++){
	if(tn[i].className=="menulines"){
       if(TO_VAL.indexOf(","+tn[i].id+",")>0 || TO_VAL.indexOf(tn[i].id+",")==0){
		   click_user(tn[i].id);
	   }
    }
  }
}
</script>
</head>
<body topmargin="0" leftmargin="0" onload="begin_set()">
    <form id="form1" runat="server">
    <div>
    <table  border="0" align="center" cellpadding="1" cellspacing="1" style="WIDTH: 269px;"
				bgColor="honeydew" tabIndex="4">
				<tr>
					<td align="center" valign="top" style="WIDTH: 137px;">
						<br>
						</td>
					<td rowspan="2" align="center" valign="top" style="width: 153px;">
						<TABLE id="tbmain" cellSpacing="0" cellPadding="0" width="150" border="0" style="WIDTH: 150px; HEIGHT: 44px"
							tabIndex="3">
							<TR>
								<TD style="CURSOR: hand; HEIGHT: 12px" onclick="add_all()" align="center" bgColor="#33cccc"><FONT face="宋体" size="2">选择所有部门</FONT></TD>
							</TR>
							<TR>
								<TD style="CURSOR: hand; HEIGHT: 18px" onclick="del_all()" align="center" bgColor="#6699cc"><FONT face="宋体" size="2">取消所有部门</FONT></TD>
							</TR>
							<TR>
								<TD vAlign="top" align="center"><table width="100" cellpadding="0" cellspacing="0" border="0">
										<asp:datalist id="dluser" runat="server" Width="100%" BackColor="White" BorderWidth="1px" GridLines="Horizontal"
											CellPadding="3" BorderStyle="None" BorderColor="#E7E7FF">
											<SelectedItemStyle Font-Bold="True" ForeColor="#F7F7F7" BackColor="#738A9C"></SelectedItemStyle>
											<AlternatingItemStyle BackColor="#F7F7F7"></AlternatingItemStyle>
											<FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE"></FooterStyle>
											<ItemStyle ForeColor="#4A3C8C" BackColor="#E7E7FF"></ItemStyle>
											<ItemTemplate>
												<tr width="100%" class="TableLine2">
													<td  id='<%# DataBinder.Eval(Container, "DataItem.departid") %>' name='<%# DataBinder.Eval(Container, "DataItem.department") %>'  onclick='javascript:click_user("<%# DataBinder.Eval(Container, "DataItem.departid") %>")'  class="menulines" align="center" style="cursor:hand"><%# DataBinder.Eval(Container, "DataItem.department")%></td>
												</tr>
											</ItemTemplate>
											<HeaderStyle Font-Bold="True" ForeColor="#F7F7F7" BackColor="#4A3C8C"></HeaderStyle>
										</asp:datalist></table>
								</TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
        <asp:HiddenField ID="HFdb" runat="server" />
    </div>
    </form>
</body>
</html>
