<%@ page language="C#" autoeventwireup="true" inherits="b28web_Retail_small, App_Web_small.aspx.832efc68" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>B28WEB收银</title>
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/small.css" rel="stylesheet" type="text/css" />
    <link href="../Utility/dateChooser.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript"  src="../Utility/jquery-1.2.6.min.js"></script> <!--jQuery -->
    <script src="../Utility/command.js" type="text/javascript"></script><!--通用 -->
    <script src="../Utility/trans.js" type="text/javascript"></script><!--刷卡 -->
    <script type="text/javascript" src="../Utility/dateChooser.js"></script>
    <script type="text/javascript" src="../../js/sound.js"></script>
    <style type="text/css"> #sub_template{display:none;}body,html{ margin:0;padding:0;overflow:hidden;}</style>
    <script type="text/javascript">
    
    function KeyDown(){
	    with (event){ 
		    if(keyCode==27){
		        if($("#retail_thType").val()=="0"){
	                $("#key").val('').focus();
		        }else{
	                $("#f2").focus();
		        }
		        return nokey();
		    }
		    else if (keyCode>111&&keyCode<=123)
		    {
		        if(!($("#f"+(keyCode-111)+"").attr('disabled'))){
			        $("#f"+(keyCode-111)+"").click();
		        }
		        return nokey();
            }
            
	    }
    }

    $(function() {
        $("#gridTab").prepend('<div id="loading" style=" position:absolute; top:200px; left:0;"><img src="../Images/loading.gif" alt="" align="absmiddle" /> 请稍等..</div>');

        var dd = new Date();    //local datetime
        var sd = $("#LocalDateTime").val();    //host datetime
        var cc = dd.getFullYear() + "-" + (dd.getMonth() + 1) + "-" + dd.getDate();
        if (sd != cc) location.href("../relogin.aspx?datetime=" + encodeURI(dd.toLocaleDateString()));
        ajax_disbtn(0);
        ajax_read(1);
        ajax_retail();
        //签到
        $("#opentrans").click(openTrans);
        //查询银行卡余额
        $("#querycard").click(f_query);

        //关必VIP图片显示
        $("#closevipimg").click(closevippic);

        $("#showvipimg").click(showvippic);


        //刷VIP卡
        $("#f1").click(function() {
            var m = openModal('../Modal/input_bankcard.aspx', 400, 250)
            if (m) {
                //去掉前后的特殊符号
                m = m.replace(';', '').replace('?', '');

                //负值并触发事件
                $("#vipcard").val(m).change();
            }
            $("#key").focus();
        });
        //收银
        $("#f2").click(function() {

            if ($("#retail_thType").val() == "0") {
                ajax_checkout(0, 0, true, true);     //执行收银判断 
            } else {
                ajax_checkout(0, 0, true, false);    //退货状态，不计算促销与VIP
                //退货状态，不计算促销与VIP
            }
            $("#key").focus();
        });
        //挂单
        $("#f3").click(function() {
            if ((openModal('../Modal/retail_save.aspx', 360, 150) == 1)) { ajax_retail(); ajax_read(1); }
            closevippic();
            $("#key").focus();
        });
        //取单
        $("#f4").click(function() {
            if ((openModal('../Modal/retail_get.aspx', 360, 200) == 1)) { ajax_retail(); ajax_read(1); }
            $("#key").focus();
        });
        //赠送
        $("#f5").click(function() {
            $("#key").focus();
            $("#hd_back").val(0);
            if ($("#hd_zs").val() == 1) {
                $("#key").css("background", '#FFF');
                $("#hd_zs").val(0);
            } else {
                $("#key").css("background", '#BFCAE6');
                $("#hd_zs").val(1);
            }
        });
        //整单打折
        $("#f6").click(function() {
            if ((openModal('../Modal/input_discount.aspx', 360, 120) == 1)) { ajax_read(1); }
            $("#key").focus();
        });
        //整单作废 
        $("#f7").click(function() {
            if (confirm('确认作废此单吗？')) {
                ajax_clear(true);
            }
            $("#key").focus();
        });

        //输入VIP卡
        $("#f8").click(function() {
            
            var url='../Modal/input_vipcard.aspx';
            var pos_vipshow='<%=pos_vipshow%>';
         
            if (pos_vipshow.toLowerCase()=="true"){
                url='../Modal/input_vipcardjm.aspx';
            }
          
            var m = openModal(url, 800, 350);
            if (m != undefined) {
                var ary = m.split("_");
                isChage = ary[1];
                $("#hid_vipcut").val("t");
                $("#vipcard").val(ary[0]).change();
                //$("#vipcard").val(m).change()
            }
            $("#key").focus();
        });
        //退货
        $("#f9").click(function() {
            $("#key").focus();
            $("#hd_zs").val(0);
            if ($("#hd_back").val() == 2) {
                $("#hd_back").val(0);
                $("#key").css("background", '#FFF');
            } else {
                $("#hd_back").val(2);
                $("#key").css("background", '#feb0d0');
            }
        });
        //手工输入 
        $("#f10").click(function() {
            if (openModal('../Modal/input_clothing.aspx?zs=' + $("#hd_zs").val() + '&back=' + $("#hd_back").val(), 500, 450) == 1) {
                ajax_read(1);
                $("#hd_zs").val(0);
                $("#hd_back").val(0);
                $("#key").css("background", '#FFF');
            }
            $("#key").focus();

        });
        //整单退货
        $("#f11").click(function() {
            var m = openModal('../Modal/retail_back.aspx', 360, 160);
            if (m == 1) {
                ajax_retail();
                ajax_read(1);
            }

            if ($("#retail_thType").val() == "0") {
                $("#key").focus();
            } else {
                $("#f2").focus();
            }

        });
        //查看VIP消费记录
        $("#f12").click(function() {
            if ($("#vipcard").val() != "") {
                openModal('../Modal/Vipinfo.aspx', 990, 450);
                $("#key").focus();
            } else {
                $("#vipcard").focus();
            }
        });

        //
        $("#key,#vipcard,#x_name,#shopcard,#comment,#daystat").keydown(function() {
            if (event.keyCode < 111 || event.keyCode > 123) {
                $('#f2').attr('disabled', 'disabled');
            }
            if (event.keyCode == 13 || event.keyCode == 10) {
                $(this).change();
                return false;
            }
            else if (event.keyCode == 38 || event.keyCode == 40) {
                return false;    //解决内嵌浏览器上下键的问题
            }
        });

        //
        $("#key,#vipcard,#x_name,#shopcard,#comment,#daystat").blur(function() {
            if ($('#sub_body').find('tr').length > 0) $('#f2').removeAttr('disabled');


            return false;
        })
        //添加款
        $("#key").change(function() {
            var cl = $('#clothing_len').val();
            var id = $(this).val();
            var html = ajax_rText("addClothing.aspx", "clothingid=" + id.substring(0, (id.length - cl)) + "&zs=" + $("#hd_zs").val() + "&back=" + $("#hd_back").val() + "&nums=1")

            if (html) {
                alert(html);
            } else {
                PlayScanSound();
                $("#hd_zs").val(0);
                $("#hd_back").val(0);
                ajax_read(1);
            }
            $(this).val('')
                    .focus()
                    .css("background", "#FFF");
        });
        //改日期
        $("#setdate").change(function() {
            var html = ajax_rText("updRetail.aspx", "act=setdate&setdate=" + $(this).val())
            ajax_rFocus(html, $(this))
        });
        //改班次
        $("#x_name").change(function() {
            var html = ajax_rText("updRetail.aspx", "act=x_name&x_name=" + $(this).val())
            ajax_rFocus(html, $(this))
        });
        //使用商场卡
        $("#shopcard").change(function() {
            var html = ajax_rText("updRetail.aspx", "act=shopcard&shopcard=" + $(this).val())
            ajax_rFocus(html, $(this));
            ajax_read(1);
        });
        //改整单备注
        $("#comment").change(function() {
            var html = ajax_rText("updRetail.aspx", "act=comment&comment=" + $(this).val())
            ajax_rFocus(html, $(this))
        });
        //改天气
        $("#daystat").change(function() {
            var html = ajax_rText("updRetail.aspx", "act=daystat&daystat=" + $(this).val())
            ajax_rFocus(html, $(this))
        });

        //改VIP卡
        $("#vipcard").change(function() {
            var m = $(this).val();
            if ($("#vipcut").val() == "1") {
                m = m.substr(eval($("#vipbeg").val()) - 1, $("#vipcnt").val());
            }
            if ($("#hid_vipcut").val() == "t") {
                m = $("#vipcard").val();
                $("#hid_vipcut").val(undefined);
            }
            var html = ajax_rText("updRetail.aspx", "act=vip&vipcode=" + m + "&isUpdate=false");
            ajax_rFocus(html, $(this));

        });
        //按键
        document.onkeydown = KeyDown;
    });
    
    //焦点
    function ajax_rFocus(html,_this)
    {
        var b = false;
        if(html.substr(0,1)=="$") {
           eval(html);
           if(html.indexOf('alert')>0)
            b = true;
           else
            b = false;
        }else if(html.length>0) {
            alert(html);
            b = true;
        }else {
            b = false;
        }
        
        //焦点
        if(b){
            $(_this).val('');
            $(_this).focus();
        }else{
            if($("#retail_thType").val()=="0")
            {
                $("#key").focus();
            }else{
                $("#f2").focus();
            }
        }
    }
    
    //取得更新结果
    function ajax_rText(url,data)
    {
        var html = $.ajax({
        url: "../ajax/"+url,
        type: "POST",
        data: data,
        async: false
        }).responseText;
        return html;
    }
    
    //清除界面
    function ajax_clear(f)
    {
        if(f) ajax_post(this,"updRetail.aspx","act=clear",false,false);
        $("#sub_body").empty();
        $("#vipcard").val('');
        $("#vipname").text('-');
        $("#centum").text('0');
        $("#comment").val('');
        $("#retail_thType").val(0);
        $("#key").css("background","#FFF");
        $("#hd_zs").val(0);
        $("#hd_back").val(0);
        ajax_totalsum(true);
        closevippic();
    }
    
    //提交销售单
    function ajax_checkout(runid, vipRunType, callback, cx)
    {
        //alert($("#hd_back").val());
        var path="../AJAX/CHECKOUT.ASPX?"+(new Date());
        var data = "runid="+runid+"&vipRunType="+vipRunType+"&callback="+callback+"&cx="+cx;
       // alert($("#chb_date").attr("checked"));
        //if($("#chb_date").attr("checked")){
            //data=data+"&sdate="+$("#setdate").val();
            //path=path+"&sdate="+$("#setdate").val();
         //  alert(path);
       // }
         $.ajax({
            url:path,
            beforeSend:function(){$("#loading").show()},
           complete :function(){
                        $("#loading").hide();
                        //$("#chb_date").attr("checked",false);
                        //checkBoxEven("#chb_date");
                        $("#key").focus();},
           type:"POST",
           dataType:"script",
           data:data,
           error:function(o,msg){
                 alert("数据提交时发生错误！\n\n参考数据：\n"+data);
           }
        });
    }
    
    //移动光标改款
    function jmove(e,t)
    {
    var k;

    if(window.event){
        k = e.keyCode;
    }else if(e.which){
        k = e.which;
    }
    if(k>=37 && k<=40)
      {
      var input = $("#sub_body").find("INPUT[type='text']");
      var m = 0;
          for(i=0;i<input.length;i++)
          {
            if(input[i]==t){
               m = i;
               break;
            }
          }
        if(k==37){
            m = m - 1;
        }else if(k==38){
            m = m - 4;
        }else if(k==39){
            m = m + 1;
        }else if(k==40){
            m = m + 4;
        }
        if(m>=0&&m<input.length){
            input[m].focus();
        }
        return false;
      }
      else if(k==13||k==27)
      {
        $(t).change();
        $("#key").focus();
        return false
      }
    }

    //删除款
    function ajax_del(id)
    {
        var html = ajax_rText("delClothing.aspx","id="+id);
        if(html){
            alert(html);
        }else{
            var tbl=event.srcElement.parentNode.parentElement.parentElement;
            event.cancelBubble=true;
            with (event.srcElement.parentNode.parentElement) {
	            if (tagName.toLowerCase()=="tr") tbl.deleteRow(rowIndex-2);
            }
        }
        ajax_totalsum(true);
    }
    //更改款信息
    function ajax_upd(id,act,_this,data)
    {
        if(_this.value.length > 0 || act=='comment')
        {
        
            ajax_post(this,"updClothing.aspx","id=" + id + "&act=" + act + "&" + act + "=" + _this.value + data, false,false);

            if(act=='discount'){
                $(_this).val(Math.round($(_this).val() * 1000000) / 1000000);
                ajax_calc();
            }
            if(act=='nums') 
            {
                $(_this).val(parseInt($(_this).val()));
                ajax_calc();
            }
            if(act=='s_price')
            {
                $(_this).val(ajax_round(Math.round($(_this).val() * 100)/100));
                ajax_calc();
            }
        }
        else
        {
            ajax_read(1);
        }
    }
    
    //提交处理
    function ajax_post(obj,url,data,upd,upd2){
       $.ajax({url:"../AJAX/" + url,
       type:"post",
       dataType:"html",
       data:data,   //post过去的参数
       async:false,
       error:function (msg){
          alert("数据加载错误!");
       },
       success: function(msg){
          if(msg) {
            alert(msg);//发生错误，重新加载
            $(obj).focus()
            return false;
          }
            if(upd) {ajax_read(1);}
            if(upd2) {ajax_retail();}
           }
       });
    }
        
    //取零售列表
    function ajax_read(data){
       $.ajax({url:"../AJAX/readClothing.aspx",
       beforeSend:function(){},//$("#loading").show();
       complete :function(){ $("#loading").hide();ajax_totalsum(true);},
       type:"post",
       dataType:"json",
       data:"cx="+data,
       async:false,
       error:function(msg) {
           $("#sub_body").empty();
       },
       success: function(msg) {
           var json = msg["Head"];
           $("#sub_body").empty();
           $("#Button1").enabled=false;
           $.each(json,function(i,o){
            var row=$("#sub_template").clone();
                //负值
                row.find("#sstyleid").html('<a href="#" onclick="return false" title="查看《'+o.s_name+'》详细">'+o.styleid+'</a>');
                row.find("#scolorid").text(o.colorid+o.c_name);
                row.find("#sname").text(o.s_name);
                row.find("#ssizeid").text(o.sizeid);
                row.find("#sub_nums").val(o.nums);
                if($("#retail_yj").val()=="1")row.find("#sj_price").text(Math.round(o.j_price*100)/100);
                row.find("#sx_price").text(Math.round(o.x_price*100)/100);
                row.find("#sub_discount").val(Math.round(o.discount*1000000)/1000000);
                row.find("#sub_s_price").val(Math.round(o.s_price*100)/100);
                row.find("#sx_sums").text(Math.round(o.xsums*100)/100);
                row.find("#ssums").text(Math.round(o.sums*100)/100);
                row.find("#sub_comment").val(o.comment);
                
                if (o.comment=="退货.")
                {
                  row.find("#sub_comment").attr('readonly','readonly');
                }
                
                row.find("#sub_zskc").text(o.kc);
                row.find("#skc").html('<a href="#" onclick="return false" title="其它店铺库存">查看</a>');
                
               if($("#retail_thType").val()=="0"){
               
                    //事件
                    row.find("#sub_del").click(function(){ajax_del(o.id)});
                    
                    //查款详细
                    row.find("#sstyleid a").click(function(){openModal('../../pos/pos/f22/clothing.asp?id='+o.clothingid,600,370)});
                    //查其它库存
                    row.find("#skc a").click(function(){openModal('../../pos/pos/f22/pos_dpkc.asp?id='+o.clothingid,600,370)});

                    row.find("#sub_nums").change(function(){ajax_upd(o.id,'nums',this,'')})
                                    .focus(function(){this.select()})
                                    .keydown(function(){return jmove(event,this)});
                                    
                    if($("#retail_jsj").val()=="1"){
                        row.find("#sub_s_price").change(function(){ajax_upd(o.id,'s_price',this,'&x_price='+o.x_price+'&olddiscount='+o.olddiscount)})
                                .focus(function(){this.select()})
                                .keydown(function(){return jmove(event,this)});
                    }else{
                        if (row.find("#sub_comment").val()!="赠品")
		                        {
                            row.find("#sub_s_price").attr('readonly','readonly');
                        }
                        else
                        {
                            row.find("#sub_s_price").change(function(){ajax_upd(o.id,'s_price',this,'&x_price='+o.x_price+'&olddiscount='+o.olddiscount)})
                                .focus(function(){this.select()})
                                .keydown(function(){return jmove(event,this)});
                        }
                    }

                    if($("#retail_zk").val()=="1"){

                       row.find("#sub_discount").change(function(){ajax_upd(o.id,'discount',this,'&olddiscount='+o.olddiscount)})
                                                .focus(function(){this.select()})
                                                .keydown(function(){return jmove(event,this)});

                    }else{
                       row.find("#sub_discount").attr('readonly','readonly');
                    }
                    
                    row.find("#sub_comment").change(function(){ajax_upd(o.id,'comment',this,'')})
                                            .focus(function(){this.select()})
                                            .keydown(function(){return jmove(event,this)});

               }else{
                    row.find("#sub_del").hide();
                    row.find("#sub_nums,#sub_discount,#sub_s_price,#sub_comment").attr('readonly','readonly');
               }

                //颜色
                if(o.back=='True'){row.addClass('row_back');}
                if(o.zs=='True'){row.addClass('row_zs');}
                //显示
                row.appendTo("#sub_body");
                row.show();
               
           });
       }});
  
       if ($("#isvip").val()==1){
         $("#divvippic").show();
       }
       else{
         $("#divvippic").hide();
       }
     
    }

    //取主表信息
    function ajax_retail(){
       $.ajax({url:"../AJAX/readRetail.aspx",
       type:"post",
       dataType:"json",
       data:'',
       async:false,
       success: function(msg) {
           var json = msg["Head"];
           $.each(json,function(i,o){
                $("#x_name").val(o.x_name);
                $("#shopcard").val(o.shopcard);
                $("#setdate.calendarSelectDate").val(strToDate(o.setdate));
                $("#vipcard").val(o.vipcode);
                $("#daystat").val(o.daystat);
                $("#comment").val(o.comment);
                $("#retail_thType").val(o.back);
                $("#vipname").text(o.vipname);
                $("#centum").text(o.centum);
           });
       }});
    }
    //JS日期格式化
    function strToDate(str)
    {
      
     
        var data = new Date(str);
        
    
        format = "yyyy-MM-dd";
        var o = 
        {
            "M+" : data.getMonth()+1, //month
            "d+" : data.getDate(),    //day
            "h+" : data.getHours(),   //hour
            "m+" : data.getMinutes(), //minute
            "s+" : data.getSeconds(), //second
            "q+" : Math.floor((data.getMonth()+3)/3), //quarter
            "S" : data.getMilliseconds() //millisecond
        }
        
        if(/(y+)/.test(format)) 
        format=format.replace(RegExp.$1,(data.getFullYear()+"").substr(4 - RegExp.$1.length));
        for(var k in o)
        if(new RegExp("("+ k +")").test(format))
        format = format.replace(RegExp.$1,RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
        return format;
    }

    
    //改结算价等
    function ajax_calc(){
        var e = event.srcElement;  //对象事件源
        var row = e.parentNode.parentNode;

        var tds=row.all.tags("td");
        var txts = row.all.tags("input");

        var sl =$(txts[0]).val();  //数量
        var zk = $(txts[1]).val();  //折扣
        var jsj = $(txts[2]).val(); //结算价

        //结算价 
        if(e.id=="sub_s_price"){  
          if ($(tds[6]).text()!=0){
             $(txts[1]).val(Math.round(($(txts[2]).val()/$(tds[6]).text())*1000000)/1000000);
          }
        }
        //折扣
        if(e.id=="sub_discount"){
        $(txts[2]).val(ajax_round(Math.round($(tds[6]).text() * zk * 100)/100));
        }

        //结算金额
        $(tds[9]).text(Math.round($(tds[6]).text() * sl * 100)/100);
        $(tds[10]).text(Math.round($(txts[2]).val() * sl * 100)/100);

        ajax_totalsum(false);
    }

    function ajax_round(val){
        //四舍五入方式
        var rt = $("#round_type").val();
        var rb = $("#round_bit").val();
        /*四舍五入位数*/
        if(rt==0 && rb==0)
        {
            return Math.round(val * 1)/1;
        }
        else if(rt==0 && rb==1)
        {
            return Math.round(val * 10)/10;
        }
        else if(rt==1)
        {
        /*只入不舍*/
            return Math.ceil(val);
        }
        else if(rt==3)
        {
        /*只舍不入*/
            return Math.floor(val);
        }
        else
        {
            return val;
        }
    }

    //是否关掉没用的按钮
    function ajax_disbtn(x){
        if(x>0){
            $("#f2").removeAttr('disabled')
        }else{
            $("#f2").attr('disabled','disabled');
        }

        if($("#retail_thType").val()!="0"){
           $("#key").attr('readonly','readonly');
           $("#clothing_len").attr('readonly','readonly');
           $("#vipcard").attr('readonly','readonly');
           $("#f3").attr('disabled','disabled');
           $("#f4").attr('disabled','disabled');
           $("#f5").attr('disabled','disabled');
           $("#f6").attr('disabled','disabled');
           $("#f9").attr('disabled','disabled');
           $("#f8").attr('disabled','disabled');
           $("#f10").attr('disabled','disabled');
           $("#f11").attr('disabled','disabled');
        }else{
           $("#key").removeAttr('readonly');
           $("#clothing_len").removeAttr('readonly');
           $("#vipcard").removeAttr('readonly');
           $("#f8").removeAttr('disabled');
           $("#f10").removeAttr('disabled');
           $("#f11").attr('disabled','disabled');
            if(x>0){
               $("#f3").removeAttr('disabled');
               $("#f4").attr('disabled','disabled');
               if($("#retail_dz").val()=="1") $("#f6").removeAttr('disabled') ;
               $("#f11").attr('disabled','disabled');
            }else{
               $("#f3").attr('disabled','disabled');
               $("#f4").removeAttr('disabled');
               $("#f6").attr('disabled','disabled');
               if($("#retail_thh").val()=="1") $("#f11").removeAttr('disabled');
            }
            //赠送
            if($("#retail_zs").val()=="0"){
                $("#f5").attr('disabled','disabled');
            }else{
               $("#f5").removeAttr('disabled');
            }
            //退货
            if($("#retail_back").val()=="0"){
                $("#f9").attr('disabled','disabled');
            }else{
               $("#f9").removeAttr('disabled');
            }
        }
        
    }

    //统计
    function ajax_totalsum(f)
    {

        var nums=0;
        var xsums=0;
        var sums=0;
        var x = 0;
        $("#sub_body").find("tr").each(function(i, n)
        {
            x+=1;
            var tds=$(n).find("td");
            var txts=$(n).find("input");
            nums += parseInt(txts[0].value);  //数量
            xsums += (Math.round($(tds[9]).text() * 100)/100);//结算价       
            sums +=(Math.round($(tds[10]).text() * 100)/100); //结算价
        });
				
        $('#ct_style').text(x);
        $('#ct_nums').text(nums);
        $('#ct_xsums').text((Math.round(xsums * 100)/100));
        $('#ct_sums').text((Math.round(sums * 100)/100));
        
        ajax_disbtn(x);
        
       if(f) $("#key").focus();
    }

  function f_query(){
   try{
	 	var ret = Trans1.OnTrans("QUE000000");
	    //处理返回值
		if(ret.length>=6)
		{
			if(ret.substring(0,6)=="000000")
			{   
				 //查询成功
			alert('查询余额成功');
			}
			else
			{   
			    //失败信息提示
			    alert(getTransInfo(ret));
			}
		}
		else if(ret.length==0)
		{
			//工行没有返回数据
			alert('银行没有返回数据');
		}
		else
		{
		    alert('银行返回信息出错，返回数据为：“' + ret + '”');//工行返回其它信息
		}
	  }
	catch(e){alert("未安装工行刷卡控件!");}
	}
	
	
	function   showvippic(){   
	  if ($("#showvip").val()==1){
	    var y=document.getElementById("f12");
	    $("#divvippic").css({left:getDimX(y)+98});
        $("#divvippic").css({top:getDimY(y)-155});  
        $("#divvippic").show();
      }
    }   
    
    function   getDimX(el){   
      for   (var   lx=0;el!=null;   
      lx+=el.offsetLeft,el=el.offsetParent);   
      return   lx   
    }   
    
    function   getDimY(el){   
     for   (var   ly=0;el!=null;   
       ly+=el.offsetTop,el=el.offsetParent);   
       return   ly   
    }   
   
	function closevippic()
	{
	   $("#divvippic").hide();
	}
    </script>

</head>
<body>
<embed id="soundControl" src="../../sound/scan.wav"  mastersound hidden="true" loop="false" autostart="false"></embed>
    <form id="form1" runat="server">
       
        <div style="padding:0px 5px;">
        <div>
            <table>
                <tr>
                    <td>
                        <a href="javascript:;" title="点击签到" id="opentrans">销售店柜</a>：
                        <asp:TextBox ID="DepotName" runat="server" ReadOnly="True" Width="90px" CssClass="input"></asp:TextBox>
                        &nbsp;&nbsp;班次： 
                        <asp:DropDownList ID="x_name" runat="server" Width="50px" CssClass="input">
                        </asp:DropDownList>
                        &nbsp;&nbsp;销售日期：<asp:TextBox ID="setdate" runat="server" Width="62px" Enabled="false" CssClass="input" 
                        ReadOnly="true"></asp:TextBox>
                        <!--
                        Enabled="false"
                        ReadOnly="true" 
                        onFocus="setday(this);" 
                        onpropertychange="updateDate(this);" 
                        document.getElementById('dateflag').value='1';
                        <input type="hidden" id="dateflag" value="0" />
                        <input id="chb_date" type="checkbox"/>选择销售日期
                        -->
                       &nbsp;&nbsp;天　气：
                       <asp:TextBox ID="daystat" runat="server" Width="50px" CssClass="input" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        款　　号：
                        <asp:TextBox ID="key" runat="server" Width="90px" CssClass="input ucase"  
                            AutoCompleteType="Disabled" ToolTip="手工输入请按F10"></asp:TextBox>
                        &nbsp;&nbsp;截取：
                        <asp:TextBox ID="clothing_len" ToolTip="条码截取位数" MaxLength="2" runat="server" Width="30px" CssClass="input" AutoCompleteType="Disabled" ></asp:TextBox>
                            
                        &nbsp;&nbsp;整单备注：<asp:TextBox ID="comment" runat="server" Width="80px" CssClass="input" 
                            AutoCompleteType="Disabled" ></asp:TextBox>
                        &nbsp;&nbsp;商场卡：
                        <asp:DropDownList ID="shopcard" runat="server" CssClass="input" >
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                        </asp:DropDownList>

                            
                    </td>
                </tr>
            </table>
        </div>
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
        <tr><td style="height:210px" valign="top">
        <div id="gridTab">
            <table id="retailsub" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr>
                      <td class="gw10">款式编号</td>
                      <td class="gw7">颜色</td>
                      <td class="gw7">名称</td>
                      <td class="gw4">尺码</td>
                      <td class="gw4">数量</td>
                      <td class="gw6">原价</td>
                      <td class="gw7">现价</td>
                      <td class="gw7">折扣</td>
                      <td class="gw7">结算单价</td>
                      <td class="gw7">现价总额</td>
                      <td class="gw7">结算总额</td>
                      <td class="gw12">单款备注</td>
                      <td class="gw6">库存</td>
                      <td class="gw7">同区库存</td>
                      <td class="gw3">&nbsp;</td>
                    </tr>
                    <tr id="sub_template">
                        <td id="sstyleid" class="gw10"></td>
                        <td id="scolorid" class="gw4"></td>
                        <td id="sname" class="gw4"></td>
                        <td id="ssizeid" class="gw4"></td>
                        <td id="snums" class="gw4"><input name="sub_nums" type="text" autocomplete="off" maxlength="7" id="sub_nums" style="width:89%;" /></td>
                        <td id="sj_price" class="gw6"><span id="sub_j_price">-</span></td>
                        <td id="sx_price" class="gw7"><span id="sub_x_price"></span></td>
                        <td id="sdiscount" class="gw7"><input name="sub_discount" type="text" autocomplete="off" id="sub_discount" style="width:90%;" /></td>
                        <td id="ss_price" class="gw7"><input name="sub_s_price" type="text" autocomplete="off" id="sub_s_price" style="width:90%;" /></td>
                        <td id="sx_sums" class="gw7"><span id="sub_xsums"></span></td>
                        <td id="ssums" class="gw7"><span id="sub_sums"></span></td>
                        <td id="scomment" class="gw12"><input name="sub_comment" type="text" autocomplete="off" id="sub_comment" style="width:96%;" /></td>
                        <td id="zskc" class="gw6"><span id="sub_zskc"></span></td>
                        <td id="skc" class="gw4"></td>
                        <td id="sdel" class="gw3">
                            <input type="hidden" name="sub_ID" id="sub_ID"/>
                            <input type="hidden" name="sub_ClothingID" id="sub_ClothingID" />
                            <input type="hidden" name="sub_olddiscount" id="sub_olddiscount" />
                            <img src="../Images/del.gif" alt="删除"  id="sub_del"  />
                        </td>
                    </tr>
                </thead>
                <tbody id="sub_body"></tbody>
                <tfoot>
                   <tr>
                      <td class="gw10">品种：<span id="ct_style">0</span></td>
                      <td class="gw4"></td>
                      <td class="gw4"></td>
                      <td class="gw4"></td>
                      <td class="gw4" id="ct_nums">0</td>
                      <td class="gw6"></td>
                      <td class="gw7"></td>
                      <td class="gw7"></td>
                      <td class="gw7"></td>
                      <td class="gw7" id="ct_xsums">0</td>
                      <td class="gw7" id="ct_sums">0</td>
                      <td class="gw12"></td>
                      <td class="gw6"></td>
                      <td class="gw4"></td>
                      <td class="gw3">&nbsp;</td>
                      </tr>
                </tfoot>
            </table>
         </div>
        </td></tr>
        </table>
        <div style="width:100%;text-align:center;">
            <table style="text-align:left;margin:auto;">
                <tr>
                   <td align="left">
                        &nbsp;&nbsp;VIP卡： 
                        <asp:TextBox ID="vipcard" runat="server" Width="50px" AutoCompleteType="Disabled" 
                            CssClass="input ucase"></asp:TextBox>
                           <input id="f1" class="btn2" value="F1刷VIP卡" type="button" style="width:65px;" />
                           <input id="f8" class="btn2" value="F8其他方式" type="button" style="width:70px;" />
                           <input id="f12" class="btn2" value="F12消费记录" type="button" style="width:72px;" />
                        顾客：<asp:Label ID="vipname" runat="server" Text="-"></asp:Label>
                        总积分：<asp:Label ID="centum" runat="server" Text="0"></asp:Label>
                        上单金额：<asp:Label ID="Label2" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <input id="f2" class="btn2" value="F2收银" type="button" style="width:45px;" />
                        <input id="f3" class="btn2" value="F3挂单" type="button" style="width:45px;" />
                        <input id="f4" class="btn2" value="F4取单" type="button" style="width:45px;" />
                        <input id="f5" class="btn2" value="F5赠送" type="button" style="width:45px;" />
                        <input id="f6" class="btn2" value="F6整单打折" type="button" style="width:68px;" />
                        <input id="f7" class="btn2" value="F7整单作废" type="button" style="width:68px;" />
                        <input id="f9" class="btn2" value="F9退货" type="button" style="width:45px;" />
                        <input id="f10" class="btn2" value="F10手工输入" type="button" style="width:68px;" />
                        <input id="f11" class="btn2" value="F11退换货" type="button" style="width:60px;" />
                        <asp:Label ID="RetailTips" runat="server" Text=""></asp:Label>
                        <asp:HiddenField ID="LocalDateTime" runat="server" />
                        <asp:HiddenField ID="hd_zs" runat="server" Value="0" /><%--赠送--%>
                        <asp:HiddenField ID="hd_back" runat="server" Value="0" /><%--退货--%>
                        <asp:HiddenField ID="retail_zs" runat="server" Value="1" /><%--是否允许赠送--%>
                        <asp:HiddenField ID="retail_back" runat="server" Value="1" /><%--是否允许退货--%>
                        <asp:HiddenField ID="retail_thh" runat="server" Value="1" /><%--允许退换货--%>
                        <asp:HiddenField ID="retail_thType" runat="server" Value="0" /><%--退换货状态--%>
                        <asp:HiddenField ID="retail_yj" runat="server" Value="0" /><%--不显示原价--%>
                        <asp:HiddenField ID="retail_jsj" runat="server" Value="0" /><%--不能改结算价--%>
                        <asp:HiddenField ID="retail_zk" runat="server" Value="0" /><%--不能改折扣--%>
                        <asp:HiddenField ID="retail_dz" runat="server" Value="0" /><%--允许整单打折权限--%>
                        <asp:HiddenField ID="round_type" runat="server" Value="0" />
                        <asp:HiddenField ID="round_bit" runat="server" Value="2" />
                        <asp:HiddenField ID="vipcut" runat="server" Value="0" />
                        <asp:HiddenField ID="vipbeg" runat="server" Value="0" />
                        <asp:HiddenField ID="vipcnt" runat="server" Value="0" />
                        <asp:HiddenField ID="PayCode" runat="server" />
                        <asp:HiddenField ID="isvip" runat="server" Value="0" />
                        <asp:HiddenField ID="showvip" runat="server" Value="0" />
                        <input type="hidden"  id="hid_vipcut" value=""/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
        <div id="divvippic" style=" top:260px; display:none;left:470px; width: 100px; position: absolute; height: 120px;
        BACKGROUND-color:#fff; border:1px solid #cad9ea;">
         <div style=" BACKGROUND: url(../images/cat_bg.gif);
            height: 8px; text-align: left; paddint-bottom: 1px">
        
          
            <a href="#" id="closevipimg">
               <div  class="CloseDropOut" onmouseover="this.className='CloseDropOn'" onmouseout="this.className='CloseDropOut'" >
               </div>
            </a>
            <a href="#" id="showvipimg"></a>
        </div>
        <img id="vippic" src="../AJAX/Vip/vipImg.aspx?vipcode=-999" width="100px" height="133px" alt="" />
        </div>
        <input type="hidden" id="cx_run" value="0" />
        <input type="hidden" id="cx_runid" value="-1" />
    </form>
</body>
</html>
