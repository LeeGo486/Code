/*
   *
   *  author: keliro
   *  email: keliro_lin@hotmail.com
   *
   */

/*****************************
*                            *
*        可重载方法定义       *
*                            *	
******************************/

function gtCheckParameter(t, form){
	return true;
}

function gtPreSetParameter(t, form){
}

function gtSavePreSetParameter(t, form){
	gtPreSetParameter(t, form);
}


/*****************************
*                            *
* 可编辑GridTable对象定义    *
*                            *	
******************************/
function GtEditTable(id){
	GtTable.call(this, id);
	
	this.inputTable = null;
	this.inputRow = null;
	this.inputRowObject = new Array();
//	this.form = null;
	
	this._newRows = new Array();
	this._changedRows = new Array();

	this._createActionUri = null;	
	this._saveActionUri = null;
	this._moveActionUri = null;	
	this._createParameterXml = null;	
	this._saveParameterXml = null;	
		
	
	this._movable = true;

	document.body.onbeforeunload = _geIsNeedSave;
}

_p = GtEditTable.prototype = new GtTable;
_super = GtTable.prototype;

_p.enableMoveLine = function(){
	this._movable = true;
}

_p.setCreateActionUri = function(uri){
	this._createActionUri = uri;
}


_p.setSaveActionUri = function(uri){
	this._saveActionUri = uri;
}

_p.setMoveActionUri = function(uri){
	this._moveActionUri = uri;
}

_p.setCreateParameterXml = function (xml){
	this._createParameterXml = xml;
}

_p.setSaveParameterXml = function (xml){
	this._saveParameterXml = xml;
}

_p._getPageInfo = function (){
	_super._getPageInfo.call(this);
	
	this.inputTable = this.outerDiv.childNodes[1];
	this.inputTable.style.display = "none";
	this.inputRow = this.inputTable.tBodies[0].rows[0];
	this._initInputRowObject();
}

_p.initContentDIV = function(){
	_super.initContentDIV.call(this);
	
	return this.contentDiv;
}

_p._initInputRowObject = function(){
	var obj;
	var cell;
	var input, sel;
	_gtRemoveRowSpaceElement(this.inputRow);
	for(var i=0; i<this.inputRow.cells.length; i++){
		obj = new Object();
		cell = this.inputRow.cells[i];
		obj.html = cell.innerHTML;
		input = _gtFindChildByTagName(cell, "INPUT");
		sel = _gtFindChildByTagName(cell, "SELECT");
		if(input != null && (input.type == "text" || input.type == "checkbox")){
			if(input.type == "text"){
				if(input.selectClassName != null && input.selectClassName != "")
					obj.inputType = "CHOICE";	
				else
					obj.inputType = "INPUT";
			}else
				obj.inputType = "CHECKBOX";
			obj.name = input.name;
			obj.inputHtml = input.outerHTML + cell.innerText;
			obj.otherHtml = _gtHTMLWithOutTextAndTag(cell, "INPUT");
		}else if(sel != null){
			obj.inputType = "SELECT";
			obj.name = sel.name;
			obj.inputHtml = sel.outerHTML + _gtGetInnerText(cell);
			obj.otherHtml = _gtHTMLWithOutTextAndTag(cell, "SELECT");
		}else{
			obj.inputType = "TEXT";
			obj.inputHtml = cell.innerText;
			obj.otherHtml = _gtHTMLWithOutText(cell);
		
		}
		this.inputRowObject[this.inputRowObject.length] = obj;
	}
}

_p.registEvent = function (e){
	_super.registEvent.call(this,e);

	if(this._movable == true){
		document.attachEvent("onmousemove", _geMoveRowMouseMoveEvent);
		document.attachEvent("onmouseup", _geMoveRowMouseUpEvent);	
	}
}

_p._leftRowAttachEvent = function(row){
	_super._leftRowAttachEvent.call(this,row);
	if(this._movable == true){
		row.attachEvent("onmousedown", _geLeftHeadRowMouseDownEvent);
		row.attachEvent("onmouseover", _geLeftHeadRowMouseOverEvent);
		row.attachEvent("onmouseout", _geLeftHeadRowMouseOutEvent);	
	}
}

_p._rowAttachEvent = function(row){
	_super._rowAttachEvent.call(this,row);
//	row.attachEvent("onfocusout", _geContentRowFocusOutEvent);
}

// 为移动行创建可移动的新Object
_p._geCreateMoveObject = function (tr){
	var str = "";
	str += '<label class="grid-title" style="position:absolute;z-index:10;display:none;width:' 
		+ this.position.leftHeadDivWidth + 'px;height:' 
		+ this.position.tdHeight + 'px;">' 
		+ tr.innerText + '</label>';
	var obj = _gtCreateElementWithHTML(str);
	document.body.appendChild(obj);
	return obj;
}

GtEditTable._changeRowWithRowHtml = function (row, html){
	var newrow = _gtCreateElementWithHTML(html);
	for(var i=0; i<row.cells.length; i++)
		row.cells[i].innerHTML = newrow.childNodes[0].childNodes[i].innerHTML;
}

GtEditTable._initRowObject = function(row){
	var obj;
	row.rowObject = new Array();
	for(var i=0; i<row.cells.length; i++){
		obj = new Object();
	//	obj.otherHtml = _gtHTMLWithOutText(row.cells[i]);		
		obj.otherHtml = _gtHTMLWithOutText(row.cells[i]);
		row.rowObject[row.rowObject.length] = obj;
	}
}

GtEditTable._changeSelectOption = function(sel, text){
	var v = "NULL";
	for(var i=0; i<sel.options.length; i++){
		sel.options[i].selected = false;
		if(sel.options[i].text == text){
			sel.options[i].selected = true;
			v = sel.options[i].value;
		}
	}
	return v;
}

GtEditTable._getSelectValue = function(sel){
	return sel.options[sel.selectedIndex].text;
}

GtEditTable._findChildTextInputObject = function(obj){
	var inputs = _gtFindChildsByTagName(obj, "INPUT");
	for(var i=0; i<inputs.length; i++){
		if(inputs[i].type == "text")
			return inputs[i];
	}
	return null;
}

GtEditTable._findChildCheckboxInputObject = function(obj){
	var inputs = _gtFindChildsByTagName(obj, "INPUT");
	for(var i=0; i<inputs.length; i++){
		if(inputs[i].type == "checkbox")
			return inputs[i];
	}
	return null;
}

GtEditTable._getInputCellValue = function(cell){
	var input, sel;
	input = GtEditTable._findChildTextInputObject(cell);
	if(input != null)
		return input.value;
	input = GtEditTable._findChildCheckboxInputObject(cell);
	if(input != null)
		return input.checked;
	sel = _gtFindChildByTagName(cell, "SELECT");
	if(sel != null)
		return GtEditTable._getSelectValue(sel);
	return gtTrim(cell.innerText);
}

GtEditTable._geGetInputHtmlWithValue = function(obj, cell){
	var d = _gtCreateDivElementWithHTML(obj.html);
	
	var input;
	
	if(obj.inputType == "INPUT"){
		input = _gtFindChildByTagName(d, "INPUT");
		input.className = 'grid-input';
		input.value = cell.innerText;
	}else if(obj.inputType == "CHECKBOX"){
		input = _gtFindChildByTagName(d, "INPUT");
		input.className = 'grid-input';
		var oldInput = _gtFindChildByTagName(cell, "INPUT");
		if(oldInput == null){
			if(cell.innerText == "true")
				input.checked = true;				
		}else if(oldInput.checked == true)
			input.checked = true;		
	}else if(obj.inputType == "CHOICE"){
		input = _gtFindChildByTagName(d, "INPUT");
		input.className = 'grid-choice-input';
		input.value = cell.innerText;
		stSetObjectId(input);
	}else if(obj.inputType == "SELECT"){
		input = _gtFindChildByTagName(d, "SELECT");
		input.className = 'grid-select';
		GtEditTable._changeSelectOption(input, cell.innerText);
	}
	
	return d.innerHTML;
}

GtEditTable._geGetOldTdInputHtml = function(html, cell, mod){
	var d = _gtCreateDivElementWithHTML(html);
	var c;
	
	var cs1 = _gtFindChildsCheckBox(d);
	var cs2 = _gtFindChildsCheckBox(cell);
	
	var i = 0;
	var j = 0;
	for(i=0; i<cs1.length; i++){
		if(cs2[i].checked == true)
			cs1[i].checked = true;
	}
	
	return d.innerHTML;
}

_p._createEditableRowHtml = function(row){
	/*
	var str = "<tr><form>";
	for(var i=0; i<row.cells.length; i++){
		str += '<td>';
		str += '<label class="grid-label" style="width:' + (this.titleWidth[i]-1) + 'px;height:' 
			+ this.position.tdHeight + 'px;text-align:' 
			+ this.titleAlign[i] + ';">';
		
		
		str += GtEditTable._geGetOldTdInputHtml(row.rowObject[i].otherHtml, row.cells[i], this.inputRowObject[i]);	
		if(this.inputRowObject[i].inputType == "TEXT")
//			str += row.cells[i].innerText;
			str += GtEditTable._getInnerText(row.cells[i].childNodes[0]);
		str += GtEditTable._geGetInputHtmlWithValue(this.inputRowObject[i], row.cells[i]);
	//	str += row.rowObject[i].otherHtml;

		str += '</label>';
		str += '</td>';
	}
	str += '</form></tr>';

	return GtEditTable._restoreOldRowValue(row, str);
	*/
	var str = "<div><form>";
	for(var i=0; i<row.cells.length; i++){
		str += '<label>';
		str += GtEditTable._geGetOldTdInputHtml(row.rowObject[i].otherHtml, row.cells[i], this.inputRowObject[i]);	
		if(this.inputRowObject[i].inputType == "TEXT")
			str += GtEditTable._getInnerText(row.cells[i]);
		str += GtEditTable._geGetInputHtmlWithValue(this.inputRowObject[i], row.cells[i]);
		str += '</label>';
	}
	str += '</form><div>';

	return GtEditTable._restoreOldRowValue(row, str);
}

GtEditTable._getInnerText = function (obj){
	if(obj.hasChildNodes() == false)	
		return obj.innerText;
	var ret = "";
	for(var i=0; i<obj.childNodes.length; i++){
		if(obj.childNodes[i].nodeType == 1 && obj.childNodes[i].tagName == "BUTTON"){
			continue;
		}
		if(obj.childNodes[i].nodeType == 1)
			ret += obj.childNodes[i].innerText;
		else if(obj.childNodes[i].nodeType == 3)
			ret += obj.childNodes[i].data;
	}
	return ret;
}

GtEditTable._restoreOldRowValue = function(row, str){
	var e, ne;
	var nrow = _gtCreateElementWithHTML(str);
	var nform = nrow.childNodes[0];
	var form = row.form;

	for(var i=0; i<form.elements.length; i++){
		e = form.elements[i]
		if(e.tagName == "INPUT" && e.type == "hidden" && e.value != ""){
			for(var j=0; j<nform.elements.length; j++){
				ne = nform.elements[j];
				if(ne.name == e.name)
					ne.value = e.value;
			}
		}
		if(e.tagName == "INPUT" && e.type == "checkbox")
			for(var j=0; j<nform.elements.length; j++){
				ne = nform.elements[j];
				if(ne.name == e.name)
					ne.checked = e.checked;
			}		
	}
	return nrow.outerHTML;
}

_p._restoreInputRow = function(row){
	var node, tnode, label;
	
	for(var r=0; r<row.cells.length; r++){
		label = row.cells[r];
		if(label.hasChildNodes() == false)
			continue;
		for(var i=0; i<label.childNodes.length; i++){
			node = label.childNodes[i];
			if(node.tagName == "INPUT" && node.type == "text"){
				tnode = _gtCreateTextNode(node.value);
				node.parentNode.replaceChild(tnode, node);
				i--;
				continue;				
			}
			if(node.tagName == "SELECT"){
				tnode = _gtCreateTextNode(GtEditTable._getSelectValue(node));
				node.parentNode.replaceChild(tnode, node);
				i--;
				continue;		
			}
			if(node.tagName == "BUTTON" && node.ischoice == "true"){
				node.parentNode.replaceChild(tnode, node);
				i--;
				continue;		
			}
		}
	}
}


_p._row2input = function(row){
	if(row.rowObject == null)
		GtEditTable._initRowObject(row);

	GtEditTable._changeRowWithRowHtml(row, this._createEditableRowHtml(row)); 
	_geUniqRowElement(row);
}

_p._input2row = function(row){
	this._rowChangedTest(row);
	this._restoreInputRow(row);
}

_p._rowChangedTest = function(row){
	for(var i=0; i<row.cells.length; i++)
		_geCellChangeTest(row.cells[i]);
}

_geInputObject = null;
_p.selectRow = function(row){
	_super.selectRow.call(this, row);
	
	this._row2input(row);
	
	if(row._oldValueInited == null || row._oldValueInited == false)
		GtEditTable._initRowOldValue(row);

	for(var i=0; i<row.cells.length; i++)
		GtEditTable._cellInputAttachEvent(row.cells[i]);
}

GtEditTable._cellInputAttachEvent = function(cell){
	var input, sel;
	input = GtEditTable._findChildTextInputObject(cell);
	if(input != null){
		input.attachEvent("onblur", _geCellChangeEvent);
		input.attachEvent("onkeyup", _geCellChangeKeyUpEvent);
		input.attachEvent("onfocus", _geCellChangeEvent);
	}
	input = GtEditTable._findChildCheckboxInputObject(cell);
	if(input != null){
		input.attachEvent("onclick", _geCellChangeEvent);
	}	
	sel = _gtFindChildByTagName(cell, "SELECT");
	if(sel != null)
		sel.attachEvent("onchange", _geCellChangeEvent);
}

GtEditTable._initRowOldValue = function (row){
	for(var i=0; i<row.cells.length; i++){
		row.cells[i]._oldValue = GtEditTable._getInputCellValue(row.cells[i]);
		row.cells[i]._status = GtEditTable.UNCHANGED;
	}
	row._oldValueInited = true;
}

function _geInputObjectFocus(){
	_geInputObject.focus();
}

_p.unSelectRow = function(row){
	_super.unSelectRow.call(this, row);
	
	this._input2row(row);
}

_p._gtChangeRowStyle = function(obj, type){
	_super._gtChangeRowStyle.call(this, obj, type);
	
	if(type == "DOWN"){
		var inputs = _gtFindChildsByTagName(obj, "INPUT");
		var sels = _gtFindChildsByTagName(obj, "SELECT");
		
		for(var i=0; i<inputs.length; i++){
			if(inputs[i].type != "text")
				continue;
				inputs[i].parentNode.style.borderBottom = "1px solid black";
				inputs[i].style.backgroundColor = GtTable.SELECTCOLOR;
		}
			
		for(var i=0; i<sels.length; i++){
			sels[i].parentNode.style.borderBottom = "1px solid black";
			sels[i].style.backgroundColor = GtTable.SELECTCOLOR;
		}
	}else if(type == "OUT"){
		var labels = _gtFindChildsByTagName(obj, "LABEL");
		for(var i=0; i<labels.length; i++)
			labels[i].style.borderBottom = "0px";
	}
}

GtEditTable.STARTEDIT = null;
GtEditTable.JUSTCREATED = 1;

GtEditTable.UNCHANGED = null;
GtEditTable.CHANGED = 1;

_p.appendRow = function (){
	var row = _super.appendRow.call(this);
	
	row._status = GtEditTable.JUSTCREATED;
	
	return row;
}

_p._setRowSaved = function (row){
	GtEditTable._initRowOldValue(row);
	row._status = GtEditTable.STARTEDIT;
}

_p.getRowsByStatus = function( status ){
	var ret = new Array();
	try{
	for(var i=0; i<this.areaDiv.rows.length; i++){
		if(this.areaDiv.rows[i]._status != status)
			continue;
		if(this.areaDiv.rows[i]._status == GtEditTable.JUSTCREATED
			&& this.areaDiv.rows[i]._createWithValue == true){
				ret[ret.length] = this.areaDiv.rows[i];
				continue;
		}		
		for(var j=0; j<this.areaDiv.rows[i].cells.length; j++){
			if(this.areaDiv.rows[i].cells[j]._status == GtEditTable.CHANGED){
				ret[ret.length] = this.areaDiv.rows[i];
				break;
			}
		}		
	}
	return ret;
	}catch(ex){}
}

_p.getJustCreatedRows = function(){
	return this.getRowsByStatus(GtEditTable.JUSTCREATED);
}

_p.getChangedRows = function(){
	return this.getRowsByStatus(GtEditTable.STARTEDIT);
}

_p.isNeedSave = function(){
	var ret = this.getJustCreatedRows();
//	alert("JustCreated: " + ret.length);
	if(ret.length > 0)
		return true;
	ret = this.getChangedRows();
//	alert("Changed: " + ret.length);
	if(ret.length > 0)
		return true;
	return false;
}

_p.saveAll = function(){
	var n = 0;
	var ret = this.getChangedRows();
	n += ret.length;
	for(var i=0; i<ret.length; i++){
		if(this.saveChangedRow(ret[i]) == false)
			return;
		this._setRowSaved(ret[i]);
	}
	
	ret = this.getJustCreatedRows();
	for(var i=0; i<ret.length; i++){
		if(this.saveJustCreatedRow(ret[i]) == false)
			return;
		this._setRowSaved(ret[i]);
	}
	n += ret.length;
	
	if(n > 0)
		this.setSelectedRow(null);
}

_p.saveJustCreatedRow = function(row){
	var ret;
	this.setSelectedRow(row, false);
	var form = _gtFindChildByTagName(row, "FORM");
	form.action = this._createActionUri;
	
	gtPreSetParameter(this, form);

	if(checkParameter(form, getActionXml(this._createActionUri)) == false)
		return false;
	if(gtCheckParameter(this, form) == false)
		return false;
	ret = xp_loadActionByForm(form);
	if(ret.isSuccess() == true){
		row.id = this._createRowId(ret.getNewOid());
		return true;
	}else{
		alert(ret.getMessage());
		return false;
	}
}

_p.saveChangedRow = function (row){
	this.setSelectedRow(row, false);
	var form = _gtFindChildByTagName(row, "FORM");
	form.action = this._saveActionUri;
	
	_geSetFormValue(form, this._actionIdName, this.getRowId(row));
	
	gtSavePreSetParameter(this, form);
	
	if(checkParameter(form, getActionXml(this._saveActionUri)) == false)
		return false;
	if(gtCheckParameter(this, form) == false)
		return false;		
	ret = xp_loadActionByForm(form);
	if(ret.isSuccess() == false){
		alert(ret.getMessage());
		return false;
	}	
	return true;
}



_p.moveLine = function(srcIndex, dstIndex){
	var uri = this._moveActionUri;
	var re = /\?/;
	
	if(re.test(uri) == false)
		uri += "?";
	
	uri += "&from=" + srcIndex + "&to=" + dstIndex;

	ret = xp_loadAction(uri);
	
	if(ret.isSuccess() == false){
		alert(ret.getMessage());
		return false;
	}	
	return true;	
}



/*****************************
*                            *
*          消息注册函数       *
*                            *	
******************************/
function clearUnloadCheck(){
	document.body.onbeforeunload = null;
}

function _geContentRowFocusOutEvent(e){
	return;
	var row = _gtFindParentNodeByTagName(e.srcElement, "TR");
	var table = gtTables.findTable(row);
	var changed = false;
	for(var i=0; i<row.cells.length; i++){
		if(row.cells[i]._oldValue != GtEditTable._getInputCellValue(row.cells[i])){
			changed = true;
			break;
		}
	}
	if(changed == true)
		row._status = GtEditTable.CHANGED;
	else
		row._status = GtEditTable.STARTEDIT;
}

function _geCellChangeKeyUpEvent(e){
	var input = e.srcElement;
	var table = gtTables.findTable(input);
	
	table._changeTotalRow(input);
	
	_geInputChangeTest(input);
}

function _geCellChangeEvent(e){
	var input = e.srcElement;
	_geInputChangeTest(input);
}

function _geCellChangeTest(cell){
	var input;
	input = GtEditTable._findChildTextInputObject(cell);
	if(input != null){
		_geInputChangeTest(input);
		return;
	}
	
	input = GtEditTable._findChildCheckboxInputObject(cell);
	if(input != null){
		_geInputChangeTest(input);
		return;
	}	
	
	input = _gtFindChildByTagName(cell, "SELECT");
	if(input != null){
		_geInputChangeTest(input);
		return;
	}	
	
}

function _geInputChangeTest(input){
	var cell = _gtFindParentNodeByTagName(input, "LABEL");
	var row = _gtFindParentNodeByTagName(cell, "DIV");
	var table = gtTables.findTable(input);
	
	var newValue = null;
	
	if(input.tagName == "INPUT"){
		if(input.type == "checkbox")
			newValue = input.checked;
		else if(input.type == "text")
			newValue = input.value;
	}else if(input.tagName == "SELECT")
		newValue = GtEditTable._getSelectValue(input);
	
	if(newValue != null){
		if(newValue != cell._oldValue){
			cell._status = GtEditTable.CHANGED;
		}else
			cell._status = GtEditTable.UNCHANGED;
	}
}

function _geLeftHeadRowMouseDownEvent(e){
	if(e.button != 1)
		return;	
	var tr = _gtFindParentNodeByTagName(e.srcElement, "TR");
	var table = gtTables.findTable(tr);
	if(tr.newObject == null)
		tr.newObject = table._geCreateMoveObject(tr);
	_geLeftHeadRowMouseDownEvent.moveObject = tr;
	_geShowObjectWithMouse(tr, e);
}

function _geLeftHeadRowMouseOverEvent(e){
	if(_geLeftHeadRowMouseDownEvent.moveObject == null)
		return;
	var tr = _gtFindParentNodeByTagName(e.srcElement, "TR");
	_geLeftHeadRowMouseOverEvent.overObject = tr;
	_geChangeHeadTitleStyle(tr, "OVER");
}

function _geLeftHeadRowMouseOutEvent(e){
	if(_geLeftHeadRowMouseOverEvent.overObject == null)
		return;
	_geChangeHeadTitleStyle(_geLeftHeadRowMouseOverEvent.overObject, "");
	_geLeftHeadRowMouseOverEvent.overObject = null;
}

function _geMoveRowMouseMoveEvent(e){
	if(_geLeftHeadRowMouseDownEvent.moveObject == null)
		return;
	_geShowObjectWithMouse(_geLeftHeadRowMouseDownEvent.moveObject, e);
}

function _geMoveRowMouseUpEvent(e){
	var srcIndex, dstIndex;
	if(_geLeftHeadRowMouseDownEvent.moveObject == null)
		return;
	_geHideMoveObject(_geLeftHeadRowMouseDownEvent.moveObject);
	var src = _geLeftHeadRowMouseDownEvent.moveObject;
	_geLeftHeadRowMouseDownEvent.moveObject = null;

	if(_geLeftHeadRowMouseOverEvent.overObject == null)
		return;
	var table = gtTables.findTable(src);
	srcIndex = src.rowIndex;
	dstIndex = _geLeftHeadRowMouseOverEvent.overObject.rowIndex;
	_geChangeHeadTitleStyle(_geLeftHeadRowMouseOverEvent.overObject, "");
	_geLeftHeadRowMouseOverEvent.overObject	= null;		

	if(srcIndex == dstIndex)
		return;
	if(table.moveLine(srcIndex, dstIndex) == true)
		_geInserAfterByIndex(table, srcIndex, dstIndex);
}

// 移动Object
function _geShowObjectWithMouse(obj, e){
	var top = e.clientY + 10;
	var left = e.clientX;
	
	obj.newObject.style.display = "";
	
	obj.newObject.style.posTop = top;
	obj.newObject.style.posLeft = left;
}

function _geHideMoveObject(obj){
	obj.newObject.style.display = "none";
}

// 在目标后面插入行
function _geInserAfterByIndex(table, srcIndex, dstIndex){
	table.contentTable.tBodies[0].insertBefore(
		table.contentTable.tBodies[0].rows[srcIndex],
		table.contentTable.tBodies[0].rows[dstIndex].nextSibling);
}

// 更改样式
function _geChangeHeadTitleStyle(obj, type){
	if(type == "OVER"){
		_gtFindChildByTagName(obj, 'DIV').style.backgroundColor = "#898989";
	}else if(type == ""){
		_gtFindChildByTagName(obj, 'DIV').style.backgroundColor = "";
	}
}

// 检查是否需要保存

function _geIsNeedSave(){
	var needSave = false;
	
	for(var i=0; i<gtTables.tables.length; i++){
		if(gtTables.tables[i].isNeedSave != null && gtTables.tables[i].isNeedSave() == true){
			needSave = true;
			break;
		}
	}
		
	if(needSave == true)
		return "你做了修改，需要保存！";
}

function _geUniqRowElement(row){
	var e;
	var a = new Object();
	
	var form = _gtFindChildByTagName(row, "FORM");
	
	for(var i=0; i<form.elements.length; i++){
		e = form.elements[i];
		if(e.name == null || e.name == "")
			continue;
		
		if(a[e.name] != null){
			e.parentNode.removeChild(e);
			i--;
		}else
			a[e.name] = e;
	}
}
