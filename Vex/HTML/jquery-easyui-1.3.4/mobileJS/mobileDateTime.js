
$(function () {
    var curr = new Date().getFullYear();
    var opt = {
        'date': {
            preset: 'date',
            invalid: { daysOfWeek: [0, 6], daysOfMonth: ['5/1', '12/24', '12/25'] }
        },

        'time': {
            preset: 'time'
        }
               
    }

    $('.demo-test-date').scroller('destroy').scroller($.extend(opt['date'], {
        yearText:'年',
        monthText: '月',
        dayText:'日',
        theme: 'default',   
        mode:'scroller',    
        lang: 'zh',         
        display: 'bottom',  
        animate: 'slideup'
    }));
    $('.demo-test-time').scroller('destroy').scroller($.extend(opt['time'], {
        theme: 'default',
        mode: 'scroller',
        lang: 'zh',
        display: 'bottom',
        animate: 'slideup'
    }));
});

