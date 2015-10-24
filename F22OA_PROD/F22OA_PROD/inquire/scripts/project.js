//----------变样式的------------
function chgStyle(_this,color,background){

if(_this){
		_this.style.color = color;
		_this.style.background = background;
	}
}

//----------格式化表格的样式------------
function jsTable(tab,layout,width,tWidth,align){
	/*
		tab		//需要应用的表格的父ID
		layout		//左右,还是上下结构
		width	//表格宽度
		tWidth	//标头宽度 [上下结构的标头宽度由多个组成] 
		align	//表格位置
	*/

	var table = document.getElementById(tab);
	
	//是否存在
	if(table){
		//table.style.padding="10px";
		//确定该ID里面有Table
		var tabs = table.getElementsByTagName("table");
		if(tabs.length>0){
			//取得该Table下级应为无关的Table
		
			//循环Table
			for(var t=0;t<tabs.length;t++){
					var subtabs = tabs[t].getElementsByTagName("TABLE");
					if(subtabs.length>0){
						for(var g=0;g<subtabs.length;g++){
							subtabs[g].lang="zh";	//将所有table加上标识以便下次识时不将此标签做格式化处理
							var suball = subtabs[g].getElementsByTagName("TD");
								for(var ga=0;ga<suball.length;ga++){
									suball[ga].lang="zh"; //将所有table里面的标签都加上标识以便下次识时不将此标签做格式化处理
								}
						}
					}
				if(tabs[t].lang!="zh"){
					 tabs[t].border="0";
					 tabs[t].style.border="none";
					 tabs[t].cellPadding="5";
					 tabs[t].cellSpacing="1";
					 tabs[t].align=align;
					 tabs[t].style.width=width;
					 tabs[t].style.background="#99bbe8";
					 tabs[t].style.fontSize="12px";
					 tabs[t].style.fontFamily="tahoma";
					 tabs[t].style.margin="10px 0 0 0";
					 tabs[t].style.clear="both";
				}
				
			//确定TR
				var trs = tabs[t].getElementsByTagName("tr");
				if(trs.length>0){
				
				//循环Tr
					for(var r=0;r<trs.length;r++){
					
					//确定TD
						var tds = trs[r].getElementsByTagName("td");
						if(tds.length>0){
						//循环TD
							for(var d=0;d<tds.length;d++){
								if(tds[d].lang!="zh"){
									if(r==0&&layout=='tm'){
										if(tWidth!=''){
											var tw = tWidth.split("|");
											if(d<tw.length){
												//alert(tw[d])
												tds[d].style.width=''+tw[d]+'';	//标头宽度（多个值，由"|"符号分开）
											}
										}
										//上下结构的标头
										tds[d].style.background="#d9e5f4";						//标头背景色
										tds[d].style.borderTop="solid 1px #f0f5fa";		//反光效果
										tds[d].style.borderLeft="solid 1px #f0f5fa";	//反光效果
										tds[d].style.textAlign="center";		//字体居中
										tds[d].style.color="#15428b";		//标头字体颜色
										
									}else if((d==0 || tds[d].className=='jsTitle' )&&layout=='lr'){
									
									//左右结构的标头
										tds[d].style.background="#d9e5f4";						//标头背景色
										tds[d].style.borderTop="solid 1px #f0f5fa";		//反光效果
										tds[d].style.borderLeft="solid 1px #f0f5fa";	//反光效果
										tds[d].style.color="#15428b";		//标头字体颜色
										tds[d].style.width=tWidth;		//标头宽度
										var thtml = tds[d].innerHTML.toUpperCase();		//将冒号转为全角的（这样比较标准点）
										if(thtml.indexOf(":")>0&&thtml.indexOf("<INPUT")<0){	//过虑掉带按钮的。
										tds[d].innerHTML = tds[d].innerHTML.replace(":","：");
										}
										
									}else{
										tds[d].style.background="#FFF";
									}
								}
								
							}
						}
					}
				}
			}
		}
	}
}

