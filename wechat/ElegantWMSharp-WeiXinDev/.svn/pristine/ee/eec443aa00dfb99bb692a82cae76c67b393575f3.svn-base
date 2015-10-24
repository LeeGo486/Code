Ext.define('WMC.model.HRQuestion', {
    extend: 'Ext.data.Model',
    fields: [
		
		'Id',
		'QsnName',
		'QsnCategory',
		'QsnType',
        'QsnSatisfactionType',
        'QsnAnswer1',
        'QsnAnswer2',
        'QsnAnswer3',
        'QsnAnswer4',
        'QsnAnswer5',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});