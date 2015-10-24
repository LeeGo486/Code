<%@ page language="C#" autoeventwireup="true" inherits="b28web_Modal_retail_vipcentumrevise, App_Web_retail_vipcentumrevise.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>调整老V带新V卡号</title>
    <link href="../../css/default.css" rel="stylesheet" type="text/css" />
    <script src="../../jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../../jquery/jquery.json-2.2.min.js" type="text/javascript"></script>
    <script src="../Utility/jquery.blockUI.js" type="text/javascript"></script>
    <script src="../../jquery/common.js" type="text/javascript"></script>
    <script src="../../jquery/jquery.hotkeys.js" type="text/javascript"></script>
    <script src="Scripts/retail_vipcentumrevise.js" type="text/javascript"></script>
    <script src="../../js/project.js" type="text/javascript"></script>
</head>
<body>
    <input type="hidden" id="id" value="" />
    <input type="hidden" id="tbname" value="" />
    <form id="form1" runat="server">
    <div id="BottomPane">
        <div id="queryTable">
            <div style="margin: 150px auto; width: 480px; height: 200px; text-align: center;
                padding: 15px; border: 1px solid #ddd">
                <div style="margin-top: 30px;">
                    <label>
                        零售单据号：</label>
                    <input type="text" id="txtretailid" name="txtretailid" style="width: 180px" cssclass="input" />
                    <span style="color: Red">*</span>
                </div>
                <div style="padding-top: 15px;">
                    <label>
                        原老V卡号：</label>
                    <input type="text" id="txtvipcode" name="txtvipcode" style="width: 180px" cssclass="input" />
                    <span style="color: Red">*</span>
                </div>
                <div style="padding-top: 15px;">
                    <label>
                        现老V卡号：</label>
                    <input type="text" id="txtnewvipcode" name="txtnewvipcode" style="width: 180px" cssclass="input" />
                    <span style="color: Red">*</span>
                </div>
                <div style="text-align: right; padding-top: 20px; padding-right: 80px">
                    <input type="button" id="btnsubmit" value="确   定" style="width: 90px" />
                    <input type="button" id="btncancel" value="取  消" style="width: 90px"  />                 
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
