
/***********************************************************************
 *  数据写成excel格式，然后导出
 *  DLY 
 */
function dataExpotToFile(type, rows, dllist, xllist, type1) {
    if (type1 == undefined) {
        type1 = '';
    }
    var outstr = '';
    var filename = '';
    if (type == '1') {
        filename = '店铺预算查询';
        outstr = '年份' + '\t' + '品牌' + '\t' + '公司' + '\t'
               + '大区' + '\t' + '成本中心' + '\t' + '店铺名称' + '\t'
               + '大类' + '\t' + '大类代码' + '\t' + '小类' + '\t' + '小类代码' + '\t'
               + '说明' + '\t' + '合计' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg3_year + '\t' + rows[i].bg3_brand + '\t' + rows[i].bg3_com + '\t'
                   + rows[i].bg3_branch + '\t="' + rows[i].bg3_centercode + '"\t' + rows[i].bg3_deptname + '\t="'
                   + basedata_getCodename(dllist, rows[i].bg3_dlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_dlcode + '"\t="'
                   + basedata_getCodename(xllist, rows[i].bg3_xlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_xlcode + '"\t="'
                   + rows[i].bg3_remark1 + '"\t' + basedata_AtoB(rows[i].bg3_total, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m1, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m2, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m3, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m4, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m5, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m6, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m7, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m8, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m9, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m10, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m11, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m12, 0, '') + '\t' + '\r\n';
        }
    } else if (type == '2') {
        filename = '店铺预算编制Excel模板';
        outstr = '公司' + '\t'
               + '大区' + '\t' + '成本中心' + '\t' + '店铺名称' + '\t'
               + '说明' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '本行止\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg3_com + '\t'
                   + rows[i].bg3_branch + '\t="' + rows[i].bg3_centercode + '"\t' + rows[i].bg3_deptname + '\t="'
                   + rows[i].bg3_remark1 + '"\t'
                   + basedata_AtoB(rows[i].bg3_m1, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m2, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m3, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m4, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m5, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m6, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m7, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m8, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m9, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m10, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m11, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m12, 0, '') + '\t' + '本行止\r\n';
        }
    } else if (type == '3') {
        filename = '部门预算明细查询';
        outstr = '年份' + '\t' + '品牌' + '\t' + '公司' + '\t'
               + '成本中心' + '\t' + '部门名称' + '\t' + '项目' + '\t'
               + '大类' + '\t' + '大类代码' + '\t' + '小类' + '\t' + '小类代码' + '\t'
               + '说明' + '\t' + '合计' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg3_year + '\t' + rows[i].bg3_brand + '\t' + rows[i].bg3_com + '\t"'
                   + rows[i].bg3_centercode + '"\t' + rows[i].bg3_deptname + '\t="' + rows[i].bg3_project + '"\t="'
                   + basedata_getCodename(dllist, rows[i].bg3_dlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_dlcode + '"\t="'
                   + basedata_getCodename(xllist, rows[i].bg3_xlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_xlcode + '"\t="'
                   + rows[i].bg3_remark1 + '"\t' + basedata_AtoB(rows[i].bg3_total, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m1, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m2, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m3, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m4, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m5, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m6, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m7, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m8, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m9, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m10, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m11, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m12, 0, '') + '\t' + '\r\n';
        }
    } else if (type == '3A') {
        filename = '部门预算科目汇总查询';
        outstr = '年份' + '\t' + '品牌' + '\t'
                + '部门名称' + '\t' + '成本中心' + '\t' + '项目' + '\t'
               + '大类' + '\t' + '大类代码' + '\t' + '小类' + '\t' + '小类代码' + '\t'
               + '合计' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg3_year + '\t' + rows[i].bg3_brand + '\t"'
                   + rows[i].bg3_deptname + '"\t="' + rows[i].bg3_centercode + '"\t="' + rows[i].bg3_project + '"\t="'
                   + basedata_getCodename(dllist, rows[i].bg3_dlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_dlcode + '"\t="'
                   + basedata_getCodename(xllist, rows[i].bg3_xlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_xlcode + '"\t' + basedata_AtoB(rows[i].bg3_total, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m1, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m2, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m3, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m4, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m5, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m6, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m7, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m8, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m9, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m10, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m11, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m12, 0, '') + '\t' + '\r\n';
        }
    } else if (type == '3B') {
        filename = '部门预算科目汇总查询';
        outstr = '年份' + '\t' + '品牌' + '\t'
               + '大类' + '\t' + '大类代码' + '\t' + '小类' + '\t' + '小类代码' + '\t'
               + '合计' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg3_year + '\t' + rows[i].bg3_brand + '\t"'
                   + basedata_getCodename(dllist, rows[i].bg3_dlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_dlcode + '"\t="'
                   + basedata_getCodename(xllist, rows[i].bg3_xlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_xlcode + '"\t' + basedata_AtoB(rows[i].bg3_total, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m1, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m2, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m3, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m4, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m5, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m6, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m7, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m8, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m9, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m10, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m11, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m12, 0, '') + '\t' + '\r\n';
        }
    } else if (type == '4') {
        filename = '部门预算编制Excel模板';
        outstr = '公司' + '\t' + '成本中心' + '\t'
               + '说明' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '本行止\r\n';
        outstr = outstr + '雅莹' + '\t' + 'YY9050' + '\t'
               + '说明......' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t' + '本行止\r\n';
    } else if (type == '5') {
        filename = '统一费用预算编制Excel模板';
        outstr = '公司' + '\t' + '成本中心' + '\t'
                + '部门代码' + '\t' + '部门名称' + '\t'
               + '说明' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '本行止\r\n';
        outstr = outstr + '雅莹' + '\t' + 'YY9052' + '\t'
               + '492453' + '\t' + '财务部' + '\t'
               + '说明......' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t'
               + '2000' + '\t' + '2000' + '\t' + '2000' + '\t' + '本行止\r\n';
    } else if (type == '6') {
        filename = '统一费用预算查询';
        outstr = '年份' + '\t' + '品牌' + '\t' + '公司' + '\t'
               + '成本中心' + '\t' + '部门代码'
               + '\t' + '部门名称' + '\t'
               + '大类' + '\t' + '大类代码' + '\t' + '小类' + '\t' + '小类代码' + '\t'
               + '说明' + '\t' + '合计' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg3_year + '\t' + rows[i].bg3_brand + '\t' + rows[i].bg3_com + '\t"'
                   + rows[i].bg3_centercode + '"\t' + rows[i].bg3_deptid + '\t'
                   + rows[i].bg3_deptname + '\t="'
                   + basedata_getCodename(dllist, rows[i].bg3_dlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_dlcode + '"\t="'
                   + basedata_getCodename(xllist, rows[i].bg3_xlcode, 'ct1_code', 'ct1_codename') + '"\t="'
                   + rows[i].bg3_xlcode + '"\t="'
                   + rows[i].bg3_remark1 + '"\t' + basedata_AtoB(rows[i].bg3_total, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m1, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m2, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m3, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m4, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m5, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m6, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m7, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m8, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m9, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m10, 0, '') + '\t'
                   + basedata_AtoB(rows[i].bg3_m11, 0, '') + '\t' + basedata_AtoB(rows[i].bg3_m12, 0, '') + '\t' + '\r\n';
        }
    } else if (type == '7') {
        filename = '固定资产预算查询';
        outstr = '年份' + '\t' + '品牌' + '\t' + '公司' + '\t'
               + '成本中心' + '\t' + '部门代码'
               + '\t' + '部门名称' + '\t'
               + '大类' + '\t' + '大类代码' + '\t' + '小类' + '\t' + '小类代码' + '\t'
               + '资产名称' + '\t' + '数量' + '\t' + '资产单价' + '\t' + '总金额' + '\t'
               + '行动计划' + '\t' + '备注' + '\t' + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg1_years + '\t' + rows[i].bg1_brand + '\t' + rows[i].bg1_com + '\t"'
                   + rows[i].bg1_centercode + '"\t' + rows[i].bg1_deptid + '\t'
                   + rows[i].bg1_deptname + '\t="'
                   + rows[i].bg1_largeclassname + '"\t="' + rows[i].bg1_largeclasscode + '"\t="'
                   + rows[i].bg1_smallclassname + '"\t="' + rows[i].bg1_smallclasscode + '"\t="'
                   + rows[i].bg1_assetsname + '"\t="' + rows[i].bg1_number + '"\t="'
                   + rows[i].bg1_price + '"\t="' + rows[i].bg1_sureamount + '"\t="'
                   + rows[i].bg1_planuse + '"\t="' + rows[i].bg1_remark + '"\t' + '\r\n';
        }
    } else if (type == '8') {
        if (type1 == '') {
            alert('type1不能为空！');
            return false;
        }
        filename = '店铺销售预算Excel模板';
        outstr = '品牌' + '\t' + '年份' + '\t' + '公司' + '\t'
               + '大区' + '\t' + '类型' + '\t'
               + '成本中心' + '\t' + '店铺名称' + '\t'
               + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t' + '本行止\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg5_brand + '\t' + rows[i].bg5_year + '\t' + rows[i].bg5_com + '\t'
                   + rows[i].bg5_branch + '\t="' + rows[i].bg5_shoptype + '"\t="'
                   + rows[i].bg5_centercode + '"\t="' + rows[i].bg5_deptname + '"\t';
            for (var j = 1; j < 13; j++) {
                outstr = outstr + basedata_AtoB(rows[i]["bg5_" + type1 + "m" + j], 0, '') + '\t';
            }
            outstr = outstr + '本行止\r\n';
        }
    } else if (type == '9') {
        var tabTypes = [{ "id": "xssl", "text": "销售数量" }, { "id": "dpje", "text": "吊牌金额" }
                            , { "id": "sxsr", "text": "实销收入" }, { "id": "jssr", "text": "结算收入" }
                            , { "id": "jxse", "text": "净销售额" }, { "id": "sjcb", "text": "实际成本" }
                            , { "id": "xncb", "text": "虚拟成本" }];
        filename = '店铺销售预算';
        var ms = '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t';

        outstr = '品牌' + '\t' + '年份' + '\t' + '公司' + '\t'
               + '大区' + '\t' + '类型' + '\t'
               + '成本中心' + '\t' + '店铺名称' + '\t'
               + '销售数量' + '\t' + ms
               + '吊牌金额' + '\t' + ms
               + '实际收入' + '\t' + ms
               + '结算收入' + '\t' + ms
               + '净销售额' + '\t' + ms
               + '实际成本' + '\t' + ms
               + '虚拟成本' + '\t' + ms + '\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg5_brand + '\t' + rows[i].bg5_year + '\t' + rows[i].bg5_com + '\t'
                   + rows[i].bg5_branch + '\t="' + rows[i].bg5_shoptype + '"\t="'
                   + rows[i].bg5_centercode + '"\t="' + rows[i].bg5_deptname + '"\t';
            for (var x = 0; x < tabTypes.length; x++) {
                outstr = outstr + ' \t';
                for (var j = 1; j < 13; j++) {
                    outstr = outstr + basedata_AtoB(rows[i]["bg5_" + tabTypes[x].id + "m" + j], 0, '') + '\t';
                }
            }
            outstr = outstr + '\r\n';
        }
    } else if (type == '10') {
        filename = '利润中心损益表';
        var ms = '合计' + '\t' + '1月' + '\t' + '2月' + '\t' + '3月' + '\t'
               + '4月' + '\t' + '5月' + '\t' + '6月' + '\t'
               + '7月' + '\t' + '8月' + '\t' + '9月' + '\t'
               + '10月' + '\t' + '11月' + '\t' + '12月' + '\t';

        outstr = '品牌' + '\t' + '年份' + '\t'
               + '系统编码' + '\t' + '自编号' + '\t'
               + '名称' + '\t'
               + '说明' + '\t' + ms
               + '成本中心' + '\t'
               + '科目代码' + '\t'
               + '参数类型' + '\t\r\n';
        for (var i = 0; i < rows.length; i++) {
            outstr = outstr + rows[i].bg6_brand + '\t' + rows[i].bg6_year + '\t'
                   + rows[i].bg6_code + '\t="' + rows[i].bg6_code1 + '"\t="'
                   + rows[i].bg6_name + '"\t="' + rows[i].bg6_remark + '"\t'
                   + basedata_AtoB(rows[i].bg6_total, 0, '') + '\t';
            for (var j = 1; j < 13; j++) {
                outstr = outstr + basedata_AtoB(rows[i]["bg6_" + "m" + j], 0, '') + '\t';
            }
            outstr = outstr + '="' + rows[i].bg6_centers + '"\t="' + rows[i].bg6_xlcodes + '"\t'
                   + rows[i].bg6_type + '\t';
            outstr = outstr + '\r\n';
        }
    }
    if (navigator.appName.toLowerCase() == 'microsoft internet explorer') {
        doFileExport(filename + dateUtil_dateFomaterB(new Date(), '') + ".xls", outstr);
    } else {
        $('#toExceltext').val(outstr);
        $('#toEXCELdlg').dialog('open');
    }
    return outstr;
}




/***********************************************************************
 *  文件导出方法 
 *  DLY 
 */
function doFileExport(inName, inStr) {
    var xlsWin = null;
    var openPara = "left=200 ,top=200, Toolbar=no,Location=no,"
    			+ "Direction=no,Resizeable=no,width=100,height=100";
    xlsWin = window.open("", "_blank", openPara);
    //xlsWin = window.showModalDialog("",window,"dialogHeight:100px; dialogWidth: 100px; dialogTop: 100px; dialogLeft: 100px; resizable: no; status: no;scroll:no");
    xlsWin.document.write(inStr);
    xlsWin.document.close();
    xlsWin.document.execCommand('Saveas', false, inName);
    xlsWin.focus();
    xlsWin.close();
}