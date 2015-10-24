//----------------------------隐藏脚本出错提示框-----------------------------------//
	window.onerror = function(){return true;}

//---------------------new javascript for Ext------------------//

//新标签打开消息内容
function showMsg(t){
	//如果有最新的图片，点击该连接后会自动隐藏 by jackie
	var aa  = t.getElementsByTagName("img");
	if(aa.length>0){
		aa[(aa.length-1)].style.display="none";
	}
	LoadClass(t.href,RemoveHTML(t.innerHTML));
	
	return false;
}

//新标签打开消息内容
function refreshTab(id){
	var mainpanel = top.Ext.getCmp("doc-body");
	if(id==0){
		id = mainpanel.getActiveTab().id;
	}
	
	var fid = id.replace("docs-","iframe-");
	var frm = top.frames[fid];
	var title = id.replace("docs-","");
	
	var tab = top.Ext.getCmp(id);
	if(tab){
		
		//方法一:关闭当前标签,再生成一个
		//mainPanel.remove(id);
		//mainPanel.loadClass(href,title)
		
		//方法二:直接当前标签内的框架
		if(frm){
			var subFrm = top.frames[fid].frames["main"];
			if(subFrm){
			subFrm.location.reload();
			}else{
			frm.location.reload();
			}
		}
	}
}

//新标签打开消息内容
function closeTab(title){
	
		var mainpanel = top.Ext.getCmp('doc-body');
		var id;
		if(title==0){			//关闭当前
			id = mainpanel.getActiveTab().id;
		}else if(title.indexOf("docs-")!=0){	//仅是标题
			id = "docs-" + title;
		}else{						//直接传ID过来
			id = title;
		}
		
		//判断该ID是否存在
		var tab = top.Ext.getCmp(id);
		if(tab){
			mainpanel.remove(id);
		}
}

//过滤HTML标签
function RemoveHTML(strText){
	var regEx = /<[^>]*>/g;
	strText=strText.replace(regEx, "");
	//strText=strText.replace("&","");
	strText=strText.replace("'","");
	strText=strText.replace("\"","");
	return strText;
}

//加载新的标签
function LoadClass(url,title){
	var Ext = top.Ext;
	if(Ext){
		var mainpanel = Ext.getCmp('doc-body');
		//新标签打开
		mainpanel.loadClass(url,title);
	}
}

//代替旧的窗口加载方法
function LoadWindow(url,width,height,title,modal,x,y){
	var mainpanel = top.Ext.getCmp('doc-body');
	//----弹出窗口涉及到的参数------------------------
	//----url:窗口路径,width:窗口宽度,height:窗口高度
	//----title:标题,modal:打开时不可以做其它操作
	//----------------------------
	
	if(title.length<=0){title = "unnamed"}else{title=RemoveHTML(title)};
	
	//获取父框架的ID
	var mgid = mainpanel.getActiveTab().id;
	//检查是否有旧的窗口打开
	var oldwin = top.Ext.getCmp('win-' + title);
	if(oldwin){
		oldwin.close();//存在则关闭，否则创建
	}else{
		//定义一个内嵌框架
		var iframe  ='<iframe frameborder="0" width="100%" height="100%" src="isprit//'+url+'" scrolling="auto"></iframe>';
		
		//创建窗口
		var ExtWin = new top.Ext.Window({
			id: 'win-' + title,
			title: title,
			width: width,
			height: height,
			x:x,
			y:y,
			minWidth: width/2,
			minHeight: height/2,
			layout: 'fit',
			shadow:false,
			plain:true,
			modal:modal,//不能操作其它
			maskDisabled:false,
			html:iframe
		});
		ExtWin.show();
	}
}

//判断是否在新窗口打开
function chkNewTab(tabName,keyword){
//tabName
	var title = top.Ext.getCmp("doc-body").getActiveTab().title;
	var href = location.href;
	if(title.search(keyword)<=0){
		history.go(-1);
		refreshTab(title);
		LoadClass(href,tabName);
	}
}

//关闭窗口
function CloseWindow(t){
	var tWin = top.Ext.getCmp('win-' + t);
	if(tWin){
		tWin.close();//存在则关闭，否则创建
	}
}


//使用LoadWindow打开窗口时，负值给当前窗口中某个ID的值
function setParentValue(id,val,type){
	//id:负给该ID的val值
	//type:三种类型[add:增加,remove:移除符合val的内容,only:仅val]
	var f = "iframe-" + getActiveTab('title');
	var ifrm = top.document.frames ? top.document.frames[f].document : top.document.getElementById(f).contentDocument;
	
	if(ifrm){
		var target = ifrm.getElementById(id);
		//确定该ID的存在
		if(target){
			if(type=="add"){
				target.value += val;
			}else if(type=="remove"){
				target.value = target.value.replace(val);
			}else if(type=="html"){
				target.innerHTML = val;
			}else{
				target.value = val;
			}
		//}else{
		//	alert("ID "+id+" 不存在!请向管理员反馈此问题!")
		}
	}
}

//----------变样式的------------
function chgStyle(_this,color,background){

if(_this){
		_this.style.color = color;
		_this.style.background = background;
	}
}

//----------格式化表格的样式------------
function jsTable(tab,layout,width,tWidth,align){
	/*
		tab		//需要应用的表格的父ID
		layout		//左右,还是上下结构
		width	//表格宽度
		tWidth	//标头宽度 [上下结构的标头宽度由多个组成] 
		align	//表格位置
	*/

	var table = document.getElementById(tab);
	
	//是否存在
	if(table){
		//table.style.padding="10px";
		//确定该ID里面有Table
		var tabs = table.getElementsByTagName("table");
		if(tabs.length>0){
			//取得该Table下级应为无关的Table
		
			//循环Table
			for(var t=0;t<tabs.length;t++){
					var subtabs = tabs[t].getElementsByTagName("TABLE");
					if(subtabs.length>0){
						for(var g=0;g<subtabs.length;g++){
							subtabs[g].lang="zh";	//将所有table加上标识以便下次识时不将此标签做格式化处理
							var suball = subtabs[g].getElementsByTagName("TD");
								for(var ga=0;ga<suball.length;ga++){
									suball[ga].lang="zh"; //将所有table里面的标签都加上标识以便下次识时不将此标签做格式化处理
								}
						}
					}
				if(tabs[t].lang!="zh"){
					 tabs[t].border="0";
					 tabs[t].style.border="none";
					 tabs[t].cellPadding="5";
					 tabs[t].cellSpacing="1";
					 tabs[t].align=align;
					 tabs[t].style.width=width;
					 tabs[t].style.background="#99bbe8";
					 tabs[t].style.fontSize="12px";
					 tabs[t].style.fontFamily="tahoma";
					 tabs[t].style.margin="10px 0 0 0";
					 tabs[t].style.clear="both";
				}
				
					
			//确定TR
				var trs = tabs[t].getElementsByTagName("tr");
				if(trs.length>0){
				
				//循环Tr
					for(var r=0;r<trs.length;r++){
					
					//确定TD
						var tds = trs[r].getElementsByTagName("td");
						if(tds.length>0){
						//循环TD
							for(var d=0;d<tds.length;d++){
								if(tds[d].lang!="zh"){
									if(r==0&&layout=='tm'){
										if(tWidth!=''){
											var tw = tWidth.split("|");
											if(d<tw.length){
												//alert(tw[d])
												tds[d].style.width=''+tw[d]+'';	//标头宽度（多个值，由"|"符号分开）
											}
										}
										//上下结构的标头
										tds[d].style.background="#d9e5f4";						//标头背景色
										tds[d].style.borderTop="solid 1px #f0f5fa";		//反光效果
										tds[d].style.borderLeft="solid 1px #f0f5fa";	//反光效果
										tds[d].style.textAlign="center";		//字体居中
										tds[d].style.color="#15428b";		//标头字体颜色
										
									}else if((d==0 || tds[d].className=='jsTitle' )&&layout=='lr'){
									
									//左右结构的标头
										tds[d].style.background="#d9e5f4";						//标头背景色
										tds[d].style.borderTop="solid 1px #f0f5fa";		//反光效果
										tds[d].style.borderLeft="solid 1px #f0f5fa";	//反光效果
										tds[d].style.color="#15428b";		//标头字体颜色
										tds[d].style.width=tWidth;		//标头宽度
										var thtml = tds[d].innerHTML.toUpperCase();		//将冒号转为全角的（这样比较标准点）
										if(thtml.indexOf(":")>0&&thtml.indexOf("<INPUT")<0){	//过虑掉带按钮的。
										tds[d].innerHTML = tds[d].innerHTML.replace(":","：");
										}
										
									}else{
										tds[d].style.background="#FFF";
									}
								}
								
							}
						}
					}
				}
			}
		}
	}
}


//限定此页面必须是新标签打开
function justNew(url,title){
	var Ext=parent.Ext;
	if(!Ext){
		history.go(-1);
		LoadClass(url,title);
	}
}

//显示关闭或返回按钮
function goBack(nn,span){
		if(!span){
			span="backSpan";
		}
		var backspan = document.getElementById(span);	//要应用这个按钮的对象

		var cc = '<input class="btn" type="button" value="关 闭" onclick="javascript:closeTab(0);" />'
		var bb = '<input class="btn" type="button" value="返 回" onclick="javascript:history.go(-1);" />'
		
		var tt = getActiveTab("title");
		if(backspan){
			if(tt!=nn){
					backspan.innerHTML=cc;  //关闭
			}else{
					backspan.innerHTML=bb;  //返回
			}
		}
		
}

function getActiveTab(element){
	var Ext = top.Ext;
	if(Ext){
		var mainPanel =Ext.getCmp("doc-body");
		var str;
		if(element=="title"){
			str = mainPanel.getActiveTab().title;
		}else if(element=="id"){
			str = mainPanel.getActiveTab().id;
		}
			return str;
	}
}

//更改Label的抬头文字
function chgTitle(val,target){
	/*
	target = 要更改的ID
	val = 负什么值给这个ID
	*/
	var mainPanel = top.Ext.getCmp("doc-body");	//要应用这个按钮的对象
	
	if(target){
		//当target有值的时候将更改对应的ID的抬头文字
	}else{
		mainPanel.getActiveTab().setTitle(val);
	}
}














//-------------------------------------------------------------//
//默认控件焦点
function setFocus(obj)
{	 
	 document.all[obj].focus(); 
}
/*//弹出窗口
function OpenWin(URL,w,h)
{
  var rtt=window.open(URL,"弹出窗口","height="+h+",width="+w+",status=0,toolbar=no,menubar=no,location=no,scrollbars=auto,top="+200+",left="+200+",resizable=yes");
}
*/
//load 非模式窗口

function LoadNWindow(url)
{
//定义窗口尺寸等
var w_height=200;//360;
var w_width=300;
var w_features="width="+w_width+",height="+w_height;
w_features=w_features+",top="+((screen.availHeight-w_height)/2);
w_features=w_features+",left="+((screen.availWidth-w_width)/2);

  window.showModelessDialog(url,'window',w_features);
}

//项目检测
function checkIt(){
	  if (document.all.tbname.value=="")
   { alert("请填写项目名称！");
     document.all.tbname.focus();
     return (false);
   }
   
  
   var number_chars = "abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        var i;
        var str=document.all.tbnumber.value;
        for (i=0;i<str.length;i++){
            if (number_chars.indexOf(str.charAt(i))==-1){
			alert("项目编号只能是字符和数字组合！" + str.charAt(i));
			document.all.tbnumber.focus();
			document.all.tbnumber.select();
			
    return false;
   }
   }
   
   if (document.all.tbid.value=="")
   { alert("没有选择公司！");
     return (false);
   }
   
    if (document.all.tbnumber.value=="")
   { alert("请填写项目编号！");
     document.all.tbnumber.focus();
     return (false);
   }
   return (true);
}

//检测文本长度
function ChkLength(val, max_length) {
var str_area=document.forms[0].elements[val].value;
if (str_area!=null&&str_area.length > max_length)
{
alert("字段文字超长，最多可输入" + max_length +"个字符，请重新输入！");
document.forms[0].elements[val].focus();
document.forms[0].elements[val].select();
return false;
}
return true;
}


////////////////////////////////////////////////////////////////////////////
//
// 通用数据校验函数，调用该函数需要传两个对像参数
// 表单需要定义三个扩展属性：nullable,datatype,cname (增加,strnum)
// nullable属性用来说明该表单是否可以为空
//            y——可以为空，n——不能为空
// datatype属性用来说明该表单的数据类型,
//            n——整型，m——浮点(例ma.b），
//             f——固定长度整数，d——日期型
//cname属性用来定义在数据校验失败时提示信息中出现的字出错字段名称
//maxlength的取值应该和数据库对应字段长度一直或小于
//
// strnum 属性说明该表单是否为字母数字组合
//          y--必须为字母数字 n-不限制
//         最后修改日期：2006-07-01
// 
///////////////////////////////////////////////////////////////////////////          

var msg="";


/* 取得字符串的字节长度 */
function strlen(str)
 {
  var i;
        var len;
        len = 0;
        for (i=0;i<str.length;i++)
   {
   if (str.charCodeAt(i)>255) len+=2; else len++;
  }
        return len;
}
/* 检测字符串是否为空*/
function isnull(str)
 {
  var i;
        for (i=0;i<str.length;i++)
   {
   if (str.charAt(i)!=' ') return false;
        }
        return true;
}          
/* 字符串不能为空 */
function checkNull(obj){
  nulll=obj.nullable;
  if (nulll=="n")
     {
   if (isnull(obj.value))
   {
          str="【"+obj.cname+"】"+"不能为空；";
    obj.focus();
    alert(str);
	return false;
   }
   return true;
  }

}
/*字符串只能为数字和字符组合*/
function isStrnum(str){
 var number_chars = "abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        var i;       
        for (i=0;i<str.length;i++){
            if (number_chars.indexOf(str.charAt(i))==-1) return false;					
		 }
		 return true;
}
/* 检测字符串是否全为数字 */
function isnumber(str)
 {
  var number_chars = "1234567890";
        var i;
        for (i=0;i<str.length;i++)
   {
            if (number_chars.indexOf(str.charAt(i))==-1) return false;
        }
        return true;
}
/* 检测字符串是否是指点的数点数 */
function isfloat(str,typ){
  var number_chars = "1234567890.";
        var i;
        for (i=0;i<str.length;i++){
            if (number_chars.indexOf(str.charAt(i))==-1){
       msg="这里应该是数字；";
    return false;
   }
        }
        
  if (str.length==0)
  {
   msg="数字位不能为空";
   return false;
  }
  
  var len=typ.length;
  var po=typ.indexOf(".");
  if (po==-1){
   intlen=typ.substring(1,len);
   floatlen="0";
  }
  else{
      var intlen=typ.substring(1,po);
      var floatlen=typ.substring(po+1,len);
  }
  
  var len=str.length;
  var po=str.indexOf(".");
  if (po==-1){
   ints=str.substring(0,len);
   floats="0";
  }
  else{
      var ints=str.substring(0,po);
      var floats=str.substring(po+1,len);
  }
        if (intlen<ints.length){
   msg="整数位超过长度；";
   return false;
  }
  if (floatlen<floats.length){
   msg="小数位超过长度；";
   return false;
  }
  return true;
}

/* 检测字符串是否是有效日期 */
String.prototype.isDate=function(){
 var re=/^(\d{1,4})(-|\/|\.)(\d{1,2})\2(\d{1,2})$/;
 var r=this.match(re);
 if(r==null) return false;
 var d=new Date(r[1],r[3]-1,r[4]);
 return (d.getFullYear()==r[1]&&d.getMonth()==r[3]-1&&d.getDay()==r[4]);
}
/*检测数据类型*/
String.prototype.isType=function(){
 var re=/^\m((\d+)*)((\.\d+)*)$/;
 var r=this.match(re);
 if (r != null)
  return true;
}          

/* 检测字符串是否满足要求 */
function verify(obj,flag)
{
if(obj==undefined)
{
   return
}
 var nam,val,len,max,nulll,typee,bool,str,boo,typ;
 str="";
    bool=true;
 boo=true
    for (i=0;i<obj.elements.length;i++)
 {
  if (!bool)
            break;
     max=obj.elements[i].maxLength;
  val=(obj.elements[i].value);
  nam=(obj.elements[i].name); 
  typee=obj.elements[i].datatype;
  if (nam=="editmode" && flag)
  {
   break;
  }
  if (nam !="editmode" && !flag && boo)
   continue;
  else
   boo=false;
        len=strlen(val);
  if (typee!=null && typee!="undefined")
  {
   if (typee.isType()){
       typ=typee;
    typee="m";
    max=max+1;
   }     
  }
  
  sn=obj.elements[i].strnum;        
  if (sn=="y")
   {
	if (isStrnum(val)==false)
	{
		str="【"+obj.elements[i].cname+"】"+"只能为字母和数字组合；";
		obj.elements[i].focus();
		obj.elements[i].select();
		bool=false;
		alert(str);
        break;
        }  
  }
  
  if (len>max)
  {
         str="【"+obj.elements[i].cname+"】"+"超过限制长度；";
            obj.elements[i].focus();
   obj.elements[i].select();
   bool=false;
   alert(str);
   break;
  }
  
  nulll=obj.elements[i].nullable;
  if (nulll=="n")
     {
   if (isnull(val))
   {
          str="【"+obj.elements[i].cname+"】"+"不能为空；";
    obj.elements[i].focus();
       obj.elements[i].select();
    bool=false;
    alert(str);
                break;
   }
  }
  
  switch(typee)
  {
   case "n" : if (isnumber(val)==false)
   {
     str="【"+obj.elements[i].cname+"】"+"应该是数字；";
     obj.elements[i].focus();
        obj.elements[i].select();
     bool=false;
     alert(str);  
   }
   break;
            case "m" : if (isfloat(val,typ)==false)
      {
     str="【"+obj.elements[i].cname+"】"+"数字的格式不正确"+"——"+msg;
     obj.elements[i].focus();
        obj.elements[i].select();
     bool=false;
     alert(str);
   }
   break;
   case "f" : if (isnumber(val)==false || (max!=len && len!=""))
      {
     str="【"+obj.elements[i].cname+"】"+"不是数字或长度无效；";
     obj.elements[i].focus();
        obj.elements[i].select();
     bool=false;
     alert(str);
   } 
   break;          

   case "d" : if (! val.isDate() && val!="")
      {
     str="【"+obj.elements[i].cname+"】"+"日期格式无效；";
     obj.elements[i].focus();
        obj.elements[i].select();
     bool=false;
     alert(str);
   }
   break;
   //在这里可以加入其它数据类型校验
   default : break;
  }
 } 
 return bool;   
}


/*回车转换焦点*/
function keyenter(obj,obje)
{
 var keycd,i,nam,ii,bool;
 keycd=event.keyCode;
 ii=obj.elements.length;
 nam=obje.name;
 bool=true;
 if (keycd==13)
 {
      for (i=0;i<obj.elements.length;i++) 
             {
     if (bool)
     if (nam==(obj.elements[i].name))
         {
         bool=false;
         if (i+1<ii)
      {
                   obj.elements[i + 1].focus();
      }
        }
         }
      }
} 

/*==========复选 框全选 ============================================== */
 function SelectAll (chkVal, idVal) { 

       var thisfrm = document.forms[0];

           // 查找Forms里面所有的元素

           for (i=0; i<thisfrm.length; i++) {

              // 查找模板头中的CheckBox

              if (idVal.indexOf ('chkAll') != -1) {

                  if(chkVal == true) {

                     thisfrm.elements[i].checked = true;

                  } 

                  else {

                      thisfrm.elements[i].checked = false;

                  }

               } // if

               // 如果除题头以外的项没有全选上则取消题头的选择

              else if (idVal.indexOf ('chkDelete') != -1) {

                  if(thisfrm.elements[i].checked == false) {

                     thisfrm.elements[1].checked = false; 

                  }

               }

           } // for

        }
//==============================================================================
 function SelectAll1 (chkVal, idVal) { 

       var thisfrm = document.forms[0];

           // 查找Forms里面所有的元素

           for (i=0; i<thisfrm.length; i++) {

              // 查找模板头中的CheckBox

              if (idVal.indexOf ('chkAll1') != -1) {

                  if(chkVal == true) {

                     thisfrm.elements[i].checked = true;

                  } 

                  else {

                      thisfrm.elements[i].checked = false;

                  }

               } // if

               // 如果除题头以外的项没有全选上则取消题头的选择

              else if (idVal.indexOf ('chkDelete') != -1) {

                  if(thisfrm.elements[i].checked == false) {

                     thisfrm.elements[1].checked = false; 

                  }

               }

           } // for

        }
   //=============复选 框选中后，返回值到父窗口================
   function click_chk(cid)
{
  var parent_window = parent.dialogArguments;
  TO_VAL=parent_window.document.all.TO_ID.value;
  targetelement=window.document.all(cid);
  user_name=targetelement.name;

  if(TO_VAL.indexOf(","+user_id+",")<0 && TO_VAL.indexOf(user_id+",")!=0)
  {
    parent_window.document.all.TO_ID.value+=user_id+",";
    parent_window.document.all.TO_NAME.value+=user_name+",";
    borderize_on(targetelement);
  }
  else
  {
    parent_window.document.all.TO_ID.value=parent_window.document.all.TO_ID.value.replace(user_id+",","");
    parent_window.document.all.TO_NAME.value=parent_window.document.all.TO_NAME.value.replace(user_name+",","");
    borderize_off(targetelement);
  }
}

//-----------------隐藏或显示 DIV----------------------
function expandCont(ID)
{
    targetelement=window.document.all(ID);
    if (targetelement.style.display=="none")
        targetelement.style.display='';
 
    else
        targetelement.style.display="none";
}

//----------------------显示PNG透明--------------------------
function fixPNG() // correctly handle PNG transparency in Win IE 5.5 & 6.
{
   var arVersion = navigator.appVersion.split("MSIE")
   var version = parseFloat(arVersion[1])
   if ((version >= 5.5) && (document.body.filters)) 
   {
      for(var i=0; i<document.images.length; i++)
      {
         var img = document.images[i]
         var imgName = img.src.toUpperCase()
         if (imgName.substring(imgName.length-3, imgName.length) == "PNG")
         {
            var imgID = (img.id) ? "id='" + img.id + "' " : ""
            var imgClass = (img.className) ? "class='" + img.className + "' " : ""
            var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' "
            var imgStyle = "display:inline-block;" + img.style.cssText 
            if (img.align == "left") imgStyle = "float:left;" + imgStyle
            if (img.align == "right") imgStyle = "float:right;" + imgStyle
            if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle
            var strNewHTML = "<span " + imgID + imgClass + imgTitle
            + " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";"
            + "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
            + "(src='" + img.src + "', sizingMethod='scale');\"></span>" 
            img.outerHTML = strNewHTML
            i = i-1
         }
      }
  }
  }   
  
  
  //------------复制内容到剪贴板-------------//
  function copy(ID)
{
  targetelement=document.all(ID);
  textRange = targetelement.createTextRange();
  textRange.execCommand("Copy");
  alert("已复制到剪贴板!");
}

//-----------文本框CSS改变,高亮显示-----state 默认为0 否则为1
function highlight(state) {
element=event.srcElement;
if (element.tagName=='INPUT') {
etype=element.type;
if ((etype=='text'))
	{
		if(state==1){ 
		element.className="onIE"; 
		}else {
			element.className="on";
		}
	}
//element.focus();
}
}
//--------------------判断文本框输入，回车则改变焦点------------
function SubmitKeyClick(button) 
{ 
if (event.keyCode == 13) 
{ 
	event.keyCode=9;
	event.returnValue = false;
	document.all[button].click(); 
}
}

