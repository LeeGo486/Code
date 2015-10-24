Ext.define('WMC.model.ITSMEngineer', {
    extend: 'Ext.data.Model',
    fields: [
		'Id',
		'EgrName',
        'EgrAmName',
        'Phone',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});