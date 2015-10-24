<%@ page language="C#" autoeventwireup="true" inherits="isprit_other_menu_shortcut, App_Web_menu_shortcut.aspx.bf068bd5" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>menu_shortcut</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<script language="javascript"  type="text/javascript">
function copyToList(master,client) //from表示:包含可选择项目的select对象名字 to表示:列出可选择项目的select对象名字 //你可以根据你的具体情况修改
{
  var tmpval
  var tmptxt
  var arruse
  fromList = eval('document.forms[0].' + master);
  toList = eval('document.forms[0].' + client);
  var sel = false;
  for (i=0;i<fromList.options.length;i++)
  {
    var current = fromList.options[i];
    if (current.selected)
    {
      sel = true;
      txt = current.text;
      val = current.value;
      var j;
      var tmpList=false;
      for (j=0;j<toList.options.length;j++)
      {
		var tmp=toList.options[j];
		tmptxt=tmp.text;
		tmpval=tmp.value;
		if (tmpval==val){
			tmpList=true;	
		}
      }
      if (!tmpList)
      {
        toList.options[toList.length] = new Option(txt,val);
      }
    }
  }
  if (!sel) alert ('你还没有选择任何项目');
}

function cancelToList(from) //from表示:包含可选择项目的select对象名字 to表示:列出可选择项目的select对象名字 //你可以根据你的具体情况修改
{
  fromList = eval('document.forms[0].' + from);
  var sel = false;
  for (i=0;i<fromList.options.length;i++)
  {
    var current = fromList.options[i];
    if (current.selected)
    {
      sel = true;
      txt = current.text;
      val = current.value;
      var j;
      var tmpList=false;
		fromList.options[i] = null;
		i--;
    }
  }
  if (!sel) alert ('你还没有选择任何项目');
}

function addAllselect(master,client)
{
  var tmpval
  var tmptxt
  var arruse
  fromList = eval('document.forms[0].' + master);
  toList = eval('document.forms[0].' + client);
  for (i=0;i<fromList.options.length;i++)
  { //alert(i);
    var current = fromList.options[i];
    txt = current.text;
    val = current.value;
    var j;
    var tmpList=false;
    for (j=0;j<toList.options.length;j++)
    {
      //alert("j="+j);
      var tmp=toList.options[j];
	  tmptxt=tmp.text;
	  tmpval=tmp.value;
	  if (tmpval==val)
	  {
		tmpList=true;	
      }
    }
    //alert(tmpList);
    if (!tmpList)
    {
      toList.options[toList.length] = new Option(txt,val);   
    }
  }  
}

function DeleteAll(from) //from表示:包含可选择项目的select对象名字 to表示:列出可选择项目的select对象名字 //你可以根据你的具体情况修改
{
  fromList = eval('document.forms[0].' + from);
  var sel = false;
  for (i=0;i<fromList.options.length;i++)
  {
    var current = fromList.options[i];
    sel = true;
    txt = current.text;
    val = current.value;
    var j;
    var tmpList=false;
    fromList.options[i] = null;
	i--;
  }
  if (!sel) alert ('你还没有选择任何项目');
}

function btnSubmit() //这是当用户按下提交按钮时，对列出选择的select对象执行全选工作，让递交至的后台程序能取得相关数据
{
  var List
  var v
  document.all.v2.value="";
  List = document.forms[0].selUse;
  for (i=0;i<List.length;i++)
  {
     List.options[i].selected = true;
     document.all.v.value+= List.options[i].value + ",";
     document.all.v2.value+=i + ",";
  }
  
}

function arrowUp()
{
  var strValue;
  var strText;
  var intSel;
  var optionSel;
  var optionUp;
  intSel=document.frmQMenu.selUse.selectedIndex;
  if (intSel>0)
  {
    optionSel=document.frmQMenu.selUse.options(intSel);
    strValue=optionSel.value;
    strText=optionSel.text;
    intSel=intSel-1;
    optionUp=document.frmQMenu.selUse.options(intSel);
    optionSel.value=optionUp.value;
    optionSel.text=optionUp.text;
    optionUp.value=strValue;
    optionUp.text=strText;    
    //optionUp.selected=true;
    document.frmQMenu.selUse.selectedIndex=intSel;
  }
}

function arrowDown()
{
  var strValue;
  var strText;
  var intSel;
  var optionSel;
  var optionUp;
  intSel=document.frmQMenu.selUse.selectedIndex;
  if (intSel<document.frmQMenu.selUse.length-1 & intSel>=0)
  {
    optionSel=document.frmQMenu.selUse.options(intSel);
    strValue=optionSel.value;
    strText=optionSel.text;
    intSel=intSel+1;
    optionUp=document.frmQMenu.selUse.options(intSel);
    optionSel.value=optionUp.value;
    optionSel.text=optionUp.text;
    optionUp.value=strValue;
    optionUp.text=strText;    
    //optionUp.selected=true;
    document.frmQMenu.selUse.selectedIndex=intSel;
  }
}
		</script>
</head>
<body leftMargin="1" topMargin="1">
    <form id="frmQMenu" runat="server">
    <div>
    <table id="table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
				<tr class="header">
					<td>· 快捷菜单</td>
					<td></td>
				</tr>
				<tr>
					<td align="center" colSpan="2">
						<table>
							<tr>
								<td><SELECT id="selMaster" ondblclick="javascript:copyToList('selMaster','selUse');" style="WIDTH: 152px; HEIGHT: 248px"
										multiple size="15" runat="server"></SELECT></td>
								<td align="center" width="100"><A onclick="javascript:addAllselect('selMaster','selUse');" href="#">添加全部</A><BR>
									<A onclick="javascript:copyToList('selMaster','selUse');" href="#">添加</A><br>
									<A onclick="javascript:cancelToList('selUse');" href="#">移除</A><br>
									<A onclick="javascript:DeleteAll('selUse');" href="#">移除全部</A><br>
								</td>
								<td><SELECT id="selUse" ondblclick="javascript:cancelToList('selUse');" style="WIDTH: 152px; HEIGHT: 246px"
										multiple size="15" runat="server" DataTextField="title" DataValueField="id"></SELECT></td>
								<td class="caution"><A onclick="javascript:arrowUp();" href="#">向上</A><br>
									<br>
									<A onclick="javascript:arrowDown();" href="#">向 下</A>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><asp:button id="btok" runat="server" Text="提交(S)" CssClass="btn" OnClick="btok_Click"></asp:button><INPUT id="v" style="WIDTH: 92px; HEIGHT: 22px" type="hidden" size="10" runat="server"><INPUT id="v2" style="WIDTH: 92px; HEIGHT: 22px" type="hidden" size="10" name="Hidden1"
							runat="server"></td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
