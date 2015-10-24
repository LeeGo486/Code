/* MarcGrabanski.com */
/* Pop-Up Calendar Built from Scratch by Marc Grabanski */
var popUpCal = {
    selectedMonth: new Date().getMonth(), // 0-11
    selectedYear: new Date().getFullYear(), // 4-digit year
    selectedDay: new Date().getDate(),
init: function () {
   $('<div id="calendarDiv"></div>').appendTo("body");
   var x = $('input.calendarSelectDate');
   var y = $('#calendarDiv');
   x.click( function () {
    popUpCal.input = $(this);
    y.hide();
    setPos(this, y); // setPos(targetObj,moveObj)
    setDateFromField();
    popUpCal.drawCalendar(); 
   });
    }, // end init function
    drawCalendar: function () {
   html = '';
   html += '<table cellpadding="0" cellspacing="0" id="linksTable"><tr>';
   html += ' <td><a id="prevYear" title="上一年">&lt;&lt;</a></td>';
   html += ' <td><a id="prevMonth" title="上个月">&lt;</a></td>';
   html += ' <td><a id="closeCalender" title="关闭">CLOSE</a></td>';
   html += ' <td><a id="nextMonth" title="下个月">&gt;</a></td>';
   html += ' <td><a id="nextYear" title="下一年">&gt;&gt;</a></td>';
   html += '</tr></table>';
   html += '<table id="calendar" cellpadding="0" cellspacing="1"><tr>';
   html += '<th colspan="7" class="calendarHeader">'+popUpCal.selectedYear+'年&nbsp;&nbsp;'+getMonthName(popUpCal.selectedMonth)+'</th>';
   html += '</tr><tr class="weekDaysTitleRow">';
        var weekDays = new Array('日','一','二','三','四','五','六');
        for (var j=0; j<weekDays.length; j++) {
    html += '<td>'+weekDays[j]+'</td>';
        }
        daysInMonth = getDaysInMonth(popUpCal.selectedYear, popUpCal.selectedMonth);
        startDay = getFirstDayofMonth(popUpCal.selectedYear, popUpCal.selectedMonth);
        numRows = 0;
        printDate = 1;
        if (startDay != 7) { numRows = Math.ceil(((startDay+1)+(daysInMonth))/7); } // calculate the number of rows to generate
        // calculate number of days before calendar starts
        (startDay != 7) ? noPrintDays = startDay + 1 : noPrintDays = 0; // if sunday print right away 
   // function with cruft for figuring out what day to highlight
   selectedDate = popUpCal.input.val().split('/');
   if (selectedDate.length == 3) {
    thisMonth = parseFloat(selectedDate[0])-1;
    thisDay = parseFloat(selectedDate[1]);
    thisYear = parseFloat(selectedDate[2]);
   } else {
    thisDay = new Date().getDate();
    thisMonth = new Date().getMonth();
    thisYear = new Date().getFullYear();
   }
        // create calendar rows
        for (var e=0; e<numRows; e++) {
    html += '<tr class="weekDaysRow">';
            // create calendar days
            for (var f=0; f<7; f++) {
     if ( (printDate == thisDay) 
      && (popUpCal.selectedYear == thisYear) 
      && (popUpCal.selectedMonth == thisMonth) 
      && (noPrintDays == 0)) {
      html += '<td id="today" class="weekDaysCell">';
     } else {
                html += '<td class="weekDaysCell">';
     }
                if (noPrintDays == 0) {
      if (printDate <= daysInMonth) {
       html += '<a>'+printDate+'</a>';
      }
                    printDate++;
                }
                html += '</td>';
                if(noPrintDays > 0) noPrintDays--;
            }
            html += '</tr>';
        }
   html += '</table>';

        // add calendar to element to calendar Div
        var calendarDiv = $('#calendarDiv');
   calendarDiv.empty().append(html).show();
   popUpCal.setupLinks();
        // close button link
        $('#closeCalender').click( function () {
            calendarDiv.hide();
        });
   // setup next and previous links
   $('#prevMonth').click( function () {
            popUpCal.selectedMonth--;
            if (popUpCal.selectedMonth < 0) {
                popUpCal.selectedMonth = 11;
                popUpCal.selectedYear--;
            }
            popUpCal.drawCalendar(); 
        });
   $('#nextMonth').click( function () {
    popUpCal.selectedMonth++;
            if (popUpCal.selectedMonth > 11) {
                popUpCal.selectedMonth = 0;
                popUpCal.selectedYear++;
            }
            popUpCal.drawCalendar(); 
        });
        $('#prevYear').click( function () {
            popUpCal.selectedYear--;
            popUpCal.drawCalendar(); 
        });
   $('#nextYear').click( function () {
    popUpCal.selectedYear++;
            popUpCal.drawCalendar(); 
        });
    }, // end drawCalendar function
    setupLinks: function () {
        // set up link events on calendar table
        var x = $('#calendar a');
   x.mouseover( function () {
    this.parentNode.className = 'weekDaysCellOver';
   });
   x.mouseout( function () {
    this.parentNode.className = 'weekDaysCell';
        });
   x.click( function () {
            $('#calendarDiv').hide();
            popUpCal.selectedDay = $(this).html();
            setVal = formatDate(popUpCal.selectedDay, popUpCal.selectedMonth, popUpCal.selectedYear);
            popUpCal.input.val(setVal);  
            popUpCal.input.change();
        });
    } // end setupLinks function
}
// Initialize the calendar
$(document).ready(function(){
   popUpCal.init();
});
/* Functions Dealing with Dates */
function formatDate(Day, Month, Year) {
    Month++; // adjust javascript month
    if (Month <10) Month = '0'+Month; // add a zero if less than 10
    if (Day < 10) Day = '0'+Day; // add a zero if less than 10
    var dateString = Year+'-'+Month+'-'+Day;
    return dateString;
}
function setDateFromField() {
selectedDate = popUpCal.input.val().split('-');
if (selectedDate.length == 3) {
   popUpCal.selectedDay = parseInt(selectedDate[2]);
   popUpCal.selectedMonth = parseInt(selectedDate[1]-1);
   popUpCal.selectedYear = parseInt(selectedDate[0]);
} else {
   popUpCal.selectedDay = new Date().getDate();
   popUpCal.selectedMonth = new Date().getMonth();
   popUpCal.selectedYear = new Date().getFullYear();
}
}
function getMonthName(month) {
    var monthNames = new Array('1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月');
    return monthNames[month];
}
function getDayName(day) {
    var dayNames = "";//new Array('星期一','星期二','星期三','星期四','星期五','星期六','星期日')
    return dayNames[day];
}
function getDaysInMonth(year, month) {
    return 32 - new Date(year, month, 32).getDate();
}
function getFirstDayofMonth(year, month) {
    var day;
    day = new Date(year, month, 0).getDay();
    return day;
}
/* Position Functions */
function setPos(targetObj,moveObj) {
    var coors = findPos(targetObj);
    moveObj.css('position','absolute');
    moveObj.css('top',coors[1]+18+'px');
    moveObj.css('left',coors[0]+'px');
}
function findPos(obj) {
    var curleft = curtop = 0;
    if (obj.offsetParent) {
        curleft = obj.offsetLeft
        curtop = obj.offsetTop
        while (obj = obj.offsetParent) {
            curleft += obj.offsetLeft
            curtop += obj.offsetTop
        }
    }
    return [curleft,curtop];
}

