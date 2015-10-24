document.write("<img id=imgStar1 src=Images/Star/star-off.gif><img id=imgStar2 src=Images/Star/star-off.gif><img id=imgStar3 src=Images/Star/star-off.gif><img id=imgStar4 src=Images/Star/star-off.gif><img id=imgStar5 src=Images/Star/star-off.gif>")

if (navigator.userAgent.toLowerCase().indexOf("firefox")!=-1) {

	Object.prototype.attachEvent = function(type, fc){
		this.addEventListener(type.toLowerCase().replace(/^on/ig, ""), fc, false);
	};
	
	Object.prototype.detachEvent = function(type, fc){
		this.removeEventListener(type.toLowerCase().replace(/^on/ig, ""), fc, false);
	};

	Event.prototype.__defineGetter__("srcElement", function () {
		var node = this.target;
		while (node.nodeType != 1) node = node.parentNode;
		return node;
	});
}

function voteBase(nValue)
{

	if(ThreadID != null)
	{
		var xmlHttp = Ajax_GetXMLHttpRequest();
		var RequestUrl = "Loading.asp?Menu=Threadstar&ThreadID=" + ThreadID + "&Rate=" + nValue + "&" + Math.random();

		xmlHttp.onreadystatechange = function(){
			if (xmlHttp.readyState == 4)
			{
			showData(xmlHttp.responseText);
			}
		};
		xmlHttp.open("POST", RequestUrl, true);
		xmlHttp.send(null);
	}
}

function showData(avgVoteScore)
{
	var canBeFull = false;
	for(var i=5; i>=1; i--)
	{
		temp = document.getElementById("imgStar" + i);
		if(temp != null)
		{
			if(canBeFull == false)
			{
				if(i - avgVoteScore <= 0.5 && temp != null)
				{
					canBeFull = true;
					temp.src = i - avgVoteScore <0.5 ? "Images/Star/star-on.gif" : "Images/Star/star-half.gif";
				}
				else
					temp.src = "Images/Star/star-off.gif"
			}
			else
			{
				temp.src = "Images/Star/star-on.gif";
			}

			temp.nValue = i;
			temp.defaultImage = temp.src;
		}
	}
	setEvent();
}

function votePoint(event)
{
	var evt = window.event ? window.event : event;
	var element = evt.srcElement;
	if(element != null && confirm('您确定将其评为 '+element.nValue+' 星级?'))
	{
		voteBase(element.nValue);
	}
}
var TigArray = ["非常差", "差", "好", "很好", "非常好"];

function OnMouseOverImgStar(event)
{
	if(typeof(imgStarMouseEvent) != "undefined")
		clearTimeout(imgStarMouseEvent);
	var evt = window.event ? window.event : event;
	var element = evt.srcElement;
	if(element != null)
	{
		var n = element.nValue;
		for(var i=1; i<=5; i++)
		{
			var temp = document.getElementById("imgStar" + i);
			if(temp != null)
			{
				temp.src = i <= n ? "Images/Star/star-on.gif" : "Images/Star/star-off.gif";
			}
			temp.alt=TigArray[i-1];
		}
	}
}

var imgStarMouseEvent;

function OnMouseOutImgStar(event)
{
	imgStarMouseEvent = setTimeout(function(){
	for(var i=1; i<=5; i++)
	{
		var temp = document.getElementById("imgStar" + i);
		if(temp != null)
			temp.src = temp.defaultImage;
		}
	}, 100);
}

function setEvent()
{
	for(var i=1; i<=5; i++)
	{
		var element = document.getElementById("imgStar" + i);
		if(element != null)
		{
			element.detachEvent("onclick", votePoint);
			element.detachEvent("onmouseover", OnMouseOverImgStar);
			element.detachEvent("onmouseout", OnMouseOutImgStar);
		
			element.attachEvent("onclick", votePoint);
			element.attachEvent("onmouseover", OnMouseOverImgStar);
			element.attachEvent("onmouseout", OnMouseOutImgStar);
			element.style.cursor = "pointer";
		}
	}
}