
CommonKendo = {
		
		/*
		 * Kendo UI TreeView get TreeToJson
		 * 
		 * 트리뷰의 전체 노드의 데이터를 JSON 으로 변환
		 * 
		 */
		getTreeToJson : function (treeview) {
			var nodes = treeview.dataSource.view();
			return JSON.stringify(CommonKendo.getTreeNodes(nodes));
		},

		getTreeNodes : function (nodes) {
			var node, childNodes;
		    var _nodes = [];

		    for (var i = 0; i < nodes.length; i++) {
		      node = nodes[i];
		      //if (node.checked) {
		      _nodes.push(node);
		      //}
		        
		      // to understand recursion, first
		      // you must understand recursion
		      if (node.hasChildren) {
		    	  childNodes = CommonKendo.getTreeNodes(node.children.view());
		        if (childNodes.length > 0){
		        	_nodes = _nodes.concat(childNodes);
		        }
		      }

		    }

		    return _nodes;

     	},
     	
     	/*
     	 * Kendo UI TreeView get TreeCheckedToJson
     	 * 
     	 * 트리뷰의 체크된 노드의 데이터를 JSON 으로 변환
     	 * 
     	 */
		getTreeCheckedToJson : function (treeview) {
			var nodes = treeview.dataSource.view();
			return JSON.stringify(CommonKendo.getTreeCheckedNodes(nodes));
		},

		getTreeCheckedNodes : function (nodes) {
			var node, childNodes;
		    var _nodes = [];

		    for (var i = 0; i < nodes.length; i++) {
		      node = nodes[i];
		      if (node.checked) {
		      _nodes.push(node);
		      }
		        
		      // to understand recursion, first
		      // you must understand recursion
		      if (node.hasChildren) {
		    	  childNodes = CommonKendo.getTreeCheckedNodes(node.children.view());
		        if (childNodes.length > 0){
		        	_nodes = _nodes.concat(childNodes);
		        }
		      }

		    }
		    return _nodes;

     	},
     	/* 
     	 * grid checkbox 에서 check된 item 리스트 가져오기
     	 * 
     	 * */
     	getChecked : function (grid) {
     		var nodes = grid.dataSource.view();
     		var node;
     		var checkItems = [];
     		
     		for (var i = 0; i < nodes.length; i++) {
     			node = nodes[i];
     			console.log("node.checked : " + node.checked);
     			if (node.checked == "checked") {
     				checkItems.push(node);
     			}
     		 }
     		return checkItems;
     	},
     	/*
     	 * grid checkbox checked 또는 리셋
     	 */
     	setChecked : function (grid, obj) {
     		var checked = obj.checked,
    		row = $(obj).closest("tr"),
	     	//grid = $("#grid").data("kendoGrid"),
	     	dataItem = grid.dataItem(row);
		         
		    if (checked) {
		    	dataItem.checked = "checked";		
		    
		    		row.addClass("k-state-selected");
		   	} else {
		   		dataItem.checked = "";
		   	
		    		row.removeClass("k-state-selected");
		    }
     	}
		
		
		
};