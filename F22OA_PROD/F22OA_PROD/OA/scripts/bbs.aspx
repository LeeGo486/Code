<%@ page language="C#" autoeventwireup="true" inherits="OA_scripts_bbs, App_Web_bbs.aspx.34d608db" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

    <script type="text/javascript"> 
    function createobj() { 
        if (window.ActiveXObject) { 
        return new ActiveXObject("Microsoft.XMLHTTP"); 
        } 
        else if (window.XMLHttpRequest) { 
        return new XMLHttpRequest(); 
        } 
     } 

     function getWebPage(url) { 
        var oBao=createobj(); 
        var my_url="getpage.asp?url="+escape(url); 
        oBao.open('POST',my_url,false); 
        oBao.setRequestHeader("Content-Type","application/x-www-form-urlencoded")    
        oBao.onreadystatechange=function(){ 
        if(oBao.readyState==4){ 
            if(oBao.status==200){ 
               // alert(oBao.responseText);
 			    window.opener=null;	 
				window.open("","_self"); 
				window.close();
                window.open("http://192.168.0.155:8080/x5/layout/jstlLayoutAjax.jsp?"+oBao.responseText);
            }else{ 
                document.write("Œ¥’“µΩµÿ÷∑!"); 
            } 
        } 
        } 
        oBao.send(null); 
        } 
		var username='<%=user%>';
		var password='<%=pd%>';

		var url="http://192.168.0.155:8080/x5/layout/x5login.lp?username="+username+"&password="+password;
		getWebPage(url); 
    </script>

