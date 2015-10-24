Ext.define('WMC.model.HRQARst', {
    extend: 'Ext.data.Model',
    fields: [
		
		'Id',
		'Cid',
		'Qid',
		'Uid',
		'Result',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});