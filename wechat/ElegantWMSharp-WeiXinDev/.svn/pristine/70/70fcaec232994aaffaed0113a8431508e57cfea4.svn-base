Ext.define('Ext.calendar.data.Events', {

    statics: {
        getData: function() {
            var today = Ext.Date.clearTime(new Date()), 
                makeDate = function(d, h, m, s) {
                    d = d * 86400;
                    h = (h || 0) * 3600;
                    m = (m || 0) * 60;
                    s = (s || 0);
                    return Ext.Date.add(today, Ext.Date.SECOND, d + h + m + s);
                };

            //Ext.Ajax.request({
            //    url: '/Admin/ITSMEgrSchedule/Get',
            //    method: 'GET',
            //    scope: this,
            //    success: function (response) {
            //        console.log(eval('(' + response.responseText + ')'));
            //    },
            //    failure: function (response) {
            //        Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            //    }
            //});
            return {

                "evts": [{
                    "Id": 'BC47DA55-D687-4E46-A708-1738EA08BDD5',
                    "CategoryId": "1",
                    "EventTitle": "王梁",
                    "StartDate": '/Date(1404835200000)/',
                    "EndDate": '/Date(1404835200000)/',
                    "Location": "Have fun",
                    "LinkUrl": "Have fun",
                    "Note": "Have fun",
                    "IsAllDay": true,
                    "Reminder": "15"
                }]
            }
        }
    }
});
