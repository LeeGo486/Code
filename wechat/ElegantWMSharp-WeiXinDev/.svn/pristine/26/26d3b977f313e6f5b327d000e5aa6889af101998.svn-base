Ext.define('WMC.model.WXAccount', {
    extend: 'Ext.data.Model',
    fields: [
		
		'Id',
		'OpenId',
        'LoginEmail',
        'LoginPwd',
		'AppId',
		'AppSecret',
		'IsAuthed',
		'IsAccessed',
		'Token',
		'AccountName',
		'WelcomeWord',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});