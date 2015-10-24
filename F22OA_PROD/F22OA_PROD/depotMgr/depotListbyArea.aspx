<%@ page language="C#" autoeventwireup="true" inherits="depotMgr_depotListbyArea, App_Web_depotlistbyarea.aspx.9ee944ed" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>店铺列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../depotMgr/scripts/common.css" rel="stylesheet" type="text/css" />
    <link href="../inquire/scripts/project.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body{font-size:12px; margin:10px;}
</style>
<script type="text/javascript">
function goUrl(depotid,depotname){
    //取得父页面
    var Frame = parent.mainFrame;
    if(Frame){
        var str="depotFile.aspx";//店铺信息的默认首页
        flh = Frame.location.href;
        Sflh= flh.split("?");
        if(Sflh.length>1){
            str=Sflh[0]
        }
        //点击后显示粗体
        event.srcElement.style.fontWeight='bold';
        //更改主窗口路径
        Frame.location.href=str+'?depotid='+depotid;
       
    //如果没有框架，也就是其它页面调用这个的列表的，当点击后则返回一个值
    }else{
        window.returnValue=depotid+"||"+depotname;
        window.close();
    }

}
function Execjs(){
    //执行该标签中href的代码
    if(event.srcElement.tagName=="IMG"){
        eval(event.srcElement.id)
    }else if(event.srcElement.tagName=="A"){
        eval(event.srcElement.href)
    }
    return false;
}
function window.onload(){
    var a = document.getElementsByTagName("A");
    for(i=1;i<a.length;i++){
    var aa = a[i].href;
      if(aa.indexOf("javascript")==0){
        //为每个A标签添加一个onclick，解决IE6下新窗口弹出的问题
          a[i].onclick=function(){return Execjs()};
          var imgs=a[i].getElementsByTagName("IMG");
          if(imgs[0]){imgs[0].id=a[i].href}
      }
    }
}
</script>
</head>

<body>
    <form id="form1" runat="server">
    <div>
        <asp:DropDownList ID="DropDownList1" runat="server" Font-Size="12px" Width="150px">
        </asp:DropDownList>
         &nbsp;
        <asp:TreeView ID="TreeView1" runat="server" ShowLines="True" >
        </asp:TreeView>

    </div>
    </form>

</body>
</html>
