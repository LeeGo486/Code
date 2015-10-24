//Emotion_Part Start
var YuZiCellWidth = 20;
var YuZiCellHeight = 20;
var YuZiRowNum = 4;
var YuZiColNum = 9;
var YuZiCurTab = 0;
var YuZiCurPage = 0;
var YuZiShowWidth = 75;
var YuZiShowHeight = 75;
var YuZiSnapThumb = 0; 				//需要截取缩略图时候，把这个改为1
var YuZiCustomSizeLock = 1; 		//是否开启自定义大小


var XmlDom = GetXmlDom();
XmlDom.async = false;
XmlDom.load("Editor/Emotion.XML");
var XmlDomRoot = XmlDom.documentElement;
EmotionNode = XmlDomRoot.getElementsByTagName('Emotion');


var YuZiTabs = EmotionNode.length	//表情——组数

var gbMoNeedHidden = false;

function Gel(id, obj) {
	obj = (obj == null ? document : obj);
	return obj.getElementById(id);
}

function BbsxpCalcCurPages() {//每组表情页数
	var iDLen = EmotionNode[YuZiCurTab].getElementsByTagName('ICON').length;		//每组表情数
	
	var iPLen = YuZiRowNum * YuZiColNum;
	var fv = iDLen / iPLen;
	if (iDLen % iPLen == 0) {
		return fv == 0 ? 1 : parseInt(fv);
	}
	else {
		return Math.round(fv + 0.5);
	}
}

function BbsxpJustifyImg(oImg, iWidth, iHeight, bPos) {//单元格表情按比例缩放
	var oNewImg = new Image();
	oNewImg.src = oImg.src;
	
	var w = oNewImg.width;
	var h = oNewImg.height;
	var wb = w / iWidth;
	var hb = h / iHeight;

	if (wb > 1 || hb > 1) {//等比例缩少
		if (wb > hb) {
			oImg.width = iWidth;
			oImg.height = h * iHeight / w;
		}
		else {
			oImg.width = w * iWidth / h;
			oImg.height = iHeight;
		}
		h = oImg.height;
	}
	else {
		oImg.width = w;
		oImg.height = h;
	}

	if (bPos) {
		oImg.style.top = ((iHeight - h) / 2) + "px";
	}

	return;
}

function EmotionHidePanel() {
	try{
		if (gbMoNeedHidden) {
			Gel("moShowPanel").style.display = "none";
		}
	}catch(e){}
}

function BbsxpEmotionShow(sUrl, iOffset, oldObj) {
	var obj = Gel("moShowPanel");
	if (sUrl == null || sUrl == "") {
		gbMoNeedHidden = true;
		setTimeout("EmotionHidePanel()", 300);
	}
	else if (EmotionCurObj == oldObj){
		gbMoNeedHidden = false;
		var div = Gel("moDivContainer");
		obj.style.top = parseInt(div.offsetTop) + "px";
		if (iOffset < YuZiColNum / 2) {
			obj.style.left = (parseInt(div.offsetLeft) + parseInt(div.offsetWidth) - YuZiShowWidth) + "px";
		}
		else {
			obj.style.left = div.offsetLeft + "px";
		}
		obj.innerHTML = "<img src='" + sUrl + "' width=" + YuZiShowWidth + " height=" + YuZiShowHeight + " onload='BbsxpJustifyImg(this, " + YuZiShowWidth + "," + YuZiShowHeight + ", true);this.style.zIndex = 1;Gel(\"moShowLoadDiv\").style.display = \"none\";' style='position:relative;'></img><div id='moShowLoadDiv' style='text-align:center;position:absolute;left:0;top:0;background:#fff;width:" + YuZiShowWidth + "px;height:" + YuZiShowHeight + "px;'><div style='font:normal 12px Verdana;color:#888;margin-top:" + (YuZiShowHeight/2 - 6) + "px;'>loading...</div></div>";
		obj.style.display = "";
	}
}

var EmotionCurObj = null;
function BbsxpOnMouseOver(obj, iOffset) {
	if (YuZiSnapThumb) {return ;}
	obj.style.border='1px solid #000080';
	EmotionCurObj = obj;
	setTimeout(function() {try{BbsxpEmotionShow(obj.getElementsByTagName("IMG")[0].getAttribute("sval"), iOffset, obj);}catch(e){}}, 300);
}

function BbsxpOnMouseOut(obj) {
	if (YuZiSnapThumb) {return ;}
	obj.style.border='1px solid #F6F6F6';
	EmotionCurObj = null;
	BbsxpEmotionShow();
}

function BbsxpGetPageText() {
	return (YuZiCurPage + 1) + "/" + BbsxpCalcCurPages();
}

function BbsxpRefreshData() {
	Gel("moTabContainer").innerHTML = BbsxpTab();
	Gel("moDivContainer").innerHTML = BbsxpTable();
	Gel("moPageText").innerHTML = BbsxpGetPageText();
}

function BbsxpChangeTab(iTab) {
	if (iTab >= YuZiTabs || iTab == YuZiCurTab) {
		return;
	}
	YuZiCurPage = 0;
	YuZiCurTab = iTab;
	BbsxpRefreshData();
}

function BbsxpNextPage() {
	if (YuZiCurPage + 1 >= BbsxpCalcCurPages()) {
		return ;
	}
	YuZiCurPage += 1;
	BbsxpRefreshData();
}

function BbsxpPrevPage() {
	if (YuZiCurPage <= 0) {
		return ;
	}
	YuZiCurPage -= 1;
	BbsxpRefreshData();
}

function BbsxpCell(iCurTab, iCurPage, iNum, iOffset) {
	iNum = iCurPage * YuZiRowNum * YuZiColNum + iNum;
	var data = EmotionNode[iCurTab].getElementsByTagName('ICON');	//第 iCurTab 组表情数据
	if (iNum >= data.length) {
		return "";
	}
	
	var sSrc = EmotionNode[iCurTab].getAttributeNode('PathName').nodeValue + data[iNum].getAttributeNode('FileName').nodeValue;		//获取 第 iCurTab 组、第 iNum 个 表情符号的路径
	
	return "<img onclick='BBSXPExecute(\"YuZi_ICON_END\", \"" + sSrc + "\");' sval='" + sSrc + "' src='" + sSrc + "' title='" + GetNodeValue(data[iNum]) + "' width=" + YuZiCellWidth + " height=" + YuZiCellHeight + " onload='BbsxpJustifyImg(this, " + YuZiCellWidth + "," + YuZiCellHeight + ", true);' style='position:relative;cursor:pointer'></img>";
}

function BbsxpTable() {
	var pdivh = "<div style='width:" + YuZiCellWidth + "px;height:" + YuZiCellHeight + "px;'>";
	var code = "<table cellpadding=0 cellspacing=" + (YuZiSnapThumb ? 0 : 1) + " bgcolor=#DFE6F6>";
	for (var i = 0; i < YuZiRowNum; i++) {
		code += "<tr>";
		for (var j = 0; j < YuZiColNum; j++) {
			var cell = BbsxpCell(YuZiCurTab, YuZiCurPage, i * YuZiColNum + j, j);
			code += "<td align=center valign=middle width=" + (YuZiCellWidth + (YuZiSnapThumb ? 0 : 2)) + "px height=" + (YuZiCellHeight + (YuZiSnapThumb ? 0 : 2)) + "px style='background:#f6f6f6;padding:" + (YuZiSnapThumb ? 0 : 1) + "px;border:" + (YuZiSnapThumb ? 0 : 1) + "px solid #F6F6F6;' " + (cell != "" ? "onmouseover='BbsxpOnMouseOver(this, " + j + ");' onmouseout='BbsxpOnMouseOut(this);'>" + pdivh + cell : ">" + pdivh) + "</div></td>";
		}
		code += "</tr>";
	}
	return code + "</table>";
}

function BbsxpTab() {
	if (YuZiCustomSizeLock) {//根据定义大小，重定向:宽,高,行,列
		YuZiCellWidth = parseInt(EmotionNode[YuZiCurTab].getAttributeNode('Width').nodeValue);
		YuZiCellHeight = parseInt(EmotionNode[YuZiCurTab].getAttributeNode('Height').nodeValue);
		YuZiRowNum = parseInt(EmotionNode[YuZiCurTab].getAttributeNode('TableRow').nodeValue);
		YuZiColNum = parseInt(EmotionNode[YuZiCurTab].getAttributeNode('TableCol').nodeValue);
	}

	var code = "";
	for (var i = 0; i < YuZiTabs; i++) {
		code += "<span style='color:" + (YuZiCurTab == i ? "#000;border:1px solid #DFE6F6;font-weight:bold;border-bottom:1px solid #f6f6f6;border-top:2px solid #FFC83C" : "#000" ) + ";padding:3px 7px 2px 7px;cursor:pointer;' onclick='BbsxpChangeTab(" + i + ")'  unselectable='on'>" + EmotionNode[i].getAttributeNode('CategoryName').nodeValue + "</span>";
	}
	return code;
}

function BbsxpBtnMouse(obj, down) {
	var s = obj.style;
	s.position = "relative";
	s.top = down ? "1px" : "0px";
	s.left = down ? "1px" : "0px";
}

function BBSXPCube() {
	var str;
	str = "<div style='padding:10px 5px 0 5px;' unselectable='on'>";
	str += "<div id='moTabContainer' style='font:normal 12px Verdana;color:#000;padding:2px 6px' unselectable='on'>" + BbsxpTab() + "</div>";
	str += "<div id='moDivContainer' unselectable='on'>" + BbsxpTable() + "</div>";
	
	str += "<div align=right style='font-size:12px;padding:5px 0 5px 0;color:#000;' unselectable='on'>";
	str += "<span style='margin:0 10px 0 0;color:#000;font:normal 12px Verdana;' id='moPageText' unselectable='on'>" + BbsxpGetPageText() + "</span>";
	str += "<span style='cursor:pointer;margin:0 2px 0 2px;font-weight:bold;background:#eff7ff;border:1px solid #8ba8c8;color:#000;padding:2px 8px 0 8px' onclick='BbsxpPrevPage();' onmousedown='BbsxpBtnMouse(this,1);' onmouseup='BbsxpBtnMouse(this,0);' title='上一页' unselectable='on'>&lt;</span>";
	str += "<span style='cursor:pointer;margin:0 2px 0 2px;font-weight:bold;background:#eff7ff;border:1px solid #8ba8c8;color:#000;padding:2px 8px 0 8px' onclick='BbsxpNextPage();' onmousedown='BbsxpBtnMouse(this,1);' onmouseup='BbsxpBtnMouse(this,0);' title='下一页' unselectable='on'>&gt;</span>";
	str += "</div>";
	
	str += "<div id='moShowPanel' style='background:#fff;position:absolute;left:0;top:0;border:1px solid #004B97;width:" + YuZiShowWidth + "px;height:" + YuZiShowHeight + "px;text-align:center;display:none' unselectable='on'></div>";
	str += "<div id='moMainLoadDiv' style='font:normal 12px Verdana;display:none;position:absolute;text-valign:center;' unselectable='on'><img src='images/loading.gif' width=16 height=16>loading...</div>";
	str += "</div>";
	
	str += "<img id='moPPL' style='display:none;'/>";
	return str;
}
//Emotion_Part End

var YuZi_SAFE_MODE = false; 		// true or false
var YuZi_CurrentMode = "DESIGN";
var YuZi_IsChangeMode = false;
var YuZi_TdHeight = -1;
var YuZi_FONT_FAMILY = "Courier New";
var YuZi_WIDTH = "100%";
var YuZi_HEIGHT = "100%";
var YuZi_SKIN_PATH  = "Editor/Button/";
var YuZi_MENU_BORDER_COLOR = '#AAAAAA';
var YuZi_MENU_BG_COLOR = '#EFEFEF';
var YuZi_MENU_TEXT_COLOR = '#222222';
var YuZi_MENU_SELECTED_COLOR = '#CCCCCC';
var YuZi_TOOLBAR_BORDER_COLOR = '#DDDDDD';
var YuZi_TOOLBAR_BG_COLOR = '#EFEFEF';
var YuZi_FORM_BORDER_COLOR = '#DDDDDD';
var YuZi_FORM_BG_COLOR = '#FFFFFF';
var YuZi_BUTTON_COLOR = '#AAAAAA';
var YuZi_ForeColor = '#000000';
var YuZi_BackColor = '#FFFFFF';

var YuZi_LANG = {
	INPUT_URL		: "请输入正确的URL地址。",
	CONFIRM			: "确定",
	CANCEL			: "取消",
	PREVIEW			: "预览",
	REMOTE			: "URL：",
	NEW_WINDOW		: "新窗口",
	CURRENT_WINDOW	: "当前窗口",
	TARGET			: "目标",
	SUBJECT			: "标题",
	CurrentMode		: "编辑器处于代码状态下不能发送内容！",
	SubjectMinLen	: "标题不能小于2个字符！",
	BodyMinLen		: "内容不能小于2个字符！",
	BodyMaxLen		: "内容不能超过60000个字符！",
	VerifyCode		: "请输入验证码！",
	DesignMode		: "设计模式",
	CodeMode		: "代码模式",
	AddEditorArea	: "增大编辑区",
	ReduceEditorArea: "减小编辑区",
	Search			: "查　找：",
	Replace			: "替换为：",
	ReplaceButton		: "替换",
	Case			: "大小写：",
	CaseChkBox		: "区分大小写",
	WIDTH			: "宽度",
	HEIGHT			: "高度",
	Transparent		: "透明",
	AutoStart		: "自动播放",
	StatusBar		: "显示状态栏",
	CopyPaste		: "请用鼠标右击完成剪切/复制、粘贴操作"
}

var YuZi_FONT_NAME = Array(
	Array('宋体', '宋体'),
	Array('黑体', '黑体'),
	Array('楷体', '楷体'), 
	Array('隶书', '隶书'),
	Array('幼圆', '幼圆'),
	Array('新宋体', '新宋体'),
	Array('Arial', 'Arial'),
	Array('Arial Black', 'Arial Black'),
	Array('Courier New','Courier New'),
	Array('Garamond','Garamond'),
	Array('Georgia','Georgia'),
	Array('Tahoma','Tahoma'),
	Array('Verdana', 'Verdana'),
	Array('Times New Roman', 'Times New Roman'),
	Array('GulimChe', 'GulimChe'),
	Array('MS Gothic', 'MS Gothic')
);
var YuZi_SPECIAL_CHARACTER = Array(
	'§','№','☆','★','○','●','◎','◇','◆','□','℃','‰','■','△','▲','※',
	'→','←','↑','↓','〓','¤','°','＃','＆','＠','＼','︿','＿','￣','―','α',
	'β','γ','δ','ε','ζ','η','θ','ι','κ','λ','μ','ν','ξ','ο','π','ρ',
	'σ','τ','υ','φ','χ','ψ','ω','≈','≡','≠','＝','≤','≥','＜','＞','≮',
	'≯','∷','±','＋','－','×','÷','／','∫','∮','∝','∞','∧','∨','∑','∏',
	'∪','∩','∈','∵','∴','⊥','∥','∠','⌒','⊙','≌','∽','〖','〗',
	'【','】','（','）','［','］'
);

var YuZi_TOP_TOOLBAR_ICON = Array(
	Array('YuZi_TITLE', 'title.gif', '标题'),
	Array('YuZi_FONTNAME', 'font.gif', '字体'),
	Array('YuZi_FONTSIZE', 'fontsize.gif', '文字大小'),
	Array('YuZi_TEXTCOLOR', 'fbcolor.gif', '文字颜色'),
	Array('YuZi_BGCOLOR', 'fgcolor.gif', '文字背景颜色'),
	Array('YuZi_BOLD', 'bold.gif', '粗体'),
	Array('YuZi_ITALIC', 'italic.gif', '斜体'),
	Array('YuZi_UNDERLINE', 'underline.gif', '下划线'),
	Array('YuZi_STRIKE', 'strikethrough.gif', '删除线'),
	Array('YuZi_JUSTIFYLEFT', 'justifyleft.gif', '左对齐'),
	Array('YuZi_JUSTIFYCENTER', 'justifycenter.gif', '居中'),
	Array('YuZi_JUSTIFYRIGHT', 'justifyright.gif', '右对齐'),
	Array('YuZi_JUSTIFYFULL', 'justifyfull.gif', '两端对齐'),
	Array('YuZi_NUMBEREDLIST', 'numberedlist.gif', '编号'),
	Array('YuZi_UNORDERLIST', 'unorderedlist.gif', '项目符号')
);

var YuZi_MIDDLE_TOOLBAR_ICON = Array(
	Array('YuZi_Replace','replace.gif','替换'),
	Array('YuZi_CUT', 'cut.gif', '剪切'),
	Array('YuZi_COPY', 'copy.gif', '复制'),
	Array('YuZi_PASTE', 'paste.gif', '粘贴'),
	Array('YuZi_ClearUP','cleanup.gif','清洁代码'),
	Array('YuZi_UNDO', 'undo.gif', '撤消'),
	Array('YuZi_REDO', 'redo.gif', '恢复'),
	Array('YuZi_SELECTALL', 'selectall.gif', '全选'),
	Array('YuZi_UNSELECT', 'unselect.gif', '取消全选'),
	Array('YuZi_REMOVE', 'RemoveFormat.gif', '清除格式'),
	Array('YuZi_Paragraph','Paragraph.gif','段落'),
	Array('YuZi_INDENT', 'indent.gif', '减少缩进'),
	Array('YuZi_OUTDENT', 'outdent.gif', '增加缩进'),
	Array('YuZi_SUBSCRIPT', 'subscript.gif', '下标'),
	Array('YuZi_SUPERSCRIPT', 'superscript.gif', '上标'),
	Array('Break','Break.gif','换行符'),
	Array('YuZi_HR', 'hr.gif', '横线')
);

var YuZi_BOTTOM_TOOLBAR_ICON = Array(
	Array('YuZi_DATE', 'date.gif', '日期'),
	Array('YuZi_TIME', 'time.gif', '时间'),
	Array('YuZi_SPECIALCHAR', 'specialchar.gif', '插入特殊字符'),
	Array('YuZi_ICON', 'emoticons.gif', '插入表情'),
	Array('YuZi_TABLE', 'table.gif', '插入表格'),
	Array('YuZi_IMAGE', 'image.gif', '插入图片'),
	Array('YuZi_Media', 'Media.gif', '插入 FLASH、MediaPlayer、RealPlayer 文件'),
	Array('YuZi_LINK', 'link.gif', '创建超级连接'),
	Array('YuZi_UNLINK', 'unlink.gif', '删除超级连接'),
	Array('YuZi_Delete','delete.gif','删除当前选中区域'),
	Array('InsertInputText','InputText.gif','插入输入框'),
	Array('InsertTextArea','TextArea.gif','插入文字输入区'),
	Array('InsertInputRadio','InputRadio.gif','插入单选按钮'),
	Array('InsertCheckbox','Checkbox.gif','插入复选框'),
	Array('InsertSelectDropdown','SelectDropdown.gif','插入下拉框'),
	Array('InsertButton','Button.gif','插入按钮'),
	Array('YuZi_PRINT', 'print.gif', '打印')
);

var YuZi_TITLE_TABLE = Array(
	Array('H1', YuZi_LANG['SUBJECT'] + ' 1'), 
	Array('H2', YuZi_LANG['SUBJECT'] + ' 2'), 
	Array('H3', YuZi_LANG['SUBJECT'] + ' 3'), 
	Array('H4', YuZi_LANG['SUBJECT'] + ' 4'), 
	Array('H5', YuZi_LANG['SUBJECT'] + ' 5'), 
	Array('H6', YuZi_LANG['SUBJECT'] + ' 6')
);

var YuZi_FONT_SIZE = Array(
	Array(1,'8pt'), 
	Array(2,'10pt'), 
	Array(3,'12pt'), 
	Array(4,'14pt'), 
	Array(5,'18pt'), 
	Array(6,'24pt'), 
	Array(7,'36pt')
);
var YuZi_POPUP_MENU_TABLE = Array(
	"YuZi_TITLE", "YuZi_FONTNAME", "YuZi_FONTSIZE", "YuZi_TEXTCOLOR", "YuZi_BGCOLOR", 
	"YuZi_TABLE", "YuZi_HR", "YuZi_ICON", "YuZi_SPECIALCHAR", 
	"YuZi_Replace", "YuZi_IMAGE", "YuZi_Media", "YuZi_LINK"
);
var YuZi_COLOR_TABLE = Array(
	"#000000","#993300","#333300","#003300","#003366","#000080","#333399","#333333",
	"#800000","#FF6600","#808000","#008000","#008080","#0000FF","#666699","#808080",
	"#FF0000","#FF9900","#99CC00","#339966","#33CCCC","#3366FF","#800080","#999999",
	"#FF00FF","#FFCC00","#FFFF00","#00FF00","#00FFFF","#00CCFF","#993366","#C0C0C0",
	"#FF99CC","#FFCC99","#FFFF99","#CCFFCC","#CCFFFF","#99CCFF","#CC99FF","#FFFFFF"
);

var YuZi_OBJ_NAME;
var YuZi_SELECTION;
var YuZi_RANGE;
var YuZi_RANGE_TEXT;
var YuZi_EDITFORM_DOCUMENT;
var YuZi_Replace_DOCUMENT;
var YuZi_IMAGE_DOCUMENT;
var YuZi_Media_DOCUMENT;
var YuZi_LINK_DOCUMENT;
var YuZi_BROWSER;
var YuZi_TOOLBAR_ICON;

//浏览器类型
function BBSXPGetBrowser()
{
	var browser = '';
	var agentInfo = navigator.userAgent.toLowerCase();
	if (agentInfo.indexOf("msie") > -1) {
		var re = new RegExp("msie\\s?([\\d\\.]+)","ig");
		var arr = re.exec(agentInfo);
		if (parseInt(RegExp.$1) >= 5.5) {
			browser = 'IE';
		}
	} else if (agentInfo.indexOf("firefox") > -1) {
		browser = 'FF';
	} else if (agentInfo.indexOf("netscape") > -1) {
		var temp1 = agentInfo.split(' ');
		var temp2 = temp1[temp1.length-1].split('/');
		if (parseInt(temp2[1]) >= 7) {
			browser = 'NS';
		}
	} else if (agentInfo.indexOf("gecko") > -1) {
		browser = 'ML';
	} else if (agentInfo.indexOf("opera") > -1) {
		var temp1 = agentInfo.split(' ');
		var temp2 = temp1[0].split('/');
		if (parseInt(temp2[1]) >= 9) {
			browser = 'OPERA';
		}
	}
	return browser;
}



function BBSXPHtmlToXhtml(str) 
{
	str = str.replace(/<br.*?>/gi, "<br />");
	str = str.replace(/(<hr\s+[^>]*[^\/])(>)/gi, "$1 />");
	str = str.replace(/(<img\s+[^>]*[^\/])(>)/gi, "$1 />");
	str = str.replace(/(<\w+)(.*?>)/gi, function ($0,$1,$2) {
						return($1.toLowerCase() + BBSXPConvertAttribute($2));
					}
				);
	str = str.replace(/(<\/\w+>)/gi, function ($0,$1) {
						return($1.toLowerCase());
					}
				);
	return str;
}
function BBSXPConvertAttribute(str)
{
	if (YuZi_SAFE_MODE == true) {
		str = BBSXPClearAttributeScriptTag(str);
	}
	return str;
}
function BBSXPClearAttributeScriptTag(str)
{
	var re = new RegExp("(\\son[a-z]+=)[\"']?[^>]*?[^\\\\\>][\"']?([\\s>])","ig");
	str = str.replace(re, function ($0,$1,$2) {
						return($1.toLowerCase() + "\"\"" + $2);
					}
				);
	return str;
}
function BBSXPClearScriptTag(str)
{
	if (YuZi_SAFE_MODE == false) {
		return str;
	}
	str = str.replace(/<(script.*?)>/gi, "[$1]");
	str = str.replace(/<\/script>/gi, "[/script]");
	return str;
}
function BBSXPHtmlentities(str)
{
	str = str.replace(/&/g,'&amp;');
	str = str.replace(/</g,'&lt;');
	str = str.replace(/>/g,'&gt;');
	str = str.replace(/"/g,'&quot;');
	return str;
}

function BBSXPDisplayMenu(cmd)
{
	BBSXPEditorForm.focus();
	BBSXPSelection();
	BBSXPDisableMenu();
	
	var Top = ie_y(document.getElementById(cmd))+25;
	var Left = ie_x(document.getElementById(cmd));

	document.getElementById('POPUP_'+cmd).style.top = Top.toString(10) + 'px';
	document.getElementById('POPUP_'+cmd).style.left = Left.toString(10) + 'px';
	document.getElementById('POPUP_'+cmd).style.display = 'block';
}
function BBSXPDisableMenu()
{
	for (i = 0; i < YuZi_POPUP_MENU_TABLE.length; i++) {
		document.getElementById('POPUP_'+YuZi_POPUP_MENU_TABLE[i]).style.display = 'none';
	}
}
function BBSXPReloadIframe()
{
	var str = '';
	str += BBSXPPopupMenu('YuZi_Replace');
	str += BBSXPPopupMenu('YuZi_IMAGE');
	str += BBSXPPopupMenu('YuZi_Media');
	document.getElementById('InsertIframe').innerHTML = str;
	BBSXPDrawIframe('YuZi_Replace');
	BBSXPDrawIframe('YuZi_IMAGE');
	BBSXPDrawIframe('YuZi_Media');
}
function BBSXPGetMenuCommonStyle()
{
	var str = 'position:absolute;top:1px;left:1px;font-size:12px;color:'+YuZi_MENU_TEXT_COLOR+
			';background-color:'+YuZi_MENU_BG_COLOR+';border:solid 1px '+YuZi_MENU_BORDER_COLOR+';z-index:1;display:none;';
	return str;
}
function BBSXPGetCommonMenu(cmd, content)
{
	var str = '';
	str += '<div id="POPUP_'+cmd+'" style="'+BBSXPGetMenuCommonStyle()+'">';
	str += content;
	str += '</div>';
	return str;
}
function BBSXPCreateColorTable(cmd, eventStr)
{
	var str = '';
	str += '<table cellpadding="0" cellspacing="2" border="0">';
	for (i = 0; i < YuZi_COLOR_TABLE.length; i++) {
		if (i == 0 || (i >= 8 && i%8 == 0)) {
			str += '<tr>';
		}
		str += '<td style="width:12px;height:12px;border:1px solid #AAAAAA;font-size:1px;cursor:pointer;background-color:' +
		YuZi_COLOR_TABLE[i] + ';" onmouseover="this.style.borderColor=\'#000000\';' + ((eventStr) ? eventStr : '') + '" ' +
		'onmouseout="this.style.borderColor=\'#AAAAAA\';" ' + 
		'onclick="BBSXPExecute(\''+cmd+'_END\', \'' + YuZi_COLOR_TABLE[i] + '\');">&nbsp;</td>';
		if (i >= 7 && i%(i-1) == 0) {
			str += '</tr>';
		}
	}
	str += '</table>';
	return str;
}
function BBSXPDrawColorTable(cmd)
{
	var str = '';
	str += '<div id="POPUP_'+cmd+'" style="width:128px;padding:2px;'+BBSXPGetMenuCommonStyle()+'">';
	str += BBSXPCreateColorTable(cmd);
	str += '</div>';
	return str;
}


//弹出菜单
function BBSXPPopupMenu(cmd)
{
	switch (cmd)
	{
		case 'YuZi_TITLE':
			var str = '';
			for (i = 0; i < YuZi_TITLE_TABLE.length; i++) {
				str += '<div style="width:140px;cursor:pointer;" ' + 
				'onclick="BBSXPExecute(\'YuZi_TITLE_END\', \'' + YuZi_TITLE_TABLE[i][0] + '\');" ' + 
				'onmouseover="this.style.backgroundColor=\''+YuZi_MENU_SELECTED_COLOR+'\';" ' +
				'onmouseout="this.style.backgroundColor=\''+YuZi_MENU_BG_COLOR+'\';"><' + YuZi_TITLE_TABLE[i][0] + ' style="margin:2px;">' + 
				YuZi_TITLE_TABLE[i][1] + '</' + YuZi_TITLE_TABLE[i][0] + '></div>';
			}
			str = BBSXPGetCommonMenu('YuZi_TITLE', str);
			return str;
			break;
		case 'YuZi_FONTNAME':
			var str = '';
			for (i = 0; i < YuZi_FONT_NAME.length; i++) {
				str += '<div style="font-family:' + YuZi_FONT_NAME[i][0] + 
				';padding:2px;width:160px;cursor:pointer;" ' + 
				'onclick="BBSXPExecute(\'YuZi_FONTNAME_END\', \'' + YuZi_FONT_NAME[i][0] + '\');" ' + 
				'onmouseover="this.style.backgroundColor=\''+YuZi_MENU_SELECTED_COLOR+'\';" ' +
				'onmouseout="this.style.backgroundColor=\''+YuZi_MENU_BG_COLOR+'\';">' + 
				YuZi_FONT_NAME[i][1] + '</div>';
			}
			str = BBSXPGetCommonMenu('YuZi_FONTNAME', str);
			return str;
			break;
		case 'YuZi_FONTSIZE':
			var str = '';
			for (i = 0; i < YuZi_FONT_SIZE.length; i++) {
				str += '<div style="font-size:' + YuZi_FONT_SIZE[i][1] + 
				';padding:2px;width:120px;cursor:pointer;" ' + 
				'onclick="BBSXPExecute(\'YuZi_FONTSIZE_END\', \'' + YuZi_FONT_SIZE[i][0] + '\');" ' + 
				'onmouseover="this.style.backgroundColor=\''+YuZi_MENU_SELECTED_COLOR+'\';" ' +
				'onmouseout="this.style.backgroundColor=\''+YuZi_MENU_BG_COLOR+'\';">' + 
				YuZi_FONT_SIZE[i][1] + '</div>';
			}
			str = BBSXPGetCommonMenu('YuZi_FONTSIZE', str);
			return str;
			break;
		case 'YuZi_TEXTCOLOR':
			var str = '';
			str = BBSXPDrawColorTable('YuZi_TEXTCOLOR');
			return str;
			break;
		case 'YuZi_BGCOLOR':
			var str = '';
			str = BBSXPDrawColorTable('YuZi_BGCOLOR');
			return str;
			break;
		case 'YuZi_HR':
			var str = '';
			str += '<div id="POPUP_'+cmd+'" style="width:128px;'+BBSXPGetMenuCommonStyle()+'">';
			str += '<div id="hrPreview" style="margin:10px 2px 10px 2px;height:1px;border:0;font-size:0;background-color:#FFFFFF;"></div>';
			str += BBSXPCreateColorTable(cmd, 'document.getElementById(\'hrPreview\').style.backgroundColor = this.style.backgroundColor;');
			str += '</div>';
			return str;
			break;
		case 'YuZi_ICON':
			var str = '';
			str = '<div id="POPUP_'+cmd+'" style="'+BBSXPGetMenuCommonStyle()+'"></div>';
			return str;
			break;
		case 'YuZi_SPECIALCHAR':
			var str = '';
			str += '<table id="POPUP_'+cmd+'" cellpadding="0" cellspacing="2" style="'+BBSXPGetMenuCommonStyle()+'">';
			for (i = 0; i < YuZi_SPECIAL_CHARACTER.length; i++) {
				if (i == 0 || (i >= 10 && i%10 == 0)) {
					str += '<tr>';
				}
				str += '<td style="padding:2px;border:1px solid #AAAAAA;cursor:pointer;" ' + 
				'onclick="BBSXPExecute(\'YuZi_SPECIALCHAR_END\', \'' + YuZi_SPECIAL_CHARACTER[i] + '\');" ' +
				'onmouseover="this.style.borderColor=\'#000000\';" ' +
				'onmouseout="this.style.borderColor=\'#AAAAAA\';">' + YuZi_SPECIAL_CHARACTER[i] + '</td>';
				if (i >= 9 && i%(i-1) == 0) {
					str += '</tr>';
				}
			}
			str += '</table>';
			return str;
			break;
		case 'YuZi_TABLE':
			var str = '';
			var num = 10;
			str += '<table id="POPUP_'+cmd+'" cellpadding="0" cellspacing="0" style="'+BBSXPGetMenuCommonStyle()+'">';
			for (i = 1; i <= num; i++) {
				str += '<tr>';
				for (j = 1; j <= num; j++) {
					var value = i.toString(10) + ',' + j.toString(10);
					str += '<td id="BBSXPTableTd' + i.toString(10) + '_' + j.toString(10) + 
					'" style="width:15px;height:15px;background-color:#FFFFFF;border:1px solid #DDDDDD;cursor:pointer;" ' + 
					'onclick="BBSXPExecute(\'YuZi_TABLE_END\', \'' + value + '\');" ' +
					'onmouseover="BBSXPDrawTableSelected(\''+i.toString(10)+'\', \''+j.toString(10)+'\');" ' + 
					'onmouseout="">&nbsp;</td>';
				}
				str += '</tr>';
			}
			str += '<tr><td colspan="10" id="tableLocation" style="text-align:center;height:20px;"></td></tr>';
			str += '</table>';
			return str;
			break;
		case 'YuZi_Replace':
			var str = '';
			str += '<div id="POPUP_'+cmd+'" style="width:250px;'+BBSXPGetMenuCommonStyle()+'">';
			str += '<iframe name="BBSXPReplaceIframe" id="BBSXPReplaceIframe" frameborder="0" style="width:250px;height:120px;padding:0;margin:0;border:0;">';
			str += '</iframe></div>';
			return str;
			break;
		case 'YuZi_IMAGE':
			var str = '';
			str += '<div id="POPUP_'+cmd+'" style="width:250px;'+BBSXPGetMenuCommonStyle()+'">';
			str += '<iframe name="BBSXPImageIframe" id="BBSXPImageIframe" frameborder="0" style="width:250px;height:240px;padding:0;margin:0;border:0;">';
			str += '</iframe></div>';
			return str;
			break;
		case 'YuZi_Media':
			var str = '';
			str += '<div id="POPUP_'+cmd+'" style="width:250px;'+BBSXPGetMenuCommonStyle()+'">';
			str += '<iframe name="BBSXPMediaIframe" id="BBSXPMediaIframe" frameborder="0" style="width:250px;height:300px;padding:0;margin:0;border:0;">';
			str += '</iframe></div>';
			return str;
			break;
		case 'YuZi_LINK':
			var str = '';
			str += '<div id="POPUP_'+cmd+'" style="width:250px;'+BBSXPGetMenuCommonStyle()+'">';
			str += '<iframe name="BBSXPLinkIframe" id="BBSXPLinkIframe" frameborder="0" style="width:250px;height:85px;padding:0;margin:0;border:0;">';
			str += '</iframe></div>';
			return str;
			break;
		default: 
			break;
	}
}
function BBSXPDrawIframe(cmd)
{
	if (YuZi_BROWSER == 'IE') {
		YuZi_Replace_DOCUMENT = document.frames("BBSXPReplaceIframe").document;
		YuZi_IMAGE_DOCUMENT = document.frames("BBSXPImageIframe").document;
		YuZi_Media_DOCUMENT = document.frames("BBSXPMediaIframe").document;
		YuZi_LINK_DOCUMENT = document.frames("BBSXPLinkIframe").document;
	} else {
		YuZi_Replace_DOCUMENT = document.getElementById('BBSXPReplaceIframe').contentDocument;
		YuZi_IMAGE_DOCUMENT = document.getElementById('BBSXPImageIframe').contentDocument;
		YuZi_Media_DOCUMENT = document.getElementById('BBSXPMediaIframe').contentDocument;
		YuZi_LINK_DOCUMENT = document.getElementById('BBSXPLinkIframe').contentDocument;
	}
	switch (cmd)
	{
		case 'YuZi_IMAGE':
			var str = '';
			str += '<div align="center">' +
				'<form name="uploadForm" style="margin:0;padding:0;" method="post" onsubmit="javascript:if(parent.BBSXPDrawImageEnd()==false){return false;};">' +
				'<input type="hidden" name="fileName" id="fileName" value="" />' + 
				'<table cellpadding="0" cellspacing="0" style="width:100%;font-size:12px;">' + 
				'<tr><td colspan="2"><table border="0" style="margin-bottom:3px;"><tr><td id="imgPreview" style="width:240px;height:180px;border:1px solid #AAAAAA;background-color:#FFFFFF;" align="center" valign="middle">&nbsp;</td></tr></table></td></tr>' +  	
				'<tr><td style="width:40px;padding-left:5px;">';
				
			str += YuZi_LANG['REMOTE'];
			str += '</td><td style="width:210px;padding-bottom:3px;">';

			str += '<input type="text" id="imgLink" value="http://" maxlength="255" style="width:95%;border:1px solid #555555;" />';
			str += '</td></tr><tr><td colspan="2" style="margin:5px;padding-bottom:5px;" align="center">' +
				'<input type="button" name="button" value="'+YuZi_LANG['PREVIEW']+'" onclick="parent.BBSXPImagePreview();" /> ' +
				'<input type="submit" name="button" id="'+cmd+'submitButton" value="'+YuZi_LANG['CONFIRM']+'" /> ' +
				'<input type="button" name="button" value="'+YuZi_LANG['CANCEL']+'" onclick="parent.BBSXPDisableMenu();parent.BBSXPReloadIframe();" /></td></tr>' + 
				'</table></form></div>';
			BBSXPDrawMenuIframe(YuZi_IMAGE_DOCUMENT, str);
			break;
		case 'YuZi_Replace':
			var str = '<table border=0 cellpadding=2 style="background:'+YuZi_MENU_BG_COLOR+';width:100%;height:100%;font-size:12px;">';
			str += '<form name=Replace method="Post">';
			str += '<tr><td>'+YuZi_LANG['Search']+'<input type=text name=TextOne value=></td></tr>';
			str += '<tr><td>'+YuZi_LANG['Replace']+'<input type=text name=TextTwo value=></td></tr>';
			str += '<tr><td>　　<input type=checkbox id=Case /> <label for="Case">'+YuZi_LANG['CaseChkBox']+'</label></td></tr>';
			str += '<tr><td align=center><input id="YuZi_ReplacesubmitButton" type="button" value=" '+YuZi_LANG['ReplaceButton']+' " onclick="parent.BBSXPReplace();">　<input type=button value=" '+YuZi_LANG['CANCEL']+' " onclick="parent.BBSXPDisableMenu();parent.BBSXPReloadIframe();"></td></tr>';
			str += '</form></div>';
			BBSXPDrawMenuIframe(YuZi_Replace_DOCUMENT, str);
			break;
		case 'YuZi_Media':
			var str = '<table cellpadding="0" cellspacing="0" style="width:100%;font-size:12px;">' + 
			'<tr><td colspan="2"><table border="0"><tr><td id="MediaPreview" style="width:240px;height:180px;border:1px solid #AAAAAA;background-color:#FFFFFF;" align="center" valign="middle">&nbsp;</td></tr></table></td></tr>' +
			'<tr><td style="width:20px;padding:5px;">'+YuZi_LANG['REMOTE']+'</td>' +
			'<td style="width:230px;padding-bottom:5px;padding-top:5px"><input type="text" id="MediaLink" value="http://" style="width:195px;border:1px solid #555555;" /></td></tr>' +
			'<tr>' +
			'<td colspan="2" style="margin:5px;padding-bottom:5px;padding-left:5px">'+YuZi_LANG['WIDTH']+'：<input type=text id="MediaWidth" value=300 size=4 style="border:1px solid #555555;">　　'+YuZi_LANG['HEIGHT']+'：<input type=text id=MediaHeigth value=250 size=4 style="border:1px solid #555555;"></td>' +
			'</tr>' +
			
			'<tr><td colspan="2" style="padding-bottom:5px;padding-left:5px">'+YuZi_LANG['AutoStart']+'：<input type="checkbox" id="AutoStart" value="1" checked />　　　'+YuZi_LANG['StatusBar']+'：<input type="checkbox" value="1" id=ShowStatusBar checked></td></tr>' +
			
			
			'<tr><td colspan="2" style="margin:5px;padding-bottom:5px;" align="center">' +
			'<input type="button" name="button" value="'+YuZi_LANG['PREVIEW']+'" onclick="parent.BBSXPMediaPreview();" /> ' +
			'<input type="submit" name="button" id="'+cmd+'submitButton" value="'+YuZi_LANG['CONFIRM']+'" onclick="parent.BBSXPDrawMediaEnd();" /> ' +
			'<input type="button" name="button" value="'+YuZi_LANG['CANCEL']+'" onclick="parent.BBSXPDisableMenu();parent.BBSXPReloadIframe();" /></td></tr>' + 
			'</table>';
			BBSXPDrawMenuIframe(YuZi_Media_DOCUMENT, str);
			break;
		case 'YuZi_LINK':
			var str = '';
			str += '<table cellpadding="0" cellspacing="0" style="width:100%;font-size:12px;">' + 
				'<tr><td style="width:50px;padding:5px;">URL</td>' +
				'<td style="width:200px;padding-top:5px;padding-bottom:5px;"><input type="text" id="hyperLink" value="http://" style="width:190px;border:1px solid #555555;background-color:#FFFFFF;"></td>' +
				'<tr><td style="padding:5px;">'+YuZi_LANG['TARGET']+'</td>' +
				'<td style="padding-bottom:5px;"><select id="hyperLinkTarget"><option value="_blank" selected="selected">'+YuZi_LANG['NEW_WINDOW']+'</option><option value="">'+YuZi_LANG['CURRENT_WINDOW']+'</option></select></td></tr>' + 
				'<tr><td colspan="2" style="padding-bottom:5px;" align="center">' +
				'<input type="submit" name="button" id="'+cmd+'submitButton" value="'+YuZi_LANG['CONFIRM']+'" onclick="parent.BBSXPDrawLinkEnd();" /> ' +
				'<input type="button" name="button" value="'+YuZi_LANG['CANCEL']+'" onclick="parent.BBSXPDisableMenu();" /></td></tr>';
			str += '</table>';
			BBSXPDrawMenuIframe(YuZi_LINK_DOCUMENT, str);
			break;
		default:
			break;
	}
}
function BBSXPDrawMenuIframe(obj, str)
{
	obj.open();
	obj.write(str);
	obj.close();
	obj.body.style.color = YuZi_MENU_TEXT_COLOR;
	obj.body.style.backgroundColor = YuZi_MENU_BG_COLOR;
	obj.body.style.margin = 0;
	obj.body.scroll = 'no';
}
function BBSXPDrawTableSelected(i, j)
{
	var text = i.toString(10) + ' 乘 ' + j.toString(10) + ' 表格';
	document.getElementById('tableLocation').innerHTML = text;
	var num = 10;
	for (m = 1; m <= num; m++) {
		for (n = 1; n <= num; n++) {
			var obj = document.getElementById('BBSXPTableTd' + m.toString(10) + '_' + n.toString(10) + '');
			if (m <= i && n <= j) {
				obj.style.backgroundColor = YuZi_MENU_SELECTED_COLOR;
			} else {
				obj.style.backgroundColor = '#FFFFFF';
			}
		}
	}
}

//替换内容_开始
function BBSXPReplace()
{
	var TextOne = YuZi_Replace_DOCUMENT.Replace.elements['TextOne'].value
	var TextTwo = YuZi_Replace_DOCUMENT.Replace.elements['TextTwo'].value
	var IgnoreCase = YuZi_Replace_DOCUMENT.Replace.elements['Case'].value
	if (TextOne != null && TextTwo != null){
		con = YuZi_EDITFORM_DOCUMENT.body.innerHTML;
		if (IgnoreCase.toLowerCase() == "on"){
			con = BBSXPRegEx(con,TextOne,TextTwo,true);
		}
		else{
			con = BBSXPRegEx(con,a,b);
		}
		YuZi_EDITFORM_DOCUMENT.body.innerHTML = con;
	}
	else
		BBSXPEditorForm.focus();
	
	BBSXPDisableMenu();
	BBSXPReloadIframe();
}
function BBSXPRegEx(s,a,b,i){
	a = a.replace("?","\\?");
	if (i==null){
		var r = new RegExp(a,"gi");
	}
	else if (i) {
		var r = new RegExp(a,"g");
	}
	else{
		var r = new RegExp(a,"gi");
	}
	return s.replace(r,b); 
}
//替换内容_结束

//插入图片 预览
function BBSXPImagePreview()
{
	var url = YuZi_IMAGE_DOCUMENT.getElementById('imgLink').value;
	if (url=="http://" || !url || url.length<10) {
		alert(YuZi_LANG['INPUT_URL']);
		return false;
	}
	var imgObj = YuZi_IMAGE_DOCUMENT.createElement("IMG");
	imgObj.src = url;
	var width = parseInt(imgObj.width);
	var height = parseInt(imgObj.height);
	var rate = parseInt(width/height);
	if (width >240 && height <= 180) {
		width = 240;
		height = parseInt(width/rate);
	} else if (width <=240 && height > 180) {
		height = 180;
		width = parseInt(height*rate);
	} else if (width >240 && height > 180) {
		height = 180;
		width = parseInt(height*rate);
		if (width >240) width = 240;
	}
	imgObj.style.width = width;
	imgObj.style.height = height;
	var el = YuZi_IMAGE_DOCUMENT.getElementById('imgPreview');
	if (el.hasChildNodes()) {
		el.removeChild(el.childNodes[0]);
	}
	el.appendChild(imgObj);
	return imgObj;
}
//插入图片
function BBSXPDrawImageEnd()
{
	var url = YuZi_IMAGE_DOCUMENT.getElementById('imgLink').value;
	if (url=="http://" || !url || url.length<10) {
		alert(YuZi_LANG['INPUT_URL']);
		return false;
	}
		
	BBSXPEditorForm.focus();
	var element = document.createElement("img");
	element.src = url;
	element.border = 0;
	BBSXPSelect();
	BBSXPInsertItem(element);
	BBSXPDisableMenu();
	BBSXPReloadIframe();
}
function BBSXPGetMediaHtmlTag(url)
{
	var str = '<embed src="'+url+'" quality="high" AutoStart="true"></embed>';
	return str;
}
//插入Media 预览
function BBSXPMediaPreview()
{
	var url = YuZi_Media_DOCUMENT.getElementById('MediaLink').value;
	if (url=="http://" || !url || url.length<10) {
		alert(YuZi_LANG['INPUT_URL']);
		return false;
	}
	var el = YuZi_Media_DOCUMENT.getElementById('MediaPreview');
	el.innerHTML = BBSXPGetMediaHtmlTag(url);
}
//插入Media
function BBSXPDrawMediaEnd()
{
	var url = YuZi_Media_DOCUMENT.getElementById('MediaLink').value;
	var Width = YuZi_Media_DOCUMENT.getElementById('MediaWidth').value;
	var Height = YuZi_Media_DOCUMENT.getElementById('MediaHeigth').value;
	if (url=="http://" || !url || url.length<10) {
		alert(YuZi_LANG['INPUT_URL']);
		return false;
	}
	BBSXPEditorForm.focus();
	BBSXPSelect();
	var obj = document.createElement("EMBED");
	obj.src = url;
	obj.style.width = Width;
	obj.style.height = Height;
	obj.quality = "high";
	obj.autostart = YuZi_Media_DOCUMENT.getElementById('AutoStart').checked;
	obj.ShowStatusBar = YuZi_Media_DOCUMENT.getElementById('ShowStatusBar').checked;
	BBSXPInsertItem(obj);
	BBSXPDisableMenu();
}

//插入链接
function BBSXPDrawLinkEnd()
{
	var range;
	var url = YuZi_LINK_DOCUMENT.getElementById('hyperLink').value;
	var target = YuZi_LINK_DOCUMENT.getElementById('hyperLinkTarget').value;
	if (url.match(/http|ftp|https|mailto|wais|telnet|news|gopher|mms:\/\/.{3,}/) == null) {
		alert(YuZi_LANG['INPUT_URL']);
		return false;
	}
	BBSXPEditorForm.focus();
	BBSXPSelect();
	var element;
    if (YuZi_BROWSER != 'IE') {
		BBSXPExecuteValue('CreateLink', url);
		element = YuZi_RANGE.startContainer.previousSibling;
		element.target = target;
		if (target) {
			element.target = target;
		}
    }
	BBSXPDisableMenu();
}

function BBSXPSelection()
{
	if (YuZi_BROWSER == 'IE') {
		YuZi_SELECTION = YuZi_EDITFORM_DOCUMENT.selection;
		YuZi_RANGE = YuZi_SELECTION.createRange();
		YuZi_RANGE_TEXT = YuZi_RANGE.text;
	}
	else {
		YuZi_SELECTION = document.getElementById("BBSXPEditorForm").contentWindow.getSelection();
        YuZi_RANGE = YuZi_SELECTION.getRangeAt(0);
		YuZi_RANGE_TEXT = YuZi_RANGE.toString();
	}
}
function BBSXPSelect()
{
	if (YuZi_BROWSER == 'IE') {
		YuZi_RANGE.select();
	}
}

function BBSXPInsertItem(insertNode)
{
	if (YuZi_BROWSER == 'IE') {
		if (YuZi_SELECTION.type.toLowerCase() == 'control') {
			YuZi_RANGE.item(0).outerHTML = insertNode.outerHTML;
		}
		else {
			YuZi_RANGE.pasteHTML(insertNode.outerHTML);
		}
	}
	else {
        YuZi_SELECTION.removeAllRanges();
		YuZi_RANGE.deleteContents();
        var startRangeNode = YuZi_RANGE.startContainer;
        var startRangeOffset = YuZi_RANGE.startOffset;
        var newRange = document.createRange();
		if (startRangeNode.nodeType == 3 && insertNode.nodeType == 3) {
            startRangeNode.insertData(startRangeOffset, insertNode.nodeValue);
            newRange.setEnd(startRangeNode, startRangeOffset + insertNode.length);
            newRange.setStart(startRangeNode, startRangeOffset + insertNode.length);
        }
		else {
            var afterNode;
            if (startRangeNode.nodeType == 3) {
                var textNode = startRangeNode;
                startRangeNode = textNode.parentNode;
                var text = textNode.nodeValue;
                var textBefore = text.substr(0, startRangeOffset);
                var textAfter = text.substr(startRangeOffset);
                var beforeNode = document.createTextNode(textBefore);
                var afterNode = document.createTextNode(textAfter);
                startRangeNode.insertBefore(afterNode, textNode);
                startRangeNode.insertBefore(insertNode, afterNode);
                startRangeNode.insertBefore(beforeNode, insertNode);
                startRangeNode.removeChild(textNode);
            }
			else {
				if (startRangeNode.tagName.toLowerCase() == 'html') {
					startRangeNode = startRangeNode.childNodes[0].nextSibling;
					afterNode = startRangeNode.childNodes[0];
				}
				else {
					afterNode = startRangeNode.childNodes[startRangeOffset];
				}
				startRangeNode.insertBefore(insertNode, afterNode);
            }
            newRange.setEnd(afterNode, 0);
            newRange.setStart(afterNode, 0);
        }
        YuZi_SELECTION.addRange(newRange);
	}
}

//清洁代码
function ClearCode(){
	var htmlStr = YuZi_EDITFORM_DOCUMENT.body.innerHTML;
	htmlStr = htmlStr.replace(/\<p>/gi,"[$p]");
	htmlStr = htmlStr.replace(/\<\/p>/gi,"[$\/p]");
	htmlStr = htmlStr.replace(/\<br>/gi,"[$br]");
	htmlStr = htmlStr.replace(/\<[^>]*>/g,"");
	htmlStr = htmlStr.replace(/\[\$p\]/gi,"<p>");
	htmlStr = htmlStr.replace(/\[\$\/p\]/gi,"<\/p>");
	htmlStr = htmlStr.replace(/\[\$br\]/gi,"<br>");
	YuZi_EDITFORM_DOCUMENT.body.innerHTML = htmlStr;
}

//非IE浏览器文字背景颜色
function BBSXPExecuteBackColor(value) {
	var startRangeNode = YuZi_RANGE.startContainer;
	if (startRangeNode.nodeType == 3) {
		var parent = startRangeNode.parentNode;
		var element = document.createElement("font");
		element.style.backgroundColor = value;
		element.appendChild(YuZi_RANGE.extractContents());
		var startRangeOffset = YuZi_RANGE.startOffset;
		var newRange = document.createRange();
		var afterNode;
		var textNode = startRangeNode;
		startRangeNode = textNode.parentNode;
		var text = textNode.nodeValue;
		var textBefore = text.substr(0, startRangeOffset);
		var textAfter = text.substr(startRangeOffset);
		var beforeNode = document.createTextNode(textBefore);
		var afterNode = document.createTextNode(textAfter);
		startRangeNode.insertBefore(afterNode, textNode);
		startRangeNode.insertBefore(element, afterNode);
		startRangeNode.insertBefore(beforeNode, element);
		startRangeNode.removeChild(textNode);
		newRange.setEnd(afterNode, 0);
		newRange.setStart(afterNode, 0);
		YuZi_SELECTION.addRange(newRange);
	}
}

function BBSXPExecuteValue(cmd, value)
{
	if (value == 'YuZi_BackColor') {
		value = YuZi_BackColor;
		if (YuZi_BROWSER == 'IE') {
			YuZi_EDITFORM_DOCUMENT.execCommand(cmd, false, value);
		}
		else {
			BBSXPSelection();
			BBSXPExecuteBackColor(value);
		}
	}
	else {
		if (value == 'YuZi_ForeColor') value = YuZi_ForeColor;
		YuZi_EDITFORM_DOCUMENT.execCommand(cmd, false, value);
	}
}
function BBSXPSimpleExecute(cmd,option)
{
	BBSXPEditorForm.focus();
	YuZi_EDITFORM_DOCUMENT.execCommand(cmd,true,option);
	BBSXPDisableMenu();
}

//格式实现
function BBSXPExecute(cmd, value)
{
	switch (cmd)
	{
		case 'InsertInputText':
			BBSXPSimpleExecute('InsertInputText');
			break;
		case 'InsertTextArea':
			BBSXPSimpleExecute('InsertTextArea');
			break;
		case 'InsertInputRadio':
			BBSXPSimpleExecute('InsertInputRadio');
			break;
		case 'InsertCheckbox':
			BBSXPSimpleExecute('InsertInputCheckbox');
			break;
		case 'InsertSelectDropdown':
			BBSXPSimpleExecute('InsertSelectDropdown');
			break;
		case 'InsertButton':
			BBSXPSimpleExecute('InsertButton');
			break;
		case 'Break':
			BBSXPEditorForm.focus();
			BBSXPSelection();
			var element = document.createElement("br");
			BBSXPInsertItem(element);
			BBSXPDisableMenu();
			break;
		case 'YuZi_PRINT':
			BBSXPSimpleExecute('print');
			break;
		case 'YuZi_UNDO':
			BBSXPSimpleExecute('undo');
			break;
		case 'YuZi_REDO':
			BBSXPSimpleExecute('redo');
			break;
		case 'YuZi_CUT':
			YuZi_BROWSER == 'IE' ? BBSXPSimpleExecute('cut') : alert(YuZi_LANG['CopyPaste']);
			break;
		case 'YuZi_COPY':
			YuZi_BROWSER == 'IE' ? BBSXPSimpleExecute('copy') : alert(YuZi_LANG['CopyPaste']);
			break;
		case 'YuZi_PASTE':
			YuZi_BROWSER == 'IE' ? BBSXPSimpleExecute('paste') : alert(YuZi_LANG['CopyPaste']);
			break;
		case 'YuZi_SELECTALL':
			BBSXPSimpleExecute('selectall');
			break;
		case 'YuZi_UNSELECT':
			BBSXPSimpleExecute('unselect');
			break;
		case 'YuZi_Paragraph':
			BBSXPSimpleExecute('InsertParagraph');
			break;
		case 'YuZi_Delete':
			BBSXPSimpleExecute('Delete');
			break;
		case 'YuZi_SUBSCRIPT':
			BBSXPSimpleExecute('subscript');
			break;
		case 'YuZi_SUPERSCRIPT':
			BBSXPSimpleExecute('superscript');
			break;
		case 'YuZi_BOLD':
			BBSXPSimpleExecute('bold');
			break;
		case 'YuZi_ITALIC':
			BBSXPSimpleExecute('italic');
			break;
		case 'YuZi_UNDERLINE':
			BBSXPSimpleExecute('underline');
			break;
		case 'YuZi_STRIKE':
			BBSXPSimpleExecute('strikethrough');
			break;
		case 'YuZi_JUSTIFYLEFT':
			BBSXPSimpleExecute('justifyleft');
			break;
		case 'YuZi_JUSTIFYCENTER':
			BBSXPSimpleExecute('justifycenter');
			break;
		case 'YuZi_JUSTIFYRIGHT':
			BBSXPSimpleExecute('justifyright');
			break;
		case 'YuZi_JUSTIFYFULL':
			BBSXPSimpleExecute('justifyfull');
			break;
		case 'YuZi_NUMBEREDLIST':
			BBSXPSimpleExecute('insertorderedlist');
			break;
		case 'YuZi_UNORDERLIST':
			BBSXPSimpleExecute('insertunorderedlist');
			break;
		case 'YuZi_INDENT':
			BBSXPSimpleExecute('indent');
			break;
		case 'YuZi_OUTDENT':
			BBSXPSimpleExecute('outdent');
			break;
		case 'YuZi_REMOVE':
			BBSXPSimpleExecute('removeformat');
			break;
		case 'YuZi_ClearUP':
			ClearCode();
			break;
		case 'YuZi_TITLE':
			BBSXPDisplayMenu(cmd);
			break;
		case 'YuZi_TITLE_END':
			BBSXPEditorForm.focus();
			value = '<' + value + '>';
			BBSXPSelect();
			BBSXPExecuteValue('FormatBlock', value);
			BBSXPDisableMenu();
			break;
		case 'YuZi_FONTNAME':
			BBSXPDisplayMenu(cmd);
			break;
		case 'YuZi_FONTNAME_END':
			BBSXPEditorForm.focus();
			BBSXPSelect();
			BBSXPExecuteValue('fontname', value);
			BBSXPDisableMenu();
			break;
		case 'YuZi_FONTSIZE':
			BBSXPDisplayMenu(cmd);
			break;
		case 'YuZi_FONTSIZE_END':
			BBSXPEditorForm.focus();
			value = value.substr(0, 1);
			BBSXPSelect();
			BBSXPExecuteValue('fontsize', value);
			BBSXPDisableMenu();
			break;
		case 'YuZi_TEXTCOLOR':
			BBSXPDisplayMenu(cmd);
			break;
		case 'YuZi_TEXTCOLOR_END':
			BBSXPEditorForm.focus();
			BBSXPSelect();
			BBSXPExecuteValue('ForeColor', value);
			BBSXPDisableMenu();
			document.getElementById('YuZi_TEXTCOLORBar').style.background = value;
			YuZi_ForeColor = value;
			break;
		case 'YuZi_BGCOLOR':
			BBSXPDisplayMenu(cmd);
			break;
		case 'YuZi_BGCOLOR_END':
			BBSXPEditorForm.focus();
			if (YuZi_BROWSER == 'IE') {
				BBSXPSelect();
				BBSXPExecuteValue('BackColor', value);
			} else {
				BBSXPExecuteBackColor(value)
			}
			BBSXPDisableMenu();
			document.getElementById('YuZi_BGCOLORBar').style.background = value;
			YuZi_BackColor = value;
			break;
		case 'YuZi_ICON':
			BBSXPDisplayMenu(cmd);
			document.getElementById('POPUP_'+cmd).innerHTML = BBSXPCube();
			break;
		case 'YuZi_ICON_END':
			BBSXPEditorForm.focus();
			var element = document.createElement("img");
			element.src = value;
			element.border = 0;
			BBSXPSelect();
			BBSXPInsertItem(element);
			BBSXPDisableMenu();
			break;
		case 'YuZi_Replace':
			BBSXPDisplayMenu(cmd);
			BBSXPReplaceIframe.focus();
			YuZi_Replace_DOCUMENT.getElementById(cmd+'submitButton').focus();
			break;
		case 'YuZi_IMAGE':
			BBSXPDisplayMenu(cmd);
			BBSXPImageIframe.focus();
			YuZi_IMAGE_DOCUMENT.getElementById(cmd+'submitButton').focus();
			break;
		case 'YuZi_Media':
			BBSXPDisplayMenu(cmd);
			BBSXPMediaIframe.focus();
			YuZi_Media_DOCUMENT.getElementById(cmd+'submitButton').focus();
			break;
		case 'YuZi_LINK':
			if (YuZi_BROWSER == 'IE') {
				BBSXPSimpleExecute('createLink');
			}
			else {
				BBSXPDisplayMenu(cmd);
				BBSXPLinkIframe.focus();
				YuZi_LINK_DOCUMENT.getElementById(cmd+'submitButton').focus();
			}
			break;
		case 'YuZi_UNLINK':
			BBSXPSimpleExecute('unlink');
			break;
		case 'YuZi_SPECIALCHAR':
			BBSXPDisplayMenu(cmd);
			break;
		case 'YuZi_SPECIALCHAR_END':
			BBSXPEditorForm.focus();
			BBSXPSelect();
			var element = document.createElement("span");
			element.appendChild(document.createTextNode(value));
			BBSXPInsertItem(element);
			BBSXPDisableMenu();
			break;
		case 'YuZi_TABLE':
			BBSXPDisplayMenu(cmd);
			break;
		case 'YuZi_TABLE_END':
			BBSXPEditorForm.focus();
			var location = value.split(',');
			var element = document.createElement("table");
			element.cellPadding = 0;
			element.cellSpacing = 0;
			element.border = 1;
			element.style.width = "100%";
			for (var i = 0; i < location[0]; i++) {
				var rowElement = element.insertRow(i);
				for (var j = 0; j < location[1]; j++) {
					var cellElement = rowElement.insertCell(j);
					cellElement.innerHTML = "&nbsp;";
				}
			}
			BBSXPSelect();
			BBSXPInsertItem(element);
			BBSXPDisableMenu();
			break;
		case 'YuZi_HR':
			BBSXPDisplayMenu(cmd);
			break;
		case 'YuZi_HR_END':
			BBSXPEditorForm.focus();
			var element = document.createElement("hr");
			element.width = "100%";
			element.color = value;
			element.size = 1;
			BBSXPSelect();
			BBSXPInsertItem(element);
			BBSXPDisableMenu();
			break;
		case 'YuZi_DATE':
			BBSXPEditorForm.focus();
			BBSXPSelection();
			var element = document.createElement("span");
			element.appendChild(document.createTextNode(new Date().toLocaleDateString()));
			BBSXPInsertItem(element);
			BBSXPDisableMenu();
			break;
		case 'YuZi_TIME':
			BBSXPEditorForm.focus();
			BBSXPSelection();
			var element = document.createElement("span");
			element.appendChild(document.createTextNode(new Date().toLocaleTimeString()));
			BBSXPInsertItem(element);
			BBSXPDisableMenu();
			break;
		case 'YuZi_QUOTE':
			BBSXPEditorForm.focus();
			var element = document.createElement("span");
			element.innerHTML = value;
			BBSXPSelection();
			BBSXPInsertItem(element);
			BBSXPDisableMenu();
			BBSXPReloadIframe();	
			break;
		default:
			break;
	}
}
// 改变模式：代码、编辑
function setMode(NewMode){
	if(NewMode!=YuZi_CurrentMode){
		YuZi_IsChangeMode = true;
		var obj=document.getElementById("BBSXPEditorIframe");
		if(YuZi_TdHeight == -1)YuZi_TdHeight = parseInt(obj.offsetHeight);
		switch(NewMode){
			case 'DESIGN':
				obj.style.height = (parseInt(obj.offsetHeight) - 81) + 'px';
		
				YuZi_EDITFORM_DOCUMENT.body.innerHTML = BBSXPClearScriptTag(document.getElementById("BBSXPCodeForm").value);
				document.getElementById("BBSXPEditorForm").style.display = 'block';
				document.getElementById("BBSXPToolBar").style.display = 'block';
				document.getElementById("BBSXPCodeForm").style.display = 'none';
				
				var EditorFormObject =document.getElementById("BBSXPEditorForm");
				EditorFormObject.style.height = parseInt(obj.offsetHeight) + 'px';
				if (parseInt(EditorFormObject.offsetHeight)< YuZi_TdHeight){EditorFormObject.style.height = YuZi_TdHeight + 'px';}

				break;
			case 'CODE':
				obj.style.height = (parseInt(obj.offsetHeight) + 77) + 'px';
				
				document.getElementById("BBSXPCodeForm").value = BBSXPHtmlToXhtml(YuZi_EDITFORM_DOCUMENT.body.innerHTML);
				document.getElementById("BBSXPToolBar").style.display = 'none';
				document.getElementById("BBSXPEditorForm").style.display = 'none';
				document.getElementById("BBSXPCodeForm").style.display = 'block';
				document.getElementById("BBSXPCodeForm").focus();
				
				var CodeFormObject=document.getElementById("BBSXPCodeForm");
				CodeFormObject.style.height = parseInt(obj.offsetHeight) + 'px';
				if (parseInt(CodeFormObject.offsetHeight)< YuZi_TdHeight){CodeFormObject.style.height = YuZi_TdHeight + 'px';}

				break;
			default:
				break;
		}
		if (parseInt(obj.offsetHeight)< YuZi_TdHeight){obj.style.height = YuZi_TdHeight + 'px';}
		try{
			document.getElementById("HtmlEditor_DESIGN").className = "StatusBarBtnOff";
			document.getElementById("HtmlEditor_CODE").className = "StatusBarBtnOff";
			document.getElementById("HtmlEditor_"+NewMode).className = "StatusBarBtnOn";
		}
		catch(e){
		}
		YuZi_CurrentMode = NewMode;
	}
}

// 调整编辑器的大小
function ChangeSize(size){
	var obj=document.getElementById("BBSXPEditorIframe");
	if(YuZi_TdHeight == -1)YuZi_TdHeight = parseInt(obj.offsetHeight);
	obj.style.height = (parseInt(obj.offsetHeight) + size) + 'px';
	if (parseInt(obj.offsetHeight)< YuZi_TdHeight){obj.style.height = YuZi_TdHeight + 'px';}
	
	if (YuZi_IsChangeMode) {
		if (YuZi_CurrentMode == 'DESIGN') {
			obj=document.getElementById("BBSXPEditorForm");
			obj.style.height = (parseInt(obj.offsetHeight) + size) + 'px';
			if (parseInt(obj.offsetHeight)< YuZi_TdHeight){obj.style.height = YuZi_TdHeight + 'px';}
		}
		else {
			if (parseInt(obj.offsetHeight)< YuZi_TdHeight+77){obj.style.height = (YuZi_TdHeight+77) + 'px';}
			
			obj=document.getElementById("BBSXPCodeForm");
			obj.style.height = (parseInt(obj.offsetHeight) + size) + 'px';
			if (parseInt(obj.offsetHeight)< YuZi_TdHeight+77){obj.style.height = (YuZi_TdHeight+77) + 'px';}
		}
	}
}

//编辑器工具栏各图标按钮
function BBSXPCreateIcon(icon)
{
	var str;
	if (icon[0] == 'YuZi_TEXTCOLOR' || icon[0] == 'YuZi_BGCOLOR') {
		if (icon[0] == 'YuZi_TEXTCOLOR')
			ExecuteCMD = 'ForeColor';
		else
			ExecuteCMD = 'BackColor';
		
		str = '<div style="POSITION: relative;border:1px solid ' + YuZi_TOOLBAR_BG_COLOR +';cursor:pointer;height:20px;width:28px" onmouseover="document.getElementById(\''+icon[0]+'RightBar\').style.borderLeft = this.style.border=\'1px solid ' + YuZi_MENU_BORDER_COLOR + '\';" onmouseout="document.getElementById(\''+icon[0]+'RightBar\').style.borderLeft = this.style.border=\'1px solid ' + YuZi_TOOLBAR_BG_COLOR + '\';" title="' + icon[2]  + '">';
		str += '<img src="' + YuZi_SKIN_PATH  + icon[1] +'" onclick="BBSXPExecuteValue(\''+ExecuteCMD+'\',\'YuZi_'+ExecuteCMD+'\');">';
		str += '<img id="'+icon[0]+'Bar" style="BACKGROUND: '+eval("YuZi_"+ExecuteCMD)+'; LEFT: 1px; POSITION: absolute; TOP: 15px" height=4 src="' + YuZi_SKIN_PATH  +'clear.gif" width=16 onclick="BBSXPExecuteValue(\''+ExecuteCMD+'\',\'YuZi_'+ExecuteCMD+'\');">';
		str += '<div id="'+icon[0]+'RightBar" style="POSITION: absolute;left:17px;top:0px;border-left:1px solid '+YuZi_TOOLBAR_BG_COLOR+';height:18px"><img id="'+ icon[0] +'" src="' + YuZi_SKIN_PATH + 'PopMenu.gif" alt="' + icon[2]  + '" align="absmiddle" onclick="BBSXPExecute(\''+ icon[0] +'\');"></div>';
		str += '</div>';
	}
	else {
		str = '<img id="'+ icon[0] +'" src="' + YuZi_SKIN_PATH + icon[1] + '" alt="' + icon[2]  + 
			'" align="absmiddle" style="border:1px solid ' + YuZi_TOOLBAR_BG_COLOR +';cursor:pointer;height:20px;';
		str += '" onclick="BBSXPExecute(\''+ icon[0] +'\');" '+
			'onmouseover="this.style.border=\'1px solid ' + YuZi_MENU_BORDER_COLOR + '\';" ' +
			'onmouseout="this.style.border=\'1px solid ' + YuZi_TOOLBAR_BG_COLOR + '\';" ';
		str += '>';
	}
	return str;
}
//编辑器工具栏
function BBSXPCreateToolbar()
{
	var htmlData = '<table cellpadding="0" cellspacing="0" border="0" height="26"><tr>';
	
	for (i = 0; i < YuZi_TOP_TOOLBAR_ICON.length; i++) {
		htmlData += '<td style="padding:2px;">' + BBSXPCreateIcon(YuZi_TOP_TOOLBAR_ICON[i]) + '</td>';
	}
		
	htmlData += '</tr></table><table cellpadding="0" cellspacing="0" border="0" height="26"><tr>';
	for (i = 0; i < YuZi_MIDDLE_TOOLBAR_ICON.length; i++) {
		htmlData += '<td style="padding:2px;">' + BBSXPCreateIcon(YuZi_MIDDLE_TOOLBAR_ICON[i]) + '</td>';
	}
		
	htmlData += '</tr></table><table cellpadding="0" cellspacing="0" border="0" height="26"><tr>';
	for (i = 0; i < YuZi_BOTTOM_TOOLBAR_ICON.length; i++) {
		htmlData += '<td style="padding:2px;">' + BBSXPCreateIcon(YuZi_BOTTOM_TOOLBAR_ICON[i]) + '</td>';
	}
		
	htmlData += '</tr></table>';
	return htmlData;
}

function BBSXPWriteFullHtml(documentObj, content)
{
	var editHtmlData = '';
	editHtmlData += '<html>\r\n<head>\r\n<title>BBSXP Editor --Powered By BBSXP</title>\r\n';
	editHtmlData += '<style type="text/css">\r\n\tbody { font-family:Courier New;font-size:12px;margin:2px;}\r\n\tBLOCKQUOTE {BORDER: #cccccc 1px dotted; PADDING: 4px; MARGIN: 16px;}\r\n</style>\r\n';
	editHtmlData += '</head>\r\n<body>\r\n';
	editHtmlData += content;
	editHtmlData += '\r\n</body>\r\n</html>\r\n';
	documentObj.open();
	documentObj.write(editHtmlData);
	documentObj.close();
}

//编辑器主函数
function BBSXPEditor(objName) 
{
	this.objName = objName;
	this.hiddenName = objName;
	this.safeMode;
	this.editorWidth;
	this.editorHeight;
	this.iconPath;
	this.menuBorderColor;
	this.menuBgColor;
	this.menuTextColor;
	this.menuSelectedColor;
	this.toolbarBorderColor;
	this.toolbarBgColor;
	this.formBorderColor;
	this.formBgColor;
	this.buttonColor;
	this.init = function()
	{
		if (this.safeMode) YuZi_SAFE_MODE = this.safeMode;
		if (this.editorWidth) YuZi_WIDTH = this.editorWidth;
		if (this.editorHeight) YuZi_HEIGHT = this.editorHeight;
		if (this.menuBorderColor) YuZi_MENU_BORDER_COLOR = this.menuBorderColor;
		if (this.menuBgColor) YuZi_MENU_BG_COLOR = this.menuBgColor;
		if (this.menuTextColor) YuZi_MENU_TEXT_COLOR = this.menuTextColor;
		if (this.menuSelectedColor) YuZi_MENU_SELECTED_COLOR = this.menuSelectedColor;
		if (this.toolbarBorderColor) YuZi_TOOLBAR_BORDER_COLOR = this.toolbarBorderColor;
		if (this.toolbarBgColor) YuZi_TOOLBAR_BG_COLOR = this.toolbarBgColor;
		if (this.formBorderColor) YuZi_FORM_BORDER_COLOR = this.formBorderColor;
		if (this.formBgColor) YuZi_FORM_BG_COLOR = this.formBgColor;
		if (this.buttonColor) YuZi_BUTTON_COLOR = this.buttonColor;
		YuZi_OBJ_NAME = this.objName;
		YuZi_BROWSER = BBSXPGetBrowser();
	}
	this.show = function()
	{
		this.init();
		var widthStyle = 'width:' + YuZi_WIDTH + ';';
		var heightStyle = 'height:' + YuZi_HEIGHT + ';';
		if (YuZi_BROWSER == '') {
			var htmlData = '<div id="BBSXPEditorIframe" style="' + widthStyle + heightStyle +';background-color:'+ YuZi_FORM_BG_COLOR +'">' +
			'<textarea name="BBSXPCodeForm" id="BBSXPCodeForm" style="' + widthStyle + heightStyle + 
			'padding:0;margin:0;border:1px solid '+ YuZi_FORM_BORDER_COLOR + 
			';font-size:12px;line-height:16px;font-family:'+YuZi_FONT_FAMILY+';background-color:'+ 
			YuZi_FORM_BG_COLOR +';">' + document.getElementsByName(this.hiddenName)[0].value + '</textarea></div>';
			document.open();
			document.write(htmlData);
			document.close();
			return;
		}
		var htmlData = '<style>TD.StatusBarBtnOff {padding:1px 5px;border:1px outset;cursor:pointer;}TD.StatusBarBtnOn {padding:1px 5px;border:1px inset;background-color: #EEEEEE;}</style>';
		
		htmlData += '<div id=BBSXPToolBar style="'+widthStyle+';border:1px solid ' + YuZi_TOOLBAR_BORDER_COLOR + ';border-bottom:0;background-color:'+ YuZi_TOOLBAR_BG_COLOR +'">';
		htmlData += BBSXPCreateToolbar();
		htmlData += '</div><div id="BBSXPEditorIframe" style="' + widthStyle + heightStyle + 
			'border:1px solid '+ YuZi_FORM_BORDER_COLOR +';background-color:'+ YuZi_FORM_BG_COLOR +'">' +
			'<iframe name="BBSXPEditorForm" id="BBSXPEditorForm" style="' + widthStyle + heightStyle + 
			'padding:0;margin:0;border:0;"></iframe>';

		
		htmlData += '<textarea name="BBSXPCodeForm" id="BBSXPCodeForm" style="' + widthStyle + heightStyle + 
				'padding:0;margin:0;border:0;font-size:12px;display:none;line-height:16px;font-family:'+YuZi_FONT_FAMILY+';background-color:'+ 
		YuZi_FORM_BG_COLOR +';" onclick="javascirit:parent.BBSXPDisableMenu();"></textarea></div>';
		
		htmlData += '<table border=0 cellpadding=0 cellspacing=0 height=20 style="margin-top:5px;">';
		htmlData += '<tr>';
		htmlData += '<td class=StatusBarBtnOn id=HtmlEditor_DESIGN onclick="setMode(\'DESIGN\')"><img border=0 src=Editor/Button/modeedit.gif align=absmiddle alt="'+YuZi_LANG['DesignMode']+'"></td>';
		htmlData += '<td width=5>&nbsp;</td>';
		htmlData += '<td class=StatusBarBtnOff id=HtmlEditor_CODE onclick="setMode(\'CODE\')"><img border=0 src=Editor/Button/modecode.gif align=absmiddle alt="'+YuZi_LANG['CodeMode']+'"></td>';
		htmlData += '<td width=5>&nbsp;</td>';
		htmlData += '<td align=right width=100%><img border=0 src=Editor/Button/+.gif align=absmiddle onclick=ChangeSize(100) style=cursor:pointer title="'+YuZi_LANG['AddEditorArea']+'"><img border=0 src=Editor/Button/-.gif align=absmiddle onclick=ChangeSize(-100) style=cursor:pointer title="'+YuZi_LANG['ReduceEditorArea']+'"></td>';
		htmlData += '</tr></table>';
		
		for (var i = 0; i < YuZi_POPUP_MENU_TABLE.length; i++) {
			if (YuZi_POPUP_MENU_TABLE[i] == 'YuZi_Replace') {
				htmlData += '<span id="InsertIframe">';
			}
			htmlData += BBSXPPopupMenu(YuZi_POPUP_MENU_TABLE[i]);
			if (YuZi_POPUP_MENU_TABLE[i] == 'YuZi_Media') {
				htmlData += '</span>';
			}
		}
		document.open();
		document.write(htmlData);
		document.close();
		if (YuZi_BROWSER == 'IE') {
			YuZi_EDITFORM_DOCUMENT = document.frames("BBSXPEditorForm").document;
		} else {
			YuZi_EDITFORM_DOCUMENT = document.getElementById('BBSXPEditorForm').contentDocument;
		}
		BBSXPDrawIframe('YuZi_Replace');
		BBSXPDrawIframe('YuZi_IMAGE');
		BBSXPDrawIframe('YuZi_Media');
		BBSXPDrawIframe('YuZi_LINK');
		YuZi_EDITFORM_DOCUMENT.designMode = 'On';
		YuZi_CurrentMode = "DESIGN";
		BBSXPWriteFullHtml(YuZi_EDITFORM_DOCUMENT, document.getElementsByName(eval(YuZi_OBJ_NAME).hiddenName)[0].value);
		var el = YuZi_EDITFORM_DOCUMENT.body;
		
		if (YuZi_EDITFORM_DOCUMENT.addEventListener){
			YuZi_EDITFORM_DOCUMENT.addEventListener('click', BBSXPDisableMenu, false);
			YuZi_EDITFORM_DOCUMENT.addEventListener('keypress', ctlent, true);
		} else if (el.attachEvent){
			el.attachEvent('onclick', BBSXPDisableMenu);
			el.attachEvent('onkeypress', ctlent);
		}
	}
	this.data = function()
	{
		var htmlResult;
		if (YuZi_BROWSER == '') {
			htmlResult = document.getElementById("BBSXPCodeForm").value;
		}
		else {
			if (YuZi_CurrentMode.toLowerCase() == 'design') {
				htmlResult = YuZi_EDITFORM_DOCUMENT.body.innerHTML;
			}
			else {
				htmlResult = document.getElementById("BBSXPCodeForm").value;
			}
		}
		BBSXPDisableMenu();
		htmlResult = BBSXPHtmlToXhtml(htmlResult);
		htmlResult = BBSXPClearScriptTag(htmlResult);
		
		htmlResult = ChangeImgPath(htmlResult);
		
		document.getElementsByName(this.hiddenName)[0].value = htmlResult;
		return htmlResult;
	}
}

//初始化编辑器
var editor = new BBSXPEditor("editor");
editor.hiddenName = "Body";
editor.show();

function ChangeImgPath(str){
	var url = location.href;
	var siteUrl = url.split("/");
	siteUrl.length = siteUrl.length-1;
	var siteStr = siteUrl.join("/") +"/";
	var re=new RegExp(siteStr,'ig');
	return str.replace(re,"");
}

// 预览
function Preview()
{
	editor.data();
	Subject=document.form.Subject
	Body=document.form.Body

 	if(typeof(Subject) != "undefined" ){
		if(Subject.value.length<2){alert(YuZi_LANG['SubjectMinLen']);return false;}
  	}

 	if(typeof(Body) != "undefined" ){
		if(Body.value.length<2){alert(YuZi_LANG['BodyMinLen']);return false;}
		if(Body.value.length>60000){alert(YuZi_LANG['BodyMaxLen']);return false;}
  	}

	document.getElementById('Preview').style.display = '';
	Ajax_CallBack('form','Preview','Loading.asp?menu=Preview');
	window.location="#Preview";
}

//内容提交
function CheckForm() {
	if(YuZi_CurrentMode.toLowerCase() != 'design'){
		alert(YuZi_LANG['CurrentMode']);
		return false;
	}
	
	editor.data();
	Subject=document.form.Subject;
	Body=document.form.Body;
	VerifyCode=document.form.VerifyCode;

 	if(typeof(Subject) != "undefined" ){
		if(Subject.value.length<2){alert(YuZi_LANG['SubjectMinLen']);return false;}
  	}

 	if(typeof(Body) != "undefined" ){
		if(Body.value.length<2){alert(YuZi_LANG['BodyMinLen']);return false;}
		if(Body.value.length>60000){alert(YuZi_LANG['BodyMaxLen']);return false;}
  	}
	
	if(typeof(VerifyCode) != "undefined" ){
		if(VerifyCode.value.length<4){alert(YuZi_LANG['VerifyCode']);return false;}
  	}
}
//检测文章长度
function CheckLength(){
	editor.data();
	MessageLength=document.form.Body.value.length;
	alert("最大字符为 "+60000+ " 字节\n您的内容已有 "+MessageLength+" 字节");
}

//Ctrl + Enter 发帖
function ctlent(event){
	if(YuZi_CurrentMode.toLowerCase() != 'design'){
		alert(YuZi_LANG['CurrentMode']);
		return false;
	}
	else if(event.ctrlKey && (event.keyCode==13 || event.keyCode==10)){
		parent.document.form.EditSubmit.click();
	}
}