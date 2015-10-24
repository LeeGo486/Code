/*
   *
   *  author: keliro
   *  email: keliro_lin@hotmail.com
   *
   */

/* 全局变量定义：*/
GridTableImgDir = "../imgs/";
GridTableSortUpCursor = GridTableImgDir + "sort_up.gif";
GridTableSortDownCursor = GridTableImgDir + "sort_down.gif";
GridTableSortBlankCursor = GridTableImgDir + "sort_blank.gif";


// 全局消息注册
window.onresize = gtResetTablesPosition;
document.onkeydown = _gtOuterDivKeyDownEvent;

String.prototype.trim=function(){
	return this.replace(/(^\s+)|\s+$/g,"");
};

/*****************************
*                            *
*        可重载方法定义       *
*                            *	
******************************/


function gtDoKeySelect(t, row, id){
	gtDoSelect(t, row, id);
}

function gtDoSelect(t, row, id){
}

function gtDoDblClick(t, row, id){
}

function gtDoEnter(t, row, id){
	gtDoDblClick(t, row, id);
}

function canBeSelect(t, row){
	return true;
}

function canBeDbclick(t, row){
	return true;
}

function canBeOver(t, row){
	return true;
}

/*****************************
*                            *
*   GridTalbes 对象定义       *
*                            *	
******************************/
gtTables = new GtTables();						// 保存页面(document)内所有的gridTable
function GtTables(){
	this.tables = new Array();
	this.focusIndex = 0;
}

GtTables.prototype.addTable = function(gt){
	gt.number = this.tables.length;
	this.tables[this.tables.length] = gt;
}

GtTables.prototype.getFocusTable = function(){
	return this.tables[this.focusIndex];
}

GtTables.prototype.setFocusTable = function(t){
	this.focusIndex = t.getNumber();
}

GtTables.prototype.findTable = function(obj){
	var gtId, table;
	for(var i=0; i<this.tables.length; i++){
		table = this.tables[i];
		gtId = table.getGtId();
		if(_gtFindParentNodeById(obj, gtId) != null)
			return table;
	}
		
	return null;
}

GtTables.prototype.getTable = function(gtId){
	var gtId, table;
	for(var i=0; i<this.tables.length; i++){
		if(this.tables[i].gtId == gtId)
			return this.tables[i];
	}
	return null;
}

// 按照索引获得table
function getGtTable(n){
	return gtTables.tables[n];
}

function getSelectedCellChilds(n, cellIndex){
	return getGtTable(n).getSelectedCellChilds(cellIndex);
}

function getRowCellChilds(n, row, cellIndex){
	return getGtTable(n).getRowCellChilds(row, cellIndex);
}

function getSelectedRowElement(n, elename){
	return getGtTable(n).getSelectedRowElement(elename);
}

function getRowElement(n, row, elename){
	return getGtTable(n).getRowElement(row, elename);
}

function getSelectedRowElements(n, elename){
	return getGtTable(n).getSelectedRowElements(elename);
}

function getRowElements(n, row, elename){
	return getGtTable(n).getRowElements(row, elename);
}

function setSelectedRowElementValue(n, elename, value){
	getGtTable(n).setSelectedRowElementValue(elename, value);
}

function getSelectedRowElementValue(n, elename){
	getGtTable(n).getSelectedRowElementValue(elename);
}

function setRowElementValue(n, row, elename, value){
	getGtTable(n).setRowElementValue(row, elename, value);
}

function getSelectedRowLabel(n, m){
	getGtTable(n).getSelectedRowLabel(m);
}

function getRowLabel(n, row, m){
	getGtTable(n).getRowLabel(row, m);
}

function setSelectedRowLabelHtml(n, m, html){
	getGtTable(n).setSelectedRowLabelHtml(m, html);
}

function setRowLabelHtml(row, n, m, html){
	getGtTable(n).setRowLabelHtml(row, m, html);
}

function getSelectedRowLabelText(n, m){
	getGtTable(n).getSelectedRowLabelText(m);
}

function getRowLabelText(row, n, m){
	getGtTable(n).getRowLabelText(row, m);
}

function getClickCell(n){
	getGtTable(n).getClickCell();
}

/*****************************
*                            *
*   GridTalbe 对象定义       *
*                            *	
******************************/
function GtTable(id){
	this.gtId = id;
	
	this.number = null;
	
	this.oldTable = null;
	
	this.outerDiv = null;
	this.innerDiv = null;
	
	this.contentDiv = null;
	this.contentTable = null;
	
	this.topHeadDiv = null;
	this.topHeadTable = null;
	
	this.leftHeadDiv = null;
	this.leftHeadTable = null;
	
	this.spaceDiv = null;

	this.selectedRow = null;
	this.preSelectedRow = null;
	
	this.position = null;
	this.titleWidth = null;
	this._spaceDivWidth = 33;
	this._lineHeight = 16;
	this._hasTotalLine = false;
	
	this.titleSort = new Array();
	this.titleSearch = new Array();
	this.titleAlign = new Array();
	this.totalInfo = new Array();

	this.createTopHead = true;
	this.createLeftHead = true;	
	
	this._focusCellIndex = null;
	
	this._dymicLoad = false;
	this._selectFirst = false;
	
	this._actionIdName = null;
	this._deleteActionUri = null;		

	this._contentTableBorderColor = "white";

//	this._interCrossStyle = true;

	this._hiddenLineCount = 0;

	this._dmodel = null;
}

GtTable.OVERCOLOR = "#FFFFCC";
GtTable.SELECTCOLOR = "#BEC5DE";
GtTable.ODDCOLOR = "#FFFFFF";
GtTable.EVENCOLOR = "#E3E3E3";
GtTable.SURECOLOR = "#DDDDDD";

_p = GtTable.prototype;

_p.setOverColor = function(v){
	GtTable.OVERCOLOR = v;
}
_p.setSelectColor = function(v){
	GtTable.SELECTCOLOR = v;
}
_p.setOddColor = function(v){
	GtTable.ODDCOLOR = v;
}
_p.setEvenColor = function(v){
	GtTable.EVENCOLOR = v;
}

_p.disableInterCrossStyle = function(){
	this._interCrossStyle = false;
}

_p.setGridBorderColor = function(v){
	this._contentTableBorderColor = v;
}

_p.getTotalValue = function(n){
	return this.totalRow.cells[n].innerText.trim();
}

_p.setFirstSelect = function(){
	this._selectFirst = true;
}

_p.setParameter = function(para){
	this.createTopHead = para.createTopHead;	
	this.createLeftHead = para.createLeftHead;	
}

_p.getSelectedId = function(){
	return this.getRowId(this.selectedRow);
}

_p.getRowId = function(row) {
	if (row == null)
	return null;

	var re = eval("/^gt-" + this.number + "-/");
	return row.id.replace(re, '');
}

_p.getPreSelectedRow = function(){
	return this.preSelectedRow;
}

_p.getSelectedRow = function(){
	return this.selectedRow;
}

_p.isNewSelect = function(){
	return ! (this.selectedRow == this.preSelectedRow);
}

_p.getSelectedCellChilds = function(cellIndex){
	if(this.selectedRow == null)
		return null;
	return this.getRowCellChilds(this.selectedRow, cellIndex);
}

_p.getRowCellChilds = function(row, cellIndex){
//	return row.cells[cellIndex].childNodes[0].childNodes;
	return row.cells[cellIndex].childNodes;
}

_p.getRowByRid = function(rid){
	var row;
	for(var i=0; i<this.contentTable.tBodies[0].rows.length; i++){
		row = this.contentTable.tBodies[0].rows[i];
		if(this.getRowId(row) == rid) 
			return row;
	}
	return null;
}

_p.getSelectedRowElement = function(name){
	return this.getSelectedRowElements(name)[0];
}

_p.getRowElement = function(row, name){
	return this.getRowElements(row, name)[0];
}


_p.getSelectedRowElements = function(name){
	if(this.selectedRow == null)
		return null;
	return this.getRowElements(this.selectedRow, name);
}

_p.getRowElements = function(row, name){
	var ret = new Array();
	var form = _gtFindChildByTagName(row, "FORM");
	
	for(var i=0; i<form.elements.length; i++){
		if(form.elements[i].name == name)
			ret[ret.length] = form.elements[i];
	}
	return ret;
}

_p.setSelectedRowElementValue = function(name, value){
	this.setRowElementValue(this.selectedRow, name, value);
}

_p.getSelectedRowElementValue = function(name){
	return this.getRowElementValue(this.selectedRow, name);
}

_p.setRowElementValue = function(row, name, value){
	var e;
	var es = this.getRowElements(row, name);
	for(var i=0; i<es.length; i++){
		e = es[i];
		e.value = value;
		if(e.tagName == "INPUT" && e.type == "text")
			e.focus();
	}
}

_p.getRowElementValue = function(row, name) {
	var e;
	var es = this.getRowElements(row, name);
	for(var i=0; i<es.length; i++){
		e = es[i];
		return e.value;
	}

	return "";
}

_p.getSelectedRowLabel = function(m){
	return this.getRowLabel(this.selectedRow, m);
}

_p.getRowLabel = function(row, m){
	return row.cells[m];
}

_p.setSelectedRowLabelHtml = function(m, html){
	return this.setRowLabelHtml(this.selectedRow, m, html);
}

_p.setRowLabelHtml = function(row, m, html){
	return this.getRowLabel(row, m).innerHTML = html;
}

_p.getSelectedRowLabelText = function(m){
	return this.getRowLabelText(this.selectedRow, m);
}

_p.getRowLabelText = function(row, m){
	return this.getRowLabel(row, m).innerText.trim();
}

_p.getClickCell = function(){
	return this.selectedRow.cells[this.getFocusCellIndex()];
}

_p.selectRow = function(row){
}

_p.unSelectRow = function(row){
}

_p.setFocusCellIndex = function(index){
	this._focusCellIndex = index;
}

_p.getFocusCellIndex = function(index){
	return this._focusCellIndex;
}

_p.setSelectedRow = function(row, scrollToView){
	
	if(this.selectedRow != null && this.selectedRow != row)
		this.unSelectRow(this.selectedRow);	
	this.preSelectedRow = this.selectedRow;
	if(this.preSelectedRow != null)
		this._gtChangeRowStyle(this.preSelectedRow, "OUT");
	this.selectedRow = row;
	
	if(row == null) //如果选空
		return;
	
	if(this.preSelectedRow != row){
		this.selectRow(row);
		if(scrollToView != false)
			this._focusCellInput();		
	}
	this._gtChangeRowStyle(this.selectedRow, "DOWN");
	
	if(scrollToView != false)
		this.scrollToRow(row);
}

_p.setDymicLoad = function(index){
	this._dymicLoad = true;
}

_p.needDymicLoad = function(index){
	return this._dymicLoad;
}

_p.isLoaded = function(index){
	return !this._dymicLoad;
}

_p.tableLoadFinish = function(index){
	this._dymicLoad = false;
}

_p._focusCellInput = function(){
	return;
	var row = this.selectedRow;
	if(this._focusCellIndex == null)
		return;
	var input = _gtFindTdInputElement(row.childNodes[this._focusCellIndex]);
	if(input == null)
		return;
	GtTable._focusInputObject = input;
	setTimeout("GtTable._inputObjectFocus()", 2);
}

GtTable._inputObjectFocus = function(){
	GtTable._focusInputObject.focus();
	if(GtTable._focusInputObject.tagName == "INPUT" && GtTable._focusInputObject.type == "text"){
		var r =GtTable._focusInputObject.createTextRange();
		r.moveStart('character',GtTable._focusInputObject.value.length);
		r.collapse(true);
		r.select();	
	}
}

_p.showOneLeftHeadRow = function(){
	var t = this.leftHeadTable;
	var index = t.tBodies[0].rows.length - 1;
	if(t._hiddenRowIndex != null){	
		index = t._hiddenRowIndex++;
	}
	t.tBodies[0].rows[index].style.display = "";
}

_p.hideOneLeftHeadRow = function(){
	var t = this.leftHeadTable;
	var index = t.tBodies[0].rows.length - 1;
	if(t._hiddenRowIndex != null){	
		index = --t._hiddenRowIndex;
	}else
		t._hiddenRowIndex = index;
	t.tBodies[0].rows[index].style.display = "none";
}

_p.changeSelectedRowWithValue = function(arr){
	this.changeRowWithValue(this.selectedRow, arr);
}

_p.changeRowWithValue = function(row, arr){
	for(var i=0; i<row.cells.length; i++){
		if(arr[i] == null)
			continue;
		row.cells[i].innerHTML = arr[i];
	}
	if(this._hasTotalLine == true)
		this.reTotalAll();
	return row;
}

_p.createNewLine = function(){
	this.setSelectedRow(this.appendRow());
}

_p.clearRowStatus = function(row){
	this.selectedRow = null;
	this.preSelectedRow = null;
}

_p.selectNone = function(){
	
}

_p.deleteRow = function(row){
	/*
	var nrow = row.nextSibling;
	if(this._hasTotalLine == true)
		this.subtractRowTotal(row);
	
	if(row == this.getSelectedRow())
		this.clearRowStatus();
	this.contentTable.tBodies[0].removeChild(row);
	this.hideOneLeftHeadRow();
	this.leftHeadTable.tBodies[0].removeChild(
			this.leftHeadTable.tBodies[0].lastChild);
	this._gtResetHeadPosition();
	if(this._interCrossStyle == true)
		while(nrow != null){
			if(nrow != this.selectedRow)
				this.setRowInterCrossStyle(nrow);
			nrow = nrow.nextSibling;
		}
		*/
	var nrow = row.nextSibling;
	if(this._hasTotalLine == true)
		this.subtractRowTotal(row);
	
	if(row == this.getSelectedRow())
		this.clearRowStatus();

	this._dmodel.removeRow(row.rowIndex);

	this._resetTitlePosition();
}

_p.deleteCurrentRow = function(){
	this.deleteRow(this.getSelectedRow());
}

_p.deleteRowByIndex = function(n){
	this.deleteRow(this._dmodel.getRow(n).getLine());
}

_p.setSelectedRowByIndex = function(n){
	this.setSelectedRow(this.contentTable.tBodies[0].rows[n]);
}

_p.setGtId = function(id){
	this.gtId = id;
}

_p.getGtId = function(){
	return this.gtId;
}

_p.getNumber = function(){
	return this.number;
}

_p.setCreateTopHead = function(v){
	this.createTopHead = v;	
}

_p.setCreateLeftHead = function(v){
	this.createLeftHead = v;	
}

_p._newRowObject = function(){
	var str = "";
	str += '<table>';
	str += '<tr>';
	str += '<form>';
	for(var i=0; i<this.oldTable.tHead.childNodes[0].cells.length; i++)
		str += this._newLabelTDHtml(i, "");
	str += '</form>';
	str += '</tr>';
	str += '</table>';
	
	var ret = _gtCreateElementWithHTML(str).tBodies[0].rows[0];
	this._rowAttachEvent(ret);
	return ret;
}

_p._newLabelTDHtml = function(ind, text, td){
	var str = '<td>';
	str += '<label class="grid-label" style="height:' 
		+ this.position.tdHeight + 'px;width:' 
		+ (this.titleWidth[ind]-1)  + 'px;text-align:' 
		+ this.titleAlign[ind] + ';">';
	/*
	str += text;
	if(td != null)
		str += _gtHTMLWithOutText(td);	
		*/
	if(td != null)
		str += td.innerHTML;
	else
		str += text;
	str += '</label>';

	str += '</td>';
	return str;	
}

_p._getLabeledTDHtml = function(td){
	return this._newLabelTDHtml(td.cellIndex, td.innerText, td);
}

_p._createRowId = function(id){
	return 'gt-' + this.number + '-' + id;
}

_p.setRowId = function(row, id){
	row.id = this._createRowId(id);
}

_p._getLabeledTRHtml = function(tr){
	var idstr = "";
	var str = "";
	if(tr.id != null)
		idstr = ' id="' + this._createRowId(tr.id) + '"';
	str += '<tr' + idstr + '>';
	str += '<form>';
	for(var j=0; j<tr.cells.length; j++)
		str += this._getLabeledTDHtml(tr.cells[j]);
	str += '</form>';
	str += '</tr>';
	
	return str;
}

_p._increaseTrWithOldTr = function(){
	if(this._increaseTrWithOldTrNumber == null)
		this._increaseTrWithOldTrNumber = 0;
			
	if(this._increaseTrWithOldTrNumber >= this.oldTable.tBodies[0].rows.length ){
		this.tableLoadFinish();	
		return;
	}
		
	this._createTrWithOldTr(this._increaseTrWithOldTrNumber);
	this._increaseTrWithOldTrNumber ++;
}

_p._createTrWithOldTr = function(n){
	var tr = this.oldTable.tBodies[0].rows[n];
	_gtRemoveRowSpaceElement(tr);
	var ntr = gtCreateTRWithHTML(this._getLabeledTRHtml(tr));
	this._rowAttachEvent(ntr);
	this.contentTable.tBodies[0].appendChild(ntr);
	if(this._interCrossStyle == true)
		this.setRowInterCrossStyle(ntr);
	
	var headRow = this._newLeftHeadRowObject();
	this.leftHeadTable.tBodies[0].appendChild(headRow);	
	this.showOneLeftHeadRow();
	
	if(this._selectFirst == true && this._firstSelected == null)
		if(this.selectNextRow() == true)
			this._firstSelected = true;
}

GtTable._createTrWithOldTr = function(){
	var t;
	
	var needLoad = false;
	for(var i=0; i<gtTables.tables.length; i++){
		t = gtTables.tables[i];
		if(t.needDymicLoad()){
			for(var i=0; i<3; i++)
				t._increaseTrWithOldTr();
			if(t.isLoaded() == false)
				needLoad = true;
		}
	}
	if(needLoad == false)
		for(var i=0; i<gtTables.tables.length; i++){
			t = gtTables.tables[i];	
			if(t._dymicLoadTimer != null)
				clearInterval(t._dymicLoadTimer);
		}
}

_p._newLeftHeadRowObject = function(td){
	var str = '<table>' 
		+ this._newLeftHeadHtml(
				this.contentTable.tBodies[0].rows.length) 
		+ '</table>';
	
	var ret = _gtCreateElementWithHTML(str).tBodies[0].rows[0];
	ret.style.display = "none";
	this._leftRowAttachEvent(ret);
	return ret;
}

_p._newLeftHeadHtml = function(n){
	return '<tr><td><div class="grid-title" style="height:' 
		+ this.position.leftHeadTdHeight + 'px;cursor:default;">' + n + '</div></td></tr>'
}

_p._getTopHeadTdHtml = function(td){
	var str = '<td>';
	str += '<label class="grid-title" style="height:' 
		+ this.position.topHeadTdHeight + 'px;text-align:center;width:' + this.titleWidth[td.cellIndex] + 'px;">';
	str += td.innerText;
	if(this.titleSort[td.cellIndex] != null)
		str += '<img src="' + GridTableSortBlankCursor + '" alt="" border="0"/>';
	str += '</label>';
	str += '</td>';
	return str;	
}

_p.setSpaceDivWidth = function(w){
	this._spaceDivWidth = w;
}

_p.setLineHeight = function(w){
	this._lineHeight = w;
}

_p.getLineWidth = function(){
	var w = 0;
	for(var i=0; i<this.titleWidth.length; i++)
		w += this.titleWidth[i];
	return w;
}

GtTable._calculateLength = function(w, p){
	var re = /\%$/;
	
	if(re.test(p) == false)
		return parseInt(p);
	else
		return parseInt(w * parseInt(p) / 100);
}

GtTable.getLengthParentNode = function(node){
	var p = node.parentNode;
	while(p != null){
		if(p.clientWidth > 0)
			break;
		p = p.parentNode;
	}
	return p;
}

_p.initDivArea = function(){
	this.position.innerDivWidth = GtTable._calculateLength(GtTable.getLengthParentNode(this.outerDiv).clientWidth, this.outerDiv.style.width);
	this.position.innerDivHeight = GtTable._calculateLength(GtTable.getLengthParentNode(this.outerDiv).clientHeight, this.outerDiv.style.height);
}

_p.replaceTable = function(){
	this.outerDiv.appendChild(this.innerDiv);
}

_p.registEvent = function(){
	var row, cell;
	
	this.outerDiv.attachEvent("onselectstart", _gtOuterDivSelectStartEvent);
	this.outerDiv.attachEvent("onmousedown", _gtOuterDivMouseDownEvent);
//	this.outerDiv.attachEvent("onkeydown", _gtOuterDivKeyDownEvent);
	
	this.contentDiv.attachEvent("onscroll", _gtContentDivScrollEvent);
	
	this.topHeadDiv.attachEvent("onmousedown", _gtTopHeadTableMouseDownEvent);
	document.attachEvent("onmouseup", _gtTopHeadTDMoveUpEvent);
	
	if(this.createTopHead == true)
		for(var i=0; i<this.topHeadTable.tBodies[0].rows[0].cells.length; i++){
			cell = this.topHeadTable.tBodies[0].rows[0].cells[i];
			cell.attachEvent('onmousemove', _gtTopHeadTDMouseMoveEvent);
			cell.attachEvent('onmouseout', _gtTopHeadTDMouseOutEvent);
			cell.attachEvent('onmousedown', _gtTopHeadTDMouseDownEvent);
			cell.attachEvent('ondblclick', _gtTopHeadTDDblClickEvent);
		}
		
	/*
	for(var i=0; i<this.leftHeadTable.tBodies[0].rows.length; i++)
		this._leftRowAttachEvent(this.leftHeadTable.tBodies[0].rows[i]);
		*/
	
//	for(var i=0; i<this.contentTable.tBodies[0].rows.length; i++)
	//	this._rowAttachEvent(this.contentTable.tBodies[0].rows[i]);
	
}

_p._leftRowAttachEvent = function(row){
	row.attachEvent("onmousedown", _gtLeftRowMouseDownEvent);
}

_p._rowAttachEvent = function(row){
	row.attachEvent("onmouseover", _gtContentRowMouseOverEvent);
	row.attachEvent("onmouseout", _gtContentRowMouseOutEvent);
	row.attachEvent("onmousedown", _gtContentRowMouseDownEvent);
	row.attachEvent("onkeydown", _gtContentRowKeyDownEvent);
	row.attachEvent("ondblclick", _gtContentRowDblClickEvent);
}

_p.getContentScrollLeft = function(){
	return this.contentDiv.scrollLeft;
}

_p.getContentScrollTop = function(){
	return this.contentDiv.scrollTop;
}

// 更改选中行的显示样式
_p._gtChangeRowStyle = function(obj, type){
	if(type == "OVER"){
		obj.style.backgroundColor = GtTable.OVERCOLOR;
	}else if(type == "OUT"){
		if(this._interCrossStyle == true)
			this.setRowInterCrossStyle(obj);
		else
			obj.style.backgroundColor = "";
	}else if(type == "DOWN"){
		obj.style.backgroundColor = GtTable.SELECTCOLOR;		
	}
}

_p.setRowInterCrossStyle= function(row){
	var rn = row.rowIndex;
	if(row._preHiddenCount != null)
		rn -= row._preHiddenCount;
	else
		rn -= this._hiddenLineCount;

	if(rn%2 == 0)
		row.style.backgroundColor = GtTable.EVENCOLOR;
	else
		row.style.backgroundColor = GtTable.ODDCOLOR;
}

// 在搜索和排序之后重新设定奇行和偶行的颜色
_p.resetCrossStyle = function(){
	var row;
	for(var i=0; i<this.contentTable.tBodies[0].rows.length; i++)
		this.setRowInterCrossStyle(this.contentTable.tBodies[0].rows[i]);
}

GtTable.UpSort = 0;
GtTable.DownSort = 1;

_p._gtChangeSortImage = function(cell){
	var row = this.topHeadTable.tBodies[0].rows[0];
	var re1 = /sort_blank.gif|sort_down.gif/;
	var re2 = /sort_blank.gif|sort_up.gif/;
	var re3 = /sort_\w*\.gif/;
	
	if(row._sortLine != null && row._sortLine != cell.cellIndex){
		row.cells[row._sortLine].innerHTML = row.cells[row._sortLine].innerHTML.replace(re3, "sort_blank.gif");	
	}
	row._sortLine = cell.cellIndex;
	
	if(cell._sortDirection == null)
		cell._sortDirection = GtTable.DownSort;
	cell._sortDirection = 1 - cell._sortDirection;
	
	if(cell._sortDirection == GtTable.UpSort)
		cell.innerHTML = cell.innerHTML.replace(re1, "sort_up.gif");
	else if(cell._sortDirection == GtTable.DownSort)
		cell.innerHTML = cell.innerHTML.replace(re2, "sort_down.gif");
}

GtTable.StringSort = "string";
GtTable.NumberSort = "number";
GtTable.DateSort = "date";

_p._geSortContentTable = function(){
	var row = this.topHeadTable.tBodies[0].rows[0];
	var ind = row._sortLine;
	var cell = row.cells[ind];
	var cells = new Array();
	var tbody = this.contentTable.tBodies[0];
	var rows = tbody.rows;
	for(var i=0; i<rows.length; i++){
		cells[i] = rows[i].cells[ind];
	}
	
	var type = this.titleSort[ind];
	
	if(type == GtTable.NumberSort)
		cells.sort(gtNumberCompare);
	else if(type == GtTable.DateSort)
		cells.sort(gtDateCompare);
	else
		cells.sort(gtStringCompare);
		
	if(cell._sortDirection == GtTable.DownSort)
		cells.reverse();
	
	var r;
	for(var i=0; i<cells.length; i++){
		r = _gtFindParentNodeByTagName(cells[i], "TR");
		tbody.insertBefore(r);	
	}
}

GtTable._addTdValue = function(src, dst){
	src.childNodes[0].innerHTML = GtTable._getFloat(gtGetInnerTextWithInput(src))
		+ GtTable._getFloat(gtGetInnerTextWithInput(dst));	
}

GtTable._subtractTdValue = function(src, dst){
	src.childNodes[0].innerHTML = GtTable._getFloat(gtGetInnerTextWithInput(src))
		- GtTable._getFloat(gtGetInnerTextWithInput(dst));	
}

_p.subtractRowTotal = function(row){
	for(var i=0; i<row.cells.length; i++)
		if(this.totalInfo[i].isFee == true)
			GtTable._subtractTdValue(this.totalRow.cells[this.totalInfo[i].n], row.cells[i]);
}

_p.addRowTotal = function(row){
	for(var i=0; i<row.cells.length; i++)
		if(this.totalInfo[i].isFee == true)
			GtTable._addTdValue(this.totalRow.cells[this.totalInfo[i].n], row.cells[i]);
}

_p.reTotalAll = function(){
}

_p.reTotalCells = function(cell){
	var total = 0;
	for(var i=0; i<this.areaDiv.rows.length; i++)
		if(this.areaDiv.rows[i].style.display != "none"){
			total += GtTable._getFloat(gtGetInnerTextWithInput(this.areaDiv.rows[i].cells[cell.cellIndex]));
		}
	this.totalRow.cells[this.totalInfo[cell.cellIndex].n].childNodes[0].innerHTML = total;
}

_p._showHiddenLine = function(row, n){
	row.style.display = "";
	this.showOneLeftHeadRow();
	if(this._hasTotalLine == true && this.totalInfo[n].isFee == true)
		GtTable._addTdValue(this.totalRow.cells[this.totalInfo[n].n], row.cells[n]);
	this._hiddenLineCount --;
}

_p._changeTotalRow = function(input){
	var cell = _gtFindParentNodeByTagName(input, "LABEL");
	if(this._hasTotalLine == true && this.totalInfo[cell.cellIndex].isFee == true)
		this.reTotalCells(cell);
}

_p._hiddenLine = function(row, n){
	row.style.display = "none";
	this.hideOneLeftHeadRow();
	if(this._hasTotalLine == true && this.totalInfo[n].isFee == true)
		GtTable._subtractTdValue(this.totalRow.cells[this.totalInfo[n].n], row.cells[n]);
	this._hiddenLineCount ++;
}

_p._geSearchContentTableCell = function(cell, key){
	var re = null;
	if(key != null && key != "")
		re = eval('/' + key + '/');
	var tbody = this.contentTable.tBodies[0];
	var rows = tbody.rows;
	for(var i=0; i<rows.length; i++){
		rows[i]._preHiddenCount = this._hiddenLineCount;
		if(re == null || re.test(gtGetInnerTextWithInput(rows[i].cells[cell.cellIndex])) == true){
			if(rows[i].style.display == "none")
				this._showHiddenLine(rows[i], cell.cellIndex);
		}else{
			if(rows[i].style.display != "none")
				this._hiddenLine(rows[i], cell.cellIndex);
		}
	}
	
	this._gtResetHeadPosition();
}

// 更改Top Head 和 Left Head的位置
_p._gtResetHeadPosition = function(){

	this._resetTitlePosition();
	return;
}

_p.resetTablePosition = function(){
	var label;
	
	this.initPositition();
	
	this.innerDiv.style.width = this.position.innerDivWidth;
	this.innerDiv.style.height = this.position.innerDivHeight;
	
	this.contentDiv.style.width = this.position.contentDivWidth;
	this.contentDiv.style.height = this.position.contentDivHeight;	
	
	this.topHeadDiv.style.width = this.position.topHeadDivWidth;
	this.topHeadDiv.style.height = this.position.topHeadDivHeight;
	
	this.leftHeadDiv.style.width = this.position.leftHeadDivWidth;
	this.leftHeadDiv.style.height = this.position.leftHeadDivHeight;
	
	/*
	for(var i=0; i<this.topHeadTable.tBodies[0].rows[0].cells.length; i++){
		label = _gtFindChildByTagName(this.topHeadTable.tBodies[0].rows[0].cells[i], "LABEL");
		label.style.width = this.titleWidth[i];
	}
	
	for(var i=0; i<this.contentTable.tBodies[0].rows.length; i++){
		for(var j=0; j<this.contentTable.tBodies[0].rows[i].cells.length; j++){
			label = _gtFindChildByTagName(this.contentTable.tBodies[0].rows[i].cells[j], "LABEL");
			label.style.width = this.titleWidth[j] - 1;
		}
	}
	*/

	this._dmodel.repaintArea();
	this._gtResetHeadPosition();
	this.repaintScreen();
}

_p._getContentClientHeight = function(){
	return this.contentDiv.clientHeight - this.position.contentDivPadTop;
}

_p._getBottomScrollbarWidth = function(){
	var a = this.position.contentDivHeight 
		- this.contentDiv.clientHeight;
	return a;
}

_p._getContentClientWidth = function(){
	return this.contentDiv.clientWidth - this.position.contentDivPadLeft;
}

_p._getRightScrollbarWidth = function(){
	return this.position.contentDivWidth 
		- this.contentDiv.clientWidth;
}

_p.deleteSelectedLine = function (){
	var row = this.getSelectedRow();
	if(row == null)
		return;
	if(this.deleteLine(row) == true)
		this.clearRowStatus();
}

_p.deleteLine = function (row){
	var ret;
	this.setSelectedRow(row);
	
	if(row.id == null || row.id == ""){
		this.deleteRow(row);
		return true;
	}
	
	var form = _gtFindChildByTagName(row, "FORM");
	if(window.confirm("确认删除!") == false)
		return false;
	form.action = this._deleteActionUri;
	_geSetFormValue(form, this._actionIdName, this.getRowId(row));
//	ret = xp_loadAction(this._deleteActionUri + "?" + this._actionIdName + "=" + this.getRowId(row));
	ret = xp_loadAction(xp_getActionUriByForm(form) + "&" + this._actionIdName + "=" + this.getRowId(row));
	
	if(ret.isSuccess() == false){
		alert(ret.getMessage());
		return false;
	}	
	this.deleteRow(row);
	return true;
}

_p.setDeleteActionUri = function(uri){
	this._deleteActionUri = uri;
}

_p.setActionIdName = function (name){
	this._actionIdName = name;
}

/*
 *
 * display
 *
 */

_p.loadTable = function(){
	if(this.gtId == null)
		return;
	
	if(this.number == null)
		return;
	
	this.initDIV();
	this.registEvent();
	this.replaceTable();
	
//	this._gtResetHeadPosition();
	this._resetTitlePosition();

	this.initContentTable();
}

_p.initDIV = function(){
	
	this._getPageInfo();
	
	this.initPositition();
	this.initTitleWidth();
	this._dmodel = new DataModel(this);
	this._dmodel.calSize();
	
	var div = this.initInnerDiv();

	div.appendChild(this.initContentDIV());	

	if(this.createTopHead == true){
		div.appendChild(this.initTopBackground());
		this.topBackground.appendChild(this.initTopHeadDIV());	
	}
		
	if(this.createLeftHead == true){
		div.appendChild(this.initLeftBackground());
		this.leftBackground.appendChild(this.initLeftHeadDIV());
	}
		
	if(this.createTopHead == true || this.createLeftHead == true)
		div.appendChild(this.initSpaceDIV());						

}

_p.initContentTable = function(){
	this.repaintScreen();
}

_p._gtShowThisContent = function(){
	var num = this.getContentLineNumber();

	for(var i=num[0]; i<=num[1]; i++)
		this._dmodel.addRow(i);
}

_p.repaintScreen = function(){
	var num = this.getContentLineNumber();

	this.repaintLines([num[0], num[1]]);
}

_p.repaintLines = function(a){
	for(var i=a[0]; i<=a[1]; i++){
		if(i >= 0 && i<this._dmodel.getLength())
			this._dmodel.repaintRow(i);
	}
}

_p.initContentDIV = function(){
	var str ='<div class="grid-content" style="width:' 
			+ this.position.contentDivWidth + 'px;height:' 
			+ this.position.contentDivHeight + 'px;">';
	str += '<div class="grid-area" style="top:' 
			+ this.position.contentDivPadTop + 'px;left:' 
			+ this.position.contentDivPadLeft + 'px;width:' 
			+ this.position.areaDivWidth+ 'px;height:' 
			+ this.position.areaDivHeight+ 'px;">';
	/*
	str += '<table class="grid-table" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="'
		+ this._contentTableBorderColor + '">';
	str += '</table>';
	*/
	str += '</div>';
	str += '</div>';
	this.contentDiv = _gtCreateElementWithHTML(str);
	this.areaDiv = this.contentDiv.childNodes[0];
	this.areaDiv.rows = this.areaDiv.childNodes;
	this.contentTable = this.areaDiv.childNodes[0];
	return this.contentDiv;
}

_p.initInnerDiv = function(){
	var str = '<div class="grid-inner" style="width:' 
			+ this.position.innerDivWidth + 'px;height:' 
			+ this.position.innerDivHeight + 'px;"></div>';
	this.innerDiv = _gtCreateElementWithHTML(str);
	return this.innerDiv;
}

_p.initSpaceDIV = function(){
	var str = '<div class="grid-space" style="position:absolute;overflow:hidden;height:' 
			+ this.position.spaceDivHeight + 'px;width:' 
			+ this._spaceDivWidth + 'px;left:0px;top:0px;"></div>';
	this.spaceDiv = _gtCreateElementWithHTML(str);
	return this.spaceDiv;	
}
/*
 *
 * get initial information
 *
 */

_p.initPositition = function(){
	this.position = new Object();	
	
	this.position.tdHeight = this._lineHeight + 2;
	
	this.initDivArea();
	
	this.position.spaceDivHeight = this.position.tdHeight;
	if(this._hasTotalLine == true)
		this.position.spaceDivHeight += this.position.tdHeight;
	
	this.position.scrollBarWidth = 16;
	
	this.position.topHeadDivWidth = this.position.innerDivWidth - 2 - this._spaceDivWidth;
	this.position.topHeadDivHeight = this.position.tdHeight;
	if(this._hasTotalLine == true)
		this.position.topHeadDivHeight += this.position.tdHeight;
	this.position.topHeadTdHeight = this.position.tdHeight;
	this.position.topHeadDivLeft = this._spaceDivWidth;

	this.position.contentDivWidth = this.position.innerDivWidth - 2;
	this.position.contentDivHeight = this.position.innerDivHeight - 2;
	this.position.contentDivPadTop = this.position.topHeadDivHeight;
	this.position.contentDivPadLeft = this._spaceDivWidth - 1;
	this.position.contentLineDivHeight = this._lineHeight + 1;
	this.position.contentLineWidth = this.position.contentDivWidth - this._spaceDivWidth;
	this.position.contentLineHeight = this.position.contentLineDivHeight;
	this.position.contentLineTopHeight = this.position.tdHeight;
	
	this.position.leftHeadDivWidth = this._spaceDivWidth;
	this.position.leftHeadDivHeight = this.position.innerDivHeight - 2 - (this._lineHeight+1);
	if(this._hasTotalLine == true)
		this.position.leftHeadDivHeight -= this._lineHeight+1;
	this.position.leftHeadTop = this.position.topHeadDivHeight;
	this.position.leftHeadTdHeight = this.position.tdHeight;
	this.position.leftTitleWidth = this._spaceDivWidth;
	this.position.leftTitleHeight = this.position.tdHeight;
}

_p._getPageInfo = function(){
	this.outerDiv = _gtGetElement(this.gtId);
	this.oldTable = this.outerDiv.childNodes[0];	
	this.oldTable.style.display = "none";
	
	this.getOldTheadInfo();
}

_p.getLineHeight = function(){
	return this.position.contentLineDivHeight;
}

_p._getContentClientHeight = function(){
	return this.contentDiv.clientHeight - this.position.contentDivPadTop;
}

_p._getContentClientWidth = function(){
	return this.contentDiv.clientWidth - this.position.contentDivPadLeft;
}

_p.getContentLineNumber = function(){
	var d = this.contentDiv;
	var stop = d.scrollTop;
	var cwidth = this._getContentClientWidth();
	var cheight = this._getContentClientHeight();
	var lheight = this.position.contentLineTopHeight;

	var tn = parseInt(stop / lheight);
	var ty = stop - ( tn * lheight );
	var cy = ty > 0 ? lheight-ty : 0;
	var cl = cheight - cy;
	var cn = parseInt(cl / lheight);
	var cy2 = cl % lheight;

	var snum = tn;
	var tnum = tn + cn + (ty>0 ? 1 : 0) + (cy2>0 ? 1 : 0);

	/*
	snum -= 5;
	tnum += 5;
	if(snum < 0)
		snum = 0;
	*/

	if(tnum >= this._dmodel.getLength())
		tnum = this._dmodel.getLength() - 1;

	return [snum, tnum, tn, ty, cy, cn, cy2, parseInt(cheight/lheight), cheight%lheight];
}

_p.getOldTheadInfo = function(){
	var w,td;
	for(var i=0; i<this.oldTable.tHead.childNodes[0].cells.length; i++){
		td = this.oldTable.tHead.childNodes[0].cells[i];
		if(td.sortable != null)
			this.titleSort[i] = td.sortable;
		else
			this.titleSort[i] = null;
		if(td.searchable != null)
			this.titleSearch[i] = true;
		else
			this.titleSearch[i] = false;
		this.titleAlign[i] = "left";
		if(td.align != null && td.align != "")
			this.titleAlign[i] = td.align;
	}

	var hrow = this.oldTable.tHead.childNodes[1];
	var re = /^[\d\.\,]+$/;
	var re2 = /^true$/i;
	if(hrow != null){
		this._oldTotalRow = hrow;
		this._hasTotalLine = true;
		for(var i=0; i<hrow.cells.length; i++){
			for(var j=0; j<hrow.cells[i].colSpan; j++){
				var obj = new Object();
				obj.isFee = re.test(hrow.cells[i].innerText.trim()) 
					|| re2.test(hrow.cells[i].innerText.trim());
				obj.n = i;
				obj.cell = hrow.cells[i];
				this.totalInfo[this.totalInfo.length] = obj;	
			}
		}
	}
}

_p.initTitleWidth = function(){
	var w,td;
	this.titleWidth = new Array();
	var ns = new Array();
	var yue = this.position.topHeadDivWidth;
	for(var i=0; i<this.oldTable.tHead.childNodes[0].cells.length; i++){
		w = null;
		td = this.oldTable.tHead.childNodes[0].cells[i];
		if(td.width != ""){
			w = GtTable._calculateLength(this.position.topHeadDivWidth, td.width);
			yue -= w;
		}else
			ns[ns.length] = i;
		this.titleWidth[this.titleWidth.length] = w;
	}	
	
	var fen = parseInt(yue / ns.length);
	for(var i=0; i<ns.length; i++)
		this.titleWidth[ns[i]] = fen;
	var tol = 0;
	for(var i=0; i<this.titleWidth.length; i++)
		tol += this.titleWidth[i];
	if((this.position.topHeadDivWidth-tol) > 0 && ns.length > 0)
		this.titleWidth[ns[ns.length-1]] += this.position.topHeadDivWidth-tol;
}

/*
 *
 * set head functions
 *
 */
_p._resetTitlePosition = function(){
	this._setBottomScrollBar();
	this._setRightScrollBar();
	this._setBottomScrollBar();
	this._setTopHeadPosition();
	this._setLeftHeadPosition(); 
}

_p._setRightScrollBar = function(){
	var lh = this._dmodel.getLength() * this.position.contentLineTopHeight;
	var ch = this._getContentClientHeight();

	if(lh > ch)
		this.contentDiv.style.overflowY = "scroll";
}

_p._setBottomScrollBar = function(){
	var tw = this.position.contentLineWidth;
	var cw = this._getContentClientWidth();

	if(tw > cw)
		this.contentDiv.style.overflowX = "scroll";
}

_p._setTopHeadPosition = function(){
	var cw = this._getContentClientWidth();

	this.topBackground.style.left = this.position.topHeadDivLeft - this.contentDiv.scrollLeft;
	this.topBackground.style.width = cw + this.contentDiv.scrollLeft;
	this.position.topHeadDivWidth = this.getLineWidth();
	this.topHeadDiv.style.width = this.position.topHeadDivWidth;
}

_p._setLeftHeadPosition = function(){
	var ch = this._getContentClientHeight();

	this.leftBackground.style.top = this.position.leftHeadTop - this.contentDiv.scrollTop;

	this.leftBackground.style.height = ch + this.contentDiv.scrollTop;
}

/*
 *
 * left no functions
 *
 */

_p.newTitle = function(index){
	var src = '<label class="grid-no" style="width:' 
		+ this.position.leftTitleWidth  + 'px;height:' 
		+  this.position.leftTitleHeight + 'px;left:0px;">' 
		+ (index+1) + '</label>';
	return _gtCreateElementWithHTML(src);
}

_p.appendTitle = function(title, index){

	this.leftHeadDiv.appendChild(title);
	title.style.top = index * this.position.leftTitleHeight;
}

/*
 *
 * top head functions
 *
 */
GtTable._getFloat = function(s){
	var n = s.trim();
	var ret = parseFloat(n.replace(/,/g, ""));

	if(isNaN(ret))
		ret = 0;
	return ret;
}	

_p._calculateTotalCell = function(cell, m){
	var re = /true/i;
	if(re.test(cell.innerText) == false)
		return cell.innerText.trim();
	var total = 0;
	for(var i=0; i<this.oldTable.tBodies[0].rows.length; i++)
		total += GtTable._getFloat(this.oldTable.tBodies[0].rows[i].cells[m].innerText);
	
	return formatMoneyValue(total);
}

_p.appendTotalHeadLine = function(){
	var cell, spanstr, w, align;
	var str = '<tr>';
	var m = 0;
	for(var i=0; i<this._oldTotalRow.cells.length; i++){
		cell = this._oldTotalRow.cells[i];
		spanstr = '';
		if(cell.colSpan > 1)
			spanstr = ' colspan="' + cell.colSpan + '"'
		align = 'right';
		if(cell.align != null && cell.align != '')
			align = cell.align;
		w = 0;
		for(var j=0; j<cell.colSpan; j++)
			w += this.titleWidth[m++];
		str += '<td' + spanstr + '>';
		str += '<label class="grid-total" style="height:' 
			+ this.position.topHeadTdHeight + 'px;text-align:' 
			+ align + ';width:' 
			+ w + 'px;">';
		str += this._calculateTotalCell(cell, m-1);
		str += '</label>';
		str += '</td>';
	}
	str += '</tr>';
	this.totalRow = gtCreateTRWithHTML(str);
	this.topHeadTable.tBodies[0].appendChild(this.totalRow);
}	

_p.initTopBackground = function(){
	var str = '<div class="grid-top-background" style="position:absolute;overflow:hidden;height:' 
			+ this.position.topHeadDivHeight + 'px;width:' 
			+ this.position.topHeadDivWidth + 'px;left:' 
			+ this.position.topHeadDivLeft + 'px;top:0px;">';
	str += '</div>';
	
	this.topBackground = _gtCreateElementWithHTML(str);
	return this.topBackground;
}
	
_p.initTopHeadDIV = function(){

	var str = '<div style="position:absolute;overflow:hidden;height:' 
			+ this.position.topHeadDivHeight + 'px;width:' 
			+ this.position.topHeadDivWidth + 'px;left:0px;top:0px;">';
	
	var head = this.oldTable.tHead.childNodes[0];
	str += '<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" bordercolor="black">';
	str += '<tr>';
	
	for(var i=0; i<head.cells.length; i++)
		str += this._getTopHeadTdHtml(head.cells[i]);

	str += '</tr>';
	str += '</table>';
	str += '</div>';
	
	
	this.topHeadDiv = _gtCreateElementWithHTML(str);
	this.topHeadTable = this.topHeadDiv.childNodes[0];
	
	if(this._hasTotalLine == true){
		this.appendTotalHeadLine();	
	}
	
	return this.topHeadDiv;
}

/*
 *
 * left head functions
 *
 */

_p.initLeftBackground = function(){
	var str = '<div class="grid-left-background" style="position:absolute;overflow:hidden;height:' 
			+ this.position.leftHeadDivHeight + 'px;width:' 
			+ this.position.leftHeadDivWidth + 'px;left:0px;top:' 
			+ this.position.leftHeadTop + 'px;">';
	str += '</div>';
	this.leftBackground = _gtCreateElementWithHTML(str);
	return this.leftBackground;	
}

_p.initLeftHeadDIV = function(){

	var str = '<div style="position:absolute;overflow:hidden;height:' 
			+ this.position.leftHeadDivHeight + 'px;width:' 
			+ this.position.leftHeadDivWidth + 'px;left:0px;top:0px;">';
	str += '</div>';
	this.leftHeadDiv = _gtCreateElementWithHTML(str);
	return this.leftHeadDiv;
}

/*
 *
 * line functions
 *
 */
_p.newLine = function(data){
	var html = '<div class="grid-line" style="width:' 
		+ this.position.contentLineWidth + 'px;height:' 
		+ this.position.contentLineDivHeight + 'px;"><form></form>'
		+ '</div>';
	
	var line = _gtCreateElementWithHTML(html);
	var form = line.childNodes[0];
	line.form = form;
	var cell;
	
	for(var i=0; i<this.titleWidth.length; i++){
		if(data != null)
			cell = this._createLineField(data[i], i);
		else
			cell = this._createLineField("", i);
		cell.cellIndex = i;
		cell.row = line;
		form.appendChild(cell);
	}
	
	this._lineAttachEvent(line);
	
	line.cells = form.childNodes;
	return line;
}

_p._lineAttachEvent = function(line){
	line.attachEvent("onmouseover", _gtContentRowMouseOverEvent);
	line.attachEvent("onmouseout", _gtContentRowMouseOutEvent);
	line.attachEvent("onmousedown", _gtContentLineMouseDownEvent);
	line.attachEvent("onkeydown", _gtContentRowKeyDownEvent);
	line.attachEvent("ondblclick", _gtContentRowDblClickEvent);
}

_p.appendLine = function(line, index){
	this.areaDiv.appendChild(line);
	/*
	line.style.left = "0px";
	if(index != null)
		line.style.top = (index * this.position.contentLineHeight) + "px";
		*/
}

_p.createLineFieldHtml = function(text, i){
	var html = '<label class="grid-field" style="width:' 
		+ this.titleWidth[i] + 'px;height:' 
		+ this.position.contentLineHeight + 'px;text-align:' 
		+ this.titleAlign[i] + ';">' 
		+ text + '</label>';
	return html;
}

_p._createLineField = function (text, i){
	var html = this.createLineFieldHtml(text, i);
	var obj = _gtCreateElementWithHTML(html);
	return obj;
}

_p.appendRow = function(){
	/*
	var row = this._newRowObject();
	this.contentTable.tBodies[0].appendChild(row);
	if(this._interCrossStyle == true)
		this.setRowInterCrossStyle(row);
	var headRow = this._newLeftHeadRowObject();
	this.leftHeadTable.tBodies[0].appendChild(headRow);
	this.showOneLeftHeadRow();
	return row;
	*/
	var arr = new Array();
	for(var i=0; i<this.titleWidth.length; i++)
		arr[arr.length] = '';

	var row = this.appendRowWithValue(arr);
	row._createWithValue = false;
	return row;
}

/*
_p.createLineWithValue = function(id, arr){
	var row = this.appendRowWithValue(arr);
	this.setSelectedRow(row);
	this.setRowId(row, id);
}
*/

_p.appendRowWithValue = function(arr){
	/*
	var row = this.appendRow();
	for(var i=0; i<row.cells.length; i++){
		if(arr[i] == null)
			continue;
		row.cells[i].childNodes[0].innerHTML = arr[i];
	}
	*/

	var row = this._dmodel.appendRow(arr);

	var line = row.getLine();
	line._createWithValue = true;

	if(this._hasTotalLine == true)
		this.addRowTotal(line);
	return line;
}

/*
 *
 * line selecte
 *
 */
_p.selectPreviousRow = function(){
//	var row = this.areaDiv.firstChild;
	var row = this.getLastLine();
	if(this.selectedRow != null)
//		row = this.selectedRow.previousSibling;
		row = this.getPreviousLine(this.selectedRow);
	while(row != null){
		if(row.style.display != "none" && canBeOver(this, row) != false && canBeSelect(this, row) != false)
			break;
//		row = row.previousSibling;
		row = this.getPreviousLine(row);
	}
	if(row == null)
		return;
	this.setSelectedRow(row);
	gtDoKeySelect(this, this.getSelectedRow(), this.getSelectedId());
}

_p.selectNextRow = function(){
//	var row = this.areaDiv.firstChild;
	var row = this.getFirstLine();
	if(this.selectedRow != null)
//		row = this.selectedRow.nextSibling;
		row = this.getNextLine(this.selectedRow);
		
	while(row != null){
		if(row.style.display != "none" && canBeOver(this, row) != false && canBeSelect(this, row) != false)
			break;
//		row = row.nextSibling;
		row = this.getNextLine(row);
	}
			
	if(row == null)
		return;
	
	this.setSelectedRow(row);
	gtDoKeySelect(this, this.getSelectedRow(), this.getSelectedId());
	return true;
}

_p.scrollToIndex = function(index){
	var cdiv = this.contentDiv;
	var num = this.getContentLineNumber(); 
	var lheight = this.position.tdHeight;

	var s1 = num[2] + (num[3]>0 ? 1 : 0);
	var s2 = s1 + num[5] - 1;

	if(index < s1){
		cdiv.scrollTop = index * lheight;
	}if(index > s2)
		cdiv.scrollTop = (index+1-num[7]) * lheight - num[8];
}

_p.scrollToRow = function(row){
	this.scrollToIndex(row.rowIndex);
}

_p.getPreviousLine = function(line){
	var row = this._dmodel.getRowByLine(line);
	var prow = this._dmodel.getPreviousRow(row);
	if(prow == null)
		return null;
	this.repaintLines([line.rowIndex - 1, line.rowIndex - 1]);
	return prow.getLine();
}

_p.getNextLine = function(line){
	var row = this._dmodel.getRowByLine(line);
	var nrow = this._dmodel.getNextRow(row);
	if(nrow == null)
		return null;
	this.repaintLines([line.rowIndex + 1, line.rowIndex + 1]);
	return nrow.getLine();
}

_p.getFirstLine = function(){
	var row = this._dmodel.getFirstRow();
	if(row == null)
		return null;

	this.repaintLines([0, 10]);
	return row.getLine();
}

_p.getLastLine = function(){
	var row = this._dmodel.getLastRow();
	if(row == null)
		return null;

//	this._dmodel.repaintRow(row.getIndex());
	this.repaintLines([row.getIndex()-10, row.getIndex()]);
	return row.getLine();
}

/*****************************
*                            *
*          DataModel Object       *
*                            *	
******************************/

function DataModel(t){
	this._gt = t;
	this._tbody = t.oldTable.tBodies[0];

	this._rows = new Array();
	this._titles = new Array();
	this._length = 0;

	this._positions = new Array();

	this._init();
}

_p = DataModel.prototype;

_p.calSize = function(){
	var len = this.getLength();	
	
	this._gt.position.areaDivWidth = this._gt.getLineWidth();
	this._gt.position.areaDivHeight = this._gt.position.tdHeight * this.getLength();
	this._gt.position.leftHeadDivHeight = this._gt.position.tdHeight * this.getLength();
}

_p.getRowByLine = function(line){
	var index = parseInt(line.style.top) / this._gt.position.contentLineTopHeight;
	return this.getRow(index);
}

_p.getFirstRow = function(){
	if(this.getLength() < 0)
		return null;
	return this.getRow(0, true);
}

_p.getLastRow = function(){
	if(this.getLength() < 0)
		return null;
	return this.getRow(this.getLength() - 1, true);
}

_p.getPreviousRow = function(row){
	var index = row.getIndex();
	index --;
	if(index < 0 || index >= this.getLength())
		return null;
	return this.getRow(index, true);
}

_p.getNextRow = function(row){
	var index = row.getIndex();
	index ++;
	if(index < 0 || index >= this.getLength())
		return null;
	return this.getRow(index, true);
}

_p.setAreaWidth = function (w){
	this._gt.position.areaDivWidth = w;
}

_p.changeLength = function(z){
	this._length += z;
}

_p.getLength = function(){
	return this._length;
}

_p._init = function(){
	this._length = this._gt.oldTable.tBodies[0].rows.length;
}

_p.getRow = function(index, create){
	var row = this._rows[index];
	if(row != null)
		row._newIndex = index;
	else if(create == true)
		row = this.addRow(index);
	return row;
}

_p.addRow = function(index, data){
	var row = new GridRow(this, index, data);
	this._rows[index] = row;
	return row;
}

_p.setRowPosition = function(row, index){
	var line = row.getLine();
	line.style.left = "0px";
	if(index != null)
		line.style.top = (index * this._gt.position.contentLineTopHeight) + "px";
}

_p.appendRow = function(data){
	var row = this.addRow(this._length, data);
	
	this.changeLength(1);
	this.repaintArea();

	row.display();

	return row;
}

_p.removeRow = function(index){
	var row = this.getRow(index);
	var line = row.getLine();
	row.flush();
	delete row;
	this._rows.removeAt(index);

	this.changeLength(-1);
	this.repaintArea();
	this._gt._resetTitlePosition();
	this._gt.repaintScreen();
}

_p.addTitle = function(index){
	var title = this._titles[index];
	title = this._gt.newTitle(index);
	this._gt.appendTitle(title, index);
	this._titles[index] = title; 
}

_p.showTitle = function(index){
	var title = this._titles[index];
	if(title == null)
		this.addTitle(index);
}

_p.getTitle = function(index){
	return this._titles[index];
}

_p.repaintArea = function(){
	this.calSize();
	this._gt.areaDiv.style.height = this._gt.position.areaDivHeight;
	this._gt.leftHeadDiv.style.height = this._gt.position.areaDivHeight;
}

_p.repaintRow = function(index){
	var row = this.getRow(index);
	this.showTitle(index);
	if(row == null){
		row = this.addRow(index);
		row.display();
	}else
		row.repaint();
}

/*****************************
*                            *
*          GridRow Object       *
*                            *	
******************************/

function GridRow(model, index, data){
	this._id = '';

	this._model = model;
	this._gt = this._model._gt;
	this._index = index;

	this._data = data;
	this._createdByTable = false;
	if(this._data == null)
		this.initData();


	this._line = null;

	this.init();

	this._pained = false;
}

_p = GridRow.prototype;

_p.init = function(){
}

_p.getCell = function(n){
	this._gt.oldTable.tBodies[0].rows[this._index].cells[n].innerHTML;
}

_p.setLineId = function(id){
	this._id = this._gt._createRowId(id);
}

_p.getIndex = function(){
	return this._index;
}

_p.initData = function(){
	var r = this._gt.oldTable.tBodies[0].rows[this._index];
	_gtRemoveRowSpaceElement(r);
	var ret = new Array();
	for(var i=0; i<r.cells.length; i++)
		ret[ret.length] = r.cells[i].innerHTML;

	this._createdByTable = true;
	this._data = ret;

	if(r.id != null && r.id != "")
		this.setLineId(r.id);

	return ret;
}

_p.getTitle = function(){
	return this._model.getTitle(this._index);
}

_p.getData = function(){
	return this._data;
}

_p.display = function(){
	this._line = this._gt.newLine(this._data);
	this._gt.appendLine(this._line, this._index);
	this._model.setRowPosition(this, this._index);
	this._line.id = this._id;

	/*
	this._title = this._gt.newTitle(this._index);
	this._gt.appendTitle(this._title, this._index);
	*/
	this._model.showTitle(this._index);
	this._pained = true;

	this._line.rowIndex = this._index;
}

_p.repaint = function(){

	if(this._pained == false){
		this.display();
		return;
	}

	this.repaintColumnWidth();

	this.resetPosition();
}

_p.repaintColumnWidth = function(){
	var tw = this._gt.titleWidth;
	for(var i=0; i<tw.length; i++)
		this._line.cells[i].style.width = tw[i];
}

_p.changeIndex = function(index){
	this._index = index;
	this._line.rowIndex = index;
}

_p.resetPosition = function(){
	if(this._newIndex == this._index)
		return;

	this._model.setRowPosition(this, this._newIndex);
//	this._line.style.top = this._gt.position.contentLineHeight * this._newIndex;

	this.changeIndex(this._newIndex);
}

_p.getLine = function(){
	return this._line;
}

_p.flush = function(){
	this._gt.areaDiv.removeChild(this._line);
	if(this._createdByTable == true)
		this._model._tbody.removeChild(this._model._tbody.rows[this._index]);
}

/*****************************
*                            *
*          消息注册函数       *
*                            *	
******************************/

function _gtOuterDivMouseDownEvent(e){
	var table = gtTables.findTable(e.srcElement);
	if(table == null)
		return;
	gtTables.setFocusTable(table);
}

function _gtLeftRowMouseDownEvent(e){
	if(e.button != 1)
		return;	
	var tr = _gtFindParentNodeByTagName(e.srcElement, "TR");
	var table = gtTables.findTable(e.srcElement);
	var row = table.contentTable.tBodies[0].rows[tr.rowIndex];
	if(canBeOver(table, row) == false || canBeSelect(table, row) == false)
		return;	
	
	table.setSelectedRowByIndex(tr.rowIndex);
}

function _gtContentRowKeyDownEvent(e){
	var table = gtTables.findTable(e.srcElement);
	if(e.keyCode == 13){
		gtDoEnter(table, table.getSelectedRow(), table.getSelectedId());
		e.cancelBubble = true;
		return false;
	}
}

function _gtContentRowDblClickEvent(e){
	var row = _gtFindParentNodeByTagName(e.srcElement, "DIV");
	var table = gtTables.findTable(row);
	
	if(canBeOver(table, row) == false || canBeDbclick(table, row) == false)
		return;
	
	gtDoDblClick(table, table.getSelectedRow(), table.getSelectedId());	
}

function _gtContentRowMouseOutEvent(e){
	var tr = _gtFindParentNodeByTagName(e.srcElement, "DIV");
	if(tr == null)
		return;
	var table = gtTables.findTable(e.srcElement);
	if(table.getSelectedRow() != tr)
		table._gtChangeRowStyle(tr, "OUT");
}

function _gtContentRowMouseOverEvent(e){
	if(_gtTopHeadTableMouseDownEvent.start == true)
		return;
	var tr = _gtFindParentNodeByTagName(e.srcElement, "DIV");
	if(tr == null)
		return;
	var table = gtTables.findTable(e.srcElement);
	if(canBeOver(table, tr) == false)
		return;
	if(table.getSelectedRow() != tr)	
		table._gtChangeRowStyle(tr, "OVER");
}

function _gtContentLineMouseDownEvent(e){
	if(e.button != 1)
		return;	
	var cell = _gtFindParentNodeByTagName(e.srcElement, "LABEL");
	if(cell == null || cell.cellIndex == null)
		return;
	var table = gtTables.findTable(cell);
	table.setFocusCellIndex(cell.cellIndex);
	gtTables.setFocusTable(table);
	var row = _gtFindParentNodeByTagName(e.srcElement, "DIV");
	if(canBeOver(table, row) == false || canBeSelect(table, row) == false)
		return;
	table.setSelectedRow(row);
	gtDoSelect(table, table.getSelectedRow(), table.getSelectedId());
}

function _gtOuterDivKeyDownEvent(){
	var e = window.event;
	var table = gtTables.getFocusTable();
	var code = e.keyCode;
	if(code == 38){
		table.selectPreviousRow();
		return false;
	}else if(code == 40){
		table.selectNextRow();
		return false;
	}
}

function _gtOuterDivSelectStartEvent(e){
	if(e.srcElement != null){
		if(e.srcElement.tagName == "INPUT" && e.srcElement.type == "text")
			return true;
	}
	return false;
}

function _gtTopHeadTDMoveUpEvent(e){
	if(_gtTopHeadTableMouseDownEvent.start != true)
		return;
	
	_gtResizeTable(_gtTopHeadTDMouseMoveEvent.resizeObj, 
		 parseInt(e.clientX) - parseInt(_gtTopHeadTableMouseDownEvent.x));
	gtTables.findTable(_gtTopHeadTDMouseMoveEvent.resizeObj)._gtResetHeadPosition();
		
	_gtSetCursor("");
	_gtTopHeadTableMouseDownEvent.start = false;
}

function _gtTopHeadTDMouseDownEvent(e){
	if(e.button != 1)
		return;
		
	if( _gtTopHeadTDMouseMoveEvent.resizeObj != null)
		return;
	var obj = e.srcElement;
	td = _gtFindParentNodeByTagName(obj, "TD");
	var table = gtTables.findTable(obj);

	if(table.titleSort[td.cellIndex] == null)
		return;
	
	table._gtChangeSortImage(td);
	table._geSortContentTable();
	if(table._interCrossStyle == true)
		table.resetCrossStyle(); 
}

function _gtTopHeadTDDblClickEvent(e){
	if( _gtTopHeadTDMouseMoveEvent.resizeObj != null)
		return;
	var obj = e.srcElement;
	td = _gtFindParentNodeByTagName(obj, "TD");
	var table = gtTables.findTable(obj);

	if(table.titleSearch[td.cellIndex] != true)
		return;
		
	var key = window.prompt(td.innerText + ": ", "");
	if(key == null)
		return;
	table._geSearchContentTableCell(td, key);
	if(table._interCrossStyle == true)
		table.resetCrossStyle(); 
}

function _gtTopHeadTableMouseDownEvent(e){
	if(e.button != 1)
		return;	
	if( _gtTopHeadTDMouseMoveEvent.resizeObj == null)
		return;
	_gtTopHeadTableMouseDownEvent.start = true;
	_gtTopHeadTableMouseDownEvent.x = e.clientX;
}

function _gtTopHeadTDMouseOutEvent(e){
	if(_gtTopHeadTableMouseDownEvent.start == true)
		return;
	_gtSetCursor("");
}

function _gtTopHeadTDMouseMoveEvent(e){
	var obj = e.srcElement;
	
	if(obj.tagName == "IMG")
		return;
	
	td = _gtFindParentNodeByTagName(obj, "TD");
	td.table = gtTables.findTable(obj);
	var resizeObj = null;
	
	if(_gtTopHeadTableMouseDownEvent.start == true)
		return;

	if(e.offsetX <= 8 && td.cellIndex !=0)
		resizeObj = td.previousSibling;
	else if(e.offsetX+8 >= td.clientWidth)
		resizeObj = td;
	else 
		resizeObj = null;
	
	if(e.offsetY < 2 || e.offsetY > td.clientHeight-3)
		resizeObj = null;
		
	_gtTopHeadTDMouseMoveEvent.resizeObj = resizeObj;
	
	if(resizeObj != null)
		_gtSetCursor("col-resize");
	else
		_gtSetCursor("");
}

function _gtContentDivScrollEvent(e){
	_gtContentDivScrollEvent.obj = e.srcElement;

//	gtTables.findTable(obj);
//	table._gtResetHeadPosition();

/*
	if(_stContentDiv != null)
		_stContentDiv.style.display = "none";
*/

	if(_gtContentDivScrollEvent._timer != null)
		clearTimeout(_gtContentDivScrollEvent._timer);
	_gtContentDivScrollEvent._timer = setTimeout("_gtTestScroll()", 50);

	if(_gtContentDivScrollEvent._timer2 != null)
		clearTimeout(_gtContentDivScrollEvent._timer2);
	_gtContentDivScrollEvent._timer2 = setTimeout("_gtTestScroll2()", 100);
}

function _gtTestScroll(){
	gtTables.findTable(_gtContentDivScrollEvent.obj)._gtResetHeadPosition();
}

function _gtTestScroll2(){
	gtTables.findTable(_gtContentDivScrollEvent.obj).repaintScreen();
}

function _gtContentDivMouseDownEvent(e){
	var obj = e.srcElement;
	var table = gtTables.findTable(obj);
}

function gtResetTablesPosition(){
	for(var i=0; i<gtTables.tables.length; i++)
		gtTables.tables[i].resetTablePosition();
}

// 更改table obj列宽度，w 为增量
function _gtResizeTable(obj, w){
	var nwidth = parseInt(obj.childNodes[0].style.width) + w;
	var table = gtTables.findTable(obj);
	
	if(nwidth < 18)
		nwidth = 18;
	
	table.titleWidth[obj.cellIndex] = nwidth;
	if(table._hasTotalLine == true)
		table.totalRow.cells[table.totalInfo[obj.cellIndex].n].childNodes[0].style.width = 
				parseInt(table.totalRow.cells[table.totalInfo[obj.cellIndex].n].childNodes[0].style.width)
				- parseInt(obj.childNodes[0].style.width) + nwidth;
	obj.childNodes[0].style.width = nwidth + "px";

	table.repaintScreen();
	/*
	for(var i=0; i<table.contentTable.tBodies[0].rows.length; i++)
		table.contentTable.tBodies[0].rows[i].cells[obj.cellIndex].childNodes[0].style.width = nwidth + "px";
		*/

	table.position.topHeadDivWidth = table.getLineWidth();

	table._dmodel.setAreaWidth(table.getLineWidth());
	table.areaDiv.style.width = table.position.areaDivWidth + "px";
}
/*****************************
*                            *
*    cell  排序函数          *
*                            *	
******************************/
function gtNumberCompare(a,b){
	var an, bn;
	an = parseFloat(gtGetInnerTextWithInput(a).replace(/,/g, ""));
	if(an == null || isFinite(an) == true)
		an = 0;
	bn = parseFloat(gtGetInnerTextWithInput(b).replace(/,/g, ""));	
	if(bn == null || isFinite(bn) == true)
		bn = 0;
	return an-bn;
}

function gtGetDateArray(datestr){
	var arr = datestr.split("-");
	return [parseInt(arr[0]),parseInt(arr[1])-1,parseInt(arr[2])];
}

function gtGetDateObj(datestr){
	var arr = gtGetDateArray(datestr);
	return new Date(arr[0],arr[1],arr[2]-1);
}

function gtDateCompare(a,b){
	var an, bn;
	an = gtGetInnerTextWithInput(a);
	if(an == null || an == "")
		an = "1970-1-1";
	bn = gtGetInnerTextWithInput(b);
	if(bn == null || bn == "")
		bn = "1970-1-1";
	
	return gtGetDateObj(an).getTime() - gtGetDateObj(bn).getTime();
}

function gtStringCompare(a,b){
	var an, bn;
	an = gtGetInnerTextWithInput(a);
	if(an == null)
		an = "";
	bn = gtGetInnerTextWithInput(b);
	if(bn == null)
		bn = "";
	
	if(an<bn)
		return -1;
	else if(an > bn)
		return 1;
	else
		return 0;
}
/*****************************
*                            *
*          常用方法          *
*                            *	
******************************/
// 获得element
function _gtGetElement(id){
	return document.getElementById(id);
}

function _gtCreateElementWithHTML(str){
	var d = document.createElement("DIV");
	d.innerHTML = str;
	
	return d.childNodes[0];
}

function gtCreateTRWithHTML(str){
	return _gtCreateElementWithHTML('<table>' + str + '</table>').tBodies[0].rows[0];
}

function _gtCreateTextNode(str){
	return document.createTextNode(str);
}

function _gtCreateDivElementWithHTML(str){
	var d = document.createElement("DIV");
	d.innerHTML = str;
	
	return d;
}

function _gtFindParentNodeById(obj, id){
	var p = obj;
	while(p != null && p.tagName != "BODY"){
		if(p.id == id)
			return p;
		p = p.parentNode;
	}
	return null;
}

function _gtFindParentNodeByTagName(obj, tagname){
	var p = obj;
	while(p != null && p.tagName != "BODY"){
		if(p.tagName == tagname)
			return p;
		p = p.parentNode;
	}
	return null;
}

function _gtSetCursor(c){
	document.body.style.cursor = c;
}

// 寻找 childs by tagName
function _gtFindChildsByTagName(obj, name){
	return obj.getElementsByTagName(name);
}

function _gtFindChildsCheckBox(obj){
	var ret = new Array();
	var cs = _gtFindChildsByTagName(obj, "INPUT");
	for(var i=0; i<cs.length; i++){
		if(cs[i].type == "checkbox")
			ret[ret.length] = cs[i];
	}
	return ret;
}

function _gtFindChildByTagName(obj, name){
	var childs = _gtFindChildsByTagName(obj, name);
	if(childs != null && childs.length > 0)
		return childs[0];
	return null;
}

function _gtFindTdInputElement(obj){
	var input, node;
//	var label = obj.childNodes[0];
	var label = obj;
	if(label.hasChildNodes() == false)
		return null
	
	for(var i=0; i<label.childNodes.length; i++){
		node = label.childNodes[i];
		if(node.tagName == "INPUT" && (node.type == "checkbox" || node.type == "text"))
			return node;
		if(node.tagName == "SELECT")
			return node;
	}
	return null;
}

function _gtHTMLWithOutText(obj){
	return _gtHTMLWithOutTextAndTag(obj);
}

function _gtHTMLWithOutTextAndTag(obj, tag){
	var str = "<div>" + obj.innerHTML + "</div>";
	var d = _gtCreateElementWithHTML(str);
	if(d.hasChildNodes() == true)
		for(var i=0; i<d.childNodes.length; i++){
			if(d.childNodes[i].nodeType == 3){
				d.removeChild(d.childNodes[i]);
				i--;
				continue;
			}else if(d.childNodes[i].nodeType == 1 && d.childNodes[i].tagName == "LABEL"){
				d.removeChild(d.childNodes[i]);
				i--;
				continue;
			}
			if(tag != null)
				if(d.childNodes[i].nodeType == 1 && d.childNodes[i].tagName == tag && d.childNodes[i].type != 'hidden'){
					d.removeChild(d.childNodes[i]);				
					i--;
					continue;
				}
		}
	return d.innerHTML;
}

function _gtRemoveRowSpaceElement(row){
	var cell, node, tnode;
	var re = /^\s*$/;
	for(var i=0; i<row.cells.length; i++){
		cell = row.cells[i];
		if(cell.hasChildNodes() == false)
			continue;
		for(var j=0; j<cell.childNodes.length; j++){
			node = cell.childNodes[j];
			if(node.nodeType == 3){
				if(re.test(node.data) == true){
					node.parentNode.removeChild(node);
					j--;
					continue;
				}else{
					tnode = _gtCreateTextNode(node.data.trim());
					node.parentNode.replaceChild(tnode, node);
				}
			}
		}
	}
}

function _gtGetInnerText(obj){
	var str = "<div>" + obj.innerHTML + "</div>";
	var d = _gtCreateElementWithHTML(str);
	if(d.hasChildNodes() == true)
		for(var i=0; i<d.childNodes.length; i++){
			if(d.childNodes[i].nodeType == 1 && d.childNodes[i].tagName == "SELECT"){
				d.removeChild(d.childNodes[i]);	
				i--;
			}
		}
	return d.innerText;
}

function gtTrim(str){
	return str.replace(/^\s*/, '').replace(/\s*$/, '');
}

function gtGetSelectValue (sel){
	return sel.options[sel.selectedIndex].text;
}

function gtGetInnerTextWithInput(cell){
//	var d = _gtFindChildByTagName(cell, "LABEL");
	var d = cell;
	var node;
	
	var str = "";
	
	if(d.hasChildNodes() == true)
		for(var i=0; i<d.childNodes.length; i++){
			node = d.childNodes[i];
			if(node.nodeType == 3){
				str += node.data;
			}else if(node.nodeType == 1){
				if(node.tagName == "INPUT" && node.type == "text")
					str += node.value;
				else if(node.tagName == "SELECT")
					str += gtGetSelectValue(node);
			} 
		}
	return str;
}

function getShowText(obj){
	var tnode;
	var d = _gtCreateElementWithHTML("<div>" + obj.innerHTML + "</div>");
	
	var ins = _gtFindChildsByTagName(d, "INPUT");
	for(var i=0; i<ins.length; i++){
		if(ins[i].type != "text")
			continue;
		tnode = _gtCreateTextNode(ins[i].value);
		ins[i].parentNode.replaceChild(tnode, ins[i]);
	}
	return d.innerText;
}

function _geSetFormValue(form, name, value){
	var e;
	for(var i=0; i<form.elements.length; i++){
		e = form.elements[i];
		if(e.name == name)
			e.value = value;
	}
}
