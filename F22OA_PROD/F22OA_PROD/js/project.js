//默认控件焦点
function setFocus(obj)
{	 
	 document.all[obj].focus(); 
}
//load 模式窗口
function LoadWindow(url,w,h)
{

  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+150;
  var rtw=window.showModalDialog(url,self,"edge:sunken;scroll:2;status:0;help:0;resizable:1;dialogWidth:"+w+"px;dialogHeight:"+h+"px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
}
//弹出窗口
function OpenWin(URL,w,h)
{
  var rtt=window.open(URL,"弹出窗口","height="+h+",width="+w+",status=0,toolbar=no,menubar=no,location=no,scrollbars=auto,top="+200+",left="+200+",resizable=yes");
}
function select_date(lx) 
{
  var url="/usercontrol/pop_selectrq.aspx?chktype="+lx;
  var rq=showaspx(url,320,400);
  return rq;
}

//弹出模式窗口，送入的url从站点开始的完整路径
function showaspx(url,w,h)
{
  url=getroot()+url;
  var rtw=window.showModalDialog(url,self,"edge:sunken;scroll:2;status:0;help:0;resizable:1;center:yes;dialogWidth:"+w+"px;dialogHeight:"+h+"px;");
  return rtw;
}
//得到站点名称
function getroot() 
{
  
  var path=location.pathname.split("/");

  var root=path[1];
  if (path[0]!="")
  {
     root=path[0];
   }
  if (root!="")
  {
    root="/"+root;
  }
  return root;
}

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
 return (d.getFullYear()==r[1]&&d.getMonth()==r[3]-1&&d.getDate()==r[4]);
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
            + "(src=\'" + img.src + "\', sizingMethod='scale');\"></span>" 
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
	}
	 else {element.className="on";}
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
//----------------------------表格排序-----------------------------------//
        

