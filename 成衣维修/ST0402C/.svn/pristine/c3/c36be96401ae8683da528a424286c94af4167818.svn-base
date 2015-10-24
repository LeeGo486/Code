<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>菜单注册</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/dojo/resources/dojo.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/dijit/themes/tundra/tundra.css">
	<script type="text/javascript" src=""></script>
	
	<script type="text/javascript" src="<%=request.getContextPath() %>/dojo/dojo.js"></script>

	
	
	</head>
<script type="text/javascript">
	djConfig="parseOnLoad: true, isDebug: true";
	
	dojo.require("dijit.Tree");
	dojo.require("dojo.data.ItemFileWriteStore");
	dojo.require("dijit.tree.ForestStoreModel");
	dojo.require("dojox.data.JsonRestStore");

	//TreeStore
	var store = new dojo.data.ItemFileWriteStore( {
		url : '',
		labelAttribute : "menuname"

	});

	//Tree
	var tree = new dijit.Tree( {
		region : 'leading',
		splitter : true,
		style : 'width:140px;',
		allowMultiState : true,
		branchIcons : true,
		nodeIcons : true,
		openOnClick : true,
		//persist: false,
		model : new dijit.tree.ForestStoreModel( {
			store : store,
			rootId : "0",
			rootLabel : "ROOT",
			childrenAttrs : [ "children" ]
		})

	});

	//节点点击事件

	tree.set("onClick", function(item, node, event) {
		dojo.xhrPost( {
			url : 'url',
			sync : true,
			handleAs : 'json',
			content : {
				pid : item.id
			//点击的节点ID
			},
			load : function(response) {
				var data = response.items;
				//加载子节点
			for ( var i = 0; i < data.length; i++) {
				store.fetchItemByIdentity( {
					identity : data[i].id,
					onItem : function(i) {
						var parent = {
							parent : item,
							attribute : 'children'
						};
						store.newItem( {
							id : data[i].id, //节点ID
							name : data[i].name
						//节点名称
								}, parent); //给父节点添加子节点
				}
				});
			}
		},
		erro : function(error) {
		}
		});
	});
</script>

	<body>
		
		<div dojoType="dijit.Tree" model="booksDataStore " 	
     	persist="false" id="booksDataTree">
		
		
		This is my JSP page.
		<br>
	</body>
</html>
