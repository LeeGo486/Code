// JavaScript Document
function jsGrid(g,arr,align){
	var grid = document.getElementById(g);
	var arrs = arr.split('|');
	var aligns = align.split('|');
	var rows = grid.getElementsByTagName("LI");

	for(i=0;i<rows.length;i++){
		var cels = rows[i].getElementsByTagName("DIV");
		for(n=0;n<cels.length;n++){
				cels[n].style.width= arrs[n];
				cels[n].style.textAlign=aligns[n];
		}
	}
}

function jsSelected(object,z){
	if(object.tagName=="INPUT"){
		var b = document.getElementById("grid_body");
		var a = b.getElementsByTagName("*");
		for(i=0;i<a.length;i++){
				var m = i-2;
			if(z){
				if(a[i].tagName=="INPUT"){
					if(a[i].type="checkbox"){
						a[i].checked = object.checked;
						if(object.checked){
							a[m].className="gridSel"
						}else{
							a[m].className=""
						}
						
					}
				}
			}else if(a[i]==object){
					if(object.checked){
						a[m].className="gridSel"
					}else{
						a[m].className=""
					}
			}
		}
	}else{
		var chkbox = object.getElementsByTagName("INPUT");
		if(chkbox[0]) chkbox[0].click();
	}
}
