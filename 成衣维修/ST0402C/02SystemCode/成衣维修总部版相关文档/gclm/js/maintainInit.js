  //�ؼ���ʼ��
      $(function(){
    	    //���乫˾
      		$('#ysgs').combogrid({
      			panelWidth:320,
      	 		mode:'remote',
      			idField:'mc',
      			textField:'mc',
      			url:'rest/getYsgs/S2',
      			method:'post',
      			
      			columns:[[
      				{field:'bm',title:'����',width:50},
      				{field:'mc',title:'����',width:70},
      				{field:'lxdh',title:'��ϵ�绰',width:90},
      				{field:'lxr',title:'��ϵ��',width:90}
      		
      			]]
      		});
      		
      		
      		//�ܲ����� ���乫˾
      		$('#zbfh_ysgs').combogrid({
      			panelWidth:310,
      	 		mode:'remote',
      			idField:'mc',
      			textField:'mc',
      			url:'rest/getYsgs/S2',
      			method:'post',
      			columns:[[
      				{field:'bm',title:'����',width:50},
      				{field:'mc',title:'����',width:70},
      				{field:'lxdh',title:'��ϵ�绰',width:90},
      				{field:'lxr',title:'��ϵ��',width:90}
      			]]
      		});
      		
      		//ά��ʱ��2
      	  $('#wxsj2').datebox({
              formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
              parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
              });  
      	 $('#wxsj_gys').datebox({
             formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
             parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
             });  
      	//�۳�ʱ��
      	 $('#scsj').datebox({
             formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
             parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); },
             onSelect: function(date){
            	 if(compareDate($('#scsj').datebox('getValue'),$('#thrq').datebox('getValue'))){
            		 $.messager.alert("��ʾ", "�����۳�ʱ������˻�����֮ǰ");return;
            	 }
             }

             });    
      	 //�˻�����
      	  $('#thrq').datebox({
              formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
              parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
      	  }); 
	      	 var d,date;
	     	  d = new Date();
	     	  date = d.getFullYear() + "-";            
	     	  date = date + (d.getMonth() + 1) + "-";
	     	  date += d.getDate() + " ";     
	     	$('#thrq').datebox('setValue',date)
     	
      	//Ʒ���ж�   
          //��������  ����
        		$('#wxxz1').combobox({
        			onChange:function (id){  
        				 $('#wtd1').combogrid({
        			  			panelWidth:200,
        			  	 		mode:'remote',
        			  			idField:'fcode',
        			  			textField:'fcontent',  	
        			  			url:'rest/getWtd/'+id,
        			  			method:'post',
        			  			onChange:function (idField){  
        			  				$('#qy1').combogrid({
        		    			  			panelWidth:200,
        		    			  	 		mode:'remote',
        		    			  			idField:'fcode',
        		    			  			textField:'fcontent',  	
        		    			  			url:'rest/getQy/'+idField,
        		    			  			method:'post',
        		    			  			onChange:function (idField){  
        		    			  				$('#xxd1').combogrid({
        	    		    			  			panelWidth:200,
        	    		    			  	 		mode:'remote',
        	    		    			  			idField:'fcode',
        	    		    			  			textField:'fcontent',  	
        	    		    			  			url:'rest/getXxd/'+idField,
        	    		    			  			method:'post',
        	    		    			  			columns:[[
        	    		    			  				{field:'fcode',title:'',width:90},
        	    		    			  				{field:'fcontent',title:'',width:90}
        	    		    			  			]]
        	    		    			  		});
        		    			  				
        		    			  			 },
        		    			  			columns:[[
        		    			  				{field:'fcode',title:'',width:90},
        		    			  				{field:'fcontent',title:'',width:90}
        		    			  			]]
        		    			  		});
        		    				
        			  				
        			  			 },
        			  			columns:[[
        			  				{field:'fcode',title:'',width:90},
        			  				{field:'fcontent',title:'',width:90}
        			  			]]
        			  		});
        			 }
        		});

         //�������  ����
            		$('#wxxz2').combobox({
            			onChange:function (id){  
            				 $('#wtd2').combogrid({
            			  			panelWidth:200,
            			  	 		mode:'remote',
            			  			idField:'fcode',
            			  			textField:'fcontent',  	
            			  			url:'rest/getWtd/'+id,
            			  			method:'post',
            			  			onChange:function (idField){  
            			  				$('#qy2').combogrid({
            		    			  			panelWidth:200,
            		    			  	 		mode:'remote',
            		    			  			idField:'fcode',
            		    			  			textField:'fcontent',  	
            		    			  			url:'rest/getQy/'+idField,
            		    			  			method:'post',
            		    			  			onChange:function (idField){  
            		    			  				$('#xxd2').combogrid({
            	    		    			  			panelWidth:200,
            	    		    			  	 		mode:'remote',
            	    		    			  			idField:'fcode',
            	    		    			  			textField:'fcontent',  	
            	    		    			  			url:'rest/getXxd/'+idField,
            	    		    			  			method:'post',
            	    		    			  			columns:[[
            	    		    			  				{field:'fcode',title:'',width:90},
            	    		    			  				{field:'fcontent',title:'',width:90}
            	    		    			  			]]
            	    		    			  		});
            		    			  				
            		    			  			 },
            		    			  			columns:[[
            		    			  				{field:'fcode',title:'',width:90},
            		    			  				{field:'fcontent',title:'',width:90}
            		    			  			]]
            		    			  		});
            		    				
            			  				
            			  			 },
            			  			columns:[[
            			  				{field:'fcode',title:'',width:90},
            			  				{field:'fcontent',title:'',width:90}
            			  			]]
            			  		});
            				
            				
            				
            			 }
            			
            		});

                	
			           
			     //ά��ȷ��
            		$('#iswc').combobox({
            			width:'180',
            		    valueField:'id',
            		    textField:'text',
            		    data:[{
            		        "id":7,
            		        "text":"���"
            		    },{
            		        "id":14,
            		        "text":"δ���"
            		    }]
            		});

            		$('#iswc_gys').combobox({
            			width:'180',
            		    valueField:'id',
            		    textField:'text',
            		    data:[{
            		        "id":7,
            		        "text":"���"
            		    },{
            		        "id":14,
            		        "text":"δ���"
            		    }]
            		});

            		
            		
                // ά����
                	$('#wxr2').combogrid({
          				panelWidth:180,
          	  	 		mode:'remote',
          	  			idField:'fcode',
          	  			textField:'fcontent',  
          	  			url:'rest/getTybmb/wxry',
          	  			method:'post',
          	  			columns:[[
          	  				{field:'fcode',title:'',width:90},
          	  				{field:'fcontent',title:'',width:90}
          	  			]]
          			});
                	
                	$('#gys').combogrid({
          				panelWidth:180,
          	  	 		mode:'remote',
          	  			idField:'fcode',
          	  			textField:'fcontent',  
          	  			url:'rest/getTybmb/gys',
          	  			method:'post',
          	  			columns:[[
          	  				{field:'fcode',title:'',width:90},
          	  				{field:'fcontent',title:'',width:90}
          	  			]]
          			});
                	
                	//�˲ִ�����
              			$('#tccljg').combogrid({
              				panelWidth:180,
              	  	 		mode:'remote',
              	  			idField:'fcode',
              	  			textField:'fcontent',  
              	  			url:'rest/getTybmb/tccljg',
              	  			method:'post',
              	  			columns:[[
              	  				{field:'fcode',title:'',width:90},
              	  				{field:'fcontent',title:'',width:90}
              	  			]]
              			});
              		//���β���
              			$('#zrbm').combogrid({
              				panelWidth:200,
              	  	 		mode:'remote',
              	  			idField:'fcode',
              	  			textField:'fcontent',  
              	  			url:'rest/getTybmb/zrbm',
              	  			method:'post',
              	  			columns:[[
              	  				{field:'fcode',title:'',width:90},
              	  				{field:'fcontent',title:'',width:90}
              	  			]]
              			});
              	 //�ƻ�ά������
              			$('#jhwxts').combogrid({
              				panelWidth:200,
              	  	 		mode:'remote',
              	  			idField:'fcode',
              	  			textField:'fcontent',  
              	  			url:'rest/getTybmb/jhwxts',
              	  			method:'post',
              	  			columns:[[
              	  				{field:'fcode',title:'',width:90},
              	  				{field:'fcontent',title:'',width:90}
              	  			]]
              			});

              	//�ж�����ʽ
                   		$('#pdclfs').combobox({
                   			onChange:function (id){  
                   				
                   				if(id==1){
                   				
                   					$("#tccljg").combogrid('enable');
                   					//$("#thdh").combogrid('enable');
                   					document.getElementById("thdh").readOnly=true;
                   					$("#nx").combobox('disable');
                   					$("#sfsf").combobox('disable');
                   					document.getElementById("sfje").readOnly=true;
                   					document.getElementById("sfnr").readOnly=true;
                   				};
                   				if(id==2){
                   					$("#tccljg").combogrid('disable');
                   					document.getElementById("thdh").readOnly=true;
                   					$("#nx").combobox('disable');
                   					$("#sfsf").combobox('disable');
                   					document.getElementById("sfje").readOnly=true;
                   					document.getElementById("sfnr").readOnly=true;
                   				};
                   				if(id==3){
                   					$("#tccljg").combogrid('disable');
                   					//document.getElementById("thdh").className="output-body";
                   					document.getElementById("thdh").readOnly=true;
                   					$("#nx").combobox('enable');
                   					$("#sfsf").combobox('enable');
                   					document.getElementById("sfje").readOnly=true;
                   					document.getElementById("sfnr").readOnly=true;
                   				}
                   			}
                   		});
              
               //�Ƿ��շ�
                   		$('#sfsf').combobox({
                   			onChange:function (id){  
                   				if(id==1){
                   					document.getElementById("sfje").disabled=false;
                   					document.getElementById("sfnr").disabled=false;
                   				}
                   			}
                   		})   		
                   		
                   		
});

     
          
          
  
