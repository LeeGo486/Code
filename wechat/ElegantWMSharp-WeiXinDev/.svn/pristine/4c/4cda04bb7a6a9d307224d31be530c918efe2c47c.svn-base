Ext.define('WMC.controller.Main', {
    extend: 'Ext.app.Controller',
    models: ['ITSMBasicInfo', 'ITSMEngineer', 'ITSMEvent'],
    stores: ['ITSMBasicInfoSB', 'ITSMBasicInfoYY', 'ITSMEngineer', 'ITSMEvent'],
    views: ['MainGrid', 'EditWin', 'EgrWin'],
    //注意：如果该模块使用了KindEditor富文本框编辑器，详细使用规范请参考博客说明 http://www.cnblogs.com/qidian10/p/3619701.html
    refs: [
        {
            ref: 'mainGrid',
            selector: 'maingrid'
        },
        {
            ref: 'btnAuto',
            selector:'maingrid button[action=btnAutoReflash]'
        },
        {
            ref: 'editWin',
            selector: 'editwin',
            autoCreate: true,
            xtype: 'editwin'
        }, {
            ref: 'egrWin',
            selector: 'egrwin',
            autoCreate: true,
            xtype: 'egrwin'
        }, {
            ref: 'assEgr',
            selector: 'combo[name=Engineer]'
        }
    ],
    //声明监控事件
    init: function () {
        this.control({
            'maingrid': {
                itemdblclick: this.editRecord
            },
            'editwin button[action=btnSave]': {
                click: this.saveRecord
            },
            'editwin': {
                close: function () {
                    //启动刷新
                    this.setTaskStatus(0);
                }
            },
            'egrwin': {
                close: function () {
                    //启动刷新
                    this.setTaskStatus(0);
                }
            },
            'editwin textfield[name=ReqMan]': {
                blur: function (ths) {
                    this.getReqManInfo(ths.getValue());
                }
            },
            'maingrid button[action=btnAdd]': {
                click: this.addRecord
            },
            'maingrid button[action=btnDelete]': {
                click: this.deleteRecord
            },
            'maingrid button[action=btnAss]': {
                click: function () {
                    var grid = this.getMainGrid();
                    var selModel = grid.getSelectionModel();
                    if (!selModel.hasSelection()) {
                        Ext.Tools.Msg("请先选择要派工的记录！", 1);
                        return;
                    }
                    //当单击派工按钮的时候，停止刷新
                    this.getEgrWin().show();
                    this.setTaskStatus(1);
                }
            },
            'maingrid button[action=btnAutoReflash]': {
                click: function () {
                    if (this.getBtnAuto().getText() == "自动刷新（已开启）") {
                        runnerTask.stop();
                        this.getBtnAuto().setIconCls("RecordRed");
                        this.getBtnAuto().setText("自动刷新（已关闭）");
                    } else {
                        runnerTask.start();
                        this.getBtnAuto().setIconCls("RecordGreen");
                        this.getBtnAuto().setText("自动刷新（已开启）");
                    }
                }
            },
            'egrwin button[action=btnSure]': {
                click: this.Assignment
            }
        });
    },
    onLaunch: function () {
        //根据权限控制界面按钮状态
        //Ext.Tools.CtrlButtonsByPermession("ITSMEvent", this.getMainGrid(), false);
        //设置Grid自动刷新
        var ths = this;

        var runner = new Ext.util.TaskRunner();
        runnerTask = runner.newTask({
            run: function () {
                ths.autoReflashEvent();
            },
            interval: 10000
        });
        runnerTask.start();
    },
    //开启或者关闭任务
    setTaskStatus: function (t) {
        if (t == 1) {
            runnerTask.stop();
            this.getBtnAuto().setIconCls("RecordRed");
            this.getBtnAuto().setText("自动刷新（已关闭）");
        } else if (t == 0) {
            runnerTask.start();
            this.getBtnAuto().setIconCls("RecordGreen");
            this.getBtnAuto().setText("自动刷新（已开启）");
        }
    },
    //自动监控，每隔5s中自动到后台获取一次数据
    autoReflashEvent: function () {
        Ext.Ajax.request({
            url: '/Admin/ITSMEvent/GetPer5Second',
            method: 'GET',
            scope: this,
            success: function (response) {
                var rst = Ext.JSON.decode(response.responseText);
                if (rst.total > 0) {
                    Ext.Tools.Msg("收到（" + rst.total + "条）新的ITSM事件，请及时处理！", 0);
                    
                    //将数据添加到grid
                    var store = this.getMainGrid().getStore();
                    Ext.each(rst.data, function (record) {
                        var rec = Ext.create('WMC.model.ITSMEvent', record);
                        store.add(rec);
                    });
                    //播放声音
                    soundManager.play('newmsg');

                } else if (intervalCount > 2) {
                    intervalCount = 0;
                    this.getMainGrid().getStore().reload();
                } else {
                    intervalCount++;
                }
            },
            failure: function (response) {
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
    },
    //获取提报人信息
    getReqManInfo: function (reqman) {
        if (reqManStatic != reqman) {
            Ext.Ajax.request({
                url: '/Admin/ITSMEvent/GetReqManInfo?reqMan=' + reqman,
                method: 'GET',
                scope: this,
                success: function (response) {
                    var rst = Ext.JSON.decode(response.responseText);
                    if (rst.total <= 0) return;
                    
                    //获取了数据，那么给form赋值
                    var win = this.getEditWin();
                    var form = win.down("form");
                    form.down("[name=ReqCom]").setValue(rst.data[0].ReqCom);
                    form.down("[name=ReqDept]").setValue(rst.data[0].ReqDept);
                    form.down("[name=ReqManPhone]").setValue(rst.data[0].ReqManPhone);
                    form.down("[name=ReqIncident]").setValue(rst.data[0].ReqIncident);
                },
                failure: function (response) {
                    Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
                }
            });
        }
    },
    //新增
    addRecord: function () {
        this.getEditWin().show();
        //新增的时候关闭刷新
        this.setTaskStatus(1);
    },
    //编辑
    editRecord: function (view, record, item, index) {
        var win = this.getEditWin();
        var form = win.down("form");
        form.loadRecord(record);
        win.show();
        //编辑的时候关闭刷新
        this.setTaskStatus(1);
    },
    //保存
    saveRecord: function () {
        var win = this.getEditWin();
        var form = win.down("form");
        var model = form.getValues();
        if (form.isValid()) {
            record = form.getRecord();
            var store = this.getMainGrid().getStore();
            if (record) {//如果是修改
                record.set(model);
            }
            else {
                //record = Ext.create('WMC.model.ITSMEvent', model);
                //store.add(record);
                //如果没有datefield，可以直接设置为
                model["Id"] = Ext.data.IdGenerator.get('uuid').generate();
                model["CreateTime"] = "/Date(" + (new Date()).getTime() + ")/";
                store.add(model);
            }
            //Date类型的需要重新赋值才起作用，很奇怪
            //record.data.Birthday = model.Birthday;
            win.close();
            store.sync();
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
        var ths = this;
        var records = selModel.getSelection();
        ths.setTaskStatus(1);
        Ext.MessageBox.confirm("警告", "是否要彻底删除这些信息吗？", function (button, text) {
            if (button == "yes") {
                grid.getStore().remove(records);
                grid.getStore().sync();//保存
                //删除完成后，开启刷新
                ths.setTaskStatus(0);
            }
        });
    },
    //派工
    Assignment: function () {
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要派工的记录！", 1);
            return;
        }
        var records = selModel.getSelection();
        var egr = this.getAssEgr().getValue();
        if (egr == null || egr == '') {
            Ext.Tools.Msg("请选择工程师！", 1);
            return;
        }
        var evts = [];
        Ext.each(records, function (value, index) {
            evts.push(value.data.Id);
        });
        var myMask = new Ext.LoadMask(this.getEgrWin(), { msg: "请稍等..." });
        myMask.show();
        Ext.Ajax.request({
            url: '/Admin/ITSMEvent/Assignment',
            method: 'POST',
            params: { ids: evts, egrName: egr },
            scope: this,
            success: function (response) {
                myMask.hide();
                var rst = Ext.JSON.decode(response.responseText);
                Ext.Tools.Msg(rst.msg, rst.result);
                if (rst.result == 0) {
                    this.getEgrWin().close();
                    //this.setTaskStatus(0);
                    grid.getStore().reload();
                }
            },
            failure: function (response) {
                myMask.hide();
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
    }
});
