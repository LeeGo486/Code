/***********************************************************************
  * 
  *  参数： n
  *  返回值： sessionid
  */
function peoa_GetWSRRURL(n) {
    var s = '11111111-1111-1111-1111-111111111111';
    switch (n) {
        // HR辅助系统 begin
        case 1001:          //店铺人员加班
            //s = '2948324c-39de-4d9b-b998-f58bf5ef449a'; // PE_OA
            s = 'e021f17b-c58d-48a6-9b64-69a945959c1f';   //EHRAS
            break;
        case 1002:          //hr系统接口
            s = '261f8014-1912-4768-87ec-994eb365cf01';
            break;
        case 1003:          //hr系统接口(分单)
            s = 'abc1e2c2-05e6-417f-ae0a-44034abe4dc2';
            break;
            // HR辅助系统 end           
        default:
            s = '11111111-1111-1111-1111-111111111111';
    }
    return s;
}




