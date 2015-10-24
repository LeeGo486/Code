<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%
function table1(total,table_x,table_y,thickness,table_width,all_width,all_height,table_type)
'参数含义(传递的数组，横坐标，纵坐标，柱子的厚度，柱子的宽度，图表的宽度，图表的高度,图表的类型)
'纯ASP代码生成图表函数1——柱状图
'作者：龚鸣(Passwordgm) QQ:25968152 MSN:passwordgm@sina.com Email:passwordgm@sina.com
'本人非常愿意和ASP,VML,FLASH的爱好者在HTTP://www.ilisten.cn进行交流和探讨
'非常感谢您使用这个函数，请您使用和转载时保留版权信息，这是对作者工作的最好的尊重。
dim tb_color(14,2)
tb_color(1,1)="#d1ffd1"
tb_color(2,1)="#ffbbbb"
tb_color(3,1)="#ffe3bb"
tb_color(4,1)="#cff4f3"
tb_color(5,1)="#d9d9e5"
tb_color(6,1)="#ffc7ab"
tb_color(7,1)="#ecffb7"
tb_color(8,1)="#d1ffd1"
tb_color(9,1)="#ffbbbb"
tb_color(10,1)="#ffe3bb"
tb_color(11,1)="#cff4f3"
tb_color(12,1)="#d9d9e5"
tb_color(13,1)="#ffc7ab"
tb_color(14,1)="#ecffb7"

tb_color(1,2)="#00ff00"
tb_color(2,2)="#ff0000"
tb_color(3,2)="#ff9900"
tb_color(4,2)="#33cccc"
tb_color(5,2)="#666699"
tb_color(6,2)="#993300"
tb_color(7,2)="#99cc00"
tb_color(8,2)="#00ff00"
tb_color(9,2)="#ff0000"
tb_color(10,2)="#ff9900"
tb_color(11,2)="#33cccc"
tb_color(12,2)="#666699"
tb_color(13,2)="#993300"
tb_color(14,2)="#99cc00"

line_color="#69f"
left_width=70
length=thickness/2
total_no=ubound(total,1)

temp1=0
temp6=0
for i=1 to total_no
	if temp1<total(i,1) then temp1=total(i,1)
	if temp6>total(i,1) then temp6=total(i,1)
next
'if temp6=1 then
'else'出现值小于0的情况
temp1=int(temp1)
if temp6>=0 then
	temp6=int(temp6)
	if temp6>10 then
		temp2=mid(cstr(temp6),2,1)
		if temp2>4 then 
			temp3=(int(temp6/(10^(len(cstr(temp6))-1)))-1)*10^(len(cstr(temp6))-1)
		else
			temp3=(int(temp6/(10^(len(cstr(temp6))-1)))-0.5)*10^(len(cstr(temp6))-1)
		end if
		temp6=temp3
	else
		temp6=0
	end if
'	if temp6-10<0 then temp6=0 else temp6=temp6-10
else
	temp6=int(0-temp6)
	if temp6>10 then
		temp2=mid(cstr(temp6),2,1)
		if temp2>4 then 
			temp3=(int(temp6/(10^(len(cstr(temp6))-1)))+1)*10^(len(cstr(temp6))-1)
		else
			temp3=(int(temp6/(10^(len(cstr(temp6))-1)))+0.5)*10^(len(cstr(temp6))-1)
		end if
		temp6=0-temp3
	else
		temp6=-10
	end if
end if
if temp1>9 then
	temp2=mid(cstr(temp1),2,1)
	if temp2>4 then 
		temp3=(int(temp1/(10^(len(cstr(temp1))-1)))+1)*10^(len(cstr(temp1))-1)
	else
		temp3=(int(temp1/(10^(len(cstr(temp1))-1)))+0.5)*10^(len(cstr(temp1))-1)
	end if
else
	if temp1>4 then temp3=10 else temp3=5
end if
temp4=temp3
response.write "<v:rect id='_x0000_s1027' alt='' style='position:absolute;left:"&table_x+left_width&"px;top:"&table_y&"px;width:"&all_width&"px;height:"&all_height&"px;z-index:-1' fillcolor='#9cf' stroked='f'><v:fill rotate='t' angle='-45' focus='100%' type='gradient'/></v:rect>"
select case table_type
case "A"
	for i=0 to all_height step all_height/5
		if i<>all_height then response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width+length&"px,"&table_y+all_height-length-i&"px' to='"&table_x+all_width+left_width&"px,"&table_y+all_height-length-i&"px' strokecolor='"&line_color&"'/>"
		if i<>all_height then response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width&"px,"&table_y+all_height-length-i&"px' to='"&table_x+left_width+length&"px,"&table_y+all_height-i&"px' strokecolor='"&line_color&"'/>"
		response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+(left_width-15)&"px,"&table_y+i&"px' to='"&table_x+left_width&"px,"&table_y+i&"px'/>"
		response.write ""
		response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x&"px;top:"&table_y+i&"px;width:"&left_width&"px;height:18px;z-index:1'>"
		response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='right'>"&temp4&"</td></tr></table></v:textbox></v:shape>"
		temp4=temp4-(temp3-temp6)/5
	next
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width+length&"px,"&table_y&"px' to='"&table_x+left_width+length&"px,"&table_y+all_height-length&"px' strokecolor='"&line_color&"'/>"
	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+left_width-50&"px;top:"&table_y-20&"px;width:100px;height:18px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='center'>纵坐标</td></tr></table></v:textbox></v:shape>"
	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+left_width+all_width&"px;top:"&table_y+all_height-9&"px;width:100px;height:18px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='left'>横坐标</td></tr></table></v:textbox></v:shape>"

	line0=(temp3/(temp3-temp6))*all_height
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:2' from='"&table_x+left_width&"px,"&table_y+line0&"px' to='"&table_x+all_width+left_width&"px,"&table_y+line0&"px'></v:line>"
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width&"px,"&table_y+line0-length&"px' to='"&table_x+left_width+length&"px,"&table_y+line0&"px' strokecolor='"&line_color&"'/>"
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width+length&"px,"&table_y+line0-length&"px' to='"&table_x+all_width+left_width&"px,"&table_y+line0-length&"px' strokecolor='"&line_color&"'/>"


'	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+(left_width-15)&"px,"&table_y+line0&"px' to='"&table_x+left_width&"px,"&table_y+line0&"px'/>"
'	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x-15&"px;top:"&table_y+line0-10&"px;width:"&left_width&"px;height:18px;z-index:1'>"
'	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='right'>0</td></tr></table></v:textbox></v:shape>"

	table_space=(all_width-table_width*total_no)/total_no
for i=1 to total_no
	temp_space=table_x+left_width+table_space/2+table_space*(i-1)+table_width*(i-1)
	response.write "<v:rect id='_x0000_s1025' alt='' style='position:absolute;"
	response.write "left:"&temp_space&"px;top:"
	if total(i,1)>0 then
		response.write table_y+line0-(total(i,1)/(temp3-temp6))*all_height
	else
		response.write table_y+line0
	end if
	response.write "px;width:"&table_width&"px;height:"&all_height*(abs(total(i,1))/(temp3-temp6))
	response.write "px;z-index:1' fillcolor='"&tb_color(i,2)&"'>"
	response.write "<v:fill color2='"&tb_color(i,1)&"' rotate='t' type='gradient'/>"
	response.write "<o:extrusion v:ext='view' backdepth='"&thickness&"pt' color='"&tb_color(i,2)&"' on='t'/>"
	response.write "</v:rect>"

	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&temp_space&"px;top:"
	if total(i,1)>0 then
		response.write table_y+line0-(total(i,1)/(temp3-temp6))*all_height-table_width
	else
		response.write table_y+line0-table_width
	end if
	response.write "px;width:"&table_space+15&"px;height:18px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='center'>"&total(i,1)&"</td></tr></table></v:textbox></v:shape>"

	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&temp_space-table_space/2&"px;top:"&table_y+all_height+1&"px;width:"&table_space+table_width&"px;height:18px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='center'>"&total(i,2)&"</td></tr></table></v:textbox></v:shape>"
next

Case "B"
	table_space=(all_height-table_width*total_no)/total_no
	temp4=temp6

	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width&"px,"&table_y+all_height&"px' to='"&table_x+left_width&"px,"&table_y+all_height+15&"px'/>"
	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+left_width-left_width&"px;top:"&table_y+all_height&"px;width:"&left_width&"px;height:18px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='right'>"&temp4&"</td></tr></table></v:textbox></v:shape>"
	temp4=temp6+(temp3-temp6)/5
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width+length&"px,"&table_y+all_height-length&"px' to='"&table_x+left_width+all_width&"px,"&table_y+all_height-length&"px' strokecolor='"&line_color&"'/>"
for i=0 to all_width-1 step all_width/5
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width+i&"px,"&table_y+all_height-length&"px' to='"&table_x+left_width+length+i&"px,"&table_y+all_height&"px' strokecolor='"&line_color&"'/>"
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width+length+i&"px,"&table_y+all_height-length&"px' to='"&table_x+left_width+length+i&"px,"&table_y&"px' strokecolor='"&line_color&"'/>"
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width+i+all_width/5&"px,"&table_y+all_height&"px' to='"&table_x+left_width+i+all_width/5&"px,"&table_y+all_height+15&"px'/>"
	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+left_width+i+all_width/5-left_width&"px;top:"&table_y+all_height&"px;width:"&left_width&"px;height:18px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='right'>"&temp4&"</td></tr></table></v:textbox></v:shape>"
	temp4=temp4+(temp3-temp6)/5
next

for i=1 to total_no
	temp_space=table_space/2+table_space*(i-1)+table_width*(i-1)
	if total(i,1)>=0 then
		response.write "<v:rect id='_x0000_s1025' alt='' style='position:absolute;left:"&table_x+left_width+all_width*abs(temp6)/(temp3-temp6)&"px;top:"&table_y+temp_space&"px;width:"&all_width*temp3/(temp3-temp6)*(total(i,1)/temp3)&"px;height:"&table_width&"px;z-index:1' fillcolor='"&tb_color(i,2)&"'>"
		response.write "<v:fill color2='"&tb_color(i,1)&"' rotate='t' angle='-90' focus='100%' type='gradient'/>"
		response.write "<o:extrusion v:ext='view' backdepth='"&thickness&"pt' color='"&tb_color(i,2)&"' on='t'/>"
		response.write "</v:rect>"
		response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+left_width+all_width*abs(temp6)/(temp3-temp6)+all_width*temp3/(temp3-temp6)*(total(i,1)/temp3)+thickness/2&"px;top:"&table_y+temp_space&"px;width:"&table_space+15&"px;height:18px;z-index:1'>"
		response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='center'>"&total(i,1)&"</td></tr></table></v:textbox></v:shape>"
	else
		response.write "<v:rect id='_x0000_s1025' alt='' style='position:absolute;left:"&table_x+left_width+all_width*abs(temp6)/(temp3-temp6)-all_width*temp3/(temp3-temp6)*abs(total(i,1)/temp3)&"px;top:"&table_y+temp_space&"px;width:"&all_width*temp3/(temp3-temp6)*abs(total(i,1)/temp3)&"px;height:"&table_width&"px;z-index:1' fillcolor='"&tb_color(i,2)&"'>"
		response.write "<v:fill color2='"&tb_color(i,1)&"' rotate='t' angle='-90' focus='100%' type='gradient'/>"
		response.write "<o:extrusion v:ext='view' backdepth='"&thickness&"pt' color='"&tb_color(i,2)&"' on='t'/>"
		response.write "</v:rect>"
		response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+left_width+all_width*abs(temp6)/(temp3-temp6)+thickness/2&"px;top:"&table_y+temp_space-table_space/4&"px;width:"&table_space+30&"px;height:18px;z-index:1'>"
		response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='center'>"&total(i,1)&"</td></tr></table></v:textbox></v:shape>"
	end if

	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x&"px;top:"&table_y+temp_space&"px;width:"&left_width&"px;height:18px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='right'>"&total(i,2)&"</td></tr></table></v:textbox></v:shape>"
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width+all_width*abs(temp6)/(temp3-temp6)&"px,"&table_y&"px' to='"&table_x+left_width+all_width*abs(temp6)/(temp3-temp6)&"px,"&table_y+all_height&"px'></v:line>"
next

case else
end select
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width&"px,"&table_y+all_height&"px' to='"&table_x+all_width+left_width&"px,"&table_y+all_height&"px'><v:stroke endarrow='block'/></v:line>"
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width&"px,"&table_y&"px' to='"&table_x+left_width&"px,"&table_y+all_height&"px'><v:stroke endarrow='block'/></v:line>"
'end if

end function


function table2(total,table_x,table_y,all_width,all_height,line_no)
'参数含义(传递的数组，横坐标，纵坐标，图表的宽度，图表的高度,折线条数)
'纯ASP代码生成图表函数2——折线图
'作者：龚鸣(Passwordgm) QQ:25968152 MSN:passwordgm@sina.com Email:passwordgm@sina.com
'本人非常愿意和ASP,VML,FLASH的爱好者在HTTP://www.ilisten.cn进行交流和探讨
'非常感谢您使用这个函数，请您使用和转载时保留版权信息，这是对作者工作的最好的尊重。

line_color="#69f"
left_width=70
total_no=ubound(total,1)

temp1=0
if total_no>0 then temp6=total(1,1)
for i=1 to total_no
	for j=1 to line_no
		if temp1<total(i,j) then temp1=total(i,j)
		if temp6>total(i,j) then temp6=total(i,j)
	next
next

temp1=int(temp1)
if temp6>0 then
	temp6=int(temp6)
	if temp6>10 then
		temp2=mid(cstr(temp6),2,1)
		if temp2>4 then 
			temp3=(int(temp6/(10^(len(cstr(temp6))-1)))-1)*10^(len(cstr(temp6))-1)
		else
			temp3=(int(temp6/(10^(len(cstr(temp6))-1)))-0.5)*10^(len(cstr(temp6))-1)
		end if
		temp6=temp3
	else
		temp6=0
	end if
'	if temp6-10<0 then temp6=0 else temp6=temp6-10
else
	temp6=int(0-temp6)
	if temp6>10 then
		temp2=mid(cstr(temp6),2,1)
		if temp2>4 then 
			temp3=(int(temp6/(10^(len(cstr(temp6))-1)))+1)*10^(len(cstr(temp6))-1)
		else
			temp3=(int(temp6/(10^(len(cstr(temp6))-1)))+0.5)*10^(len(cstr(temp6))-1)
		end if
		temp6=0-temp3
	else
		temp6=-10
	end if
end if
if temp1>9 then
	temp2=mid(cstr(temp1),2,1)
	if temp2>4 then 
		temp3=(int(temp1/(10^(len(cstr(temp1))-1)))+1)*10^(len(cstr(temp1))-1)
	else
		temp3=(int(temp1/(10^(len(cstr(temp1))-1)))+0.5)*10^(len(cstr(temp1))-1)
	end if
else
	if temp1>4 then temp3=10 else temp3=5
end if
temp4=temp3
response.write "<v:rect id='_x0000_s1027' alt='' style='position:absolute;left:"&table_x+left_width&"px;top:"&table_y&"px;width:"&all_width&"px;height:"&all_height&"px;z-index:-1' fillcolor='#9cf' stroked='f'><v:fill rotate='t' angle='-45' focus='100%' type='gradient'/></v:rect>"
for i=0 to all_height step all_height/5
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width+length&"px,"&table_y+all_height-length-i&"px' to='"&table_x+all_width+left_width&"px,"&table_y+all_height-length-i&"px' strokecolor='"&line_color&"'/>"
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+(left_width-15)&"px,"&table_y+i&"px' to='"&table_x+left_width&"px,"&table_y+i&"px'/>"
	response.write ""
	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x&"px;top:"&table_y+i&"px;width:"&left_width&"px;height:18px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='right'>"&temp4&"</td></tr></table></v:textbox></v:shape>"
	temp4=temp4-(temp3-temp6)/5
next
response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width&"px,"&table_y+all_height&"px' to='"&table_x+all_width+left_width&"px,"&table_y+all_height&"px'><v:stroke endarrow='block'/></v:line>"
response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width&"px,"&table_y&"px' to='"&table_x+left_width&"px,"&table_y+all_height&"px'><v:stroke endarrow='block'/></v:line>"
	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+left_width-50&"px;top:"&table_y-20&"px;width:100px;height:18px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='center'>纵坐标</td></tr></table></v:textbox></v:shape>"
	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+left_width+all_width&"px;top:"&table_y+all_height-9&"px;width:100px;height:18px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='left'>横坐标</td></tr></table></v:textbox></v:shape>"


dim line_code
redim line_code(line_no,5)
for i=1 to line_no
	line_temp=split(total(0,i),",")
	line_code(i,1)=line_temp(0)
	line_code(i,2)=line_temp(1)
	line_code(i,3)=line_temp(2)
	line_code(i,4)=line_temp(3)
	line_code(i,5)=line_temp(4)
next
for j=1 to line_no
	for i=1 to total_no-1
		x1=table_x+left_width+all_width*(i-1)/total_no
		y1=table_y+(temp3-total(i,j))*(all_height/(temp3-temp6))
		x2=table_x+left_width+all_width*i/total_no
		y2=table_y+(temp3-total(i+1,j))*(all_height/(temp3-temp6))
		response.write "<v:line id=""_x0000_s1025"" alt="""" style='position:absolute;left:0;text-align:left;top:0;z-index:1' from="""&x1&"px,"&y1&"px"" to="""&x2&"px,"&y2&"px"" coordsize=""21600,21600"" strokecolor="""&line_code(j,1)&""" strokeweight="""&line_code(j,2)&""">"

		select case line_code(j,3)
		case 1
		case 2
			response.write "<v:stroke dashstyle='1 1'/>"
		case 3
			response.write "<v:stroke dashstyle='dash'/>"
		case 4
			response.write "<v:stroke dashstyle='dashDot'/>"
		case 5
			response.write "<v:stroke dashstyle='longDash'/>"
		case 6
			response.write "<v:stroke dashstyle='longDashDot'/>"
		case 7
			response.write "<v:stroke dashstyle='longDashDotDot'/>"
		case else
		end select
		response.write "</v:line>"&CHR(13)
		select case line_code(j,4)
		case 1
		case 2
			response.write "<v:rect id=""_x0000_s1027"" style='position:absolute;left:"&x1-2&"px;top:"&y1-2&"px;width:4px;height:4px; z-index:2' fillcolor="""&line_code(j,1)&""" strokecolor="""&line_code(j,1)&"""/>"&CHR(13)
		case 3
			response.write "<v:oval id=""_x0000_s1026"" style='position:absolute;left:"&x1-2&"px;top:"&y1-2&"px;width:4px;height:4px;z-index:1' fillcolor="""&line_code(j,1)&""" strokecolor="""&line_code(j,1)&"""/>"&CHR(13)
		end select
		response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&x1&"px;top:"&y1-15&"px;width:60px;height:18px;z-index:1'><v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='left'>"&total(i,j)&"</td></tr></table></v:textbox></v:shape>"
	next
	select case line_code(j,4)
	case 1
	case 2
		response.write "<v:rect id=""_x0000_s1027"" style='position:absolute;left:"&x2-2&"px;top:"&y2-2&"px;width:4px;height:4px; z-index:2' fillcolor="""&line_code(j,1)&""" strokecolor="""&line_code(j,1)&"""/>"&CHR(13)
	case 3
		response.write "<v:oval id=""_x0000_s1026"" style='position:absolute;left:"&x2-2&"px;top:"&y2-2&"px;width:4px;height:4px;z-index:1' fillcolor="""&line_code(j,1)&""" strokecolor="""&line_code(j,1)&"""/>"&CHR(13)
	end select
	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&x2&"px;top:"&y2-15&"px;width:60px;height:18px;z-index:1'><v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='left'>"&total(i,j)&"</td></tr></table></v:textbox></v:shape>"
next
	
for i=1 to total_no
	response.write "<v:line id='_x0000_s1027' alt='' style='position:absolute;left:0;text-align:left;top:0;flip:y;z-index:-1' from='"&table_x+left_width+all_width*(i-1)/total_no&"px,"&table_y+all_height&"px' to='"&table_x+left_width+all_width*(i-1)/total_no&"px,"&table_y+all_height+15&"px'/>"
	response.write ""
	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+left_width+all_width*(i-1)/total_no&"px;top:"&table_y+all_height&"px;width:"&all_width/total_no&"px;height:18px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='left'>"&total(i,0)&"</td></tr></table></v:textbox></v:shape>"
next

tb_height=50
response.write "<v:rect id='_x0000_s1025' style='position:absolute;left:"&table_x+all_width+20&"px;top:"&table_y&"px;width:100px;height:"&line_no*tb_height+20&"px;z-index:1'/>"
for i=1 to line_no
	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+all_width+25&"px;top:"&table_y+10+(i-1)*tb_height&"px;width:60px;height:"&tb_height&"px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='left'>"&line_code(i,5)&"</td></tr></table></v:textbox></v:shape>"
	response.write "<v:rect id='_x0000_s1040' alt='' style='position:absolute;left:"&table_x+all_width+80&"px;top:"&table_y+10+(i-1)*tb_height+((tb_height-20)/2)&"px;width:30px;height:20px;z-index:1' fillcolor='"&line_code(i,1)&"'><v:fill color2='"&line_code(i,1)&"' rotate='t' focus='100%' type='gradient'/></v:rect>"
next

end function

function table3(total,table_x,table_y,all_width,all_height,table_type)
'参数含义(传递的数组，横坐标，纵坐标，图表的宽度，图表的高度,图表的类型)
'纯ASP代码生成图表函数3——饼图
'作者：龚鸣(Passwordgm) QQ:25968152 MSN:passwordgm@sina.com Email:passwordgm@sina.com
'本人非常愿意和ASP,VML,FLASH的爱好者在HTTP://www.ilisten.cn进行交流和探讨
'非常感谢您使用这个函数，请您使用和转载时保留版权信息，这是对作者工作的最好的尊重。
tb_height=30

dim tb_color(7,2)
tb_color(1,1)="#d1ffd1"
tb_color(2,1)="#ffbbbb"
tb_color(3,1)="#ffe3bb"
tb_color(4,1)="#cff4f3"
tb_color(5,1)="#d9d9e5"
tb_color(6,1)="#ffc7ab"
tb_color(7,1)="#ecffb7"

tb_color(1,2)="#00ff00"
tb_color(2,2)="#ff0000"
tb_color(3,2)="#ff9900"
tb_color(4,2)="#33cccc"
tb_color(5,2)="#666699"
tb_color(6,2)="#993300"
tb_color(7,2)="#99cc00"

total_no=ubound(total,1)
totalpie=0
for i=1 to total_no
	totalpie=totalpie+total(i,1)
next

PreAngle=0
for i=1 to total_no
	response.write "<v:shape id='_x0000_s1025' alt='' style='position:absolute;left:"&table_x&"px;top:"&table_y&"px;width:"&all_width&"px;height:"&all_height&"px;z-index:1' coordsize='1500,1400' o:spt='100' adj='0,,0' path='m750,700ae750,700,750,700,"&int(23592960*PreAngle)&","&int(23592960*total(i,1)/totalpie)&"xe' fillcolor='"&tb_color(i,1)&"' strokecolor='#FFFFFF'><v:fill color2='"&tb_color(i,2)&"' rotate='t' focus='100%' type='gradient'/><v:stroke joinstyle='round'/><v:formulas/><v:path o:connecttype='segments'/></v:shape>"&CHr(13)
	PreAngle=PreAngle+total(i,1)/totalpie
next

if table_type="A" then
	response.write "<v:rect id='_x0000_s1025' style='position:absolute;left:"&table_x+all_width+20&"px;top:"&table_y+20&"px;width:100px;height:"&total_no*tb_height+20&"px;z-index:1'/>"
for i=1 to total_no
	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+all_width+25&"px;top:"&table_y+30+(i-1)*tb_height&"px;width:60px;height:"&tb_height&"px;z-index:1'>"
	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='left'>"&total(i,0)&"</td></tr></table></v:textbox></v:shape>"
	response.write "<v:rect id='_x0000_s1040' alt='' style='position:absolute;left:"&table_x+all_width+80&"px;top:"&table_y+30+(i-1)*tb_height+3&"px;width:30px;height:20px;z-index:1' fillcolor='"&tb_color(i,1)&"'><v:fill color2='"&tb_color(i,2)&"' rotate='t' focus='100%' type='gradient'/></v:rect>"
'显示比例数
'	response.write "<v:shape id='_x0000_s1025' type='#_x0000_t202' alt='' style='position:absolute;left:"&table_x+all_width+110&"px;top:"&table_y+30+(i-1)*tb_height&"px;width:60px;height:"&tb_height&"px;z-index:1'>"
'	response.write "<v:textbox inset='0px,0px,0px,0px'><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='left'>"&formatnumber(total(i,1)*100/totalpie,2,-1)&"%</td></tr></table></v:textbox></v:shape>"
next
end if

if table_type="B" then
pie=3.14159265358979
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