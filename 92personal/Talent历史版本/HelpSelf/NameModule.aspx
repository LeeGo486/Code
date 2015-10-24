<%@ Page Title="" Language="C#" MasterPageFile="~/HelpSelf.Master" AutoEventWireup="true" CodeBehind="NameModule.aspx.cs" Inherits="HelpSelf.Web.NameModule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>IP功能模块</title>
    <link href="/Style/Site.css" rel="stylesheet" type="text/css" />
    <link href="/ImagesMenu/common.css" rel="stylesheet" type="text/css" />
    <link href="/Style/pagination.css" rel="stylesheet" type="text/css" />
    <link href="/Style/table.css" rel="stylesheet" type="text/css" />
    <link href="/Style/calendar.css" rel="stylesheet" type="text/css"  />
    <script src="/Script/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script src="/Script/public.js" type="text/javascript"></script>
    <script src="/Script/pop.js" type="text/javascript"></script>
    <script src="/Script/jquery.pagination.js" type="text/javascript"></script>
    <script src="/Script/cal.js" type="text/javascript"  charset="utf-8"></script>
    <script type="text/javascript">
        globalapplypage=0 ;
        function modulecall(pageindex, jq) {
            var query = "{pagesize:'0',index:'" + (pageindex + 1) + "',querystr:\""+ GetQueryStr() +"\"}" ;
            $.ajaxWebService("NameModule.aspx/GetModuleListWeb", query, function (result) {
                var pager=eval("("+result.d.toString()+")");
                $("#orderapply").html(pager.html);
                module_event();//添加事件
                pagerpagination("OrderApplyPage", pager.total, pageindex, modulecall);
                globalapplypage = pageindex ;
            });
        }

        $(function(){
            module_event();//添加事件
            pagerpagination("OrderApplyPage", <%=p.total %>, 0, modulecall);
        });

        function module_event() {
            $("#orderapply tr").mousemove(function () {
                $(this).children().addClass("tr_bg");
            }).mouseleave(function () {
                $(this).children().removeClass("tr_bg");
            }).click(function () {
                if ($(this).children().hasClass("tr_bg_sel")) {
                    $(this).children().removeClass("tr_bg_sel");
                }
                else {
                    $(this).children().addClass("tr_bg_sel").end().siblings().children().removeClass("tr_bg_sel");
                }
            });
        }
    </script>
    <script type="text/javascript">
        function getModuleList() {
            var tmptr = $("#orderapply tr");
            var flag = false;
            var obj = "[";
            var tmpstr = "";
            $.each(tmptr, function (i, item) {
                if (flag == true) obj += ",";
                var child = $(item).children();
                obj += "{";
                obj += "NP_No:'" + child.eq(0).find("input").val() + "',";
                obj += "NP_M_No:'" + child.eq(1).find("select").val() + "',";
                obj += "NP_Name:'" + encodeURI(child.eq(2).find("input").val()) + "',";
                obj += "NP_Status:'" + child.eq(3).find("select").val() + "'";
                obj += "}";
                flag = true;
            });
            obj += "]";
            return obj;
        }

        //查询条件
        function GetQueryStr() {
            var queryStr = "";
            if ($("#cxNP_M_No").val().trim() != "") {
                queryStr += " and NP_M_No ='" + $("#cxNP_M_No").val().trim() + "' ";
            }
            if ($("#cxNP_Name").val().trim() != "") {
                queryStr += " and NP_Name  like '%" + $("#cxNP_Name").val().trim() + "%' ";
            }
            if ($("#cxNP_Status").val().trim() != "") {
                queryStr += " and NP_Status ='" + $("#cxNP_Status").val().trim() + "' ";
            }
            return queryStr;
        }

    </script>
    <script type="text/javascript">
        $(function () {
            //列表查找
            $("input[name='orderapplysearch']").click(function () {
                modulecall(0);
            });
            //列表查找clear
            $("input[name='orderapplyclear']").click(function () {
                $("#cxNP_M_No").val("");
                $("#cxNP_Name").val("");
                $("#cxNP_Status").val("");
            });

            $("input[name='orderapplyadd']").click(function () {
                $("#orderapply").prepend($("<tr><td><input name='NP_No' value='0' type='checkbox'  /></td><td><select name='NP_M_No'><%=moduledb.GetOptions(0,-1) %></select></td>" +
                  "<td><input  name='NP_Name' class=gray  value=''  style='width:300px' />" +
                  "</td><td><select name='NP_Status'><option value='1' >有效</option><option value='0' >无效</option></select></td></tr>").mousemove(function () { $(this).children().addClass("tr_bg"); }).mouseleave(function () { $(this).children().removeClass("tr_bg"); }).click(function () {
                      if ($(this).children().hasClass("tr_bg_sel")) {
                          $(this).children().removeClass("tr_bg_sel");
                      }
                      else {
                          $(this).children().addClass("tr_bg_sel").end().siblings().children().removeClass("tr_bg_sel");
                      }
                  }));
            });
            $("input[name='orderapplysave']").click(function () {
                $.ajaxWebService("NameModule.aspx/SaveOrUpdateList", "{list:\"" + getModuleList() + "\"}", function (result) {
                    var obj = eval("(" + result.d.toString() + ")");
                    alert(obj.html);
                    if (obj.flag == "true") {
                        modulecall(globalapplypage);
                    }
                });
            });
            $("input[name='orderapplydelete']").click(function () {
                if (confirm("确定批量删除记录吗？") == false) return;
                var tmp = "";
                var ip_no = "";
                var tr_sel = $("#orderapply tr input[type='checkbox']:checked");
                for (var i = 0; i < tr_sel.length; i++) {
                    ip_no = $.trim(tr_sel.eq(i).val());
                    if (ip_no == "0") {
                        tr_sel.parents("tr:first").remove();
                    } else {
                        if (tmp != "") tmp += ",";
                        tmp += ip_no;
                    }
                }

                if (tmp == "") {
                    return;
                }

                $.ajaxWebService("NameModule.aspx/deleteModule", "{NP_Nolist:'" + tmp + "'}", function (result) {
                    var obj = eval("(" + result.d.toString() + ")");
                    alert(obj.html);
                    if (obj.flag == "true") {
                        $("#orderapply tr input[type='checkbox']:checked").parents("tr:first").remove();
                        modulecall(0);
                    }
                });

            });

            $("#checkall").click(function () {
                var allcheckstatus = $("#checkall")[0].checked;
                var chkArr = $("#orderapply  input[type='checkbox']");
                $.each(chkArr, function (i, item) {
                    item.checked = allcheckstatus;
                });
            });

            //注销 begin
            $("#cancell").click(function () {
                if (confirm("确定注销吗？") == false) return;
                wy_zx();
            });
            //注销 end
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
<div id="nav"  class="fontclass">
    <ul>
        <li class="bg_image" name="Module.aspx" >功能模块</li>
        <li class="bg_image" name="IPModule.aspx" >IP功能模块</li>
        <li class="bg_image_onclick" name="NameModule.aspx" >名字模块</li>
    </ul>
</div>
<div id="sub_info"  class="fontclass"><div style="width:80%; float:left">&nbsp;&nbsp;<img  src="ImagesMenu/hi.gif" />&nbsp;<span id="Span1" >自助名字模块</span></div><div style="width:10%;float:right;"><span><a target=_self href="userModules.aspx">自助平台首页</a></span></div></div>
<script type="text/javascript">
    $(function () {
        $("#nav .bg_image").click(function () {
            window.location.href = $(this).attr("name");
        });
    });
</script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="17" valign="top" background="images/mail_leftbg.gif"><img src="images/left-top-right.gif" width="17" height="29" /></td>
    <td valign="top" background="images/content-bg.gif">
    <table width="100%" height="31" border="0" cellpadding="0" cellspacing="0" class="left_topbg" id="table2">
      <tr>
        <td height="31" style=" width:90%"><div class="titlebt  titlebtimage"  name="lists">&nbsp;&nbsp;列&nbsp;&nbsp;&nbsp;&nbsp;表</div></td><td height="31"  style="width:10%;" ><div class="titlebt" style=" float:right; padding-right:10px" id="cancell" >注销</div></td>
      </tr>
    </table>
    </td>

    <td width="16" valign="top" background="images/mail_rightbg.gif"><img src="images/nav-right-bg.gif" width="16" height="29" /></td>
  </tr>
  <tr style=" height:400px">
    <td valign="middle" background="images/mail_leftbg.gif">&nbsp;</td>
    <td valign="top" bgcolor="#F7F8F9">
   
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td colspan="2" valign="top">&nbsp;</td>
        <td>&nbsp;</td>
        <td valign="top">&nbsp;</td>
      </tr>
      <tr id="lists">
      	<td colspan="4">
            <!--begin 列表查询 -->
            <div class="tabledata" style="width:100%">
                 
               <table border="0" cellpadding="4" cellspacing="0" style="margin-bottom:0px; margin-top:0px">
                  <thead>
                       <tr >
    			        <td class="bold" >查询条件：</td>
  		               </tr>
                  </thead>
              </table>

      	      <table border="0" cellpadding="4" cellspacing="1"  style="margin-top:0px;margin-bottom:0px">
                  <tbody>
                    <tr >
    			        <td  width="10%" class="bold" >模块名称：</td>
                        <td width="40%">
                        <select id="cxNP_M_No">
                            <option value=""></option>
                            <%=moduledb.GetOptions(0,-1) %>
                        </select>
                        </td>
    			        <td width="10%" class="bold">姓名:</td>
                        <td width="40%"><input type="text" id="cxNP_Name" value=""  style="width:300px"/></td>
  		            </tr>
                  </tbody>
              </table>
             
              <table border="0" cellpadding="4" cellspacing="1"  style="margin-top:0px; ">
                  <tbody>
                    <tr>
                        <td width="10%" class="bold">状态:</td>
                        <td width="40%"><select id="cxNP_Status"><option value=""></option><option value="1">有效</option><option value="0">无效</option></select></td>
                        <td width="50%">
                            <div class="impBtn hMargin  shadow"  style="display:block;float:left;" ><input type="button" name="orderapplysearch" value="查找" class="search imgButton" ></div>
                            <div class="impBtn hMargin  shadow"  style="display:block;float:left;" ><input type="button" name="orderapplyclear" value="清空" class="clear imgButton"></div>
                        </td>
                    </tr>
                  </tbody>
                </table>

            </div>
           <!-- end 列表查询 -->
            <!-- begin 列表操作 -->
            <div class="operate">
                <div class="impBtn hMargin fLeft shadow" ><input type="button" name="orderapplyadd" value="添加" class="add imgButton"></div>
                <div class="impBtn hMargin fLeft shadow" > <input type="button" name="orderapplysave" value="保存" class="filesave imgButton" /></div>
               <!-- <div class="impBtn hMargin fLeft shadow" ><input type="button" name="orderapplysearch" value="查找" class="search imgButton" ></div>-->
            </div>
            <div class="operate2">
                <div class="impBtn hMargin fLeft shadow" ><input type="button" name="orderapplydelete" value="删除"  class="delete imgButton"></div>
            </div>
            <!-- end 列表操作 -->

            <!-- beign 列表信息 -->
            <div class="tabledata">
              <table border="0" cellpadding="4" cellspacing="1">
                  <thead>
                      <tr  >
                          <td width="4%"><input id="checkall" type="checkbox" /></td>
                          <td width="40%">模块名称</td><td  width="38%" >姓名</td>
                          <td width="18%" >状态</td>
                      </tr>
                  </thead>
                  <tbody id="orderapply" >
                       <%=p.html %>
                  </tbody>
              </table>
            </div>
            <!-- end 列表信息 -->

            <!--begin 列表分页   -->
            <div id="OrderApplyPage" ></div>
            <!--end 列表分页   -->
      	</td>
      </tr>
    </table>
    </td> 
    <td background="images/mail_rightbg.gif">&nbsp;</td>
  </tr>
  <tr>
    <td valign="bottom" background="images/mail_leftbg.gif"><img src="images/buttom_left2.gif" width="17" height="17" /></td>
    <td background="images/buttom_bgs.gif"><img src="images/buttom_bgs.gif" width="17" height="17"></td>
    <td valign="bottom" background="images/mail_rightbg.gif"><img src="images/buttom_right2.gif" width="16" height="17" /></td>
  </tr>
</table>
</asp:Content>
