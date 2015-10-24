using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.ServiceProcess;

using System.Diagnostics;
using System.Management;
using System.IO;

namespace SMTSendMessage
{

    public partial class MainForm : Form
    {
       
        public MainForm()
        {
            InitializeComponent();

            loadData();

            try
               {
                ServiceController serviceObject = this.GetServiceObject();

                string status = serviceObject.Status.ToString();

                if (status == "Running")
                {
                    label1.Text = "服务已启动！";
                    //Operate(true);
                }
                else
                {
                    label1.Text = "服务已停止！";
                }
            }
            catch (Exception ex)
            {

                string exMsg = ex.Message;

                if (exMsg == "在计算机“.”上没有找到服务 SMTSendMessage。") {
                    AutoRegCom("");
                    label1.Text = "服务未运行！";
                    //Operate(false);
                }
                
                //throw;
            }  
            
        }

        #region Button_Click

        #region 注册公司
        private void button1_Click(object sender, EventArgs e)
        {
            Account account = new Account();
            account.Owner = this;
            account.ShowDialog();
        }
        #endregion

        #region 创建帐号

        private void button2_Click(object sender, EventArgs e)
        {
            Company cp = new Company();
            
            cp.ShowDialog();
        }

        
        #endregion

        #region 注册帐号
        private void button3_Click(object sender, EventArgs e)
        {

            if (dataGridView1.CurrentCell == null) {
                return;
            };

            int sltRow = dataGridView1.CurrentCell.RowIndex;

            string strStatus = dataGridView1.Rows[sltRow].Cells["注册状态"].Value.ToString();

            if (strStatus == "未注册") {
                //获取数据

                string AID = dataGridView1.Rows[sltRow].Cells["AID"].Value.ToString();  //主键

                string CorpID = dataGridView1.Rows[sltRow].Cells["企业号"].Value.ToString();
                string Pwd = dataGridView1.Rows[sltRow].Cells[3].Value.ToString();  //密码
                string CorpName = dataGridView1.Rows[sltRow].Cells["公司名称"].Value.ToString();
                string LinkMan = dataGridView1.Rows[sltRow].Cells["联系人"].Value.ToString();
                string Tel = dataGridView1.Rows[sltRow].Cells["联系电话"].Value.ToString();
                string Mobile = dataGridView1.Rows[sltRow].Cells["移动电话"].Value.ToString();
                string Email = dataGridView1.Rows[sltRow].Cells["邮箱"].Value.ToString();
                string Memo = dataGridView1.Rows[sltRow].Cells["备注"].Value.ToString();

                //调用webServer
                Dxt.LinkWS LinkWs = new Dxt.LinkWS();

                int ReS = LinkWs.Reg(CorpID.Trim(), Pwd.Trim(), CorpName.Trim(), LinkMan.Trim(), Tel.Trim(), Mobile.Trim(), Email.Trim(), Memo.Trim());

                try
                {
                    if (ReS == 0)
                    {

                        string strSQL = "AStatus = 1 WHERE AID = " + AID;
                        bool bRst = DBconn.Update("[dbo].[CFG_Account]", strSQL);

                        MessageBox.Show("注册成功");
                    }
                    else if (ReS == -1)
                    {
                        MessageBox.Show("帐号已经注册，请先注销！");
                    }
                    else if (ReS == -2)
                    {
                        MessageBox.Show("其他错误！");
                    }
                    else if (ReS == -3)
                    {
                        MessageBox.Show("帐号密码不匹配！");
                    }
                }
                catch (System.Net.WebException WebExcp)
                {
                    MessageBox.Show("网络错误，无法连接到服务器！");
                    throw;
                }
                finally
                {
                    loadData();
                }

            } else {
                MessageBox.Show("请检查注册状态","警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            };
        } 
        
        #endregion

        #region 注销帐号
        private void button4_Click(object sender, EventArgs e)
        {
            if (dataGridView1.CurrentCell == null)
            {
                return;
            };

            int sltRow = dataGridView1.CurrentCell.RowIndex;

            string strASts = dataGridView1.Rows[sltRow].Cells["注册状态"].Value.ToString();
            string strSSts = dataGridView1.Rows[sltRow].Cells["启用状态"].Value.ToString();


            if (strSSts == "未启用") {
                if (strASts == "已注册")
                {
                    //代码

                    string AID = dataGridView1.Rows[sltRow].Cells["AID"].Value.ToString();  //主键
                    string CorpID = dataGridView1.Rows[sltRow].Cells["企业号"].Value.ToString();
                    string Pwd = dataGridView1.Rows[sltRow].Cells[3].Value.ToString();

                    try
                    {
                        Dxt.LinkWS LinkWs = new Dxt.LinkWS();
                        int ReS = LinkWs.UnReg(CorpID.Trim(), Pwd.Trim());
                        if (ReS == 0)
                        {

                            string strSQL = "AStatus = 0 WHERE AID = " + AID;
                            bool bRst = DBconn.Update("[dbo].[CFG_Account]", strSQL);

                            MessageBox.Show("注销成功");
                        }
                        else if (ReS == -1)
                        {
                            MessageBox.Show("帐号未注册！");
                        }
                        else if (ReS == -2)
                        {
                            MessageBox.Show("其他错误！");
                        }
                        else if (ReS == -3)
                        {
                            MessageBox.Show("帐号密码不匹配！");
                        }
                    }
                    catch (System.Net.WebException WebExcp)
                    {
                        MessageBox.Show("网络错误，无法连接到服务器！");
                    }
                    finally
                    {
                        loadData();
                    }

                }
                else
                {
                    MessageBox.Show("请检查注册状态", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                };
            } else {
                MessageBox.Show("请先停用后再试", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;                    
            };
            
        }
        #endregion

        #region 查询余额
        private void button5_Click(object sender, EventArgs e)
        {
            if (dataGridView1.CurrentCell == null)
            {
                return;
            };

            int sltRow = dataGridView1.CurrentCell.RowIndex;

            string strStatus = dataGridView1.Rows[sltRow].Cells["注册状态"].Value.ToString();

            if (strStatus == "已注册") {

                string CorpID = dataGridView1.Rows[sltRow].Cells["企业号"].Value.ToString();
                string Pwd = dataGridView1.Rows[sltRow].Cells[3].Value.ToString();

                try
                {
                    Dxt.LinkWS LinkWs = new Dxt.LinkWS();
                    int ReS = LinkWs.SelSum(CorpID.Trim(), Pwd.Trim());
                    if (ReS >= 0)
                    {

                        MessageBox.Show("还剩" + ReS.ToString() + "条");
                    }
                    else if (ReS == -1)
                    {
                        MessageBox.Show("帐号未注册！");
                    }
                    else if (ReS == -2)
                    {
                        MessageBox.Show("其他错误！");
                    }
                    else if (ReS == -3)
                    {
                        MessageBox.Show("帐号密码不匹配！");
                    }
                }
                catch (System.Net.WebException WebExcp)
                {
                    MessageBox.Show("网络错误，无法连接到服务器！");
                }
                
            } else {
                MessageBox.Show("请检查注册状态", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;     
            }
        }
        #endregion

        #region 测试短信
        private void button6_Click(object sender, EventArgs e)
        {
            TestMsg textMsg = new TestMsg();
            
            textMsg.ShowDialog();
        }
        #endregion

        #region 启用
        private void button7_Click(object sender, EventArgs e)
        {
            if (dataGridView1.CurrentCell == null)
            {
                return;
            };

            int sltRow = dataGridView1.CurrentCell.RowIndex;

            string strASts = dataGridView1.Rows[sltRow].Cells["注册状态"].Value.ToString();
            string strSSts = dataGridView1.Rows[sltRow].Cells["启用状态"].Value.ToString();

            if (strASts == "已注册")
            {
                if (strSSts == "未启用")
                {
                    //获取数据

                    string AID = dataGridView1.Rows[sltRow].Cells["AID"].Value.ToString();  //主键


                    bool bRst = DBconn.Update("[dbo].[CFG_Account]", " [SendStatus] = 1 WHERE AID = " + AID);

                    if (bRst)
                    {
                        MessageBox.Show("启用成功", "提示信息", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        loadData();
                        return;
                    }
                    else
                    {
                        MessageBox.Show("启用失败", "错误信息", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                }
                else
                {
                    MessageBox.Show("请检查启用状态", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                };
            }
            else {
                    MessageBox.Show("请先注册后再启用", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
            }

        }
        #endregion

        #region 停用
        private void button8_Click(object sender, EventArgs e)
        {
            if (dataGridView1.CurrentCell == null)
            {
                return;
            };

            int sltRow = dataGridView1.CurrentCell.RowIndex;

            string strStatus = dataGridView1.Rows[sltRow].Cells["启用状态"].Value.ToString();

            if (strStatus == "已启用")
            {
                //获取数据

                string AID = dataGridView1.Rows[sltRow].Cells["AID"].Value.ToString();  //主键


                bool bRst = DBconn.Update("[dbo].[CFG_Account]", " [SendStatus] = 0 WHERE AID = " + AID);

                if (bRst)
                {
                    MessageBox.Show("停用成功", "提示信息", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    loadData();
                    return;
                }
                else
                {
                    MessageBox.Show("停用失败", "错误信息", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
            }
            else
            {
                MessageBox.Show("请检查启用状态", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            };
        }
        #endregion

        #region 开启服务
        private void button9_Click(object sender, EventArgs e)
        {
            ServiceController serviceObject = this.GetServiceObject();
            try
            {
                this.StarService(serviceObject);
                label1.Text = "服务已启动！";
                //Operate(true);
            }
            catch (Exception ex)
            {

                label1.Text ="启动服务失败:" + ex.Message;
            }
        }
        #endregion

        #region 关闭服务
        private void button10_Click(object sender, EventArgs e)
        {

            ServiceController serviceObject = this.GetServiceObject();
            
            try
            {
                
                this.StopService(serviceObject);
                label1.Text ="服务已停止！";
                
            }
            catch (Exception ex)
            {

                label1.Text ="停止服务发生错误:" + ex.Message.ToString();
            }
        }
        #endregion

        #endregion

        #region 加载数据
        public void loadData()
        {

            string sql = @"SELECT  T2.[Com] AS '公司编号'
                                  ,T1.[CompName] AS '公司名称'
                                  ,T1.[AccountNo] AS '企业号'
                                  ,T1.[PassWord]
                                  ,ISNULL(T1.[QueryCNT],0) AS '每次查询数'
                                  ,CASE T1.[AStatus] WHEN 0 THEN '未注册'
                                  WHEN 1 THEN '已注册' END AS '注册状态'
                                  ,CASE T1.[SendStatus] WHEN 0 THEN '未启用'
                                  WHEN 1 THEN '已启用' END AS '启用状态'
                                  ,T1.[Contacts] AS '联系人'
                                  ,T1.[Telephone] AS '联系电话'
                                  ,T1.[MobilePhone] AS '移动电话'
                                  ,T1.[EMail] AS '邮箱'
                                  ,T1.[Remark] AS '备注'
                                  ,T1.[CreateTime]
                                  ,T1.[AID]
                        FROM [dbo].[CFG_Account] T1
                        LEFT JOIN [dbo].[CFG_Company] T2 ON T1.CID = T2.ID";
            DataTable dt = DBconn.getDataView(sql);

            dataGridView1.DataSource = null;
            dataGridView1.DataSource = dt;
            dataGridView1.Columns[3].Visible = false;
            dataGridView1.Columns["AID"].Visible = false;
        }
        #endregion

        #region 双击修改
        private void dataGridView1_DoubleClick(object sender, EventArgs e)
        {
            int sltRow = dataGridView1.CurrentCell.RowIndex;

            string strStatus = dataGridView1.Rows[sltRow].Cells["注册状态"].Value.ToString();

            if (strStatus == "未注册")
            {
                string AID = dataGridView1.Rows[sltRow].Cells["AID"].Value.ToString();

                EditAccount ea = new EditAccount(AID);
                ea.Owner = this;
                ea.ShowDialog();
            }
            else if (strStatus == "已注册")
            {
                MessageBox.Show("请先注销，再尝试修改.", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            else
            {
                return;
            };
        }
        #endregion

        #region 服务的方法

        #region 获取服务
        private ServiceController GetServiceObject()
        {
            return new ServiceController("SMTSendMessage");
        }
        #endregion

        #region 重启服务
        private void ReStarService(ServiceController sc)
        {
            this.StopService(sc);
            this.StarService(sc);
        }
        #endregion

        #region 停止服务

        private void StopService(ServiceController sc)
        {
            if ((sc.Status == ServiceControllerStatus.Paused) || (sc.Status == ServiceControllerStatus.Running))
            {
                sc.Stop();
            }
        }
        #endregion

        #region 开启服务
        private void StarService(ServiceController sc)
        {
            if ((sc.Status == ServiceControllerStatus.Paused) || (sc.Status == ServiceControllerStatus.Stopped))
            {
                sc.Start();
            }
        }
        #endregion

        #endregion

        #region Bat程序执行
        static string AutoRegCom(string strCmd) {
            string rInfo;
            try
            {
                string strAppPath = Application.StartupPath;

                int iLast = strAppPath.LastIndexOf("SMTSendMessage");//找到父路径的位置
                string strScePath = strAppPath.Substring(0, iLast - 1);
                strScePath = strScePath + "\\SendMsgService1\\bin\\Debug\\Install.bat"; //服务安装路径
                Process myProcess = new Process();

                ProcessStartInfo myProcessStartInfo = new ProcessStartInfo(strScePath);
                
                myProcessStartInfo.UseShellExecute = false;
                myProcessStartInfo.CreateNoWindow = true;
                myProcessStartInfo.RedirectStandardOutput = true;
                myProcess.StartInfo = myProcessStartInfo;
                myProcessStartInfo.Arguments = "/c " + strCmd;
                myProcess.Start();
                StreamReader myStreamReader = myProcess.StandardOutput;
                rInfo = myStreamReader.ReadToEnd();
                myProcess.Close();
                rInfo = strCmd + "\r\n" + rInfo;
                return rInfo;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        
        }

        #endregion

        #region Bat程序处理
        //private void Operate(bool isOpen)
        //{
        //    string winFormPath 
        //        = Application.StartupPath;

        //    winFormPath += "\\AutostartService.bat";

        //    Process pro = new Process();

        //    FileInfo file = new FileInfo(winFormPath);

        //    pro.StartInfo.WorkingDirectory 
        //        = file.Directory.FullName;
        //    pro.StartInfo.FileName 
        //        = winFormPath;
        //    pro.StartInfo.CreateNoWindow = false;

        //    if (isOpen)
        //    {
        //        pro.Start();
        //    }
        //    else
        //    {


        //        Process[] proList = Process.GetProcessesByName("cmd");//获得本机的进程
        //        proList[0].Close();
        //        proList[0].Kill();
        //    }
            
        //    //pro.WaitForExit();
        //}
        
        #endregion

    }
}
