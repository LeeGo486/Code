//�ж��ַ����Ƿ�Ϊ��
function isEmpty(str){
	if(str==null || trim(str)==""){
		return true;
	}
	else{
		return false;
	}
}

//�ж��Ƿ�Ϊ������
function isDigital(str){
    return /^\d+$/.test(str);
}

//���������������ı��������ֻ����������"0"��"9",".","-",Ҳ������������ֵ,������ֵ
function isNumberText(){
 if ( !(((window.event.keyCode >= 48) && (window.event.keyCode <= 57)) 
 || (window.event.keyCode == 13) || (window.event.keyCode == 46) 
 || (window.event.keyCode == 45)))
    return false;
 else
    return true;
}

//ȥ���ִ���ߵĿո� 
function lTrim(str) { 
  if (str.charAt(0) == " ") { 
  //����ִ���ߵ�һ���ַ�Ϊ�ո� 
  str = str.slice(1);//���ո���ִ���ȥ�� 
  //��һ��Ҳ�ɸĳ� str = str.substring(1, str.length); 
  str = lTrim(str); //�ݹ���� 
  } 
  return str; 
} 

//ȥ���ִ��ұߵĿո� 
function rTrim(str) { 
  var iLength; 

  iLength = str.length; 
  if (str.charAt(iLength - 1) == " ") { 
    //����ִ��ұߵ�һ���ַ�Ϊ�ո� 
    str = str.slice(0, iLength - 1);//���ո���ִ���ȥ�� 
    //��һ��Ҳ�ɸĳ� str = str.substring(0, iLength - 1); 
    str = rTrim(str); //�ݹ���� 
  } 
  return str; 
} 

//ȥ���ִ����ߵĿո� 
function trim(str) { 
  return lTrim(rTrim(str)); 
} 


