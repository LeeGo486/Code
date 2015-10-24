// JScript 文件
//========================================================================
//  弹出模式窗口 
//
//
//
//
//=========================================================================
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

//load 非模式窗口

function LoadNWindow(url)
{
var w_height=200;//360;//定义窗口尺寸等
var w_width=300;
var w_features="width="+w_width+",height="+w_height;
w_features=w_features+",top="+((screen.availHeight-w_height)/2);
w_features=w_features+",left="+((screen.availWidth-w_width)/2);

  window.showModelessDialog(url,'window',w_features);
}
//================================================
//
//
//
//===================================================

function clear_user(){
    document.all.TO_ID.value="";
    document.all.TO_NAME.value="";
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


/////////////////////////////////////////////////////////
//
//                 全选 checkbox
//
////////////////////////////////////////////////////////

 function sel(){ 
  o=document.frmMain;
  var str;
  for(i=0;i<o.elements.length;i++) 
  {
    
   // alert(o.elements[i].type);
   
if(typeof o.elements[i].type  !=  "undefined"  &&  o.elements[i].type=='checkbox')
  {
   o.elements[i].checked=event.srcElement.checked 
   }
 }
   
 }
/////////////////////////////////////////////////////////////////////
//
//                      弹出加载框
//////////////////////////////////////////////////////////

    function pop(x,y){      
        var oPopup = window.createPopup();
        with (oPopup.document.body) {
       
        style.backgroundColor="#000";
        //style.border="solid #036 0px";
        innerHTML=' <IMG SRC="../icon/loading.gif" /><font size="2" color="#ffffff">正在处理...</font>' ;
        }
        oPopup.show(x,y,110,20);
    }  