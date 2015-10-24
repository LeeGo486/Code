Ext.define('WMC.model.HRCourseLesson', {
    extend: 'Ext.data.Model',
    fields: [
		'Id',
		'Cid',
		'LessonName',
        'Teacher',
        'Integration',
        'Num',
        'ClassHour',
        'SatisfactionType',
		{ name: 'StartTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d H:i').toString(); } },
		{ name: 'EndTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d H:i').toString(); } }
    ]
});