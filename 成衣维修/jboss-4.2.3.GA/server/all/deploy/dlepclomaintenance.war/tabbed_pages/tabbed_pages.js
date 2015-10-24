onload = function() {
	var e, i = 0;
	while (e = document.getElementById('gallery').getElementsByTagName('DIV')[i++]) {
		if (e.className == 'on' || e.className == 'off') {
			e.onclick = function() {
				var getEls = document.getElementsByTagName('DIV');
				for ( var z = 0; z < getEls.length; z++) {
					getEls[z].className = getEls[z].className.replace('show',
							'hide');
					getEls[z].className = getEls[z].className.replace('on',
							'off');
				}
				this.className = 'on';
				var max = this.getAttribute('title');
				document.getElementById(max).className = "show";
				
				var subIframe = document.getElementById('maintenanceParticularInfo');
				if (max == 'particularInfo') {
					
					if (subIframe != null) {
						if (subIframe.contentWindow.document
								.getElementById('isSaveFlag') != null) {
							
							//document.getElementById("guid").value=subIframe.contentWindow.document.getElementById('guid');
							document.getElementById('sendHQ').disabled = false;
							document.getElementById('guid').value = subIframe.contentWindow.document.getElementById('guid').value;
							document.getElementById('dh').value = subIframe.contentWindow.document.getElementById('dh').value;
							//document.getElementById('deleteBill').disabled=true;
							if(subIframe.contentWindow.document.getElementById('dh').value==''){
								document.getElementById('deleteBill').disabled=true;
								document.getElementById('dpPrint').disabled=true;
								document.getElementById('expressPrint').disabled=true;
							}else{
								document.getElementById('deleteBill').disabled=false;
								document.getElementById('dpPrint').disabled=false;
								document.getElementById('expressPrint').disabled=false;
							}
							document.getElementById('dpAppraiseInfo').disabled=true;
							document.getElementById('gkAppraiseInfo').disabled=true;
							
						} else {
							document.getElementById('sendHQ').disabled = true;
							//alert(subIframe.contentWindow.document.getElementById('guid').value);
							document.getElementById('guid').value = subIframe.contentWindow.document.getElementById('guid').value;
							document.getElementById('deleteBill').disabled=true;
							document.getElementById('dpAppraiseInfo').disabled=true;
							document.getElementById('gkAppraiseInfo').disabled=true;
							var zt = subIframe.contentWindow.document.getElementById('ZT').value;
							if(zt=='8'){
								document.getElementById('dpAppraiseInfo').disabled = false;
								
							}
							if(zt=='9'){
								document.getElementById('gkAppraiseInfo').disabled = false;
								//document.getElementById('guid').value = subIframe.contentWindow.document.getElementById('guid').value;
							}
							document.getElementById('dpPrint').disabled=false;
							document.getElementById('expressPrint').disabled=false;
						
						}
						
					}
				}
			
				else if(max=='infolist'){
					document.getElementById('sendHQ').disabled = true;
					document.getElementById('deleteBill').disabled=true;
					document.getElementById('dpAppraiseInfo').disabled=true;
					document.getElementById('gkAppraiseInfo').disabled=true;
					document.getElementById('dpPrint').disabled=true;
					document.getElementById('expressPrint').disabled=true;
				}
				else{
					document.getElementById('sendHQ').disabled = true;
					document.getElementById('deleteBill').disabled=true;
					document.getElementById('dpAppraiseInfo').disabled=true;
					document.getElementById('gkAppraiseInfo').disabled=true;
					document.getElementById('dpPrint').disabled=true;
					document.getElementById('expressPrint').disabled=true;
				}
			}

		}
	}
	
	if(document.getElementById('sendHQFlag')!=null){
		if(document.getElementById('sendHQFlag').value=='1'){
			document.getElementById('sendHQFlag').value='0';
			setTimeout("dpPrint()",1500);
			//dpPrint();
			
		}
	}
	
}