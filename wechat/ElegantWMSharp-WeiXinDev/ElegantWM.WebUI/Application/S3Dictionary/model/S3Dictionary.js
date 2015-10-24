Ext.define('WMC.model.S3Dictionary', {
    extend: 'Ext.data.Model',
    fields: [
		
		'Id',
		'Type',
		'Code',
		'Name',
		'Desp',
		'Seq',
		'FatherId',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});