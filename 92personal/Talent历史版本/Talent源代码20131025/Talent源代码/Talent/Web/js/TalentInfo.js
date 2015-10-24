(function () {
    TalentInfo = {};
    $.extend(TalentInfo, {
        AddRow: function (_obj) {
            var tmpCB_NO = $("input[name=CB_No]", $(_obj).parents(".pageForm:first"));
            $.ajaxWebService("TalentInfo/TalentInfo.aspx/AddTalent", "{CB_NO:" + tmpCB_NO.val() + "}", function (result) {
                var obj = eval("(" + result.d.toString() + ")");
                if (obj.flag == "true") {
                    tmpCB_NO.parents(".pageForm:first").submit();
                }
            });
        },
        DelRow: function ($this, event) {
            var $tbody = $this.parents(".pageContent:first").find("tbody[name='TalentsList']");
            var dataId = unescape($this.attr("data")).replaceTmById($(event.target).parents(".unitBox:first"));
            DWZ.debug("DataID:" + dataId);
            if (!dataId.isFinishedTm()) {
                alertMsg.error($this.attr("warn") || DWZ.msg("alertSelectMsg"));
                return false;
            }
            $.ajaxWebService("TalentInfo/TalentInfo.aspx/DelTalent", "{id:" + dataId + "}", function (result) {
                var obj = eval("(" + result.d.toString() + ")");
                if (obj.flag == "true") {
                    var tr = $tbody.children().filter(".selected");
                    $("#" + tr.attr("target"), tr.parent().parent().parent()).remove();
                    tr.remove();
                }
            });
            event.preventDefault();
        },
        RefeshDocument: function (json) {
            DWZ.ajaxDone(json);
            if (json.statusCode == DWZ.statusCode.ok) {
                json.forwardUrl = json.forwardUrl.replace(new RegExp("&amp;", "gm"), "&");
                //$.pdialog.open(, , "简历管理", {width:'400px',height:'500px',max:true});
                $.pdialog.reload(json.forwardUrl, "", json.rel)
            }
        },
        TalentCallBack: function (json) {
            DWZ.ajaxDone(json);
            if (json.statusCode == DWZ.statusCode.ok) {
                var tmp = json.rel;
                if (tmp == "basicID") {
                    $("#" + json.rel).loadUrl("TalentInfo/TalentBasic.aspx?CB_No=" + json.addId, "", function () {
                        $("#" + json.rel).find("[layoutH]").layoutH();
                    });
                    map.navTabLabel(json);
                }
                else if (tmp == "studyID") $("#" + json.rel).loadUrl("TalentInfo/TalentStudy.aspx?CB_No=" + json.addId, "", function () {
                    $("#" + json.rel).find("[layoutH]").layoutH();
                });
                else if (tmp == "listID") $("#" + json.rel).loadUrl("TalentInfo/TalentLlist.aspx?CB_No=" + json.addId, "", function () {
                    $("#" + json.rel).find("[layoutH]").layoutH();
                });
            }
        },
        SaveTalent: function () {
            $("input[name=webmethod]").val("updateTalentInfo");
            $("#TEST").submit();
        },
        SearchHistory: function (CB_NO) {
            //alert($("#TEST"));
            //方法1
            $("input[name=webmethod]").val("SearchHistoryInfo");
            $("#TEST").submit();
            //            return;
            //方法2，取所有字段，并写在&CB_NO=" + CB_NO后
//            $("input[name=SP_AVGBase]").val()
//            return;
//            ajaxTodo("ajaxWebServices.ashx?webmethod=SearchHistoryInfo&CB_NO=" + CB_NO, function (json) {
//                DWZ.ajaxDone(json);
//                if (json.statusCode == DWZ.statusCode.ok) {
//                    map.navTabLabel(json);
//                }
            //            });
//方法2结束
        },
        DelTalent: function (CB_NO) {
            /*未完善*/
            ajaxTodo("ajaxWebServices.ashx?webmethod=delTalentInfo&CB_NO=" + CB_NO, function (json) {
                DWZ.ajaxDone(json);
                if (json.statusCode == DWZ.statusCode.ok) {
                    setTimeout(function () { navTab.closeCurrentTab("TalentInfo"); map.lmap.closeInfoWindow(); map.getData(); }, 100);
                }
            });
        }



    })
})();