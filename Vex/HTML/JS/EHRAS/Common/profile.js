//发展历程的JS代码
$(function(){
	$(".right").click(function(){
		turnright();
	});
	
	$(".left").click(function(){
		turnleft();
	});
	
	$("#profile .show").touchwipe({
		 wipeLeft: function() { turnright(); },
		 wipeRight: function() { turnleft(); },
		 wipeUp: function() {  },
		 wipeDown: function() {  },
		 min_move_x: 20,
		 min_move_y: 20,
		 preventDefaultEvents: true
	});
});

function turnleft(){
	pid = $(".show").attr("rel");
	total = $("#profile").attr("rel");
	pid = parseInt(pid)-1;
	total = parseInt(total);
	if(pid<=total && pid>0){
		getn(pid);
	}
	if(pid<total){
		$(".right").removeClass("gray");
	}
	if(pid==1){
		$(".left").addClass("gray");
	}
}

function turnright(){
	pid = $(".show").attr("rel");
	total = $("#profile").attr("rel");
	pid = parseInt(pid)+1;
	total = parseInt(total);
	if(pid<=total && pid>0){
		getn(pid);
	}
	if(pid==total){
		$(".right").addClass("gray");
	}
	if(pid>1){
		$(".left").removeClass("gray");
	}
}

//获取或修改放大图
function getn(pid){
	$(".show").attr("rel",pid);
	$.get("/ports/profileupdown/"+pid, {},function(result){
		result = $.parseJSON(result);
		$(".show img").attr("src",result.pic);
		$(".show img").attr("title",result.title);
	});
}
