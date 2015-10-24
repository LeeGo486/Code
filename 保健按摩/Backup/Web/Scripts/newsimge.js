// JavaScript Document By Trance

$(document).ready(function(){
						   
var t=false; //定时器
var time=4000; //切换间隔
var speed=500; //滚动时间
var fot=300; //淡出时间
var fin=300; //淡入时间
var i=0; //起始序列						   
var len=$("#list li").length; //滚动内容个数
var wh=330; //每个滚动内容的宽度

$("#info").css({"width": wh*len + "px"});
//标记当前					   
function cur(ele,currentClass){
	ele= $(ele)? $(ele):ele;
	ele.addClass(currentClass).siblings().removeClass(currentClass);
	}
	
	$("#prev").click(function(){			
		roll(-1);		
		})
    
	$("#next").click(function(){			
		roll(1);		
		})	
	
	$("#list li").mouseover(function(){
		checkfade();
		i=$("#list li").index($(this)[0]);	
		if(!$(this).hasClass("cur")){
			fade(i);
			}		
		cur(this,"cur");		
		})
	//滚动函数
	function roll(j){
		checkroll();
		if(!$("#info").is(":animated")){
			i+=j;					
			if(i!=-1 && i!=len){						
				$("#info").animate({"left" : -(wh*i)+"px"},speed);					
				}else if(i==-1){
					i=len-1;
					$("#info").css({"left" : -(wh*(i-1))+"px"});
					$("#info").animate({"left" : -(wh*i)+"px"},speed);
					}else if(i==len){								
						i=0;
						$("#info").css({"left" : -wh+"px"});
						$("#info").animate({"left" : 0+"px"},speed);						
						}	
			cur($("#list li").eq(i) , "cur");			
			}			
		}
		
	//Fade 函数
	function fade(k){
		checkfade();
		$("#info").find("div:visible").fadeOut(fot,function(){
			$("#info").find("div").eq(k).fadeIn(fin)
			})
		}
		
	//检查并且初始化滚动
	function checkroll(){		
		if($("#info").find(".hide").html()){
			//alert("执行了 checkroll 函数"+index);
			$("#info").find("div").removeClass("hide").show();
			$("#info").css({"left" : -(wh*i)+"px"});
			}
		}
	//检查并且初始化Fade	
	function checkfade(){
		if(!$("#info").find(".hide").html()){
			//alert("执行了 checkfade 函数");
			$("#info").find("div").not($("#info").find("div").eq(i)).addClass("hide");
			$("#info").css({"left" : 0+"px"});
			}
		}
	
	//自动执行
	function setInt(){
		t=setInterval(function(){roll(1)},time);
		}
	function clearInt(){
		if(t) clearInterval(t);
		}
		
	$("#area").hover(
		function(){ clearInt() },
		function(){ setInt() }
		)	
	
	//响应键盘
	$(document).keydown(function(event){ 
		event = event || window.event;
		if(event.keyCode==38 || event.keyCode==37){	
			clearInt();
			roll(-1);
			setInt();
			};
		if(event.keyCode==40 || event.keyCode==39){			
			clearInt();
			roll(1);
			setInt();
			};	
		})
	
	//开始自动
	setInt();	
	
	})