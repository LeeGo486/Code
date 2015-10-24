/**
 * 上传文件( <input id="uploadedFile" name="uploadedFile" type="file")
 * @param formId 表单ID
 * @param savepath 保存文件地址
 * @param filename 文件名(document.getElementById('uploadedFile').value)
 */
function fileUtil_UploadFile(formId,savepath,filename,datagridId,billType,createName, isFileLinkId) {
	$('#'+formId).form('submit', {
		async: false,
		url:'/'+basedate_getexpenseServer()+'/resteasy/file/upload?filename='+encodeURIComponent(filename)+'&savepath='+encodeURIComponent(savepath),
		success : function(result) {
				//alert(result);
				//alert(result.substr(0,7));
				//alert(result.substr(8,26));
				if(result.substr(0,7)=='SUCCESS'){
					result = result.substr(8,26);
					$('#'+datagridId).datagrid('appendRow',{
						fileID:result,//文件编号
						billType:billType,//单据类型
						fileName:filename,
						filePath:savepath,
						createDate: dateUtil_dateFomaterC(new Date(),'-'),
						createName:createName
					}); 
					
					fileUtil_changeFJS(datagridId, isFileLinkId);
					return true;
				}else{
					return false;
				}
		},
		error : function(){
			alert("error");
			return false;
		}
	});
	return true;
}

/**
 * 文件下载
 * @param filename
 * @param path
 * @returns {String}
 */
function fileUtil_DownloadFile(filename,path){
	var url='/'+basedate_getexpenseServer()+'/resteasy/file/download?filename='+path+filename;
	$.ajax({
 	    url:url,
 	    type: 'get',
 	    async: false,
 	    //dateType:'json',
 	    contentType:'application/json;charset=UTF-8', 
 	    success: function(result) {
 	    	alert(result);
 	    },
 	    error:function(){
 	    	alert('下载文件error');
 	    }
 	});
	return url;
}


/**
 * 文件下载1
 * @param filename
 * @param path
 * @returns {String}
 */
function fileUtil_DownloadFile1(filename,path){
	var url='/'+basedate_getexpenseServer()+'/resteasy/file/download?filePath='+path+filename +'&fileName='+filename 
	+'&s='+new Date().getTime();  
	var openPara = "left=200 ,top=200, Toolbar=no,Location=no," 
		+ "Direction=no,Resizeable=no,width=100,height=100" ; 
    window.open(url,"_blank", openPara); 
}




/***********************************************************************
 *  通过html导出excel方法 
 *  DLY
 *  2013-08-17
 */ 
function fileUtil_doFileExport(inName, inStr) {
    var xlsWin = null;   
    var openPara = "left=200 ,top=200, Toolbar=no,Location=no," 
    			+ "Direction=no,Resizeable=no,width=100,height=100" ; 
    xlsWin = window.open("","_blank", openPara);  
    //xlsWin = window.showModalDialog("",window,"dialogHeight:100px; dialogWidth: 100px; dialogTop: 100px; dialogLeft: 100px; resizable: no; status: no;scroll:no");
    xlsWin.document.write(inStr);
    xlsWin.document.close();
    xlsWin.document.execCommand('Saveas', false, inName);
    xlsWin.focus();
    xlsWin.close(); 
}
  



/**
 * 附件数
 */
function fileUtil_changeFJS(datagridId, isFileLinkId){
	var rownums = $('#'+datagridId).datagrid('getRows').length;
	//alert(rownums);
	$('#'+isFileLinkId).attr('value',rownums);
} 