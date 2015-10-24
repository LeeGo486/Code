Ext.define('HRJobs.controller.Jobs', {
    extend: 'Ext.app.Controller',
    config: {
        refs: {
            jobList: 'joblist',
            jobDetail: {
                selector: 'jobdetail',
                xtype: 'jobdetail',
                autoCreate: true
            },
            applyForm: {
                selector: 'applyjob',
                xtype: 'applyjob',
                autoCreate:true
            },
            jobNav: 'jobs',
            jobDetailHeader: '#jobDetailHeader',
            jobDetailContent: '#jobDetailContent',
            applyBtn: 'jobdetail button[action=btnApply]'
        },
        routes: {
            'Home': 'ReturnHome',
            'showJobDetail/:id': 'showJobDetail',
            'applyJob/:id': 'applyJob'
        },
        control: {
            //选择条件窗体
            jobList: {
                itemtap: function (list, index, item, record, type) {
                    //跳转到职位详细页面
                    this.redirectTo("showJobDetail/" + record.data.Id);
                }
            },
            applyBtn: {
                tap: function () {
                    this.redirectTo("applyJob/" + window.location.hash.replace("#showJobDetail/", ""));
                }
            },
            'applyjob button[action=btnSubmit]': {
                tap: 'submitApply'
            },
            jobNav: {
                activeitemchange:function( nv, value, oldValue, eOpts ){
                    if (value.getItemId() == "jobList") {
                        document.title = "雅莹招聘";
                    }
                }
            }
        }
    },
    ReturnHome: function () {
        this.getJobNav().pop(2);
        //this.getJobNav().setActiveItem("joblist");/App/HR/Jobs/
    },
    showJobDetail: function (jobId) {
        //加载jobId
        this.getJobNav().pop("applyjob");
        detail = this.getJobDetail();
        this.getJobNav().push(detail);
        Ext.Viewport.setMasked({
            xtype: 'loadmask',
            message: '获取中...'
        });
        Ext.Ajax.request({
            url: '/Admin/HRJobs/GetJobById/'+jobId,
            method: 'GET',
            scope: this,
            callback: function (options, success, response) {
                Ext.Viewport.unmask();//关闭遮罩
                if (success) {
                    if (response.responseText == "") {
                        Ext.Msg.alert('提示', "职位ID错误！");
                        this.redirectTo("Home");
                        return;
                    }
                    obj = Ext.JSON.decode(response.responseText);
                    var record = Ext.create('HRJobs.model.Jobs', obj);
                    this.getJobDetailHeader().setRecord(record);
                    this.getJobDetailContent().setRecord(record);
                    document.title = record.data.JobName;
                } else {
                    Ext.Msg.alert('异常', '网络异常,操作失败！');
                }
            }
        });
    },
    applyJob: function (jobId) {
        apply = this.getApplyForm();
        this.getJobNav().push(apply);
        Ext.Viewport.setMasked({
            xtype: 'loadmask',
            message: '获取中...'
        });
        Ext.Ajax.request({
            url: '/Admin/HRJobs/GetJobById/' + jobId,
            method: 'GET',
            scope: this,
            callback: function (options, success, response) {
                Ext.Viewport.unmask();//关闭遮罩
                if (success) {
                    if (response.responseText == "") {
                        Ext.Msg.alert('提示', "职位ID错误！");
                        this.redirectTo("Home");
                        return;
                    }
                    obj = Ext.JSON.decode(response.responseText);
                    var record = Ext.create('HRJobs.model.Jobs', obj);
                    apply.down('fieldset').setTitle("应聘职位：" + record.data.JobName);
                } else {
                    Ext.Msg.alert('异常', '网络异常,操作失败！');
                }
            }
        });
    },
    //提交申请
    submitApply: function () {
        record = this.getApplyForm().getValues();
        //JobId
        record.JobId = window.location.hash.replace("#applyJob/", "");
        Ext.Viewport.setMasked({
            xtype: 'loadmask',
            message: '提交中...'
        });
        Ext.Ajax.request({
            url: '/Admin/HRJobSeeker/Post',
            method: 'POST',
            params: record,
            scope:this,
            callback: function (options, success, response) {
                Ext.Viewport.unmask();//关闭遮罩
                if (success) {
                    obj = Ext.JSON.decode(response.responseText);
                    if (obj.result == 0) {
						Ext.Msg.alert('提示', "已提交成功，我们会尽快和您联系！");
                        this.redirectTo("Home");
                        return;
                    }else
						Ext.Msg.alert('提示', obj.msg);
                } else {
                    Ext.Msg.alert('异常', '网络异常,操作失败！');
                }
            }
        });
    }
})