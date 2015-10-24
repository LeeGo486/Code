<%@ page language="C#" autoeventwireup="true" inherits="isprit_news_addnews, App_Web_addnews.aspx.9a188d08" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加、编辑新闻</title>
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
					ans=window.confirm('确定要添加|更改新闻?');
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
					<TD style="WIDTH: 914px; HEIGHT: 10px" width="914">新闻标题:<INPUT id="tbtitle" style="WIDTH: 232px; HEIGHT: 21px" accessKey="a" type="text" maxLength="100"
							size="33" runat="server">(A)类别:<SELECT id="lbclass" style="WIDTH: 120px" accessKey="b" runat="server" DataTextField="newsclass"
							DataValueField="classid">
							<OPTION selected></OPTION>
						</SELECT>[作者]
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
								<option selected>段落格式</option>
								<option value="<P>">普通</option>
								<option value="<PRE>">已编排格式</option>
								<option value="<H1>">标题一</option>
								<option value="<H2>">标题二</option>
								<option value="<H3>">标题三</option>
								<option value="<H4>">标题四</option>
								<option value="<H5>">标题五</option>
								<option value="<H6>">标题六</option>
								<option value="<H7>">标题七</option>
							</select>
							<select class="TBGen" id="specialtype" onchange="specialtype(this[this.selectedIndex].value);this.selectedIndex=0">
								<option selected>特殊格式</option>
								<option value="SUP">上标</option>
								<option value="SUB">下标</option>
								<option value="DEL">删除线</option>
								<option value="BLINK">闪烁</option>
								<option value="BIG">增大字体</option>
								<option value="SMALL">减小字体</option>
							</select>
							<div class="TBSep"></div>
							<select class="TBGen" id="FontName" onchange="format('fontname',this[this.selectedIndex].value);this.selectedIndex=0">
								<option selected>字体</option>
								<option value="宋体">宋体</option>
								<option value="黑体">黑体</option>
								<option value="楷体_GB2312">楷体</option>
								<option value="仿宋_GB2312">仿宋</option>
								<option value="隶书">隶书</option>
								<option value="幼圆">幼圆</option>
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
								<option selected>字号</option>
								<option value="7">一号</option>
								<option value="6">二号</option>
								<option value="5">三号</option>
								<option value="4">四号</option>
								<option value="3">五号</option>
								<option value="2">六号</option>
								<option value="1">七号</option>
							</select>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="全部选择" onclick="format('selectall')"><IMG class="Ico" height="18" src="icon\selectall.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="删除" onclick="format('delete')"><IMG class="Ico" height="18" src="icon\del.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="剪切" onclick="format('cut')"><IMG class="Ico" height="18" src="icon\cut.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="复制" onclick="format('copy')"><IMG class="Ico" height="18" src="icon\copy.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="粘贴" onclick="format('paste')"><IMG class="Ico" height="18" src="icon\paste.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="撤消" onclick="format('undo')"><IMG class="Ico" height="18" src="icon\undo.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="恢复" onclick="format('redo')"><IMG class="Ico" height="18" src="icon\redo.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="插入表格" onclick="InsertTable()"><IMG class="Ico" height="18" src="icon\table.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="插入栏目框" onclick="FIELDSET()"><IMG class="Ico" height="18" src="icon\fieldset.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="插入网页"><IMG class="Ico" height="18" src="icon\htm.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="插入图片" onclick="forPic()"><IMG class="Ico" height="18" src="icon\img.gif" width="18">
							</div> <!--
							<div language="javascript" class="Btn" title="插入画中画广告" onclick="adv()"><IMG class="Ico" height="18" src="icon\adv.gif" width="18">
							</div>-->
						</div>
						<div class="yToolbar">
							<div class="TBHandle"></div>
							<div language="javascript" class="Btn" title="左对齐" onclick="format('justifyleft')" NAME="Justify"><IMG class="Ico" height="18" src="icon\aleft.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="居中" onclick="format('justifycenter')" NAME="Justify"><IMG class="Ico" height="18" src="icon\acenter.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="右对齐" onclick="format('justifyright')" NAME="Justify"><IMG class="Ico" height="18" src="icon\aright.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="编号" onclick="format('insertorderedlist')"><IMG class="Ico" height="18" src="icon\num.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="项目符号" onclick="format('insertunorderedlist')"><IMG class="Ico" height="18" src="icon\list.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="减少缩进量" onclick="format('outdent')"><IMG class="Ico" height="18" src="icon\outdent.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="增加缩进量" onclick="format('indent')"><IMG class="Ico" height="18" src="icon\indent.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="删除文字格式" onclick="format('RemoveFormat')"><IMG class="Ico" height="18" src="icon\clear.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="保存" onclick="save()"><IMG class="Ico" height="18" src="icon\save.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="插入flash多媒体文件" onclick="swf()"><IMG class="Ico" height="18" src="icon\flash.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="插入视频文件，支持格式为：avi、wmv、asf" onclick="wmv()"><IMG class="Ico" height="18" src="icon\wmv.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="插入RealPlay文件，支持格式为：rm、ra、ram" onclick="rm()"><IMG class="Ico" height="18" src="icon\rm.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="查看帮助" onclick="help()"><IMG class="Ico" height="18" src="icon\help.gif" width="18">
							</div>
							<div class="TBSep"></div>
						</div>
						<div class="yToolbar">
							<div class="TBHandle"></div>
							<div language="javascript" class="Btn" title="字体颜色" onclick="foreColor()"><IMG class="Ico" height="18" src="icon\fgcolor.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="加粗" onclick="format('bold')"><IMG class="Ico" height="18" src="icon\bold.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="斜体" onclick="format('italic')"><IMG class="Ico" height="18" src="icon\italic.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="下划线" onclick="format('underline')"><IMG class="Ico" height="18" src="icon\underline.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="上标" onclick="format('superscript')"><IMG class="Ico" height="18" src="icon\sup.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="下标" onclick="format('subscript')"><IMG class="Ico" height="18" src="icon\sub.gif" width="18">
							</div>
							<div class="TBSep"></div>
							<div language="javascript" class="Btn" title="插入超级连接" onclick="UserDialog('CreateLink')"><IMG class="Ico" height="18" src="icon\url.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="取消超级链接" onclick="UserDialog('unLink')"><IMG class="Ico" height="18" src="icon\nourl.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="插入普通水平线" onclick="format('InsertHorizontalRule')"><IMG class="Ico" height="18" src="icon\line.gif" width="18">
							</div>
							<div language="javascript" class="Btn" title="插入特殊水平线" onclick="hr()"><IMG class="Ico" height="18" src="icon\sline.gif" width="18">
							</div>
							<div class="TBGen" title="查看HTML源代码"><input id="EditMode" onclick="setMode(this.checked)" type="checkbox">
								查看HTML源代码</div>
                            <asp:HiddenField ID="HFID" runat="server" />
						</div>
						<div>
						  <fieldset> <LEGEND style="WIDTH: 35px; HEIGHT: 15px" align="left">文章附件</LEGEND>
						   <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            Caption="符件列表" CaptionAlign="Left" DataKeyNames="fileid" 
            Font-Size="Smaller" Width="100%" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" CommandArgument='<%# Eval("fileurl") %>'
                            Text="删除" OnClientClick="return confirm('确认要删除此数据吗？')"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="文件名称" SortExpression="filename">
                  
                    <ItemTemplate>
                       <a href='../Module/openfile.aspx?url=../../file/uploadFiles/<%# Eval("fileurl") %>' ><asp:Label ID="Label1" runat="server" Text='<%# Bind("filename") %>'></asp:Label></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="fileurl" HeaderText="文件路径" InsertVisible="False" ReadOnly="True"
                    SortExpression="fileurl" />
                <asp:BoundField DataField="crdate" DataFormatString="{0:d}" HeaderText="上传日期" HtmlEncode="False"
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
    <p><input type="button" value="添加附件.." onclick="addFile();" class="button" /></p></fieldset>
						</div>
						<iframe class="HtmlEdit" id="HtmlEdit" style="WIDTH: 697px; HEIGHT: 343px" marginWidth="1"
							marginHeight="1" width="100%" height="320" runat="server"></iframe>
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 67px"></TD>
					<TD style="WIDTH: 914px"><asp:button id="cmdSend" accessKey="s" runat="server" CssClass="button" Text=" 提  交(S)" CommandName="add" OnClick="cmdSend_Click"></asp:button><input id="hid" type="hidden" name="hidValue" runat="server"></TD>
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
