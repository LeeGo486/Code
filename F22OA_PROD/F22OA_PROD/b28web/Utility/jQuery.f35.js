// JavaScript Document
var beforeRow =	null;

//F35 javascript
	//extend function
	jQuery.fn.extend({
					 
		//get rows
		f35gridGetRow:function(type)
		{
			return $(this).find('tbody tr'+(type||''));
		},
		//get Selected rows
		f35gridGetCol:function(col,rows)
		{
			var rt = new Array();
			$.each((rows||$(this).find('tbody tr')),function(){
				rt.push($(this).find("td").not($('.choosebox')).eq((col||0)).text());
			});
			return rt;
		},
		
		f35gridRemoveRow:function(rows)
		{
			rows = (rows||$(this).find('tbody tr.selected'));
			
			beforeRow = beforeRow.next().length>0?$(beforeRow).next():$(beforeRow).prev();
			beforeRow.addClass('selected');
			
			if(rows.length>0) rows.remove();
			$(this).f35grid();
			
		},
		//grid for web pos
		f35grid:function(opt,callback){
			
			var grid = 	$(this);
			//begin
			grid.attr({'cellspacing':'0','cellpadding':'2'}).addClass('f35grid');
			grid.find('tbody tr:odd').removeClass('even').addClass('odd');
			grid.find('tbody tr:even').removeClass('odd').addClass('even');
			
			//header
			if(!opt) return;
			if(opt.width){
				$.each(grid.find('thead td').not($('.choosebox')),function(i,o){
					$(this).width((parseFloat(opt.width[i])||80)+'px');
				});
			}
			
			//rows
			var _foot = new Array();
			$.each(grid.find('tbody tr'),function(i,row){
				//align
				if(opt.align)
				{
					$.each(opt.align,function(n){
						if(opt.align[n])$(row).find("td").eq(n).attr('align',opt.align[n]);	  
					});
				}
				//showFooter
				if(opt.showFooter)
				{
					$.each(opt.showFooter,function(n){
						if(!_foot[opt.showFooter[n].col]) _foot[opt.showFooter[n].col] = new Array();
						_foot[opt.showFooter[n].col].push($(row).find("td").eq(opt.showFooter[n].col).text());
					});
				}
			});
			
			//showFooter
			if(opt.showFooter)
			{
				var f =  $('<tfoot />');
				var tr = $('<tr />');
				var n=0;
				
				$.each(grid.find('thead td'),function(i){
					var td = $('<td />');
					if(_foot[i]){
						var txt = $.f35.tools.calc(_foot[i],opt.showFooter[n].type);
						if(opt.showFooter[n].format) txt=opt.showFooter[n].format.replace('{0}',txt);
						td.text(txt);
						n += 1;
					}
					tr.append(td);
				});
				grid.append(f.append(tr));
			}
			
			//choose box
			if(opt.choosebox)
			{
				//type
				opt.choosebox.type=!opt.choosebox.type?"checkbox":opt.choosebox.type;

				//header
				var h = $('<td />').addClass('choosebox');
				if(opt.choosebox.type=="checkbox")
				{
					var ah= $('<span class="'+opt.choosebox.type+'-on"></span>')
					.click(function(){
						if($(this).parent().find('.checkbox-off').length==0)
						{
							$(this).addClass('checkbox-off');
							grid.find('tbody tr').not($('.selected')).addClass('selected')
							
						}else{
							$(this).removeClass('checkbox-off');
							grid.find('tbody tr.selected').removeClass('selected')
						}
					})
					h.append(ah);
					
					//document up&down muilite choose events
					$(document).bind('keydown', 'ctrl+a', function(){
						ah.click();return false;
					});
					$(document).bind('keydown', 'shift+up', function(){
					   keymove($(beforeRow).prev(),true);return false;
					});
					$(document).bind('keydown', 'shift+down', function(){
					   keymove($(beforeRow).next(),true);return false;
					});
				}
				
				//document up&down events
				$(document).bind('keydown', 'up', function(){
				   keymove(!beforeRow?grid.find('tbody tr:last'):$(beforeRow).prev(),false);
				   return false;
				});
				$(document).bind('keydown', 'down', function(){
				   keymove(!beforeRow?grid.find('tbody tr:first'):$(beforeRow).next(),false);
				   return false;
				});
				$(document).bind('keydown', 'end', function(){
				   keymove(grid.find('tbody tr:last'),false);
				   return false;
				});
				$(document).bind('keydown', 'home', function(){
				   keymove(grid.find('tbody tr:first'),false);
				   return false;
				});
				
				function keymove(obj, shiftKey)
				{
					if(obj.length>0)
					{
						if(!shiftKey)$(beforeRow).removeClass('selected')
						$(obj).addClass('selected');
						beforeRow = obj;
					}
				}
				
				//body
				var b = $('<td />').addClass('choosebox');
				var ab= $('<span class='+opt.choosebox.type+'></span>');
				if(opt.choosebox.callback) ab.click(opt.choosebox.callback);
				b.append(ab);
				
				grid.find('thead tr').prepend(h);
				grid.find('tbody tr').prepend(b).css({'cursor':'pointer'});
				grid.find('tfoot tr').prepend($('<td />'));
				
			}
			
			//row button
			if(opt.button)
			{
				//header
				var h = $('<td />')	
				//body
				var b = $('<td />').attr('align','center');
				var w = 0;
				//button(s)
				$.each(opt.button.text,function(i){
					w += opt.button.text[i].length;
					var ab = $('<a href="javascript:return false;" />').text(opt.button.text[i]);
					ab.click(function(){return false});
					if(opt.button.callback) ab.click(opt.button.callback[i]);
					if(i>0)b.append(' | ');
					b.append(ab);
				});
				
				h.width((w*10)+'px')
				
				grid.find('thead tr').append(h);
				grid.find('tbody tr').append(b);
				grid.find('tfoot tr').append($('<td />'));
			}
			
			//row click event
			grid.find('tbody tr').click(function(){
				if(opt.choosebox){
					if(opt.choosebox.type=="checkbox"){
						$(this).toggleClass('selected');
					}else if(opt.choosebox.type=="radio"){
						if(beforeRow) $(beforeRow).removeClass("selected");
						$(this).addClass('selected');
					}
					beforeRow = $(this);
				}
			});
			if(opt.rowClick) grid.find('tbody tr').click(opt.rowClick);
			if(opt.rowDblClick){
				
				//row double click event
				grid.find('tbody tr').dblclick(opt.rowDblClick);
				
				//document up&down events
				$(document).bind('keydown', 'return', function(){
					if(beforeRow) $(beforeRow).dblclick();
				});
			}
			
			//grid callback
			if(callback)callback();
		}
	});
	
$(function()
{
	//extend
	jQuery.extend({
	  f35:{
		tools:{
			calc:function(arr,type){
				var _x = 0;
				type = (type||'count')
				switch(type)
				{
					case 'count':
						_x = arr.length;
						break;
					case 'sum':
						$.each(arr,function(i){ _x+=(parseFloat(arr[i])||0)});
						_x = Math.round(_x * 1000000) / 1000000;
						break;
					case 'avg':
						$.each(arr,function(i){ _x+=(parseFloat(arr[i])||0)});
						_x = _x / arr.length;
						_x = Math.round(_x * 1000000) / 1000000;
						break;
					case 'max':
						$.each(arr,function(i){ _x = i==0?_item:(_x>(parseFloat(arr[i])||0)?(parseFloat(arr[i])||0):_x)});
						_x = Math.round(_x * 1000000) / 1000000;
						break;
					case 'min':
						$.each(arr,function(i){ _x = i==0?_item:(_x<(parseFloat(arr[i])||0)?(parseFloat(arr[i])||0):_x)});
						_x = Math.round(_x * 1000000) / 1000000;
						break;
				}
				return _x;
			}
		}
	  }
	});		   
});


