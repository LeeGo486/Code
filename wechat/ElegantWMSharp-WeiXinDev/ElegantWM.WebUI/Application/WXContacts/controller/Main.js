Ext.define('WMC.controller.Main', {
    extend: 'Ext.app.Controller',
    models: ['Account','WXContacts'],
    stores: ['Account','WXContacts'],
    views: ['MainGrid','EditWin'],
    //注意：如果该模块使用了KindEditor富文本框编辑器，详细使用规范请参考博客说明 http://www.cnblogs.com/qidian10/p/3619701.html
    refs: [{
        ref: 'mainGrid',
        selector: 'maingrid'
    }, {
        ref: 'editWin',
        selector: 'editwin',
        autoCreate: true,
        xtype: 'editwin'
    }],
    //声明监控事件
    init: function () {
        this.control({
            'maingrid': {
                //编辑
                edit: function (editor, e) {
                    this.getMainGrid().getStore().sync();//保存 
                },
                itemclick: this.rowEditorUpdateBtnDisable,
                itemdblclick: this.rowEditorUpdateBtnDisable
            },
            'maingrid button[action=btnSync]': {
                click: this.syncContact
            },
            'maingrid button[action=btnShowDetail]': {
                click: this.showContactDetail
            },
            'maingrid button[action=btnSendMsg]': {
                click:this.sendMsg
            },
            'maingrid combobox[name=cbAccount]': {
                select: this.loadWXContacts
            }
        });
    },
    onLaunch: function () {
        //根据权限控制界面按钮状态
        //Ext.Tools.CtrlButtonsByPermession("WXContacts", this.getMainGrid(), false);
    },
    //解决rowEditor插件的按钮bug
    rowEditorUpdateBtnDisable: function (me, record, item, index, e, eOpts) {
        if (this.getMainGrid().getPlugin("rowEditor").editor) {
            this.getMainGrid().getPlugin("rowEditor").editor.floatingButtons.child('#update').setDisabled(false);
        }
    },
    getAccountId: function () {
        var accountInfo = this.getMainGrid().down("combobox[name=cbAccount]");
        return accountInfo.getValue();
    },
    loadWXContacts: function () {
        var mainStore = this.getMainGrid().getStore();
        mainStore.getProxy().setExtraParam("accountId", this.getAccountId());
        mainStore.load();
    },
    //同步联系人
    syncContact: function () {
        var accountId = this.getAccountId();
        if (accountId == null) {
            Ext.Tools.Msg("请先选择微信账号！", 1);
            return;
        }

        var myMask = new Ext.LoadMask(this.getMainGrid(), { msg: "正在同步，操作比较耗时，请耐心等待..." });
        myMask.show();
        Ext.Ajax.request({
            url: '/Admin/WXContacts/DownloadContact',
            timeout: 600000,
            method: 'POST',
            params: { sid: accountId },
            scope: this,
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
    sendMsg: function () {
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择联系人！", 1);
            return;
        }
        var records = selModel.getSelection();
        var fids = [];
        Ext.each(records, function (value, index) {
            fids.push(value.get("fake_id"));
        });
        var accountId = this.getAccountId();

        Ext.MessageBox.show({
            title: '消息',
            width: 350,
            buttons: Ext.MessageBox.OKCANCEL,
            multiline: true,
            scope: this,
            fn: function (btn, text) {
                if (btn == "ok") {
                    var myMask = new Ext.LoadMask(this.getMainGrid(), { msg: "发送中，请稍等..." });
                    myMask.show();
                    Ext.Ajax.request({
                        url: '/Admin/WXContacts/SendMsg',
                        timeout: 600000,
                        method: 'POST',
                        params: { sid: accountId, fakeIds: fids,msg: text },
                        scope: this,
                        success: function (response) {
                            myMask.hide();
                            var rst = Ext.JSON.decode(response.responseText);
                            Ext.Tools.Msg(rst.msg,rst.result);
                        },
                        failure: function (response) {
                            myMask.hide();
                            Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
                        }
                    });
                }
            }
        });
    },
    showContactDetail: function () {
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要查看的联系人！", 1);
            return;
        }
        var records = selModel.getSelection();
        if (records.length != 1) {
            Ext.Tools.Msg("每次只能查看一个联系人！", 1);
            return;
        }
        var accountId = this.getAccountId();
        var fid = records[0].get("fake_id");

        var myMask = new Ext.LoadMask(this.getMainGrid(), { msg: "正获取中，请耐心等待..." });
        myMask.show();
        Ext.Ajax.request({
            url: '/Admin/WXContacts/ContactsDetail',
            timeout: 600000,
            method: 'POST',
            params: { sid: accountId, fakeId: fid },
            scope: this,
            success: function (response) {
                myMask.hide();
                var rst = Ext.JSON.decode(response.responseText);
                var win = this.getEditWin();
                var tmp = "<table align='center' width='100%'><tr><td rowspan=3 width='100px' style='padding:10px'><img src='/Admin/WXContacts/ContactHeadImg/?sid=" + accountId + "&fakeId=" + fid + "' style='width:100px;border-radius:4px;' /></td>"
                        + "<td style='padding:10px'>FakeId：" + rst.fake_id + "</td></tr>"
                        + "<tr><td style='padding:10px'>昵称：" + rst.nick_name + "</td></tr>"
                        + "<tr><td style='padding:10px'>备注：" + rst.remark_name + "</td></tr>"
                        + " <tr><td colspan=2 style='padding:10px'>签名：" + rst.signature + "</td></tr>"
                        + "<tr><td colspan=2 style='padding:10px'>省市：" + rst.country + "," + rst.province + "," + rst.city + "</td></tr></table>";
                win.down("form").html = (tmp);
                win.show();
            },
            failure: function (response) {
                myMask.hide();
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
        
    }
});
