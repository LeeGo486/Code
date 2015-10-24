// ²Ëµ¥º¯Êý

document.onmouseover = doDocumentOnMouseOver;
document.onmouseout = doDocumentOnMouseOut;

function doDocumentOnMouseOver()
{
	var eSrc = window.event.srcElement;
	if (eSrc.className == "item")
	{
		window.event.srcElement.className = "highlight";
	}
}

function doDocumentOnMouseOut()
{
	var eSrc = window.event.srcElement;
	if (eSrc.className == "highlight")
	{
		window.event.srcElement.className = "item";
	}
}

var bV=parseInt(navigator.appVersion);
NS4=(document.layers) ? true : false;
IE4=((document.all)&&(bV>=4)) ? true : false;
DOM=(!document.layers && !document.all && bV>=4) ? true : false; // A hack to guess if the browser supports the DOM
capable = (NS4 || IE4 || DOM) ? true : false;

function expandIt(){return}
function expandAll(){return}

isExpanded = false;

function getIndex(el)
{
	ind = null;
	for (i=0; i<document.layers.length; i++)
	{
		whichEl = document.layers[i];
		if (whichEl.id == el)
		{
			ind = i;
			break;
		}
	}
	return ind;
}

function arrange()
{
	nextY = document.layers[firstInd].pageY + document.layers[firstInd].document.height;
	for (i=firstInd+1; i<document.layers.length; i++)
	{
		whichEl = document.layers[i];
		if (whichEl.visibility != "hide")
		{
			whichEl.pageY = nextY;
			nextY += whichEl.document.height;
		}
	}
}

function initIt()
{
	if (NS4)
	{
		for (i=0; i<document.layers.length; i++)
		{
			whichEl = document.layers[i];
			if (whichEl.id.indexOf("Child") != -1) whichEl.visibility = "hide";
		}
		arrange();
	}
	else if(IE4)
	{
		tempColl = document.all.tags("DIV");
		for (i=0; i<tempColl.length; i++)
		{
			if (tempColl(i).className == "child") tempColl(i).style.display = "none";
		}
	}
	else if(DOM)
	{
		tempColl = document.getElementsByTagName("DIV");
		for (i=0; i<tempColl.length; i++)
		{
			if (tempColl(i).className == "child") tempColl(i).style.visibility = "hidden";
		}
	}
}

function expandIt(el)
{
	if (!capable) return;
	if (IE4)
	{
		expandIE(el);
	}
	else if(NS4)
	{
		expandNS(el);
	}
	else if(DOM)
	{
		expandDOM(el);
	}
}

function expandIE(el)
{
	whichEl = eval(el + "Child");
	whichIm = eval(el + "Img");

	if (whichEl.style.display == "none")
	{
		whichEl.style.display = "block";
		whichIm.src = www_url + "midopenedfolder.gif";
	}
	else
	{
		whichEl.style.display = "none";
		whichIm.src = www_url + "midclosedfolder.gif";
	}
	window.event.cancelBubble = true ;
}

function expandNS(el)
{
	whichEl = eval("document." + el + "Child");
	whichIm = eval("document." + el + "Parent.document.images['imEx']");
	if (whichEl.visibility == "hide")
	{
		whichEl.visibility = "show";
		whichIm.src = www_url + "midopenedfolder.gif";
	}
	else
	{
		whichEl.visibility = "hide";
		whichIm.src = www_url + "midclosedfolder.gif";
	}
	arrange();
}

function expandDOM(el)
{
	whichEl = document.getElementById(el + "Child");
	whichIm = document.getElementById(el + "Img");

	if (whichEl.style.visibility != "visible")
	{
		whichEl.style.visibility = "visible";
		whichIm.src = www_url + "midopenedfolder.gif";
	}
	else
	{
		whichEl.style.visibility = "hidden";
		whichIm.src = www_url + "midclosedfolder.gif";
	}
}

function showAll()
{
	for (i=firstInd; i<document.layers.length; i++)
	{
		whichEl = document.layers[i];
		whichEl.visibility = "show";
	}
}

function expandAll(isBot)
{
	newSrc = (isExpanded) ? www_url + "midopenedfolder.gif" : www_url + "midclosedfolder.gif";

	if (NS4)
	{
		for (i=firstInd; i<document.layers.length; i++)
		{
			whichEl = document.layers[i];
			if (whichEl.id.indexOf("Parent") != -1)
			{
				whichEl.document.images["imEx"].src = newSrc;
			}
			if (whichEl.id.indexOf("Child") != -1)
			{
				whichEl.visibility = (isExpanded) ? "hide" : "show";
			}
		}
		arrange();

		if (isBot && isExpanded) scrollTo(0,document.layers[firstInd].pageY);
	}
	else if(IE4)
	{
		divColl = document.all.tags("DIV");
		for (i=0; i<divColl.length; i++)
		{
			if (divColl(i).className == "child")
			{
				divColl(i).style.display = (isExpanded) ? "none" : "block";
			}
		}
		imColl = document.images.item("imEx");
		for (i=0; i<imColl.length; i++)
		{
			imColl(i).src = newSrc;
		}
	}
	else if(DOM)
	{
		divColl = document.getElementsByTagName("DIV");
		for (i=0; i<divColl.length; i++)
		{
			if (divColl(i).className == "child")
			{
				divColl(i).style.visibility = (isExpanded) ? "hidden" : "visible";
			}
		}
		imColl = document.getElementsByName("imEx");
		for (i=0; i<imColl.length; i++)
		{
			imColl(i).src = newSrc;
		}
	}
	isExpanded = !isExpanded;
}
onload = initIt;
