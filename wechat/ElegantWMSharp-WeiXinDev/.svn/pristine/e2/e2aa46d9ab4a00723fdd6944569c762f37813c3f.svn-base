Ext.define('WMC.model.ITSMBasicInfo', {
    extend: 'Ext.data.Model',
    fields: [
		
		'Id',
		'BIType',
		'BIValue',
		'BIndex',
		'TntId',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});