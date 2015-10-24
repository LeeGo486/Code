/********************************************************************************************************
 * D-ImageChange
 *----------------------------------------------------------------------------------------------------
 * @Desc 图片轮换插件
 *----------------------------------------------------------------------------------------------------
 * @Author D.夏亦知非
 * @Email DeclanZhang@gmail.com
 * @QQ 29540200
 * @Blog http://onblur.javaeye.com
 * @Date 2009-10-19
 * @Version V1.3@2010-03-16
 * @JQueryVersion 1.3.2+ (建议使用1.4以上版本)
 * 
 * @update v1.1 增加清空原始内容功能,以免页面加载完成之前显示大片空白
 * 		   v1.2 修正IE6每次从服务器读取背景图片的BUG
 *         v1.3 修正了宽度过大产生的BUG, 兼容JQ1.4.1, 建议使用JQ1.4+, 效率更高
 **/

// 修正IE6每次从服务器读取背景图片的BUG
try {
	document.execCommand('BackgroundImageCache', false, true);
}catch(e){

}

(function($){

jQuery.fn.extend({
	
	imageSwitch:function(setting){
		if (typeof Fai == "undefined"){
			alert("must import fai.js");
			return;
		}
		var config = $.extend({
			bg:true,						// 是否背景色
			title:true,						// 是否有标题
			desc:true,						// 是否有描述
			btn:true,						// 是否显示按钮
			repeat:'no-repeat',				// 重复规则 'no-repeat' 'repeat-x' 'repeat-y' 'repeat'
			position:'50% 50%',				// 背景位置
			
			bgColor:'#000',					// 背景色
			bgOpacity:0,					// 背景透明度
			bgHeight:20,					// 背景高
			
			titleSize:14,					// 标题文字大小
			titleFont:'Verdana,宋体',		// 标题文本字体
			titleColor:'#FFF',				// 标题文本颜色
			titleTop:4,						// 标题上边距
			titleLeft:4,					// 标题左边距
			
			descSize:12,					// 描述文字大小
			descFont:'Verdana,宋体',			// 描述文本字体
			descColor:'#FFF',				// 描述文本颜色
			descTop:2,						// 描述上边距
			descLeft:4,						// 描述左边距
			
			btnWidth:15,					// 按钮宽
			btnHeight:15,					// 按钮高
			btnMargin:4,					// 按钮间距
			
			playTime:4000,					// 轮换间隔时间,单位(毫秒)
			animateTime:1500,				// 轮换动画时间,单位(毫秒)
			animateStyle:'o',				// 动画效果:'o':渐显 'x':横向滚动 'y':纵向滚动 'show':原地收缩伸展 'show-x':横向收缩伸展 'show-y':纵向收缩伸展' none':无动画
			//width:300,						// 宽, 不设定则从DOM读取
			//height:200						// 高, 不设定则从DOM读取
			index: 0,
			from: 'module'
			
		},setting);
		
		return $(this).each(function(){
			var _this = $(this);
			var _w = config.width || _this.width();			// 宽
			var _h = config.height || _this.height();		// 高
			var _n = config.data.length;					// 数目
			var _i = config.index;										// 当前显示的item序号
			
			_this.css('overflow','hidden')
			_this.height(_h);
			if (config.width && config.from == "module") {
				_this.width(config.width);
			}
			
			// 计算动画时间
			/*
			if (!config.animateTime){
				if (config.playTime <= 1000) {
					config.animateTime = 300;
				} else if (config.playTime < 2000) {
					config.animateTime = 800;
				} else if (config.playTime < 3000) {
					config.animateTime = 1200;
				} else {
					config.animateTime = 1500;
				}
			}
			*/
			
			// 半透明背景
			if(config.bg){
			var _transArea = 
			$('<div />').appendTo(_this)
//						.width(_w)
						.css('width', '100%')
						.height(config.bgHeight)
						.css('background-color',config.bgColor)
						.css('opacity',config.bgOpacity)
						.css('position','absolute')
						.css('marginTop',_h-config.bgHeight)
						.css('zIndex',1);
			}
			

			// 按钮区
			var btnDisplay = "none";
			if(config.data.length > 1)
			{
				btnDisplay = config.btn?'block':'none';
			}
			var _btnArea = 
			//$('<div class="imageSwitchBtnArea"/>').appendTo(_this)
			$('<div class="imageSwitchBtnArea"/>').appendTo(_this)
						.css('position','absolute')
						.css('zIndex',1)
						.css('display',btnDisplay);
						
			
			//var btnHtml = '<div class="imageSwitchBtnArea" style="position:absolute; zIndex:29;display:'+ btnDisplay +';"></div>';
			
			// 文字区
			/*
			var _textArea = 
			$('<div />').appendTo(_this)
//						.width(_w)
						.css('width', '100%')
						.height(config.bgHeight)
						.css('position','absolute')
						.css('marginTop',_h-config.bgHeight)
						.css('zIndex',0);
			*/
			
			
			// 插入空div修正IE的绝对定位BUG
			$('<div />').appendTo(_this);
			
			// 图片区
			var _imgArea = 
			$('<div class="switchGroup" />').appendTo(_this)
//						.width('x,show-x'.indexOf(config.animateStyle)!=-1?_w*_n:_w)
						.css("width", "100%")
						.height('y,show-y'.indexOf(config.animateStyle)!=-1?_h*_n:_h);			
	
			// 初始化图片 文字 按钮
			var btnAreaWidth = 0;
			$.each(config.data,function(i,n){
				var onclick = "";
				if (!n.href){
					onclick = "onclick='return false;'";
				}
				if(n.width && n.width > 0) {
					//传了宽度且宽度大于0，则以img的方式，否则以背景的方式显示
					$('<a hidefocus="true" style="outline:none;" ' + onclick + '/>').appendTo(_imgArea)
//						  .width(_w)
						  .css("width", "100%")
						  //.height(_h)
						  .css("height", _h + "px")
						  .attr('href',n.href?n.href:'javascript:;')
						  .attr('target',n.target?n.target:'')
						  .attr('title',n.tip?n.tip:'')
                          .attr('desc',n.desc?n.desc:'')
						  .css('cursor',n.href?'pointer':'default')
						  //.css('background-image','url('+n.src+')')
						  .css('background-position',config.position)
						  .css('background-repeat',config.repeat)
						  .css('overflow', 'hidden')
						  .css('display','block')
						  .css('float','x,show-x'.indexOf(config.animateStyle)!=-1?'left':'').html("<img src='"+ n.src +"' width='"+ n.width +"' height='"+ n.height +"'>");
				}else{
					$('<a hidefocus="true" style="outline:none;" ' + onclick + '/>').appendTo(_imgArea)
//						  .width(_w)
						  .css("width", "100%")
						  //.height(_h)
						  .css("height", _h + "px")
						  .attr('href',n.href?n.href:'javascript:;')
						  .attr('target',n.target?n.target:'')
						  .attr('title',n.tip?n.tip:'')
                          .attr('desc',n.desc?n.desc:'')
						  .css('cursor',n.href?'pointer':'default')
						  .css('background-image','url('+n.src+')')
						  .css('background-position',config.position)
						  .css('background-repeat',config.repeat)
						  .css('overflow', 'hidden')
						  .css('display','block')
						  .css('float','x,show-x'.indexOf(config.animateStyle)!=-1?'left':'');
				}
				
						  /*
				if(config.title){
				$('<b />').appendTo(_textArea)
						  .html(n.title?n.title:'')
						  .css('display',i==_i?'block':'none')
						  .css('fontSize',config.titleSize)
						  .css('fontFamily',config.titleFont)
						  .css('color',config.titleColor)
						  .css('marginTop',config.titleTop)
						  .css('marginLeft',config.titleLeft);
				}
				if(config.desc){
				$('<p />').appendTo(_textArea)
						  .html(n.desc?n.desc:'')
						  .css('display',i==_i?'block':'none')
						  .css('fontSize',config.descSize)
						  .css('fontFamily',config.descFont)
						  .css('color',config.descColor)
						  .css('marginTop',config.descTop)
						  .css('marginLeft',config.descLeft);
				}
				*/
				
				var _btn = $('<a class="imageSwitchBtn"/>').appendTo(_btnArea)
						  .html('<span>' + (i + 1) + '</span>')
				btnAreaWidth += Fai.getDivWidth(_btn);
				if (i == _i) {
					_btn.addClass('imageSwitchBtnSel');
                    _this.next(".tpdesc").html(n.desc);
				}
			});

			_btnArea.width(btnAreaWidth);
			var parent = _this.parent();
			var parentWidth = parent.width();
			var parentHeight = parent.height();
			if(config.from == "module")
			{
				//图片从左上角开始
				if(parentWidth > config.width){parentWidth = config.width;}
			}else{
				//banner居中
				if(parentWidth > config.width){parentWidth = config.width + (parentWidth - config.width)/2;}
				if(parentWidth > _this.width()){ parentWidth = _this.width();}
			}
			if(parentHeight > _h){parentHeight = _h;}
			_btnArea.css('top', (parentHeight - _btnArea.height()) + "px");
			_btnArea.css('left', (parentWidth - btnAreaWidth) + 'px');
			
			// 保存所有元素集合的引用,方便在事件中使用
			var _bs = _btnArea.children('a');
			//var _ts = _textArea.children('b');
			//var _ds = _textArea.children('p');
			var _is = _imgArea.children('a');

			// 针对不同的动画效果的附加设置, 主要是block的问题, 若在初始化时设置block:none会造成之后无block效果
			if('o,show,none'.indexOf(config.animateStyle)!=-1){
				_is.each(function(i, n){
					if (_i != i) {
						$(this).hide();
					}
					$(this).css('position','absolute');
					$(this).css('left','0');
					$(this).css('top','0');
				});
			}
			
			// 添加按钮事件
			_bs.click(function(){
				var ii = _bs.index(this);
				if(ii==_i){return;}
				
				//_ts.eq(_i).css('display','none');
				//_ts.eq(ii).css('display','block');
				//_ds.eq(_i).css('display','none');
				//_ds.eq(ii).css('display','block');
				_bs.eq(_i).removeClass('imageSwitchBtnSel');
				_bs.eq(ii).addClass('imageSwitchBtnSel');

				switch(config.animateStyle){
				case 'o' :
					_is.eq(_i).fadeOut(config.animateTime, "failinear");
					_is.eq(ii).fadeIn(config.animateTime, "failinear");
					break;
				case 'x' :
					_imgArea.animate({marginLeft:-ii*_w},config.animateTime);
					break;
				case 'y' :
					_imgArea.animate({marginTop:-ii*_h},config.animateTime);
					break;
				case 'show' :
				case 'show-x' :
				case 'show-y' :
					_is.eq(_i).hide(config.animateTime);
					_is.eq(ii).show(config.animateTime);
					break;				
				case 'none' :
					_is.eq(_i).hide();
					_is.eq(ii).show();
					break;				
				}
                _this.next(".tpdesc").html(_is.eq(ii).attr("desc"));
				_i = ii;
			});

			// faisco:使用fai的方式，以便弹出窗口是能够停止动画
			var intervalId = 'imageSwitch' + Math.random();
			function play(){
				_bs.eq((_i+1)%_n).click()
			}					
			Fai.addInterval(intervalId, play, config.playTime);
			Fai.startInterval(intervalId);
			_this.mouseover(function(){
				Fai.stopInterval(intervalId);
			});
			_this.mouseout(function(){
				Fai.startInterval(intervalId);
			});

/*
			// 添加轮换任务
			var _play = setInterval(play,config.playTime);
			function play(){
				_bs.eq((_i+1)%_n).click()
			}		
			var _ran = Math.random();
			// 鼠标进入事件
			_this.mouseover(function(){
				clearInterval(_play);
			});
			// 鼠标离开事件
			_this.mouseout(function(){
				clearInterval(_play);
				_play = setInterval(play,config.playTime);
			});
*/
		});
	}
});












})(jQuery);