function checkuserid()
{
   if (document.all.TO_ID.value=="")
   { alert("请添加收件人！");
     return (false);
   }
}

function CheckForm()
{
   if (document.all.TO_ID.value=="")
   { alert("请添加收件人！");
     return (false);
   }
     if (document.all.tbmsg.value=="")
   { alert("请填写消息！");
     document.all.tbmsg.focus();
     return (false);
   }
   return (true);
  }
//清除用户
function clear_user()
{
  document.all.TO_NAME.value="";
  document.all.TO_ID.value="";
}

//选择用户
/*function LoadWindow(url)
{
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+170;
  window.showModalDialog(url,self,"edge:raised;scroll:2;status:0;help:0;resizable:1;dialogWidth:350px;dialogHeight:280px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
}

*/
    function SelectAll (chkVal, idVal) { 

       var thisfrm = document.forms[0];

           // 查找Forms里面所有的元素

           for (i=0; i<thisfrm.length; i++) {

              // 查找模板头中的CheckBox

              if (idVal.indexOf ('chkAll') != -1) {

                  if(chkVal == true) {

                     thisfrm.elements[i].checked = true;

                  } 

                  else {

                      thisfrm.elements[i].checked = false;

                  }

               } // if

               // 如果除题头以外的项没有全选上则取消题头的选择

              else if (idVal.indexOf ('chkDelete') != -1) {

                  if(thisfrm.elements[i].checked == false) {

                     thisfrm.elements[1].checked = false; 

                  }

               }

           } // for

        }
//==============================================================================
 function SelectAll1 (chkVal, idVal) { 

       var thisfrm = document.forms[0];

           // 查找Forms里面所有的元素

           for (i=0; i<thisfrm.length; i++) {

              // 查找模板头中的CheckBox

              if (idVal.indexOf ('chkAll1') != -1) {

                  if(chkVal == true) {

                     thisfrm.elements[i].checked = true;

                  } 

                  else {

                      thisfrm.elements[i].checked = false;

                  }

               } // if

               // 如果除题头以外的项没有全选上则取消题头的选择

              else if (idVal.indexOf ('chkDelete') != -1) {

                  if(thisfrm.elements[i].checked == false) {

                     thisfrm.elements[1].checked = false; 

                  }

               }

           } // for

        }
        
        