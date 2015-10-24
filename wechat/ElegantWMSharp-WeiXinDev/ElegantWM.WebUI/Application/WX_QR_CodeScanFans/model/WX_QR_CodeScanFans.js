Ext.define('WMC.model.WX_QR_CodeScanFans', {
    extend: 'Ext.data.Model',
    fields: [
		
		'Id',
		'AccountId',
		'Oid',
		'Scene_ID',
		'Scene_Key',
		'Scene_Name',
		'Scene_Param1',
		'Scene_Param2',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});