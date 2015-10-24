Ext.define('WMC.model.HRCourseUser', {
    extend: 'Ext.data.Model',
    fields: [
		
		'Id',
		'UserName',
		'EmployeeID',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d H:i:s').toString(); } }
    ]
});