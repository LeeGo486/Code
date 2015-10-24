<%@ page language="C#" autoeventwireup="true" inherits="web_usercr, App_Web_web_usercr.aspx.9597e00c" %>
<%@ OutputCache   Duration="1"  VaryByParam="merchantid;dptid;dptype"   %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>建立各店操作员</title>
    
    <!--grid 的 Height="298px" Width="100%"-->
    <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../../../js/check.js" ></script>
    
       <script type="text/javascript">
        <!--

        function save_readyState()
        {
           var oFeedBackLabel = igtbl_getElementById("lblFeedBack");
           if (request.readyState<4) 
           {
               oFeedBackLabel.innerHTML = "正在处理...";
           }
           else
           if (request.readyState==4) 
           {
              oFeedBackLabel.innerHTML = "操作成功！";
           }
           else
           {
             oFeedBackLabel.innerHTML = "操作失败！";
             alert(request.responseText);
           }
           
        }
        
        //删除当前用户
		function user_del()
		{
		   if(confirm('真的要删除当前记录吗?'))
		   {
                var row=igtbl_getActiveRow("UltraWebGrid1"); 
	            var userid=row.getCellFromKey("userid").getValue();	
                        
                var url="web_usercrxml.aspx?SaveType=3&userid="+userid;
	            if (update_srv(url))
	            {
    　　              igtbl_deleteSelRows('UltraWebGrid1');
　　            }
	       }
 		 }
		
		//保存修改
		function user_editsave()
		{
             var row=igtbl_getActiveRow("UltraWebGrid1"); 
             row.endEditRow();
             var userid=row.getCellFromKey("userid").getValue();	
	         var username=row.getCellFromKey("username").getValue();
	         var usermain=row.getCellFromKey("usermain").Element.firstChild.firstChild.checked;
	         var notuse=row.getCellFromKey("notuse").Element.firstChild.firstChild.checked;
             var url="web_usercrxml.aspx?SaveType=2&userid=" +userid+"&username="+escape(username)+"&usermain="+usermain+"&notuse="+notuse;

	         update_srv(url);
	                      
		}

        //提交服务器
        function update_srv(url)
        {
            if (window.XMLHttpRequest)
            {
                request = new XMLHttpRequest();
            }
            else if (window.ActiveXObject)
            {
                request = new ActiveXObject("Microsoft.XMLHTTP");
            }
            if (request)
            {
                if (request.readyState!=0)
                {
                  alert("服务器正忙,请稍后提交...");
                  return false;
                } 
   
               var oFeedBackLabel = igtbl_getElementById("lblFeedBack");
                oFeedBackLabel.innerHTML = "正在处理...";
                request.onreadystatechange = save_readyState;
                request.open("GET", url,false);
                request.send(null);
                
                var strReturn=request.ResponseText;
	            if (strReturn=="1")
	            {
                   oFeedBackLabel.innerHTML = "处理成功！.";

			       return true;
                }
                else
                {
                  oFeedBackLabel.innerHTML = "处理失败！";
                  alert(strReturn);
                  return false;
                }          
             }
        }
        //保存新增加记录
        function save_add(userid,username)
		{
		    
                var merid=igtbl_getElementById("lbl_merchantid");
                var dptid=igtbl_getElementById("lbl_depotid");
                var dtpye=igtbl_getElementById("lbl_type");
                var url="web_usercrxml.aspx?SaveType=1&userid=" +userid+"&username="+username+"&mid="+merid.innerHTML+"&dptid="+dptid.innerHTML+"&dtype="+dtpye.innerHTML;

	            if (update_srv(url))
	            {
	                var row=igtbl_addNew("UltraWebGrid1",0);
			        	
			        row.getCellFromKey("username").setValue(username);
			        row.getCellFromKey("usermain").setValue(false);
			        row.getCellFromKey("userid").setValue(userid);
			        			        
			        cell=row.getCellFromKey("del");
			        cell.Element.firstChild.innerHTML='<a onclick="javascript:return user_del()"  href="#"  >删除</a>';

			        cell=row.getCellFromKey("save");
			        cell.Element.firstChild.innerHTML='<a onclick="javascript:return user_editsave()"  href="#"  >保存</a>';
                    row.endEditRow();
                    
			        return true;
                 }
                 else
                 {
                   return false;
                 }          
             }
        
        //新增加用户判断
        function addNewRows()			
		{						
		    
		    var ntype=document.getElementById("lbl_type");
		    if (ntype.innerHTML=="-1")
		    {
		        alert("在大类上不可以建立用户，请选择加盟商或者店铺后再建立！"); 
		        return false;
		    }
		    
			var userid=document.getElementById("Text_userid");
  	        var username=document.getElementById("Text_username");
			if (userid.value!="" && userid.value.length==4)
			{
			    if (username.value!="" && userid.value!="")
			    {
			      if (save_add(userid.value,username.value))
			      {
			        userid.value="";
			        username.value="";
                  }
                  else
                  {
                    userid.value="";
			      }
			      
			     }
			  }
			userid.focus();	
				
		   return false;	
		 }
			
		//文本框回车触发的事件
		function TBchanged(obj)  
        { 
            if (event.keyCode == 13) 
            { 
                if(obj.id=="Text_userid")
                {
                   if (obj.value.length!=4)
                   {
                     alert("用户编号必须等于４位长度！");
                     return false;
                   }
                   else
                   {   
                       event.keyCode=9;
                       return true;
                   }
                }
                else
                {
                if(obj.id=="Text_username")
                {
                   if (obj.value=="")
                   {
                     alert("用户姓名不能为空！");
                     return false;
                   }
                }
                if(obj.value!="")
                {
                    addNewRows();
                } 
                }
                return true; 
             }
             
         }
						
        -->
        </script>
</head>
<body style="text-align: center">
    <form id="from1" runat="server">
        <table style="width: 567px">
            <tr>
                <td style="width: 100px; height: 15px;">
                    <asp:Label ID="lbl_merchantid" runat="server" Text="" Width="78px"></asp:Label></td>
                <td style="width: 100px; height: 15px;">
                    <asp:Label ID="lbl_depotid" runat="server" Text="" Width="78px"></asp:Label></td>
                <td style="width: 100px; height: 15px;">
                    <asp:Label ID="lbl_type" runat="server" Text="" Width="78px"></asp:Label></td>
                <td style="width: 99px; height: 15px">
                    <asp:label id="lblFeedBack" runat="server" Font-Names="Verdana" Font-Size="8pt" ForeColor="#CC0000" Width="281px"></asp:label>
                </td>
            </tr>
        </table>
        <igtbl:ultrawebgrid id="UltraWebGrid1" runat="server" Browser="Xml" Height="292px" Width="93%" EnableViewState="False" OnInitializeLayout="UltraWebGrid1_InitializeLayout">
                                            <DisplayLayout AllowDeleteDefault="Yes" AllowAddNewDefault="Yes" RowHeightDefault="20px" Version="3.00" SelectTypeRowDefault="Extended" RowsRange="20" BorderCollapseDefault="Separate"  Name="UltraWebGrid1" AllowUpdateDefault="Yes" AutoGenerateColumns="False" AllowColSizingDefault="Free">
                                                <AddNewBox>
                                                    <Style BorderWidth="1px" BorderStyle="Solid" BackColor="LightGray">

                                                    <BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White">
                                                    </BorderDetails>

                                                    </Style>
                                                </AddNewBox>
                                                <Pager>
                                                    <Style BorderWidth="1px" BorderStyle="Solid" BackColor="LightGray">

                                                        <BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White">
                                                        </BorderDetails>

                                                    </Style>
                                                </Pager>
                                                <HeaderStyleDefault BorderStyle="Solid" HorizontalAlign="Center" BackColor="Info">
                                                    <BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
                                                </HeaderStyleDefault>
                                                <RowSelectorStyleDefault TextOverflow="Ellipsis"></RowSelectorStyleDefault>
                                                <FrameStyle Width="93%" BorderWidth="1px" Font-Size="8pt" Font-Names="Verdana" BorderStyle="Inset" BackColor="White" Height="292px" BorderColor="Blue"></FrameStyle>
                                                <FooterStyleDefault BorderWidth="1px" BorderStyle="Solid" BackColor="LightGray">
                                                    <BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
                                                </FooterStyleDefault>
                                                
                                                <RowExpAreaStyleDefault TextOverflow="Ellipsis"></RowExpAreaStyleDefault>
                                                <EditCellStyleDefault BorderWidth="0px" Font-Size="8pt" Font-Names="Verdana" BorderStyle="None"></EditCellStyleDefault>
                                                <SelectedRowStyleDefault BackColor="#9FBEEB"></SelectedRowStyleDefault>
                                                <RowAlternateStyleDefault TextOverflow="Ellipsis" BackColor="#FFFFC0"></RowAlternateStyleDefault>
                                                <RowStyleDefault TextOverflow="Ellipsis" BorderWidth="1px" BorderColor="Gray" BorderStyle="Solid">
                                                    <Padding Left="3px"></Padding>
                                                    <BorderDetails WidthLeft="0px" WidthTop="0px"></BorderDetails>
                                                </RowStyleDefault>
                                                <FixedCellStyleDefault TextOverflow="Ellipsis"></FixedCellStyleDefault>
                                                <GroupByBox Hidden="True">
                                                </GroupByBox>
                                                <FilterOptionsDefault AllString="(All)" EmptyString="(Empty)" NonEmptyString="(NonEmpty)">
                                                    <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                                        CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                                                        Font-Size="11px" Width="200px">
                                                        <Padding Left="2px" />
                                                    </FilterDropDownStyle>
                                                    <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
                                                    </FilterHighlightRowStyle>
                                                </FilterOptionsDefault>
                                            </DisplayLayout>
                                            <Bands>
                                                <igtbl:UltraGridBand>
                                                    <AddNewRow View="NotSet" Visible="NotSet">
                                                    </AddNewRow>
                                                    <FilterOptions AllString="" EmptyString="" NonEmptyString="">
                                                        <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                                            CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                                                            Font-Size="11px" Width="200px">
                                                            <Padding Left="2px" />
                                                        </FilterDropDownStyle>
                                                        <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
                                                        </FilterHighlightRowStyle>
                                                    </FilterOptions>
                                                    <Columns>
                                                        <igtbl:UltraGridColumn BaseColumnName="userid" HeaderText="编号" Key="userid">
                                                            <Header Caption="编号">
                                                            </Header>
                                                        </igtbl:UltraGridColumn>
                                                        <igtbl:UltraGridColumn BaseColumnName="username" HeaderText="姓名" Key="username">
                                                            <Header Caption="姓名">
                                                                <RowLayoutColumnInfo OriginX="1" />
                                                            </Header>
                                                            <Footer>
                                                                <RowLayoutColumnInfo OriginX="1" />
                                                            </Footer>
                                                        </igtbl:UltraGridColumn>
                                                        <igtbl:UltraGridColumn BaseColumnName="usermain" DataType="System.Boolean" HeaderText="系统员"
                                                            Key="usermain" Type="CheckBox" Width="60px">
                                                            <Header Caption="系统员">
                                                                <RowLayoutColumnInfo OriginX="2" />
                                                            </Header>
                                                            <CellStyle HorizontalAlign="Center">
                                                            </CellStyle>
                                                            <Footer>
                                                                <RowLayoutColumnInfo OriginX="2" />
                                                            </Footer>
                                                        </igtbl:UltraGridColumn>
                                                        <igtbl:UltraGridColumn BaseColumnName="notuse" DataType="System.Boolean" HeaderText="禁用"
                                                            Key="notuse" Type="CheckBox" Width="60px">
                                                            <Header Caption="禁用">
                                                                <RowLayoutColumnInfo OriginX="3" />
                                                            </Header>
                                                            <CellStyle HorizontalAlign="Center">
                                                            </CellStyle>
                                                            <Footer>
                                                                <RowLayoutColumnInfo OriginX="3" />
                                                            </Footer>
                                                        </igtbl:UltraGridColumn>
                                                        <igtbl:TemplatedColumn AllowUpdate="No" HeaderText="保存" HTMLEncodeContent="True"
                                                            Key="save" Width="50px">
                                                            <CellTemplate>
                                                                <a href="#" onclick="javascript:return user_editsave()">保存</a>  
                                                            </CellTemplate>
                                                            <Header Caption="保存">
                                                                <RowLayoutColumnInfo OriginX="4" />
                                                            </Header>
                                                            <CellStyle HorizontalAlign="Center">
                                                            </CellStyle>
                                                            <Footer>
                                                                <RowLayoutColumnInfo OriginX="4" />
                                                            </Footer>
                                                        </igtbl:TemplatedColumn>
                                                        <igtbl:TemplatedColumn AllowUpdate="No" HeaderText="删除" HTMLEncodeContent="True"
                                                            Key="del" Width="50px">
                                                            <CellTemplate>
                                                                <a href="#" onclick="javascript:return user_del()">删除</a>  
                                                            </CellTemplate>
                                                            <Header Caption="删除">
                                                                <RowLayoutColumnInfo OriginX="5" />
                                                            </Header>
                                                            <CellStyle HorizontalAlign="Center">
                                                            </CellStyle>
                                                            <Footer>
                                                                <RowLayoutColumnInfo OriginX="5" />
                                                            </Footer>
                                                        </igtbl:TemplatedColumn>
                                                     </Columns>
                                                </igtbl:UltraGridBand>
                                            </Bands>
                                        </igtbl:ultrawebgrid>&nbsp;<br />
        <asp:ObjectDataSource ID="ds_user" runat="server">
        </asp:ObjectDataSource>
    </form>
</body>
</html>
