<html>
<head>
<style>
body{margin:0;background:url(../skin/<%=session("skindir")%>/image/index_15.gif) repeat-x; line-height:25px; height:25px; overflow:hidden; text-align:center; font-size:12px; width:170px;}
a{ color:black; text-decoration:none; display:block;}
a:hover{ color:black;}
</style>
<script>
function showsale(){
_t=window.parent.document.getElementById("LeftMainFrame")
	if(_t.rows=="*,25,80"){
	 _t.rows="*,25,260";
	}else if(_t.rows=="*,25,260"){
	 _t.rows="*,25,0";
	}else{
	 _t.rows="*,25,80";
	}
}
</script>
</head>
<body>
<a href="#" title="显示/隐藏" onClick="showsale()" onFocus="this.blur()">信息提示</a>
</body>
</html>
