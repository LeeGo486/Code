<!-- #include file="Setup.asp" -->
<%
HtmlTop
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> �� <a href="help.asp">ʹ�ð���</a></div>
<%if Request("menu")="Ranks"then%>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td width="30%" align="center">�ȼ�����</td>
		<td width="30%">
		<p align="center">����ֵ</p>
		</td>
		<td width="30%">����ͼ��</td>
	</tr>
<%
sql="Select * from [BBSXP_Ranks] order by PostingCountMin"
Set Rs=Execute(sql)
do while not Rs.eof
%>
	<tr id=CommonListCell>
		<td width="30%" align="center"><%=Rs("RankName")%></td>
		<td width="30%" align="center">��<%=Rs("PostingCountMin")%></td>
		<td width="30%">
		<img src="<%=Rs("RankIconUrl")%>">
		</td>
	</tr>
<%
Rs.Movenext
loop
Set Rs = Nothing
%>
</table>
<%elseif Request("menu")="ybb"then%>

<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td>ʲô��YBB(Yuzi Bulletin Board)���룿 </td>
	</tr>
	<tr id=CommonListCell>
		<td>����YBB������HTML��һ�����֡���Ҳ���Ѿ���������Ϥ�ˡ�һ������£������������HTM��Ҳ�Ϳ���ʹ��YBB���롣��ʹ������������������ʹ��HTML����Ҳ����ʹ��YBB���롣 ����Ҫ��ʹ�õı�����٣���ʹ����ʹ��HTML��������Ҳ��ʹ��YBB���룬��Ϊ�������Ŀ����Դ���С�ˡ�
		</td>
	</tr>
	<tr id=CommonListTitle>
		<td>URL��������</td>
	</tr>
	<tr id=CommonListCell>
		<td>��������Ϣ����볬�����ӣ�ֻҪ�����з�ʽ����Ϳ�����<br><br>
		<font color="red">[url]</font><a target="_blank" href="http://www.yuzi.net">http://www.yuzi.net</a><font color="red">[/url]</font>
		<br>���� <br>
		<font color="red">[url=http://www.yuzi.net]</font><a target="_blank" href="http://www.yuzi.net">YUZI������</a><font color="red">[/url]</font><br><br>
		���������룬YBB������Զ���URL�������ӣ�����֤���û�����µĴ���ʱ��������Ǵ��ŵġ�ע��URL��&quot;http://&quot;��һ����������ġ�</td>
	</tr>
	<tr id=CommonListTitle>
		<td>�����ʼ�����</td>
	</tr>
	<tr id=CommonListCell>
		<td>��������Ϣ���������ʼ��ĳ������ӣ�ֻҪ������������Ϳ�����<br>
<br>
		<font color="red">[email]</font><a href="mailto:yuzi@yuzi.net">yuzi@yuzi.net</a><font color="red">[/email]</font><br>
<br>
���������룬YBB�����Ե����ʼ��Զ��������ӡ� </td>
	</tr>
	<tr id=CommonListTitle>
		<td>������б��</td>
	</tr>
	<tr id=CommonListCell>
		<td>������ʹ�� [b] [i] ����Щ��־�Դﵽ��������ʹ����Ӧ��Ч��<br>
		<br>
		����,<font color="red">[b]</font><strong>����Ա</strong><font color="red">[/b]</font><br>
		����,<font color="red">[i]</font><em>����Ա</em><font color="red">[/i]</font><br>
		����,<font color="red">[u]</font><u>����Ա</u><font color="red">[/u]</font><br>
		����,<font color="red">[strike]</font><strike>����Ա</strike><font color="red">[/strike]</font></td>
	</tr>
	<tr id=CommonListTitle>
		<td>�ƶ�����</td>
	</tr>
	<tr id=CommonListCell>
		<td height="42">��������Ϣ������ƶ����֣�ֻҪ����������Ϳ�����<br><br>
		<font color="red">[marquee]</font>�ƶ�����<font color="red">[/marquee]</font><br>
		
		<marquee>�ƶ�����</marquee></td>
	</tr>
	<tr id=CommonListTitle>
		<td>����������Ϣ</td>
	</tr>
	<tr id=CommonListCell>
		<td>����һЩ�˵����ӣ�ֻҪ���кͿ���Ȼ����������Ϳ�����<br>
		<br><font color="red">
		[QUOTE]</font>�������Ĺ�����Ϊ����ʲô......<br>
		������Ϊ���Ĺ�����ʲô��<font color="red">[/QUOTE]</font>
		<BLOCKQUOTE>�������Ĺ�����Ϊ����ʲô......<br>
		������Ϊ���Ĺ�����ʲô��</BLOCKQUOTE>
		</td>
	</tr>
	<tr id=CommonListTitle>
		<td>��ɫ����</td>
	</tr>
	<tr id=CommonListCell>
		<td><font color="red">[COLOR=green]</font><font COLOR="#008000">��ɫ����</font><font COLOR="red">[/COLOR]</font>������green���������ֵ���ɫ<font color="red"><br>
		[FONT=����]</font><font face="����">��ɫ����</font><font color="red">[/FONT]</font>���������塱�������ֵ�����<font color="red"><br>
		[SIZE=5]</font><font size="5">��ɫ����</font><font color="red">[/SIZE]</font>������5���������ֵĴ�С</td>
	</tr>
	<tr id=CommonListTitle>
		<td>�ر�ע��</td>
	</tr>
	<tr>
		<td height="76" bgcolor="FFFFFF">
		<p>��������ͬʱʹ��<font face="Verdana, Arial">HTML</font>��YBB�����ͬһ�ֹ��ܡ�����ע��YBB���벻�Դ�Сд���С�������������<font color="red">[URL]</font> 
		�� <font color="red">[url]</font> <font color="800000">
		<br>
		����ȷ��</font><font color="800000" face="Verdana, Arial">YBB</font><font color="800000">����ʹ�ã�</font><font face="Verdana, Arial"><font color="red"><br>
		[url]</font> www.yuzi.net <font color="red">[/url]</font> </font>��Ҫ�����ź������������֮���пո�<font face="Verdana, Arial"><font color="red"><br>
		[email]</font>yuzi@yuzi.net<font color="red">[email]</font>
		</font>�ڽ���ʱ����Ҫ�����������ڼ���б��<font color="red">[/email]</font>
		</p>
		</td>
	</tr>
</table>


<%else%>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td>���������� </td>
	</tr>
	<tr id=CommonListCell>
		<td><b>ע��͵�¼</b> <br>
		<a href="#A1">��ΪʲôҪע�᣿ </a><br>
		<a href="#A2">��������ע�᣿ </a><br>
		<a href="#A3">���Ѿ�ע�����û��������룬��ô��¼�� </a><br>
		<a href="#A4">���Ѿ���¼��Ϊʲô�����Զ�ע����</a> <br>
		<a href="#A5">���������û���/����.</a> <br>
		<a href="#A6">Ϊʲô����ע�ᵫ�Բ��ܵ�¼��</a> <br>
		<a href="#A7">��ǰע�ᣬ�������ڲ��ܵ�¼��</a>
		<p><b>�û��������� &amp; ���� </b><br>
		<a href="#B1">ʲô�Ǹ������ϣ�</a> <br>
		<a href="#B2">��������������ǩ����</a> <br>
		<a href="#B3">ʲô��ͷ��</a> <br>
		<a href="#B4">��������ҵ�ͷ�� </a><br>
		<a href="#B5">Ϊʲô����Ҫ��¼���ܷ���������û����ϣ�</a> <br>
		<a href="?menu=Ranks">����֪���û��ĵȼ����ƣ�</a></p>
		<p><b>��˽ &amp; ��ȫ</b> <br>
		<a href="#C1">��θ������룿 </a><br>
		<a href="#C2">��θ���e-mail��ַ��</a> <br>
		<a href="#C3">Ҫ�����õĸ������ϣ�</a> </p>
		<p><b>����</b> <br>
		<a href="#D1">ʲô����̳�飿</a> <br>
		<a href="#D2">ʲô����̳��</a> <br>
		<a href="#D3">ʲô�����⣿ </a><br>
		<a href="#D4">����ͼ����ʲô��˼��</a> <br>
		<a href="#D5">�������̳ʱ�������κ�����/���ӣ�</a> <br>
		<a href="#D6">Ϊʲô�������Ҹշ������ӣ�</a> <br>
		<a href="#D7">ʲô���ö����� </a><br>
		<a href="#D8">ʲô��������</a> <br>
		<a href="#D9">�������̳ʱ���ܽ����������� </a><br>
		<a href="#D10">��̳��RSSͼ����ʲô��</a> <br>
		<a href="#D11">�Ҳ��ܵ�¼��ǰ���ʹ�����̳��</a> </p>
		<p><b>���� </b><br>
		<a href="#E1">����ʹ��HTML��</a> <br>
		<a href="#E2">ʲô��YBB���룿</a> <br>
		<a href="#E3">�ҿ������ҵ�����������Ӹ�����</a> <br>
		<a href="#E4">ʲô�Ǳ���ͼ�ꣿ</a> <br>
		<a href="#E5">�����������ڰ���з��������ӣ�</a> <br>
		<a href="#E6">��ô�ظ�һ�����ӣ�</a> <br>
		<a href="#E7">��ô���޸��ҵ����ӣ�</a> <br>
		<a href="#E8">��ôɾ���ҵ����ӣ�</a> <br>
		<a href="#E9">Ϊʲô�ҵ���������Щ�ʱ��滻���ˡ�***����</a> <br>
		<a href="#E10">����ô���ҵ������м�ǩ����</a> <br>
		<a href="#E11">��ô��ͷ����ӵ������У�</a> <br>
		<a href="#E12">����֪����̳�ķ�������</a></p>
		<p><b>�û����Ȩ��</b> <br>
		<a href="#F1">ʲô��Ȩ�ޣ�</a> <br>
		<a href="#F2">ʲô�ǹ���Ա��</a> <br>
		<a href="#F3">ʲô�ǳ���������</a> <br>
		<a href="#F4">ʲô�ǰ�����</a><br>
		<a href="#F5">ʲô����̳��ɫ��</a> <br>
		<a href="#F6">����μ���һ����̳��ɫ���飿</a> <br>
		<p><b>���� BBSXP</b> <br>
		<a href="#G1">ʲô�� BBSXP��</a> <br>
		<a href="#G2">˭��ʹ�� BBSXP��</a> <br>
		<a href="#G3">˭������ BBSXP�� </a><br>
		<a href="#G4">���Ļ�ȡ BBSXP �Ŀ�����</a> </p>
		</td>
	</tr>
</table>
<p>��</p>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td>ע�� &amp; ��¼ </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="A1"></a><b>��ΪʲôҪע�᣿ </b><br>
		�������Ķ������˵�����ǰ�Ƿ���Ҫ��¼����ȡ������̳����Ա�Ƿ���������̳���ο�Ȩ�ޡ����������������Ҫע���¼�Ϳ����Ķ���Ϣ��ͨ��ע�����������ܵ����еĸ��ӹ��ܣ����磺��������ͷ��
		�ղظ���Ȥ�����ӡ����û������ʼ���˽�����ԡ�����һЩ�ܱ�������̳�ȵȣ�ע�Ჽ��Ҳ�ǳ��򵥣�һ���Ӿ�����ɡ�<br><a href="#top">���ض���</a></a><br>
		 </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="A2"></a><b>��������ע�᣿ </b><br>
		Ҫע��һ�����ʺţ�����Ҫ����ע�Ტ�Ұ���Ҫ����дע������������ṩһ���û�����һ����Ч�ĵ��������ַ������Ա����Ҫ����ָ�����룬�������Ҫָ�����룬��ô��ע����ɺ������յ�ȷ���ʼ��� 
		<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="A3"></a><b>���Ѿ�ע�����û��������룬��ô��¼�� </b><br>
		ע��ɹ����㽫ӵ��һ���û��������룬����Է��ʵ�¼ҳ�沢���������û����������¼����̳�� <br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="A4"></a><b>���Ѿ���¼��Ϊʲô�����Զ�ע����</b> <br>
		�����¼��ʱ�����û��ѡ�� &quot;�Զ���¼&quot; ��ѡ���������뿪ʱ�Զ�ע������������һֱ���ֵ�¼״̬�����ڵ�¼��ʱ��ѡ�� &quot;�Զ���¼&quot; ��ѡ�� 
		<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="A5"></a><b>������������.</b> <br>
		���������������룬�����Է��� &quot;�һ�����&quot; 
		ҳ������ע��ʱ�ĵ��������ַ������һ������������ʼ����͵�����ע�����䡣��Ϊ�����ǲ�������ܴ洢�����������޷��һ�����ԭʼ���롣һ�����յ����������룬�����Ե�¼���޸��������롣 
		<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="A6"></a><b>��ע�ᵫ����Ȼ���ܵ�¼�� </b><br>
		�������ע�ᵫ����Ȼ���ܵ�¼,��ȷ�����Ƿ���һ���Ϸ����û��������롣 
		�����ȷ������û�������������ȷ�ģ�����Ȼ�޷����룬���������ʺ���Ҫ���������ʺ���ͣ���С� ��������ԭ���������ϵ�������ǹ���Ա�� <br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="A7"></a><b>��ע�ᣬ�������ڲ��ܵ�¼�� </b><br>
		���ȼ������û����������Ƿ���ȷ�������Ȼ���ܵ�¼������ʺſ������ڳ���δ��¼�ѱ�ɾ����������̳����Ա���߰�����ϵ�� <br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
</table>
<p>��</p>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td>�û����� &amp; ���� </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="B1"></a><b>ʲô�Ǹ������ϣ�</b> <br>
		�������Ͼ�������ʺ���Ϣ���ʺſ���������β鿴��̳�ϵ����ӡ���������������������ӵ���ϸ���ϣ������������˹����˽����Ϣ�������ַ�����͵�ַ���Լ�һЩ���������������̳�໥���õ�����
		��<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="B2"></a><b>��������������ǩ���� </b><br>
		ǩ�����Ǹ������㷢������̳�ϵ�ÿһƪ���Ӻ������Ϣ. ������ڸ�������ҳ��༭���ǩ��. ��ǩ������ʾ������������κ���Ϣ��β����<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="B3"></a><b>ʲô��ͷ��</b> <br>
		ͷ����һ�����Ӹ���������<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="B4"></a><b>���������ͷ�� </b><br>
		�������Ա������ͷ�񣬵���鿴��������ʱ���Կ���ͷ�����������������ѡ��һ����ϲ����ͷ������ϴ���������һ��ͼƬ����ַ����Ϊ���ͷ��<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="B5"></a><b>Ϊʲô����Ҫ��¼���ܷ���������û����ϣ� </b>
		<br>
		���ݹ���Ա���������̳���������Ҫ��¼�������/ʹ����̳��ĳЩ��������Ҫ��Ϊ�˱����û�����˽��<br><a href="#top">���ض���</a> 
		<br>
		 </td>
	</tr>

	</table>
<p>��</p>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td>˽����Ϣ &amp; ��ȫ </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="C1"></a><b>��θ������룿 </b><br>
		��¼�Ժ������ڸ�������ҳ����������롣<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="C2"></a><b>��θ���email��ַ��</b> <br>
		������ڿ�����壭�������޸������Email��ַ��<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="C3"></a><b>Ҫ�����õĸ������ϣ� </b><br>
		ֻ�е��������ַ�Ǳ�����ġ� ��������ַ�������㷢����Ԥ������̳��Ϣ�������㷢�����ǵ��û��������롣���������϶��ǲ��Ǳ�����ġ�<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
</table>
<p>��</p>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td>���� </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="D1"></a><b>ʲô����̳�飿</b> <br>
		��̳���Ǹ�����������ذ���Ĵ��ࡣһ����̳�����һ�������Ӱ��档<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="D2"></a><b>ʲô�ǰ�飿 </b><br>
		�����������һϵ��������顣һ����������ƪ���ӻ��߶�����档<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="D3"></a><b>ʲô�����⣿</b> <br>
		һ���������һ����ص����ӣ����Ƕ�������һ�����⡣��һƪ���ӳ�Ϊһ�����⣬�������������������档�������滹��¼һ�����ٻ�����˭����������Ϣ��<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="D4"></a><b>����ͼ�����ʲô��˼��</b> 
		<table border=0 width="100%">
			<tr>
				<td><img src="images/topic-announce.gif" border="0"> ��������</td>
				<td><img src="images/topic-pinned.gif" border="0"> �ö�����</td>
				<td><img src="images/topic-popular.gif"> ��������</td>
				<td><img src="images/topic-locked.gif" border="0"> ��������</td>
				<td><img src="images/topic-poll.gif" border="0"> ͶƱ����</td>
				<td><img src="images/topic-hot.gif" border="0" title="�ظ����ﵽ <%=SiteConfig("PopularPostThresholdPosts")%> ���ߵ�����ﵽ <%=SiteConfig("PopularPostThresholdViews")%>"> �������� </td>
				<td><img src="images/topic.gif" border="0"> ��ͨ����</td>

			</tr>
		</table>
<a href="#top">���ض���</a></td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="D5"></a><b>���������̳ʱ��Ϊʲô�������κ�����/���ӣ�</b> <br>
		���û�˷����ӣ���Ȼ�Ϳ�������Ҫô���������������ӹ��������������㲻�뿴�����ӡ����������������ֻ��ʾĳ�������Ժ�����ӣ�����ֻ��ʾ���������ڵ����ӡ�<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="D6"></a><b>Ϊʲô�Ҹշ������ӿ�������</b> <br>
		��̳�������ñ༭����������˹��ܡ��������һ����Ҫ��˵���̳������ϵͳ�����һ����Ϣ��������������ڵȴ���ˡ�һ�����Աͨ����ˣ�������Ӳſɼ������Ա�����ƶ����޸Ļ�ɾ��������ӣ������������Ϊ������Ӳ��ʺ��������̳����Ļ���<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="D7"></a><b>ʲô���ö����ӣ�</b> <br>
		�����ܳ�������̳�����б���ǰ������ӡ�<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="D8"></a><b>ʲô����������</b> <br>
		���ǲ��ܻظ������ӡ������ˡ�����Ա��������������������һ�����ӡ�<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="D9"></a><b>����ʱ���ɷ�����</b> <br>
		���ԣ����������򣬻ظ����򣬵�������������������С�Ĭ���ǰ���ʱ���������µ����������档<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="D10"></a><b>��̳��RSSͼ����ʲô������</b> <br>
		���RSSͼ��������������̳��RSS���ӡ�RSS��Ҫʹ��ר�ŵ��Ķ������Ķ���<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="D11"></a><b>����ô��������̳��</b> <br>
		������¼��ǰ���ʹ�����̳��ȴ����һ��δ֪�Ĵ��󣬿���������ԭ��һ��ԭ���������̳Ҫ��Ҫע����ܵ�¼����һ��ԭ����������̳�Ѿ��ر��ˡ�<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
</table>
<p>��</p>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td>���� </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="E1"></a><b>������HTML������</b> <br>
		���ԣ����ǲ���ֱ�����뵽�༭���ڡ� �������IE�����Ĭ�ϱ༭����һ���߼�HTML�༭���������Զ�����HTML���롣�������������������������ʹ��һ����ͨ��HTML�༭���� 
<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="E2"></a><b>ʲô��YBB���룿</b> <br>
		�������ڰ����ָ���ܶ໨�����﷨��<a href="?menu=ybb">�������ɲ鿴YBB������ϸʹ�÷���</a>��<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="E3"></a><b>�������Դ�������</b> <br>
		���ԣ�����Ҫ����Ա���Ŵ˹��ܡ�<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="E4"></a><b>ʲô�Ǳ���ͼ�ꣿ</b> <br>
		�����ڷ���ʱ���Բ����һЩСͼ�꣬���磺Ц���������ȡ�<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="E5"></a><b>��ô��������</b> <br>
		����̳�ϵġ����������⡱ͼƬ�����һ��������ҳ�棨�������Ѿ���¼�������Ҫ�����ȵ�¼����<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="E6"></a><b>��ô�ظ�һ�����ӣ�</b> <br>
		�㡰�ظ�����ť�����á���ť�Ϳ��Իظ����ӡ�<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="E7"></a><b>��ô���޸��ҵ����ӣ�</b> <br>
		������༭�����ͼ��ť����Ա༭������ӡ�<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="E8"></a><b>��ôɾ���ҵ����ӣ�</b> <br>
		�����ɾ�������ͼ��ť�����ɾ��������ӡ�<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="E9"></a><b>Ϊʲô�ҵ���������Щ�ʱ��滻���ˡ�***����</b> <br>
		����ԱҲ���Ѿ�Ϊ���������˴�������������������������ʱ��ĳЩ����Ϊ�����ð���Ĵ��ｫ����ĸ***�滻��<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="E10"></a><b>����ô���ҵ������м�ǩ����</b> <br>
		���ڿ�����壭�������޸�������ǩ����<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="E11"></a><b>��ô��ͷ����ӵ������У�</b> <br>
		���ڿ�����壭�������޸�������ͷ��<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td>
		
		
<a name="E12"></a><b>��������
</b>
<table border="0" cellpadding="5" cellspacing="1">
	<tr>
		<td>1������������<br>
		����&nbsp; ����ֵ��<font color="red"><%=SiteConfig("IntegralAddThread")%></font><br>
		����&nbsp; ��Ǯֵ��<font color="red"><%=SiteConfig("IntegralAddThread")%></font><br>
	</tr>
		<td>2���ظ�����<br>
		����&nbsp; ����ֵ��<font color="red"><%=SiteConfig("IntegralAddPost")%></font><br>
		����&nbsp; ��Ǯֵ��<font color="red"><%=SiteConfig("IntegralAddPost")%></font></tr>
		<td>3����Ϊ������<br>
		����&nbsp; ����ֵ��<font color="red"><%=SiteConfig("IntegralAddValuedPost")%></font><br>
		����&nbsp; ��Ǯֵ��<font color="red"><%=SiteConfig("IntegralAddValuedPost")%></font></tr>
		<td>4��ɾ��������<br>
		����&nbsp; ����ֵ��<font color="red"><%=SiteConfig("IntegralDeleteThread")%></font><br>
		����&nbsp; ��Ǯֵ��<font color="red"><%=SiteConfig("IntegralDeleteThread")%></font></tr>
		<td>5��ɾ���ظ���<br>
		����&nbsp; ����ֵ��<font color="red"><%=SiteConfig("IntegralDeletePost")%></font><br>
		����&nbsp; ��Ǯֵ��<font color="red"><%=SiteConfig("IntegralDeletePost")%></font></tr>
		<td>6��ȡ��������<br>
		����&nbsp; ����ֵ��<font color="red"><%=SiteConfig("IntegralDeleteValuedPost")%></font><br>
		����&nbsp; ��Ǯֵ��<font color="red"><%=SiteConfig("IntegralDeleteValuedPost")%></font></tr>
	</table>
<a href="#top">���ض���</a></td>
	</tr>
</table>
<p>��</p>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td>�û����Ȩ��</td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="F1"></a><b>ʲô��Ȩ�ޣ�</b> <br>
���������̳ʱ��Ȩ�޿������������ʲô�Ͳ�������ʲô����ʹ����̳��Ĭ�Ϲ۵�ʱ��Ȩ�ޱ���ʾ��ÿҳ�����½ǣ���Ӧ��Ȩ�޵ĵط������㱻�����Ȩ�޿�����������̳����ķ������档<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="F2"></a><b>ʲô�ǹ���Ա��</b> <br>
		����Աӵ����̳����߼�Ȩ�ޡ�Ĭ������£�����Ա��������̳��ִ���κβ���������Ȩ�ޡ�<br><a href="#top">���ض���</a></td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="F3"></a><b>ʲô�ǳ���������</b> <br>
		��������ӵ����̳�ĵڶ���Ȩ�ޡ�Ĭ������£�����������������̳ǰִ̨���κβ���������Ȩ�ޣ��������ӹ��桢������⡢�鿴�����û�IP�ȵȡ�<br><a href="#top">���ض���</a></td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="F4"></a><b>ʲô�ǰ����� </b><br>
		����ӵ�еİ���ڵ��κ�Ȩ�ޡ������ܹ��������İ����ִ���κβ������������׼���ӡ�ת�����ӡ�ɾ�����ӡ��༭���ӡ�������й���ĳ�������⣬��õĽ���취����ͬ������ϵ��<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="F5"></a><b>ʲô����̳��ɫ��</b> <br>
		��̳��ɫ��ָΪ��ָ��Ȩ�޶�����ͨ�û����з��顣�����ܸ��û�ָ�ɽ�ɫ���Լ�Ȩ�ޱ�Ӧ�õ�������Щ��ɫ����̳�ϣ�����Ա�Ͱ����Ĺ�����ø��������� <br><a href="#top">���ض���</a></td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="F6"></a><b>����μ���һ����̳��ɫ���飿</b> <br>
����Ա����̳��ɫָ�ɸ����û��������ϣ������һ���ض�����̳��ɫ���������Ա��ϵ�Ի�ȡ�������Ϣ��<br><a href="#top">���ض���</a></td>
	</tr>

	</table>
<p>��</p>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<tr id=CommonListTitle>
		<td>���� BBSXP�� </td>
	</tr>
	<tr id=CommonListCell>
		<td><a name="G1"></a><b>ʲô�� BBSXP��</b> <br>
		BBSXP ��һ��ʹ��ASP���Կ�������̳ϵͳ��<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="G2"></a><b>˭��ʹ�� BBSXP��</b> <br>
		�ܶ๫����˽�˵���֯��ʹ����������̳ϵͳ��<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="G3"></a><b>˭������ BBSXP��</b> <br>
		BBSXP ����YUZI�����Ŷӿ���������Բ��� <a target="_blank" href="http://www.yuzi.net">http://www.yuzi.net</a> �õ��������Ѷ��<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>

	<tr id=CommonListCell>
		<td><a name="G4"></a><b>���Ļ�ȡBBSXP�Ŀ����� </b><br>
		���� <a target="_blank" href="http://www.bbsxp.com">http://www.bbsxp.com</a> �������� BBSXP �����°汾��<br><a href="#top">���ض���</a><br>
		 </td>
	</tr>
</table>
<%end if%>

<%HtmlBottom%>