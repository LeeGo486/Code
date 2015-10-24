<%@ page language="C#" autoeventwireup="true" inherits="b28web_Modal_input_vipcardjm, App_Web_input_vipcardjm.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>其它VIP输入方式</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <script src="../Utility/command.js" type="text/javascript"></script>
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <script src="../Utility/jquery-1.2.6.min.js" type="text/javascript"></script>
    <style type="text/css">
    #research
    {
	    height:250px;
	    width:750px;
	    padding:10px;
	    overflow:auto;
	    }

    </style>
    <script type="text/javascript">
    $(function(){
        $("#loading").hide();
       
        
        //查询
        $("#Button1").click(function(){
           $("#Button5").attr('disabled','disabled');
           $("#HiddenField1").val('');
            $.ajax({
                beforeSend:function(){
                    $("#research").empty();
                    $("#research").html('<div id="loading"><img src="../Images/loading.gif" alt="" align="absmiddle"/> 加载中...</div>');
                    $("#loading").show();
                },
                complete:function(){$("#loading").hide();setevents()},
                url: "../ajax/Vip/vipresearch.aspx",
                type: "POST",
                data: "act="+$("input:checked").val()+"&val="+$("#keyword").val(),
                async: true,
                success:function(html){
                    $("#research").html(html);
            
                },
                error:function(html){
                    alert('数据加载出错！');
                }
            });
        });
        
        //确定
        $("#Button5").click(function() {
            var s = "";
            $("#DataBody tr").each(function() {
                if ($(this).find("input").attr('checked'))
                    s = $(this).find("td").eq(2).children("input type[hidden]").val();
                /*
                合并字符串，用于界面截取
                    
                */
                s = s + "_" + "1";
            });
            window.returnValue = s
            window.close();
        })
        //vipcode,vipname,mobtel
        $("#vipcode").change(function(){
              var pos_vipshow='<%=pos_vipshow%>';
              if (pos_vipshow){
                document.all('keyword').outerHTML="<input type=password id=keyword style=\"width:200px\" class=input>";
              }
	        })
	        
	    $("#vipname,#mobtel").change(function(){
	         document.all('keyword').outerHTML="<input type=text id=keyword style=\"width:200px\" class=input  >";
	        })
	        
	    $("#keyword").keydown(function(){
            if(event.keyCode==13||event.keyCode==10){
                $("#Button1").click();
                return false;
            }
        });    
    });
    
  
    function setevents()
    {
            var row = $("#DataBody").find("tr");
            $.each(row,function(i,obj){
                if(i % 2 == 0)$(obj).css("background-color", "#F7F6F3");
                $(obj).click(function(){
                   setcolor();
                   $(obj).find(":radio").attr('checked','checked');
                   $(obj).css("background-color", "#E2DED6");
                   $("#Button5").removeAttr('disabled');
                   $("#HiddenField1").val( $(obj).find("input").val());
                });
                
                $(obj).dblclick(function(){
                   $("#HiddenField1").val( $(obj).find("input").val());
                   $("#Button5").removeAttr('disabled');
                   $("#Button5").click();

                });
            
                $(obj).find("a").click(function()
                {
                    openModal('../Modal/Vipinfo.aspx?vipcode=' + ($(obj).find(":radio").val().split('$'))[0],990,450);
                    return false;
                })
            });
    }
    
    function setcolor()
    {
        var row = $("#DataBody").find("tr");
        $.each(row,function(i,obj){
           $(obj).css("font-weight","");
           $(obj).css("background-color", "");
            if(i % 2 == 0)$(obj).css("background-color", "#F7F6F3");
        });
    }
    
    </script>
    <script type="text/javascript">
    function KeyDown(){
        with (event){ 
            if(keyCode==116){//确定
                document.getElementById('Button5').click();
                event.keyCode = 0; 
                event.cancelBubble = true; 
                return false;
            }
            if(keyCode==27){//ESC返回输入状态
                document.getElementById('Button4').click();
                event.keyCode = 0; 
                event.cancelBubble = true; 
                return false;
            }
        }
    }
    
    //加载完成
    $(document).ready(function(){
        document.onkeydown = KeyDown;
    });
    
    function changetype(typeid){
       
    }
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding:10px 5px;width:98%">
    <asp:RadioButton ID="vipcode" runat="server" Text="VIP卡号 " GroupName="se" />
    <asp:RadioButton ID="vipname" runat="server" Text="顾客姓名 " GroupName="se" />
    <asp:RadioButton ID="mobtel" runat="server" Text="手机号码 " Checked="true" GroupName="se" />
      <input type="text" id="keyword" style="width:200px" class="input"  />
      <input id="Button1" type="button" value="查询" class="btn2"/>
    <asp:Button ID="Button5" runat="server" cssclass="btn2"  Text="确　定[F5]" 
            Enabled="false" OnClientClick="return false" UseSubmitBehavior="false" />
    <input id="Button4" type="button" value="取　消[Esc]" onclick="window.close();" class="btn2" />
    <hr class="clear" />
    <div style="text-align:center;" id="research"></div>
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:HiddenField ID="HiddenField2" runat="server" />
    <asp:HiddenField ID="HiddenField3" runat="server" />
    </div>
    </form>
</body>
</html>
