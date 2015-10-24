Ext.define('WMC.model.WXRespImgTxt', {
    extend: 'Ext.data.Model',
    fields: [
		'Id',
		'KwId',
		'Title',
		'ImageUrl',
        'AbsUrl',
        'Description',
		'Content',
        'Hits',
        'Praise',
		'IsShow',
		'IsMain',
        'OrderIndex',
		'CreateUser',
		{ name: 'CreateTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } },
		'ModifyUser',
		{ name: 'ModifyTime', convert: function (value) { return Ext.Tools.FormatDate(value, 'Y-m-d').toString(); } }
    ]
});