// strPrintName 打印任务名
// printDatagrid 要打印的datagrid
function CreateFormPage(strPrintName, printDatagrid, brand,txtcmbdhhjj1, txtEndDate1, jbs) {
    var tableString =
    '<div style="padding: 15px">' +
' <form id="frmSeach">' +
' <table  style="font-size: 16pt; width:630px">' +
'     <tr >' +
  '      <td style="text-align:center" > 版师每日收交版明细</td>' +
'    </tr>' +
' </table>' +
' <table  style="font-size: 10pt;width:630px">' +
'     <tr >' +
 '       <td  style="text-align:center;width:630px">订货会季节：' + txtcmbdhhjj1 + '&nbsp;&nbsp 时间：' + txtEndDate1 + '</td>' +
'    </tr>' +
' </table>' +
' </form>' +
'  </div> ' + '<table cellspacing="0" class="pb">';
    var frozenColumns = printDatagrid.datagrid("options").frozenColumns;  // 得到frozenColumns对象
    var columns = printDatagrid.datagrid("options").columns;    // 得到columns对象

    var columnsOutline = new Array();
    var columnsInline = new Array();
    var nameList = '';
    var nameList1 = '';
    var nameListOut = ',{"f":"序号", "a":"center"}';
    var columnsLen = columns[0].length;

    do {
        var len = columnsLen;
        len--;
        var name = columns[0][len].field;
        switch (name) {
            case "计伟伟": columnsOutline.push(columns[0][len]); break;
            case "张英滨": columnsOutline.push(columns[0][len]); break;
            case "张华光": columnsOutline.push(columns[0][len]); break;
            case "冯闯": columnsOutline.push(columns[0][len]); break;
            case "陈志杰": columnsOutline.push(columns[0][len]); break;
            case "张红艳": columnsOutline.push(columns[0][len]); break;
            case "张国兵": columnsOutline.push(columns[0][len]); break;
            case "李成林": columnsOutline.push(columns[0][len]); break;
            default: columnsInline.push(columns[0][len]); break;
        };

        columnsLen--;
    } while (columnsLen != 0);

    columnsOutline.reverse();//排序反转
    columnsInline.reverse();

    // 载入title
    if (typeof frozenColumns != 'undefined' && frozenColumns != '') {
        $(frozenColumns).each(function (index) {
            tableString += '\n<tr>';
            if (typeof frozenColumns != 'undefined' && typeof frozenColumns[index] != 'undefined') {
                for (var i = 0; i < frozenColumns[index].length; ++i) {
                    if (!frozenColumns[index][i].hidden) {
                        tableString += '\n<th width="' + frozenColumns[index][i].width + '"';
                        if (typeof frozenColumns[index][i].rowspan != 'undefined' && frozenColumns[index][i].rowspan > 1) {
                            tableString += ' rowspan="' + frozenColumns[index][i].rowspan + '"';
                        }
                        if (typeof frozenColumns[index][i].colspan != 'undefined' && frozenColumns[index][i].colspan > 1) {
                            tableString += ' colspan="' + frozenColumns[index][i].colspan + '"';
                        }
                        if (typeof frozenColumns[index][i].field != 'undefined' && frozenColumns[index][i].field != '') {
                            nameList += ',{"f":"' + frozenColumns[index][i].field + '", "a":"' + frozenColumns[index][i].align + '"}';
                        }
                        tableString += '>' + frozenColumns[0][i].title + '</th>';
                    }
                }
            }


            tableString += '\n</tr>';
        });
    } else {
        if (brand=="EP") {

            var len = columnsInline.length;
            if (len > 12) { len = 12; };

            for (var i = 0; i < len; ++i) {
                if (!columnsInline[i].hidden) {
                    tableString += '\n<th width="' + columnsInline[i].width + '"';
                    if (typeof columnsInline[i].rowspan != 'undefined' && columnsInline[i].rowspan > 1) {
                        tableString += ' rowspan="' + columnsInline[i].rowspan + '"';
                    }
                    if (typeof columnsInline[i].colspan != 'undefined' && columnsInline[i].colspan > 1) {
                        tableString += ' colspan="' + columns[index][i].colspan + '"';
                    }
                    if (typeof columnsInline[i].field != 'undefined' && columnsInline[i].field != '') {
                        nameList += ',{"f":"' + columnsInline[i].field + '", "a":"' + columnsInline[i].align + '"}';
                    }
                    tableString += '>' + columnsInline[i].title + '</th>';
                }
            }
        } else {
            var len = columnsInline.length;
            if (len > 10) { len = 10; };

            for (var i = 0; i < len; ++i) {
                if (!columnsInline[i].hidden) {
                    tableString += '\n<th width="' + columnsInline[i].width + '"';
                    if (typeof columnsInline[i].rowspan != 'undefined' && columnsInline[i].rowspan > 1) {
                        tableString += ' rowspan="' + columnsInline[i].rowspan + '"';
                    }
                    if (typeof columnsInline[i].colspan != 'undefined' && columnsInline[i].colspan > 1) {
                        tableString += ' colspan="' + columnsInline[i].colspan + '"';
                    }
                    if (typeof columnsInline[i].field != 'undefined' && columnsInline[i].field != '') {
                        nameList += ',{"f":"' + columnsInline[i].field + '", "a":"' + columnsInline[i].align + '"}';
                    }
                    tableString += '>' + columnsInline[i].title + '</th>';
                }
            }
        }
    }
    // 载入内容
    var rows = printDatagrid.datagrid("getRows"); // 这段代码是获取当前页的所有行
    var nl = eval('([' + nameList.substring(1) + '])');
    for (var i = 0; i < rows.length; ++i) {
        tableString += '\n<tr>';
        $(nl).each(function (j) {
            var e = nl[j].f.lastIndexOf('_0');

            tableString += '\n<td';
            if (nl[j].a != 'undefined' && nl[j].a != '') {
                tableString += ' style="text-align:' + nl[j].a + ';"';
            }
            tableString += '>';
            if (e + 2 == nl[j].f.length) {
                tableString += rows[i][nl[j].f.substring(0, e)];
            }
            else
                tableString += rows[i][nl[j].f];
            tableString += '</td>';
        });
        tableString += '\n</tr>';
    }


    //第二行

    // 载入title

    tableString += '\n<tr>';
    for (var i = 0; i < 1; ++i) {
        if (!columnsInline.hidden) {
            tableString += '\n<th width="' + columnsInline.width + '"';
            if (typeof columnsInline[i].rowspan != 'undefined' && columnsInline[i].rowspan > 1) {
                tableString += ' rowspan="' + columnsInline[i].rowspan + '"';
            }
            if (typeof columnsInline[i].colspan != 'undefined' && columnsInline[i].colspan > 1) {
                tableString += ' colspan="' + columnsInline[i].colspan + '"';
            }
            if (typeof columnsInline[i].field != 'undefined' && columnsInline[i].field != '') {
                nameList1 += ',{"f":"' + columnsInline[i].field + '", "a":"' + columnsInline[i].align + '"}';
            }
            tableString += '>' + columnsInline[i].title + '</th>';
        };
    };
    if (brand=="EP") {
        for (var i = 12; i < columnsInline.length; ++i) {
            if (!columnsInline[i].hidden) {
                tableString += '\n<th width="' + columnsInline[i].width + '"';
                if (typeof columnsInline[i].rowspan != 'undefined' && columnsInline[i].rowspan > 1) {
                    tableString += ' rowspan="' + columnsInline[i].rowspan + '"';
                }
                if (typeof columnsInline[i].colspan != 'undefined' && columnsInline[i].colspan > 1) {
                    tableString += ' colspan="' + columnsInline[i].colspan + '"';
                }
                if (typeof columnsInline[i].field != 'undefined' && columnsInline[i].field != '') {
                    nameList1 += ',{"f":"' + columnsInline[i].field + '", "a":"' + columnsInline[i].align + '"}';
                }
                tableString += '>' + columnsInline[i].title + '</th>';
            }
        }
    }
    else {
        for (var i = 10; i < columnsInline.length; ++i) {
            if (!columnsInline[i].hidden) {
                tableString += '\n<th width="' + columnsInline[i].width + '"';
                if (typeof columnsInline[i].rowspan != 'undefined' && columnsInline[i].rowspan > 1) {
                    tableString += ' rowspan="' + columnsInline[i].rowspan + '"';
                }
                if (typeof columnsInline[i].colspan != 'undefined' && columnsInline[i].colspan > 1) {
                    tableString += ' colspan="' + columnsInline[i].colspan + '"';
                }
                if (typeof columnsInline[i].field != 'undefined' && columnsInline[i].field != '') {
                    nameList1 += ',{"f":"' + columnsInline[i].field + '", "a":"' + columnsInline[i].align + '"}';
                }
                tableString += '>' + columnsInline[i].title + '</th>';
            }
        }
    };
    tableString += '\n</tr>';

    // 载入内容
    var rows = printDatagrid.datagrid("getRows"); // 这段代码是获取当前页的所有行
    var nl = eval('([' + nameList1.substring(1) + '])');

    for (var i = 0; i < rows.length; ++i) {
        tableString += '\n<tr>';
        $(nl).each(function (j) {
            var e = nl[j].f.lastIndexOf('_0');

            tableString += '\n<td';
            if (nl[j].a != 'undefined' && nl[j].a != '') {
                tableString += ' style="text-align:' + nl[j].a + ';"';
            }
            tableString += '>';
            if (e + 2 == nl[j].f.length) {
                tableString += rows[i][nl[j].f.substring(0, e)];
            }
            else
                tableString += rows[i][nl[j].f];
            tableString += '</td>';
        });
        tableString += '\n</tr>';
    }

    //外部线
    if (columnsOutline.length > 0) {
        tableString += '</table><p>外部线</p><table cellspacing="0" class="pb">';

        tableString += '\n<th width="50">序号</th>';
        var cOutLength = columnsOutline.length;
        if (cOutLength > 8) {
            cOutLength = 8;
        }
        for (var i = 0; i < cOutLength; i++) {
            tableString += '\n<th width="' + columnsOutline[i].width + '"';
            if (typeof columnsOutline[i].rowspan != 'undefined' && columnsOutline[i].rowspan > 1) {
                tableString += ' rowspan="' + columnsOutline[i].rowspan + '"';
            }
            if (typeof columnsInline[i].colspan != 'undefined' && columnsOutline[i].colspan > 1) {
                tableString += ' colspan="' + columnsOutline[i].colspan + '"';
            }
            if (typeof columnsOutline[i].field != 'undefined' && columnsOutline[i].field != '') {
                nameListOut += ',{"f":"' + columnsOutline[i].field + '", "a":"' + columnsOutline[i].align + '"}';
            }
            tableString += '>' + columnsOutline[i].title + '</th>';
        };

        // 载入内容
        var rows = printDatagrid.datagrid("getRows"); // 这段代码是获取当前页的所有行
        var nl = eval('([' + nameListOut.substring(1) + '])');

        for (var i = 0; i < rows.length; ++i) {
            tableString += '\n<tr>';
            $(nl).each(function (j) {
                var e = nl[j].f.lastIndexOf('_0');

                tableString += '\n<td';
                if (nl[j].a != 'undefined' && nl[j].a != '') {
                    tableString += ' style="text-align:' + nl[j].a + ';"';
                }
                tableString += '>';
                if (e + 2 == nl[j].f.length) {
                    tableString += rows[i][nl[j].f.substring(0, e)];
                }
                else
                    tableString += rows[i][nl[j].f];
                tableString += '</td>';
            });
            tableString += '\n</tr>';
        };
    };

    for (var p in jbs) {

        if (jbs[p] == 'undefined') {
            jbs[p] = 0;
        }

    };

    if (brand == "EP" || brand == "欧逸柔" || brand == "徐俊楠" || brand == "白鑫" || brand == "马小姐" || brand == "张黎" || brand == "EP.Zen" || brand == "EP.Lab") {
        tableString += '\n </table> ' +
       ' <div title="" id="" style="padding: 5px" split="true">' +
        '<form id="text" title="" name="formBrand" method="post">' +
        //table1
          '  <table style="font-size: 9pt;" cellpadding="2px;"border="0">' +
 '               <tr>' +
  '                  <td>EP交版数： ' +
   '                 </td>' +
    '                <td>' + jbs.m_epjbs +
      '              </td>' +
            '        <td> &nbsp; &nbsp; &nbsp; &nbsp EP.Zen交版数：' +
             '       </td>' +
              '      <td>' + jbs.epZenJ +
               '     </td>' +
            '        <td> &nbsp; &nbsp; &nbsp; &nbsp EP.Lab交版数：' +
             '       </td>' +
              '      <td>' + jbs.eplabJ +
               '     </td>' +
            '        <td> &nbsp; &nbsp; &nbsp; &nbsp 上海交版数：' +
             '       </td>' +
              '      <td>' + jbs.shangHaiJ +
               '     </td>' +
            '        <td> &nbsp; &nbsp; &nbsp; &nbsp 白鑫交版数：' +
             '       </td>' +
              '      <td>' + jbs.baiXinJ +
               '     </td>' +

                '  </tr>' +
                 '<tr>' +
  '                  <td>EP调版数：' +
   '                 </td>' +
    '                <td>' + jbs.m_eptbs +
      '              </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp EP.Zen调版数：' +
        '            </td>' +
         '           <td>' + jbs.epZenT +
           '         </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp EP.Lab调版数：' +
        '            </td>' +
         '           <td>' + jbs.eplabT +
           '         </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp 上海调版数：' +
        '            </td>' +
         '           <td>' + jbs.shangHaiT +
           '         </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp 白鑫调版数：' +
        '            </td>' +
         '           <td>' + jbs.baiXinT +
           '         </td>' +

                '  </tr>' +
                '<tr>' +
  '                  <td>EP未交版数：' +
   '                 </td>' +
    '                <td>' + jbs.m_epwjbs +
      '              </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp EP.Zen未交版数：' +
        '            </td>' +
         '           <td>' + jbs.epZenW +
           '         </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp EP.Lab未交版数：' +
        '            </td>' +
         '           <td>' + jbs.eplabW +
           '         </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp 上海未交版数：' +
        '            </td>' +
         '           <td>' + jbs.shangHaiW +
           '         </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp 白鑫未交版数：' +
        '            </td>' +
         '           <td>' + jbs.baiXinW +
           '         </td>' +

                '  </tr>' +
                '  </table><p>&nbsp;------------</p>'+
        //table2
        '<table style="font-size: 9pt;" cellpadding="2px;"border="0"><tr>' +
            '        <td>张黎交版数：' +
             '       </td>' +
              '      <td>' + jbs.zhangLiJ +
               '     </td>' +
            '        <td> &nbsp; &nbsp; &nbsp; &nbsp 马小姐交版数：' +
             '       </td>' +
              '      <td>' + jbs.missMaJ +
               '     </td>' +
            '        <td> &nbsp; &nbsp; &nbsp; &nbsp 订做交版数：' +
             '       </td>' +
              '      <td>' + jbs.dingZuoJ +
               '     </td>' +
            '        <td> &nbsp; &nbsp; &nbsp; &nbsp 徐俊楠交版数：' +
             '       </td>' +
              '      <td>' + jbs.xuJNJ +
               '     </td>' +
                '    </tr>' +
                '<tr>' +
       '             <td>张黎调版数：' +
        '            </td>' +
         '           <td>' + jbs.zhangLiT +
           '         </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp 马小姐调版数：' +
        '            </td>' +
         '           <td>' + jbs.missMaT +
           '         </td>' +
            '        <td> &nbsp; &nbsp; &nbsp; &nbsp 订做调版数：' +
             '       </td>' +
              '      <td>' + jbs.dingZuoT +
               '     </td>' +
            '        <td> &nbsp; &nbsp; &nbsp; &nbsp 徐俊楠调版数：' +
             '       </td>' +
              '      <td>' + jbs.xuJNT +
               '     </td>' +
                '  <tr>'+
       '           <td>张黎未交版数：' +
        '            </td>' +
         '           <td>' + jbs.zhangLiW +
           '         </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp 马小姐未交版数：' +
        '            </td>' +
         '           <td>' + jbs.missMaW +
           '         </td>' +
            '        <td> &nbsp; &nbsp; &nbsp; &nbsp 订做未交版数：' +
             '       </td>' +
              '      <td>' + jbs.dingZuoW +
               '     </td>' +
            '        <td> &nbsp; &nbsp; &nbsp; &nbsp 徐俊楠未交版数：' +
             '       </td>' +
              '      <td>' + jbs.xuJNW +
               '     </td>' +
                '  </tr>' +
            '</table>' +
'            <table style="font-size: 9pt;" cellpadding="2px;">' +
 '<tr><td colspan="10">注:<font color="#669900">绿色代表交版</font>,<font color="00bfff">蓝色代表调版</font>,<font color="red">红色代表未交版</font></td></tr>' +
        '    </table>' +
        '</form>' +
   ' </div>' + '\n';
    } else if (brand == "E.Prosper") {
        tableString += '\n </table> ' +
       ' <div title="" id="" style="padding: 5px" split="true">' +
        '<form id="text" title="" name="formBrand" method="post">' +
          '  <table style="font-size: 9pt;" cellpadding="2px;"border="0">' +
 '               <tr>' +
  '                  <td>B线交版数： ' +
   '                 </td>' +
    '                <td>' + jbs.m_eprosperbjbs +
      '              </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp C线交版数数：' +
        '            </td>' +
         '           <td>' + jbs.m_eprospercjbs +
           '         </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp F线交版数：' +
        '            </td>' +
         '           <td>' + jbs.m_eprosperfjbs +
           '         </td>' +
'                </tr>' +
 '               <tr>' +
    '                  <td>B线调版数：' +
   '                 </td>' +
    '                <td>' + jbs.m_eprosperbtbs +
      '              </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp C线调版数：' +
        '            </td>' +
         '           <td>' + jbs.m_eprosperctbs +
           '         </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp F线调版数：' +
        '            </td>' +
         '           <td>' + jbs.m_eprosperftbs +
           '         </td>' +
               ' </tr>' +
 '               <tr>' +
    '                  <td>B线未交版数：' +
   '                 </td>' +
    '                <td>' + jbs.m_eprosperbwjbs +
      '              </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp C线未交版数：' +
        '            </td>' +
         '           <td>' + jbs.m_eprospercwjbs +
           '         </td>' +
       '             <td> &nbsp; &nbsp; &nbsp; &nbsp F线未交版数：' +
        '            </td>' +
         '           <td>' + jbs.m_eprosperfwjbs +
           '         </td>' +
               ' </tr>' +
            '</table>' +
'            <table style="font-size: 9pt;" cellpadding="2px;">' +
 '<tr><td colspan="10">注:<font color="#669900">绿色代表交版</font>,<font color="00bfff">蓝色代表调版</font>,<font color="red">红色代表未交版</font></td></tr>' +
        '    </table>' +
        '</form>' +
   ' </div>' + '\n';
    }
    else if (brand == "DoubleLove") {
        tableString += '\n </table> ' +
       ' <div title="" id="" style="padding: 5px" split="true">' +
        '<form id="text" title="" name="formBrand" method="post">' +
          '  <table style="font-size: 9pt;" cellpadding="2px;"border="0">' +
 '               <tr>' +
  '                  <td>DoubleLove交版数： ' +
   '                 </td>' +
    '                <td>' + jbs.m_DLjbs +
      '              </td>' +
'                </tr>' +
 '               <tr>' +
    '                  <td>DoubleLove调版数：' +
   '                 </td>' +
    '                <td>' + jbs.m_DLtbs +
      '              </td>' +
               ' </tr>' +
 '               <tr>' +
    '                  <td>DoubleLove未交版数：' +
   '                 </td>' +
    '                <td>' + jbs.m_DLwjbs +
      '              </td>' +
               ' </tr>' +
            '</table>' +
'            <table style="font-size: 9pt;" cellpadding="2px;">' +
 '<tr><td colspan="10">注:<font color="#669900">绿色代表交版</font>,<font color="00bfff">蓝色代表调版</font>,<font color="red">红色代表未交版</font></td></tr>' +
        '    </table>' +
        '</form>' +
   ' </div>' + '\n';
    }
//    else if (brand == "欧逸柔") {
//        tableString += '\n </table> ' +
//       ' <div title="" id="" style="padding: 5px" split="true">' +
//        '<form id="text" title="" name="formBrand" method="post">' +
//          '  <table style="font-size: 9pt;" cellpadding="2px;"border="0">' +
// '               <tr>' +
//  '                  <td>上海交版数： ' +
//   '                 </td>' +
//    '                <td>' + jbs.shangHaiJ +
//      '              </td>' +
//'                </tr>' +
// '               <tr>' +
//    '                  <td>上海调版数：' +
//   '                 </td>' +
//    '                <td>' + jbs.shangHaiT +
//      '              </td>' +
//               ' </tr>' +
// '               <tr>' +
//    '                  <td>上海未交版数：' +
//   '                 </td>' +
//    '                <td>' + jbs.shangHaiW +
//      '              </td>' +
//               ' </tr>' +
//            '</table>' +
//'            <table style="font-size: 9pt;" cellpadding="2px;">' +
// '<tr><td colspan="10">注:<font color="#669900">绿色代表交版</font>,<font color="00bfff">蓝色代表调版</font>,<font color="red">红色代表未交版</font></td></tr>' +
//        '    </table>' +
//        '</form>' +
//   ' </div>' + '\n';
//    }
//    else if (brand == "白鑫") {
//        tableString += '\n </table> ' +
//       ' <div title="" id="" style="padding: 5px" split="true">' +
//        '<form id="text" title="" name="formBrand" method="post">' +
//          '  <table style="font-size: 9pt;" cellpadding="2px;"border="0">' +
// '               <tr>' +
//  '                  <td>白鑫交版数： ' +
//   '                 </td>' +
//    '                <td>' + jbs.baiXinJ +
//      '              </td>' +
//'                </tr>' +
// '               <tr>' +
//    '                  <td>白鑫调版数：' +
//   '                 </td>' +
//    '                <td>' + jbs.baiXinT +
//      '              </td>' +
//               ' </tr>' +
// '               <tr>' +
//    '                  <td>白鑫未交版数：' +
//   '                 </td>' +
//    '                <td>' + jbs.baiXinW +
//      '              </td>' +
//               ' </tr>' +
//            '</table>' +
//'            <table style="font-size: 9pt;" cellpadding="2px;">' +
// '<tr><td colspan="10">注:<font color="#669900">绿色代表交版</font>,<font color="00bfff">蓝色代表调版</font>,<font color="red">红色代表未交版</font></td></tr>' +
//        '    </table>' +
//        '</form>' +
//   ' </div>' + '\n';
//    }
//    else if (brand == "马小姐") {
//        tableString += '\n </table> ' +
//       ' <div title="" id="" style="padding: 5px" split="true">' +
//        '<form id="text" title="" name="formBrand" method="post">' +
//          '  <table style="font-size: 9pt;" cellpadding="2px;"border="0">' +
// '               <tr>' +
//  '                  <td>马小姐交版数： ' +
//   '                 </td>' +
//    '                <td>' + jbs.missMaJ +
//      '              </td>' +
//'                </tr>' +
// '               <tr>' +
//    '                  <td>马小姐调版数：' +
//   '                 </td>' +
//    '                <td>' + jbs.missMaT +
//      '              </td>' +
//               ' </tr>' +
// '               <tr>' +
//    '                  <td>马小姐未交版数：' +
//   '                 </td>' +
//    '                <td>' + jbs.missMaW +
//      '              </td>' +
//               ' </tr>' +
//            '</table>' +
//'            <table style="font-size: 9pt;" cellpadding="2px;">' +
// '<tr><td colspan="10">注:<font color="#669900">绿色代表交版</font>,<font color="00bfff">蓝色代表调版</font>,<font color="red">红色代表未交版</font></td></tr>' +
//        '    </table>' +
//        '</form>' +
//   ' </div>' + '\n';
//    }
//    else if (brand == "张黎") {
//        tableString += '\n </table> ' +
//       ' <div title="" id="" style="padding: 5px" split="true">' +
//        '<form id="text" title="" name="formBrand" method="post">' +
//          '  <table style="font-size: 9pt;" cellpadding="2px;"border="0">' +
// '               <tr>' +
//  '                  <td>张黎交版数： ' +
//   '                 </td>' +
//    '                <td>' + jbs.zhangLiJ +
//      '              </td>' +
//'                </tr>' +
// '               <tr>' +
//    '                  <td>张黎调版数：' +
//   '                 </td>' +
//    '                <td>' + jbs.zhangLiT +
//      '              </td>' +
//               ' </tr>' +
// '               <tr>' +
//    '                  <td>张黎未交版数：' +
//   '                 </td>' +
//    '                <td>' + jbs.zhangLiW +
//      '              </td>' +
//               ' </tr>' +
//            '</table>' +
//'            <table style="font-size: 9pt;" cellpadding="2px;">' +
// '<tr><td colspan="10">注:<font color="#669900">绿色代表交版</font>,<font color="00bfff">蓝色代表调版</font>,<font color="red">红色代表未交版</font></td></tr>' +
//        '    </table>' +
//        '</form>' +
//   ' </div>' + '\n';
//    }
//    else if (brand == "EP.Zen") {
//        tableString += '\n </table> ' +
//       ' <div title="" id="" style="padding: 5px" split="true">' +
//        '<form id="text" title="" name="formBrand" method="post">' +
//          '  <table style="font-size: 9pt;" cellpadding="2px;"border="0">' +
// '               <tr>' +
//  '                  <td>EP.Zen交版数： ' +
//   '                 </td>' +
//    '                <td>' + jbs.epZenJ +
//      '              </td>' +
//'                </tr>' +
// '               <tr>' +
//    '                  <td>EP.Zen调版数：' +
//   '                 </td>' +
//    '                <td>' + jbs.epZenT +
//      '              </td>' +
//               ' </tr>' +
// '               <tr>' +
//    '                  <td>EP.Zen未交版数：' +
//   '                 </td>' +
//    '                <td>' + jbs.epZenW +
//      '              </td>' +
//               ' </tr>' +
//            '</table>' +
//'            <table style="font-size: 9pt;" cellpadding="2px;">' +
// '<tr><td colspan="10">注:<font color="#669900">绿色代表交版</font>,<font color="00bfff">蓝色代表调版</font>,<font color="red">红色代表未交版</font></td></tr>' +
//        '    </table>' +
//        '</form>' +
//   ' </div>' + '\n';
//    }
//    else if (brand == "EP.Lab") {
//        tableString += '\n </table> ' +
//       ' <div title="" id="" style="padding: 5px" split="true">' +
//        '<form id="text" title="" name="formBrand" method="post">' +
//          '  <table style="font-size: 9pt;" cellpadding="2px;"border="0">' +
// '               <tr>' +
//  '                  <td>EP.Lab交版数： ' +
//   '                 </td>' +
//    '                <td>' + jbs.eplabJ +
//      '              </td>' +
//'                </tr>' +
// '               <tr>' +
//    '                  <td>EP.Lab调版数：' +
//   '                 </td>' +
//    '                <td>' + jbs.eplabT +
//      '              </td>' +
//               ' </tr>' +
// '               <tr>' +
//    '                  <td>EP.Lab未交版数：' +
//   '                 </td>' +
//    '                <td>' + jbs.eplabW +
//      '              </td>' +
//               ' </tr>' +
//            '</table>' +
//'            <table style="font-size: 9pt;" cellpadding="2px;">' +
// '<tr><td colspan="10">注:<font color="#669900">绿色代表交版</font>,<font color="00bfff">蓝色代表调版</font>,<font color="red">红色代表未交版</font></td></tr>' +
//        '    </table>' +
//        '</form>' +
//   ' </div>' + '\n';
//    }
   
    //return tableString;
    window.showModalDialog("print.html", new String(tableString),
    "location:No;status:no;help:No;dialogWidth:700px;resizable:yes;center:yes;dialogHeight:700px;scroll:auto;");
}