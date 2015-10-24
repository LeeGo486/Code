using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace SMTSendMessage
{
    public partial class Account : Form
    {
        public Account()
        {
            InitializeComponent();

            DataTable dtSouce = DBconn.getData("[dbo].[CFG_Company]", "");

            compBox.DataSource = dtSouce;
            compBox.ValueMember = "ID";
            compBox.DisplayMember = "ComName";

        }

        private void Form2_Load(object sender, EventArgs e)
        {

        }


        #region Button
        private void button1_Click(object sender, EventArgs e)
        {
            string comp = compBox.SelectedValue.ToString();
            string account = textBox2.Text.Trim();//企业号
            string password = textBox3.Text.Trim();//密码
            string name = textBox8.Text.Trim();//企业名称
            string querycnt = textBox9.Text.Trim();//每次查询数

            if (account == "" || password == "")
            {
                MessageBox.Show("请填写帐号或密码", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            };

            if (querycnt == "")
            {
                MessageBox.Show("每次查询数不能为空", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                textBox9.Focus();
                return;
            }

            string contact = textBox4.Text.Trim();//联系人
            string telephone = textBox5.Text.Trim();//联系电话
            string mobilephone = textBox6.Text.Trim();//移动电话
            string email = textBox7.Text.Trim();//邮箱
            string remake = textBox1.Text.Trim();//备注

            string where = "[AccountNo] = '" + account + "'";
            int iChk = DBconn.getCount("[dbo].[CFG_Account]", where);

            if (iChk == 0)
            {
                List<String> filed = new List<string>();
                List<String> value = new List<string>();

                filed.Add("CID");
                filed.Add("AccountNo");
                filed.Add("PassWord");
                filed.Add("QueryCNT");
                filed.Add("CompName");
                filed.Add("Contacts");
                filed.Add("Telephone");
                filed.Add("MobilePhone");
                filed.Add("EMail");
                filed.Add("Remark");

                value.Add(comp);
                value.Add(account);
                value.Add(password);
                value.Add(querycnt);
                value.Add(name);
                value.Add(contact);
                value.Add(telephone);
                value.Add(mobilephone);
                value.Add(email);
                value.Add(remake);

                bool bRst = DBconn.Insert("[dbo].[CFG_Account]", filed, value);

                if (bRst)
                {
                    MessageBox.Show("保存成功", "提示信息", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    //将父窗体传过来
                    MainForm f1 = (MainForm)this.Owner;
                    f1.loadData();

                    this.Close();

                    return;
                }
                else
                {
                    MessageBox.Show("保存失败", "错误信息", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                };
            }
            else
            {
                MessageBox.Show("该企业号已存在", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();

        }
        #endregion

        #region ChangeEvent
        //企业号
        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            textBox2.BackColor = Color.White;

            if (textBox2.Text.Trim() == "")
            {
                textBox2.BackColor = Color.SeaShell;
            }
        }
        //密码
        private void textBox3_TextChanged(object sender, EventArgs e)
        {
            textBox3.BackColor = Color.White;

            if (textBox3.Text.Trim() == "")
            {
                textBox3.BackColor = Color.SeaShell;
            }
        }
        //每次查询数
        private void textBox9_TextChanged(object sender, EventArgs e)
        {
            textBox9.BackColor = Color.White;

            if (textBox9.Text.Trim() == "")
            {
                textBox9.BackColor = Color.SeaShell;
            }
        }

        private void compBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            textBox8.Text = "";

            if (compBox.Text == "System.Data.DataRowView") {
                textBox8.Text = "浙江雅莹集团有限公司";
            } else {
                textBox8.Text = compBox.Text;
            };
            
        }
        #endregion

        #region CheckEvent

        //只能输入数字
        private void textBox9_KeyPress(object sender, KeyPressEventArgs e)
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
