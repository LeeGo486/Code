<%dim total(7,1)
total(1,0)="中国经营报"
total(2,0)="招聘网"
total(3,0)="51Job"
total(4,0)="新民晚报"
total(5,0)="新闻晚报"
total(6,0)="南方周末"
total(7,0)="羊城晚报"

total(1,1)=200
total(2,1)=1200
total(3,1)=900
total(4,1)=600
total(5,1)=1222
total(6,1)=413
total(7,1)=800

%><html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
<!--[if !mso]>
<style>
v\:*         { behavior: url(#default#VML) }
o\:*         { behavior: url(#default#VML) }
.shape       { behavior: url(#default#VML) }
</style>
<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title></title>
<style>
TD {	FONT-SIZE: 9pt}
</style></head>
<body topmargin=5 leftmargin=0 scroll=AUTO>
范例一
<%call table4(total,100,40,250,250,50,0,"A")%>
<Br><Br><Br><Br><Br><Br><Br><Br><Br><Br><Br><Br><Br><Br><Br><Br><Br><Br><Br><Br>范例二
<%'call table3(total,300,450,250,250,"A")%>
</body>
</html>

<%
function table4(total,table_x,table_y,all_width,all_height,thickness,cut_no,table_type)
'参数含义(传递的数组，横坐标，纵坐标，图表的宽度，图表的高度,饼图厚度,分离块的序号,图表的类型)
'纯ASP代码生成图表函数4——立体饼图
'作者：龚鸣(Passwordgm) QQ:25968152 MSN:passwordgm@sina.com Email:passwordgm@sina.com
'本人非常愿意和ASP,VML,FLASH的爱好者在HTTP://www.ilisten.cn进行交流和探讨
'非常感谢您使用这个函数，请您使用和转载时保留版权信息，这是对作者工作的最好的尊重。
tb_height=30
pie=3.14159265358979
rotationangle1=55
rotationangle2=-30

dim tb_color(7,2)
tb_color(1,1)="#d1ffd1"
tb_color(2,1)="#ffbbbb"
tb_color(3,1)="#ffe3bb"
tb_color(4,1)="#ff6600"
tb_color(5,1)="#d9d9e5"
tb_color(6,1)="#ffc7ab"
tb_color(7,1)="#ffff00"

tb_color(1,2)="#00ff00"
tb_color(2,2)="#ff0000"
tb_color(3,2)="#ff9900"
tb_color(4,2)="#ffcc09"
tb_color(5,2)="#666699"
tb_color(6,2)="#993300"
tb_color(7,2)="#ffcc00"

total_no=ubound(total,1)
totalpie=0
for i=1 to total_no
	totalpie=totalpie+total(i,1)
next
%><v:group id="_x0000_s1032" style='position:absolute;left:75pt;top:67.5pt;width:187.5pt;height:187.5pt;z-index:1' coordorigin="100,90" coordsize="250,250"><%
PreAngle=0
TempPie=0
dim temp_total
redim temp_total(total_no,7)
temp_total(1,3)=0
K=1
flag1=0
for i=1 to total_no
	TempAngle=pie*2*(total(i,1)/(TotalPie*2)+TempPie)
	x1=table_x+all_width/2+cos(TempAngle)*all_width/2
	y1=table_y+all_height/2-sin(TempAngle)*all_height/2

	TempAngle2=pie*2*(total(i,1)/(TotalPie*2)+TempPie-0.046)
	x2=table_x+all_width/2+cos(TempAngle2)*all_width/2+sin(TempAngle2)*all_height/2*sin(pie*(rotationangle1/180))*0.1
	y2=table_y+all_height/2-sin(TempAngle2)*all_height/2+sin(TempAngle2)*all_height/2*sin(pie*(rotationangle1/180))*0.07

	if TempPie*pie*2<Pie/2 and (TempPie+total(i,1)/TotalPie)*pie*2>=Pie/2 then
		temp_total(1,1)=total(i,1)
		temp_total(1,2)=y1
		temp_total(1,3)=TempPie
		temp_total(1,4)=i
		temp_total(1,5)=x1
		temp_total(1,6)=x2
		temp_total(1,7)=y2
	else
		if TempPie*pie*2<Pie*2*3/4 and (TempPie+total(i,1)/TotalPie)*pie*2>=Pie*2*3/4 then
			temp_total(total_no,1)=total(i,1)
			temp_total(total_no,2)=y1
			temp_total(total_no,3)=TempPie
			temp_total(total_no,4)=i
			temp_total(total_no,5)=x1
			temp_total(total_no,6)=x2
			temp_total(total_no,7)=y2
			flag1=1
		else
			K=K+1
			temp_total(K,1)=total(i,1)
			temp_total(K,2)=y1
			temp_total(K,3)=TempPie
			temp_total(K,4)=i
			temp_total(K,5)=x1
			temp_total(K,6)=x2
			temp_total(K,7)=y2
		end if
	end if
		TempPie=TempPie+total(i,1)/TotalPie
'	if K<total_no then temp_total(K+1,3)=TempPie
next
for i=1 to total_no
	response.write "total"&i&"("&temp_total(i,1)&","&formatnumber(temp_total(i,3),2,-1)&","&temp_total(i,4)&")"&"<br>"
next
'response.end
if total_no>3 then
if flag1=1 then m=total_no-1 else m=total_no
do 
n=0
for i=3 to m
	if temp_total(i-1,2)>temp_total(i,2) then
		for j=1 to 5
			temp=temp_total(i-1,j)
			temp_total(i-1,j)=temp_total(i,j)
			temp_total(i,j)=temp
		next
		n=i
	end if
next
m=n
Loop Until (m<2)
end if

for i=1 to total_no
	if cut_no=temp_total(i,4) then
		x5=table_x+(all_width/2)
'		response.write "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"&x5
		y5=(temp_total(i,7)-table_y-all_height/2)/2
	else
		x5=table_x
		y5=table_y
	end if
	if temp_total(i,1)>=TotalPie/2 then
		response.write "<v:shape id='_x0000_s1025' alt='' style='position:absolute;left:"&x5&"px;top:"&y5&"px;width:"&all_width&"px;height:"&all_height&"px;z-index:1' coordsize='1500,1400' o:spt='100' adj='0,,0' path='m750,700ae750,700,750,700,"&int(23592960*temp_total(i,3))&","&int(23592960*(1/2-temp_total(i,3)))&"xe' fillcolor='"&tb_color(i,2)&"' strokecolor='#FFFFFF'><v:fill color2='"&tb_color(i,2)&"' rotate='t' focus='100%' type='gradient'/><v:stroke joinstyle='round'/><o:extrusion v:ext='view' backdepth='"&thickness&"px' on='t' rotationangle='"&rotationangle1&","&rotationangle2&"'/><v:formulas/><v:path o:connecttype='segments'/></v:shape>"&CHr(13)
		if (temp_total(i,3)+temp_total(i,1)/totalpie)>0.75 then z_index="2" else z_index="1"
		response.write "<v:shape id='_x0000_s1025' alt='' style='position:absolute;left:"&x5&"px;top:"&y5&"px;width:"&all_width&"px;height:"&all_height&"px;z-index:"&z_index&"' coordsize='1500,1400' o:spt='100' adj='0,,0' path='m750,700ae750,700,750,700,"&int(23592960*1/2)&","&int(23592960*(temp_total(i,1)/totalpie-1/2+temp_total(i,3)))&"xe' fillcolor='"&tb_color(i,2)&"' strokecolor='#FFFFFF'><v:fill color2='"&tb_color(i,2)&"' rotate='t' focus='100%' type='gradient'/><v:stroke joinstyle='round'/><o:extrusion v:ext='view' backdepth='"&thickness&"px' on='t' rotationangle='"&rotationangle1&","&rotationangle2&"'/><v:formulas/><v:path o:connecttype='segments'/></v:shape>"&CHr(13)
	else
		response.write "<v:shape id='_x0000_s1025' alt='' style='position:absolute;left:"&x5&"px;top:"&y5&"px;width:"&all_width&"px;height:"&all_height&"px;z-index:1' coordsize='1500,1400' o:spt='100' adj='0,,0' path='m750,700ae750,700,750,700,"&int(23592960*temp_total(i,3))&","&int(23592960*temp_total(i,1)/totalpie)&"xe' fillcolor='"&tb_color(i,1)&"' strokecolor='#FFFFFF'><v:fill color2='"&tb_color(i,2)&"' rotate='t' focus='100%' type='gradient'/><v:stroke joinstyle='round'/><o:extrusion v:ext='view' backdepth='"&thickness&"px' on='t' rotationangle='"&rotationangle1&","&rotationangle2&"'/><v:formulas/><v:path o:connecttype='segments'/></v:shape>"&CHr(13)
	end if
'	PreAngle=PreAngle+total(i,1)/totalpie
'			response.write "<v:rect id=""_x0000_s1027"" style='position:absolute;left:"&temp_total(i,6)&"px;top:"&temp_total(i,7)&"px;width:4px;height:4px; z-index:2' fillcolor=""#111111"" strokecolor=""#111111""/>"&CHR(13)
next
%></v:group><%
'if table_type="A" then
'	response.write "<v:rect id='_x0000_s1025' style='position:absolute;left:"&table_x+all_width+20&"px;top:"&table_y+20&"px;width:100px;height:"&total_no*tb_height+20&"px;z-index:1'/>"
'for i=1 to total_no
'	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+all_width+25&"px;top:"&table_y+30+(i-1)*tb_height&"px;width:60px;height:"&tb_height&"px;z-index:1'>"
'	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='left'>"&total(i,0)&"</td></tr></table></v:textbox></v:shape>"
'	response.write "<v:rect id='_x0000_s1040' alt='' style='position:absolute;left:"&table_x+all_width+80&"px;top:"&table_y+30+(i-1)*tb_height+3&"px;width:30px;height:20px;z-index:1' fillcolor='"&tb_color(i,1)&"'><v:fill color2='"&tb_color(i,2)&"' rotate='t' focus='100%' type='gradient'/></v:rect>"
'显示比例数
'	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+all_width+110&"px;top:"&table_y+30+(i-1)*tb_height&"px;width:60px;height:"&tb_height&"px;z-index:1'>"
'	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='left'>"&formatnumber(total(i,1)*100/totalpie,2,-1)&"%</td></tr></table></v:textbox></v:shape>"
'next
'end if

if table_type="B" then
TempPie=0
for i=1 to total_no
	TempAngle=pie*2*(total(i,1)/(TotalPie*2)+TempPie)
	x1=table_x+all_width/2+cos(TempAngle)*all_width*3/8
	y1=table_y+all_height/2-sin(TempAngle)*all_height*3/8
	x2=table_x+all_width/2+cos(TempAngle)*all_width*3/4
	y2=table_y+all_height/2-sin(TempAngle)*all_height*3/4
	if x2>table_x+all_width/2 then
		x3=x2+20
		x4=x3
	else
		x3=x2-20
		x4=x3-100
	end if
	response.write "<v:oval id='_x0000_s1027' style='position:absolute;left:"&x1-2&"px;top:"&y1-2&"px;width:4px;height:4px; z-index:2' fillcolor='#111111' strokecolor='#111111'/>"&CHR(13)
	response.write "<v:line id='_x0000_s1025' alt='' style='position:absolute;left:0;text-align:left;top:0;z-index:1' from='"&x1&"px,"&y1&"px' to='"&x2&"px,"&y2&"px' coordsize='21600,21600' strokecolor='#111111' strokeweight='1px'></v:line>"
	response.write "<v:line id='_x0000_s1025' alt='' style='position:absolute;left:0;text-align:left;top:0;z-index:1' from='"&x2&"px,"&y2&"px' to='"&x3&"px,"&y2&"px' coordsize='21600,21600' strokecolor='#111111' strokeweight='1px'></v:line>"
	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&x4&"px;top:"&y2-10&"px;width:130px;height:20px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='left'>"&total(i,0)&" "&formatnumber(total(i,1)*100/totalpie,2,-1)&"%</td></tr></table></v:textbox></v:shape>"
	TempPie=TempPie+total(i,1)/TotalPie
next
end if

end function
%>
