
 // 品鉴判定  部分内容

 //问题描述1 必填 级联下拉
  $(function(){
    		$('#wxxz1').combobox({
    			onChange:function (id){  
    				//alert(id); // 根据维修性质加载问题点相关信息
    				 $('#wtd1').combogrid({
    			  			panelWidth:200,
    			  	 		mode:'remote',
    			  			idField:'fcode',
    			  			textField:'fcontent',  	
    			  			url:'/gclm/rest/getWtd/'+id,
    			  			method:'post',
    			  			onChange:function (idField){  
    			  				$('#qy1').combogrid({
    		    			  			panelWidth:200,
    		    			  	 		mode:'remote',
    		    			  			idField:'fcode',
    		    			  			textField:'fcontent',  	
    		    			  			url:'/gclm/rest/getQy/'+idField,
    		    			  			method:'post',
    		    			  			onChange:function (idField){  
    		    			  				$('#xxd1').combogrid({
    	    		    			  			panelWidth:200,
    	    		    			  	 		mode:'remote',
    	    		    			  			idField:'fcode',
    	    		    			  			textField:'fcontent',  	
    	    		    			  			url:'/gclm/rest/getXxd/'+idField,
    	    		    			  			method:'post',
    	    		    			  			columns:[[
    	    		    			  				{field:'fcode',title:'',width:90},
    	    		    			  				{field:'fcontent',title:'',width:90},
    	    		    			  			]]
    	    		    			  		});
    		    			  				
    		    			  			 },
    		    			  			columns:[[
    		    			  				{field:'fcode',title:'',width:90},
    		    			  				{field:'fcontent',title:'',width:90},
    		    			  			]]
    		    			  		});
    		    				
    			  				
    			  			 },
    			  			columns:[[
    			  				{field:'fcode',title:'',width:90},
    			  				{field:'fcontent',title:'',width:90},
    			  			]]
    			  		});
    				
    				
    				
    			 },
    			
    		});
    	});
     
     

     //问题次因2  级联操作
      $(function(){
        		$('#wxxz2').combobox({
        			onChange:function (id){  
        				//alert(id); // 根据维修性质加载问题点相关信息
        				 $('#wtd2').combogrid({
        			  			panelWidth:200,
        			  	 		mode:'remote',
        			  			idField:'fcode',
        			  			textField:'fcontent',  	
        			  			url:'/gclm/rest/getWtd/'+id,
        			  			method:'post',
        			  			onChange:function (idField){  
        			  				$('#qy2').combogrid({
        		    			  			panelWidth:200,
        		    			  	 		mode:'remote',
        		    			  			idField:'fcode',
        		    			  			textField:'fcontent',  	
        		    			  			url:'/gclm/rest/getQy/'+idField,
        		    			  			method:'post',
        		    			  			onChange:function (idField){  
        		    			  				$('#xxd2').combogrid({
        	    		    			  			panelWidth:200,
        	    		    			  	 		mode:'remote',
        	    		    			  			idField:'fcode',
        	    		    			  			textField:'fcontent',  	
        	    		    			  			url:'/gclm/rest/getXxd/'+idField,
        	    		    			  			method:'post',
        	    		    			  			columns:[[
        	    		    			  				{field:'fcode',title:'',width:90},
        	    		    			  				{field:'fcontent',title:'',width:90},
        	    		    			  			]]
        	    		    			  		});
        		    			  				
        		    			  			 },
        		    			  			columns:[[
        		    			  				{field:'fcode',title:'',width:90},
        		    			  				{field:'fcontent',title:'',width:90},
        		    			  			]]
        		    			  		});
        		    				
        			  				
        			  			 },
        			  			columns:[[
        			  				{field:'fcode',title:'',width:90},
        			  				{field:'fcontent',title:'',width:90},
        			  			]]
        			  		});
        				
        				
        				
        			 },
        			
        		});
      });
         
     
     //  判定助理方式  级联 权限控制     
     //从通用编码中取   退仓处理结果、 责任部门 、计划维修天数 
     $(function(){
			$('#tccljg').combogrid({
				panelWidth:200,
	  	 		mode:'remote',
	  			idField:'fcode',
	  			textField:'fcontent',  
	  			url:'/gclm/rest/getTybmb/tccljg',
	  			method:'post',
	  			columns:[[
	  				{field:'fcode',title:'',width:90},
	  				{field:'fcontent',title:'',width:90},
	  			]]
			});
			$('#zrbm').combogrid({
				panelWidth:200,
	  	 		mode:'remote',
	  			idField:'fcode',
	  			textField:'fcontent',  
	  			url:'/gclm/rest/getTybmb/zrbm',
	  			method:'post',
	  			columns:[[
	  				{field:'fcode',title:'',width:90},
	  				{field:'fcontent',title:'',width:90},
	  			]]
			});
			$('#jhwxts').combogrid({
				panelWidth:200,
	  	 		mode:'remote',
	  			idField:'fcode',
	  			textField:'fcontent',  
	  			url:'/gclm/rest/getTybmb/jhwxts',
	  			method:'post',
	  			columns:[[
	  				{field:'fcode',title:'',width:90},
	  				{field:'fcontent',title:'',width:90},
	  			]]
			});
		});
		
		 
     
     //判定方式 结果  控制只读控件
       $(function(){
        		$('#pdclfs').combobox({
        			onChange:function (id){  
        				if(id==1){
        				
        					$("#tccljg").combogrid('enable');
        					//$("#thdh").combogrid('enable');
        					document.getElementById("thdh").disabled=true;
        					$("#tx").combogrid('disable');
        					$("#sfsf").combogrid('disable');
        					document.getElementById("sfje").disabled=true;
        					document.getElementById("sfnr").disabled=true;
        				};
        				if(id==2){
        					$("#tccljg").combogrid('disable');
        					document.getElementById("thdh").disabled=true;
        					$("#tx").combogrid('disable');
        					$("#sfsf").combogrid('disable');
        					document.getElementById("sfje").disabled=true;
        					document.getElementById("sfnr").disabled=true;
        				};
        				if(id==3){
        					$("#tccljg").combogrid('disable');
        					//document.getElementById("thdh").className="output-body";
        					document.getElementById("thdh").disabled=true;
        					$("#tx").combogrid('enable');
        					$("#sfsf").combogrid('enable');
        					document.getElementById("sfje").disabled=true;
        					document.getElementById("sfnr").disabled=true;
        				}
        				
        			
        			}
        		})
       });
       
       
       $(function(){
        		$('#sfsf').combobox({
        			onChange:function (id){  
        				if(id==1){
        					document.getElementById("sfje").disabled=false;
        					document.getElementById("sfnr").disabled=false;
        				}
        			}
        		})
       });
       