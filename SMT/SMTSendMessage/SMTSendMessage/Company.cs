using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Configuration;


namespace SMTSendMessage
{
    public partial class Company : Form
    {

        string strConn;
        
        public Company()
        {
            InitializeComponent();

        }

        #region ChangeEvent
        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            textBox1.BackColor = Color.White;

            if (textBox1.Text.Trim() == "")
            {
                textBox1.BackColor = Color.SeaShell;
            }
        }
        #endregion

        #region CloseButton
            private void button2_Click(object sender, EventArgs e)
            {
                this.Close();
            }
        #endregion

        #region CreateButton
            private void button1_Click(object sender, EventArgs e)
            {
                string strCom = textBox1.Text.Trim();
                string strComName = textBox2.Text.Trim();
                if (strCom == "")
                {
                    MessageBox.Show("公司编号必须填写", "警告信息", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    textBox1.Focus();
                };

                string strWhere = " 1=1 AND [Com] = '" + strCom + "'";

                int iChk = DBconn.getCount("[dbo].[CFG_Company]", strWhere);

                if (iChk == 0)
                {
                    List<String> list = new List<String>();

                    List<String> list1 = new List<String>();

                    list.Add("Com");
                    list.Add("ComName");

                    list1.Add(strCom);
                    list1.Add(strComName);
                    //插入数据
                    bool bRst = DBconn.Insert("[dbo].[CFG_Company]", list, list1);

                    if (bRst)
                    {
                        MessageBox.Show("保存成功", "提示信息", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        
                        this.Close();
                    }
                    else {
                        MessageBox.Show("保存失败", "错误信息", MessageBoxButtons.OK, MessageBoxIcon.Error);

                    };

                }
                else { 
                    //报错
                    MessageBox.Show("保存失败,已存在该公司。", "错误信息", MessageBoxButtons.OK, MessageBoxIcon.Error);
                };
                
            }
        #endregion

        private void Company_Load(object sender, EventArgs e)
        {
            strConn = ConfigurationManager.AppSettings["RDSMS"];
        }
       
    }
}
