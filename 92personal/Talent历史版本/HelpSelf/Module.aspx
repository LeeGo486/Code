<%@ Page Title="" Language="C#" MasterPageFile="~/HelpSelf.Master" AutoEventWireup="true" CodeBehind="Module.aspx.cs" Inherits="HelpSelf.Web.Module" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>功能模块</title>
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
            var query = "{pagesize:'0',index:'" + (pageindex + 1) + "',querystr:\"\"}" ;
            $.ajaxWebService("Module.aspx/GetModuleListWeb", query, function (result) {
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
                obj += "M_No:'" +  child.eq(0).find("input[name='M_No']").val() + "',";
                obj += "M_Name:'" + encodeURI(child.eq(0).find("input[name='M_Name']").val()) + "',";
                obj += "M_Desc:'" + encodeURI(child.eq(1).find("input").val()) + "',";
                obj += "M_Type:'" + child.eq(2).find("select").val() + "',";
                obj += "M_Status:'" + encodeURI(child.eq(3).find("select").val()) + "',";
                obj += "M_Url:'" + encodeURI(child.eq(4).find("input").val()) + "',";
                obj += "M_Pic:'" + encodeURI(child.eq(5).find("input").val()) + "'";
                obj += "}";
                flag = true;
            });
            obj += "]";
            return obj;
        }

        function getSelObj() {
            var tr_sel = $("#orderapply tr td.tr_bg_sel");
            if (tr_sel.length == 6) {
                return tr_sel.find("input[name='M_No']").val();
            } else {
                return "";
            }
        }

    </script>
    <script type="text/javascript">
        $(function () {
            $("input[name='orderapplyadd']").click(function () {
                $("#orderapply").prepend($("<tr><td><input name='M_No' value='0' type='hidden'  /><input class='gray' name='M_Name' value=''  style='width:115px' /></td><td><input class='gray' name='M_Desc' value=''  style='width:205px' /></td>" +
                  "<td><select name='M_Type'><option value='0'>名字</option><option value='1'>IP</option><option value='2'>所有</option></select>" +
                  "</td><td><select name='M_Status'><option value='1'>有效</option><option value='0'>无效</option></select>" +
                  "</td><td><input class='gray'  name='M_Url' value=''  style='width:240px' /></td><td><input class='gray'  name='M_Pic' value=''  style='width:115px' /></td></tr>").mousemove(function () { $(this).children().addClass("tr_bg"); }).mouseleave(function () { $(this).children().removeClass("tr_bg"); }).click(function () {
                      if ($(this).children().hasClass("tr_bg_sel")) {
                          $(this).children().removeClass("tr_bg_sel");
                      }
                      else {
                          $(this).children().addClass("tr_bg_sel").end().siblings().children().removeClass("tr_bg_sel");
                      }
                  }));
            });
            $("input[name='orderapplysave']").click(function () {
                $.ajaxWebService("Module.aspx/SaveOrUpdateList", "{list:\"" + getModuleList() + "\"}", function (result) {
                    var obj = eval("(" + result.d.toString() + ")");
                    alert(obj.html);
                    if (obj.flag == "true") {
                        modulecall(globalapplypage);
                    }
                });
            });
            $("input[name='orderapplydelete']").click(function () {
                var selid = getSelObj();
                if (selid == "") {
                    alert("请先选择需要删除的记录");
                    return;
                }
                if (confirm("确定批量删除记录吗？") == false) return;
                if (selid == "0") {
                    $("#orderapply tr td.tr_bg_sel").parent().remove();
                } else {
                    $.ajaxWebService("Module.aspx/deleteModule", "{M_No:\"" + selid + "\"}", function (result) {
                        var obj = eval("(" + result.d.toString() + ")");
                        alert(obj.html);
                        if (obj.flag == "true") {
                            $("#orderapply tr td.tr_bg_sel").parent().remove();
                        }
                    });
                }
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
        <li class="bg_image_onclick" name="Module.aspx" >功能模块</li>
        <li class="bg_image" name="IPModule.aspx" >IP功能模块</li>
        <li class="bg_image" name="NameModule.aspx" >名字模块</li>
    </ul>
</div>
<div id="sub_info"  class="fontclass"><div style="width:80%; float:left">&nbsp;&nbsp;<img  src="ImagesMenu/hi.gif" />&nbsp;<span id="show_text" >自助功能模块</span></div><div style="width:10%;float:right;"><span><a target=_self href="userModules.aspx">自助平台首页</a></span></div></div>
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
            <!--begin 列表查询 
            <div class="tabledata" style="width:100%">
                 
               <table border="0" cellpadding="4" cellspacing="0" style="margin-bottom:0px; margin-top:0px">
                  <thead>
                       <tr >
    			        <td class="bold" >查询条件w：</td>
  		               </tr>
                  </thead>
              </table>

      	      <table border="0" cellpadding="4" cellspacing="1"  style="margin-top:0px;margin-bottom:0px">
                  <tbody>
                       <tr >
    			        <td  width="10%" class="bold" >表单编号：</td>
                        <td width="14%"><input type="text" id="orderapplybh" value=""   size=11 /></td>
    			        <td width="10%" class="bold">表单状态:</td>
                        <td width="10%"><select  name="applyState" id="orderapplystate" >
                                            <option value=""></option>
                                            <option value="未申请">未申请</option>
                                            <option value="已申请">已申请</option>
                                            <option value="已受理">已受理</option>
                                        </select></td>
    			        <td width="9%" class="bold">汇总状态:</td>
                        <td width="7%"><select  name="applyState1"  id="orderapplystate1">
                                            <option value=""></option>
                                            <option value="是">是</option>
                                            <option value="否">否</option>
                                        </select></td>
                        <td width="9%" class="bold">创建日期:</td>
                        <td width="30%"><input type="text" value="" id="orderapplycreatebegin"   size=8 /><span style="font-weight:bold;font-size:14px">&nbsp;至&nbsp;</span><input type="text" value="" id="orderapplycreateend"  size=8 /></td>
  		            </tr>
                  </tbody>
              </table>
             
              <table border="0" cellpadding="4" cellspacing="1"  style="margin-top:0px; ">
                  <tbody>
                       <tr >
    			      <td  width="10%" class="bold" >修改人：</td>
                        <td width="14%"><input type="text" value="" id="orderapplyupdateman"   size=8 /></td>
    			        <td width="9%" class="bold">修改日期:</td>
                        <td width="28%"><input type="text" value="" id="orderapplyupdatebegin" readonly="true" size=8 /><span  style="font-weight:bold;font-size:14px">&nbsp;至&nbsp;</span><input type="text" value="" id="orderapplyupdateend" readonly="true" size=8  /></td>
    			      
                        <td width="10%" class="bold">申请日期:<input type="hidden" value="" id="orderapplyupdateman"   size=8 /><input type="hidden" value="" id="orderapplyupdatebegin" readonly="true" size=8 /><input type="hidden" value="" id="orderapplyupdateend" readonly="true" size=8  /></td>
                        <td width="30%"><input type="text" value="" id="orderapplyapplybegin"  size=8 /><span style="font-weight:bold;font-size:14px">&nbsp;至&nbsp;</span><input id="orderapplyapplyend" type="text" value=""  size=8 /></td>
                        <td width="60%">
                            <div class="impBtn hMargin  shadow"  style="display:block;float:left;" ><input type="button" name="orderapplysearch" value="查找" class="search imgButton" ></div>
                            <div class="impBtn hMargin  shadow"  style="display:block;float:left;" ><input type="button" name="orderapplyclear" value="清空" class="clear imgButton"></div>
                        </td>
                    </tr>
                  </tbody>
                </table>

            </div>
            end 列表查询 -->
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
                          <td width="15%">模块名称</td><td  width="25%" >模块描述</td><td width="8%" >模块类型</td>
                          <td width="8%" >模块状态</td><td width="29%" >模块链接</td><td width="15%">模块图片</td>
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
