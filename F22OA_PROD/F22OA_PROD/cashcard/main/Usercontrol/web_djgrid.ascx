<%@ control language="C#" autoeventwireup="true" inherits="web_djgrid, App_Web_web_djgrid.ascx.3f410aa0" %>
<%@ Register Assembly="Infragistics2.WebUI.Misc.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
    <script language="javascript" type="text/javascript" src="<%= Request.ApplicationPath %>/js/select.js" ></script>
 <script type="text/javascript">
<!--
var gridName="Webxdjgrid1xUltraWebGrid1";
var runtype="";
function editrow()
{
    var row=igtbl_getActiveRow(gridName); 
	var styleid=row.getCellFromKey("styleid").getValue();	
	var styname=row.getCellFromKey("s_name").getValue();	
	var jprice=row.getCellFromKey("j_price").getValue();	
	var xprice=row.getCellFromKey("x_price").getValue();	
	var rate=row.getCellFromKey("x_discount").getValue();	
	var sprice=row.getCellFromKey("s_price").getValue();	
	var nums=row.getCellFromKey("nums").getValue();	
	var comment=myescape(row.getCellFromKey("comment").getValue());	
	
	var pricelist="0|"+styleid+"|"+styname+"|0|"+jprice+"|"+xprice+"|"+rate+"|"+sprice+"|"+comment;
　  pricelist=loadstylesub(pricelist); 
　  if (pricelist!="")
　  {
　　　　var v=pricelist.split("|");
　　    if (v[1]=="" && v[1]!=null)
　　    {
　　         return false;
　　    }

	    row.getCellFromKey("j_price").setValue(v[4]);	
	    row.getCellFromKey("x_price").setValue(v[5]);	
	    row.getCellFromKey("x_discount").setValue(v[6]);
	    row.getCellFromKey("s_price").setValue(v[7]);
	    row.getCellFromKey("nums").setValue(v[8]);
	    row.getCellFromKey("jpricesums").setValue(v[8]*v[4]);
	    row.getCellFromKey("xpricesums").setValue(v[8]*v[5]);
	    row.getCellFromKey("sums").setValue(v[8]*v[7]);
	    row.getCellFromKey("comment").setValue(unmyescape(v[9]));
　  
　  }
}
function delrow()
{
    var row=igtbl_getActiveRow(gridName); 
    var styleid=row.getCellFromKey("styleid").getValue();	

	if(confirm("真的要删除当前记录吗? ->"+styleid))
    {
       var row=igtbl_getActiveRow(gridName); 
       if (row==null)
       {
          return;
       }
       runtype="del";
       var styleid=myescape(runtype+"|"+row.getCellFromKey("styleid").getValue());	
	   var context=document.getElementById(getname()+"_Txt_styleid");
    　 <%=Page.ClientScript.GetCallbackEventReference(this, "styleid", "handleResultFromServer", "context")%>; 
       
    }

}

//查看这个款的数量和基本资料
function seestyleid()
{
    var row=igtbl_getActiveRow(gridName); 
    var styleid=row.getCellFromKey("styleid").getValue();	
    alert(styleid+"查看款式数量");
}

//新增款式判断
function addNewRows()			
{						
	var osty=document.getElementById(getname()+"_Txt_styleid");
	if (osty==null)
	{
	   alert("系统内部错误,估计IE有问题!请与公司系统管理员联系.");
	   osty.focus();
	   return false;	
	}
	if (osty.value=="")
	{
	   osty.focus();
	   return false;	
	}
	
	if (FindValue(osty.value)==0)
	{
	   editrow();
       osty.value="";
       osty.focus();

	}
    else
    {
        runtype="chk";
	    var styleid=myescape(runtype+"|"+osty.value);
	    var context=osty;
　      <%=Page.ClientScript.GetCallbackEventReference(this, "styleid", "handleResultFromServer", "context")%>; 
　  }
    
 }
//0表示成功
function handleResultFromServer(result, context)
{
  var r=result.split("|");
  switch (runtype)
  {
     case "del":
        if (r[0]=="0")
        {
          igtbl_deleteSelRows(gridName);
        }
        else
        {
          alert(r[1]);
        }
        break; 
     case "chk":
        if (r[0]=="0")
        {
          add(result);
        }
        else
        {
          alert(r[1]);
        }
        break;   
  }

 }
 function add(pricelist)
 {　　
　　//录入明细后在增加
　　var nums=loadstylesub(pricelist);
　　if (nums!="")
　　{
　　　　var v=nums.split("|");
　　    if (v[1]=="" && v[1]!=null)
　　    {
　　         return false;
　　    }
　　    var row=igtbl_addNew(gridName,0); 
	    row.getCellFromKey("styleid").setValue(v[1]);	
	    row.getCellFromKey("s_name").setValue(v[2]);	
	    row.getCellFromKey("j_price").setValue(v[4]);	
	    row.getCellFromKey("x_price").setValue(v[5]);	
	    row.getCellFromKey("x_discount").setValue(v[6]);
	    row.getCellFromKey("s_price").setValue(v[7]);
	    row.getCellFromKey("nums").setValue(v[8]);
	    row.getCellFromKey("jpricesums").setValue(v[8]*v[4]);
	    row.getCellFromKey("xpricesums").setValue(v[8]*v[5]);
	    row.getCellFromKey("sums").setValue(v[8]*v[7]);
	    row.getCellFromKey("comment").setValue(unmyescape(v[9]));
    				        			        
        var cell=row.getCellFromKey("del");
        cell.Element.firstChild.innerHTML='<a onclick="javascript:return delrow()"  href="#">删除</a>';

        cell=row.getCellFromKey("edit");
        cell.Element.firstChild.innerHTML='<a onclick="javascript:return editrow()"  href="#">编辑</a>';

        cell=row.getCellFromKey("see");
        cell.Element.firstChild.innerHTML='<a onclick="javascript:return seestyleid(this)"  href="#">查看</a>';

    }
	var osty=document.getElementById(getname()+"_Txt_styleid");
    osty.value="";
    osty.focus();
 
 }
 
//录入这个款的明细数量
function loadstylesub(pricelist)
{
    //录入明细
    var url=get_url()+"?pricelist="+pricelist+"&&id="+getid(); 
　  var newpricelist=showaspx(url,730,550);
　  if (newpricelist!="" && newpricelist!=undefined) 
　  {
       var v=newpricelist.split("|");
       if (v[0]=="1")
      {
         newpricelist="";
         alert("保存出现错误！->"+v[1]);
      }
    }
    else
    {
      newpricelist="";
    }
  return newpricelist;
}
//文本框回车触发的事件
function TBchanged(obj)  
{ 
    if (event.keyCode == 13) 
    { 
        if(obj.value!="")
        {
            addNewRows();
            return true;
        } 
        return true; 
     }
     
 }
 function myescape(value)
 {
   return escape(value);
    
 }
 function unmyescape(value)
 {
   return unescape(value);
    
 }
 function bt_help_onclick()
 {
   showaspx("/Usercontrol/web_djgridhelp.aspx",730,500);
   return false;
 }

 function returnid(ob)
 {
   window.returnValue=getid();
 }
 function bt_close_onclick(ob)
 {
  if(confirm("警告：你修改的数据将不会被保存，真的要不保存退出吗?"))
  {
       window.returnValue=getid();
       window.close();
  } 
 }
 
  function bt_del_onclick()
 {
   if (confirm("警告：你录入的这张单据将被删除，真的要删除吗?"))
   {
     window.returnValue="del";
     return true;
   }
   else
   {
     return false;
   }
 }
 
 function bt_chk_onclick()
 {
   var rq=select_date(1);
   if (rq!="")
   {
       var orq=document.getElementById(getname()+"_lbl_chkdate");
       if (orq==null)
       {
          alert("客户端js出现错误，没有找到日期id");  
          return false;
       }
       else
       {
          window.returnValue=getid();
          orq.value=rq;
          return true;
       }
   }
   else
   {
     return false;
   }
 }
 
  function bt_sure_onclick()
 {
   var rq=select_date(2);
   if (rq!="")
   {
       var orq=document.getElementById(getname()+"_lbl_suredate");
       if (orq==null)
       {
          alert("客户端js出现错误，没有找到日期id");  
          return false;
       }
       else
       {
          window.returnValue=getid();
          orq.value=rq;
          return true;
       }
   }
   else
   {
     return false;
   }
 }
 function getid()
 {
   var ids=getname()+"_lbl_id";
   var oid=document.getElementById(ids);
   if (oid==null)
   {
      alert("客户端js出现错误，没有找到id");  
      return "";
   }
   else
   {
       return oid.value;
   }
  }
 
  function get_url()
 {
   var ids=getname()+"_lbl_url";
   var oid=document.getElementById(ids);
   if (oid==null)
   {
      alert("客户端js出现错误，没有找到url");  
      return "";
   }
   else
   {
       return oid.value;
   }
  }
  
function FindValue(styleid)
{
    findValue = styleid;
    var oUltraWebGrid1=igtbl_getGridById(gridName);
    var re = new RegExp("^" + findValue, "gi");
    igtbl_clearSelectionAll(oUltraWebGrid1.Id);
    var oCell = oUltraWebGrid1.find(re);
    if(oCell != null) 
    {
            var row = oCell.Row;
            oUltraWebGrid1.setActiveRow(row);
            oCell.setSelected(true);
            return 0;
    }
    else
    {
        return 1;
    }
}
// -->
</script>


<table style="width:800px;border-right: #cccccc 1px solid; border-top: #cccccc 1px solid; border-left: #cccccc 1px solid; border-bottom: #cccccc 1px solid;">
    <tr>
        <td  align="left" colspan="6">
        <div style="float:left" >
            &nbsp; &nbsp; &nbsp;&nbsp;
            款式编号:
            <input id="Txt_styleid" runat="server" style="width: 187px" type="text" onkeydown="javascript:return TBchanged(this)" maxlength="22" />
            <input id="btadd"  runat="server" onclick="javascript:return addNewRows()"  style="width: 76px;border:solid 1px ; background-color: transparent;" type="button" value="添加" />
            <input id="lbl_id" runat="server" style="width: 135px" type="hidden" />

        </div><input id="lbl_url" runat="server" style="width: 104px" type="hidden" />
            <input id="lbl_price" runat="server" style="width: 123px" type="hidden" /></td>
    </tr>
    <tr>
    <td style="text-align: center; height: 252px;" colspan="6">

<igtbl:UltraWebGrid ID="UltraWebGrid1" runat="server" Height="250px" Width="797px" Browser="Xml" EnableViewState="False">
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
                <igtbl:UltraGridColumn BaseColumnName="styleid" HeaderText="款式编号" Key="styleid">
                    <Header Caption="款式编号">
                    </Header>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="s_name" HeaderText="款式名称" Key="s_name">
                    <Header Caption="款式名称">
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="j_price" HeaderText="零售原价" Key="j_price" Width="60px">
                    <Header Caption="零售原价">
                        <RowLayoutColumnInfo OriginX="2" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="x_price" HeaderText="零售价" Key="x_price" Width="60px">
                    <Header Caption="零售价">
                        <RowLayoutColumnInfo OriginX="3" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="3" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="x_discount" Format="#.######" HeaderText="折扣"
                    Key="x_discount" Width="30px">
                    <Header Caption="折扣">
                        <RowLayoutColumnInfo OriginX="4" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="4" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="s_price" HeaderText="结算价" Key="s_price" Width="60px">
                    <Header Caption="结算价">
                        <RowLayoutColumnInfo OriginX="5" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="5" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="nums" HeaderText="数量" Key="nums" Width="40px">
                    <Header Caption="数量">
                        <RowLayoutColumnInfo OriginX="6" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="6" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="jpricesums" HeaderText="原价金额" Key="jpricesums"
                    Width="70px">
                    <Header Caption="原价金额">
                        <RowLayoutColumnInfo OriginX="7" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="7" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="xpricesums" HeaderText="零售价金额" Key="xpricesums"
                    Width="70px">
                    <Header Caption="零售价金额">
                        <RowLayoutColumnInfo OriginX="8" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="8" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="sums" HeaderText="结算金额" Key="sums" Width="70px">
                    <Header Caption="结算金额">
                        <RowLayoutColumnInfo OriginX="9" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="9" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="comment" HeaderText="备注" Key="comment">
                    <Header Caption="备注">
                        <RowLayoutColumnInfo OriginX="10" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="10" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:TemplatedColumn AllowUpdate="No" HeaderText="编辑" HTMLEncodeContent="True"
                    Key="edit" Width="30px">
                    <CellTemplate>
                        <a href="#" onclick="javascript:return editrow(this)">编辑</a>  
                    </CellTemplate>
                    <Header Caption="编辑">
                        <RowLayoutColumnInfo OriginX="11" />
                    </Header>
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="11" />
                    </Footer>
                </igtbl:TemplatedColumn>
                <igtbl:TemplatedColumn AllowUpdate="No" HeaderText="删除" HTMLEncodeContent="True"
                    Key="del" Width="30px">
                    <CellTemplate>
                        <a href="#" onclick="javascript:return delrow(this)">删除</a>  
                    </CellTemplate>
                    <Header Caption="删除">
                        <RowLayoutColumnInfo OriginX="12" />
                    </Header>
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="12" />
                    </Footer>
                </igtbl:TemplatedColumn>
                <igtbl:TemplatedColumn AllowUpdate="No" HeaderText="查看" HTMLEncodeContent="True"
                    Key="see" Width="30px">
                    <CellTemplate>
                        <a href="#" onclick="javascript:return seestyleid(this)">查看</a>  
                    </CellTemplate>
                    <Header Caption="查看">
                        <RowLayoutColumnInfo OriginX="13" />
                    </Header>
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="13" />
                    </Footer>
                </igtbl:TemplatedColumn>
            </Columns>
            <RowTemplateStyle BackColor="White" BorderColor="White" BorderStyle="Ridge">
                <BorderDetails WidthBottom="3px" WidthLeft="3px" WidthRight="3px" WidthTop="3px" />
            </RowTemplateStyle>
        </igtbl:UltraGridBand>
    </Bands>
    <DisplayLayout AllowAddNewDefault="Yes" AllowColSizingDefault="Free" AllowDeleteDefault="Yes"
        AllowUpdateDefault="Yes" AutoGenerateColumns="False" ColWidthDefault="" Name="ctl00xUltraWebGrid1"
        NoDataMessage="没有数据" RowHeightDefault="18px" RowsRange="-1" SelectTypeRowDefault="Extended"
        Version="3.00" AllowSortingDefault="OnClient" HeaderClickActionDefault="SortSingle">
        <GroupByBox Hidden="True">
        </GroupByBox>
        <RowExpAreaStyleDefault TextOverflow="Ellipsis">
        </RowExpAreaStyleDefault>
        <FooterStyleDefault BackColor="#FFFFC0" BorderStyle="Double" BorderWidth="1px"
            TextOverflow="Ellipsis">
            <BorderDetails ColorLeft="White" ColorTop="White" StyleBottom="Dashed" StyleLeft="Dotted"
                StyleRight="Dotted" StyleTop="Dotted" WidthLeft="3px" WidthTop="1px" />
        </FooterStyleDefault>
        <RowStyleDefault BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px" TextOverflow="Ellipsis">
            <BorderDetails WidthLeft="0px" WidthTop="0px" />
            <Padding Left="3px" />
        </RowStyleDefault>
        <FilterOptionsDefault AllString="(All)" EmptyString="(Empty)" NonEmptyString="(NonEmpty)">
            <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                Font-Size="11px" Width="200px">
                <Padding Left="2px" />
            </FilterDropDownStyle>
            <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
            </FilterHighlightRowStyle>
        </FilterOptionsDefault>
        <RowSelectorStyleDefault Font-Names="宋体" Font-Size="9pt" TextOverflow="Ellipsis">
        </RowSelectorStyleDefault>
        <SelectedRowStyleDefault BackColor="#9FBEEB">
        </SelectedRowStyleDefault>
        <HeaderStyleDefault BackColor="Info" HorizontalAlign="Center">
            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="0px" WidthTop="1px" />
        </HeaderStyleDefault>
        <RowAlternateStyleDefault BackColor="#FFFFC0" TextOverflow="Ellipsis">
        </RowAlternateStyleDefault>
        <EditCellStyleDefault BackColor="Blue" BorderStyle="None" BorderWidth="0px" Font-Names="宋体-18030"
            Font-Size="9pt" ForeColor="White" Height="16px">
        </EditCellStyleDefault>
        <FrameStyle BackColor="White" BorderColor="Blue" BorderStyle="Inset" BorderWidth="1px"
            Font-Names="宋体" Font-Size="9pt" Height="251px" Width="797px">
        </FrameStyle>
        <FixedCellStyleDefault TextOverflow="Ellipsis">
        </FixedCellStyleDefault>
        <Pager>
            <Style BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
</Style>
        </Pager>
        <AddNewBox>
            <Style BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
</Style>
        </AddNewBox>
    </DisplayLayout>
</igtbl:UltraWebGrid></td>
</tr>
    <tr>
        <td style="text-align: center" >
            审核</td>
        <td style="text-align: center">
            登帐</td>
        <td style="text-align: center">
            审核日期</td>
        <td style="text-align: center">
            审核人</td>
        <td style="text-align: center">
            登帐日期</td>
        <td style="text-align: center">
            登帐人</td>
    </tr>
        <tr>
        <td style="text-align: center" >
            <asp:Label ID="lbl_chk" runat="server" Width="60px"></asp:Label></td>
        <td style="text-align: center">
            <asp:Label ID="lbl_sure" runat="server" Text="" Width="60px"></asp:Label></td>
        <td style="text-align: center">
             <input id="lbl_chkdate" runat="server" type="text" disabled="disabled" /></td>
        <td style="text-align: center">
            <asp:Label ID="lbl_chkname" runat="server" Text="" Width="150px"></asp:Label>
        <td style="text-align: center">
             <input id="lbl_suredate" runat="server" type="text" disabled="disabled" /></td>
        <td style="text-align: center">
            <asp:Label ID="lbl_surename" runat="server" Text="" Width="150px"></asp:Label></td>
    </tr>
    <tr>
        <td style="text-align: center;height:40px" colspan="6">  
        <div style="float:inherit" > 
            <asp:LinkButton id="bt_help" runat="server" OnClientClick="return bt_help_onclick(this)"  Text="帮助" Width="105px"  />
            <asp:LinkButton id="bt_prn" runat="server" OnClientClick="returnid(this)"   Text="打印" Width="105px" OnClick="bt_prn_Click"  />
            <asp:LinkButton id="bt_save" runat="server" OnClientClick="returnid(this)"  Text="保存退出" Width="105px" OnClick="bt_save_Click"  />
            <asp:LinkButton id="bt_chk" runat="server" OnClientClick="javascript:return bt_chk_onclick()"  Text="审核退出" Width="105px" OnClick="bt_chk_Click" />
            <asp:LinkButton id="bt_sure" runat="server" OnClientClick="javascript:return bt_sure_onclick()" Text="登帐退出"  Width="105px" OnClick="bt_sure_Click"  />
            <asp:LinkButton  id="bt_del" runat="server" OnClientClick="javascript:return bt_del_onclick()"  Text="删除退出"  OnClick="bt_del_Click"  Width="105px" />
            <asp:LinkButton id="bt_close" runat="server" OnClientClick="return bt_close_onclick(this)" Text="关闭" Width="105px" />
        </div>    
        </td>
    </tr>
</table>