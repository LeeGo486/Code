 
function getMenuJson() {  
    $.ajax({
        url: GetTreeWSRRURL(peoa_GetWSRRURL(8)) + "&MenuCodeContains=0&s=" + new Date().getTime(),
        options: "JSON",
        async: false,
        success: function (data) {  
            if (data != undefined && data == '[]') {
                alert("没有菜单权限,请联系管理员!");
                logout();
                return false;
            }

            data = eval("(" + data + ")");
            if (data[0].Error) {
                $.messager.alert("出错了", data[0].Error, 'error');
                return;
            }
            
            var menujson = data;
            var len = menujson.length;
            if (len == 0) {
                return '';
            }
            menuhtml = '<div id="sidebar"><ul>';
            for (var i = 0; i < len; i++) {
                subMenuJson(menujson[i]);
            }
            menuhtml = menuhtml + '</ul></div>';
            return menuhtml;  
        }

    });   
}


function subMenuJson(submenu) { 
    //alert(submenu.menu_Name+':'+submenu.subMenuList.length);
    if (submenu.children && submenu.children.length > 0) {//模块
        menuhtml = menuhtml + '<li class="submenu">  <a href="#"><i class="icon1-th-list"></i><span>'; 
        menuhtml = menuhtml + '<font color="white">' + submenu.text + '</font></span></a> ';
        menuhtml = menuhtml + '<ul>';
        for (var i = 0; i < submenu.children.length; i++) {
            subMenuJson(submenu.children[i]);
        }
        menuhtml = menuhtml + '</ul>';
        menuhtml = menuhtml + '</li>';
    } else {//菜单
        menuhtml = menuhtml + '<li  id="item_' + submenu.id + '" ><a ';
        menuhtml = menuhtml + ' onclick="gaibian(\'item_' + submenu.id + '\');addTab(\'' + submenu.text + '\',\'' + submenu.attributes.ActionURL + '\')">';
        if (submenu.attributes.Leaver == 3) {
            menuhtml = menuhtml + '&nbsp;&nbsp;&nbsp;&nbsp;';
        }
        if (submenu.id == '206') { //if (submenu.menu_Name == '我的任务') {
            menuhtml = menuhtml + '<i class="icon1-tasks"></i><span>';
            menuhtml = menuhtml + '<font color="white">' + submenu.text + '</font></span>';
        } else {
            menuhtml = menuhtml + '<i class="icon1-tag"></i><span>';
            menuhtml = menuhtml + '<font color="white">' + submenu.text + '</font></span>';
        }
       menuhtml = menuhtml + '</a>';
        menuhtml = menuhtml + '</li>';
    }
}

function subMenuJson1(submenu){
	//alert(submenu.menu_Name+':'+submenu.subMenuList.length);
	if(submenu.subMenuList.length>0){//模块
		menuhtml = menuhtml + '<li class="submenu">  <a href="#"><i class="icon icon-th-list"></i>';
		menuhtml = menuhtml + '<span><font color="white">'+submenu.menu_Name+'</font></span></a> ';
		menuhtml = menuhtml + '<ul>';
		for(var i = 0; i < submenu.subMenuList.length; i++){
			subMenuJson(submenu.subMenuList[i]);
	    }
		menuhtml = menuhtml + '</ul>';
		menuhtml = menuhtml + '</li>';
	}else{//菜单
		menuhtml = menuhtml + '<li id="item_'+submenu.menu_Code+'" ><a ';
		menuhtml = menuhtml + ' onclick="gaibian(\'item_'+submenu.menu_Code+'\');addTab(\''+submenu.menu_Name+'\',\''+submenu.actionURL+'\')">';
		if(submenu.menu_Name=='我的任务'){
			menuhtml = menuhtml + '<i class="icon icon-tasks"></i>';
		}else{
			menuhtml = menuhtml + '<i class="icon icon-tag"></i>';
		}
		menuhtml = menuhtml + '<span><font color="white">'+submenu.menu_Name+'</font></span>';
		menuhtml = menuhtml + '</a>';
		menuhtml = menuhtml + '</li>';
	}
}


function gaibian(divid)
{
      liarray   =   document.getElementsByTagName("li");//get all
      var tmppp=0;
      var fuhe = new Array();
      for(var i=0;i<liarray.length;i++)    
      {    
	      var zheci =liarray[i].id;
	      var zhao = 'item_';//
	      if((zheci).indexOf(zhao)==0)//if is real all
	        {
	            fuhe[tmppp]=zheci;
	            tmppp+=1;
	        }
      }   
        for(var i in fuhe){//clear all
         var div1=document.getElementById(fuhe[i]);
            if(div1){
            	div1.style.backgroundColor=$("#header").css('backgroundColor');
            	/*div1.style.backgroundColor="#008000";*/
            }
         }
         //change now click
      var div=document.getElementById(divid);
      div.style.backgroundColor = "#28b779";
      div.style.fontWeight = "600";
      /*div.style.backgroundColor="#008000";*/
     // div.firstChild.style.color="yellow";
}



//退出
function logout() {
    $.ajax({
        async: true,
        cache: false,
        type: 'POST',
        dataType: "json",
        url: GetWSRRURL(peoa_GetWSRRURL(7)), // 请求的action路径
        error: function () {// 请求失败处理函数
            //alert(GetErrorMsg('E0001'));
            window.location = "login.html";
        },
        onSubmit: function () {

        },
        success: function (data) { // 请求成功后处理函数。  
            if (data.Result != null) {
                //$("#login_msg").html("登录成功");
                window.location = "login.html";
            } else if (data.Error != null) {//后台异常处理
                //alert(data.Error);
                window.location = "login.html";
            }
        }
    });
}