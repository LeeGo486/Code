  //控件初始化
      $(function(){
    	    //运输公司
      		$('#ysgs').combogrid({
      			panelWidth:320,
      	 		mode:'remote',
      			idField:'mc',
      			textField:'mc',
      			url:'/gclm/rest/getYsgs/S2',
      			method:'post',
      			
      			columns:[[
      				{field:'bm',title:'编码',width:50},
      				{field:'mc',title:'名称',width:70},
      				{field:'lxdh',title:'联系电话',width:90},
      				{field:'lxr',title:'联系人',width:90}
      		
      			]]
      		});
      		
      		
      		//总部发货 运输公司
      		$('#zbfh_ysgs').combogrid({
      			panelWidth:310,
      	 		mode:'remote',
      			idField:'mc',
      			textField:'mc',
      			url:'/gclm/rest/getYsgs/S2',
      			method:'post',
      			columns:[[
      				{field:'bm',title:'编码',width:50},
      				{field:'mc',title:'名称',width:70},
      				{field:'lxdh',title:'联系电话',width:90},
      				{field:'lxr',title:'联系人',width:90}
      			]]
      		});
      		
      		//维修时间2
      	  $('#wxsj2').datebox({
              formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
              parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
              });  
      	 $('#wxsj_gys').datebox({
             formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
             parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
             });  
      	//售出时间
      	 $('#scsj').datebox({
             formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
             parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); },
             onSelect: function(date){
            	 if(compareDate($('#scsj').datebox('getValue'),$('#thrq').datebox('getValue'))){
            		 $.messager.alert("提示", "请检查售出时间必在退回日期之前");return;
            	 }
             }

             });    
      	 //退回日期
      	  $('#thrq').datebox({
              formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
              parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
      	  }); 
	      	 var d,date;
	     	  d = new Date();
	     	  date = d.getFullYear() + "-";            
	     	  date = date + (d.getMonth() + 1) + "-";
	     	  date += d.getDate() + " ";     
	     	$('#thrq').datebox('setValue',date);
     	
      	//品检判定   
          //问题主因  级联
        		$('#wxxz1').combobox({
        			onChange:function (id){  
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
        	    		    			  			onChange:function (idField){
        	    		    			  				var nx = $('#nx').combobox('getValue');
        	    		    			  				var sfsf = $('#sfsf').combobox('getValue');
        	    		    			  				if(nx!=undefined && nx=='0' && sfsf !=undefined && sfsf=='1'){
        	    		    			  					getWxjefw();
        	    		    			  				}
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
        		    				
        			  				
        			  			 },
        			  			columns:[[
        			  				{field:'fcode',title:'',width:90},
        			  				{field:'fcontent',title:'',width:90}
        			  			]]
        			  		});
        			 }
        		});

         //问题次因  级联
            		$('#wxxz2').combobox({
            			onChange:function (id){  
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

                	
			           
			     //维修确认
            		$('#iswc').combobox({
            			width:'180',
            		    valueField:'id',
            		    textField:'text',
            		    data:[{
            		        "id":7,
            		        "text":"完成"
            		    },{
            		        "id":14,
            		        "text":"未完成"
            		    }]
            		});

            		$('#iswc_gys').combobox({
            			width:'180',
            		    valueField:'id',
            		    textField:'text',
            		    data:[{
            		        "id":7,
            		        "text":"完成"
            		    },{
            		        "id":14,
            		        "text":"未完成"
            		    }]
            		});

            		
            		
                // 维修人
                	$('#wxr2').combogrid({
          				panelWidth:180,
          	  	 		mode:'remote',
          	  			idField:'fcode',
          	  			textField:'fcontent',  
          	  			url:'/gclm/rest/getTybmb/wxry',
          	  			method:'post',
          	  			columns:[[
          	  				{field:'fcode',title:'',width:90},
          	  				{field:'fcontent',title:'',width:90}
          	  			]]
          			});
                	
                	/*$('#gys').combogrid({
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
          			});*/
                	
                	//退仓处理结果
              			$('#tccljg').combogrid({
              				panelWidth:180,
              	  	 		mode:'remote',
              	  			idField:'fcode',
              	  			textField:'fcontent',  
              	  			url:'/gclm/rest/getTybmb/tccljg',
              	  			method:'post',
              	  			columns:[[
              	  				{field:'fcode',title:'',width:90},
              	  				{field:'fcontent',title:'',width:90}
              	  			]]
              			});
              		//责任部门
              			$('#zrbm').combogrid({
              				panelWidth:200,
              	  	 		mode:'remote',
              	  			idField:'fcode',
              	  			textField:'fcontent',  
              	  			url:'/gclm/rest/getTybmb/zrbm',
              	  			method:'post',
              	  			columns:[[
              	  				{field:'fcode',title:'',width:90},
              	  				{field:'fcontent',title:'',width:90}
              	  			]]
              			});
              	 //计划维修天数
              			$('#jhwxts').combogrid({
              				panelWidth:200,
              	  	 		mode:'remote',
              	  			idField:'fcode',
              	  			textField:'fcontent',  
              	  			url:'/gclm/rest/getTybmb/jhwxts',
              	  			method:'post',
              	  			columns:[[
              	  				{field:'fcode',title:'',width:90},
              	  				{field:'fcontent',title:'',width:90}
              	  			]]
              			});

              	//判定处理方式
                   		$('#pdclfs').combobox({
                   			onChange:function (id){  
                   				
                   				if(id==1){
                   				
                   					$("#tccljg").combogrid('enable');
                   					//$("#thdh").combogrid('enable');
                   					document.getElementById("thdh").readOnly=true;
                   					$("#nx").combobox('disable');
                   					$("#sfsf").combobox('disable');
                   					document.getElementById("wxjefw").readOnly=true;
                   					document.getElementById("sfnr").readOnly=true;
                   				};
                   				if(id==2){
                   					$("#tccljg").combogrid('disable');
                   					document.getElementById("thdh").readOnly=true;
                   					$("#nx").combobox('disable');
                   					$("#sfsf").combobox('disable');
                   					document.getElementById("wxjefw").readOnly=true;
                   					document.getElementById("sfnr").readOnly=true;
                   				};
                   				if(id==3){
                   					$("#tccljg").combogrid('disable');
                   					//document.getElementById("thdh").className="output-body";
                   					document.getElementById("thdh").readOnly=true;
                   					$("#nx").combobox('enable');
                   					$("#sfsf").combobox('enable');
                   					//默认维修为内修，是否收费自动为是，并获取维修金额范围。
                   					$("#sfsf").combobox('setValue','1');
                   					getWxjefw();
                   					
                   					document.getElementById("wxjefw").readOnly=true;
                   					document.getElementById("sfnr").readOnly=true;
                   				}
                   			}
                   		});
              
                   	 
                   	//是否内修
                   		$('#nx').combobox({
                   			onChange:function (id){  
                   				if(id==0){
                   					$("#sfsf").combobox('setValue','1');
                   				}else{
                   					var sfsf = $("#sfsf").combobox('getValue');
                   					if(sfsf=='1'){
                   						getWxjefw();
                   					}
                   				}
                   			}
                   		});   	
                   		
                   		
                   		//是否收费
                   		$('#sfsf').combobox({
                   			onChange:function (id){  
                   				if(id==1){
                   					getWxjefw();
                   					document.getElementById("wxjefw").disabled=false;
                   					document.getElementById("sfnr").disabled=false;
                   				}
                   				if(id==0){
                   					//$('#wxjefw').attr('value','');
                   					getWxjefw();
                   					document.getElementById("wxjefw").disabled=true;
                   					document.getElementById("sfnr").disabled=true;
                   				}
                   			}
                   		});   	
                   		
                   		
});

 
      function initZzwxd(){
    	  $('#zzwxd').combogrid({
	  			panelWidth:200,
	  	 		mode:'remote',
	  			idField:'fcode',
	  			textField:'fcontent',  	
	  			url:'/gclm/rest/getTybmb/zzwxd',
	  			method:'post',
	  			columns:[[
	  				{field:'fcode',title:'',width:90},
	  				{field:'fcontent',title:'',width:90}
	  			]],
	  			onChange:function (idField){
	  				$.post(	'/gclm/rest/getTybmb/sfje',
							{'parentCode':idField},function(queryfilter) {
							
								var sfje = eval("(" + queryfilter + ")");
								if(sfje.length>0){
									if(null!=sfje[0].fcontent){$('#nxsfje').attr('value',sfje[0].fcontent);};
								}
							}, 'text').error(function() {
							$.messager.alert("提示", "信息获取失败");});	
	  			}
	  		});
      }
          
   
     
  
