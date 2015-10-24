Ext.define('WMC.model.WXContacts', {
    extend: 'Ext.data.Model',
    fields: [
		
		'Id',
		'AccountId',
		'fake_id',
		'nick_name',
		'remark_name',
		'signature',
		'city',
		'province',
		'country',
		'groupName',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});