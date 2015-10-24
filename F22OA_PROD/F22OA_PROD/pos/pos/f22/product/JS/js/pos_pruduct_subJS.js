        //装载颜色的数组
        var color=new Array();
        //装载颜色编号的数组
        var colorIdAry=new Array();
        //装载尺码的数组
        var size=new Array();
        //装载尺码编号的数组
        var sizeidAry=new Array();
        
        //设置隐藏域
        function setCheckBoxValue(ele){
             $(ele).click(function(){
                 getCheckBox(ele);
                 colorAndSizeBtnClick();
             });
        }
        
        //设置颜色和尺码的隐藏域的值
        function getCheckBox(ele){
            $("#hid_colorAndSize").val($(ele).val());
            $("#hid_colorAndSizeId").val($(ele).next("input[type=hidden]").val());
        }
        
        //设置尺码
        function setColorTab(){
           for(var i=0;i<sizeidAry.length;i++){
            $("<td></td>").text(sizeidAry[i]).addClass("conTdStyle").appendTo($("#colorTr"));
           }
        }
        
        //设置颜色
        function setSizeTab(){
            for(var i=0;i<color.length;i++){
               var td=$("<td></td>").addClass("conTdStyle");
               td.text(color[i]);
               var tr=$("<tr></tr>");
               td.appendTo(tr);
               tr.appendTo("#sizeTab");
            }
            
        }
        
        //设置颜色和尺码的交集
        function setContentTab(){
            for(var i=0;i<color.length;i++){
                var tr=$("<tr></tr>");
                for(var j=0;j<sizeidAry.length;j++){
                    var value=sizeidAry[j]+"_"+color[i];
                    var valueId=sizeidAry[j]+"_"+colorIdAry[i];
                    var cb = $("<input type='checkbox'value='"+value+"'/><input type='hidden'value='"+valueId+"'/>");
                    var td=$("<td></td>").addClass("conTdStyle");
                    td.append(cb);
                    td.appendTo(tr);
                    isCheckBox(cb);
                    setCheckBoxValue(cb);
                }
            $("#contentTab").append(tr);
            }
        }
        
        //判断是否有输入了款式编号
        function styleTxtEven(ele){
            if($(ele).val()!=""){
                setValue($(ele).val());
                event.keyCode=9;
            }else{
                alert("请输入款式编号");
                return false;
            }
        }
        
        //款式输入框键盘事件
        function styleNumKeyDown(){
            $("#txt_styleNum").keydown(function(){
                if(event.keyCode==13){
                    styleTxtEven(this);
                }
            });
        }
        
        //调用获取颜色和尺码的方法
        function setValue(value){
            $("#styleNum").text(value);
            setStyle(value);
            $("#changeColorSize").show();
        }
        
        //设置文本的键盘事件
        function setClassToText(){
            $("#pos_subContent input[type=text]").addClass("txtBox").each(function(){
                $(this).keydown(function(){
                    if($(this).attr("id")=="txt_styleNum"){
                        clear();
                        styleNumKeyDown();
                    }else{
                        if(event.keyCode==13){
                            event.keyCode=9;
                        }
                    }
                });
            });
        }
        
        //关闭选项
        function setCheckBoxChecked(ele){
           if($(ele).attr("checked")==true){
                $("#changeColorSize input[type=checkbox]").attr("disabled",true);
                $(ele).attr("disabled",false);
           }else{
                $("#changeColorSize input[type=checkbox]").attr("disabled",false);
                $("#hid_colorAndSize").val("");
                $("#hid_colorAndSizeId").val("");
           }
        }
        
        //获取颜色和尺码
        function setStyle(sty){
            PageMethods.GetCororAndSizeToStyleId(sty,sueessudStyle,errorStyle);
        }
        
        //成功回调
        function sueessudStyle(r){ 
        if(r.SizeAry!=0 && r.ColorAry!=0){    
            for(var i=0;i<r.SizeAry.length;i++){
                size[i]=r.SizeAry[i].SizeName;
                sizeidAry[i]=r.SizeAry[i].SizeId;
            }
            for(var i=0;i<r.ColorAry.length;i++){
                color[i]=r.ColorAry[i].ColorName;
                colorIdAry[i]=r.ColorAry[i].ColorId;
            }
            setColorTab();
            setSizeTab();
            setContentTab();
            viewChange();
            focueCheckBox();
            setDivKeyDown();
            
            }else{
                var ccs= $("#changeColorSize");
                ccs.empty();
                ccs.append($("<a href='product_pos_sub.aspx'>没有相关的款式，请确认款式编号是否存在，点击返回</a>"));
            }
        }
        
        function viewChange(){
            $("#changeColorSize .showimg").hide();
            $("#cmTab").show();
        }
        
        //失败回调
        function errorStyle(e){
            alert(e.get_message());
        }
        
        //获取货物Id
        function getClothingToKey(key){
            PageMethods.GetClothingInfoToKey(key,sueessudGetClothing,errorGetClothing);
        }
        //成功回调
        function sueessudGetClothing(r){
            $("#txt_x_price").val(r.X_Price);
        }
        //失败回调
        function errorGetClothing(e){
            alert(e.get_message());
        }
        
        //确定选择尺码和颜色
        function colorAndSizeBtnClick(){
            var value=$("#hid_colorAndSize").val();
            var vId=$("#hid_colorAndSizeId").val();
            if(value!="" && vId!=""){
                var txtValue=value.split("_");
                var txtId=vId.split("_");
                $("#txt_size").val(txtValue[0]);
                $("#txt_color").val(txtValue[1]);
                var cId=$("#txt_styleNum").val()+txtId[1]+txtId[0];
                getClothingToKey(cId);
                $("#txt_clothingid").val(cId);
                $("#colorTr").empty();
                $("#sizeTab").empty();
                $("#contentTab").empty()
                $("#changeColorSize").hide();
            }else{
                alert("请选择尺码和颜色！");
            }
        }
        
        //关闭窗体
        function closeWindow(){
            window.close();
        }
        
        //验证数据
        function checkMsg(){
            var dName=$("#txt_accept_dname").val();
            var date=$("#txt_accept_date").val();
            var cName=$("#txt_retailname").val();
            var cId=$("#txt_clothingid").val();
            var price=$("#txt_s_price").val();
            var color=$("#txt_color").val();
            if(dName==""){
                alert('受理店铺不能为空！');
                return false;
            }
            if(date==""){
                alert('受理日期不能为空！');
                return false;
            }
            if(cName==""){
                alert('顾客姓名不能为空！');
                document.getElementById("txt_retailname").focus();
                $("#txt_retailname").focus();
                return false;
            }
            if(cId==""){
                alert('货品编码不能为空！');
                return false;
            }
            if(color==""){
                alert('颜色不能为空！');
                return false;
            }
            if(isNaN(price) && price==""){
                alert('购买价格类型错误！');
                return false;
            }
            return true;
        }
        
        //关闭按钮事件
        function closeBtn(){
            $("#btn_close").click(function(){
                closeWindow();
            });
        }
        
        
        //获取焦点
        function focueCheckBox(){
            var a= $("#changeColorSize input[type=checkbox]:first");
            a.focus();
            isCheckBox(a);
        }
        
        //设置多选框选中
        function isCheckBox(ele){
            $("#changeColorSize input[type=checkbox]").attr("checked",false);
            $(ele).attr("checked",true);
        }
        
        //设置键盘事件
        function setDivKeyDown(){
            $("#changeColorSize input[type=checkbox]").keydown(function(){
                var rowNum=$("#conTab tr").index($(this).parent().parent());
                var colNum=$($("#conTab tr").get(rowNum)).children().index($(this).parent());
                var max=$(this).parent().parent().find("td").size();
                if(event.keyCode==39){
                    if(colNum<max-1){
                        var a= $(this).parent().next();
                        a.children().focus();
                        isCheckBox(a.children());
                    }
                }
                if(event.keyCode==37){
                   if(colNum>0){
                        var a= $(this).parent().prev();
                        a.children().focus();
                        isCheckBox(a.children());
                   }
                }
                if(event.keyCode==38){
                    var ele=$(this).parent().parent().prev().find("td").get(colNum);
                    if(ele){
                        var a=$(ele).children();
                        a.focus();
                        isCheckBox(a);
                    }
                }
                if(event.keyCode==40){
                    var ele=$(this).parent().parent().next().find("td").get(colNum);
                    if(ele){
                        var a=$(ele).children();
                        a.focus();
                        isCheckBox(a);
                    }
                }
                if(event.keyCode==13){
                    event.keyCode=32;
                   }
                if(event.keyCode==32){
                     $(this).attr("checked",true);
                     getCheckBox(this);
                     colorAndSizeBtnClick();
                     clear();
                }
                
            });
        }
        
        //清除旧的内容
        function clear(){
            $("#colorTr").empty();
            $("#contentTab").empty();
            $("#contentTab").empty();  
            $("#changeColorSize .showimg").show();
            $("#cmTab").hide();
        }
        
        //页面加载完成后加载
        jQuery(function(){
            setClassToText();
            closeBtn();
        })