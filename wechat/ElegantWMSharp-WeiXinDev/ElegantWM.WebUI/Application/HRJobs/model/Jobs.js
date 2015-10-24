Ext.define('WMC.model.Jobs', {
    extend: 'Ext.data.Model',
    fields: [
		'Id',
		'JobName',
        'JobSeekers',
		'NeedNum',
		'Responsibilities',
		'Skills',
		'Email',
		'IsShow',
		'IsTop',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d H:m:s').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d H:m:s').toString(); } }
    ]
});