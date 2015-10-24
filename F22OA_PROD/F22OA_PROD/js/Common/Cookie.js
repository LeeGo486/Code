
    //设定COOKIE，outTime = 1 为1天
    function setCookie(cookieName,cookieValue,outTime)
    {alert(cookieName);
        //编码以适合任何浏览器
         var str = cookieName + '=' + escape(cookieValue);
         if(outTime > 0)
         {
              var mm = outTime*3600*1000*24;
              var date =new Date();
              date.setTime(date.getTime()+mm);
              str += ';expires=' + date.toGMTString();
         }  
        
         document.cookie = str;
    }
    //删除COOIKIE
    function delCookie(cookieName)
    {
         var date = new Date();
         date.setTime(date.getTime()-10000);
         document.cookie=cookieName+'=0;expires='+unescape(date.toGMTString());
    }
    //得到COOKIE的值
    function getCookie(cookieName)
    { 
         var arrCookie=document.cookie.split(";");
         
         for(var i=0;i<arrCookie.length;i++)
         {    
              var arrName=arrCookie[i].split("=");   
                   
              if(arrName[0].trim()==cookieName.trim())
              {
                  return unescape(arrName[1]);
              }
          }
          return '';
     }
