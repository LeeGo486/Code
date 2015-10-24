<%@ page language="C#" autoeventwireup="true" inherits="Setup_ocxtest, App_Web_ocxtest.aspx.4cd3357d" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>消费测试</title>
    <style type="text/css">
        body
        {
        	 position:relative; 
        }
        #Text1
        {
            width: 220px;
        }
    </style>

<script src="../b28web/Utility/trans.js" type="text/javascript"></script>
    <script type="text/javascript">
	//消费
	function f_consume()
	{
	
	    var text = document.getElementById("Text1").value;
	    var text2 = document.getElementById("Text2").value;
	    var val = (parseFloat(text)*100);
	    var val2 = (parseFloat(text2));
	    var sums = padLeft(val,12)
	    var sn = padLeft(val2,12)
	    
	 	var ret = Trans1.OnTrans("PCA888888"+sums+sn);
	 	alert(getTransInfo(ret)+"\n卡号："+ret.substr(31,19)+"\n商户流水号："+ret.substr(98,6)+"\n批次号："+ret.substr(104,6));
	}
		
	//撤销
	function f_unconsume(){
	
	    var text = document.getElementById("Text1").value;
	    var text2 = document.getElementById("Text2").value;
	    var val = (parseFloat(text)*100);
	    var sums = padLeft(val,12)
	    var sn = padLeft(text2,12)
	    
	 	var ret = Trans1.OnTrans("PRA888888"+sums+sn);
	 	alert(getTransInfo(ret)+"\n卡号："+ret.substr(31,19)+"\n商户流水号："+ret.substr(98,6)+"\n批次号："+ret.substr(104,6));
	}	
    //改值
	function cg(t){
	    var a  = t.value;
	    if(a==parseFloat(a)){
	        t.value = Math.abs(Math.round(parseFloat(a)*100)/100)
	    }else{
	        t.value = "0.01";
	    }
	}
	
	
	
 </script>

</head>
<body>
<object id="Trans1" classid="CLSID:E2EEEA3B-34C4-43B7-B7AC-CB12DCA6FBBE" style="display:none;">
    <param name="_version" value="1.0" />
    <param name="_extentx" value="13229" />
    <param name="_extenty" value="13229" />
    <param name="_stockprops" value="0" />
</object>
    <form id="form1" runat="server">
    <div style="height: 217px; width: 463px; margin-bottom: 1px;position:absolute; top: 68px; left: 204px;">
<p>
    &nbsp;</p>
<p>
    消费/撤消金额：<input id="Text1" type="text" onchange="cg(this)" value="0.01" maxlength="13" onkeydown="if(event.keyCode==13)event.keyCode=9" /></p>
<p>
    流水号+批次号：<input id="Text2" type="text"  value="000000000000" maxlength="12" onkeydown="if(event.keyCode==13)event.keyCode=9" /></p>
<p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="消　费" name="button6"  onclick="f_consume();" style="width: 100px"/>

<input type="button" value="撤　消" name="button7" onclick="f_unconsume();" style="width: 100px"/>
    
<input type="button" value="签　到" name="button8" onclick="openTrans();" style="width: 100px"/>
    
    
    </div>
    </form>
</body>
</html>
