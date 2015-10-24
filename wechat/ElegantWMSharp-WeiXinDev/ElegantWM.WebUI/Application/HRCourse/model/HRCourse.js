Ext.define('WMC.model.HRCourse', {
    extend: 'Ext.data.Model',
    fields: [

		'Id',
		'CourseName',
		'TeacherType',
		'OrgName',
        'SignUpType',
		'Fee',
		'TrainingNum',
        'RegisterNum',
		'Venue',
		{ name: 'StartDate', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		{ name: 'EndDate', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'CourseDesc',
		'IsShow',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});