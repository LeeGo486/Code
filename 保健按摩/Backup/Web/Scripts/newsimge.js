// JavaScript Document By Trance

$(document).ready(function(){
						   
var t=false; //��ʱ��
var time=4000; //�л����
var speed=500; //����ʱ��
var fot=300; //����ʱ��
var fin=300; //����ʱ��
var i=0; //��ʼ����						   
var len=$("#list li").length; //�������ݸ���
var wh=330; //ÿ���������ݵĿ��

$("#info").css({"width": wh*len + "px"});
//��ǵ�ǰ					   
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
	//��������
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
		
	//Fade ����
	function fade(k){
		checkfade();
		$("#info").find("div:visible").fadeOut(fot,function(){
			$("#info").find("div").eq(k).fadeIn(fin)
			})
		}
		
	//��鲢�ҳ�ʼ������
	function checkroll(){		
		if($("#info").find(".hide").html()){
			//alert("ִ���� checkroll ����"+index);
			$("#info").find("div").removeClass("hide").show();
			$("#info").css({"left" : -(wh*i)+"px"});
			}
		}
	//��鲢�ҳ�ʼ��Fade	
	function checkfade(){
		if(!$("#info").find(".hide").html()){
			//alert("ִ���� checkfade ����");
			$("#info").find("div").not($("#info").find("div").eq(i)).addClass("hide");
			$("#info").css({"left" : 0+"px"});
			}
		}
	
	//�Զ�ִ��
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
	
	//��Ӧ����
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
	
	//��ʼ�Զ�
	setInt();	
	
	})