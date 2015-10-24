/**
 * @fileOverview This file is the config which be used to create a calendar
 * @author <a href="mailto:support@fogtower.com">Fog Tower</a>
 * @see <a href="http://www.fogtower.com">fogtower.com</a>
 * @version 1.3
 */

Calender_Config = {
    language : "zh-cn",  //The language of calendar message.
                      //If language not be set, the message's language is 
                      //according to browser.

    css : "black",

    topPanel: [  //The top panel's layout and text, Not change id.
                {text : "<<", id : "preYear", backgroundImage : "",width:"12.5%"},
                {text : "<", id : "preMonth", backgroundImage : "",width:"12.5%"},
                {text : "", id : "thisMonth", backgroundImage : "",width:"30%"},
                {text : "", id : "thisYear", backgroundImage : "",width:"20%"},
                {text : ">", id : "nextMonth", backgroundImage : "",width:"12.5%"},
                {text : ">>", id : "nextYear", backgroundImage : "",width:"12.5%"}
     ],

    firstDayInWeek : 6,
    	
    printFormat : "YYYY-MM-DD",
    
    dates : { //The image and text of slide panel, you can break line by "\n",
              //but only the first "\n" is effective.
        "default" : {
            image : "../img/dates/2008-08-08.jpg",
            text  : "2008年北京奥运会即第二十九届夏季奥林匹克运动会于2008年8月8日20时开幕，2008年8月\n24日闭幕。"
        } 
        
        //"2008-08-08" : {
        //    image : "../../product-list/jscalendar/img/dates/2008-08-08.jpg",
        //    text  : "2008年北京奥运会即第二十九届夏季奥林匹克运动会于2008年8月8日20时开幕，\n2008年8月24日闭幕。"
        //} 
       
    }
};


