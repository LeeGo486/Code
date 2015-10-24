(function () {
    //global name space for home page
    map = {};
    map.curMkr = new Array();
    map.labelList = new Array();
    $.extend(map, {
        initialize: function () {
            $("#MapContainer").css("width", this.MapWidth($("#MapContainer")));
            $("#MapContainer").css("height", this.MapHeight($("#MapContainer")));
            map.lmap = new BMap.Map("MapContainer");
            var point = new BMap.Point(105.504445, 35.65435);
            map.lmap.centerAndZoom(point, 5);
            map.lmap.addControl(new BMap.NavigationControl());
            map.lmap.addControl(new BMap.ScaleControl());
            map.lmap.enableScrollWheelZoom();
            $("button[name=mapsearch]").click(function () { map.getData(); });
            map.getData();
            //打开的info window
            //map.infoWindow = new BMap.InfoWindow("<div><h4 style='margin:0 0 5px 0;padding:0.2em 0'>哥弟时尚</h4>" + "<img style='float:right;margin:4px' id='imgDemo' src='http://app.baidu.com/map/images/tiananmen.jpg' width='139' height='104' title='哥弟时尚'/>" + "<p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em;width:auto'>哥弟GIRDEAR简介：源自中国台湾，创始于公元1977年，本着将心比心、相辅相成的团队观，秉持物有所值、物超所值的诚信经营理念。乐观的、坚毅的、责任的，期望打造出一个不断创造工作机会，回馈社会，有信、有望、有爱的企业...<a href='javascript:void(0);' target='navTab' style='color:blue'  onclick='map.openNavTab();return false ;'>详情</a></p>" + "</div>");  // 创建信息窗口对象
        },
        MapHeight: function (obj) {
            var $this = obj;
            var iRefH = $this.parents("div.layoutBox:first").height();
            var iLayoutH = parseInt($this.parent().attr("layoutH"));
            var iH = iRefH - iLayoutH > 50 ? iRefH - iLayoutH : 50;
            return iH;
        },
        MapWidth: function (obj) {
            var $this = obj;
            return $this.parents("div.layoutBox:first").width();
        },
        openBz: function () {
            map.mkrTool.open(); //打开工具 
        },
        closeBz: function () {
            map.mkrTool.close();
        },
        BzAddClick: function (obj) {
            obj.addEventListener("dblclick", function () {
                map.MkrDialog = this;
                $.pdialog.open("TalentInfo/LabelDialog.aspx?CB_X=" + this.getPosition().lng + "&CB_Y=" + this.getPosition().lat, "TalentLabel", "人才信息", { height: 460 });
            });
        },
        getData: function () {
            var name = $.trim($("#Map_Name").val());
            var position = $.trim($("#Map_Position").val());
            var talentclass = $.trim($("#Map_TalentClass").val());
            var SqlStr = "";
            if (name != "") {
                SqlStr += " and CB_Name like '%" + name + "%' ";
            }
            if (position != "") {
                SqlStr += " and CB_Position like '%" + position + "%' ";
            }
            if (talentclass != "") {
                SqlStr += " and TC_Color  = '" + talentclass + "' ";
            }
            map.lmap.clearOverlays(); //清除覆盖物
            map.mkrTool = new BMapLib.MarkerTool(map.lmap, { autoClose: true });
            map.mkrTool.addEventListener("markend", function (evt) {
                //mkr.openInfoWindow(infoWin);
                map.curMkr.push(evt.marker);
                evt.marker.enableDragging();
                map.BzAddClick(evt.marker);
            });
            var icon = BMapLib.MarkerTool.SYS_ICONS[0];
            map.mkrTool.setIcon(icon);
            $.ajaxWebService("Map/Map.aspx/GetModelListAndClass", "{querystr:\"" + SqlStr + "\"}", function (result) {
                var arr = eval("(" + result.d.toString() + ")");
                for (var i = 0; i < arr.length; i++) {
                    map.lmap.addOverlay(map.getLabel(arr[i].ColorInfo, arr[i].InfoWindow, new BMap.Point(arr[i].X, arr[i].Y), arr[i].ID));
                }
            });

        }
        ,
        getLabel: function (ColorInfo, InfoWindow, point, level) {

            // var infoWindow = '<div id="' + id + '" class="marker_2"><DIV class="colorPicker_controlset"><DIV style="BACKGROUND-COLOR: #800080;width:4px" class="colorPicker-picker-self"></DIV><DIV style="BACKGROUND-COLOR: #230087;width:4px" class="colorPicker-picker-self">&nbsp;</DIV><DIV style="BACKGROUND-COLOR: #234523;width:4px" class="colorPicker-picker-self">&nbsp;</DIV><DIV style="BACKGROUND-COLOR: #125678;width:4px" class="colorPicker-picker-self">&nbsp;</DIV></div>';
            //var infoWindow = '<div id="' + id + '" class="marker_2"><div class="marker_word" >哥弟时尚<em class="marker_r"></em></div><em class="marker_b"></em></div>';
            // point = new BMap.Point(106, 34);
            // var c = new BMap.Label(infoWindow, { offset: new BMap.Size(-19, -25), position: point });
            var c = new BMap.Label(ColorInfo, { offset: new BMap.Size(-10, -20), position: point });

            c.setZIndex(level);
            /* c._originalZIndex = level;
            c._originalClassName = "marker_2";*/
            c.setStyle({
                border: "none", backgroundColor: "transparent", display: "inline"
            });

            var infow = new BMap.InfoWindow(InfoWindow);
            /* c.addEventListener("mouseover", function () { c.setZIndex(100); $("#" + id).attr("class", "marker_3"); });
            c.addEventListener("mouseout", function () {
            c.setZIndex(c._originalZIndex);
            $("#" + id).attr("class", c._originalClassName)
            });*/
            c.addEventListener("click", function () {
                map.lmap.openInfoWindow(infow, this.getPosition());
            });
            // lmap.openInfoWindow(infoWindow, lmap.getCenter())
            return c;
            // lmap.addOverlay(c);
            //  lmap.openInfoWindow(infoWindow, lmap.getCenter()); 
        },
        openNavTab: function (no) {
            navTab.openTab("TalentInfo", "TalentInfo/TalentInfo.aspx?CB_No=" + no, { title: "政策信息" });
        },
        replaceLabel: function (json) {
            DWZ.ajaxDone(json);
            if (json.statusCode == DWZ.statusCode.ok) {
                if (json.navTabId) {
                    navTab.reload(json.forwardUrl, { navTabId: json.navTabId });
                } else if (json.rel) {
                    navTabPageBreak({}, json.rel);
                }
                if ("closeCurrent" == json.callbackType) {
                    $.pdialog.closeCurrent();
                }
                if (map.MkrDialog) {
                    map.lmap.removeOverlay(map.MkrDialog); //清除覆盖物
                }
                if (json.addId) {
                    $.ajaxWebService("Map/Map.aspx/GetModelListAndClass", "{querystr:\" and CB_No='" + json.addId + "'\"}", function (result) {
                        var arr = eval("(" + result.d.toString() + ")");
                        for (var i = 0; i < arr.length; i++) {
                            map.lmap.addOverlay(map.getLabel(arr[i].ColorInfo, arr[i].InfoWindow, new BMap.Point(arr[i].X, arr[i].Y), arr[i].ID));
                        }
                    });
                }
            }
        },
        navTabLabel: function (json) {
            if (json.addId) { 
                $.ajaxWebService("Map/Map.aspx/GetModelListAndClass", "{querystr:\" and CB_No='" + json.addId + "'\"}", function (result) {
                    var arr = eval("(" + result.d.toString() + ")");
                    for (var i = 0; i < arr.length; i++) {
                        map.lmap.addOverlay(map.getLabel(arr[i].ColorInfo, arr[i].InfoWindow, new BMap.Point(arr[i].X, arr[i].Y), arr[i].ID + 100));
                    }
                });
            }
            else {
                $.ajaxWebService("Map/Map.aspx/GetModelListAndClass1", "{querystr:\" and CB_No='" + json.addId + "'\"}", function (result) {
                    var arr = eval("(" + result.d.toString() + ")");
                    for (var i = 0; i < arr.length; i++) {
                        map.lmap.addOverlay(map.getLabel(arr[i].ColorInfo, arr[i].InfoWindow, new BMap.Point(arr[i].X, arr[i].Y), arr[i].ID + 100));
                    }
                });
            }
        }
        //        navTabLabel1: function (json) {
        //            if (json.addId) {
        //                $.ajaxWebService("Map/Map.aspx/GetModelListAndClass", "{querystr:\" and CB_No='" + json.addId + "'\"}", function (result) {
        //                    var arr = eval("(" + result.d.toString() + ")");
        //                    for (var i = 0; i < arr.length; i++) {
        //                        map.lmap.addOverlay(map.getLabel(arr[i].ColorInfo, arr[i].InfoWindow, new BMap.Point(arr[i].X, arr[i].Y), arr[i].ID + 100));
        //                    }
        //                });
        //            }
        //        }
    })
})();