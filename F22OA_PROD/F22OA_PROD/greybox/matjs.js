

// open打开明细 会话超时
      
function showDlg(src){
 if (document.getElementById("imb_Background")==null){
     var v=document.createElement('iframe');
     v.id='imb_Background';
     v.style.backgroundColor='#000000';
     v.style.top='0px';
     v.style.left='0px';
     v.style.width='100%';
     v.style.height=document.body.scrollHeight; var vh1=document.body.scrollHeight-60;
     v.style.position='absolute';
     v.style.filter = "alpha(opacity="+65+");";  
     v.src='../greybox/HTMLPage.htm';
     document.lastChild.lastChild.appendChild(v);
 }
 if (document.getElementById("dv1")==null){
     var vc=document.createElement('div');
     vc.id='dv1';
     vc.innerHTML="<div id='pcls' style='width:98%;text-align:right;position:absolute;left:10;top:10;margin:0px;padding:0px;' ><img src='../greybox/g_close.gif' /></div><iframe id=\"imb_FormModal\" src=\""+src+"\" style=\"position:absolute;left:10;top:40;width:98%;height:"+vh1+"px;margin:0px;padding:0px;\" frameborder=\"0\"></iframe>";
     document.lastChild.lastChild.appendChild(vc);
     
           var vp=document.getElementById('pcls');
            vp.onclick=function(){
                     var v1=document.getElementById('dv1');
                     var v2=document.getElementById('imb_Background');
                     document.body.removeChild(v1);
                     document.body.removeChild(v2);
                     }
  }
}