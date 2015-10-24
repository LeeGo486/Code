Ext.define('WMC.controller.Main', {
    extend: 'Ext.app.Controller',
    models: ['HRCourse', 'HRCourseLesson', 'HRCourseUser', 'HRSignRst'],
    stores: ['HRCourse', 'HRCourseLesson', 'HRCourseUser', 'HRSignRst'],
    views: ['MainGrid', 'EditWin', 'CourseForm', 'CourseLesson', 'QRCodeBarWin', 'StudGridWin', 'SignRstGridWin'],
    //注意：如果该模块使用了KindEditor富文本框编辑器，详细使用规范请参考博客说明 http://www.cnblogs.com/qidian10/p/3619701.html
    refs: [
        {
            ref: 'mainGrid',
            selector: 'maingrid'
        },
        {
            ref: 'editWin',
            selector: 'editwin',
            autoCreate: true,
            xtype: 'editwin'
        }, {
            ref: 'qrCodeBarWin',
            selector: 'qrcodebarwin',
            autoCreate: true,
            xtype: 'qrcodebarwin'
        }, {
            ref: 'lessonGrid',
            selector: 'courselesson'
        }, {
            ref: 'qrImg',
            selector: 'qrcodebarwin [name=QRCodeBarImg]'
        }, {
            ref: 'qrUrl',
            selector: 'qrcodebarwin [name=QRCodeBarUrl]'
        }, {
            ref: 'studGridWin',
            selector: 'studgridwin',
            autoCreate: true,
            xtype: 'studgridwin'
        }, {
            ref: 'signRstGridWin',
            selector: 'signrstgridwin',
            autoCreate: true,
            xtype: 'signrstgridwin'
        }
    ],
    //声明监控事件
    init: function () {
        this.control({
            'maingrid': {
                itemdblclick: this.editRecord,
                cellclick: this.gridCellClick
            },
            'editwin button[action=btnSave]': {
                click: this.saveRecord
            },
            'editwin button[action=btnExport]': {
                click: this.ExcelExport
            },
            'maingrid button[action=btnAdd]': {
                click: this.addRecord
            },
            'maingrid button[action=btnDelete]': {
                click: this.deleteRecord
            },
            'maingrid button[action=btnDisplay]': {
                click: this.displayRecord
            },
            'courselesson': {
                //编辑
                edit: function (editor, e) {
                    this.getLessonGrid().getStore().sync();//保存 
                },
                itemclick: this.rowEditorUpdateBtnDisable,
                itemdblclick: this.rowEditorUpdateBtnDisable
            },
            'courselesson button[action=btnAddLesson]': {
                click: this.addLessonRecord
            },
            'courselesson button[action=btnDeleteLesson]': {
                click: this.deleteLessonRecord
            },
            'courselesson actioncolumn': {
                click: this.createLessonQRCode
            },
            'signrstgridwin grid': {
                //编辑
                edit: function (editor, e) {
                    this.getSignRstGridWin().down("grid").getStore().sync();//保存 
                },
                itemclick: this.rowEditorUpdateBtnDisableSign,
                itemdblclick: this.rowEditorUpdateBtnDisableSign
            }
        });
    },
    onLaunch: function () {
        //根据权限控制界面按钮状态
        //Ext.Tools.CtrlButtonsByPermession("HRCourse", this.getMainGrid(), false);
    },

    /*************这里是控制LessonGrid****************/
    //解决rowEditor插件的按钮bug
    rowEditorUpdateBtnDisable: function (me, record, item, index, e, eOpts) {
        if (this.getLessonGrid().getPlugin("rowEditor").editor) {
            this.getLessonGrid().getPlugin("rowEditor").editor.floatingButtons.child('#update').setDisabled(false);
        }
    },
    //解决rowEditor插件的按钮bug
    rowEditorUpdateBtnDisableSign: function (me, record, item, index, e, eOpts) {
        if (this.getSignRstGridWin().down("grid").getPlugin("rowEditor").editor) {
            this.getSignRstGridWin().down("grid").getPlugin("rowEditor").editor.floatingButtons.child('#update').setDisabled(false);
        }
    },
    //新增
    addLessonRecord: function () {
        //缺少cid哦
        rowEditing = this.getLessonGrid().getPlugin("rowEditor");
        rowEditing.cancelEdit();
        var r = Ext.create('WMC.model.HRCourseLesson', {
            Id: Ext.data.IdGenerator.get('uuid').generate(),
            Cid: this.getLessonGrid().CourseId,
            LessonName: '第 节'
        });
        this.getLessonGrid().getStore().insert(0, r);
        rowEditing.startEdit(0, 0);
        rowEditing.enable();
        rowEditing.editor.floatingButtons.child('#update').setDisabled(false);
    },
    //删除
    deleteLessonRecord: function () {
        var grid = this.getLessonGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要操作的行！", 1);
            return;
        }
        var records = selModel.getSelection();
        Ext.MessageBox.confirm("警告", "是否要彻底删除这些信息吗？", function (button, text) {
            if (button == "yes") {
                grid.getStore().remove(records);
                grid.getStore().sync();//保存
            }
        });
    },
    createLessonQRCode: function (grid, cell, row, col, e) {
        var rec = grid.getStore().getAt(row);
        var classList = e.getTarget().className;
        grid.getSelectionModel().select(row, false);
        if (classList.indexOf(" QRCodeBar") > 0) {
            var win = this.getQrCodeBarWin();
            this.getQrImg().html = "<div style='text-align:center;padding:6px;'><a href='/Admin/HRCourseLesson/ShowQRCode/" + rec.data.Id + "' target='_blank'><img src='/Admin/HRCourseLesson/ShowQRCode/" + rec.data.Id + "' border=0 width='280' /></a></div>";
            var wholeUrl = window.location.href.replace("http://", "");
            this.getQrUrl().setValue("http://" + wholeUrl.substring(0, wholeUrl.indexOf("/")) + "/HR/Course/SignIn/" + rec.data.Id);
            win.show();
        } else if (classList.indexOf(" StatusAway") > 0) {
            var win = this.getSignRstGridWin();
            win.show();
            var store = win.down("grid").getStore();
            store.getProxy().setExtraParam("lid", rec.get("Id"));
            store.loadPage(1);
        }
    },
    /************************************************/

    //单击单元格
    gridCellClick: function (grid, td, cellIndex, record, tr, rowIndex) {
        //如果选择的是招聘人数这一列，那么打开window
        if (grid.getGridColumns()[cellIndex].dataIndex == "RegisterNum") {
            if (record.get("RegisterNum") == 0) {
                Ext.Tools.Msg("该课程暂无人员报名！", 9);
                return;
            }

            var stud = this.getStudGridWin();
            stud.setTitle("课程：" + record.get("CourseName"));
            stud.show();
            //加载数据
            store = stud.down("grid").getStore();
            store.getProxy().setExtraParam("courseId", record.get("Id"));
            store.loadPage(1);
        }
    },
    //新增
    addRecord: function () {
        var win = this.getEditWin();
        win.down("tabpanel").items.getAt(1).setDisabled(true);
        win.show();
        this.getLessonGrid().getStore().removeAll();
        delete this.getLessonGrid().getStore().getProxy().extraParams.Cid;
        this.getLessonGrid().CourseId = "";

    },
    //编辑
    editRecord: function (view, record, item, index) {
        var win = this.getEditWin();
        var form = win.down("form");
        form.loadRecord(record);
        //加载lesson store
        this.getLessonGrid().getStore().getProxy().setExtraParam("Cid", record.data.Id);
        this.getLessonGrid().getStore().load();
        this.getLessonGrid().CourseId = record.data.Id;
        win.show();
    },
    //保存
    saveRecord: function () {
        var win = this.getEditWin();
        var lessonGrid = this.getLessonGrid();
        var form = win.down("form");
        var model = form.getValues();
        if (form.isValid()) {
            var record = form.getRecord();
            var Id = Ext.data.IdGenerator.get('uuid').generate();
            var store = this.getMainGrid().getStore();
            if (record) {//如果是修改
                Id = record.data.Id;
                record.set(model);
            }
            else {
                //record = Ext.create('WMC.model.HRCourse', model);
                //store.add(record);
                //如果没有datefield，可以直接设置为
                model["Id"] = Id;
                store.add(model);
            }
            //Date类型的需要重新赋值才起作用，很奇怪
            //record.data.Birthday = model.Birthday;

            store.sync({
                success: function (batch, options) {
                    var rst = Ext.JSON.decode(batch.operations[0].response.responseText);

                    if (rst.result == "0") {//&& !record
                        win.down("tabpanel").items.getAt(1).setDisabled(false);
                        win.down("tabpanel").setActiveTab(win.down("tabpanel").items.getAt(1));
                        lessonGrid.CourseId = Id;
                        Ext.Tools.Msg("请为该课程添加课时！", 0);
                    }
                }
            });
        }
    },
    ExcelExport: function () {
        var win = this.getEditWin();
        //alert("导入");
        var form = win.down("form");
        var model = form.getValues();
        if (form.isValid()) {
            var record = form.getRecord();

            if (record) {
                if (model.SignUpType == 1) {
                    Ext.Tools.Msg("需要报名,无需导入", 0); return;
                } else {
                    Id = record.data.Id;
                    var type = record.data.SignUpType;
                    window.open('http://192.168.0.35:99/WEB/3S/EhrCouseImport.HTML?r=' + "&courseid=" + Id + "&type=" + type, 'newwindow', 'height=400,width=500,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no')
                }
            }
        }
        else {
            Ext.Tools.Msg("请先保存,如果已经保存请关闭窗口,再打开,再单击导入", 0); return;
        }
    },
    //删除
    deleteRecord: function () {
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要操作的行！", 1);
            return;
        }
        var records = selModel.getSelection();
        Ext.MessageBox.confirm("警告", "是否要彻底删除这些信息吗？", function (button, text) {
            if (button == "yes") {
                grid.getStore().remove(records);
                grid.getStore().sync();//保存
            }
        });
    },
    displayRecord: function () {
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要操作的行！", 1);
            return;
        }
        var records = selModel.getSelection();
        Ext.each(records, function (record) {
            record.set("IsShow", (record.get("IsShow") == 0 ? 1 : 0));
        });
        grid.getStore().sync();//保存
    }
});
