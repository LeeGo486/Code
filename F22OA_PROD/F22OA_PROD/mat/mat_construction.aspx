<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_construction, App_Web_mat_construction.aspx.e229d74d" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>施工单位查询(报价) </title>
   <link  href="../css/project.css" type="text/css"  rel="stylesheet">
 <link href="../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
 <style type="text/css" >
   .ctr{ }
   .ctrs{ background-image:url(./itr.gif);background-repeat:repeat-x;}
 </style>
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
        <script src="../b28web/Utility/jquery-1.2.6.min.js" type="text/javascript"></script>
       <script src="../b28web/Utility/jquery.blockUI.js" type="text/javascript"></script>
	<script type="text/javascript">
	    var GB_ROOT_DIR = "../greybox/";
	    function funline(obj) {
	        try {
	            var vtb = obj.parentNode.parentNode.parentNode;
	            for (var i = 1; i < vtb.childNodes.length; i++)
	                vtb.childNodes[i].className = 'ctr';
	            if (obj.parentNode.parentNode.nextSibling == null || typeof (obj.parentNode.parentNode.nextSibling) == 'undefined') {
	                var tr = document.createElement('tr');
	                vtb.appendChild(tr);
	                var td = document.createElement('td');
	                td.colSpan = 13
	                tr.appendChild(td);
	                tr.className = 'ctrs';
	            } else
	                obj.parentNode.parentNode.nextSibling.className = 'ctrs';
	        } catch (e) { }
	    }
	    function drpDate_onchange(val) {
	        if (val == 1) {
	            document.getElementById("div1").style.display = "";
	            document.getElementById("tbDatespan").style.display = "";
	            document.getElementById("div2").style.display = "none";
	            document.getElementById("tbYearMonth").style.display = "none";
	        }
	        else {
	            document.getElementById("div1").style.display = "none";
	            document.getElementById("tbDatespan").style.display = "none";
	            document.getElementById("div2").style.display = "";
	            document.getElementById("tbYearMonth").style.display = "";
	        }
	    }
	    function lineOrgId(v) {
	        showDlg_center("mat_org_bw1.aspx?id=" + v);
	    }


	    $(document).ready(function () {

	        $.blockUI({ message: $('#divericode'),
	            css: { width: '360px' }
	        });
	        $(".vericode").focus();

	        $('.vericode').keydown(function () {
	            if (event.keyCode == 13) {
	                chkVeriCode();
	            }
	        });
	    });

	    function chkVeriCode() {
	        if ($(".vericode").val() == "") {
	            alert('请输入验证码!');
	            return;
	        }
	        $.ajax({ url: "ajax/chkmatvericode.aspx",
	            type: "post",
	            async: false,    //不允许同步做其它操作
	            dataType: "json",
	            data: "vericode=" + $(".vericode").val(),
	            error: function (msg) {
	                alert('检测验证码失败!');
	            },
	            success: function (json) {
	                if (json.msg == 1) {
	                    setTimeout($.unblockUI, 0);
	                    $(".vericode").val($(".vericode").val());

	                } else {
	                    alert('验证码输入错误,请重新输入!');
	                    $(".vericode").val('');
	                    $(".vericode").focus();
	                }

	            }
	        });
	    }
	    function ShowPrie() {
	        var id = $(".hid").val();

	        if (id == undefined) {
	            alert("请选择维修单!");
	            return;
            }
	        window.showModalDialog("mat_quote.aspx?id="+id+"&_d=" + (new Date())
                              , " ", " edge: Raised; center: Yes; help: Yes; resizable: Yes; status: No; dialogHeight:460px; dialogWidth:620px")
	    }
    </script>
    <script type="text/javascript" src="../greybox/AJS.js"></script>
    <script type="text/javascript" src="../greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="../greybox/gb_scripts.js"></script> 
    <script type="text/javascript" src="../greybox/matjs.js"></script> 
</head>
<body> 
<form id="form1" runat="server" >
 <div id="divericode" style=" width: 360px; vertical-align:middle; display:none;
         height: 45px; background-color: #ccc; border: 1px solid #cad9ea;">
        <table width="100%" >
            <tr>
                <td align="center">
                    <span style=" font-size:12px">请输入正确的验证码:</span>
                    <input id="vericode" name="vericode" style="width: 125px" class="vericode" runat="server" />
					<input type="button"  value="提  交" class="btn" onclick="chkVeriCode()" />
                </td>
            </tr>
            
            
        </table>
</div>
  <asp:ScriptManager ID="ScriptManager1" runat="server">
      </asp:ScriptManager>
<div  class="BContent" >
<table width="100%"> 
 <colgroup>
  <col width="300px" align="left"/><col width="120px" align="left"/><col width="480px" align="left"/><col style="width:1%;"/>
 </colgroup>  
<tr>
 <td nowrap>
 <asp:UpdatePanel ID="UpdatePanel2" runat="server">
      <ContentTemplate>
   种类：<asp:DropDownList ID="drpType" runat="server" Width="100"  AutoPostBack="true"
         onselectedindexchanged="drpType_SelectedIndexChanged"> </asp:DropDownList>
         &nbsp;&nbsp;&nbsp;&nbsp;品类：
         <asp:DropDownList ID="drpchild" runat="server" Width="100" ><asp:ListItem Value="-1" Text="全部"></asp:ListItem> </asp:DropDownList>
        </ContentTemplate>
        </asp:UpdatePanel>
   </td> 
 <td nowrap>状态：<asp:DropDownList ID="drpState" runat="server"> <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem> 
 <asp:ListItem Text="已上报" Value="1"></asp:ListItem> 
 <asp:ListItem Text="已跟进" Value="2" ></asp:ListItem> <asp:ListItem Text="已退回" Value="3" ></asp:ListItem> 
 <asp:ListItem Text="超期" Value="4" ></asp:ListItem> <asp:ListItem Text="完成" Value="5" ></asp:ListItem> 
  <asp:ListItem Text="费用审核" Value="6" ></asp:ListItem> 
 </asp:DropDownList></td> 
 <td nowrap>
  <table ><tr>
  <td> 查询方式：</td>
  <td>
     <select id="drpDate"  onchange="drpDate_onchange(this.value)" runat="server"><option value="2" selected="selected">年月</option></select> 
  </td>
  <td nowrap>
     <table id="tbDatespan" style="display:none"><tr nowrap>
        <td>报修时间：</td>
        <td><igsch:webdatechooser id="WebDateChooserDateBegin" runat="server"  value="" > </igsch:webdatechooser></td>
        <td>到</td>
        <td><igsch:webdatechooser id="WebDateChooserDateEnd" runat="server" value="" ></igsch:webdatechooser> </td>
         </tr></table>
     <table id="tbYearMonth" >
      <tr> <td><select id="drpYear" runat="server"></select>&nbsp;年</td> </tr>
      </table>
      
      </td></tr></table>
 </td>   
 <td></td>
 </tr> 
<tr  style="border-bottom:solid 1px #000000; border:solid 1px #cccccc; "> 
    <td colspan="9">
        <div style="display:none">
             <a id="abtnfb" runat="server" style="width:100px" href=""  rel="gb_page_center[500,340]">  
             <input type="button" id="Button1" style="width:100px;" runat="server" value="回复" class="btn" />   </a>  
             <a id="abtnChange" runat="server" href=""  rel="gb_page_center[500,300]"> 
             <asp:Button ID="btnChange"  runat="server" CssClass="btn" Text="更改计划" /> </a>
        </div>
         
        <a id="a13" runat="server" style="width:100px"  
            onclick='ShowPrie() '
        >  
        <input type="button" id="Button2" style="width:100px;" runat="server" value="报价" class="btn" />   </a> 
         
     <asp:Button ID="BtnSearch" runat="server" Text="查  询" CssClass="btn btnquery" OnClick="BtnSearch_Click" />
       &nbsp;筛选条件：&nbsp;&nbsp;
              <asp:DropDownList ID="drps" runat="server"> 
              <asp:ListItem Text="无" Value="-1" Selected="True"></asp:ListItem> 
              <asp:ListItem Text="按店编号" Value="0"></asp:ListItem> 
             <asp:ListItem Text="按店名称" Value="1" ></asp:ListItem>
              <asp:ListItem Text="地区编号" Value="2" ></asp:ListItem> 
              <asp:ListItem Text="大区名称" Value="3" ></asp:ListItem> 
              <asp:ListItem Text="施工单位" Value="4" ></asp:ListItem> 
              <asp:ListItem Text="质保" Value="5" ></asp:ListItem> 
             </asp:DropDownList>
             &nbsp;<input id="txtCondition" runat="server"  />
    </td>
</tr>
</table>
<table width="100%">
<tr>
  <td  colspan="9">  
    <div id="div1" runat="server"  style="display:none">      <!-- 按年份、月查询-->
      <asp:UpdatePanel ID="UpdatePanel1" runat="server">
      <ContentTemplate>
       <input type="hidden" id="txtSort" value="asc" runat="server" />
       <input type="hidden" id="txtSortExpression" value="" runat="server" />
      <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="billid"
          AutoGenerateColumns="False" CellPadding="3"  CssClass="tbGrid" CellSpacing="1" 
          ForeColor="#333333" GridLines="None" Width="100%" PageSize="15" 
          onpageindexchanged="gv_PageIndexChanged" onpageindexchanging="gv_PageIndexChanging" 
          onrowdatabound="gv_RowDataBound" onsorting="gv_Sorting">
          <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
          <Columns >           
             <asp:TemplateField HeaderText="选择" >
                <HeaderTemplate>
                    <asp:CheckBox runat="server" ID="ckbSelectall" Width="2%" OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" />
                </HeaderTemplate>
                <ItemTemplate><asp:CheckBox runat="server"   ID="ckbDel" Width="2%" OnCheckedChanged="chk_OnCheckedChanged" AutoPostBack="true"  ToolTip='<%# Eval("billid") %>'  /> </ItemTemplate>
             </asp:TemplateField> 
              <asp:TemplateField HeaderText="图片">
              <ItemTemplate>
               <a href='<%# "imgs/"+Eval("img").ToString() %>'  rel="gb_imageset[site]" target="_blank"><img src='<%# "imgst/"+Eval("img").ToString() %>' style="width:30px;height:20px; border:none;" /></a>
              </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="billid" HeaderText="编号" SortExpression="billid" />  
              <asp:TemplateField HeaderText="店铺">
              <ItemTemplate>
                  <a style="text-decoration:underline;cursor:pointer;" onclick='javascript:showDlg("mat_bill_upd.aspx?id="+<%# Eval("billid") %>+"&state="+<%# Eval("state") %>);funline(this);'><%# Eval("d_name")%></a>
              </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="typeparentName" HeaderText="种类"  /> 
              <asp:BoundField DataField="typename" HeaderText="品类"  /> 
              <asp:TemplateField  HeaderText="内容" HeaderStyle-Width="60" >
               <ItemTemplate>
               <%# Eval("content").ToString().Length > 10 ? "<marquee  width='60' scrolldelay='300'>" + Eval("content") + "</marquee>" : Eval("content")%>
                </ItemTemplate>
              </asp:TemplateField>  
              <asp:BoundField HeaderText="状态" DataField="state" ItemStyle-Font-Bold="true" />  
              <asp:BoundField DataField="chk_date" HeaderText="报修时间" SortExpression="chk_date" DataFormatString="{0:d}" />   
              <asp:BoundField DataField="fb_date" HeaderText="反馈时间"  SortExpression="fb_date" DataFormatString="{0:d}"/> 
              <asp:TemplateField HeaderText="施工单位"><ItemTemplate>
                <a style="text-decoration:underline" href='#' onclick='javascript:lineOrgId(<%# Eval("orgid").ToString()%>);' ><%# Eval("name")%></a>
              
              </ItemTemplate></asp:TemplateField>       
              <asp:BoundField DataField="schemaendDate" HeaderText="计划完成时间" SortExpression="schemaendDate" DataFormatString="{0:d}" HtmlEncode="False" />
              <asp:BoundField DataField="endDate" HeaderText="完工时间" SortExpression="endDate" DataFormatString="{0:d}" HtmlEncode="False" />
                <asp:TemplateField HeaderText="质保">
              <ItemTemplate><%# Eval("isquality").ToString() == "1" ? "是" : "否"%> </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="更改计划" Visible="false">
              <ItemTemplate>  <asp:TextBox   ID="txtschema" runat="server" Text='<%# Eval("ischangeschema").ToString() %>'></asp:TextBox> </ItemTemplate>
              </asp:TemplateField>
          </Columns>
          <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
         <PagerSettings Mode="NumericFirstLast"  FirstPageText="首页" LastPageText="最后" Position="bottom" PageButtonCount="4" />   
           <EmptyDataTemplate>
          <table cellspacing="0" cellpadding="4" border="0" id="ctl00_ctplhder_GridMonth" style="color:#333333;width:100%;border-collapse:collapse;">
	        <tr class="header" >
		    <th scope="col"><a href="#">编号</a></th>
		    <th scope="col"><a href="#" >店铺</a></th>
		    <th scope="col"><a href="#" >品类</a></th>	
		    <th scope="col"><a href="#" >内容</a></th>	
		    <th scope="col"><a href="#" >状态</a></th>
		    <th scope="col"><a href="#" >报修时间</a></th>
		    <th scope="col"><a href="#" >反馈时间</a></th>			
    	    <th scope="col"><a href="#" >施工单位</a></th>			
		    <th scope="col"><a href="#" >创建时间</a></th>			
		    <th scope="col"><a href="#" >创建人</a></th>
	      </tr>
          </table>
          </EmptyDataTemplate>
          <EditRowStyle BackColor="#2461BF" />
          <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
          <PagerStyle CssClass="header"  HorizontalAlign="Left" />
          <HeaderStyle CssClass="dgHeader"    HorizontalAlign="Center" />
          <AlternatingRowStyle BackColor="White" />
      </asp:GridView>     
       </ContentTemplate>
       <Triggers><asp:AsyncPostBackTrigger ControlID="BtnSearch" />
     <asp:AsyncPostBackTrigger ControlID="btnChange"></asp:AsyncPostBackTrigger>
          </Triggers>
      </asp:UpdatePanel>   
      </div>  
      <div id="div2" runat="server">
      <!-- 按年份、月查询 没有分页功能-->
          <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                  <ContentTemplate>
       <table cellspacing="5" width="80%"><tr nowrap><td><a id="a1" onserverclick="MonthQuery"  runat="server">一月</a></td><td><a id="a2" onserverclick="MonthQuery"  runat="server">二月</a></td><td><a id="a3" onserverclick="MonthQuery" runat="server">三月</a></td><td><a id="a4" onserverclick="MonthQuery" runat="server">四月</a></td><td><a id="a5" onserverclick="MonthQuery" runat="server">五月</a></td><td><a id="a6" onserverclick="MonthQuery" runat="server">六月</a></td><td><a id="a7" onserverclick="MonthQuery" runat="server">七月</a></td><td><a id="a8" onserverclick="MonthQuery" runat="server">八月</a></td><td><a id="a9" onserverclick="MonthQuery" runat="server">九月</a></td><td><a id="a10" onserverclick="MonthQuery" runat="server">十月</a></td><td><a id="a11" onserverclick="MonthQuery" runat="server">十一月</a></td><td><a id="a12" onserverclick="MonthQuery" runat="server">十二月</a></td></tr></table>
                   <input type="hidden" id="txtSort2" value="asc" runat="server" />
                   <input type="hidden" id="txtSortExpression2" value="" runat="server" />
                   <input type="hidden" id="hidSelectMonth" runat="server" />
                  <asp:GridView ID="gv2" runat="server" AllowSorting="True" DataKeyNames="billid"
                      AutoGenerateColumns="False" CellPadding="3"  CssClass="tbGrid" CellSpacing="1" 
                      ForeColor="#333333" GridLines="None" Width="100%"                      
                      onrowdatabound="gv2_RowDataBound" onsorting="gv2_Sorting">
                      <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                      <Columns >           
                         <asp:TemplateField HeaderText="选择" >
                            <HeaderTemplate>
                                <%--<asp:CheckBox runat="server" ID="ckbSelectall" Width="2%" OnCheckedChanged="ckbSelectall2_CheckedChanged" AutoPostBack="true" />--%>
                                <asp:TextBox ID="hid" CssClass="hid" runat="server" style="display:none"></asp:TextBox>
                           
                            </HeaderTemplate>
                            <ItemTemplate><asp:CheckBox runat="server"   ID="ckbDel" Width="2%" OnCheckedChanged="chk2_OnCheckedChanged" AutoPostBack="true"  ToolTip='<%# Eval("billid") %>'  /> </ItemTemplate>
                         </asp:TemplateField> 
                          <asp:TemplateField HeaderText="图片">
                          <ItemTemplate>
                           <a href='<%# "imgs/"+Eval("img").ToString() %>'  rel="gb_imageset[site]" target="_blank"><img src='<%# "imgst/"+Eval("img").ToString() %>' style="width:30px;height:20px; border:none;" /></a>
                          </ItemTemplate>
                          </asp:TemplateField>
                          <asp:BoundField DataField="billid" HeaderText="编号" SortExpression="billid" />  
                          <asp:TemplateField HeaderText="店铺">
                          <ItemTemplate>
                           <a style="text-decoration:underline;cursor:pointer;" onclick='javascript:showDlg("mat_bill_upd.aspx?id="+<%# Eval("billid") %>+"&state="+<%# Eval("state") %>);funline(this);'><%# Eval("d_name")%></a>
                          <%--    <a style="text-decoration:underline;cursor:pointer;" onclick='javascript:window.showModalDialog("mat_bill_upd.aspx?id="+<%# Eval("billid") %>+"&state=1"
                              ," " ," edge: Raised; center: Yes; help: Yes; resizable: Yes; status: No; dialogHeight:600px; dialogWidth:800px");funline(this);'><%# Eval("d_name")%></a>--%>
                          </ItemTemplate>
                          </asp:TemplateField>
                          <asp:BoundField DataField="typeparentName" HeaderText="种类"  /> 
                          <asp:BoundField DataField="typename" HeaderText="品类"  /> 
                          <asp:TemplateField  HeaderText="内容" HeaderStyle-Width="60" >
                           <ItemTemplate>
                           <%# Eval("content").ToString().Length > 10 ? "<marquee  width='60' scrolldelay='300'>" + Eval("content") + "</marquee>" : Eval("content")%>
                            </ItemTemplate>
                          </asp:TemplateField>  
                          <asp:BoundField HeaderText="状态" DataField="state" ItemStyle-Font-Bold="true" />  
                          <asp:BoundField DataField="chk_date" HeaderText="报修时间" SortExpression="chk_date" DataFormatString="{0:d}" />   
                          <asp:BoundField DataField="fb_date" HeaderText="反馈时间"  SortExpression="fb_date" DataFormatString="{0:d}"/> 
                          <asp:TemplateField HeaderText="施工单位"><ItemTemplate>
                             <a ><%# Eval("name")%></a>
                          
                          </ItemTemplate></asp:TemplateField>       
                          <asp:BoundField DataField="schemaendDate" HeaderText="计划完成时间" SortExpression="schemaendDate" DataFormatString="{0:d}" HtmlEncode="False" />
                          <asp:BoundField DataField="endDate" HeaderText="完工时间" SortExpression="endDate" DataFormatString="{0:d}" HtmlEncode="False" />
                            <asp:TemplateField HeaderText="质保">
                          <ItemTemplate><%# Eval("isquality").ToString() == "1" ? "是" : "否"%> </ItemTemplate>
                          </asp:TemplateField>
                          <asp:TemplateField HeaderText="更改计划" Visible="false">
                          <ItemTemplate>  <asp:TextBox   ID="txtschema" runat="server" Text='<%# Eval("ischangeschema").ToString() %>'></asp:TextBox> </ItemTemplate>
                          </asp:TemplateField>

                          <asp:TemplateField HeaderText="合计金额"><ItemTemplate>
                            
                            <%-- <a ><%# Eval("ssums")%></a>   --%>
                             
                            <a title="点击查看费用明细"  style="text-decoration:underline;cursor:pointer;" 
                            onclick='javascript:window.showModalDialog("mat_quote.aspx?id="+<%# Eval("billid") %>+"&state="+<%# Eval("state") %>+"&_d=" + (new Date()),
                            " " ," edge: Raised; center: Yes; help: Yes; resizable: Yes; status: No; dialogHeight:460px; dialogWidth:620px");funline(this);'>
                            <%# Eval("ssums")%></a>                     
                          </ItemTemplate></asp:TemplateField>    
                      </Columns>
                      <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                     <PagerSettings Mode="NumericFirstLast"  FirstPageText="首页" LastPageText="最后" Position="bottom" PageButtonCount="4" />   
                       <EmptyDataTemplate>
                      <table cellspacing="0" cellpadding="4" border="0" id="ctl00_ctplhder_GridMonth2" style="color:#333333;width:100%;border-collapse:collapse;">
	                <tr class="header" >
		            <th scope="col"><a href="#">编号</a></th>
		            <th scope="col"><a href="#" >店铺</a></th>
		            <th scope="col"><a href="#" >品类</a></th>	
		            <th scope="col"><a href="#" >内容</a></th>	
		            <th scope="col"><a href="#" >状态</a></th>
		            <th scope="col"><a href="#" >报修时间</a></th>
		            <th scope="col"><a href="#" >反馈时间</a></th>			
    	            <th scope="col"><a href="#" >施工单位</a></th>			
		            <th scope="col"><a href="#" >创建时间</a></th>			
		            <th scope="col"><a href="#" >创建人</a></th>
	              </tr>
                  </table>
                      </EmptyDataTemplate>
                      <EditRowStyle BackColor="#2461BF" />
                      <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                      <PagerStyle CssClass="header"  HorizontalAlign="Left" />
                      <HeaderStyle CssClass="dgHeader"    HorizontalAlign="Center" />
                      <AlternatingRowStyle BackColor="White" />
                  </asp:GridView>
                 
                   </ContentTemplate>
                   <Triggers><asp:AsyncPostBackTrigger ControlID="BtnSearch" />
            <asp:AsyncPostBackTrigger ControlID="btnChange"></asp:AsyncPostBackTrigger>
                      </Triggers>
                  </asp:UpdatePanel>   
      </div>  

  </td>
</tr>
</table>
     
    </div>
   
    </form>
</body>
</html>
