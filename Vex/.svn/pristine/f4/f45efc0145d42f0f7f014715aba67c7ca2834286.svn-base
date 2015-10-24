/*
 * Url preview script 
 * powered by jQuery (http://www.jquery.com)
 * 
 * written by Alen Grakalic (http://cssglobe.com)
 * 
 * for more info visit http://cssglobe.com/post/1695/easiest-tooltip-and-image-preview-using-jquery
 *
 */
 
this.screenshotPreview = function(){	
	/* CONFIG */
		
		xOffset = 10;
		yOffset = 20;
		
		// these 2 variable determine popup's distance from the cursor
		// you might want to adjust to get the right result
		
	/* END CONFIG */
	$(".screenshot").hover(function(e){
		$("body").append("<div id='screenshot'><img src='"+ $(this).attr("rel") +"' /></div>");
		$("#screenshot")
			.css("top",(e.pageY - xOffset) + "px")
			.css("left",(e.pageX + yOffset) + "px")
			.fadeIn("fast");
    },function(){
		$("#screenshot").remove();
    });
	$(".screenshot").mousemove(function(e){
		$("#screenshot")
			.css("top",(e.pageY - xOffset) + "px")
			.css("left",(e.pageX + yOffset) + "px");
	});
	
	
	
};


// starting the script on page load
$(document).ready(function(){
	screenshotPreview();
});