<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.custanalysis.entity.Category" %>
<%@ page import="com.custanalysis.entity.Communication" %>
<%@ page import="com.custanalysis.entity.Style" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>一对一客户分析</title>
    <link rel="stylesheet" href="./css/common.css" type="text/css"></link>
    <script type="text/javascript" src="./js/jquery-1.7.2.min.js"></script>
  </head>
  
  <body>
    <div id="title">
    	<div id="sign">CRM Assistant</div>
    	<div id="titleName">一对一客户分析</div>
    </div>
    <table id="basic" cellpadding="0" cellspacing="0">
    	<tbody>
    		<tr class="head">
    			<td colspan="7">基本资料</td>
    		</tr>
    		<tr>
    			<td class="toLeft">姓名：</td>
    			<td class="toCenter">${ACCOUNTNAME}</td>
    			<td class="toLeft">VIP卡号：</td>
    			<td class="toCenter">${CODE}</td>
    			<td class="toLeft">手机：</td>
    			<td class="toCenter">${MOBILE}</td>
    			<td id="photo" rowspan="8" class="toCenter">照片</td>
    		</tr>
    		<tr>
    			<td class="toLeft">电话：</td>
    			<td class="toCenter">${PHONE}</td>
    			<td class="toLeft">客户经理：</td>
    			<td class="toCenter">${USERNAME}</td>
    			<td class="toLeft">性别：</td>
    			<td class="toCenter">${SEX}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">年龄：</td>
    			<td class="toCenter">${AGE}</td>
    			<td class="toLeft">生日：</td>
    			<td class="toCenter">${BIRTHDAY}</td>
    			<td class="toLeft">发展日期：</td>
    			<td class="toCenter">${DEVELOP}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">身高：</td>
    			<td class="toCenter">${HEIGHT}</td>
    			<td class="toLeft">体型：</td>
    			<td class="toCenter">${HABITUS}</td>
    			<td class="toLeft">肤色：</td>
    			<td class="toCenter">${SKINCOLOR}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">性格特征：</td>
    			<td class="toCenter">${XGTZ}</td>
    			<td class="toLeft">从事行业：</td>
    			<td class="toCenter">${INDUSTRY}</td>
    			<td class="toLeft">岗位：</td>
    			<td class="toCenter">${JOB}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">Email：</td>
    			<td class="toCenter">${EMAIL}</td>
    			<td class="toLeft">微信号：</td>
    			<td class="toCenter"></td>
    			<td class="toLeft">手机类型：</td>
    			<td class="toCenter">${PHONETYPE}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">客户等级：</td>
    			<td class="toCenter">${VIPLEV}</td>
    			<td class="toLeft">是否大客户：</td>
    			<td class="toCenter">${ISCUSTOMER}</td>
    			<td class="toLeft">方便接听电话时间：</td>
    			<td class="toCenter">${CALLTIME}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">省份：</td>
    			<td class="toCenter">${PROVINCE}</td>
    			<td class="toLeft">城市：</td>
    			<td class="toCenter">${CITY}</td>
    			<td class="toLeft">是否愿意接收短信：</td>
    			<td class="toCenter">${ISRECEVIED}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">地址：</td>
    			<td colspan="6" class="toLeft">${SHIPPINGADDRESS}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">发票地址：</td>
    			<td colspan="6" class="toLeft">${BILLINGADDRESS}</td>
    		</tr>
    	</tbody>
    </table>
    <table id="preferences" cellpadding="0" cellspacing="0">
    	<tbody>
    		<tr class="head">
    			<td colspan="6">会员偏好信息</td>
    		</tr>
    		<tr>
    			<td class="toLeft">个人爱好：</td>
    			<td class="toCenter">${PERSONALHABIT}</td>
    			<td class="toLeft">家庭年收入：</td>
    			<td class="toCenter">${ANNUALREVENUE}</td>
    			<td class="toLeft">消费类型：</td>
    			<td class="toCenter">${XFLX}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">经常消费的品牌：</td>
    			<td class="toCenter">${CONSUMEBRANDS}</td>
    			<td class="toLeft">经常穿着的色系：</td>
    			<td class="toCenter">${DRESSCOLOR}</td>
    			<td class="toLeft">颜色：</td>
    			<td class="toCenter">${COLOR}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">获取品牌的渠道：</td>
    			<td class="toCenter">${CHANNEL}</td>
    			<td class="toLeft">接受的沟通方式：</td>
    			<td class="toCenter">${GTFS}</td>
    			<td class="toLeft">期望收到的惊喜：</td>
    			<td class="toCenter">${EXPECTGIFT}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">喜爱的书籍：</td>
    			<td class="toCenter">${BOOKS}</td>
    			<td class="toLeft">喜爱的杂志：</td>
    			<td class="toCenter">${MAGAZINE}</td>
    			<td class="toLeft">喜爱的电影：</td>
    			<td class="toCenter">${MOVIE}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">喜爱的化妆品：</td>
    			<td class="toCenter">${COSMETIC}</td>
    			<td class="toLeft">喜爱的香水：</td>
    			<td class="toCenter">${PERFUME}</td>
    			<td class="toLeft">喜爱的饮品：</td>
    			<td class="toCenter">${DRINKS}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">喜爱的运动：</td>
    			<td class="toCenter">${SPORTS}</td>
    			<td class="toLeft">美容保健：</td>
    			<td class="toCenter">${MRBJ}</td>
    			<td class="toLeft">美容保健大类：</td>
    			<td class="toCenter">${MRBJDL}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">经常关注的信息：</td>
    			<td class="toCenter">${FOUCSINFO}</td>
    			<td class="toLeft">是否热衷慈善：</td>
    			<td class="toCenter">${CHARITY}</td>
    			<td class="toLeft">是否愿意收到本品牌的信息：</td>
    			<td class="toCenter">${RECEIVEMESSAGE}</td>
    		</tr>
    	</tbody>
    </table>
    <table id="spending" cellpadding="0" cellspacing="0">
    	<tbody>
    		<tr class="head">
    			<td colspan="6">消费信息</td>
    		</tr>
    		<tr>
    			<td class="toLeft">总消费金额：</td>
    			<td class="toCenter">${ZSUMS}</td>
    			<td class="toLeft">总消费次数：</td>
    			<td class="toCenter">${ZNUMS}</td>
    			<td class="toLeft">首单折扣：</td>
    			<td class="toCenter">${FDISCOUNT}</td>
    		</tr>
    		<tr>
    			<td class="toLeft">首单实销金额：</td>
    			<td class="toCenter">${FBUYSUMS}</td>
    			<td class="toLeft">目前POS积分：</td>
    			<td class="toCenter">${POSJF}</td>
    			<td class="toLeft">12个月内消费金额：</td>
    			<td class="toCenter">${SUMS12}</td>
    		</tr>
    	</tbody>
    </table>
    <table id="recently" cellpadding="0" cellspacing="0">
    	<tbody>
    		<tr class="head">
    			<td colspan="5">最近一次消费情况</td>
    		</tr>
    		<tr>
    			<td class="toCenter time">时间</td>
    			<td class="toCenter amount">金额</td>
    			<td class="toCenter nums">件数</td>
    			<td class="toCenter discount">折扣</td>
    			<td rowspan="2" class="toLeft" id="skc">款式：${SKC}</td>
    		</tr>
    		<tr>
    			<td class="toCenter">${LBUYDATE}</td>
    			<td class="toCenter">${LBUYSUMS}</td>
    			<td class="toCenter">${LNUMS}</td>
    			<td class="toCenter">${LDISCOUNT}</td>
    		</tr>
    	</tbody>
    </table>
    <table id="plot" cellpadding="0" cellspacing="0">
    	<tbody>
    		<tr class="head">
    			<td>最近一次消费情节</td>
    		</tr>
    		<tr>
    			<td class="toLeft"></td>
    		</tr>
    	</tbody>
    </table>
    <table id="comparison" cellpadding="0" cellspacing="0">
    	<tbody>
    		<tr class="head">
    			<td colspan="11">同期消费对比</td>
    		</tr>
    		<tr>
    			<td rowspan="2" class="toCenter"></td>
    			<td colspan="2" class="toCenter">一季度</td>
    			<td colspan="2" class="toCenter">二季度</td>
    			<td colspan="2" class="toCenter">三季度</td>
    			<td colspan="2" class="toCenter">四季度</td>
    			<td rowspan="2" class="toCenter">平均折扣</td>
    			<td rowspan="2" class="toCenter">消费次数</td>
    		</tr>
    		<tr>
    			<td class="toCenter">金额</td>
    			<td class="toCenter">件数</td>
    			<td class="toCenter">金额</td>
    			<td class="toCenter">件数</td>
    			<td class="toCenter">金额</td>
    			<td class="toCenter">件数</td>
    			<td class="toCenter">金额</td>
    			<td class="toCenter">件数</td>
    		</tr>
    		<tr>
    			<td class="toCenter">${YEAR1.year}</td>
    			<td class="toCenter">${YEAR1.quarter[0].sums}</td>
    			<td class="toCenter">${YEAR1.quarter[0].nums}</td>
    			<td class="toCenter">${YEAR1.quarter[1].sums}</td>
    			<td class="toCenter">${YEAR1.quarter[1].nums}</td>
    			<td class="toCenter">${YEAR1.quarter[2].sums}</td>
    			<td class="toCenter">${YEAR1.quarter[2].nums}</td>
    			<td class="toCenter">${YEAR1.quarter[3].sums}</td>
    			<td class="toCenter">${YEAR1.quarter[3].nums}</td>
    			<td class="toCenter">${YEAR1.discount}</td>
    			<td class="toCenter">${YEAR1.counts}</td>
    		</tr>
    		<tr>
    			<td class="toCenter">${YEAR2.year}</td>
    			<td class="toCenter">${YEAR2.quarter[0].sums}</td>
    			<td class="toCenter">${YEAR2.quarter[0].nums}</td>
    			<td class="toCenter">${YEAR2.quarter[1].sums}</td>
    			<td class="toCenter">${YEAR2.quarter[1].nums}</td>
    			<td class="toCenter">${YEAR2.quarter[2].sums}</td>
    			<td class="toCenter">${YEAR2.quarter[2].nums}</td>
    			<td class="toCenter">${YEAR2.quarter[3].sums}</td>
    			<td class="toCenter">${YEAR2.quarter[3].nums}</td>
    			<td class="toCenter">${YEAR2.discount}</td>
    			<td class="toCenter">${YEAR2.counts}</td>
    		</tr>
    		<tr>
    			<td class="toCenter">合计：</td>
    			<td class="toCenter">${YEAR3.quarter[0].sumsRateString}</td>
    			<td class="toCenter">${YEAR3.quarter[0].numsRateString}</td>
    			<td class="toCenter">${YEAR3.quarter[1].sumsRateString}</td>
    			<td class="toCenter">${YEAR3.quarter[1].numsRateString}</td>
    			<td class="toCenter">${YEAR3.quarter[2].sumsRateString}</td>
    			<td class="toCenter">${YEAR3.quarter[2].numsRateString}</td>
    			<td class="toCenter">${YEAR3.quarter[3].sumsRateString}</td>
    			<td class="toCenter">${YEAR3.quarter[3].numsRateString}</td>
    			<td class="toCenter">${YEAR3.discount}</td>
    			<td class="toCenter">${YEAR3.counts}</td>
    		</tr>
    	</tbody>
    </table>
    <table id="category" cellpadding="0" cellspacing="0">
    	<tbody>    		
    		<tr class="head">
    			<td colspan="17">消费品类（当前或上季）</td>
    		</tr>
    		<tr>
    			<td rowspan="3" class="toCenter category">春夏品类：</td>
    			<td class="toCenter subcategory">品类：</td>
    			<td class="toCenter">外套</td>
    			<td class="toCenter">衬衫</td>
    			<td class="toCenter">裙子</td>
    			<td class="toCenter">连衣裙</td>
    			<td class="toCenter">针织衫</td>
    			<td class="toCenter">裤子</td>
    			<td class="toCenter">风衣</td>
    			<td class="toCenter">大衣</td>
    			<td class="toCenter">毛衫</td>
    			<td class="toCenter">尼克服</td>
    			<td class="toCenter">皮衣</td>
    			<td class="toCenter">裘皮</td>
    			<td class="toCenter">棉服</td>
    			<td class="toCenter">羽绒服</td>
    			<td class="toCenter">饰品</td>
    		</tr>
    		<tr>
    			<td class="toCenter subcategory">件数：</td>
    			<c:forEach var="i" begin="1" end="15" step="1">
    				<td class="toCenter">${SEASON1[i-1].nums}</td>
    			</c:forEach>
    		</tr>
    		<tr>
    			<td class="toCenter subcategory">全部：</td>
    			<c:forEach var="i" begin="1" end="15" step="1">
    				<td class="toCenter">${SEASON2[i-1].nums}</td>
    			</c:forEach>
    		</tr>
    		<tr>
    			<td rowspan="3" class="toCenter category">秋冬品类：</td>
    			<td class="toCenter subcategory">品类：</td>
    			<td class="toCenter">外套</td>
    			<td class="toCenter">衬衫</td>
    			<td class="toCenter">裙子</td>
    			<td class="toCenter">连衣裙</td>
    			<td class="toCenter">针织衫</td>
    			<td class="toCenter">裤子</td>
    			<td class="toCenter">风衣</td>
    			<td class="toCenter">大衣</td>
    			<td class="toCenter">毛衫</td>
    			<td class="toCenter">尼克服</td>
    			<td class="toCenter">皮衣</td>
    			<td class="toCenter">裘皮</td>
    			<td class="toCenter">棉服</td>
    			<td class="toCenter">羽绒服</td>
    			<td class="toCenter">饰品</td>
    		</tr>
    		<tr>
    			<td class="toCenter subcategory">件数：</td>
    			<c:forEach var="i" begin="1" end="15" step="1">
    				<td class="toCenter">${SEASON3[i-1].nums}</td>
    			</c:forEach>
    		</tr>
    		<tr>
    			<td class="toCenter subcategory">全部：</td>
    			<c:forEach var="i" begin="1" end="15" step="1">
    				<td class="toCenter">${SEASON4[i-1].nums}</td>
    			</c:forEach>
    		</tr>
    	</tbody>
    </table>
    <table id="style" cellpadding="0" cellspacing="0">
    	<tbody>
    		<%
    		List<Style> s1 = (List<Style>)request.getAttribute("STYLE1");
    		List<Style> s2 = (List<Style>)request.getAttribute("STYLE2");
    		List<Style> s3 = (List<Style>)request.getAttribute("STYLE3");
    		int StyleNums1 = 1;
    		int StyleNums2 = 1;
    		int StyleNums3 = 1;
    		
    		if (s1 != null && s1.size() != 0) {
    			StyleNums1 = s1.size();
    		}  		
    		if (s2 != null && s2.size() != 0) {
    			StyleNums2 = s2.size();
    		}
    		if (s3 != null && s3.size() != 0) {
    			StyleNums3 = s3.size();
    		}
    		%>
    		<tr class="head">
    			<td colspan="<%=StyleNums1+StyleNums2+StyleNums3+1%>">消费产品的生活方式</td>
    		</tr>
    		<tr>
    			<td rowspan="2" class="toCenter"></td>
    			<td colspan="<%=StyleNums2%>" class="toCenter">EP</td>
    			<td colspan="<%=StyleNums3%>" class="toCenter">EPJ</td>
    			<td colspan="<%=StyleNums1%>" class="toCenter">E.PROSPER</td>
    		</tr>
    		<tr>
    			<c:forEach var="i" begin="1" end="<%=StyleNums2%>" step="1">
    				<td class="toCenter">${STYLE2[i-1].name}</td>
    			</c:forEach>
    			<c:forEach var="i" begin="1" end="<%=StyleNums3%>" step="1">
    				<td class="toCenter">${STYLE3[i-1].name}</td>
    			</c:forEach>
    			<c:forEach var="i" begin="1" end="<%=StyleNums1%>" step="1">
    				<td class="toCenter">${STYLE1[i-1].name}</td>
    			</c:forEach>
    		</tr>
    		<tr>
    			<td class="toCenter">去年消费</td>
    			<c:forEach var="i" begin="1" end="<%=StyleNums2%>" step="1">
    				<td class="toCenter">${STYLE2[i-1].lastYearNums}</td>
    			</c:forEach>
    			<c:forEach var="i" begin="1" end="<%=StyleNums3%>" step="1">
    				<td class="toCenter">${STYLE3[i-1].lastYearNums}</td>
    			</c:forEach>
    			<c:forEach var="i" begin="1" end="<%=StyleNums1%>" step="1">
    				<td class="toCenter">${STYLE1[i-1].lastYearNums}</td>
    			</c:forEach>
    		</tr>
    		<tr>
    			<td class="toCenter">今年消费</td>
    			<c:forEach var="i" begin="1" end="<%=StyleNums2%>" step="1">
    				<td class="toCenter">${STYLE2[i-1].thisYearNums}</td>
    			</c:forEach>
    			<c:forEach var="i" begin="1" end="<%=StyleNums3%>" step="1">
    				<td class="toCenter">${STYLE3[i-1].thisYearNums}</td>
    			</c:forEach>
    			<c:forEach var="i" begin="1" end="<%=StyleNums1%>" step="1">
    				<td class="toCenter">${STYLE1[i-1].thisYearNums}</td>
    			</c:forEach>
    		</tr>
    		<tr>
    			<td class="toCenter">销售占比</td>
    			<c:forEach var="i" begin="1" end="<%=StyleNums2%>" step="1">
    				<td class="toCenter">${STYLE2[i-1].rateString}</td>
    			</c:forEach>
    			<c:forEach var="i" begin="1" end="<%=StyleNums3%>" step="1">
    				<td class="toCenter">${STYLE3[i-1].rateString}</td>
    			</c:forEach>
    			<c:forEach var="i" begin="1" end="<%=StyleNums1%>" step="1">
    				<td class="toCenter">${STYLE1[i-1].rateString}</td>
    			</c:forEach>
    		</tr>
    	</tbody>
    </table>
    <table id="frequency" cellpadding="0" cellspacing="0">
    	<tbody>
    		<tr class="head">
    			<td colspan="13">顾客消费频率分析</td>
    		</tr>
    		<tr>
    			<td class="toCenter">统计条件</td>
    			<td class="toCenter">1月</td>
    			<td class="toCenter">2月</td>
    			<td class="toCenter">3月</td>
    			<td class="toCenter">4月</td>
    			<td class="toCenter">5月</td>
    			<td class="toCenter">6月</td>
    			<td class="toCenter">7月</td>
    			<td class="toCenter">8月</td>
    			<td class="toCenter">9月</td>
    			<td class="toCenter">10月</td>
    			<td class="toCenter">11月</td>
    			<td class="toCenter">12月</td>
    		</tr>
    		<tr>
    			<td class="toCenter">消费金额</td>
    			<c:forEach var="i" begin="0" end="11" step="1">
    				<td class="toCenter">${FREQUENCY[i].sums}</td>
    			</c:forEach>
    		</tr>
    		<tr>
    			<td class="toCenter">消费次数</td>
    			<c:forEach var="i" begin="0" end="11" step="1">
    				<td class="toCenter">${FREQUENCY[i].counts}</td>
    			</c:forEach>
    		</tr>
    	</tbody>
    </table>
    <table id="ready" cellpadding="0" cellspacing="0">
    	<tbody>
    		<tr class="head">
    			<td colspan="6">顾客到店前的准备</td>
    		</tr>
    		<tr>
    			<td rowspan="2" class="toLeft title" id="skc">准备：</td>
    			<td class="toCenter time">时间</td>
    			<td class="toCenter amount">金额</td>
    			<td class="toCenter nums">件数</td>
    			<td class="toCenter discount">折扣</td>
    			<td rowspan="2" class="toLeft" id="skc">款式：</td>
    		</tr>
    		<tr>
    			<td class="toCenter"></td>
    			<td class="toCenter"></td>
    			<td class="toCenter"></td>
    			<td class="toCenter"></td>
    		</tr>
    		<tr>
    			<td rowspan="2" class="toLeft title" id="skc">购买：</td>
    			<td class="toCenter time">时间</td>
    			<td class="toCenter amount">金额</td>
    			<td class="toCenter nums">件数</td>
    			<td class="toCenter discount">折扣</td>
    			<td rowspan="2" class="toLeft" id="skc">款式：</td>
    		</tr>
    		<tr>
    			<td class="toCenter"></td>
    			<td class="toCenter"></td>
    			<td class="toCenter"></td>
    			<td class="toCenter"></td>
    		</tr>
    	</tbody>
    </table>
    <table id="communication" cellpadding="0" cellspacing="0">
    	<tbody>
    		<tr class="head">
    			<td colspan="4">沟通记录（最近5次的沟通记录）</td>
    		</tr>
    		<tr>
    			<td class="toCenter date">维护时间</td>
    			<td class="toCenter mode">沟通方式</td>
    			<td class="toCenter content">维护内容</td>
    			<td class="toCenter feedback">顾客反馈</td>
    		</tr>
    		<c:forEach var="i" begin="1" end="5" step="1">
    			<tr>
	    			<td class="toCenter">${COMMUNICATION[i-1].date}</td>
	    			<td class="toCenter">${COMMUNICATION[i-1].mode}</td>
	    			<td class="toCenter">${COMMUNICATION[i-1].content}</td>
	    			<td class="toCenter">${COMMUNICATION[i-1].feedback}</td>
	    		</tr>
    		</c:forEach>
    	</tbody>
    </table>
  </body>
</html>
