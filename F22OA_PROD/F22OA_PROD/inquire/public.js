function showMD(url,width,height){
  var m=showModalDialog(url,window,"dialogWidth:"+width+"px;dialogHeight:"+height+"px;center: yes;help:no;resizable:yes;status:no");
	return m;
}

function moveUp(oSelect,isTop)
{
if(isTop==null)
        var isTop=false;
       //多选--------------------------------------------------------
if(oSelect.multiple)
{
     for(var i=0;i<oSelect.options.length;i++)
     {
      //设置移动到顶部----
      if(isTop)
      {
       if(oSelect.options[i].selected)
       {
        var moveIndex=i;
        while(moveIndex>0 && !oSelect.options[moveIndex-1].selected)
        {
         oSelect.options[moveIndex].swapNode(oSelect.options[moveIndex-1]);
         moveIndex--;
        }
       }
      }
      //未设置移动到顶部----
      else
      {
       if(oSelect.options[i].selected)
       {
        if(i>0)
        {
         if(!oSelect.options[i-1].selected)
         {
          oSelect.options[i].swapNode(oSelect.options[i-1]);
         }
        }
       }
      }
     }
}
        //单选--
     else
     {
      var i=oSelect.selectedIndex;
      if(i<=0)
           return;
         if(isTop)
      {
       while(i>0)
       {
        oSelect.options[i].swapNode(oSelect.options[i-1]);
        i--;
       }
      }
      else
      {
       oSelect.options[i].swapNode(oSelect.options[i-1]);
      }
     }
}

/*****************************************************
* function Name:moveDown
* @param {Object}     oSelect:源列表框
* @param {Object} isBottom:是否移动到底端
*                             true:是,false:否
*****************************************************/
function moveDown(oSelect,isBottom)
{
//设置默认
       if(isBottom==null)
	 var isBottom=false;
var selLength=oSelect.options.length-1;
//多选
if(oSelect.multiple)
{
     for(var i=selLength;i>=0;i--)
     {
      if(isBottom)
      {
       if(oSelect.options[i].selected)
       {
        var moveIndex=i;
        while(moveIndex<selLength && !oSelect.options[moveIndex+1].selected)
        {
         oSelect.options[moveIndex].swapNode(oSelect.options[moveIndex+1]);
         moveIndex++;
        }
       }
      }
      else
      {
       if(oSelect.options[i].selected)
       {
        if(i<selLength)
        {
         if(!oSelect.options[i+1].selected)
            {
            oSelect.options[i].swapNode(oSelect.options[i+1]);
            }
        }
       }
      }
     }
}
//单选
else
{
     var selIndex = oSelect.selectedIndex;
            if(selIndex >= selLength - 1)
                return;
            //如果设置了移动到顶端标志
            if(isBottom)
            {
                while(selIndex < selLength - 1)
                {
                    oSelect.options[selIndex].swapNode(oSelect.options[selIndex + 1]);
                    selIndex ++;
                }
            }
            //没有设置移动到顶端标志
            else  
      {
       oSelect.options[selIndex].swapNode(oSelect.options[selIndex + 1]);
      }    
       }  
}

/**************************************************************************
    * filename:moveValue
    * oData: 源列表框对象 
    * oPurpose: 目的列表框对象
    *************************************************************************/
function moveValue(oData,oPurpose)
{
       //建立存储value和text的缓存数组
       var arrSelValue = new Array();
       var arrSelText = new Array();
       //此数组存贮选中的options，以value来对应
       var arrValueTextRelation = new Array();
       var index = 0;//用来辅助建立缓存数组
     
       //存储源列表框中所有的数据到缓存中，并建立value和选中option的对应关系
       for(var i=0; i<oData.options.length; i++)
       {
           if(oData.options[i].selected)
           {
               //存储
               arrSelValue[index] = oData.options[i].value;
               arrSelText[index] = oData.options[i].text;
               //建立value和选中option的对应关系
               arrValueTextRelation[arrSelValue[index]] = oData.options[i];
               index ++;
           }
       }
     
       //增加缓存的数据到目的列表框中，并删除源列表框中的对应项
    var order=oPurpose.options;
    var flag=true;
       for(var i=0; i<arrSelText.length; i++)  
       {
           //增加
           var oOption = document.createElement("option");
           oOption.text = arrSelText[i];
           oOption.value = arrSelValue[i];
     for(var j=0;j<order.length;j++)
     {
      if(order[j].text==oOption.text)
     {
      flag=false;
      break;
     }
     }
     if(flag==true)
     {
              oPurpose.add(oOption);
     }
           //删除源列表框中的对应项
           oData.removeChild(arrValueTextRelation[arrSelValue[i]]);
       }
}

/*********************************
* filename:deleteSelectItem
* 功能：删除选定项目
* oSelect: 源列表框对象 
*********************************/
function deleteSelectItem(oSelect)
{
      for(var i=0; i<oSelect.options.length; i++)
      {
          if(i>=0 && i<=oSelect.options.length-1 && oSelect.options[i].selected)
          {
              oSelect.options[i] = null;
              i --;
          }
      }
}
function allselect(act,val){
	var dptList=document.getElementById('dptList');
	var dptList2=document.getElementById('dptList2');
	if(act=='adds'){
			var opt = dptList2.getElementsByTagName("OPTION");
			for(i=0;i<opt.length;i++){
				opt[i].selected=true;
			}
			moveValue(dptList2,dptList);
	}else if(act=='removes'){
			var opt = dptList.getElementsByTagName("OPTION");
			for(i=0;i<opt.length;i++){
				opt[i].selected=true;
			}
			moveValue(dptList,dptList2);
	}else if(act=='add'){
			var opt = dptList2.getElementsByTagName("OPTION");
			for(i=0;i<opt.length;i++){
				optval = opt[i].value.toUpperCase();
				if(optval.indexOf(val)==0){
				opt[i].selected=true;
				}
			}
			/*先将符合要求的option选中，后执行此js*/
			moveValue(dptList2,dptList);
	}else if(act=='remove'){
			var opt = dptList.getElementsByTagName("OPTION");
			for(i=0;i<opt.length;i++){
				optval = opt[i].value.toUpperCase();
				if(optval.indexOf(val)==0){
				opt[i].selected=true;
				}
			}
			/*先将符合要求的option选中，后执行此js*/
			moveValue(dptList,dptList2);
	}
}

