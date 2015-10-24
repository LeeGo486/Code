var bMoveable1=true;
var strFrame1;

document.writeln('<iframe id=endDateLayer1 frameborder=0 width=162 height=211 style="position: absolute; z-index: 9998; display: none"></iframe>');
strFrame1='<style>';
strFrame1+='INPUT.button{BORDER-RIGHT: #63A3E9 1px solid;BORDER-TOP: #63A3E9 1px solid;BORDER-LEFT: #63A3E9 1px solid;';
strFrame1+='BORDER-BOTTOM: #63A3E9 1px solid;BACKGROUND-COLOR: #63A3E9;font-family:宋体;}';
strFrame1+='TD{FONT-SIZE: 9pt;font-family:宋体;}';
strFrame1+='</style>';
strFrame1+='<scr' + 'ipt>';
strFrame1+='var datelayerx,datelayery;';
strFrame1+='var bDrag;';
strFrame1+='function document.onmousemove()';
strFrame1+='{if(bDrag && window.event.button==1)';
strFrame1+=' {var DateLayer=parent.document.all.endDateLayer1.style;';
strFrame1+=' DateLayer.posLeft += window.event.clientX-datelayerx;';
strFrame1+=' DateLayer.posTop += window.event.clientY-datelayery;}}';
strFrame1+='function DragStart()';
strFrame1+='{var DateLayer=parent.document.all.endDateLayer1.style;';
strFrame1+=' datelayerx=window.event.clientX;';
strFrame1+=' datelayery=window.event.clientY;';
strFrame1+=' bDrag=true;}';
strFrame1+='function DragEnd(){';
strFrame1+=' bDrag=false;}';
strFrame1+='</scr' + 'ipt>';
strFrame1+='<div style="z-index:9999;position: absolute; left:0; top:0;" onselectstart="return false">';
strFrame1+='<span id=tmpSelectYearLayer1 style="z-index: 9999;position: absolute;top: 3; left: 19;display: none"></span>';
strFrame1+='<span id=tmpSelectMonthLayer1 style="z-index: 9999;position: absolute;top: 3; left: 78;display: none"></span>';
strFrame1+='<span id=tmpSelectHourLayer1 style="z-index: 9999;position: absolute;top: 188; left: 35px;display: none"></span>';
strFrame1+='<span id=tmpSelectMinuteLayer1 style="z-index:9999;position:absolute;top: 188; left: 77px;display: none"></span>';
strFrame1+='<span id=tmpSelectSecondLayer1 style="z-index:9999;position:absolute;top: 188; left: 119px;display: none"></span>';
strFrame1+='<table border=1 cellspacing=0 cellpadding=0 width=142 height=160 bordercolor=#63A3E9 bgcolor=#63A3E9 >';
strFrame1+='    <tr><td width=142 height=23 bgcolor=#FFFFFF>';
strFrame1+='        <table border=0 cellspacing=1 cellpadding=0 width=158 height=23>';
strFrame1+='            <tr align=center >';
strFrame1+='                <td width=16 align=center bgcolor=#63A3E9 style="font-size:12px;cursor: hand;color: #ffffff" ';
strFrame1+='        onclick="parent.meizzPrevM1()" title="向前翻 1 月" ><b >&lt;</b></td>';
//俞晓东2011年修改---------------------------------
//strFrame1+='       <td width=60 align="center" bgcolor="#63A3E9" style="font-size:12px;cursor:hand" ';
//strFrame1+='           onmouseover="style.backgroundColor=\'#aaccf3\'"';
//strFrame1+='        onmouseout="style.backgroundColor=\'#63A3E9\'" ';
//strFrame1+='        onclick="parent.tmpSelectYearInnerHTML1(this.innerText.substring(0,4))" ';
//strFrame1+='        title="点击这里选择年份"><span id=meizzYearHead></span></td>';
//----------------------------------------------------------
strFrame1+='       <td width=108 align="center" style="font-size:12px;font-color: #ffffff;cursor:hand" ';
strFrame1+='        bgcolor="#63A3E9" onmouseover="style.backgroundColor=\'#aaccf3\'" ';
strFrame1+='        onmouseout="style.backgroundColor=\'#63A3E9\'" ';
strFrame1+='        onclick="parent.tmpSelectMonthInnerHTML1(this.innerText.length==3?this.innerText.substring(0,1):this.innerText.substring(0,2))"';
strFrame1+='        title="点击这里选择月份"><span id=meizzMonthHead1 ></span></td>';
strFrame1+='       <td width=16 bgcolor=#63A3E9 align=center style="font-size:12px;cursor: hand;color: #ffffff" ';
strFrame1+='        onclick="parent.meizzNextM1()" title="向后翻 1 月" ><b >&gt;</b></td>';
strFrame1+='      </tr>';
strFrame1+='     </table></td></tr>';
strFrame1+='    <tr><td width=142 height=18 >';
strFrame1+='     <table border=0 cellspacing=0 cellpadding=2 bgcolor=#63A3E9 ' + (bMoveable1? 'onmousedown="DragStart()" onmouseup="DragEnd()"':'');
strFrame1+='    BORDERCOLORLIGHT=#63A3E9 BORDERCOLORDARK=#FFFFFF width=140 height=20 style="cursor:' + (bMoveable1 ? 'move':'default') + '">';
strFrame1+='    <tr><td style="font-size:12px;color:#ffffff" width=20>&nbsp;日</td>';
strFrame1+='<td style="font-size:12px;color:#FFFFFF" >&nbsp;一</td><td style="font-size:12px;color:#FFFFFF">&nbsp;二</td>';
strFrame1+='<td style="font-size:12px;color:#FFFFFF" >&nbsp;三</td><td style="font-size:12px;color:#FFFFFF" >&nbsp;四</td>';
strFrame1+='<td style="font-size:12px;color:#FFFFFF" >&nbsp;五</td><td style="font-size:12px;color:#FFFFFF" >&nbsp;六</td></tr>';
strFrame1+='</table></td></tr>';
strFrame1+=' <tr ><td width=142 height=120 >';
strFrame1+='    <table border=1 cellspacing=2 cellpadding=2 BORDERCOLORLIGHT=#63A3E9 BORDERCOLORDARK=#FFFFFF bgcolor=#fff8ec width=140 height=120 >';
var n=0; for (j=0;j<5;j++){ strFrame1+= ' <tr align=center >'; for (i=0;i<7;i++){
strFrame1+='<td width=20 height=20 id=meizzDay'+n+' style="font-size:12px" onclick=parent.meizzDayClick1(this.innerText,0)></td>';n++;}
strFrame1+='</tr>';}
strFrame1+='      <tr align=center >';
for (i=35;i<37;i++)strFrame1+='<td width=20 height=20 id=meizzDay'+i+' style="font-size:12px" onclick="parent.meizzDayClick1(this.innerText,0)"></td>';
strFrame1+='        <td colspan=5 align=right style="color:#1478eb"><span onclick="parent.setNull1()" style="font-size:12px;cursor: hand"';
strFrame1+='         onmouseover="style.color=\'#ff0000\'" onmouseout="style.color=\'#1478eb\'" title="将日期置空">置空</span>&nbsp;&nbsp;<span onclick="parent.meizzToday1()" style="font-size:12px;cursor: hand"';
strFrame1+='         onmouseover="style.color=\'#ff0000\'" onmouseout="style.color=\'#1478eb\'" title="当前日期时间">当前</span>&nbsp;&nbsp;<span style="cursor:hand" id=evaAllOK onmouseover="style.color=\'#ff0000\'" onmouseout="style.color=\'#1478eb\'" onclick="parent.closeLayer1()" title="关闭日历">关闭&nbsp;</span></td></tr>';
strFrame1+='    </table></td></tr>';

strFrame1+=' 	<tr ><td >';
strFrame1+='        <table border=0 cellspacing=1 cellpadding=0 width=100% bgcolor=#FFFFFF height=22 >';
strFrame1+='          <tr bgcolor="#63A3E9"><td id=bUseTimeLayer width=30 style="cursor:hand" title="点击这里启用/禁用时间"';
strFrame1+='    onmouseover="style.backgroundColor=\'#aaccf3\'" align=center onmouseout="style.backgroundColor=\'#63A3E9\'"';
strFrame1+='     onclick="parent.UseTime1(this)">';
strFrame1+=' <span></span></td>';
strFrame1+='             <td style="cursor:hand" onclick="parent.tmpSelectHourInnerHTML1(this.innerText.length==3?this.innerText.substring(0,1):this.innerText.substring(0,2))"';
strFrame1+=' onmouseover="style.backgroundColor=\'#aaccf3\'" onmouseout="style.backgroundColor=\'#63A3E9\'"';
strFrame1+=' title="点击这里选择时间" align=center width=42>' ;
strFrame1+='     <span id=meizzHourHead1></span></td>';
strFrame1+='             <td style="cursor:hand" onclick="parent.tmpSelectMinuteInnerHTML1(this.innerText.length==3?this.innerText.substring(0,1):this.innerText.substring(0,2))"';
strFrame1+=' onmouseover="style.backgroundColor=\'#aaccf3\'" onmouseout="style.backgroundColor=\'#63A3E9\'"';
strFrame1+=' title="点击这里选择时间" align=center width=42>' ;
strFrame1+='     <span id=meizzMinuteHead1></span></td>';
strFrame1+='             <td style="cursor:hand" onclick="parent.tmpSelectSecondInnerHTML1(this.innerText.length==3?this.innerText.substring(0,1):this.innerText.substring(0,2))"';
strFrame1+=' onmouseover="style.backgroundColor=\'#aaccf3\'" onmouseout="style.backgroundColor=\'#63A3E9\'"';
strFrame1+=' title="点击这里选择时间" align=center width=42>' ;
strFrame1+='     <span id=meizzSecondHead1></span></td>';
strFrame1+='    </tr></table></td></tr>';
	
strFrame1+=' 	</table></div>';

window.frames.endDateLayer1.document.writeln(strFrame1);
window.frames.endDateLayer1.document.close(); 



var outObject1;
var outButton1; //点击的按钮


var outDate1=""; //存放对象的日期

var bUseTime1=true; //是否使用时间
var odatelayer1=window.frames.endDateLayer1.document.all; //存放日历对象
var odatelayer1=window.endDateLayer1.document.all;
//odatelayer1.bUseTimeLayer.innerText="NO";
bImgSwitch1();
odatelayer1.bUseTimeLayer.innerHTML=bImg;



function setdayYM(tt,obj) //主调函数
{
if (arguments.length > 2){alert("对不起！傳入本控件的参数太多！");return;}
if (arguments.length == 0){alert("对不起！您沒有傳回本控件任何参数");return;}
var dads = document.all.endDateLayer1.style;
var th = tt;
var ttop = tt.offsetTop; //TT控件的定位点高


var thei = tt.clientHeight; //TT控件本身的高
var tleft = tt.offsetLeft; //TT控件的定位点宽


var ttyp = tt.type; //TT控件的类型


while (tt = tt.offsetParent){ttop+=tt.offsetTop; tleft+=tt.offsetLeft;}
dads.top = (ttyp=="image") ? ttop+thei : ttop+thei+6;
dads.left = tleft;
outObject1 = (arguments.length == 1) ? th : obj;
outButton1 = (arguments.length == 1) ? null : th; //设定外部点击的按钮


//根据当前输入框的日期显示日历的年月

//var reg = /^(\d+)-(\d{1,2})-(\d{1,2})/; //不含时间
var reg = /^(\d{1,2})-(\d{1,2})/;
var r = outObject1.value.match(reg);

if(r!=null){

r[1]=r[1]-1;
var d=new Date(new Date().getFullYear(),r[1],r[2]);
if(d.getFullYear()==new Date().getFullYear() && d.getMonth()==r[1] && d.getDate()==r[2])
{
  
	outDate1=d;
   /*俞晓东
   parent.meizzTheYear1 = r[1];
  */
   parent.meizzTheMonth1 = r[1];
   parent.meizzTheDate1 = r[2];
}
else
{
   outDate1="";
}
meizzSetDay1(new Date().getFullYear(),r[1]+1,r[2]);
}
else
{
outDate1="";
meizzSetDay1(new Date().getFullYear(), new Date().getMonth() + 1);
}
dads.display = '';

//判断初始化时是否使用时间,非严格验证

if (outObject1.value.length>10)
{
bUseTime1=true;
bImgSwitch1();
odatelayer1.bUseTimeLayer.innerHTML=bImg;
meizzWriteHead(meizzTheYear1,meizzTheMonth1);
}
else
{
bUseTime1=false;
bImgSwitch1();
odatelayer1.bUseTimeLayer.innerHTML=bImg;
meizzWriteHead(meizzTheYear1,meizzTheMonth1);
}

try
{
event.returnValue=false;
}
catch (e)
{
//此处排除错误，错误原因暂未找到。

}
}

var MonHead1 = new Array(12); //定义阳历中每个月的最大天数


MonHead1[0] = 31; MonHead1[1] = 28; MonHead1[2] = 31; MonHead1[3] = 30; MonHead1[4] = 31; MonHead1[5] = 30;
MonHead1[6] = 31; MonHead1[7] = 31; MonHead1[8] = 30; MonHead1[9] = 31; MonHead1[10] = 30; MonHead1[11] = 31;

var meizzTheYear1=new Date().getFullYear(); //定义年的变量的初始值


var meizzTheMonth1=new Date().getMonth()+1; //定义月的变量的初始值


var meizzTheDate1=new Date().getDate(); //定义日的变量的初始值 
var meizzTheHour1=new Date().getHours(); //定义小时变量的初始值


var meizzTheMinute1=new Date().getMinutes();//定义分钟变量的初始值

var meizzTheSecond1=new Date().getSeconds();//定义秒变量的初始值


var meizzWDay1=new Array(37); //定义写日期的数组

 document.onclick= function()//任意点击时关闭该控件 //ie6的情况可以由下面的切换焦点处理代替

{ 
with(window.event)
{
if (srcElement != outObject1 && srcElement != outButton1)
closeLayer1();
}
};

 document.onkeyup= function()//按Esc键关闭，切换焦点关闭
{
if (window.event.keyCode==27){
if(outObject1)outObject1.blur();
closeLayer1();
}
else if(document.activeElement)
{
if(document.activeElement != outObject1 && document.activeElement != outButton1)
{
   closeLayer1();
}
}
};

function meizzWriteHead1(yy,mm,ss) //往 head 中写入当前的年与月

{
//odatelayer1.meizzYearHead.innerText = yy + " 年"; 俞晓东
odatelayer1.meizzMonthHead1.innerText = format(mm) + " 月";
//插入当前小时、分
odatelayer1.meizzHourHead1.innerText=bUseTime1?(meizzTheHour1+" 时"):""; 
odatelayer1.meizzMinuteHead1.innerText=bUseTime1?(meizzTheMinute1+" 分"):"";
odatelayer1.meizzSecondHead1.innerText=bUseTime1?(meizzTheSecond1+" 秒"):"";
}

function tmpSelectYearInnerHTML1(strYear) //年份的下拉框
{
if (strYear.match(/\D/)!=null){alert("年份输入参数不是数字！");return;}
var m = (strYear) ? strYear : new Date().getFullYear();
if (m < 1000 || m > 9999) {alert("年份值不在 1000 到 9999 之间！");return;}
var n = m - 50;
if (n < 1000) n = 1000;
if (n + 101 > 9999) n = 9974;
var s = "&nbsp;<select name=tmpSelectYear1 style='font-size: 12px' ";
s += "onblur='document.all.tmpSelectYearLayer1.style.display=\"none\"' ";
s += "onchange='document.all.tmpSelectYearLayer1.style.display=\"none\";";
s += "parent.meizzTheYear1 = this.value; parent.meizzSetDay1(parent.meizzTheYear1,parent.meizzTheMonth1)'>\r\n";
var selectInnerHTML = s;
for (var i = n; i < n + 101; i++)
{
if (i == m) { selectInnerHTML += "<option value='" + i + "' selected>" + i + "年" + "</option>\r\n"; }
else { selectInnerHTML += "<option value='" + i + "'>" + i + "年" + "</option>\r\n"; }
}
selectInnerHTML += "</select>";
odatelayer1.tmpSelectYearLayer1.style.display="";
odatelayer1.tmpSelectYearLayer1.innerHTML = selectInnerHTML;
odatelayer1.tmpSelectYear1.focus();
}

function tmpSelectMonthInnerHTML1(strMonth) //月份的下拉框
{
if (strMonth.match(/\D/)!=null){alert("月份输入参数不是数字！");return;}
var m = (strMonth) ? strMonth : new Date().getMonth() + 1;
var s = "&nbsp;&nbsp;&nbsp;<select name=tmpSelectMonth1 style='font-size: 12px' ";
s += "onblur='document.all.tmpSelectMonthLayer1.style.display=\"none\"' ";
s += "onchange='document.all.tmpSelectMonthLayer1.style.display=\"none\";";
s += "parent.meizzTheMonth1 = this.value; parent.meizzSetDay1(parent.meizzTheYear1,parent.meizzTheMonth1)'>\r\n";
var selectInnerHTML = s;
for (var i = 1; i < 13; i++)
{
if (i == m) { selectInnerHTML += "<option value='"+i+"' selected>"+i+"月"+"</option>\r\n"; }
else { selectInnerHTML += "<option value='"+i+"'>"+i+"月"+"</option>\r\n"; }
}
selectInnerHTML += "</select>";
odatelayer1.tmpSelectMonthLayer1.style.display="";
odatelayer1.tmpSelectMonthLayer1.innerHTML = selectInnerHTML;
odatelayer1.tmpSelectMonth1.focus();
}

/***** 增加 小时、分钟 ***/
function tmpSelectHourInnerHTML1(strHour) //小时的下拉框
{
if (!bUseTime1){return;}

if (strHour.match(/\D/)!=null){alert("小时参数不是数字！");return;}
var m = (strHour) ? strHour : new Date().getHours();
var s = "<select name=tmpSelectHour1 style='font-size: 12px' ";
s += "onblur='document.all.tmpSelectHourLayer1.style.display=\"none\"' ";
s += "onchange='document.all.tmpSelectHourLayer1.style.display=\"none\";";
s += "parent.meizzTheHour1 = this.value; parent.evaSetTime1(parent.meizzTheHour1,parent.meizzTheMinute1);'>\r\n";
var selectInnerHTML = s;
for (var i = 0; i < 24; i++)
{
if (i == m) { selectInnerHTML += "<option value='"+i+"' selected>"+i+"</option>\r\n"; }
else { selectInnerHTML += "<option value='"+i+"'>"+i+"</option>\r\n"; }
}
selectInnerHTML += "</select>";
odatelayer1.tmpSelectHourLayer1.style.display="";
odatelayer1.tmpSelectHourLayer1.innerHTML = selectInnerHTML;
odatelayer1.tmpSelectHour1.focus();
}

function tmpSelectMinuteInnerHTML1(strMinute) //分钟的下拉框
{
if (!bUseTime1){return;}

if (strMinute.match(/\D/)!=null){alert("分钟输入数字不是数字！");return;}
var m = (strMinute) ? strMinute : new Date().getMinutes();
var s = "<select name=tmpSelectMinute1 style='font-size: 12px' ";
s += "onblur='document.all.tmpSelectMinuteLayer1.style.display=\"none\"' ";
s += "onchange='document.all.tmpSelectMinuteLayer1.style.display=\"none\";";
s += "parent.meizzTheMinute1 = this.value; parent.evaSetTime1(parent.meizzTheHour1,parent.meizzTheMinute1);'>\r\n";
var selectInnerHTML = s;
for (var i = 0; i < 60; i++)
{
if (i == m) { selectInnerHTML += "<option value='"+i+"' selected>"+i+"</option>\r\n"; }
else { selectInnerHTML += "<option value='"+i+"'>"+i+"</option>\r\n"; }
}
selectInnerHTML += "</select>";
odatelayer1.tmpSelectMinuteLayer1.style.display="";
odatelayer1.tmpSelectMinuteLayer1.innerHTML = selectInnerHTML;
odatelayer1.tmpSelectMinute1.focus();
}

function tmpSelectSecondInnerHTML1(strSecond) //秒的下拉框

{
if (!bUseTime1){return;}

if (strSecond.match(/\D/)!=null){alert("秒钟输入不是数字！");return;}
var m = (strSecond) ? strSecond : new Date().getMinutes();
var s = "<select name=tmpSelectSecond1 style='font-size: 12px' ";
s += "onblur='document.all.tmpSelectSecondLayer1.style.display=\"none\"' ";
s += "onchange='document.all.tmpSelectSecondLayer1.style.display=\"none\";";
s += "parent.meizzTheSecond1 = this.value; parent.evaSetTime1(parent.meizzTheHour1,parent.meizzTheMinute1,parent.meizzTheSecond1);'>\r\n";
var selectInnerHTML = s;
for (var i = 0; i < 60; i++)
{
if (i == m) { selectInnerHTML += "<option value='"+i+"' selected>"+i+"</option>\r\n"; }
else { selectInnerHTML += "<option value='"+i+"'>"+i+"</option>\r\n"; }
}
selectInnerHTML += "</select>";
odatelayer1.tmpSelectSecondLayer1.style.display="";
odatelayer1.tmpSelectSecondLayer1.innerHTML = selectInnerHTML;
odatelayer1.tmpSelectSecond1.focus();
}

function closeLayer1() //这个层的关闭
{
var o = document.getElementById("endDateLayer1");
if (o != null)
{
o.style.display="none";
}
}

function showLayer1() //这个层的关闭
{
document.all.endDateLayer1.style.display="";
}


//function IsPinYear(year) //判断是否闰平年

//{
//if (0==year%4&&((year%100!=0)||(year%400==0))) return true;else return false;
//}

//function GetMonthCount(year,month) //闰年二月为29天

//{
//var c=MonHead1[month-1];if((month==2)&&IsPinYear(year)) c++;return c;
//}

//function GetDOW(day,month,year) //求某天的星期几

//{
//var dt=new Date(year,month-1,day).getDay()/7; return dt;
//}

function meizzPrevY1() //往前翻 Year
{
if(meizzTheYear1 > 999 && meizzTheYear1 <10000){meizzTheYear1--;}
else{alert("年份超出范围（1000-9999）！");}
meizzSetDay1(meizzTheYear1,meizzTheMonth1);
}
function meizzNextY1() //往后翻 Year
{
if(meizzTheYear1 > 999 && meizzTheYear1 <10000){meizzTheYear1++;}
else{alert("年份超出范围（1000-9999）！");}
meizzSetDay1(meizzTheYear1,meizzTheMonth1);
}
function setNull1()
{
outObject1.value = '';
closeLayer1();
}
function meizzToday1() {//Today Button

parent.meizzTheYear1 = new Date().getFullYear();
parent.meizzTheMonth1 = new Date().getMonth()+1;
parent.meizzTheDate1 = new Date().getDate();
parent.meizzTheHour1 = new Date().getHours();
parent.meizzTheMinute1 = new Date().getMinutes();
parent.meizzTheSecond1 = new Date().getSeconds();
var meizzTheSecond1 = new Date().getSeconds();

if (meizzTheMonth1<10 && meizzTheMonth1.length<2) //格式化成两位数字
{
parent.meizzTheMonth1="0"+parent.meizzTheMonth1;
}
if (parent.meizzTheDate1<10 && parent.meizzTheDate1.length<2) //格式化成两位数字
{
parent.meizzTheDate1="0"+parent.meizzTheDate1;
}
//meizzSetDay1(meizzTheYear1,meizzTheMonth1);
if(outObject1)
{
if (bUseTime1)
{
   outObject1.value= //parent.meizzTheYear1 + "-" +  俞晓东
   		format( parent.meizzTheMonth1) + "-" + 
       format(parent.meizzTheDate1) + " " + format(parent.meizzTheHour1) + ":" + 
       format(parent.meizzTheMinute1) + ":" + format(parent.meizzTheSecond1); 
       //注：在这里你可以输出改成你想要的格式
}
else
{
   outObject1.value= //parent.meizzTheYear1 + "-" + 俞晓东
       format( parent.meizzTheMonth1) + "-" + 
       format(parent.meizzTheDate1); //注：在这里你可以输出改成你想要的格式
}
}
closeLayer1();
}
function meizzPrevM1() //往前翻月份
{
if(meizzTheMonth1>1){meizzTheMonth1--;}else{meizzTheYear1--;meizzTheMonth1=12;}
meizzSetDay1(meizzTheYear1,meizzTheMonth1);
}
function meizzNextM1() //往后翻月份
{
if(meizzTheMonth1==12){meizzTheYear1++;meizzTheMonth1=1;}else{meizzTheMonth1++;}
meizzSetDay1(meizzTheYear1,meizzTheMonth1);
}

// TODO: 整理代码
function meizzSetDay1(yy,mm) //主要的写程序**********
{
meizzWriteHead1(yy,mm);
//设置当前年月的公共变量为传入值


meizzTheYear1=yy;
meizzTheMonth1=mm;

for (var i = 0; i < 37; i++){meizzWDay1[i]=""}; //将显示框的内容全部清空


var day1 = 1,day2=1,firstday = new Date(yy,mm-1,1).getDay(); //某月第一天的星期几


for (i=0;i<firstday;i++)meizzWDay1[i]=GetMonthCount(mm==1?yy-1:yy,mm==1?12:mm-1)-firstday+i+1 //上个月的最后几天


for (i = firstday; day1 < GetMonthCount(yy,mm)+1; i++) { meizzWDay1[i]=day1;day1++; }
for (i=firstday+GetMonthCount(yy,mm);i<37;i++) { meizzWDay1[i]=day2;day2++; }
for (i = 0; i < 37; i++)
{
var da = eval("odatelayer1.meizzDay"+i); //书写新的一个月的日期星期排列


if (meizzWDay1[i]!="")
{
//初始化边框

da.borderColorLight="#63A3E9";
da.borderColorDark="#63A3E9";
da.style.color="#1478eb";
if(i<firstday) //上个月的部分
{
   da.innerHTML="<b><font color=#BCBABC>" + meizzWDay1[i] + "</font></b>";
   da.title=(mm==1?12:mm-1) +"月" + meizzWDay1[i] + "日";
   da.onclick=Function("meizzDayClick1(this.innerText,-1)");

   if(!outDate1)
    da.style.backgroundColor = ((mm==1?yy-1:yy) == new Date().getFullYear() && 
     (mm==1?12:mm-1) == new Date().getMonth()+1 && meizzWDay1[i] == new Date().getDate()) ?
      "#5CEFA0":"#f5f5f5";
   else
   {
    da.style.backgroundColor =((mm==1?yy-1:yy)==outDate1.getFullYear() && (mm==1?12:mm-1)== outDate1.getMonth() + 1 && 
    meizzWDay1[i]==outDate1.getDate())? "#84C1FF" :
    (((mm==1?yy-1:yy) == new Date().getFullYear() && (mm==1?12:mm-1) == new Date().getMonth()+1 && 
    meizzWDay1[i] == new Date().getDate()) ? "#5CEFA0":"#f5f5f5");
    //将选中的日期显示为凹下去


    if((mm==1?yy-1:yy)==outDate1.getFullYear() && (mm==1?12:mm-1)== outDate1.getMonth() + 1 && 
    meizzWDay1[i]==outDate1.getDate())
    {
     da.borderColorLight="#FFFFFF";
     da.borderColorDark="#63A3E9";
    }
   }
}
else if (i>=firstday+GetMonthCount(yy,mm)) //下个月的部分
{
   da.innerHTML="<b><font color=#BCBABC>" + meizzWDay1[i] + "</font></b>";
   da.title=(mm==12?1:mm+1) +"月" + meizzWDay1[i] + "日";
   da.onclick=Function("meizzDayClick1(this.innerText,1)");
   if(!outDate1)
    da.style.backgroundColor = ((mm==12?yy+1:yy) == new Date().getFullYear() && 
     (mm==12?1:mm+1) == new Date().getMonth()+1 && meizzWDay1[i] == new Date().getDate()) ?
      "#5CEFA0":"#f5f5f5";
   else
   {
    da.style.backgroundColor =((mm==12?yy+1:yy)==outDate1.getFullYear() && (mm==12?1:mm+1)== outDate1.getMonth() + 1 && 
    meizzWDay1[i]==outDate1.getDate())? "#84C1FF" :
    (((mm==12?yy+1:yy) == new Date().getFullYear() && (mm==12?1:mm+1) == new Date().getMonth()+1 && 
    meizzWDay1[i] == new Date().getDate()) ? "#5CEFA0":"#f5f5f5");
    //将选中的日期显示为凹下去

 if((mm==12?yy+1:yy)==outDate1.getFullYear() && (mm==12?1:mm+1)== outDate1.getMonth() + 1 && 
    meizzWDay1[i]==outDate1.getDate())
    {
     da.borderColorLight="#FFFFFF";
     da.borderColorDark="#63A3E9";
    }
   }
}
else //本月的部分


{
   da.innerHTML="<b>" + meizzWDay1[i] + "</b>";
   da.title=mm +"月" + meizzWDay1[i] + "日";
   da.onclick=Function("meizzDayClick1(this.innerText,0)"); //给td赋予onclick事件的处理


   //如果是当前选择的日期，则显示亮蓝色的背景；如果是当前日期，则显示暗黄色背景
   if(!outDate1)
    da.style.backgroundColor = (yy == new Date().getFullYear() && mm == new Date().getMonth()+1 && meizzWDay1[i] == new Date().getDate())?
     "#5CEFA0":"#f5f5f5";
   else
   {
    da.style.backgroundColor =(yy==outDate1.getFullYear() && mm== outDate1.getMonth() + 1 && meizzWDay1[i]==outDate1.getDate())?
     "#84C1FF":((yy == new Date().getFullYear() && mm == new Date().getMonth()+1 && meizzWDay1[i] == new Date().getDate())?
     "#5CEFA0":"#f5f5f5");
    //将选中的日期显示为凹下去


    if(yy==outDate1.getFullYear() && mm== outDate1.getMonth() + 1 && meizzWDay1[i]==outDate1.getDate())
    {
     da.borderColorLight="#FFFFFF";
     da.borderColorDark="#63A3E9";
    }
   }
}
    da.style.cursor="hand";
   }
else { da.innerHTML="";da.style.backgroundColor="";da.style.cursor="default"; }
}
}

function meizzDayClick1(n,ex) //点击显示框选取日期，主输入函数*************
{
parent.meizzTheDate1=n;
var yy=meizzTheYear1;
var mm = parseInt(meizzTheMonth1)+ex; //ex表示偏移量，用于选择上个月份和下个月份的日期
var hh=meizzTheHour1;
var mi=meizzTheMinute1;
var se=meizzTheSecond1;
//判断月份，并进行对应的处理


if(mm<1){
yy--;
mm=12+mm;
}
else if(mm>12){
yy++;
mm=mm-12;
}

if (mm < 10) {mm = "0" + mm;}
if (hh<10) {hh="0" + hh;} //时

if (mi<10) {mi="0" + mi;} //分

if (se<10) {se="0" + se;} //秒


if (outObject1)
{
if (!n) { //outObject1.value=""; 
   return;}
if ( n < 10){n = "0" + n;}

WriteDateTo1(yy,mm,n,hh,mi,se);

closeLayer1(); 
if (bUseTime1)
{
   try
   {
    outButton1.click();
   }
   catch (e)
   {
    setdayYM(outObject1);
   }
}
}
else {closeLayer1(); alert("您所要输出的控件对象并不存在！");}
closeLayer1();
}

/*function format(n) //格式化数字为两位字符表示
{
var m=new String();
var tmp=new String(n);
if (n<10 && tmp.length<2)
{
m="0"+n;
}
else
{
m=n;
}
return m;
}*/

function evaSetTime1() //设置用户选择的小时、分钟

{
odatelayer1.meizzHourHead1.innerText=meizzTheHour1+" 时";
odatelayer1.meizzMinuteHead1.innerText=meizzTheMinute1+" 分";
odatelayer1.meizzSecondHead1.innerText=meizzTheSecond1+" 秒";
WriteDateTo1(meizzTheYear1,meizzTheMonth1,meizzTheDate1,meizzTheHour1,meizzTheMinute1,meizzTheSecond1)
}

function evaSetTimeNothing1() //设置时间控件为空
{
odatelayer1.meizzHourHead1.innerText="";
odatelayer1.meizzMinuteHead1.innerText="";
odatelayer1.meizzSecondHead1.innerText="";
WriteDateTo1(meizzTheYear1,meizzTheMonth1,meizzTheDate1,meizzTheHour1,meizzTheMinute1,meizzTheSecond1)
}

function evaSetTimeNow1() //设置时间控件为当前时间

{
odatelayer1.meizzHourHead1.innerText=new Date().getHours()+" 时";
odatelayer1.meizzMinuteHead1.innerText=new Date().getMinutes()+" 分";
odatelayer1.meizzSecondHead1.innerText=new Date().getSeconds()+" 秒";
meizzTheHour1 = new Date().getHours();
meizzTheMinute1 = new Date().getMinutes();
meizzTheSecond1 = new Date().getSeconds();
WriteDateTo1(meizzTheYear1,meizzTheMonth1,meizzTheDate1,meizzTheHour1,meizzTheMinute1,meizzTheSecond1);
}

function UseTime1(ctl)
{
bUseTime1=!bUseTime1;
if (bUseTime1)
{
bImgSwitch1();
ctl.innerHTML=bImg;
evaSetTime1(); //显示时间，用户原来选择的时间

//evaSetTimeNow1(); //显示当前时间
}
else
{
bImgSwitch1();
ctl.innerHTML=bImg;
evaSetTimeNothing1();
}
}

function WriteDateTo1(yy,mm,n,hh,mi,se)
{
if (bUseTime1)
{
outObject1.value= //yy + "-" + 俞晓东
	format(mm) + "-" + format(n) + " " + format(hh) + ":" + format(mi) + ":" + format(se); //注：在这里你可以输出改成你想要的格式
}
else
{
outObject1.value= //yy + "-" + 俞晓东
		format(mm) + "-" + format(n); //注：在这里你可以输出改成你想要的格式
}
}

function bImgSwitch1()
{
if (bUseTime1)
{
bImg="关闭";
}
else

bImg="开启";
}




 


