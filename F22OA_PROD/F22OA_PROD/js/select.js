// JScript 文件

function select_date(lx) 
{
  var url="/usercontrol/pop_selectrq.aspx?chktype="+lx;
  var rq=showaspx(url,320,400);
  return rq;
}
//load 模式窗口
function LoadWindow(url,w,h)
{

  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+150;
  var rtw=window.showModalDialog(url,self,"edge:sunken;scroll:2;status:0;help:0;resizable:1;dialogWidth:"+w+"px;dialogHeight:"+h+"px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
  return rtw;
}
//弹出模式窗口，送入的url从站点开始的完整路径
function showaspx(url,w,h)
{
  url=getroot()+url;
  var rtw=window.showModalDialog(url,self,"edge:sunken;scroll:2;status:0;help:0;resizable:1;center:yes;dialogWidth:"+w+"px;dialogHeight:"+h+"px;");
  return rtw;
}
//得到站点名称
function getroot() 
{
  
  var path=location.pathname.split("/");

  var root=path[1];
  if (path[0]!="")
  {
     root=path[0];
   }
  if (root!="")
  {
    root="/"+root;
  }
  return root;
}
