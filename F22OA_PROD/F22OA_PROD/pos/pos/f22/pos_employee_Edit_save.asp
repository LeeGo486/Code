<!--#include file="inc/function.asp"-->
<%
    Response.Addheader "Content-Type","text/html; charset=gb2312"
    dim act,employeeid,groupid,usedstatus,valid,sql,yeargoal,Position
    act=request("act")
    if act="saveYearGoal" then
        employeeid=request("employeeid")
        yeargoal=request("yeargoal")
        sql="update j_employee set YearGoal="&yeargoal&" where employeeid='"&employeeid&"'"
        cn.Execute sql
        response.Write "1"
    else
        employeeid=request("employeeid")
        groupid=request("groupid")
        Position=request("Position")
        usedstatus=request("usedstatus")
        valid=request("valid")
        yeargoal=request("yeargoal")
        sql="update j_employee set groupid='"&groupid&"',Position='"&Position&"',usedstatus="&usedstatus&",valid="&valid&",YearGoal="&yeargoal&" where employeeid='"&employeeid&"'"
        cn.Execute sql
        response.Write "<script>window.returnValue=1;window.close();</script>"
    end if
    
 %>