<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!-- #include file="../inc/const.asp" -->
<%call head("")%>
<style type="text/css">
.tbhide{display:none;}
.tbshow{display:block;}
</style>
<script language="javascript">
function tb(tname){
  var t=document.all.item(tname);
  if(t.className=="tbhide")
    t.className="tbshow";
  else
    t.className="tbhide";
}
</script>

<body topmargin=1 leftmargin="0">
<%
dim i,rmax,cmax
dim tree(10,20)
rmax=10
cmax=20

tree(0,0)="url.gif,��������"
tree(0,1)=4
tree(0,2)="advise.gif,�������ƻ�,"
tree(0,3)="advise.gif,¼���ش�����,"
tree(0,4)="advise.gif,�������,"
tree(0,5)="advise.gif,��Ʒ�˳�,"


tree(1,0)="url.gif,���˷�������"
tree(1,1)=6
tree(1,2)="advise.gif,�����̶���,f22_index.asp?com=2-1-1"
tree(1,3)="advise.gif,�����̲���,f22_index.asp?com=2-1-2"
tree(1,4)="advise.gif,���̳��ƻ�,f22_index.asp?com=2-1-2"
tree(1,5)="advise.gif,�����������,f22_index.asp?com=2-1-3"
tree(1,6)="advise.gif,�������̷���,f22_index.asp?com=2-1-4"
tree(1,7)="advise.gif,�������ջ�,f22_index.asp?com=2-1-5"

tree(2,0)="url.gif,���˻�������"
tree(2,1)=5
tree(2,2)="advise.gif,������������������,f22_index.asp?com=5-1-1"
tree(2,3)="advise.gif,�������������⻻��,f22_index.asp?com=5-1-2"
tree(2,4)="advise.gif,������������,f22_index.asp?com=5-1-2"
tree(2,5)="advise.gif,�������˻�����,f22_index.asp?com=5-1-5"
tree(2,6)="advise.gif,�ֿ��ջ�,f22_index.asp?com=2-2-2"

tree(3,0)="url.gif,���̹���"
tree(3,1)=4
tree(3,2)="advise.gif,��������,f22_index.asp?com=3-2-1"
tree(3,3)="advise.gif,�����ջ�,f22_index.asp?com=3-2-2"
tree(3,4)="advise.gif,��������,f22_index.asp?com=3-2-3"
tree(3,5)="advise.gif,�̵����,f22_index.asp?com=3-2-4"

tree(4,0)="url.gif,�������"
tree(4,1)=5
tree(4,2)="advise.gif,��Ӧ�̸���ƾ֤����,"
tree(4,3)="advise.gif,��Ӧ�̵Ķ��ʵ�,"
tree(4,4)="advise.gif,�������տ�ƾ֤����,"
tree(4,5)="advise.gif,�����̵Ķ��ʵ�,"
tree(4,6)="advise.gif,�����̶������,"

tree(5,0)="url.gif,�ƻ�����"
tree(5,1)=3
tree(5,2)="advise.gif,���������ƶ���������,"
tree(5,3)="advise.gif,���������ƶ�����Ԥ��,"
tree(5,4)="advise.gif,���ݶ����ƶ������ƻ�,"

tree(6,0)="url.gif,�����ѯ"
tree(6,1)=3
tree(6,2)="advise.gif,����ѯ,"
tree(6,3)="advise.gif,���۲�ѯ,"
tree(6,4)="advise.gif,�������ѯ,"

tree(7,0)="url.gif,��չ����"
tree(7,1)=3
tree(7,2)="advise.gif,���۹���,"
tree(7,3)="advise.gif,Ѳ��Ǽ�,"
tree(7,4)="advise.gif,����Ʒ�Ƶ���,"

tree(8,0)="f22_01.jpg,��������"
tree(8,1)=15
tree(8,2)="f22_02.jpg,��������,"
tree(8,3)="f22_03.jpg,������𵵰�,"
tree(8,4)="f22_04.jpg,�������ϵ���,"
tree(8,5)="f22_05.jpg,�ո��ʽ����,"
tree(8,6)="f22_06.jpg,��Ӧ�̵���,"
tree(8,7)="f22_06.jpg,�ֻ�֧������,"
tree(8,8)="f22_02.jpg,��ɫ����,"
tree(8,9)="f22_03.jpg,���뵵��,"
tree(8,10)="f22_04.jpg,�����鵵��,"
tree(8,11)="f22_05.jpg,Ʒ�Ƶ���,"
tree(8,12)="f22_03.jpg,��ʽ���ϵ���,"
tree(8,13)="f22_04.jpg,��������ṹ����,"
tree(8,14)="f22_05.jpg,��ʽ����ṹ����,"
tree(8,15)="f22_06.jpg,ӪҵԱ��ε���,"
tree(8,16)="f22_06.jpg,ӪҵԱ����,"

tree(9,0)="url.gif,ϵͳ����"
tree(9,1)=17
tree(9,2)="advise.gif,�����̷�������������,"
tree(9,3)="advise.gif,���̶���,"
tree(9,4)="advise.gif,���ÿ�ʽ����,"
tree(9,5)="advise.gif,�����¾�������չ�ϵ,"
tree(9,6)="advise.gif,���ÿ�ʽ���Ϻ�,"
tree(9,7)="advise.gif,���õ��ݴ�ӡ����,"
tree(9,8)="advise.gif,����Ԥ������,"
tree(9,9)="advise.gif,������ȡ��������Ŀ,"
tree(9,10)="advise.gif,����������,"
tree(9,11)="advise.gif,�����������Ȩ��,"
tree(9,12)="advise.gif,������Ա����Ȩ��,"
tree(9,13)="advise.gif,������,"
tree(9,14)="advise.gif,���㹩Ӧ�����,"
tree(9,15)="advise.gif,������������,"
tree(9,16)="advise.gif,�ƶ����ϵ��,"
tree(9,17)="advise.gif,�ƶ���ȫ���ϵ��,"
tree(9,18)="advise.gif,ά��������־,"

%>
<%for i=0 to rmax
if tree(i,0)=null or tree(i,0)="" then
  exit for
end if
treemain=split(tree(i,0),",")
%>
<table width="170" border="0" cellspacing="0" cellpadding="0" id="tb<%=i%>">
  <tr valign="middle">
    <td background="../skin/<%=session("skindir")%>/image/index_151.gif"  width="27"><img src="../skin/<%=session("skindir")%>/image/<%=treemain(0)%>" broder=0></td>
    <td background="../skin/<%=session("skindir")%>/image/index_151.gif"  width="123" height="27"><font class="mainleftf1"><%=treemain(1)%></font></td>
    <td background="../skin/<%=session("skindir")%>/image/index_151.gif"  width="20"><font class="mainleftf1"><a href="javascript:tb('tbs<%=i%>');"><img src="../skin/<%=session("skindir")%>/image/Test_35a.gif" border="0"></a></font></td>
  </tr>
</table>
<table width="170" border="0" cellspacing="0" cellpadding="0" id="tbs<%=i%>">
  <%for j=2 to cmax
  if tree(i,j)=null or tree(i,j)="" then
    response.Write("<tr height=8><td colspan=2></td></tr>")
    exit for
  end if
  treesub=split(tree(i,j),",")%>
  <tr>
    <td width="50"><img src="../skin/<%=session("skindir")%>/image/<%call showimg (j-1,tree(i,1))%>" border="0"><img src="../skin/<%=session("skindir")%>/image/<%=treesub(0)%>" border="0"></td>
    <td width="120"> <font class="mainleftf1"><a href="<%=treesub(2)%>" target="main"><%=treesub(1)%></a></font></td>
  </tr>
  <%next%>
</table>
<%next

sub showimg(t,m)
select case t
case 1 response.Write("c1.gif") 
case m response.Write("c3.gif")
case else response.write("c2.gif")
end select
end sub%>
</body>
</html>
