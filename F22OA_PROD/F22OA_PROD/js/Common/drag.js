// JScript 文件

Number.prototype.NaN0=function(){return isNaN(this)?0:this;}
var iMouseDown  = false;
var dragObject  = null;
var curTarget   = null;

function makeDraggable(item){
	if(!item) return;
	item.onmousedown = function(ev){
		dragObject  = this;
		mouseOffset = getMouseOffset(this, ev);
		return false;
	}
}

function makeUndraggable(item){
    if(!item) return;
    item.onmousedown = function(){}
}

function getMouseOffset(target, ev){
	ev = ev || window.event;

	var docPos    = getPosition(target);
	var mousePos  = mouseCoords(ev);
	return {x:mousePos.x - docPos.x, y:mousePos.y - docPos.y};
}

function getPosition(e){
	var left = 0;
	var top  = 0;
	while (e.offsetParent){
		left += e.offsetLeft + (e.currentStyle?(parseInt(e.currentStyle.borderLeftWidth)).NaN0():0);
		top  += e.offsetTop  + (e.currentStyle?(parseInt(e.currentStyle.borderTopWidth)).NaN0():0);
		e     = e.offsetParent;
	}

	left += e.offsetLeft + (e.currentStyle?(parseInt(e.currentStyle.borderLeftWidth)).NaN0():0);
	top  += e.offsetTop  + (e.currentStyle?(parseInt(e.currentStyle.borderTopWidth)).NaN0():0);

	return {x:left, y:top};

}

function mouseCoords(ev){
	if(ev.pageX || ev.pageY){
		return {x:ev.pageX, y:ev.pageY};
	}
	return {
		x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
		y:ev.clientY + document.body.scrollTop  - document.body.clientTop
	};
}

function mouseDown(ev){
    if(ev==undefined){
        return;
    }
	ev         = ev || window.event;
	var target = ev.target || ev.srcElement;

	if(target.onmousedown || target.getAttribute('DragObj')){
		return false;
	}
}

function mouseUp(ev){
	dragObject = null;
	iMouseDown = false;
}


function mouseMove(ev){
	ev         = ev || window.event;

	/*
	We are setting target to whatever item the mouse is currently on

	Firefox uses event.target here, MSIE uses event.srcElement
	*/
	var target   = ev.target || ev.srcElement;
	var mousePos = mouseCoords(ev);

	if(dragObject){
		dragObject.style.position = 'absolute';
		dragObject.style.top      = mousePos.y - mouseOffset.y;
		dragObject.style.left     = mousePos.x - mouseOffset.x;
	}

	// track the current mouse state so we can compare against it next time
	lMouseState = iMouseDown;

	// this prevents items on the page from being highlighted while dragging
	if(curTarget || dragObject) return false;
}

document.onmousemove = mouseMove;
document.onmousedown = mouseDown;
document.onmouseup   = mouseUp;
