 
/*******************************************************************************
 * 已登录校验
 */
function userCheck() {
    var flag = false;
    $.ajax({
        type: 'GET',
        async: false,
        url: GetLoginNameURL(),
        options: "JSON",
        success: function (data) {
            if (eval("[" + data + "]")[0].Error) {

            }
            else {
                var user = eval("[" + data + "]")[0].UserName;
                if (user && user != "") {
                    alert('请先退出已登录账户：' + user);
                    window.location.href = 'index.html';
                    flag = true;
                }

            }
        }
    });
    return flag;
}


/**
 * 登陆
 */
function login(loginurl) {  
    if (userCheck()) {
        return;
    }

    //进入页面，焦点在用户名文本框上
    $("#uname").focus();


	var psw = $('#psw').attr('value');
	var uname = $('#uname').attr('value');

	if (uname == "" || uname == null) {
	    $("#uname").focus();  
	    $("#login_msg").html("用户名不能为空!");
	    return;
	}
	if (psw == "" || psw == null) {
	    $("#psw").focus();
	    $("#login_msg").html("密码不能为空!");
	    return;
	}
     
     
	$("#login_msg").html("登录中，请稍后..."); 
	$.ajax({
	    async: false, 
	    type: 'POST',
	    dataType: "json",
	    url: GetLoginURL(), // 请求的action路径
	    data: {
	        "UserName": $("#uname").val(),
	        "Password": $("#psw").val()
	    },
	    error: function () {// 请求失败处理函数
	        $("#login_msg").html("登录失败！");
	        alert(GetErrorMsg('E0001'));
	    },
	    onSubmit: function () {
	    },
	    success: function (data) { // 请求成功后处理函数。 
	        //var data = eval('(' + data + ')');
	        //alert(jsonUtil_jsonToStr(data));
	        if (data != null && data.Result != null) {
	            $("#login_msg").html("登录成功！"); 
	            saveInfo(loginurl);  
	            window.location.href = 'index.html' 
	        } else if (data != null && data.Error != null) {//后台异常处理
	            $("#login_msg").html(data.Error);
	            $("#Password").focus();
	        }
	    }
	});
}

function loginService(url, uname, psw, comId, loginurl) {
	var result1;
	$.ajax({
		url : url,
		type : 'GET',
		async : false,
		data : 'uname=' + encodeURIComponent(uname) + '&psw=' + psw + '&comId='
				+ comId + '&loginurl=' + loginurl + '&s='
				+ new Date().getTime(),
		dateType : 'application/json;charset=UTF-8',
		contentType : 'application/json;charset=utf-8',
		success : function(result) {
			result1 = result;
			// alert(result1);
		},
		error : function() {
			$.messager.alert('提示', "error!");
		}
	});
	return result1;
}

/*******************************************************************************
 * 快捷登陆 回车键
 */
function enter(loginurl) {
	var event = arguments.callee.caller.arguments[0] || window.event;// 消除浏览器差异
	if (event.keyCode == 13) {
		login(loginurl);
	}
}


/** 
 * 设置cookie值
 */
saveInfo = function(loginurl) {
	try {
		var isSave = document.getElementById('chkRememberPwd').checked; // 保存按键是否选中
		if (isSave) {
			var usernm = document.getElementById('uname').value;
			var userpsw = document.getElementById('psw').value; 
			if (usernm != "" && userpsw != "") {
				SetCookie(usernm, userpsw, loginurl);
			}
		} else {
			SetCookie("", "", loginurl);
		}
	} catch (e) {

	}
};


function SetCookie(usern, psw, loginurl) {
	var Then = new Date();
	Then.setTime(Then.getTime() + 500*24*60*60*1000);
	Cookies.set("loginurl", loginurl, Then);
	Cookies.set("username",usern,Then);
	Cookies.set("password",psw,Then); 
	
}




function GetCookie() {
	var username = 	Cookies.get("username");
	var password = Cookies.get("password");  
	if(username!=''&&password!=''){
		document.getElementById('uname').value = username;
		document.getElementById('psw').value = password;
		//$('#comId').combotree('setValue', comId);
		if (username != "" && password != "") {
			document.getElementById("chkRememberPwd").checked = true;
		}
	}
	
}



