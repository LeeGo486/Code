using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.ServiceProcess;

namespace LYMsgInterfaceApp
{
    public partial class Main : Form
    {
        public Main()
        {
            InitializeComponent();

            this.dataGridView1.DataSource
                = loadData();

            dataGridView1.Columns["Id"].Visible = false;
            dataGridView1.Columns["Password"].Visible = false;
            dataGridView1.Columns["CreateTime"].Visible = false;

            LogicHandle lgH = new LogicHandle();
            try
            {
                ServiceController serviceObject = lgH.GetServiceObject();

                string status = serviceObject.Status.ToString();

                if (status == "Running")
                {
                    label1.Text = "服务已启动！";
                    //Operate(true);
                }
                else
                {
                    label1.Text = "服务已停止！";
                };
            }
            catch (Exception ex)
            {

                string exMsg = ex.Message;

                if (exMsg == "在计算机“.”上没有找到服务 LYSendMessage。")
                {
                    label1.Text = "服务未安装，请先安装服务！";

                };
            };
        }


        #region 按钮操作

        #region 注册帐号
        private void btnNewCom_Click(object sender, EventArgs e)
        {
            Account account = new Account();

            account.Owner = this;

            //新建时，将数据源解绑定。
            this.dataGridView1.DataSource = null;


            account.ShowDialog();
        }
        #endregion

        #region 启用
        private void btnAction_Click
            (object sender, EventArgs e)
        {
            setStatus("启用");
        }
        #endregion

        #region 停用
        private void btnStop_Click
            (object sender, EventArgs e)
        {
            setStatus("停用");
        }
        #endregion

        #region 启动服务
        private void SevUp_Click(object sender, EventArgs e)
        {
            LogicHandle lgH
                = new LogicHandle();
            ServiceController serviceObject
                = lgH.GetServiceObject();
            try
            {
                lgH.StarService(serviceObject);

                label1.Text = "服务已启动！";
            }
            catch (Exception ex)
            {

                label1.Text = "启动服务失败:" + ex.Message;
            };
        }
        #endregion

        #region 关闭服务
        private void SevDown_Click(object sender, EventArgs e)
        {
            LogicHandle lgH = new LogicHandle();
            ServiceController serviceObject
                = lgH.GetServiceObject();

            try
            {

                lgH.StopService(serviceObject);
                label1.Text = "服务已停止！";

            }
            catch (Exception ex)
            {

                label1.Text = "停止服务发生错误:" + ex.Message.ToString();
            };
        }
        #endregion

        #endregion

        #region 加载数据
        internal DataTable loadData()
        {
            DataTable dt = new DataTable();

            string strSQL = @"SELECT [Id]
                              ,[Spid]       AS '企业号'
                              ,[ComName]    AS '企业名'
                              ,CASE [Aattribute] WHEN 0 THEN '营销'
                               WHEN 1 THEN '行业' END AS '企业通道'
                              ,[LoginName]  AS '登陆名'
                              ,[Password]   
                              ,[QueryCNT]   AS '流量'
                              ,CASE WHEN [SendStatus] = 0 THEN '未启用'
                                    WHEN [SendStatus] = 1 THEN '已启用'
                               END AS '状态'
                              ,[CreateTime]
                          FROM [dbo].[CFG_Account]";

            LogicHandle LgH = new LogicHandle();

            dt = LgH.GetDataView(strSQL);

            return dt;

        }
        #endregion

        #region 事件函数
        private void dataGridView1_DoubleClick
            (object sender, EventArgs e)
        {
            int sltRow
                = dataGridView1.CurrentCell.RowIndex;

            string strStatus
                = dataGridView1.Rows[sltRow].
                Cells["状态"].Value.ToString();

            if (strStatus == "未启用")
            {
                string strId
                    = dataGridView1.Rows[sltRow].
                    Cells["Id"].Value.ToString();

                Account ac = new Account(strId);
                ac.Owner = this;
                ac.ShowDialog();
            }
            else if (strStatus == "已启用")
            {
                Msg("请先停用，再尝试修改.", "警告信息", "warning");
                return;
            }
        }
        #endregion

        #region 消息窗口
        internal void Msg
            (string _Msg, string _Tit, string _Lev)
        {

            if (_Lev == "ok")
            {
                MessageBox.Show(_Msg, _Tit,
                            MessageBoxButtons.OK,
                            MessageBoxIcon.Information);
            }
            else if (_Lev == "warning")
            {
                MessageBox.Show(_Msg, _Tit,
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Warning);
            }
            else if (_Lev == "error")
            {
                MessageBox.Show(_Msg, _Tit,
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Error);
            }

        }
        #endregion

        #region 启停用状态
        internal void setStatus(string _type)
        {

            if (dataGridView1.CurrentCell == null)
            {
                return;
            };


            int sltRow
                = dataGridView1.CurrentCell.RowIndex;
            string strStatus
                = dataGridView1.Rows[sltRow].Cells["状态"].Value.ToString();
            string strId
                = dataGridView1.Rows[sltRow].Cells["Id"].Value.ToString();
            string strWhere = "";




            if ((_type == "启用" && strStatus == "已启用") ||
                (_type == "停用" && strStatus == "未启用"))
            {
                Msg("请检查数据行状态", "警告信息", "warning");
                return;
            };




            LogicHandle lcH = new LogicHandle();

            if (_type == "停用")
            {
                strWhere
                    = " SendStatus = 0 WHERE Id = '" + strId + "'";
            }
            else if (_type == "启用")
            {
                strWhere
                    = " SendStatus = 1 WHERE Id = '" + strId + "'";
            }


            bool bRst
                = lcH.Update("[dbo].[CFG_Account]", strWhere);

            if (bRst)
            {
                Msg("状态更新成功。", "提示信息", "ok");
                dataGridView1.DataSource = null;
                dataGridView1.DataSource = loadData();

                dataGridView1.Columns["Id"].Visible = false;
                dataGridView1.Columns["Password"].Visible = false;
                dataGridView1.Columns["CreateTime"].Visible = false;
            }
            else
            {
                Msg("状态更新失败，请联系信息管理部。", "提示信息", "error");
            }

        }
        #endregion

    }
}
