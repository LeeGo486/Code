<%@ page language="C#" autoeventwireup="true" inherits="isprit_Module_selectattach, App_Web_selectattach.aspx.a91202c5" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<%@OutputCache Duration="1" VaryByParam="*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>选择邮件附件</title>
		<LINK href="table.css" type="text/css" rel="STYLESHEET"/>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<base target="_self" />
		<script language="JavaScript" type="text/javascript">
var parent_window = parent.dialogArguments;

function click_file(file_id)
{
  
  TO_VAL=parent_window.document.all.HFILE.value;
  targetelement=window.document.all(file_id);
  file_name=targetelement.name;

  if(TO_VAL.indexOf(","+file_id+",")<0 && TO_VAL.indexOf(file_id+",")!=0)
  {
    parent_window.document.all.TO_FILE.value+=file_name+",";
    parent_window.document.all.HFILE.value+=file_id+",";
    borderize_on(targetelement);
  }
  else
  {
    parent_window.document.all.TO_FILE.value=parent_window.document.all.TO_FILE.value.replace(file_name+",","");
    parent_window.document.all.HFILE.value=parent_window.document.all.HFILE.value.replace(file_id+",","");
    borderize_off(targetelement);
  }
}

function borderize_on(targetelement)
{
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

function begin_set()
{
  TO_VAL=parent_window.document.all.HFILE.value;

  for (step_i=0; step_i<document.all.length; step_i++)
  {
    if(document.all(step_i).className=="menulines")
    {
       file_id=document.all(step_i).id;
       if(TO_VAL.indexOf(","+file_id+",")>0 || TO_VAL.indexOf(file_id+",")==0)
          borderize_on(document.all(step_i));
    }
  }
}

function add_all()
{
  TO_VAL=parent_window.document.all.TO_FILE.value;
  for (step_i=0; step_i<document.all.length; step_i++)
  {
    if(document.all(step_i).className=="menulines")
    {
       file_id=document.all(step_i).id;
       file_name=document.all(step_i).name;

       if(TO_VAL.indexOf(","+file_id+",")<0 && TO_VAL.indexOf(file_id+",")!=0)
       {
         parent_window.document.all.TO_FILE.value+=file_name+",";
         parent_window.document.all.HFILE.value+=file_id+",";
         borderize_on(document.all(step_i));
       }
    }
  }
}

function del_all()
{
 parent_window.document.all.TO_FILE.value="";
 parent_window.document.all.HFILE.value="";
 for (step_i=0; step_i<document.all.length; step_i++)
 {
 borderize_off(document.all(step_i));
 }
}
		</script>
	
</head>
<body leftMargin="0" topMargin="0" rightmargin="0" onload="begin_set()">
    <form id="form1" runat="server">
    <div>
    <table width="100%">
				<tr>
					<td>
						<asp:datalist id="dgattach" runat="server" Width="100%">
							<HeaderTemplate>
								<tr>
									<td align="center" onclick="add_all()" style="CURSOR: hand" class="TableControl">选择所有文件</td>
								</tr>
								<tr>
									<td align="center" onclick="del_all()" style="CURSOR: hand" class="TableControl">取消所有文件</td>
								</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr class="TableControl">
									<td width=400 id='<%# DataBinder.Eval(Container, "DataItem.fileid") %>' name='<%# DataBinder.Eval(Container, "DataItem.filename") %>'  onclick='javascript:click_file("<%# DataBinder.Eval(Container, "DataItem.fileid") %>")'  class="menulines" align="center" style="cursor:hand">
										<%# DataBinder.Eval(Container, "DataItem.filename") %>
									</td>
								</tr>
							</ItemTemplate>
						</asp:datalist>
					</td>
				</tr>
				<tr>
					<td>
						<webdiyer:AspNetpager id="ap" runat="server" PageSize="10" SubmitButtonText="转到" AlwaysShow="True" ShowInputBox="Always" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager></td>
				</tr>
				<tr>
					<td align="center"><a href="javascript:window.close()">关闭窗口</a></td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
