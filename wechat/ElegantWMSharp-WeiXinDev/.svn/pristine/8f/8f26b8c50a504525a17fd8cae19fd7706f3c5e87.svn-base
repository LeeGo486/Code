//用户信息修改
/// <reference path="../../ext/ext-all-debug-w-comments.js" />
Ext.define("WMS.view.UserInfo", {
    extend: 'Ext.window.Window',
    alias: 'widget.userinfo',
    title: '个人信息',
    iconCls: 'User',
    modal: true,
    width: 600,
    border: false,
    items: [{
        xtype: 'form',
        labelAlign: 'right',
        bodyPadding: 10,
        height: 210,
        border: false,
        closeAction: 'hide',
        fieldDefaults: {
            labelAlign: 'right',
            labelWidth: 60,
            anchor: '100%'
        },
        items: [
            {
                layout: 'column',
                border: false,
                defaults: {
                    border: false,
                    layout: 'form'
                },
                items: [{
                    columnWidth: .3,
                    items: [{
                        xtype: 'textfield',
                        name: 'UserName',
                        fieldLabel: '登录名',
                        allowBlank: false
                    }]
                }, {
                    columnWidth: .4,
                    items: [{
                        xtype: 'textfield',
                        name: 'NickName',
                        fieldLabel: '昵称',
                        allowBlank: false
                    }]
                }, {
                    columnWidth: .3,
                    items: [{
                        xtype: 'combo',
                        name: 'Sex',
                        fieldLabel: '性别',
                        allowBlank: false,
                        forceSelection: true,
                        valueField: 'Sex',
                        displayField: 'Sex',
                        typeAhead: true,
                        queryMode: 'local',
                        store: Ext.create('Ext.data.ArrayStore', {
                            fields: ['Sex'],
                            data: [
                                ['男'],
                                ['女']
                            ]
                        })
                    }]
                }]
            },
            {
                layout: 'column',
                border: false,
                defaults: {
                    border: false,
                    layout: 'form'
                },
                items: [{
                    columnWidth: .3,
                    items: [{
                        xtype: 'textfield',
                        name: 'Phone',
                        vtype: 'number',
                        fieldLabel: '联系电话'
                    }]
                }, {
                    columnWidth: .4,
                    items: [{
                        xtype: 'textfield',
                        name: 'Email',
                        vtype: 'email',
                        fieldLabel: '邮箱'
                    }]
                }, {
                    columnWidth: .3,
                    items: [{
                        xtype: 'textfield',
                        name: 'QQ',
                        vtype: 'number',
                        fieldLabel: 'QQ'
                    }]
                }]
            }, {
                layout: 'column',
                border: false,
                defaults: {
                    border: false,
                    layout: 'form'
                },
                items: [{
                    columnWidth: .7,
                    items: [{
                        xtype: 'textfield',
                        name: 'Address',
                        fieldLabel: '通信地址'
                    }]
                }, {
                    columnWidth: .3,
                    items: [{
                        xtype: 'textfield',
                        name: 'Remark',
                        fieldLabel: '备注'
                    }]
                }]
            }, {
                xtype: 'fieldset',
                margin:'20 0 10 0',
                columnWidth: 1,
                collapsed:true,
                title: '修改密码',
                collapsible: false
            }, {
                layout: 'column',
                border: false,
                defaults: {
                    border: false,
                    layout: 'form'
                },
                items: [{
                    columnWidth: .4,
                    items: [{
                        xtype: 'textfield',
                        name: 'UserPwd',
                        inputType: 'password',
                        fieldLabel: '旧密码'
                    }]
                }, {
                    columnWidth: .3,
                    items: [{
                        xtype: 'textfield',
                        id:'userInfo_NewPwd',
                        name: 'NewPwd',
                        fieldLabel: '新密码',
                        minLength: 6,
                        minLengthText: "长度不能小于6个字符",
                        maxLength: 12,
                        maxLengthText:"长度不能大于12个字符",
                        inputType: 'password'
                    }]
                }, {
                    columnWidth: .3,
                    items: [{
                        xtype: 'textfield',
                        name: 'SurePwd',
                        fieldLabel: '确认密码',
                        inputType: 'password',
                        vtype: 'passwordConfirm',
                        confirmTo: 'userInfo_NewPwd'
                    }]
                }]
            }],
        dockedItems: [
            {
                xtype: 'toolbar',
                dock: 'bottom',
                items: ['->', {
                    text: '取消',
                    handler: function () {
                        this.up('window').close();
                    }
                },
                {
                    text: '保存',
                    iconCls: 'Disk',
                    action: 'saveUserInfo'
                }]
            }
        ]
    }]
});