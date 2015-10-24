function SetWinData(index) {
    var shopinfo = Shops_MainStore.getAt(index).get('depotid') + "_" + Shops_MainStore.getAt(index).get('d_name');
    if (TxtShops.getValue().indexOf(shopinfo) < 0)
        TxtShops.append(shopinfo + ";");
    else {
        nowstr = TxtShops.getValue().replace(shopinfo + ";", "");
        TxtShops.setValue(nowstr);
    }
    currentcon = "Load";
}
function ExpandThis(node) {
    node.expand(true);
}
var nodeSeleted = function (node, checked) {
    //选中当前节点
    if (node.attributes.leaf) {
        if (checked) {
            if (TxtSelectedName.getValue().indexOf(node.attributes.qtip) < 0)
                TxtSelectedName.append(node.attributes.qtip + ";");
        }
        else {
            nowstr = TxtSelectedName.getValue().replace(node.attributes.qtip + ";", "");
            TxtSelectedName.setValue(nowstr);
        }
    }
    else {
        //选中所有的子节点
        node.eachChild(function (child) {
            child.ui.toggleCheck(checked);
            child.attributes.checked = checked;
        });
    }
    currentcon = "Load";
    parentChecked(node, checked);
};
var nodeState = function (node) {
    var box = node.getUI().checkbox;
    if (box.checked) {
        return 1;
    } else if (box.indeterminate) {
        return 2;
    } else {
        return 3;
    }
};
//
var siblState = function (node) {
    var state = new Array();
    var firstNode = node.parentNode.firstChild;
    if (!firstNode) {
        return false;
    }
    do {
        state.push(nodeState(firstNode));
        firstNode = firstNode.nextSibling;
    } while (firstNode != null)
    return state;
};
//
var parentState = function (node) {
    var state = siblState(node).join();
    if (state.indexOf("1") == -1 && state.indexOf("2") == -1) {
        return -1;
    } else {
        return 1;
    }
}
var parentChecked = function (node, checked) {
    var parentNode = node.parentNode;
    if (parentNode == null || parentNode.id == '0') {
        return false;
    }
    var checkbox = parentNode.getUI().checkbox;
    if (typeof checkbox == 'undefined')
        return false;
    var check = parentState(node);
    if (check == 1) {
        checkbox.indeterminate = false;
        checkbox.checked = true;
    } else if (check == -1) {
        checkbox.checked = false;
        checkbox.indeterminate = false;
    } else {
        checkbox.checked = false;
        checkbox.indeterminate = true;
    }
    parentChecked(parentNode, checked);
};