Ext.define('WMC.model.WXFans', {
    extend: 'Ext.data.Model',
    fields: [
		
		'Id',
		'AccountId',
		'OpenId',
		'NickName',
		'Sex',
		'City',
		'Province',
		'Country',
		'Avatar',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});