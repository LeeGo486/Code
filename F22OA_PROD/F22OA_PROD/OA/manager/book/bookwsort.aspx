<%@ page language="C#" autoeventwireup="true" inherits="manager_book_bookwsort, App_Web_bookwsort.aspx.c640126d" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<%@ OutputCache Duration="1" VaryByParam="none" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>BooKwSort</title>
		<base target="_self" />
		<link rel="stylesheet" type="text/css" href="../../css/project.css" />
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>

    <script src="../../js/jquery-1.3.2.min.js" type="text/javascript"></script>
		<script type="text/javascript">
		/*
			function click_model(ID){
			
				targetelement= document.getElementById(ID);//document.all(ID);
				cname=targetelement.innerHTML;
				
				setParentValue('tbvsort',ID);	//负值给tbvlinkman
				setParentValue('tbsort',cname);	//负值给tblinkman
				
				CloseWindow('选择书籍类别');	//关闭当前窗口
			}
	        */		
	        
			function binding(){
			    $("#Table1 tbody td").click(function(){
			       var id=$(this).attr("id");
			       var name=$(this).html();
                   window.opener.setValue(id,name);	//负值给tbvlinkman
				   window.close();
			    });
		    }
		    
		    jQuery(function(){
		        binding();
		    })

		</script>
</head>
<body style="margin:1px;">
    <form id="form1" runat="server">
    <div id="tmtable">
    <table id="Table2" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tbody>
					<tr >
						<td class="small" style="WIDTH: 212px; HEIGHT: 18px">关键字：
							<asp:TextBox id="tbs" runat="server" CssClass="tbox" Width="152px" ToolTip="可以按编号和名称查询，留空则查询所有"></asp:TextBox></TD>
						<td style="HEIGHT: 18px">
							<asp:ImageButton id="imbSearch" runat="server" ImageUrl="../../icon/search.gif" OnClick="imbSearch_Click"></asp:ImageButton></TD>
					</tr>
				</tbody>
			</table>
		<table id="Table1" cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">	
        <asp:Repeater id="dls" runat="server">
          <HEADERTEMPLATE>
          <tr><td> 选择图书类别</td></tr>
          </HEADERTEMPLATE>
          <ITEMTEMPLATE>
            <tbody>
              <td align="center" onmouseover="chgStyle(this,'#fff','#06c')" onmouseout="chgStyle(this,'','#fff')"
               style="CURSOR: hand" 
               id='<%# DataBinder.Eval(Container, "DataItem.sortid") %>'><%# DataBinder.Eval(Container, "DataItem.sortname") %></td>
            </tbody>
          </ITEMTEMPLATE>
        </asp:Repeater>
          <tr>
            <td style=" text-align:center;"><webdiyer:AspNetpager id="ap" runat="server" pagesize="7" AlwaysShow="true"></webdiyer:AspNetpager></TD>
          </tr>
        </table>
    </div>
    <script type="text/javascript" defer="defer">
    	jsTable('tmtable','tm','100%','','center')
    
    </script>
    </form>
</body>
</html>
