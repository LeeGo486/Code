<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintTag.aspx.cs" Inherits="PrintTag" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>打印吊牌</title>
    <style type="text/css">
        body {
            font-size: 12px;
        }

        .Mt {
            border-collapse: collapse;
        }

            .Mt tr {
                border: 1px solid #C0C0C0;
                border-collapse: collapse;
            }


            .Mt th {
                border: 1px solid #C0C0C0;
                background-color: #EEE;
                border-collapse: collapse;
                font-weight: normal;
                width: 60px;
            }

            .Mt td {
                padding: 8px;
                border: 1px solid #C0C0C0;
                border-collapse: collapse;
                height: 25px;
            }

        input {
            border: 1px solid #CCC;
            padding: 3px;
            width: 100px;
        }
    </style>
    <script language="javascript" src="Scripts/LodopFuncs.js"></script>
    <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0">
        <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="install_lodop32.exe"></embed>
    </object>
    <script type="text/javascript">
        function PrintCodeBarNew(size,clothingid){
            //获取数据
            var gbk = document.getElementById("<%= TxtGBK.ClientID %>").value;
            var price = document.getElementById("<%= lbdprice.ClientID %>").innerText;
            var safetype = document.getElementById("<%= TxtSafeType.ClientID %>").value;
            var dotype = document.getElementById("<%= TxtDoType.ClientID %>").value;
            var brand = document.getElementById("<%= lbBrand.ClientID %>").innerText;
            var production = document.getElementById("<%= lbCd.ClientID %>").innerText; 
            var grade = document.getElementById("<%= TxtGrade.ClientID %>").value; 
            var color = document.getElementById("<%= lbColor.ClientID %>").innerText;
            var sname = document.getElementById("<%= lbPinM.ClientID %>").innerText;
            var cf = document.getElementById("<%= lbcf.ClientID %>").innerText;
            var oldstyleid=document.getElementById("<%= TxtOldStyleID.ClientID %>").value;

            LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
            LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");
            /*
            LODOP.PRINT_INITA("0mm", "0mm", "70mm", "25mm", "HZY");
            //LODOP.PRINT_INIT("套打EMS的模板");            
            LODOP.SET_PRINT_PAGESIZE(0, 480, 672.8, "");
            LODOP.ADD_PRINT_TEXT("1.3mm", "17.9mm", "13mm", "5.3mm", "合格证");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "Bold", 1);
            LODOP.ADD_PRINT_TEXT("61.9mm", "1mm", "46mm", "6.6mm", "经销商:浙江雅斓商业地产管理有限公司\n浙江省嘉兴市秀洲区昌盛中路2029号1号楼1楼");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_BARCODE("54.2mm", "2.5mm", "39.4mm", "6.6mm", "Code93", clothingid);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 5);
            LODOP.SET_PRINT_STYLEA(0, "Horient", 3);
            LODOP.ADD_PRINT_BARCODE("47.4mm", "8.9mm", "24.6mm", "6.1mm", "EAN13", gbk);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 4);
            LODOP.ADD_PRINT_RECT("43.4mm", "4.4mm", "33.3mm", "3.4mm", 0, 1);
            LODOP.ADD_PRINT_TEXT("43.7mm", "4.6mm", "32.8mm", "3.7mm", "RMB " + price);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
            LODOP.SET_PRINT_STYLEA(0, "Bold", 1);
            LODOP.ADD_PRINT_TEXT("5.8mm", "2.8mm", "14.3mm", "5.3mm", "安全类别：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("5.8mm", "14.7mm", "33.1mm", "5.3mm", safetype);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("9mm", "2.8mm", "14.3mm", "5.3mm", "执行标准：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("8.7mm", "14.7mm", "33.1mm", "5.3mm", dotype);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("12.2mm", "2.8mm", "9.5mm", "5.3mm", "品牌：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("12.2mm", "25.7mm", "10.6mm", "5.3mm", "产地：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("12.2mm", "9.7mm", "18.5mm", "5.3mm", brand);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("12.2mm", "32.5mm", "13.2mm", "5.3mm", production);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("15.3mm", "2.8mm", "9.5mm", "5.3mm", "品名：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("15.3mm", "9.7mm", "38.6mm", "5.3mm", sname);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("18.5mm", "2.8mm", "10.1mm", "5.3mm", "货号：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("18.5mm", "9.7mm", "38.4mm", "5.3mm", clothingid);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("21.7mm", "2.8mm", "10.1mm", "5.3mm", "颜色：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("21.7mm", "9.7mm", "18.5mm", "5.3mm", color);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("21.7mm", "25.4mm", "10.3mm", "5.3mm", "尺码：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("21.7mm", "32.5mm", "13.2mm", "5.3mm", size);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            //等级
            LODOP.ADD_PRINT_TEXT("18.5mm","25.4mm","10.3mm","5.3mm","等级：");
            LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
            LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
            LODOP.ADD_PRINT_TEXT("18.5mm","32.5mm","13.2mm","5.3mm",grade);
            LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
            LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
            //成分
            LODOP.ADD_PRINT_TEXT("28.1mm","2.7mm","45.2mm","10.3mm",cf);
            LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
            LODOP.SET_PRINT_STYLEA(0,"FontSize",6);

            LODOP.ADD_PRINT_TEXT(94,9,38,20,"旧款号:");
            LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
            LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
            LODOP.ADD_PRINT_TEXT(94,41,141,20,oldstyleid);
            LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
            LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
            
            //LODOP.PREVIEW();
            LODOP.PRINT_DESIGN();*/

            LODOP.PRINT_INITA("0mm","0mm","70.1mm","34.4mm","HZY");
LODOP.ADD_PRINT_TEXT("6.6mm","23.8mm","46mm","6.6mm","经销商:浙江雅斓商业地产管理有限公司\n浙江省嘉兴市秀洲区昌盛中路2029号1号楼1楼");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_BARCODE("12.7mm","38.9mm","26.7mm","6.6mm","Code93",clothingid);
LODOP.SET_PRINT_STYLEA(0,"FontSize",5);
LODOP.SET_PRINT_STYLEA(0,"Horient",3);
LODOP.ADD_PRINT_BARCODE("0.5mm","40.7mm","24.6mm","6.1mm","EAN13",gbk);
LODOP.SET_PRINT_STYLEA(0,"FontSize",4);
LODOP.ADD_PRINT_RECT("20.9mm","39.7mm","22.5mm","3.4mm",0,1);
LODOP.ADD_PRINT_TEXT("21.4mm","33.6mm","32.8mm","3.7mm","RMB "+price);
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
LODOP.SET_PRINT_STYLEA(0,"Bold",1);
LODOP.ADD_PRINT_TEXT("14.6mm","-0.3mm","13mm","5.3mm","安全类别:");
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("14.6mm","10.1mm","18.5mm","5.3mm",safetype);
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("17.5mm","-0.3mm","14.3mm","5.3mm","执行标准:");
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("17.5mm","10.1mm","21.7mm","5.3mm",dotype);
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("3.7mm","14.6mm","7.9mm","5.3mm","产地:");
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("0.5mm","0.3mm","24.6mm","5.3mm",brand);
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("3.7mm","19.8mm","14.8mm","5.3mm",production);
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("3.7mm","0mm","9.5mm","5.3mm","品名:");
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("3.7mm","5.6mm","8.5mm","5.3mm",sname);
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("8.7mm","0mm","8.7mm","5.3mm","货号:");
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("8.7mm","5.6mm","20.1mm","5.3mm",clothingid);
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("6.1mm","14.6mm","7.7mm","5.3mm","尺码:");
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("6.1mm","19.8mm","6.6mm","5.3mm",size);
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("6.1mm","0mm","7.7mm","5.3mm","等级:");
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("6.1mm","5.6mm","10.6mm","5.3mm",grade);
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("20.4mm","-0.5mm","39.7mm","13.5mm","成分:"+cf);
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT(44,-1,38,20,"旧款号:");
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
LODOP.ADD_PRINT_TEXT("11.6mm","7.7mm","31mm","5.3mm",oldstyleid);
LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
LODOP.SET_PRINT_STYLEA(0,"FontSize",6);


            LODOP.PREVIEW();
        }
        function PrintCodeBar(size,clothingid) {
            //获取数据
            var gbk = document.getElementById("<%= TxtGBK.ClientID %>").value;
            var price = document.getElementById("<%= lbdprice.ClientID %>").innerText;
            var safetype = document.getElementById("<%= TxtSafeType.ClientID %>").value;
            var dotype = document.getElementById("<%= TxtDoType.ClientID %>").value;
            var brand = document.getElementById("<%= lbBrand.ClientID %>").innerText;
            var production = document.getElementById("<%= lbCd.ClientID %>").innerText; 
            var grade = document.getElementById("<%= TxtGrade.ClientID %>").value; 
            var color = document.getElementById("<%= lbColor.ClientID %>").innerText;
            var sname = document.getElementById("<%= lbPinM.ClientID %>").innerText;
            var cf = document.getElementById("<%= lbcf.ClientID %>").innerText;
            var oldstyleid=document.getElementById("<%= TxtOldStyleID.ClientID %>").value;

            LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
            LODOP.PRINT_INITA("0mm", "0mm", "47.6mm", "74.1mm", "HZY");
            //LODOP.PRINT_INIT("套打EMS的模板");
            LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");
            LODOP.SET_PRINT_PAGESIZE(0, 480, 672.8, "");
            LODOP.ADD_PRINT_TEXT("1.3mm", "17.9mm", "13mm", "5.3mm", "合格证");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "Bold", 1);
            LODOP.ADD_PRINT_TEXT("61.9mm", "1mm", "46mm", "6.6mm", "经销商:浙江雅斓商业地产管理有限公司\n浙江省嘉兴市秀洲区昌盛中路2029号1号楼1楼");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_BARCODE("54.2mm", "2.5mm", "39.4mm", "6.6mm", "Code93", clothingid);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 5);
            LODOP.SET_PRINT_STYLEA(0, "Horient", 3);
            LODOP.ADD_PRINT_BARCODE("47.4mm", "8.9mm", "24.6mm", "6.1mm", "EAN13", gbk);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 4);
            LODOP.ADD_PRINT_RECT("43.4mm", "4.4mm", "33.3mm", "3.4mm", 0, 1);
            LODOP.ADD_PRINT_TEXT("43.7mm", "4.6mm", "32.8mm", "3.7mm", "RMB " + price);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
            LODOP.SET_PRINT_STYLEA(0, "Bold", 1);
            LODOP.ADD_PRINT_TEXT("5.8mm", "2.8mm", "14.3mm", "5.3mm", "安全类别：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("5.8mm", "14.7mm", "33.1mm", "5.3mm", safetype);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("9mm", "2.8mm", "14.3mm", "5.3mm", "执行标准：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("8.7mm", "14.7mm", "33.1mm", "5.3mm", dotype);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("12.2mm", "2.8mm", "9.5mm", "5.3mm", "品牌：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("12.2mm", "25.7mm", "10.6mm", "5.3mm", "产地：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("12.2mm", "9.7mm", "18.5mm", "5.3mm", brand);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("12.2mm", "32.5mm", "13.2mm", "5.3mm", production);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("15.3mm", "2.8mm", "9.5mm", "5.3mm", "品名：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("15.3mm", "9.7mm", "38.6mm", "5.3mm", sname);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("18.5mm", "2.8mm", "10.1mm", "5.3mm", "货号：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("18.5mm", "9.7mm", "38.4mm", "5.3mm", clothingid);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("21.7mm", "2.8mm", "10.1mm", "5.3mm", "颜色：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("21.7mm", "9.7mm", "18.5mm", "5.3mm", color);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("21.7mm", "25.4mm", "10.3mm", "5.3mm", "尺码：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("21.7mm", "32.5mm", "13.2mm", "5.3mm", size);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            //等级
            LODOP.ADD_PRINT_TEXT("18.5mm","25.4mm","10.3mm","5.3mm","等级：");
            LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
            LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
            LODOP.ADD_PRINT_TEXT("18.5mm","32.5mm","13.2mm","5.3mm",grade);
            LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
            LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
            //成分
            LODOP.ADD_PRINT_TEXT("28.1mm","2.7mm","45.2mm","10.3mm",cf);
            LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
            LODOP.SET_PRINT_STYLEA(0,"FontSize",6);

            LODOP.ADD_PRINT_TEXT(94,9,38,20,"旧款号:");
            LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
            LODOP.SET_PRINT_STYLEA(0,"FontSize",6);
            LODOP.ADD_PRINT_TEXT(94,41,141,20,oldstyleid);
            LODOP.SET_PRINT_STYLEA(0,"FontName","黑体");
            LODOP.SET_PRINT_STYLEA(0,"FontSize",6);


            
            /*
            LODOP.SET_PRINT_PAGESIZE(0, 480, 780, "");
            LODOP.ADD_PRINT_TEXT("1.3mm", "63.9mm", "13mm", "5.3mm", "合格证");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "Bold", 1);
            LODOP.ADD_PRINT_TEXT("61.9mm", "48mm", "46mm", "6.6mm", "经销商:浙江雅澜商业地产管理有限公司\n浙江省嘉兴市秀洲区昌盛中路2029号1号楼1楼");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_BARCODE("54.2mm", "48.5mm", "39.4mm", "6.6mm", "Code93", clothingid);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 5);
            LODOP.SET_PRINT_STYLEA(0, "Horient", 3);
            //LODOP.ADD_PRINT_BARCODE("47.4mm", "54.9mm", "24.6mm", "6.1mm", "EAN13", gbk);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 4);
            LODOP.ADD_PRINT_RECT("43.4mm", "50.4mm", "33.3mm", "3.4mm", 0, 1);
            LODOP.ADD_PRINT_TEXT("43.7mm", "50.6mm", "32.8mm", "3.7mm", "RMB " + price);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
            LODOP.SET_PRINT_STYLEA(0, "Bold", 1);
            LODOP.ADD_PRINT_TEXT("5.8mm", "48.8mm", "14.3mm", "5.3mm", "安全类别：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("5.8mm", "60.7mm", "33.1mm", "5.3mm", safetype);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("9mm", "48.8mm", "14.3mm", "5.3mm", "执行标准：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("8.7mm", "60.7mm", "33.1mm", "5.3mm", dotype);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("12.2mm", "48.8mm", "9.5mm", "5.3mm", "品牌：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("12.2mm", "73.7mm", "10.6mm", "5.3mm", "产地：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("12.2mm", "55.7mm", "18.5mm", "5.3mm", brand);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("12.2mm", "80.5mm", "13.2mm", "5.3mm", production);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("15.3mm", "48.8mm", "9.5mm", "5.3mm", "品名：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("15.3mm", "55.7mm", "38.6mm", "5.3mm", sname);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("18.5mm", "48.8mm", "10.1mm", "5.3mm", "货号：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("18.5mm", "55.7mm", "38.4mm", "5.3mm", clothingid);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("21.7mm", "48.8mm", "10.1mm", "5.3mm", "颜色：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("21.7mm", "55.7mm", "18.5mm", "5.3mm", color);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("21.7mm", "73.4mm", "10.3mm", "5.3mm", "尺码：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("21.7mm", "80.5mm", "13.2mm", "5.3mm", size);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("25.4mm", "48.8mm", "10.1mm", "5.3mm", "校验：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("25.4mm", "73.4mm", "10.3mm", "5.3mm", "等级：");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("25.1mm", "80.5mm", "13.2mm", "5.3mm", grade);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.ADD_PRINT_TEXT("29.4mm", "48.5mm", "45.2mm", "11.6mm", cf);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
            LODOP.SET_PRINT_PAGESIZE(0, "100mm", "78mm", "");
            */

            LODOP.PREVIEW();
            //LODOP.PRINT_DESIGN();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <p align="center">
            <asp:Label ID="lbInfo" runat="server" ForeColor="Red"></asp:Label></p>
        <table class="Mt" align="center">
            <tr>
                <th>款式编号：</th>
                <td>
                    <asp:TextBox ID="TxtStyleId" runat="server"></asp:TextBox>
                </td>
                <th>颜色编号：</th>
                <td>
                    <asp:TextBox ID="TxtColorId" runat="server"></asp:TextBox>
                </td>
                <td colspan="4">
                    <asp:Button ID="BtnSearch" runat="server" Text="查 询" OnClick="BtnSearch_Click" />
                    <asp:TextBox ID="TxtOldStyleID" Style="display: none;" runat="server"></asp:TextBox>
                    &nbsp;</td>
            </tr>
            <tr>
                <th>品牌：</th>
                <td>
                    <asp:Label ID="lbBrand" runat="server"></asp:Label>
                </td>
                <th>产地：</th>
                <td>
                    <asp:Label ID="lbCd" runat="server"></asp:Label>
                </td>
                <th>品名：</th>
                <td>
                    <asp:Label ID="lbPinM" runat="server"></asp:Label>
                </td>
                <th>颜色：</th>
                <td>
                    <asp:Label ID="lbColor" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th>吊牌价：</th>
                <td>
                    <asp:Label ID="lbdprice" runat="server"></asp:Label>
                </td>
                <th>成分：</th>
                <td colspan="5">
                    <asp:Label ID="lbcf" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="8">国标码信息</td>
            </tr>
            <tr>
                <th class="auto-style1">安全类别：</th>
                <td class="auto-style1">
                    <asp:TextBox ID="TxtSafeType" runat="server"></asp:TextBox>
                </td>
                <th class="auto-style1">执行标准：</th>
                <td class="auto-style1">
                    <asp:TextBox ID="TxtDoType" runat="server"></asp:TextBox>
                </td>
                <th class="auto-style1">等级：</th>
                <td class="auto-style1">
                    <asp:TextBox ID="TxtGrade" runat="server"></asp:TextBox>
                </td>
                <th class="auto-style1">检验：</th>
                <td class="auto-style1">
                    <asp:TextBox ID="TxtCheck" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>国标码：</th>
                <td>
                    <asp:TextBox ID="TxtGBK" runat="server" ReadOnly="True"></asp:TextBox>
                </td>
                <td colspan="6">
                    <asp:Button ID="BtnSave" runat="server" Text="保 存" OnClick="BtnSave_Click" /></td>
            </tr>
            <tr>
                <td colspan="8">款式尺码</td>
            </tr>
            <tr>
                <td colspan="8" align="center">
                    <table>
                        <tr>
                            <th>尺码</th>
                            <th>打印吊牌</th>
                        </tr>
                        <asp:Repeater ID="RPSize" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("SizeId").ToString() %></td>
                                    <td>
                                        <input type="button" onclick="PrintCodeBar('<%# Eval("SizeId").ToString() %>','<%# Eval("ClothingId").ToString() %>');" value="打印（竖）" />
                                        <input type="button" onclick="PrintCodeBarNew('<%# Eval("SizeId").ToString() %>','<%# Eval("ClothingId").ToString() %>');" value="打印（横）" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
