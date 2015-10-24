 /****************************************************************************
  *  新增自定义编辑器		可以扩展
  *  liuwei
  *  2013-04-25
  */  



$.extend($.fn.datagrid.defaults.editors, { 
	/***********************************************************************
	 *  重定义editor的datebox，设置日期格式
	 *  DLY
	 *  2013-04-18
	 */  
	datebox: {
		//datebox就是你要自定义editor的名称
		init: function(container, options){ 
			var input = $('<input type="text" class="easyui-datebox"> ').appendTo(container); 
			return input.datebox({ 
				closeText:'关闭',  
				formatter:function(date){  
				   var y = date.getFullYear();  
				   var m = date.getMonth()+1;  
				   var d = date.getDate();  
				   var h = date.getHours();  
				   var M = date.getMinutes();  
				   var s = date.getSeconds();  
				   function formatNumber(value){  
				    return (value < 10 ? '0' : '') + value;  
				   }    
				   //return y+'-'+m+'-'+d+' '+ formatNumber(h)+':'+formatNumber(M)+':'+formatNumber(s); 
				   return y+'-'+formatNumber(m)+'-'+formatNumber(d);  
				},  
			    parser:function(s){  
				    var t = Date.parse(s);  
				   if (!isNaN(t)){  
				    return new Date(t);  
				   } else {  
				    return new Date();  
				   }  
				}   
			    
			}); 
		}, 
        destroy: function(target){
            $(target).datebox('destroy');
        },		
        getValue: function(target){
            return $(target).datebox('getValue');
        },
        setValue: function(target, value){
            $(target).datebox('setValue', value);
        },
        resize: function(target, width){
            $(target).datebox('resize', width);
        }
   } 

/****************************************************************************
 *  重定义editor的 按钮
 *  liuwei
 *  2013-04-25
 */ 
,
ftbutton : {  
	    init: function(container, options)  
	    {  
	        var editorContainer = $('<div/>');  
	        var button = $("<a href='javascript:void(0)'></a>")  
	             .linkbutton({plain:true, iconCls:"icon-edit"});  
	        editorContainer.append(button);  
	        editorContainer.appendTo(container);  
	        return button;  
	    }, 
	    
	    onclick1:function(){
	    	alert("nihao");
	    },
	    getValue: function(target)  
	    {  
	        return $(target).text();  
	    },  
	    setValue: function(target, value)  
	    {  
	        $(target).text(value);  
	    },  
	    resize: function(target, width)  
	    {  
	        var span = $(target);  
	        if ($.boxModel == true){  
	            span.width(width - (span.outerWidth() - span.width()) - 10);  
	        } else {  
	            span.width(width - 10);  
	        }  
	    }  
	    }  
   
   
   
   
});
