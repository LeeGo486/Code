Ext.define('WMC.model.WXLKRegMemberFans', {
    extend: 'Ext.data.Model',
    fields: [
		
		'Id',
		'AccountId',
		'Telphone',
		'OpenId',
		'IsUsing',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});