using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace SMTSendMessage
{
    public partial class TestMsg : Form
    {
        public TestMsg()
        {
            InitializeComponent();
        }

        private void TestMsg_Load(object sender, EventArgs e)
        {
            DataTable dtSouce = DBconn.getData("[dbo].[CFG_Account]", " AStatus = 1");

            comboBox1.DataSource = dtSouce;
            comboBox1.ValueMember = "AID";
            comboBox1.DisplayMember = "CompName";

            textBox1.Focus();
        }

        #region Button_Click

        #region CloseWinForm
        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        #endregion

        #region SendMsg
        private void button1_Click(object sender, EventArgs e)
        {
            string SendMobile = textBox1.Text.Trim();
            string SendContent = textBox2.Text.Trim();

            if (SendMobile == "" || SendContent == "")
            {
                MessageBox.Show("请填写手机号或测试内容", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            };



            string AID = comboBox1.SelectedValue.ToString();

            DataTable dt = DBconn.getDataView("SELECT [AccountNo],[PassWord]FROM [dbo].[CFG_Account] WITH(NOLOCK) WHERE [AID] = " + AID);
            string CorpID = dt.Rows[0][0].ToString();
            string Pwd = dt.Rows[0][1].ToString();
            string SendTime = DateTime.Now.ToString("yyyyMMddHHmmss");

            try
            {
                Dxt.LinkWS LinkWs = new Dxt.LinkWS();


                int ReS = LinkWs.Send(CorpID.Trim(), Pwd.Trim(), SendMobile.Trim(), SendContent.Trim(), "", SendTime.Trim());
                if (ReS == 0)
                {
                    MessageBox.Show("发送成功！");
                    this.Close();
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
                else if (ReS == -4)
                {
                    MessageBox.Show("手机号码不正确！");
                }
                else if (ReS == -5)
                {
                    MessageBox.Show("余额不足！");
                }
                else if (ReS == -6)
                {
                    MessageBox.Show("定时发送时间不是有效时间！");
                }
            }
            catch (System.Net.WebException WebExcp)
            {
                MessageBox.Show("网络错误，无法连接到服务器！");
            }


            return;
        }
        #endregion

        #endregion


        #region ChangeEvent

        private void textBox1_TextChanged_1(object sender, EventArgs e)
        {
            textBox1.BackColor = Color.White;

            if (textBox1.Text.Trim() == "")
            {
                textBox1.BackColor = Color.SeaShell;
            }
        }


        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            textBox2.BackColor = Color.White;

            if (textBox2.Text.Trim() == "")
            {
                textBox2.BackColor = Color.SeaShell;
            }
        }

        #endregion

        #region CheckEvent
        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            try
            {
                int kc = (int)e.KeyChar;
                if ((kc < 48 || kc > 57) && kc != 8)
                    e.Handled = true;
            }
            catch (Exception)
            {
            }
        }
        #endregion




        



    }
}
