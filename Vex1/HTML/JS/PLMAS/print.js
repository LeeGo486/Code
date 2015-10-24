// strPrintName 打印任务名
// printDatagrid 要打印的datagrid
function CreateFormPage(strPrintName, printDatagrid, txtcmbdhhjj1, txtEndDate1, m_epjbs, m_epjjbs, m_eptbs, m_epjtbs, m_epwjbs, m_epjwjbs, m_eprosperbjbs, m_eprospercjbs, m_eprosperfjbs, m_eprosperbtbs, m_eprosperctbs, m_eprosperftbs, m_eprosperbwjbs, m_eprospercwjbs, m_eprosperfwjbs, m_DLjbs, m_DLtbs, m_DLwjbs) {
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
    var nameList = '';
    var nameList1 = '';

    // 载入title
    if (typeof columns != 'undefined' && columns != '') {
        $(columns).each(function (index) {
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
            if (txtcmbdhhjj1.indexOf("EP") > 0) {
                for (var i = 0; i < 12; ++i) {
                    if (!columns[index][i].hidden) {
                        tableString += '\n<th width="' + columns[index][i].width + '"';
                        if (typeof columns[index][i].rowspan != 'undefined' && columns[index][i].rowspan > 1) {
                            tableString += ' rowspan="' + columns[index][i].rowspan + '"';
                        }
                        if (typeof columns[index][i].colspan != 'undefined' && columns[index][i].colspan > 1) {
                            tableString += ' colspan="' + columns[index][i].colspan + '"';
                        }
                        if (typeof columns[index][i].field != 'undefined' && columns[index][i].field != '') {
                            nameList += ',{"f":"' + columns[index][i].field + '", "a":"' + columns[index][i].align + '"}';
                        }
                        tableString += '>' + columns[index][i].title + '</th>';
                    }
                }
            } else {
                for (var i = 0; i < 10; ++i) {
                    if (!columns[index][i].hidden) {
                        tableString += '\n<th width="' + columns[index][i].width + '"';
                        if (typeof columns[index][i].rowspan != 'undefined' && columns[index][i].rowspan > 1) {
                            tableString += ' rowspan="' + columns[index][i].rowspan + '"';
                        }
                        if (typeof columns[index][i].colspan != 'undefined' && columns[index][i].colspan > 1) {
                            tableString += ' colspan="' + columns[index][i].colspan + '"';
                        }
                        if (typeof columns[index][i].field != 'undefined' && columns[index][i].field != '') {
                            nameList += ',{"f":"' + columns[index][i].field + '", "a":"' + columns[index][i].align + '"}';
                        }
                        tableString += '>' + columns[index][i].title + '</th>';
                    }
                }
            }

            tableString += '\n</tr>';
        });
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
    $(columns).each(function (index) {
        tableString += '\n<tr>';
        for (var i = 0; i < 1; ++i) {
            if (!columns[index][i].hidden) {
                tableString += '\n<th width="' + columns[index][i].width + '"';
                if (typeof columns[index][i].rowspan != 'undefined' && columns[index][i].rowspan > 1) {
                    tableString += ' rowspan="' + columns[index][i].rowspan + '"';
                }
                if (typeof columns[index][i].colspan != 'undefined' && columns[index][i].colspan > 1) {
                    tableString += ' colspan="' + columns[index][i].colspan + '"';
                }
                if (typeof columns[index][i].field != 'undefined' && columns[index][i].field != '') {
                    nameList1 += ',{"f":"' + columns[index][i].field + '", "a":"' + columns[index][i].align + '"}';
                }
                tableString += '>' + columns[index][i].title + '</th>';
            }
        }
        if (txtcmbdhhjj1.indexOf("EP") > 0) {
            for (var i = 12; i < columns[index].length; ++i) {
                if (!columns[index][i].hidden) {
                    tableString += '\n<th width="' + columns[index][i].width + '"';
                    if (typeof columns[index][i].rowspan != 'undefined' && columns[index][i].rowspan > 1) {
                        tableString += ' rowspan="' + columns[index][i].rowspan + '"';
                    }
                    if (typeof columns[index][i].colspan != 'undefined' && columns[index][i].colspan > 1) {
                        tableString += ' colspan="' + columns[index][i].colspan + '"';
                    }
                    if (typeof columns[index][i].field != 'undefined' && columns[index][i].field != '') {
                        nameList1 += ',{"f":"' + columns[index][i].field + '", "a":"' + columns[index][i].align + '"}';
                    }
                    tableString += '>' + columns[index][i].title + '</th>';
                }
            }
        }
        else {
            for (var i = 10; i < columns[index].length; ++i) {
                if (!columns[index][i].hidden) {
                    tableString += '\n<th width="' + columns[index][i].width + '"';
                    if (typeof columns[index][i].rowspan != 'undefined' && columns[index][i].rowspan > 1) {
                        tableString += ' rowspan="' + columns[index][i].rowspan + '"';
                    }
                    if (typeof columns[index][i].colspan != 'undefined' && columns[index][i].colspan > 1) {
                        tableString += ' colspan="' + columns[index][i].colspan + '"';
                    }
                    if (typeof columns[index][i].field != 'undefined' && columns[index][i].field != '') {
                        nameList1 += ',{"f":"' + columns[index][i].field + '", "a":"' + columns[index][i].align + '"}';
                    }
                    tableString += '>' + columns[index][i].title + '</th>';
                }
            }
        }
        tableString += '\n</tr>';
    });

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
    if (txtcmbdhhjj1.indexOf("EP") > 0) {
        tableString += '\n </table> ' +
       ' <div title="" id="" style="padding: 5px" split="true">' +
        '<form id="text" title="" name="formBrand" method="post">' +
          '  <table style="font-size: 9pt;" cellpadding="2px;"border="0">' +
 '               <tr>' +
  '                  <td>EP交版数： ' +
   '                 </td>' +
    '                <td>' + m_epjbs +
      '              </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp EPJ交版数：' +
        '            </td>' +
         '           <td>' + m_epjjbs +
           '         </td>' +
'                </tr>' +
 '               <tr>' +
    '                  <td>EP调版数：' +
   '                 </td>' +
    '                <td>' + m_eptbs +
      '              </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp EPJ调版数：' +
        '            </td>' +
         '           <td>' + m_epjtbs +
           '         </td>' +
               ' </tr>' +
 '               <tr>' +
    '                  <td>EP未交版数：' +
   '                 </td>' +
    '                <td>' + m_epwjbs +
      '              </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp EPJ未交版数：' +
        '            </td>' +
         '           <td>' + m_epjwjbs +
           '         </td>' +
               ' </tr>' +
            '</table>' +
'            <table style="font-size: 9pt;" cellpadding="2px;">' +
 '<tr><td colspan="10">注:<font color="#669900">绿色代表交版</font>,<font color="00bfff">蓝色代表调版</font>,<font color="red">红色代表未交版</font></td></tr>' +
        '    </table>' +
        '</form>' +
   ' </div>' + '\n';
    } else if (txtcmbdhhjj1.indexOf("E.Prosper") > 0) {
        tableString += '\n </table> ' +
       ' <div title="" id="" style="padding: 5px" split="true">' +
        '<form id="text" title="" name="formBrand" method="post">' +
          '  <table style="font-size: 9pt;" cellpadding="2px;"border="0">' +
 '               <tr>' +
  '                  <td>B线交版数： ' +
   '                 </td>' +
    '                <td>' + m_eprosperbjbs +
      '              </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp C线交版数数：' +
        '            </td>' +
         '           <td>' + m_eprospercjbs +
           '         </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp F线交版数：' +
        '            </td>' +
         '           <td>' + m_eprosperfjbs +
           '         </td>' +
'                </tr>' +
 '               <tr>' +
    '                  <td>B线调版数：' +
   '                 </td>' +
    '                <td>' + m_eprosperbtbs +
      '              </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp C线调版数：' +
        '            </td>' +
         '           <td>' + m_eprosperctbs +
           '         </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp F线调版数：' +
        '            </td>' +
         '           <td>' + m_eprosperftbs +
           '         </td>' +
               ' </tr>' +
 '               <tr>' +
    '                  <td>B线未交版数：' +
   '                 </td>' +
    '                <td>' + m_eprosperbwjbs +
      '              </td>' +
       '             <td>  &nbsp; &nbsp; &nbsp; &nbsp C线未交版数：' +
        '            </td>' +
         '           <td>' + m_eprospercwjbs +
           '         </td>' +
       '             <td> &nbsp; &nbsp; &nbsp; &nbsp F线未交版数：' +
        '            </td>' +
         '           <td>' + m_eprosperfwjbs +
           '         </td>' +
               ' </tr>' +
            '</table>' +
'            <table style="font-size: 9pt;" cellpadding="2px;">' +
 '<tr><td colspan="10">注:<font color="#669900">绿色代表交版</font>,<font color="00bfff">蓝色代表调版</font>,<font color="red">红色代表未交版</font></td></tr>' +
        '    </table>' +
        '</form>' +
   ' </div>' + '\n';
    }
    else if (txtcmbdhhjj1.indexOf("DoubleLove") > 0) {
        tableString += '\n </table> ' +
       ' <div title="" id="" style="padding: 5px" split="true">' +
        '<form id="text" title="" name="formBrand" method="post">' +
          '  <table style="font-size: 9pt;" cellpadding="2px;"border="0">' +
 '               <tr>' +
  '                  <td>交版数： ' +
   '                 </td>' +
    '                <td>' + m_DLjbs +
      '              </td>' +
'                </tr>' +
 '               <tr>' +
    '                  <td>调版数：' +
   '                 </td>' +
    '                <td>' + m_DLtbs +
      '              </td>' +
               ' </tr>' +
 '               <tr>' +
    '                  <td>未交版数：' +
   '                 </td>' +
    '                <td>' + m_DLwjbs +
      '              </td>' +
               ' </tr>' +
            '</table>' +
'            <table style="font-size: 9pt;" cellpadding="2px;">' +
 '<tr><td colspan="10">注:<font color="#669900">绿色代表交版</font>,<font color="00bfff">蓝色代表调版</font>,<font color="red">红色代表未交版</font></td></tr>' +
        '    </table>' +
        '</form>' +
   ' </div>' + '\n';
    }
    //return tableString;
    window.showModalDialog("print.html", tableString,
    "location:No;status:no;help:No;dialogWidth:700px;resizable:yes;center:yes;dialogHeight:700px;scroll:auto;");
}