Ext.define('WMC.controller.Main', {
    extend: 'Ext.app.Controller',
    models: ['Account', 'WXRespImgTxt', 'WXKeyWord'],
    stores: ['Account', 'WXRespImgTxt', 'WXKeyWord'],
    views: ['MainGrid', 'EditWin', 'resp.MainGrid', 'resp.EditWin', 'WMC.common.view.ExtKindEditor'],
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
            ref: 'cRespText',
            selector: 'tabpanel #CRespText'
        }, {
            ref: 'respTab',
            selector: 'tabpanel'
        }, {
            ref: 'respMainGrid',
            selector: 'respmaingrid'
        }, {
            ref: 'respWin',
            selector: 'respeditwin',
            autoCreate: true,
            xtype: 'respeditwin'
        }, {
            ref: 'respContent',
            selector: '#RespContent'
        }, {
            ref: 'respSrvForm',
            selector: 'tabpanel form'
        }
    ],
    //声明监控事件
    init: function () {
        this.control({
            'maingrid': {
                itemdblclick: this.editRecord,
                itemclick:this.cfgResp
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
            'maingrid combobox[name=cbAccount]': {
                select: this.loadKeyWords
            },
            'tabpanel button[action=btnSaveTxt]': {
                click: this.saveTxtAction
            },
            'tabpanel form button[action=btnSaveSrv]': {
                click: this.saveSrvAction
            },
            'tabpanel form button[action=btnSrvTest]': {
                click: this.testSrvAction
            },
            //图文页面管理
            'respmaingrid button[action=btnAdd]': {
                click: function () {
                    //var grid = this.getRespMainGrid();
                    //if (grid.getStore().getCount() >= 10) {
                    //    Ext.Tools.Msg("最多支持10条信息！", 1);
                    //    return;
                    //}
                    this.getRespWin().show();
                }
            },
            'respmaingrid': {
                itemdblclick: this.editRespRecord
            },
            'respeditwin button[action=btnSave]': {
                click: this.saveRespRecord
            },
            'respeditwin filefield': {
                change: function (f, v) {
                    var form = this.getRespWin().down('form').getForm();
                    var accountId = this.getAccountId();
                    if (accountId == null) {
                        Ext.Tools.Msg("请先选择微信账号！", 1);
                        return;
                    }
                    form.submit({
                        url: '/Admin/WXRespImgTxt/UploadImg?sid=' + accountId,
                        type: 'ajax',
                        waitMsg: '图片上传中...',
                        clientValidation: false,
                        scope: this,
                        success: function (f, o) {
                            var rst = Ext.JSON.decode(o.response.responseText);
                            if (rst.result == 0) {
                                Ext.Tools.Msg("图片上传成功！", rst.result);
                                this.getRespWin().down('[name=ImageUrl]').setValue(rst.msg);
                            } else {
                                Ext.Tools.Msg(rst.msg, rst.result);
                            }
                        },
                        failure: function (f, o) {
                            var rst = Ext.JSON.decode(o.response.responseText);
                            Ext.Tools.Msg(rst.msg, 9);
                        }
                    });
                }
            },
            'respmaingrid button[action=btnDelete]': {
                click: this.deleteRespRecord
            }
        });
    },
    onLaunch: function () {
        //根据权限控制界面按钮状态
        //Ext.Tools.CtrlButtonsByPermession("WXKeyWord", this.getMainGrid(), false);
    },
    //新增
    addRecord: function () {
        if (this.getAccountId() == null) {
            Ext.Tools.Msg("请先选择微信号！", 1);
            return;
        }
        this.getEditWin().show();
    },
    //编辑
    editRecord: function (view, record, item, index) {
        var win = this.getEditWin();
        var form = win.down("form");
        form.loadRecord(record);
        win.show();
    },
    //保存
    saveRecord: function () {
        var aid=this.getAccountId();
        if (aid == null) {
            Ext.Tools.Msg("请先选择微信号！", 1);
            return;
        }

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
                //record = Ext.create('WMC.model.WXKeyWord', model);
                //store.add(record);
                //如果没有datefield，可以直接设置为
                model["Id"] = Ext.data.IdGenerator.get('uuid').generate();
                model["AccountId"] = aid;
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
        var records = selModel.getSelection();
        Ext.MessageBox.confirm("警告", "是否要彻底删除这些信息吗？", function (button, text) {
            if (button == "yes") {
                grid.getStore().remove(records);
                grid.getStore().sync();//保存
            }
        });
    },
    getAccountId: function () {
        var accountInfo = this.getMainGrid().down("combobox[name=cbAccount]");
        return accountInfo.getValue();
    },
    loadKeyWords: function () {
        var store = this.getMainGrid().getStore();
        store.getProxy().setExtraParam("aid", this.getAccountId());
        store.load();
    },
    //配置关键字响应
    cfgResp: function () {
        //获取选中的菜单
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            return;
        }
        var records = selModel.getSelection();
        var mid = records[0].data.Id;

        this.getRespTab().setDisabled(true);
        if (records[0].data.RespType == "text") {
            this.getRespTab().setDisabled(false);
            this.getRespTab().down("[title=图文]").setDisabled(true);
            this.getRespTab().down("[title=文本]").setDisabled(false);
            this.getRespTab().down("[title=服务]").setDisabled(true);
            this.getRespTab().setActiveTab(0);
            var myMask = new Ext.LoadMask(this.getRespTab(), { msg: "信息获取中..." });
            myMask.show();
            Ext.Ajax.request({
                url: '/Admin/WXRespImgTxt/GetRespList',
                method: 'GET',
                params: {
                    kwId: mid
                },
                scope: this,
                success: function (response) {
                    myMask.hide();
                    this.getCRespText().setValue("");
                    var rst = Ext.JSON.decode(response.responseText);
                    if (rst.length > 0) {
                        this.getCRespText().setValue(rst[0].Content);
                    }
                },
                failure: function (response) {
                    myMask.hide();
                    Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
                }
            });
        } else if (records[0].data.RespType == "news") {
            this.getRespTab().setDisabled(false);
            this.getRespTab().down("[title=图文]").setDisabled(false);
            this.getRespTab().down("[title=文本]").setDisabled(true);
            this.getRespTab().down("[title=服务]").setDisabled(true);
            this.getRespTab().setActiveTab(1);
            //加载图文数据
            var store = this.getRespMainGrid().getStore();
            store.getProxy().setExtraParam("kwId", mid);
            store.load();
        } else if (records[0].data.RespType.indexOf("svr") >= 0) {
            this.getRespTab().setDisabled(false);
            this.getRespTab().down("[title=图文]").setDisabled(true);
            this.getRespTab().down("[title=文本]").setDisabled(true);
            this.getRespTab().down("[title=服务]").setDisabled(false);
            this.getRespTab().setActiveTab(2);

            var myMask = new Ext.LoadMask(this.getRespTab(), { msg: "信息获取中..." });
            myMask.show();
            Ext.Ajax.request({
                url: '/Admin/WXRespImgTxt/GetRespList',
                method: 'GET',
                params: {
                    kwId: mid
                },
                scope: this,
                success: function (response) {
                    myMask.hide();
                    var form = this.getRespSrvForm();
                    form.getForm().reset();
                    var rst = Ext.JSON.decode(response.responseText);
                    if (rst.length > 0) {
                        form.down("[name=CRespSvrUrl]").setValue(rst[0].AbsUrl);
                        form.down("[name=CRespSvrParams]").setValue(rst[0].Content);
                    }
                },
                failure: function (response) {
                    myMask.hide();
                    Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
                }
            });
        }
    },
    //测试响应服务
    testSrvAction: function () {
        var form = this.getRespSrvForm();
        var record = form.getValues();
        if (!form.isValid()) {
            return;
        }
        var myMask = new Ext.LoadMask(this.getRespTab(), { msg: "调用服务中..." });
        myMask.show();
        form.down("[name=CRespSvrRst]").setValue("");
        Ext.Ajax.request({
            url: '/Admin/WXRespImgTxt/TestSrv',
            method: 'POST',
            params: {
                url: record.CRespSvrUrl,
                prms: record.CRespSvrParams
            },
            scope: this,
            success: function (response) {
                myMask.hide();
                form.down("[name=CRespSvrRst]").setValue(Ext.JSON.decode(response.responseText));
            },
            failure: function (response) {
                myMask.hide();
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
    },
    //保存响应服务
    saveSrvAction: function () {
        //获取选择的菜单
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要响应的菜单！", 1);
            return;
        }
        var records = selModel.getSelection();
        var mid = records[0].data.Id;
        //获取输入的内容
        var form = this.getRespSrvForm();
        var record = form.getValues();
        if (!form.isValid()) {
            return;
        }
        //保存到后台
        var myMask = new Ext.LoadMask(this.getRespTab(), { msg: "保存中..." });
        myMask.show();
        Ext.Ajax.request({
            url: '/Admin/WXRespImgTxt/SaveRespSrv',
            method: 'POST',
            params: {
                KwId: mid,
                AbsUrl: record.CRespSvrUrl,
                Content: record.CRespSvrParams
            },
            success: function (response) {
                myMask.hide();
                var rst = Ext.JSON.decode(response.responseText);
                Ext.Tools.Msg(rst.msg, rst.result);
            },
            failure: function (response) {
                myMask.hide();
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
    },
    //保存响应文本
    saveTxtAction: function () {
        //获取选择的菜单
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要响应的菜单！", 1);
            return;
        }
        var records = selModel.getSelection();
        var mid = records[0].data.Id;
        //获取标题
        var txt = this.getCRespText().getValue();
        //保存到后台
        var myMask = new Ext.LoadMask(this.getRespTab(), { msg: "保存中..." });
        myMask.show();
        Ext.Ajax.request({
            url: '/Admin/WXRespImgTxt/SaveRespTxt',
            method: 'POST',
            params: {
                KwId: mid,
                Content: txt
            },
            success: function (response) {
                myMask.hide();
                var rst = Ext.JSON.decode(response.responseText);
                Ext.Tools.Msg(rst.msg, rst.result);
            },
            failure: function (response) {
                myMask.hide();
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
    },
    //图文响应操作
    //编辑
    editRespRecord: function (view, record, item, index) {
        var win = this.getRespWin();
        var form = win.down("form");
        form.loadRecord(record);
        win.show();
        this.getRespContent().setValue(record.data.Content);
    },
    //保存
    saveRespRecord: function () {
        //获取选择的菜单
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要响应的菜单！", 1);
            return;
        }
        var records = selModel.getSelection();
        var mid = records[0].data.Id;
        //处理保存
        var win = this.getRespWin();
        var form = win.down("form");
        var model = form.getValues();
        model.Content = this.getRespContent().getValue();
        model.KwId = mid;
        if (form.isValid()) {
            record = form.getRecord();
            var store = this.getRespMainGrid().getStore();
            if (record) {//如果是修改
                record.set(model);
            }
            else {
                //record = Ext.create('WMC.model.WXRespImgTxt', model);
                //store.add(record);
                //如果没有datefield，可以直接设置为
                model["Id"] = Ext.data.IdGenerator.get('uuid').generate();
                store.add(model);
            }
            //Date类型的需要重新赋值才起作用，很奇怪
            //record.data.Birthday = model.Birthday;
            win.close();
            store.sync();
        }
    },
    //删除
    deleteRespRecord: function () {
        var grid = this.getRespMainGrid();
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
