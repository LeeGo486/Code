Ext.define('HRJobs.model.Jobs', {
    extend: 'Ext.data.Model',
    config: {
        idProperty:'Id',
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
        { name: 'CreateTime', convert: function (value) { return Ext.util.Format.date(eval("new " + value.substr(1, value.length - 2)).toString(), 'Y-m-d'); } }
        ]
    }
});