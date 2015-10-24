Ext.define('WMC.model.WXKeyWord', {
    extend: 'Ext.data.Model',
    fields: [
		
		'Id',
		'AccountId',
		'KwList',
        'RespType',
		'IsUsing',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});