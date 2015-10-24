<%@ control language="C#" autoeventwireup="true" inherits="Toolsdj, App_Web_toolsdj.ascx.3f410aa0" %>
<script language="javascript" type="text/javascript" src="<%= Request.ApplicationPath %>/js/select.js" ></script>
<script language="javascript" type="text/javascript">
// <!CDATA[

function bt_chk_onclick(obt) 
{
       var rq=select_date("1");
       if (rq!="")
       {
            cellsrv(obt,"chk|"+rq);
       }
}

function bt_sure_onclick(obt) 
{
       var rq=select_date("2");
       if (rq!="")
       {
            cellsrv(obt,"sure|"+rq);
       }
}

function bt_save_onclick(obt) 
{
  alert(this);
  var aa=obt.value;
  alert(aa);
  cellsrv(obt,"save");
}

function bt_unchk_onclick(obt) 
{
　     cellsrv(obt,"unchk");
}
function bt_unsure_onclick(obt) 
{
　     cellsrv(obt,"unsure");
}
function bt_del_onclick(obt) 
{
    if (window.confirm("真的要删除吗？"))
    {
　     cellsrv(obt,"del");
　  }
　      
}
function cellsrv(obt,lx)
{
	   var context=obt;
	   var oid=document.getElementById("Txt_id");
	   if (oid==null)
	   {
	      alert("请定义单据id为Txt_id");
	      return "";
	   }
	   var id=oid.value;
	   if (id=="")
	   {
	      alert("单据id不能为空！");
  	      return "";
	   }
	   else
	   {
	      setdisabled(true);
	      id=lx+"|"+id
   　     <%=sCallBackToolsdjInvocation%> 
	   }
}
//0表示成功
function handleResultToolsServer(result, context)
{
  alert(result);
  var r=result.split("|");
  switch (r)
  {
     case "del":
        if (r[0]=="0")
        {
          alert(r[1]);
        }
        else
        {
          alert(r[1]);
        }
        window.close();
        break; 
     case "chk":
        alert(r[1]);
        break;   
  }

 }
 function setdisabled(v)
 {
    var obt=document.getElementById("Toolsdj1_bt_del");
    obt.disabled=v;

 }
// ]]>
</script>

<input id="bt_del" type="button" value=" 删除 " runat="server"  onclick="return bt_del_onclick(this)"/>
<input id="bt_save" type="button" value=" 保存 " runat="server"  onclick="return bt_save_onclick(this)" />
<input id="bt_chk" type="button" value=" 审核 " runat="server"  onclick="return bt_chk_onclick(this)" />
<input id="bt_sure" type="button" value=" 登帐 " runat="server"  onclick="return bt_sure_onclick(this)"/>
<input id="bt_unchk" type="button" value="反审核" runat="server"  onclick="return bt_unchk_onclick(this)"/>
<input id="bt_unsure" type="button" value="反登帐" runat="server"  onclick="return bt_unsure_onclick(this)"/>
<input id="bt_prn" type="button" value=" 打印 " runat="server"  onclick="return bt_prn_onclick(this)"/>
<input id="bt_close" type="button" value=" 退出 " runat="server"  onclick="return bt_close_onclick(this)"/>&nbsp;<br />
