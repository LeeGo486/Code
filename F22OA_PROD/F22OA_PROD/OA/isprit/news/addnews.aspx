<%@ page language="C#" autoeventwireup="true" inherits="isprit_news_addnews, App_Web_addnews.aspx.9a188d08" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>��ӡ��༭����</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<meta http-equiv="Content-Language" content="zh-cn">
		<LINK href="edit.css" type="text/css" rel="STYLESHEET"/>
		<LINK href="news.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" type="text/javascript">
			function ld() {
				HtmlEdit.document.body.innerHTML=document.all.hid.value;
			}
			
			function nPic(){
						
					document.all.hid.value = HtmlEdit.document.body.innerHTML;
					var ans;
					ans=window.confirm('ȷ��Ҫ���|��������?');
						{
						if (ans==true)
						{
							document.all.hdnbox.value='yes';
						}else{
							document.all.hdnbox.value='no';
													
						}
						}
					
			}
			    function addFile()
    {
    	var str = '<input type="file" style="width: 468px"  runat="server" name="File" />'
    	document.getElementById('iUpload').insertAdjacentHTML("beforeEnd",str)
    }
		</script>
</head>
<body  onload="ld()">
    <form id="frmMain" runat="server">
    <div>
    <TABLE class="news" align="center" border="0" cellpadding="0" cellspacing="0">
				<TR>
					<TD style="WIDTH: 67px"></TD>
					<TD style="WIDTH: 914px; HEIGHT: 10px" width="914">���ű���:<INPUT id="tbtitle" style="WIDTH: 232px; HEIGHT: 21px" accessKey="a" type="text" maxLength="100"
							size="33" runat="server">(A)���:<SELECT id="lbclass" style="WIDTH: 120px" accessKey="b" runat="server" DataTextField="newsclass"
							DataValueField="classid">
							<OPTION selected></OPTION>
						</SELECT>[����]
						<asp:TextBox id="tbauthor" runat="server" Width="104px"></asp:TextBox></TD>
					<TD style="HEIGHT: 10px" width="271"></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 67px" height="120">&nbsp;
					</TD>
					<TD>
						<div class="yToolbar">
							<div class="TBHandle"></div>
							<select class="TBGen" id="formatSelect" onchange="format('FormatBlock',this[this.selectedIndex].value);this.selectedIndex=0">
								<option selected>�����ʽ</option>
								<option value="<P>">��ͨ</option>
								<option value="<PRE>">�ѱ��Ÿ�ʽ</option>
								<option value="<H1>">����һ</option>
								<option value="<H2>">�����</option>
								<option value="<H3>">������</option>
								<option value="<H4>">������</option>
								<option value="<H5>">������</option>
								<option value="<H6>">������</option>
								<option value="<H7>">������</option>
							</select>
							<select class="TBGen" id="specialtype" onchange="specialtype(this[this.selectedIndex].value);this.selectedIndex=0">
								<option selected>�����ʽ</option>
								<option value="SUP">�ϱ�</option>
								<option value="SUB">�±�</option>
								<option value="DEL">ɾ����</option>
								<option value="BLINK">��˸</option>
								<option value="BIG">��������</option>
								<option value="SMALL">��С����</option>
							</select>
							<div class="TBSep"></div>
							<select class="TBGen" id="FontName" onchange="format('fontname',this[this.selectedIndex].value);this.selectedIndex=0">
								<option selected>����</option>
								<option value="����">����</option>
								<option value="����">����</option>
								<option value="����_GB2312">����</option>
								<option value="����_GB2312">����</option>
								<option value="����">����</option>
								<option value="��Բ">��Բ</option>
								<option value="Arial">Arial</option>
								<option value="Arial Black">Arial Black</option>
								<option value="Arial Narrow">Arial Narrow</option>
								<option value="Brush Script&#9;MT">Brush Script MT</option>
								<option value="Century Gothic">Century Gothic</option>
								<option value="Comic Sans MS">Comic Sans MS</option>
								<option value="Courier">Courier</option>
								<option value="Courier New">Courier New</option>
								<option value="MS Sans Serif">MS Sans Serif</option>
								<option value="Script">Script</option>
								<option value="System">System</option>
								<option value="Times New Roman">Times New Roman</option>
								<option value="Verdana">Verdana</option>
								<option value="Wide&#9;Latin">Wide Latin</option>
								<option value="Wingdings">Wingdings</option>
							</select>
							<select class="TBGen" id="FontSize" onchange="format('fontsize',this[this.selectedIndex].value);this.selectedIndex=0">
								<option selected>�ֺ�</option>
								<option value="7">һ��</option>
								<option value="6">����</option>
								<option value="5">����</option>
								<option value="4">�ĺ�</option>
								<option value="3">���</option>
								<option value="2">����</option>
								<option value="1">�ߺ�</option>
							</select>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="ȫ��ѡ��" onclick="format('selectall')"><IMG class="Ico" height="18" src="icon\selectall.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="ɾ��" onclick="format('delete')"><IMG class="Ico" height="18" src="icon\del.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="����" onclick="format('cut')"><IMG class="Ico" height="18" src="icon\cut.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="����" onclick="format('copy')"><IMG class="Ico" height="18" src="icon\copy.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="ճ��" onclick="format('paste')"><IMG class="Ico" height="18" src="icon\paste.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="����" onclick="format('undo')"><IMG class="Ico" height="18" src="icon\undo.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="�ָ�" onclick="format('redo')"><IMG class="Ico" height="18" src="icon\redo.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="������" onclick="InsertTable()"><IMG class="Ico" height="18" src="icon\table.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="������Ŀ��" onclick="FIELDSET()"><IMG class="Ico" height="18" src="icon\fieldset.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="������ҳ"><IMG class="Ico" height="18" src="icon\htm.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="����ͼƬ" onclick="forPic()"><IMG class="Ico" height="18" src="icon\img.gif" width="18">
							</div> <!--
							<div language="javascript" class="Btn" title="���뻭�л����" onclick="adv()"><IMG class="Ico" height="18" src="icon\adv.gif" width="18">
							</div>-->
						</div>
						<div class="yToolbar">
							<div class="TBHandle"></div>
							<div language="javascript" class="Btn" title="�����" onclick="format('justifyleft')" NAME="Justify"><IMG class="Ico" height="18" src="icon\aleft.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="����" onclick="format('justifycenter')" NAME="Justify"><IMG class="Ico" height="18" src="icon\acenter.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="�Ҷ���" onclick="format('justifyright')" NAME="Justify"><IMG class="Ico" height="18" src="icon\aright.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="���" onclick="format('insertorderedlist')"><IMG class="Ico" height="18" src="icon\num.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="��Ŀ����" onclick="format('insertunorderedlist')"><IMG class="Ico" height="18" src="icon\list.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="����������" onclick="format('outdent')"><IMG class="Ico" height="18" src="icon\outdent.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="����������" onclick="format('indent')"><IMG class="Ico" height="18" src="icon\indent.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="ɾ�����ָ�ʽ" onclick="format('RemoveFormat')"><IMG class="Ico" height="18" src="icon\clear.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="����" onclick="save()"><IMG class="Ico" height="18" src="icon\save.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="����flash��ý���ļ�" onclick="swf()"><IMG class="Ico" height="18" src="icon\flash.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="������Ƶ�ļ���֧�ָ�ʽΪ��avi��wmv��asf" onclick="wmv()"><IMG class="Ico" height="18" src="icon\wmv.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="����RealPlay�ļ���֧�ָ�ʽΪ��rm��ra��ram" onclick="rm()"><IMG class="Ico" height="18" src="icon\rm.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="�鿴����" onclick="help()"><IMG class="Ico" height="18" src="icon\help.gif" width="18">
							</div>
							<div class="TBSep"></div>
						</div>
						<div class="yToolbar">
							<div class="TBHandle"></div>
							<div language="javascript" class="Btn" title="������ɫ" onclick="foreColor()"><IMG class="Ico" height="18" src="icon\fgcolor.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="�Ӵ�" onclick="format('bold')"><IMG class="Ico" height="18" src="icon\bold.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="б��" onclick="format('italic')"><IMG class="Ico" height="18" src="icon\italic.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="�»���" onclick="format('underline')"><IMG class="Ico" height="18" src="icon\underline.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="�ϱ�" onclick="format('superscript')"><IMG class="Ico" height="18" src="icon\sup.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="�±�" onclick="format('subscript')"><IMG class="Ico" height="18" src="icon\sub.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="���볬������" onclick="UserDialog('CreateLink')"><IMG class="Ico" height="18" src="icon\url.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="ȡ����������" onclick="UserDialog('unLink')"><IMG class="Ico" height="18" src="icon\nourl.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="������ͨˮƽ��" onclick="format('InsertHorizontalRule')"><IMG class="Ico" height="18" src="icon\line.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="��������ˮƽ��" onclick="hr()"><IMG class="Ico" height="18" src="icon\sline.gif" width="18">
							</div>
							<div class="TBGen" title="�鿴HTMLԴ����"><input id="EditMode" onclick="setMode(this.checked)" type="checkbox">
								�鿴HTMLԴ����</div>
                            <asp:HiddenField ID="HFID" runat="server" />
						</div>
						<div>
						  <fieldset> <LEGEND style="WIDTH: 35px; HEIGHT: 15px" align="left">���¸���</LEGEND>
						   <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            Caption="�����б�" CaptionAlign="Left" DataKeyNames="fileid" 
            Font-Size="Smaller" Width="100%" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" CommandArgument='<%# Eval("fileurl") %>'
                            Text="ɾ��" OnClientClick="return confirm('ȷ��Ҫɾ����������')"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="�ļ�����" SortExpression="filename">
                  
                    <ItemTemplate>
                       <a href='../Module/openfile.aspx?url=../../file/uploadFiles/<%# Eval("fileurl") %>' ><asp:Label ID="Label1" runat="server" Text='<%# Bind("filename") %>'></asp:Label></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="fileurl" HeaderText="�ļ�·��" InsertVisible="False" ReadOnly="True"
                    SortExpression="fileurl" />
                <asp:BoundField DataField="crdate" DataFormatString="{0:d}" HeaderText="�ϴ�����" HtmlEncode="False"
                    SortExpression="crdate" />
            </Columns>
            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                               <RowStyle HorizontalAlign="Center" />
        </asp:GridView>
     
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="DelArticleExtran"
            SelectMethod="getArticleExtran" TypeName="zaxteam.mng">
            <DeleteParameters>
                <asp:Parameter Name="fileid" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="HFID" DefaultValue="0" Name="articleid" PropertyName="Value"
                    Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
	     					  <p id="iUpload">
                              </p>
    <p><input type="button" value="��Ӹ���.." onclick="addFile();" class="button" /></p></fieldset>
						</div>
						<iframe class="HtmlEdit" id="HtmlEdit" style="WIDTH: 697px; HEIGHT: 343px" marginWidth="1"
							marginHeight="1" width="100%" height="320" runat="server"></iframe>
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 67px"></TD>
					<TD style="WIDTH: 914px"><asp:button id="cmdSend" accessKey="s" runat="server" CssClass="button" Text=" ��  ��(S)" CommandName="add" OnClick="cmdSend_Click"></asp:button><input id="hid" type="hidden" name="hidValue" runat="server"></TD>
					<TD></TD>
				</TR>
			</TABLE>
			<script src="edit.js" type="text/javascript"></script>
		<script type="text/javascript">
			HtmlEdit.document.designMode = "on";
		</script>
    </div>
    </form>
</body>
</html>
