<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportTalent.aspx.cs" Inherits="Talent.Web.TalentInfo.ReportTalent" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http：//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http：//www.w3.org/1999/xhtml">
<head>
    <title>导出</title>
    <style type="text/css">
        table td
        {
          padding-left:5px; 
            }
    </style>
</head>
<body>
    <h2 style=" text-align:center">人才信息</h2>
    <table border=1 cellSpacing=0 cellPadding=0 width="100%" style="line-height:1.5  ;font-size:14px;margin-top:5.25px;border-collapse:collapse;" bordercolor="#333333">
        <tr style="height:25px;">
            <td width="20%">公司名称：</td>
            <td width="30%"><%=model.CB_Name %></td>
            <td width="20%">公司人数：</td>
            <td width="30%"><%=model.CB_Num %></td>
        </tr>
        <tr style="height:25px;">
            <td>公司所在地：</td>
            <td><%=model.CB_Position %></td>
            <td>华之毅品牌：</td>
            <td><%=model.CB_Province %></td>
        </tr>
        <tr style="height:25px;">
            <td>成立时间：</td>
            <td colspan=3 ><%=model.CB_SetUp %></td>
        </tr>
        <tr style="height:25px;">
            <td>上年度销售额：</td>
            <td><%=model.CB_Je %></td>
            <td>工厂规模：</td>
            <td><%=model.CB_Scale %></td>
        </tr>
        <tr style="height:25px;">
            <td>品牌名称：</td>
            <td><%=model.CB_BrandName %></td>
            <td>品牌风格：</td>
            <td><%=model.CB_BrandStyle %></td>
        </tr>
        <tr style="height:25px;">
            <td>品牌价格区间：</td>
            <td><%=model.CB_PriceSection %></td>
            <td>擅长品类：</td>
            <td><%=model.CB_Category %></td>
        </tr>
        <tr style="height:25px;">
            <td>经营方式：</td>
            <td><%=model.CB_ModeOperation %></td>
            <td>店铺数量：</td>
            <td><%=model.CB_ShopNum %></td>
        </tr>
        <tr style="height:100px;">
            <td>竞品信息描述：</td>
            <td colspan=3 ><%=model.CB_Des%></td>
        </tr>
        <tr style="height:25px;">
            <td>人才类别：</td>
            <td colspan=3 > <%=selectstr %></td>
        </tr>
        <tr style="height:100px;">
            <td>创始人介绍：</td>
            <td colspan=3 ><%=model.CB_Founder%></td>
        </tr>
        <tr style="height:100px;">
            <td>企业或品牌优势：</td>
            <td colspan=3 ><%=model.CB_Advantage%></td>
        </tr>
        <tr style="height:100px;">
            <td>企业组织架构：(含单个部门的架构,如设计\研发技术\销售\人资等)：</td>
            <td colspan=3 ><%=model.CB_OrgStructure%></td>
        </tr>
        <tr style="height:100px;">
            <td>人力资源政策（包含薪酬、福利、培训、员工关怀等）：</td>
            <td colspan=3 ><%=model.CB_HumanSrc%></td>
        </tr>
    </table>
</body>
</html>
