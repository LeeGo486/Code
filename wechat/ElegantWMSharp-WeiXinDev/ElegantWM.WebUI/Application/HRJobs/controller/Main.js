Ext.define('WMC.controller.Main', {
    extend: 'Ext.app.Controller',
    models: ['Jobs','HRJobSeeker'],
    stores: ['Jobs','HRJobSeeker'],
    views: ['MainGrid', 'EditWin','WMC.common.view.ExtKindEditor','SeekerWinGrid'],
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
        },
        {
            ref: 'responsibilities',
            selector: 'editwin form [name=Responsibilities]'
        },
        {
            ref: 'skills',
            selector: 'editwin form [name=Skills]'
        },
        {
            ref: 'seekerWin',
            selector: 'seekerwingrid',
            autoCreate: true,
            xtype: 'seekerwingrid'
        },
        {
            ref: 'seekerGrid',
            selector:'seekerwingrid grid'
        }
    ],
    //声明监控事件
    init: function () {
        this.control({
            'maingrid': {
                itemdblclick: this.editRecord,
                cellclick:this.gridCellClick
            },
            'editwin button[action=btnSave]': {
                click: this.saveRecord
            },
            'maingrid button[action=btnAdd]': {
                click: this.addRecord
            },
            'maingrid button[action=btnDelete]': {
                click: this.deleteRecord
            },
            'seekerwingrid grid button[action=btnDelete]': {
                click: this.deleteSeeker
            }
        });
    },
    onLaunch: function () {
        //根据权限控制界面按钮状态
        //Ext.Tools.CtrlButtonsByPermession("Jobs", this.getMainGrid(), false);
    },
    //单击单元格
    gridCellClick: function (grid, td, cellIndex, record, tr, rowIndex) {
        //如果选择的是招聘人数这一列，那么打开window
        if (grid.getGridColumns()[cellIndex].dataIndex == "JobSeekers") {
            if (record.get("JobSeekers") == 0) {
                Ext.Tools.Msg("该职位没有应聘人员！", 9);
                return;
            }
            var skr = this.getSeekerWin();
            skr.setTitle("职位：" + record.get("JobName"));
            skr.show();
            //加载数据
            store = this.getSeekerGrid().getStore();
            store.getProxy().setExtraParam("jobId", record.get("Id"));
            store.loadPage(1);
        }
    },
    //新增
    addRecord: function () {
        this.getEditWin().show();
    },
    //编辑
    editRecord: function (view, record, item, index) {
        var win = this.getEditWin();
        var form = win.down("form");
        form.loadRecord(record);
        win.show();
        this.getSkills().setValue(record.data.Skills);
        this.getResponsibilities().setValue(record.data.Responsibilities);
    },
    //保存
    saveRecord: function () {
        var win = this.getEditWin();
        var form = win.down("form");
        var model = form.getValues();
        model.Skills = this.getSkills().getValue();
        model.Responsibilities = this.getResponsibilities().getValue();
        if (form.isValid()) {
            record = form.getRecord();
            var store = this.getMainGrid().getStore();
            if (record) {//如果是修改
                record.set(model);
            }
            else {
                store.add(model);
            }
            //Date类型的需要重新赋值才起作用，很奇怪
            //record.data.Birthday = model.Birthday;
            win.close();
            store.sync();
        }
    },
    //删除
    deleteSeeker: function () {
        var grid = this.getSeekerGrid();
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
    }
});
