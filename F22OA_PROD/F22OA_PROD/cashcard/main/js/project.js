
//��Ŀ���
function checkIt(){
	  if (document.all.tbname.value=="")
   { alert("����д��Ŀ���ƣ�");
     document.all.tbname.focus();
     return (false);
   }
   
  
   var number_chars = "abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        var i;
        var str=document.all.tbnumber.value;
        for (i=0;i<str.length;i++){
            if (number_chars.indexOf(str.charAt(i))==-1){
			alert("��Ŀ���ֻ�����ַ���������ϣ�" + str.charAt(i));
			document.all.tbnumber.focus();
			document.all.tbnumber.select();
			
    return false;
   }
   }
   
   if (document.all.tbid.value=="")
   { alert("û��ѡ��˾��");
     return (false);
   }
   
    if (document.all.tbnumber.value=="")
   { alert("����д��Ŀ��ţ�");
     document.all.tbnumber.focus();
     return (false);
   }
   return (true);
}

//����ı�����
function ChkLength(val, max_length) {
var str_area=document.forms[0].elements[val].value;
if (str_area!=null&&str_area.length > max_length)
{
alert("�ֶ����ֳ�������������" + max_length +"���ַ������������룡");
document.forms[0].elements[val].focus();
document.forms[0].elements[val].select();
return false;
}
return true;
}


////////////////////////////////////////////////////////////////////////////
//
// ͨ������У�麯�������øú�����Ҫ�������������
// ����Ҫ����������չ���ԣ�nullable,datatype,cname (����,strnum)
// nullable��������˵���ñ��Ƿ����Ϊ��
//            y��������Ϊ�գ�n��������Ϊ��
// datatype��������˵���ñ�����������,
//            n�������ͣ�m��������(��ma.b����
//             f�����̶�����������d����������
//cname������������������У��ʧ��ʱ��ʾ��Ϣ�г��ֵ��ֳ����ֶ�����
//maxlength��ȡֵӦ�ú����ݿ��Ӧ�ֶγ���һֱ��С��
//
// strnum ����˵���ñ��Ƿ�Ϊ��ĸ�������
//          y--����Ϊ��ĸ���� n-������
//         ����޸����ڣ�2006-07-01
// 
///////////////////////////////////////////////////////////////////////////          

var msg="";


/* ȡ���ַ������ֽڳ��� */
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
/* ����ַ����Ƿ�Ϊ��*/
function isnull(str)
 {
  var i;
        for (i=0;i<str.length;i++)
   {
   if (str.charAt(i)!=' ') return false;
        }
        return true;
}          
/* �ַ�������Ϊ�� */
function checkNull(obj){
  nulll=obj.nullable;
  if (nulll=="n")
     {
   if (isnull(obj.value))
   {
          str="��"+obj.cname+"��"+"����Ϊ�գ�";
    obj.focus();
    alert(str);
	return false;
   }
   return true;
  }

}
/*�ַ���ֻ��Ϊ���ֺ��ַ����*/
function isStrnum(str){
 var number_chars = "abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        var i;       
        for (i=0;i<str.length;i++){
            if (number_chars.indexOf(str.charAt(i))==-1) return false;					
		 }
		 return true;
}
/* ����ַ����Ƿ�ȫΪ���� */
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
/* ����ַ����Ƿ���ָ��������� */
function isfloat(str,typ){
  var number_chars = "1234567890.";
        var i;
        for (i=0;i<str.length;i++){
            if (number_chars.indexOf(str.charAt(i))==-1){
       msg="����Ӧ�������֣�";
    return false;
   }
        }
        
  if (str.length==0)
  {
   msg="����λ����Ϊ��";
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
   msg="����λ�������ȣ�";
   return false;
  }
  if (floatlen<floats.length){
   msg="С��λ�������ȣ�";
   return false;
  }
  return true;
}

/* ����ַ����Ƿ�����Ч���� */
String.prototype.isDate=function(){
 var re=/^(\d{1,4})(-|\/|\.)(\d{1,2})\2(\d{1,2})$/;
 var r=this.match(re);
 if(r==null) return false;
 var d=new Date(r[1],r[3]-1,r[4]);
 return (d.getFullYear()==r[1]&&d.getMonth()==r[3]-1&&d.getDate()==r[4]);
}
/*�����������*/
String.prototype.isType=function(){
 var re=/^\m((\d+)*)((\.\d+)*)$/;
 var r=this.match(re);
 if (r != null)
  return true;
}          

/* ����ַ����Ƿ�����Ҫ�� */
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
		str="��"+obj.elements[i].cname+"��"+"ֻ��Ϊ��ĸ��������ϣ�";
		obj.elements[i].focus();
		obj.elements[i].select();
		bool=false;
		alert(str);
        break;
        }  
  }
  
  if (len>max)
  {
         str="��"+obj.elements[i].cname+"��"+"�������Ƴ��ȣ�";
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
          str="��"+obj.elements[i].cname+"��"+"����Ϊ�գ�";
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
     str="��"+obj.elements[i].cname+"��"+"Ӧ�������֣�";
     obj.elements[i].focus();
        obj.elements[i].select();
     bool=false;
     alert(str);  
   }
   break;
            case "m" : if (isfloat(val,typ)==false)
      {
     str="��"+obj.elements[i].cname+"��"+"���ֵĸ�ʽ����ȷ"+"����"+msg;
     obj.elements[i].focus();
        obj.elements[i].select();
     bool=false;
     alert(str);
   }
   break;
   case "f" : if (isnumber(val)==false || (max!=len && len!=""))
      {
     str="��"+obj.elements[i].cname+"��"+"�������ֻ򳤶���Ч��";
     obj.elements[i].focus();
        obj.elements[i].select();
     bool=false;
     alert(str);
   } 
   break;          

   case "d" : if (! val.isDate() && val!="")
      {
     str="��"+obj.elements[i].cname+"��"+"���ڸ�ʽ��Ч��";
     obj.elements[i].focus();
        obj.elements[i].select();
     bool=false;
     alert(str);
   }
   break;
   //��������Լ���������������У��
   default : break;
  }
 } 
 return bool;   
}


/*�س�ת������*/
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

/*==========��ѡ ��ȫѡ ============================================== */
 function SelectAll (chkVal, idVal) { 

       var thisfrm = document.forms[0];

           // ����Forms�������е�Ԫ��

           for (i=0; i<thisfrm.length; i++) {

              // ����ģ��ͷ�е�CheckBox

              if (idVal.indexOf ('chkAll') != -1) {

                  if(chkVal == true) {

                     thisfrm.elements[i].checked = true;

                  } 

                  else {

                      thisfrm.elements[i].checked = false;

                  }

               } // if

               // �������ͷ�������û��ȫѡ����ȡ����ͷ��ѡ��

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

           // ����Forms�������е�Ԫ��

           for (i=0; i<thisfrm.length; i++) {

              // ����ģ��ͷ�е�CheckBox

              if (idVal.indexOf ('chkAll1') != -1) {

                  if(chkVal == true) {

                     thisfrm.elements[i].checked = true;

                  } 

                  else {

                      thisfrm.elements[i].checked = false;

                  }

               } // if

               // �������ͷ�������û��ȫѡ����ȡ����ͷ��ѡ��

              else if (idVal.indexOf ('chkDelete') != -1) {

                  if(thisfrm.elements[i].checked == false) {

                     thisfrm.elements[1].checked = false; 

                  }

               }

           } // for

        }
   //=============��ѡ ��ѡ�к󣬷���ֵ��������================
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

//-----------------���ػ���ʾ DIV----------------------
function expandCont(ID)
{
    targetelement=window.document.all(ID);
    if (targetelement.style.display=="none")
        targetelement.style.display='';
 
    else
        targetelement.style.display="none";
}

//----------------------��ʾPNG͸��--------------------------
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
  
  
  //------------�������ݵ�������-------------//
  function copy(ID)
{
  targetelement=document.all(ID);
  textRange = targetelement.createTextRange();
  textRange.execCommand("Copy");
  alert("�Ѹ��Ƶ�������!");
}

//-----------�ı���CSS�ı�,������ʾ-----state Ĭ��Ϊ0 ����Ϊ1
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
//--------------------�ж��ı������룬�س���ı佹��------------
function SubmitKeyClick(button) 
{ 
if (event.keyCode == 13) 
{ 
	event.keyCode=9;
	event.returnValue = false;
	document.all[button].click(); 
}
}
//----------------------------�������-----------------------------------//
        

