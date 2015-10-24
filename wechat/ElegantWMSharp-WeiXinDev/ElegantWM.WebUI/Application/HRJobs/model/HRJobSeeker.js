Ext.define('WMC.model.HRJobSeeker', {
    extend: 'Ext.data.Model',
    fields: [
		'Id',
        'JobId',
		'SkrName',
		'SkrSex',
        'EmployeeId',
		'Telphone',
		'Remark',
        'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d H:m:s').toString(); } }
    ]
});