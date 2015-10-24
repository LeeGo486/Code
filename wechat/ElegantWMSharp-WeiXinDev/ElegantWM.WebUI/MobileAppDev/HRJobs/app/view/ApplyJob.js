Ext.define('HRJobs.view.ApplyJob', {
    extend: 'Ext.form.Panel',
    xtype: 'applyjob',
    config: {
        title: '职位申请',
        scrollable: true,
        items: [
            {
                xtype: 'fieldset',
                title: '请输入个人信息',
                instructions: '请确保上面的信息真实可靠',
                defaults: {
                    labelWidth: '110px'
                },
                margin:'20px',
                items: [
                    {
                        xtype: 'textfield',
                        name: 'SkrName',
                        label: '姓名',
                        maxLength: 20,
                        required:true
                    },
                    {
                        xtype: 'selectfield',
                        label: '性别',
                        name:'SkrSex',
                        options: [
                            { text: '男', value: '男' },
                            { text: '女', value: '女' }
                        ],
                        listeners: {
                            tap: {
                                fn: function () {
                                    if (Ext.isDefined(this.listPanel)) {
                                        this.listPanel.setHeight("6em");
                                        this.listPanel.setWidth("8em");
                                    }
                                },
                                element: 'element'
                            }
                        }
                    },
                    {
                        xtype: 'numberfield',
                        name: 'Telphone',
                        label: '手机号码',
                        required:true
                    },
                    {
                        xtype: 'textareafield',
                        name: 'Remark',
                        maxLength:200,
                        label: '申请理由'
                    }
                    ,
                    {
                        xtype: 'textfield',
                        name: 'EmployeeId',
                        placeHolder: '内部员工姓名',
                        label: '推荐人'
                    }
                ]
            }, {
                xtype: 'button',
                ui: 'action',
                margin: '10 20 10 20',
                action:'btnSubmit',
                text: '提交申请'
            }
        ]
    }
});
