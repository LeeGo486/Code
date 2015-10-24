using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace SMTSendMessage
{
    public partial class EditAccount : Form
    {
        DataTable dt = new DataTable();
        string aid ="";
        public EditAccount(string AID)
        {
            InitializeComponent();
            dt = getData(AID);
            aid = AID;
            this.textBox10.Text = dt.Rows[0]["CompName"].ToString();
            this.textBox2.Text = dt.Rows[0]["AccountNo"].ToString();
            this.textBox3.Text = dt.Rows[0]["PassWord"].ToString();
            this.textBox9.Text = dt.Rows[0]["QueryCNT"].ToString();
            //this.textBox8.Text = dt.Rows[0]["CompName"].ToString();
            this.textBox4.Text = dt.Rows[0]["Contacts"].ToString();
            this.textBox5.Text = dt.Rows[0]["Telephone"].ToString();
            this.textBox6.Text = dt.Rows[0]["MobilePhone"].ToString();
            this.textBox7.Text = dt.Rows[0]["EMail"].ToString();
            this.textBox1.Text = dt.Rows[0]["Remark"].ToString();
        }

        #region 加载数据
        private DataTable getData(string AID)
        {
            DataTable dt = new DataTable();

            string sql = @"SELECT * FROM [dbo].[CFG_Account] WHERE AID = '" + AID + "'";

            dt = DBconn.getDataView(sql);
            return dt;
        }
        #endregion
        
        #region ChangeEvent
        private void textBox3_TextChanged(object sender, EventArgs e)
        {
            textBox3.BackColor = Color.White;

            if (textBox3.Text.Trim() == "")
            {
                textBox3.BackColor = Color.SeaShell;
            }
        }

        private void textBox9_TextChanged(object sender, EventArgs e)
        {
            textBox9.BackColor = Color.White;

            if (textBox9.Text.Trim() == "")
            {
                textBox9.BackColor = Color.SeaShell;
            }
        }
        #endregion

        #region CheckEvent
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

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string Pwd = textBox3.Text.Trim();
            string querycnt = textBox9.Text.Trim();

            if (Pwd == "" || querycnt == "") {
                MessageBox.Show("请填写帐号或密码", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            };

            string Contacts = textBox4.Text.Trim();//联系人
            string Telephone = textBox5.Text.Trim();//联系电话
            string MobilePhone = textBox6.Text.Trim();//手机号码
            string Email = textBox7.Text.Trim();//Email
            string Remark = textBox1.Text.Trim();//备注

            string where = " PassWord = '" + Pwd + "',";
            where += " QueryCNT = " + querycnt + ",";
            where += " Contacts = '" + Contacts + "',";
            where += " Telephone = '" + Telephone + "',";
            where += " MobilePhone = '" + MobilePhone + "',";
            where += " Email = '" + Email + "',";
            where += " Remark = '" + Remark + "'";

            where += " WHERE AID = " + aid;

            try
            {
                bool bRst = DBconn.Update("[dbo].[CFG_Account]", where);

                if (bRst)
                {
                    MessageBox.Show("保存成功");
                    MainForm f1 = (MainForm)this.Owner;
                    f1.loadData();
                    this.Close();

                }
                else {
                    MessageBox.Show("保存失败");
                    return;
                }
            }
            catch (Exception)
            {
                
                throw;
            }
        }





    }
}
