<%@ page language="C#" autoeventwireup="true" inherits="OA_isprit_WORDPAD_note_addpic, App_Web_addpic.aspx.da50fc64" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link href="images/css.css" rel="stylesheet" type="text/css">

<SCRIPT LANGUAGE="JavaScript">
<!--
function viewpic()
{
    var fpic=window.document.getElementById("upfile").value;
    if(fpic=='')
    {
        alert('请选择您要上传的图片!');
        return false;
    }
    else
    {
        window.open("view_pic.aspx?fpic="+fpic,"","height=200,width=400,left=10,top=10,resizable=yes,scrollbars=no,status=no,toolbar=no,menubar=no,location=no");
    }
}

var Vname = "";
var PrgrsWin;
function showPrgrs()
{	
	if(window.document.getElementById("upfile").value!="")
	{
		PrgrsWin = window.open("attach.aspx", "", "resizable=no,width=400,height=160,top=220,left=200");
	}
}

function closePrgrs()
{
	if (PrgrsWin && PrgrsWin.open && !PrgrsWin.closed) PrgrsWin.close();
}

//上传
function DoAttach()
{
	if (CheckAtt())
	{
		document.uploadpic.submit();
		showPrgrs();
	}
}
//检查数据
function CheckAtt()
{
	var ret = true;
	if (window.document.getElementById("upfile").value=="")
	{
		alert('请选择要上传的图片');
		return false;
	}
	return ret
}
//-->
</SCRIPT>
</head>
<body bgcolor="#f8f8f8" onUnload="closePrgrs();">
    <form id="uploadpic" runat="server">
    <div>
    <table>
     <tr>
      <td width="100%">
        <input type=hidden name='objid' value='1'>
        <input type='hidden' name='MAX_FILE_SIZE' value='102400000'>
        <input type='file' name='upfile' value='浏览' style='width:60%' class='box2'>
        <input type='button' name='preview' value='预览'  onclick='viewpic();' class='btn'>
        <input type='submit' name='upload' value='粘贴' onclick="DoAttach()" class='btn'>
      </td>
     </tr>
    </table>
    </div>
    </form>
</body>
</html>
