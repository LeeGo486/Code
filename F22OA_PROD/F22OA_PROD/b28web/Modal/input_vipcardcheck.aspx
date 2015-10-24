<%@ page language="C#" autoeventwireup="true" inherits="b28web_Modal_input_vipcardcheck, App_Web_input_vipcardcheck.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>老V带新V</title>
    <link href="../../css/default.css" rel="stylesheet" type="text/css" />
    <script src="../../jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../../jquery/jquery.json-2.2.min.js" type="text/javascript"></script>
    <script src="../Utility/jquery.blockUI.js" type="text/javascript"></script>
    <script src="../../jquery/common.js" type="text/javascript"></script>
    <script src="../../jquery/jquery.hotkeys.js" type="text/javascript"></script>
    <script src="Scripts/input_vipcardcheck.js" type="text/javascript"></script>
</head>
<body>
    <input type="hidden" id="id" value="" />
    <input type="hidden" id="tbname" value="" />
    <form id="form1" runat="server">
    <div id="BottomPane">
        <div id="queryTable">
            <div style="width: 360px; height: 160px; margin: 15px auto auto auto; text-align: center;
                border: 1px solid #ddd">
                <div style="margin-top: 10px;">
                    <label>
                        老VIP顾客卡号：</label>
                    <input type="text" id="txtvipcode" name="txtvipcode" style="width: 180px" cssclass="input" />
                    <span style="color: Red">*</span>
                </div>
                <div style="padding-top: 15px;">
                    <label>
                        老VIP顾客手机：</label>
                    <input type="text" id="txtmobtel" name="txtmobtel" style="width: 180px" cssclass="input" />
                    <span style="color: Red">*</span>
                </div>
                <div style="padding-top: 15px;">
                    <span style="margin-left: -15px;">老VIP顾客姓名： </span>
                    <input type="text" id="txtvipname" name="txtvipname" style="width: 180px;
                        border: 0px" disabled="disabled" />
                </div>
                <div style="text-align: right; padding-top: 20px; padding-right: 50px">
                    <input type="button" id="btnsubmit" value="确  定" style="width: 90px" />
                    <input type="button" id="btnclose" value="关  闭" style="width: 90px" onclick="window.returnValue = ''; window.close();" />
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
