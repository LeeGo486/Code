
 // Ʒ���ж�  ��������

 //��������1 ���� ��������
  $(function(){
    		$('#wxxz1').combobox({
    			onChange:function (id){  
    				//alert(id); // ����ά�����ʼ�������������Ϣ
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
     
     

     //�������2  ��������
      $(function(){
        		$('#wxxz2').combobox({
        			onChange:function (id){  
        				//alert(id); // ����ά�����ʼ�������������Ϣ
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
         
     
     //  �ж�����ʽ  ���� Ȩ�޿���     
     //��ͨ�ñ�����ȡ   �˲ִ������� ���β��� ���ƻ�ά������ 
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
		
		 
     
     //�ж���ʽ ���  ����ֻ���ؼ�
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
       