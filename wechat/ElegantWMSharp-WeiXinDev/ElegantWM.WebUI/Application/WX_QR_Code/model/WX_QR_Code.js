Ext.define('WMC.model.WX_QR_Code', {
    extend: 'Ext.data.Model',
    fields: [
		
		'Id',
		'AccountId',
		'Url',
		'Action_Name',
		'Scene_ID',
		'Scene_Name',
		'Scene_Key',
		'Scene_Param1',
		'Scene_Param2',
		'IsUsed',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});