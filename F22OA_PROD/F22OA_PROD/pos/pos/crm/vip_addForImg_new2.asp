<%session("formid")=6101021%>
<!--#include file="inc/function.asp"-->
<%
 
if not padd then
    call mbox("û������Ȩ�ޣ�")
end if
dim readonly
readonly=""
dim act,ds,id,userid
set ds=server.CreateObject("ADODB.Recordset")
set rs=server.CreateObject("ADODB.Recordset")
set fs=server.CreateObject("adodb.recordset")
set fs1=server.CreateObject("adodb.recordset")
ds.ActiveConnection = cn
rs.ActiveConnection = cn
fs.activeconnection = cn
fs1.activeconnection = cn
id=trim(request.QueryString("id"))
userid = session("dm").System_userid
depotid = session("dm").System_Depotid
act=trim(request.QueryString("act"))
if act="" then act="add"

select case act
case "del"

case "add"
   session("viptmpid")="tmp"&userid&formatdatetime(now(),0)
   getmag = true
case "view","edit"

	'�����޸���
	if act="edit" then
		sql="select readid from vip_read where isnull(change,0)=1"
		rs.open sql,cn,1,1
			do while not rs.eof
				if readonly<>"" then readonly=readonly&","
				readonly=readonly&"."&rs("readid")
			rs.movenext
			loop
		rs.close
	end if

  if id<>"" then
    sql="select a.*,isnull(a.centum,0)+isnull(b.starcentum,0) as zcentum,isnull(a.sums,0)+isnull(b.starsums,0) as zsums,userpicture=DATALENGTH(a.userpicture) "&_
        "from vip_user a,vip_cardvip b where a.vipid="&qts(id)&" and a.vipcode*=b.vipcardid"
	ds.Open sql,cn,1,1
     
	if not ds.eof then
    add_province=ds("add_province")
    noeyearsums=ds("noeyearsums")
    noeyearcnt=ds("noeyearcnt")
    qq=ds("qq")
    weibo=ds("weibo")
    liketalktype=ds("liketalktype")
	vipid=ds("vipid")
	userpicture=ds("userpicture")
	session("viptmpid")=vipid
	vipname=ds("vipname")
	vipsex=ds("vipsex")
	vipbirth=ds("vipbirth")
	vippassport=ds("vippassport")
	country=ds("country")
	people=ds("people")
	stature=ds("stature")
	waistline=ds("waistline")
	city=ds("city")
	vipemail=ds("vipemail")
	viptel=ds("viptel")
	vipadd=ds("vipadd")
	vippostalcode=ds("vippostalcode")
	vipoccupation=ds("vipoccupation")
	crname=ds("crname")
	mobtel=ds("mobtel")
	vipup=ds("vipup")
	comment=ds("comment")
	vippay=ds("vippay")
	vippaper=ds("vippaper")
	vipgrab=ds("vipgrab")
  vipstyle=ds("vipstyle")
	
  vipcolor=ds("vipcolor")
	
  vipbrand1=ds("vipbrand1")
  vipbrand2=ds("vipbrand2")
  vipbrand3=ds("vipbrand3")
	
  vipsize=ds("vipsize")
  vipsize1=ds("vipsize1")
  city=ds("city")
  vipapply=ds("vipapply")
  viplove=ds("viplove")
  vipmax=ds("vipmax")
  vipmin=ds("vipmin")
  vipplace=ds("vipplace")
  tjname=ds("tj_name")
  tjId=ds("tj_Id")
  tzname=ds("tz_name")
  fbuyid=ds("fbuyid")
  fbuydate=ds("fbuydate")
  fbuysums=ds("fbuysums")
  fremark=ds("fremark")
  viptypeid=ds("viptypeid")
  vipcode=ds("vipcode")
  zcentum=ds("zcentum")
  zsums=ds("zsums")
  schools=ds("schools")
  parents=ds("parents")
  relation=ds("relation")
  add_city=ds("add_city")
  add_region=ds("add_region")
  age=ds("age")
  getmag = ds("getmag")
  AgeRange = ds("AgeRange")
  Children = ds("Children")
  YearSums = ds("YearSums")
  YearNums = ds("YearNums")
  StyleDemand1 = ds("StyleDemand1")
  StyleDemand2 = ds("StyleDemand2")
  OccasionDemand1 = ds("OccasionDemand1")
  OccasionDemand2 = ds("OccasionDemand2")
  Hobby1 = ds("Hobby1")
  Hobby2 = ds("Hobby2")
  Hobby3 = ds("Hobby3")
  ChildrenHave = ds("ChildrenHave")
  if ChildrenHave = "��" then
    Cselect1 = "selected"
    Cselect2 = ""
    Cselect3 = ""
  elseif ChildrenHave = "��" then
    Cselect1 = ""
    Cselect2 = "selected"
    Cselect3 = ""
  else
    Cselect1 = ""
    Cselect2 = ""
    Cselect3 = "selected"  
  end if
  ChildrenSex = ds("ChildrenSex")
  if ChildrenSex = "�к�" then
    Sselect1 = "selected"
    Sselect2 = ""
    Sselect3 = ""
  elseif ChildrenSex = "Ů��" then
    Sselect1 = ""
    Sselect2 = "selected"
    Sselect3 = ""
  else
    Sselect1 = ""
    Sselect2 = ""
    Sselect3 = "selected"  
  end if
  Ayina = ds("Ayina")
  ToStoreTime1 = ds("ToStoreTime1")
  ToStoreTime2 = ds("ToStoreTime2")
  Body = ds("Body")
  Fabric = ds("Fabric")
  Fabric1 = ds("Fabric1")
  WeiXin = ds("WeiXin")
  if ds("FollowWeiXin") = true then
    FollowWeiXin = "��"
    Fselect1 = "selected"
    Fselect2 = ""
  else
    FollowWeiXin = "��"
    Fselect1 = ""
    Fselect2 = "selected"
  end if
  InforChannel = ds("InforChannel")
  ShoppingType = ds("ShoppingType")
  FavouritesBook = ds("FavouritesBook")
  FavouritesMoive = ds("FavouritesMoive")
  FavouritesColour = ds("FavouritesColour")
  FavouritesColour1 = ds("FavouritesColour1")
  Fabric1 = ds("Fabric1")
  islunar = ds("islunar")
  family = ds("family")
  remarkFamily = ds("remarkFamily")
  loveFruit = ds("loveFruit")
  remarkFruit = ds("remarkFruit")
  role = ds("role")
  MemorialDay1 = ds("MemorialDay1")
  MemorialDay2 = ds("MemorialDay2")
  remarkMemorial = ds("remarkMemorial")
  firstDisc = ds("firstDisc")
  profession = ds("profession")
  Position = ds("Position")
  Constellation = ds("Constellation")
  MarkActivitie1 = ds("MarkActivitie1")
  MarkActivitie2 = ds("MarkActivitie2")
  ShoppingHabits = ds("ShoppingHabits")
  Vehicle = ds("Vehicle")
  RemarkVehicle = ds("RemarkVehicle")
  Taboo = ds("Taboo")
  isReceipt = ds("isReceipt")
  ReceiptName = ds("ReceiptName")
  Scarf = ds("Scarf")


  HopeGift = ds("HopeGift")
  FavouritesActivties = ds("FavouritesActivties")

	end if
	ds.close
  end if
end select

set ds=nothing

sub get_rs(lookupid,oldvalue)
 dim notother
 notother = false
 rs.source="select lookname from j18_lookupsub where lookupid='"&lookupid&"' order by lookcode"
 rs.open
do while not rs.eof
response.write"<option value="&rs(0)
if rs(0)=oldvalue then 
    notother = true
    response.Write" selected " 
end if
if (not notother) and (rs(0) = "����") and (oldvalue <> "") then
    response.Write" selected "
end if    
response.write">"
response.write rs(0)
response.write"</option>"
rs.movenext
loop
rs.close
end sub

sub get_agerange(oldvalue)
 notother = false
 rs.source="select lookname, comment from j18_lookupsub where lookupid='3013' order by lookcode"
 rs.open
do while not rs.eof
response.write"<option value="&rs(0)&" id="&rs(1)
if rs(0)=oldvalue then 
    response.Write" selected " 
end if   
response.write">"
response.write rs(0)
response.write"</option>"
rs.movenext
loop
rs.close
end sub

sub getprovince()
    rs.source=" select id,replace(name,' ','') name from J_ChinaArea where parentid=0 order by sequence "
     rs.open
    response.write("<option value=''></option>")
    do while not rs.eof
    response.write"<option pid="&rs("id")&" value="&rs("name")  
    if rs("name")=add_province then response.Write" selected " end if
    response.write">"
    response.write rs("name")
    response.write"</option>"
    rs.movenext
    loop
    rs.close
end sub

sub get_viptype(typeid)
 rs.source="select viptypeid,viptypename from vip_typevip "&_
 		" where viptypeid in(select viptypeid from sys_viptypepower18ql where userid='"&userid&"' and isnull(p_sure,0)=1)"
 rs.open
response.write("<option value=''></option>")
do while not rs.eof
response.write"<option value="&rs(0)
if rs(0)=typeid then response.Write" selected " end if
response.write">"
response.write rs(1)
response.write"</option>"
rs.movenext
loop
rs.close
end sub

sub getsize(oldvalue)
 rs.source="select sizeid from j_size order by s_order"
 rs.open
do while not rs.eof
response.write"<option value="&rs(0)
if rs(0)=oldvalue then response.Write" selected " end if
response.write">"
response.write rs(0)
response.write"</option>"
rs.movenext
loop
rs.close
end sub

sub get_tz(tzid)
 rs.source="select a.employeeid,'['+employeeid+']'+a.names,a.names from j_employee a,jk_group b "&_
 		" where isnull(a.valid,0)=0 and a.groupid=b.groupid and a.depotid="&qts(depotid)
 rs.open
response.write("<option value='��ѡ��'>��ѡ��</option>")
do while not rs.eof
response.write"<option value="&rs(0)
if rs(2)=tzid then response.Write" selected " end if
response.write">"
response.write rs(1)
response.write"</option>"
rs.movenext
loop
rs.close
end sub
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>���VIP����</title>
    <link href="css/f22.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../../../scripts/jquery-1.2.6.min.js"></script>
        <script type="text/javascript" src="../../../jquery/jquery.alphanumeric.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#bmonth,#bday").change(function () {
                var month = $("#bmonth").val();
                var day = $("#bday").val();
                if (month == "" || day == "") return;
                if (parseInt(month) < 10) month = "0" + month;
                if (parseInt(day) < 10) day = "0" + day;

                var d = month + "-" + day;

                if (d >= "01-20" && d <= "02-18")
                    $("#Constellation").val("ˮƿ��");
                else if (d >= "02-19" && d <= "03-20")
                    $("#Constellation").val("˫����");
                else if (d >= "03-21" && d <= "04-20")
                    $("#Constellation").val("������");
                else if (d >= "04-21" && d <= "05-20")
                    $("#Constellation").val("��ţ��");
                else if (d >= "05-21" && d <= "06-21")
                    $("#Constellation").val("˫����");
                else if (d >= "06-22" && d <= "07-22")
                    $("#Constellation").val("��з��");
                else if (d >= "07-23" && d <= "08-22")
                    $("#Constellation").val("ʨ����");
                else if (d >= "08-23" && d <= "09-22")
                    $("#Constellation").val("��Ů��");
                else if (d >= "09-23" && d <= "10-22")
                    $("#Constellation").val("�����");
                else if (d >= "10-23" && d <= "11-21")
                    $("#Constellation").val("��Ы��");
                else if (d >= "11-22" && d <= "12-21")
                    $("#Constellation").val("������");
                else if (d >= "12-22" && d <= "01-19")
                    $("#Constellation").val("ħ����");
                else
                    $("#Constellation").val("");
            });


            $(".2030").numeric({ allow: "-" });
            $(".3013,.1002").numeric();
            $(".2006").blur(function () {
                var strm = $(this).val();   //�ύmail��ַ���ı���
                var regm = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/; //��֤Mail��������ʽ,^[a-zA-Z0-9_-]:��ͷ����Ϊ��ĸ,�»���,����,
                if (!strm.match(regm) && strm != "") {
                    alert("�����ַ��ʽ����");
                    $(this).val("");
                    $(this).focus();
                }
            });
            $(".3013").blur(function () {
                if (isNaN($(this).val())) {
                    alert("QQ���������!");
                    $(this).val('');
                    $(this).focus();
                }
            });
        });

        function selectchange(val) {
            var sval = document.getElementById(val).value;
            if (sval == "����") {
                document.getElementById(val + "other").style.visibility = "";  
            }
            else {
                document.getElementById(val + "other").style.visibility = "hidden";
            }
        }
    </script>
    <script type="text/javascript">

<%
dim chkstr
'������
	chkstr="var json = ["
	'sql="select readid,comment,reg,tooltip,length=5 from vip_read where isnull(sure,0)=1"
	sql="select readid,comment,reg,tooltip,length=isnull(b.length,0),sure=isnull(sure,0) from vip_read  a  "&_
		" left join  syscolumns  b on a.columnname=b.name "&_
		" where object_name(id)='vip_user'   order by readid " 
	rs.open sql,cn,1,1
		do while not rs.eof
		reg=rs("reg")
		if isnull(reg) or isempty(reg) or reg="NULL" then reg=""
		if instr(reg,"\") then reg = replace(reg,"\","\\")
			chkstr=chkstr&"{'id':'"&rs("readid")&"','comment':'"&rs("comment")&"','reg':'"&reg&"','tooltip':'"&rs("tooltip")&"','length':'"&rs("length")&"','sure':'"&rs("sure")&"'},"
		rs.movenext
		loop
		chkstr = left(chkstr,(len(chkstr)-1))&"]"
	rs.close
	response.write chkstr

%>

$(function()
{
//    if('<%=id %>' ==''){
//        document.getElementById("form1").reset(); 
//    }

    $("#btnselretail").click(function(){
    var m=showModalDialog("selectRetail.asp",window,"dialogHeight:450px;dialogWidth:500px;center:yes;help:no;resizable:no;status:no");
    if(m!=undefined && m !="" )
    {
        $("#buyid").val(m).blur();
    }
    });



//�ѷ�����ֻ����
		<%if readonly<>"" and vipcode<>"" then %>
			$('<%=readonly%>').each(function(){
				$(this).before($(this).val()).css('display','none')
			})
		<%end if%>
//�������Ժ�ɫ�Ǻ���ʾ
			$(json).each(function(i,o){ 
                if(o.sure =="True"){
				    $('.'+o.id).after(' <span style="color:red">*</span>');
                }
			})
	
    $("#add_province").change(function(){
            $("#add_city").html("");
            $("#add_region").html("");
           var id = $(this).find("option:selected").attr("pid");
           var obj = getjson('vip_area.asp','id='+id);
          $("#add_city").append(obj.msg);
    });
    
        $("#add_city").change(function(){
            $("#add_region").html("");
           var id = $(this).find("option:selected").attr("pid");
           var obj = getjson('vip_area.asp','id='+id);
          $("#add_region").append(obj.msg);
    });


    		
	$("#mobtel").blur(
			  function(){
			    if(this.value.length!=11 || this.value.substr(0,1) != '1'){
			        alert("�ֻ��������!");
			        $(this).val('');
			    }
				$("#chksameText").html('');
				if(($(this).val().length>0)&&($("#mobtel").val().length>0))
				{
						var obj = getjson('vip_chknametel.asp','mobtel='+$(this).val()+'&vipname='+escape($("#vipname").val()))
						if(obj.success=='true'){
							
							$("#chksameText").html('');
	
						}else{
							//$("#chksameText").html('<br />'+obj.msg).css('color','red');
							alert(obj.msg);
							$(this).val('');
                            $('#mobtel').focus();
						}
				}
			});

       $('#mobtel').bind('keydown',function(e){
            var k  = window.event ? e.keyCode : e.which;
            if(k == 13){
            	var obj = getjson('vip_chknametel.asp','mobtel='+$(this).val()+'&vipname='+escape($("#vipname").val()))
				if(obj.success=='true'){							
					$("#chksameText").html('');	
				}else{
                   $("#vipname").focus();
                    return false;
				}          
            }           
            return true
         });

//����ͨ��AJAX��֤
			$("#buyid").blur(
			  function(){
				$("#buydate2").val('');
				$("#buysums2").val('');
				$("#chkretailidText").html('');
				
				if($(this).val().length>0)
				{
						var obj = getjson('vip_chkretailid.asp','fbuyid='+$(this).val())
						if(obj.success=='true'){
							var v = obj.msg.split('|');
							$("#buydate2").val(v[0]);
							$("#buysums2").val(v[1]);
							$("#firstDisc").val(v[2]);
							$("#chkretailidText").html('');
	
						}else{
							$("#chkretailidText").html('<br />'+obj.msg).css('color','red');
							$(this).val('')
						}
				}
			});
//���ύ�¼�
			$("form").submit(function()
			{
				var rt = true;
					$(json).each(function(i,o)
						{
								$('.'+o.id).each(function(){
										if($(this).css('display')!='none')
										{
										    if ((o.length>0)&&($(this).val().length>o.length))
											{
											   alert(o.comment+"���ܳ���"+o.length+"�ַ�!(ע:1�������ִ���2���ַ�)");
												rt = false;
											}
											
											if($(this).val()=='' && o.sure=="True")
											{
													alert(o.comment+"����Ϊ��!");
													rt = false;
											}else if(o.reg != "" && $(this).val()!=''){
													if(!$(this).val().match(o.reg))
													{
													alert(o.tooltip);
													rt = false;
													}
											}
										}
								})
								
								if(!rt) {
										$(this).eq(0).focus();
										rt = false;
										return false;
								}

								
							
						});
				return rt;
			})

});


//����AJAX����JSON����
function getjson(url,data)
{
		var html = $.ajax({
		url: url,
		type: "POST",
		data: data,
		async: false
		}).responseText;
		return eval('('+html+')');
}

function oncs(){
  var t=document.form1.tzid;
  var id='['+t.options[t.options.selectedIndex].value+']';
  var name=t.options[t.options.selectedIndex].text.replace(id,"");
  if(name!="��ѡ��")
  {
     document.form1.tzname.value=name;
  }
  else
  {
     document.form1.tzname.value="";
  }
}

function selectVIP()
{
    var m=showModalDialog("../../../b28web/modal/input_vipcard.aspx?act=tjr",window,"dialogHeight:450px;dialogWidth:800px;center:yes;help:no;resizable:no;status:no");
    if(m!=undefined&&m!="")
    {
        var tjname=m.split('_')[2];
        var tjId=m.split('_')[3];
        $("#tjname").val(tjname);
        $("#tjId").val(tjId);
    }
}

function changeage(t){
    var ageyear = t.value;
    if (ageyear == "") {
        document.getElementById("AgeRange").selectedIndex = 0;
        return;
    }

    var date = new Date();
    var age = date.getYear() - ageyear;

    var ops = document.getElementById("AgeRange").options;
    if (ops.length > 0)
    {
        for (var i = 0; i < ops.length; i++) {
            var strs = new Array();
            strs = ops[i].id.split(","); 
            if (strs.length == 2 && age >= strs[0] && age <= strs[1]) {
                document.getElementById("AgeRange").selectedIndex = i;
                break;    
            }
        }   
    }

}
    </script>
    <style type="text/css">
        #add_city
        {
            width: 95px;
        }
        #add_region
        {
            width: 90px;
        }
    </style>
</head>
<body>
    <table width="100%" border="0" class="bar">
        <tr>
            <td align="center">
                VIP��Ա���ϵǼ�
            </td>
        </tr>
    </table>
    <form name="form1" method="post" action="vip_save.asp">
    <input name="act" type="hidden" id="act" value="<%=act%>" />
    <table width="100%" border="0" cellpadding="3" cellspacing="1" class="f12 Fbox">
        <tr>
            <td width="100" align="right">
                �������ͣ�
            </td>
            <td width="210">
                <select name="typeid" id="typeid" class="2011">
                    <% get_viptype viptypeid%>
                </select>
            </td>
            <td width="220" rowspan="6" align="center">
                <img id="vippic" src='<%if vipid<>"" and userpicture<>"" then response.Write("vip_showimg.asp?vipid="&vipid) else response.Write("..\..\..\b28web\AJAX\Vip\nopic.gif") end if %>'
                    border="0" width="100"><br />
                  <span style=" color:Red;">��С���ܳ���200k,ͼƬ100x135���</span> 
            </td>
            <td align="right">
                ���򵥺ţ�
            </td>
            <td>
                <input name="buyid" type="text" id="buyid" value="<%=fbuyid%>" size="25" class="2012"
                    onkeydown="if(event.keyCode==13){event.keyCode=9}" />
                <span id="chkretailidText"></span>
                <input type="button" value="ѡ��" id="btnselretail" />
            </td>
        </tr>
        <tr>
            <td align="right">
                �Ƽ��ˣ�
            </td>
            <td>
                <input name="tjname" type="text" id="tjname" readonly value="<%=tjname%>" size="20" maxlength="30" style="width:120px"
                    class="2013" />
                    <input type="button" value="ѡ��" onClick="selectVIP()" />
                    <input name="tjId" id="tjId" type="hidden" value="<%=tjId %>" />
                    </td>
            <td align="right">
                �������ڣ�
            </td>
            <td>
                <input name="buydate2" id="buydate2" type="text" value="<%=fbuydate%>" size="10"
                    readonly style="background-color: #cccccc">
                �����<input name="buysums2" id="buysums2" type="text" value="<%=fbuysums%>" size="8"
                    readonly style="background-color: #cccccc">
            </td>
        </tr>
        <tr>
            <td align="right">
                �ͻ�����
            </td>
            <td>
                <select name="tzid" id="tzid" style="width:150px; " tabindex="-1" onChange="oncs();" >
                <% get_tz tzname%>
                </select>
                <input name="tzname" type="hidden" id="tzname" size="30"
                maxlength="30" value="<%=tzname%>" class="3007" >
            </td>
            <td align="right" nowrap>
                �׵�ʵ���ۿۣ�</td>
            <td>
             <input name="firstDisc" type="text" id="firstDisc" readonly style="background-color: #cccccc"
                value="<%=firstDisc%>" class="" >
               </td>
        </tr>
        <tr>
            <td align="right">
                �˿�������
            </td>
            <td>
                <input name="vipname" type="text" id="vipname" value="<%=vipname%>" size="20" class="1001"></td>
            <td align="right" nowrap>
                ��ҵ��</td>
            <td>
                 <select name="profession" id="profession" class="3052">
                    <option></option>
                    <%get_rs 3039,profession%>
                </select>
                
                </td>
        </tr>
        <tr>
            <td align="right">
                �Ա�
            </td>
            <td>
                <input name="vipsex" id="vipsex1" type="radio" value="��" 
                    <%if vipsex="��" or (vipsex="" and session("cf_VipSet_dsex") =1) then response.write "checked" end if%> 
                    checked="true">
                ��</label>
                <label for="vipsex2">
                    <input name="vipsex" id="vipsex2" type="radio" value="Ů" <%if vipsex="Ů" or (vipsex="" and session("cf_VipSet_dsex") =2) then response.write "checked" end if%>>
                    Ů</label>
            </td>
            <td align="right">
                ְλ��</td>
            <td>
              <select name="Position" id="Position" class="3053">
                    <option></option>
                    <%get_rs 3040,Position%>
                </select>
                
            </td>
        <tr>
            <td align="right">
                �̶��绰��
            </td>
            <td>
                <input name="viptel" type="text" id="viptel" value="<%=viptel%>" size="15" maxlength="15"
                    class="2030" ></td>
            <td align="right">
                ������</td>
            <td>
                  <select name="Constellation" id="Constellation" class="3054">
                    <option></option>
                    <%get_rs 3041,Constellation%>
                </select>
             </td>
        </tr>
        <tr>
            <td align="right">
                &nbsp;�ƶ��绰��
            </td>
            <td>
                <input name="mobtel" type="text" id="mobtel" value="<%=mobtel%>" size="13" maxlength="11"
                    class="1002"></td>
            <td width="220" valign="bottom">
                <iframe class="TBGen" style="top: 8px" id="UploadFiles" src="vip_Imgupload.asp" frameborder="0"
                    scrolling="no" width="240" height="30"></iframe>
            </td>

            <td align="right">
               ��Ʊ̧ͷ��
                </td>
            <td>
                <input type="text" name="ReceiptName" id="ReceiptName" value="<%=ReceiptName %>" class="3061" />
                <input  type="checkbox" id="isReceipt" name="isReceipt"  <% if isReceipt="True" then response.write("checked") end if   %>  /><label for="isReceipt">�Ƿ񾭳�����Ʊ</label> 
            </td>
        </tr>

        <tr>
            <td align="right">
                �������ڣ�
            </td>
            <td colspan="2">
                <select name="byear" id="byear" class="2005" onChange="changeage(this);">
                    <option></option>
                    <%
		dim styear,edyear
		if session("cf_VipBirthdayBeg")<>"" and session("cf_VipBirthdayEnd")<>"" then 
			styear = year(date)-cdbl(session("cf_VipBirthdayEnd"))
			edyear = year(date)-cdbl(session("cf_VipBirthdayBeg"))
		else
			styear = 1950
			edyear = year(date)
		end if
		for i=styear to edyear%>
                    <option value="<%=i%>" <%if year(vipbirth)=i and vipbirth<>"" then response.write "selected" end if%>>
                        <%=i%>|<%=year(date)-i%></option>
                    <%next%>
                </select>
                ��
                <select name="bmonth" id="bmonth" class="2005">
                    <option></option>
                    <%for i=1 to 12%>
                    <option value="<%=i%>" <%if month(vipbirth)=i and vipbirth<>"" then response.write "selected" end if%>>
                        <%=i%></option>
                    <%next%>
                </select>
                ��
                <select name="bday" id="bday" class="2005">
                    <option></option>
                    <%for i=1 to 31%>
                    <option value="<%=i%>" <%if day(vipbirth)=i and vipbirth<>"" then response.write "selected" end if%>>
                        <%=i%></option>
                    <%next%>
                </select>
                ��
                &nbsp;&nbsp;

                <label><input type="checkbox" id="islunar" name="islunar" <% if islunar="True" then response.write("checked") end if  %> />ũ������</label>&nbsp;
                 &nbsp;
            </td>

            <td align="right">
                ���ϳɷ�ϲ�ã� 
            </td>
            <td>
                <select name="Fabric" id="Fabric" class="3032">
                    <option></option>
                    <% get_rs 3027,Fabric%>
                </select>
                 <select name="Fabric1" id="Fabric1" class="3043" >
                    <option></option>
                    <% get_rs 3027,Fabric1%>
                </select>            </td>
        </tr>

        <tr>
            <td align="right">
                �������䣺</td>
            <td>
                <select name="AgeRange" id="AgeRange" class="3017">
                    <option></option>
                    <% get_agerange AgeRange%>
                </select></td>

            <td align="right">&nbsp;
                </td>
            <td align="right">
            �Ƿ�ϲ����Χ��
            <td>
              <select name="Scarf" id="Scarf" >
                <option value="��" <% if Scarf="��" then response.write("selected") end if   %> >��</option>
                <option value="��" <% if Scarf="��" then response.write("selected") end if   %>>��</option>
              </select>
               </td>
       </tr>

        <tr>
            <td align="right">
                ɫ��ϲ�ã�
            </td>
            <td colspan="2">
                <select name="FavouritesColour" id="FavouritesColour" class="3039">
                    <option></option>
                    <% get_rs 3032,FavouritesColour%>
                </select>

                <select name="FavouritesColour1" id="FavouritesColour1" class="3042">
                    <option></option>
                    <% get_rs 3032,FavouritesColour1%>
                </select>
            </td>

            <td align="right">
                �������
            </td>
            <td>
                <select name="StyleDemand1" id="StyleDemand1" class="3018">
                    <option></option>
                    <% get_rs 3015,StyleDemand1%>
                </select>
                 &nbsp;<select name="StyleDemand2" id="StyleDemand2" class="3019">
                    <option></option>
                    <% get_rs 3016,StyleDemand2%>
                </select>
             </td>

        </tr>
	   
	   
	   
	   
        <tr>
            <td align="right">
                ��ϸ��ַ��
            </td>
            <td colspan="4">
                   <select name="add_province" id="add_province"   class="3016">
                        <% getprovince()  %>
                    </select>

                    <select name="add_city" id="add_city"   class="3016" >
                        <option value="<%=add_city %>"><%=add_city %></option>
                    </select>

                    <select name="add_region" id="add_region"   class="3016" >
                        <option value="<%=add_region %>"><%=add_region %></option>
                    </select>
                    
                    <input name="vipadd" type="text" id="vipadd" value="<%=vipadd%>" size="40" maxlength="100"
                    class="2007"></td>
               
  
        </tr>
             <tr>
            <td align="right">
                ��ͥ���ɣ�
            </td>
            <td colspan="2">
                <select name="family" id="family" onChange="selectchange('family');" class="3044"  >
                    <option></option>
                    <% get_rs 3035,family%>
                </select>
               
               <input type="text" id="remarkFamily" name="remarkFamily" value="<%=remarkFamily %>" class="3045" />
            </td>

            <td align="right">
                ���е�Ӫ������ͣ�
            </td>
            <td>
              <select name="MarkActivitie1" id="MarkActivitie1" onChange="selectchange('MarkActivitie1');"  class="3055" >
                    <option></option>
                    <% get_rs 3042,MarkActivitie1%>
                </select>
                 <select name="MarkActivitie2" id="MarkActivitie2" onChange="selectchange('MarkActivitie2');" class="3056"  >
                    <option></option>
                    <% get_rs 3042,MarkActivitie2%>
                </select>
            </td>

        </tr>

        <tr>

            <td align="right">
                ����������
            </td>
            <td>
                <select name="ShoppingType" id="ShoppingType" onChange="selectchange('ShoppingType');" class="3036">
                    <option></option>
                    <% get_rs 3029,ShoppingType%>
                </select>
                &nbsp;<input name="ShoppingTypeother" type="text" id="ShoppingTypeother" value="<%=ShoppingType%>" size="15"
                    maxlength="50" style="visibility:hidden"/>
            </td>

            </td>
            <td align="right">
                ����ϰ�ߣ�</td>
            <td>
                  <select name="ShoppingHabits" id="ShoppingHabits" onChange="selectchange('ShoppingHabits');" class="3057">
                    <option></option>
                    <% get_rs 3043,ShoppingHabits%>
                </select>
                </td>
        </tr>

        <tr>
			<td align="right">���ﳡ����</td>
			<td>
			<select name="vipplace" id="vipplace" class="2027">
			<option></option>
			<% get_rs 3011,vipplace%>
			</select>      
			</td>

            <td align="right">
                ���˰��ã�</td>
            <td>
                 &nbsp;<select name="viplove" id="viplove" class="2022">
                    <option></option>
                    <% get_rs 3009,viplove%>
                </select>
                &nbsp;
               <select name="Hobby1" id="Hobby1" class="3022">
                    <option></option>
                    <% get_rs 3019,Hobby1%>
                </select>
                &nbsp;<select name="Hobby2" id="Hobby2" class="3023">
                    <option></option>
                    <% get_rs 3020,Hobby2%>
                </select>
                &nbsp;<select name="Hobby3" id="Hobby3" class="3024">
                    <option></option>
                    <% get_rs 3021,Hobby3%>
                </select>
                &nbsp;
            </td>
        </tr>
		
        <tr>
           <td align="right">
                ��ϲ����ͨ�ķ�ʽ��
            </td>
            <td colspan="2">
                <select name="liketalktype" id="liketalktype" class="3027">
                    <option></option>
                    <% get_rs 3012,liketalktype%>
                </select>
            </td>

            <td align="right">
                ���õ��귽ʽ��</td>
            <td>
               <select name="Vehicle" id="Vehicle" class="3058">
                    <option></option>
                    <% get_rs 3044,Vehicle%>
                </select>
                <input type="text" name="RemarkVehicle" id="RemarkVehicle" value="<%=RemarkVehicle %>" class="3059"  />
             </td>
        </tr>

        <tr>
           <td align="right">
                ϲ���ԵĶ�����
            </td>
            <td colspan="2">
                <select name="loveFruit" id="loveFruit" class="3046">
                    <option></option>
                    <% get_rs 3036,loveFruit%>
                </select>
             <input type="text" id="remarkFruit" name="remarkFruit" value="<%=remarkFruit %>" class="3047" />
            </td>
            <td align="right">
                ��������
            </td>
            <td colspan="2">
                <select name="OccasionDemand1" id="OccasionDemand1" class="3020">
                    <option></option>
                    <% get_rs 3017,OccasionDemand1%>
                </select>
                 &nbsp;<select name="OccasionDemand2" id="OccasionDemand2" class="3021">
                    <option></option>
                    <% get_rs 3018,OccasionDemand2%>
                </select>
             </td>
        </tr>

        <tr>
           <td align="right">
                ������Ȧ�еĽ�ɫ��
            </td>
            <td colspan="2">
                <select name="role" id="role" class="3048">
                    <option></option>
                    <% get_rs 3037,role%>
                </select>
            
            </td>
            <td align="right">
                ��ȡ��Ϣ��������
            </td>
            <td>
                <select name="InforChannel" id="InforChannel" onChange="selectchange('InforChannel');" class="3035">
                    <option></option>
                    <% get_rs 3028,InforChannel%>
                </select>
                &nbsp;<input name="InforChannelother" type="text" id="InforChannelother" value="<%=InforChannel%>" size="15"
                    maxlength="50" style="visibility:hidden" />
             </td>
        </tr>

        <tr>
           <td align="right">
                ���ں������ӣ�
            </td>
            <td colspan="2">
                <select name="MemorialDay1" id="MemorialDay1" class="3049">
                    <option></option>
                    <% get_rs 3038,MemorialDay1%>
                </select>
                <select name="MemorialDay2" id="MemorialDay2" class="3050">
                    <option></option>
                    <% get_rs 3038,MemorialDay2%>
                </select>
             <input type="text" id="remarkMemorial" name="remarkMemorial" value="<%=remarkMemorial %>" class="3051" />
            </td>

            <td align="right">
                �˿͵ļɻ䣺</td>
            <td>
                <input type="text" id="Taboo" name="Taboo" value="<%=Taboo %>" class="3060" />
            </td>

        </tr>

        <tr <%if session("cf_VipSet_gjxx")=false then response.write "style='display:none;'"%>>
            <td align="right">
                ��ע��            </td>
            <td colspan="2">
                <input name="comment" type="text" id="comment" value="<%=comment%>" size="40" maxlength="50"
                    class="2010"><input type="checkbox" <% if getmag  then response.write "checked" end if %> name="getmag" id="getmag" /><label for="getmag">ͬ���������</label>            </td>
            <td align="right">&nbsp;                </td>
            <td>&nbsp;                </td>
        </tr>



        <tr>
            <td align="right">
                VIP���ţ�
            </td>
            <td>
                <% if  session("pos_vipshow")=true then response.Write("*****") else response.Write(vipcode) end if%>
            </td>
            <td colspan="3">
                �ܻ��֣�
                <%=zcentum%>&nbsp;&nbsp;&nbsp;�ܴ�ֵ��
                <%=zsums%>
            </td>
        </tr>
         <tr>
            <td align="right" >
                һ�������ѽ�
            </td>
            <td><%=noeyearsums %></td>
            <td colspan="3">
                 һ�������Ѵ�����<%=noeyearcnt %>
            </td>
        </tr>
        <tr>
            <td align="right" >
                ��������ѽ�
            </td>
            <td><%=YearSums %></td>
            <td colspan="3">
                ��������Ѵ�����<%=YearNums %>
            </td>
        </tr>

    </table>
    <%if id="" then%>
    <table width="100%" border="0" cellpadding="3" cellspacing="1" class="f12 Fbox">
        <tr>
            <td align="center" colspan="2">
                ������ �� �� �ϣ���</font>
            </td>
        </tr>
        <%fs.source = "select lookname from j18_lookupsub where lookupid='3501' order by lookcode" 
		 fs.open 
		 if not fs.eof then
		 i=1
		   while not fs.eof%>
        <tr>
            <td align="right">
                <font size="2">
                    <%=fs("lookname")%>��</font>
            </td>
            <td>
                <input type="text" name="vip_p<%=i%>" size="35" class="editbox1" onKeyDown="if(event.keyCode==13)event.keyCode=9">
                <input type="hidden" name="vip_p<%=i%>_name" value="<%=fs("lookname")%>">
            </td>
        </tr>
        <%fs.movenext
		i=i+1
		wend
		response.write("<input type=hidden name=vip_pnum value="&i-1&">")
		else%>
        <tr>
            <td align="center" colspan="2">
                <font size="2">�� �� �� �� ��</font>
            </td>
        </tr>
        <%end if
		fs.close%>
    </table>
    <%else%>
    <table width="100%" border="0" cellpadding="3" cellspacing="1" class="f12 Fbox">
        <tr>
            <td align="center" colspan="2">
                ������ �� �� �ϣ���</font>
            </td>
        </tr>
        <%fs.source = "select lookname from j18_lookupsub where lookupid='3501' order by lookcode"
		  fs.open
		 if not fs.eof then
		 i=1
		   while not fs.eof
		     found=false
		     fs1.source = "select p_name,p_value from vip_usersub where vipid='"&id&"'"
			 fs1.open
			 while not fs1.eof
		  if fs1("p_name")=fs("lookname") then
		     found=true%>
        <tr>
            <td align="right">
                <font size="2">
                    <%=fs1("p_name")%>��</font>
            </td>
            <td>
                <input type="text" name="vip_p<%=i%>" size="35" value="<%=fs1("p_value")%>" class="editbox1"
                    onkeydown="if(event.keyCode==13)event.keyCode=9">
                <input type="hidden" name="vip_p<%=i%>_name" value="<%=fs1("p_name")%>">
            </td>
        </tr>
        <%end if
		  fs1.movenext
		  wend
		  fs1.close
		  if not found then%>
        <tr>
            <td align="right">
                <font size="2">
                    <%=fs("lookname")%>��</font>
            </td>
            <td>
                <input type="text" name="vip_p<%=i%>" size="35" class="editbox1" onKeyDown="if(event.keyCode==13)event.keyCode=9">
                <input type="hidden" name="vip_p<%=i%>_name" value="<%=fs("lookname")%>">
            </td>
        </tr>
        <%end if
		  fs.movenext
		  i=i+1
		  wend
		response.write("<input type=hidden name=vip_pnum value="&i-1&">")
		else%>
        <tr>
            <td align="center" colspan="2">
                <div align="center">
                    <font size="2">�� �� �� �� ��</font></div>
            </td>
        </tr>
        <%end if
		fs.close%>
    </table>
    <%end if%>
    <table width="100%" border="1" cellpadding="0" cellspacing="1" bordercolor="#F0DEDA"
        class="f12">
        <input type="hidden" value="<%=qts(id)%>" name="vipid">
        <%if act="add" or act="edit" then%>
        <tr>
            <td align="center">
                <input type="submit" name="Submit" value="�ύ(S)">
                <input type="reset" name="Submit" value="�� ��">
            </td>
        </tr>
        <%end if%>
    </table>
    </form>

    <script type="text/javascript">
        selectchange('vipoccupation');
        selectchange('vipbrand1');
        selectchange('Ayina');
        selectchange('InforChannel');
        selectchange('ShoppingType');
        selectchange('FavouritesMoive');
        selectchange('HopeGift');
    </script>
</body>
</html>
