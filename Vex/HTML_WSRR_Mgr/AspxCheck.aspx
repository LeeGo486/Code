<%
'�˷�asp.net̽��
'����QQ��178575
'����EMail��yliangcf@163.com
'������վ��http://www.qqcf.com
%>
<%Response.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312")%>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Microsoft.VisualBasic.CompilerServices" %>

<Script Language="VB" Runat="Server">
Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
  Dim Sw As StreamWriter
  Dim Bc as HttpBrowserCapabilities
  Dim Flag as Boolean
  Dim DownStr As String

    
  ServerName.text= Server.MachineName.ToString()
  ServerVer.text=Environment.OSVersion.ToString()

  If Request.ServerVariables("HTTP_X_FORWARDED_FOR")<>"" And Request.ServerVariables("SERVER_PORT")<>80 Then
   ServerIp.text = Request.ServerVariables("LOCAL_ADDR") & "&nbsp;&nbsp;[����IP,����IPʵ���� "&Request.ServerVariables("REMOTE_ADDR")&" ͨ���˿�ӳ��ʵ�ַ������˿ں�Url��Ķ˿ڲ�һ��]"
  Else
   ServerIp.text = Request.ServerVariables("LOCAL_ADDR") & "&nbsp;&nbsp;[����IP]"
  End if

  ServerDomain.text=Request.ServerVariables("SERVER_NAME")
  ServerPort.text = Request.ServerVariables("SERVER_PORT")

  ServerOutTime.text=Server.ScriptTimeout.ToString()
  ServerNow.text=DateTime.Now.ToString()
  ServerSessionTotal.text=Session.Contents.Count.ToString()
  ServerApplicationTotal.text=Application.Contents.Count.ToString()
    
  NetVer.text= System.Environment.Version.ToString()  
  IISVer.text= Request.ServerVariables("SERVER_SOFTWARE")
  
  ProPath.text= Request.ServerVariables("PATH_INFO")
  ProPath_2.text= Request.ServerVariables("APPL_PHYSICAL_PATH")
  
  ServerRunTime.text=Math.round(Environment.TickCount/600/60)/100
  
  
  Bc= Request.Browser   

  If Request.ServerVariables("HTTP_X_FORWARDED_FOR")="" Then
   Brower_IP.text=Request.ServerVariables("REMOTE_ADDR")
  Else
   Brower_IP.text=Request.ServerVariables("HTTP_X_FORWARDED_FOR")
  End If

  Brower_OSVer.text=Bc.Platform.ToString()
  Brower_Brower.text=Bc.Browser.ToString()
  Brower_BrowerVer.text=Bc.Version.ToString()
  Brower_Javscript.text=Bc.JavaScript.ToString()
  Brower_VBScript.text=Bc.VBScript.ToString()
  Brower_JavaApplets.text=Bc.JavaApplets.ToString()
  Brower_Cookies.text=Bc.Cookies.ToString()
  Brower_Language.text=Request.ServerVariables("HTTP_ACCEPT_LANGUAGE")
  Brower_Frame.text=Bc.Frames.ToString()
  
  DownStr="&#12288;&#91;<a href='&#104;&#116;&#116;&#112;&#58;&#47;&#47;&#119;&#119;&#119;&#46;&#113;&#113;&#99;&#102;&#46;&#99;&#111;&#109;&#47;&#100;&#111;&#119;&#110;&#46;&#104;&#116;&#109;' target='_blank' style='&#102;&#111;&#110;&#116;&#45;&#115;&#105;&#122;&#101;&#58;&#49;&#50;&#112;&#120;&#59;&#99;&#111;&#108;&#111;&#114;&#58;&#35;&#102;&#102;&#48;&#48;&#48;&#48;&#59;&#116;&#101;&#120;&#116;&#45;&#100;&#101;&#99;&#111;&#114;&#97;&#116;&#105;&#111;&#110;&#58;&#117;&#110;&#100;&#101;&#114;&#108;&#105;&#110;&#101;'>&#19979;&#36733;</a>&#93;"


 If ObjCheck("ADODB.RecordSet") Then
  Obj_Access.Text="֧��" & ObjVer("ADODB.RecordSet")
 Else
  Obj_Access.Text="��֧��"
 End If
 
 If ObjCheck("Scripting.FileSystemObject") Then
  Obj_Fso.Text="֧��"
 Else
  Obj_Fso.Text="��֧��"
 End If
 
 
 If ObjCheck("JMail.SmtpMail") Then
  Obj_Jmail.Text="֧�֣��汾��" & ObjVer("JMail.SmtpMail") & DownStr
 Else
  Obj_Jmail.Text="��֧��" & DownStr
 End If
 
 If ObjCheck("CDONTS.NewMail") Then
  Obj_Cdonts.Text="֧�֣��汾��" & ObjVer("CDONTS.NewMail")
 Else
  Obj_Cdonts.Text="��֧��"
 End If
 
 If ObjCheck("Persits.Jpeg") Then
  Obj_AspJpeg.Text="֧�֣��汾��" & ObjVer("Persits.Jpeg") & DownStr
 Else
  Obj_AspJpeg.Text="��֧��" & DownStr
 End If
 
 If ObjCheck("Persits.Upload.1") Then
  Obj_AspUpload.Text="֧�֣��汾��" & ObjVer("Persits.Upload.1") & DownStr
 Else
  Obj_AspUpload.Text="��֧��" & DownStr
 End If
 
 
 If ObjCheck("ADODB.RecordSet") Then
  Obj_Access.Text="֧��"
 Else
  Obj_Access.Text="��֧��"
 End If
 
 
Try
 Sw = New StreamWriter(Server.MapPath("AspxCheck_Temp.htm"), False, System.Text.Encoding.GetEncoding("GB2312"))
 Sw.WriteLine(Now())
 Sw.Close()
		 
 Flag = True
Catch ex As Exception
 Flag = False
End Try

If Flag=True Then
 Obj_Write.Text="<b>֧��</b>"

 System.IO.File.Delete(System.Web.HttpContext.Current.Server.MapPath("AspxCheck_Temp.htm"))
Else
 Obj_Write.Text="<font color='ff0000'><b>��֧��</b></font>"
End If


systitle.text="&nbsp;<strong style='&#102;&#111;&#110;&#116;&#45;&#115;&#105;&#122;&#101;&#58;&#49;&#56;&#112;&#116;'>&#20056;&#39118;&#65;&#83;&#80;<SUP><font size='2' style='&#102;&#111;&#110;&#116;&#45;&#115;&#105;&#122;&#101;&#58;&#49;&#50;&#112;&#116;'>&#46;&#110;&#101;&#116;</font></SUP>&#32;&#25506;&#38024;&#32;&#86;&#49;&#46;&#50;</strong><br><a href=&#104;&#116;&#116;&#112;&#58;&#47;&#47;&#119;&#119;&#119;&#46;&#113;&#113;&#99;&#102;&#46;&#99;&#111;&#109; target=_blank style='&#102;&#111;&#110;&#116;&#45;&#115;&#105;&#122;&#101;&#58;&#49;&#50;&#112;&#120;&#59;&#99;&#111;&#108;&#111;&#114;&#58;&#35;&#102;&#102;&#48;&#48;&#48;&#48;&#59;&#116;&#101;&#120;&#116;&#45;&#100;&#101;&#99;&#111;&#114;&#97;&#116;&#105;&#111;&#110;&#58;&#117;&#110;&#100;&#101;&#114;&#108;&#105;&#110;&#101;'>&#80;&#111;&#119;&#101;&#114;&#101;&#100;&#32;&#66;&#121;&#32;&#67;&#70;</a>"
End Sub
	
Private Sub SelfObjChk_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
 Dim ObjName As String
 ObjName = Trim(SelObj.value)

 If ObjCheck(ObjName) Then
  Obj_SelfObj.Text="֧�֣��汾��" & ObjVer(ObjName)
 Else
  Obj_SelfObj.Text="��֧��"
 End If

End Sub


Private Function ObjCheck(ByVal a As String) As Boolean
    Dim b As Boolean
    Try 
        Dim c = Server.CreateObject(a)
        b = True
    Catch exception1 As Exception
        ProjectData.SetProjectError(exception1)
        b = False
        ProjectData.ClearProjectError
    End Try
    Return b
End Function 

Private Function ObjVer(ByVal a As String) As string
    Dim b As string
    Try 
        Dim c = Server.CreateObject(a)
        b = c.version
    Catch exception1 As Exception
        ProjectData.SetProjectError(exception1)
        ProjectData.ClearProjectError
    End Try
    Return b
End Function
</Script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html><head><title>�˷�asp.net̽�� V1.2</title>
<meta http-equiv=content-type content="text/html; charset=gb2312">
<style type="text/css">
body {text-align: left; font-family:Arial; margin:0; padding:0; background: #FFF; font-size:12px; color:#333333;}
table{font-size:12px;}

.tb_1{
 background-color:#ffffff;
 border:1px solid #C9DDF0;
 margin:5px 0px 5px 5px;
 width:768px;
 float:left;
}

 .tb_2{
 width:980px;
 background-color:#ffffff;
 border:1px solid #C9DDF0;
 margin:15px auto;
 clear:both;
}

.tb_2 td{border-bottom: 1px dotted #C9DDF0;padding-left:6px;}

 .tb_2_b{
 width:980px;
 background-color:#ffffff;
 border:1px solid #C9DDF0;
 margin:0px auto;
 clear:both;
}

 .tb_3{
 background-color:#ffffff;
 border:1px solid #C9DDF0;
 margin:15px auto;
 padding:5px;
 clear:both;
}


.tr_1{
 padding-left:5px;
 padding-top:5px;
 font-weight:bold;
 font-size:14px;
 height:24px;
 text-align:center;
 background-color:#F3F9FE;
}

.tr_2{
 text-align:center;
}



.td_1{
 text-align:left;
}
.td_2{
 text-align:center;
}
.td_3{
 text-align:right;
}

.right{
	display:inline;
	float:right
}
.clear{
	clear:both;
	height:0px;
}
.wrap{
	width:950px;;
	margin:0 auto;
}
.bord{
	border:#b0bec7 1px solid;
}
</style>
</HEAD>
<BODY>

<form id="Form1" method="post" runat="server">
<table class="tb_2_b">
<tr class="tr_1"> 
      <td><asp:label ID="systitle" runat="server" /></td>
    </tr>
</table>

<table class="tb_2">


<tr class="tr_1"> 
      <td colspan="2">д��Ȩ��</td>
    </tr>
    <tr>
      <td>�ռ��Ƿ�֧��д�룺</td>
      <td><asp:label ID="obj_write" runat="server" /><br />
        <br />
        д��Ȩ��˵����
��Щ�ռ��̵Ŀռ俴������һЩasp.net̽��������������ʵֻ����֤��asp.net�Կռ�Ķ�ȡȨ�ޣ�asp.net��д��Ȩ�޿���û�еģ�Ҫ�ǲ�֧�ֲ������ʹ�õ�Access���ݿ��asp.net�����ò��ˣ�Ҳ���ɲ��˾�̬ҳ�档�����д��Ȩ��Ϊ֧�ֵĻ���������ռ�ſ�������ʹ�á�</td>
    </tr>
	
	<tr class="tr_1"> 
      <td colspan="2">������Ϣ</td>
    </tr>
    <tr>
      <td >���������ƣ�</td>
      <td><asp:label ID="ServerName" runat="server" /></td>
    </tr>
    <tr> 
      <td width="150" >����ϵͳ ��</td>
      <td><asp:label ID="ServerVer" runat="server" /></td>
    </tr>
    <tr>
      <td >������IP��</td>
      <td><asp:label ID="ServerIP" runat="server" /></td>
    </tr>
    <tr>
      <td >������������</td>
      <td><asp:label ID="ServerDomain" runat="server" /></td>
    </tr>
    <tr>
      <td >�������˿ڣ�</td>
      <td><asp:label ID="ServerPort" runat="server" /></td>
    </tr>
    <tr>
      <td >����˽ű�ִ�г�ʱ��</td>
      <td><asp:label ID="ServerOutTime" runat="server" />��</td>
    </tr>
    <tr>
      <td >����������ʱ�䣺</td>
      <td><asp:label ID="ServerNow" runat="server" /></td>
    </tr>
	
    <tr>
      <td >Session������</td>
      <td><asp:label ID="ServerSessionTotal" runat="server" /></td>
    </tr>
    <tr>
      <td >Application������</td>
      <td><asp:label ID="ServerApplicationTotal" runat="server" /></td>
    </tr>
	
	<tr> 
      <td>IIS�汾 ��</td><td><asp:label ID="IISVer" runat="server" /></td>
    </tr>
    <tr> 
      <td>.NET Framework �汾 ��</td><td><asp:label ID="NetVer" runat="server" /></td>
    </tr>
	
    <tr> 
      <td>���·�� ��</td><td><asp:label ID="ProPath" runat="server" /></td>
    </tr>
    <tr> 
      <td>����·�� ��</td><td><asp:label ID="ProPath_2" runat="server" /></td>
    </tr>
    <tr> 
      <td>����ʱ�� ��</td><td><asp:label ID="ServerRunTime" runat="server" />Сʱ</td>
    </tr>
    <tr class="tr_1"> 
      <td colspan="2">ϵͳ�����Ϣ</td>
    </tr>
    <tr>
      <td>Access���ݿ���� ��</td><td><asp:label ID="Obj_Access" runat="server" /></td>
    </tr>
    <tr>
      <td>FSO�ļ�������� ��</td><td><asp:label ID="Obj_Fso" runat="server" /></td>
    </tr>
    
	
	<tr class="tr_1"> 
      <td colspan="2">�ʼ������Ϣ</td>
    </tr>
	
	<tr>
      <td>JMAIL�ʼ�������� ��</td><td><asp:label ID="Obj_Jmail" runat="server" /></td>
    </tr>
    <tr>
      <td>CDONTS�ʼ�������� ��</td><td><asp:label ID="Obj_Cdonts" runat="server" /></td>
    </tr>
	<tr class="tr_1"> 
      <td colspan="2">ͼ�����</td>
    </tr>
	<tr>
      <td>AspJpeg��� ��</td><td><asp:label ID="Obj_AspJpeg" runat="server" /></td>
    </tr>
	
	<tr class="tr_1"> 
      <td colspan="2">�ļ��ϴ����</td>
    </tr>
	<tr><td>ASPUpload�ϴ���� ��</td><td><asp:label ID="obj_aspupload" runat="server" /></td>
    </tr>

	<tr class="tr_1"> 
      <td colspan="2">�Զ������</td>
    </tr>
	
    <tr><td>�Զ��������ѯ��</td><td><INPUT TYPE="text" NAME="SelObj" id="SelObj" runat="server">&nbsp;<asp:button id="SelfObjChk" runat="server" Text="���" OnClick="SelfObjChk_Click"></asp:button><asp:label ID="Obj_SelfObj" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;�˴�����ʹ�������ProgId��ClassId�����</td>
    </tr>
	
	<tr class="tr_1"> 
      <td colspan="2">�������Ϣ</td>
    </tr>
	
    <tr><td>�����ip��ַ��</td>
      <td>&nbsp;<asp:label ID="Brower_IP" runat="server" />&nbsp;</td>
	  </tr>

    <tr><td>����߲���ϵͳ��</td>
      <td>&nbsp;<asp:label ID="Brower_OSVer" runat="server" />&nbsp;</td>
    </tr>

    <tr><td>�������</td>
      <td>&nbsp;<asp:label ID="Brower_Brower" runat="server" />&nbsp;</td>
    </tr>
	  
	      <tr><td>������汾��</td>
      <td>&nbsp;<asp:label ID="Brower_BrowerVer" runat="server" />&nbsp;</td>
	  </tr>
	  
	      <tr><td>JavaScript��</td>
      <td>&nbsp;<asp:label ID="Brower_Javscript" runat="server" />&nbsp;</td>
	  </tr>
	  
	      <tr><td>VBScript��</td>
      <td>&nbsp;<asp:label ID="Brower_VBScript" runat="server" />&nbsp;</td>
	  </tr>
	  
	      <tr><td>JavaApplets��</td>
      <td>&nbsp;<asp:label ID="Brower_JavaApplets" runat="server" />&nbsp;</td>
	  </tr>
	  
	      <tr><td>Cookies��</td>
      <td>&nbsp;<asp:label ID="Brower_Cookies" runat="server" />&nbsp;</td>
	  </tr>
	  
	      <tr><td>���ԣ�</td>
      <td>&nbsp;<asp:label ID="Brower_Language" runat="server" />&nbsp;</td>
	  </tr>
	  
	      <tr><td>Frames��������:</td>
      <td>&nbsp;<asp:label ID="Brower_Frame" runat="server" />&nbsp;</td>
	  </tr> 
</table>
</form>
	