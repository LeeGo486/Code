<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML><HEAD><TITLE>系统集合</TITLE>
<META HTTP-EQUIV="Content-Type" Content="text/html; charset=utf-8">
<script type="text/javascript" src="/HzyHelper.js"></script>
<script type="text/javascript" src="md5.js"></script>
<STYLE type="text/css">
  body{
	margin:0px;
	padding:10px;
	font-size:12px;
	font-family:"微软雅黑",Arial;
  }
  .classify{
	width:98px;
	height:126px;
	text-align:center;
	font-size:14px;
  }
  img{
	border:0px solid #fff;
  }
  td{
	border:1px solid #fff;
  }
  td:hover{
  background-color:#efefef;
  border:1px solid #ccc;
  }
  a {
            color: #666666;
            text-decoration: none;
        }

            a:hover {
                color: #FF0000;
                text-decoration: none;
            }

            a:active {
                color: #FF0000;
                text-decoration: none;
            }

</STYLE>
<script type="text/javascript">
	function getParam(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if (r != null) return unescape(r[2]); return "/";
    }
</script>
</HEAD>
<BODY>
	<table align="left">
		
		<tr>
			<td>
				<div class="classify">
			  <a href="javascript:void(0);" onclick="window.open('http://192.168.0.92/ebsoft/autologin.html?u='+getParam('uid')+'&p='+hex_md5(getParam('pwd'))+'&zt='+getParam('zt'));">
			   <img src="icons/销售日报.png" />
					销售日报
				</a>
				</div>
			</td>
			<td>
				<div class="classify">
			  <a href="javascript:void(0);" onclick="window.open('/DRP_Plugin/ReportMakeSKU.aspx');">
			   <img src="icons/客订查询.png" />
					客订查询
				</a>
				</div>
			</td>			
			<td>
				<div class="classify">
			   <a href="javascript:void(0);" onclick="window.open('http://192.168.0.160/login.aspx?userid='+getParam('zt')+getParam('uid')+'&password='+getParam('pwd'));">
			   <img src="icons/形象品.png" />
					形象品&费用
				</a>
				</div>
			</td>
			<td>
				<div class="classify">
			   <a href="javascript:void(0);" onclick="window.open('http://192.168.0.125/WEB/Base/LoginAndRedirect.html?EnvID=HZY_SBS&UserName='+getParam('uid')+'&PassWord='+hex_md5(getParam('pwd'))+'&&URL=../base/main.html?openmenu=/WEB/Tag/Tag_Apply.HTML');">
			   <img src="icons/吊牌申请.png" />
					吊牌打印申请
				</a>
				</div>
			</td>	

		</tr>
		
		<tr>

				<td>
				<div class="classify">
			   <a href="javascript:void(0);" onclick="window.open('http://192.168.0.125/WEB/Base/LoginAndRedirect.html?EnvID=HZY_SBS&UserName='+getParam('uid')+'&PassWord='+hex_md5(getParam('pwd'))+'&URL=../Mat/Mat_bill.html?vexmenuid=153');">
			   <img src="icons/店铺维修.png" />
					店铺维修
				</a>
				</div>
			</td>	
			<td>
				<div class="classify">
			   <a href="javascript:void(0);" onclick="window.open('http://192.168.0.125/WEB/Base/LoginAndRedirect.html?EnvID=HZY_SBS&UserName='+getParam('uid')+'&PassWord='+hex_md5(getParam('pwd'))+'&URL=../base/main.html?openmenu=/WEB/Inventory/Inventory_Apply.HTML');">
			   <img src="icons/盘亏赔偿申请.png" />
					盘亏赔偿申请
				</a>
				</div>
			</td>	

			<td>
				<div class="classify">
			   <a href="javascript:void(0);" onclick="window.open('http://192.168.0.43/epclomaintenance/index.jsp?userID='+getParam('uid')+'&pwd='+getParam('pwd'));">
			   <img src="icons/成衣维修.png" />
					成衣维修
				</a>
				</div>
			</td>

			<td>
				<div class="classify">
			   <a href="javascript:void(0);" onclick="window.open('http://192.168.0.35/PE_OA/WEB/PE_OA/HR/login_hr.html?type=pos&shopcode='+getParam('depotid'));">
			   <img src="icons/EHR.png" />
					EHR辅助系统
				</a>
				</div>
			</td>	

		</tr>	
		<tr>
			<td>
				<div class="classify">
			   <a href="javascript:void(0);" onclick="window.open('http://192.168.0.38/PreSell/Index?userid='+getParam('uid'));">
			   <img src="icons/预售款.png" />
					预售款
				</a>
				</div>
			</td>	
			<td>
				<div class="classify">
			   <a href="javascript:void(0);" onclick="window.open('http://192.168.0.125/CMT/WEB/Base/LoginAndRedirect.html?EnvID=HZY_SBS&UserName='+getParam('uid')+'&PassWord='+hex_md5(getParam('pwd'))+'&&URL=../base/main.html?openmenu=/WEB/CMT/Feedback.HTML');">
			   <img src="icons/顾客细分管控.png" />
					顾客细分管控
				</a>
				</div>
                        </td>
	                <td>
                               <div class="classify">
			   <a href="javascript:void(0);" onclick="window.open('http://192.168.0.125/WEB/Base/LoginAndRedirect.html?EnvID=HZY_SBS&UserName='+getParam('uid')+'&PassWord='+hex_md5(getParam('pwd'))+'&&URL=../base/main.html?openmenu=/WEB/SBS/percentageDistribution.html');">
			   <img src="icons/导购提成分配.png" />
					导购提成分配
				</a>
				</div>
			</td>		
		</tr>
	</table>
</BODY>
</HTML>
