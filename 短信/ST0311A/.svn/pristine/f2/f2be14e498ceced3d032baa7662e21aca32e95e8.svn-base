using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace LYMsgInterfaceApp
{
    public partial class Account : Form
    {
        //field
        DataTable dt = new DataTable();
        string strId;
        bool bItOrUp;

        public Account()
        {
            InitializeComponent();
            bindCombox();
            this.bItOrUp = false;
        }

        public Account(string _strId)
        {
            InitializeComponent();
            bindCombox();

            this.bItOrUp = true;
            this.strId = _strId;

            this.dt = loadData(_strId);

            this.Spid.Text 
                = dt.Rows[0]["Spid"].ToString();
            this.Com.Text 
                = dt.Rows[0]["Com"].ToString();
            this.ComName.Text 
                = dt.Rows[0]["ComName"].ToString();
            this.LoginName.Text 
                = dt.Rows[0]["LoginName"].ToString();
            this.Password.Text 
                = dt.Rows[0]["Password"].ToString();
            this.QueryCNT.Text 
                = dt.Rows[0]["QueryCNT"].ToString();

            this.Aattribute.SelectedValue 
                = dt.Rows[0]["Aattribute"].ToString();
            this.Aattribute.DropDownStyle = ComboBoxStyle.DropDownList;//readonly
            this.Aattribute.Enabled = false; 

        }

        //method
        #region 按钮事件

        //保存
        private void btnAccSubmit_Click
            (object sender, EventArgs e)
        {
              bool bRst         = false;
            string strSpid      = Spid.Text.Trim();
            string strCom       = Com.Text.Trim();
            string strComName   = ComName.Text.Trim();
            string strLoginName = LoginName.Text.Trim();
            string strPassword  = Password.Text.Trim();
            string strQueryCNT  = QueryCNT.Text.Trim();

            string strAattribute = (string)Aattribute.SelectedValue;



            if (strSpid.Length == 0
                || strCom.Length == 0
                || strComName.Length == 0
                ||strLoginName.Length == 0
                || strPassword.Length == 0
                || strQueryCNT.Length ==0)
            {
                Msg("请将注册信息填写完整", "警告信息", "warning");
                return;
            };

            

            List<string> field = new List<string>();
            List<string> value = new List<string>();

            field.Add("Spid");
            field.Add("Com");
            field.Add("LoginName");
            field.Add("Password");
            field.Add("ComName");
            field.Add("QueryCNT");
            field.Add("Aattribute");

            value.Add(strSpid);
            value.Add(strCom);
            value.Add(strLoginName);
            value.Add(strPassword);
            value.Add(strComName);
            value.Add(strQueryCNT);
            value.Add(strAattribute);



            LogicHandle lgH = new LogicHandle();
            string where = " [Id] = '" + this.strId
                + "' AND [Aattribute] = '" + strAattribute + "'";
                     
            //判断是否已有数据
            int iCount 
                = lgH.GetCount("[dbo].[CFG_Account]", where);


            if (this.bItOrUp)//update
            {

                if (iCount > 0)
                {
                    where += " AND Id = " + this.strId;
                    bRst =
                        lgH.UpdateMany("[dbo].[CFG_Account]", field, value, where);
                }
                else 
                {
                    Msg("该企业或此通道不存在。", "警告信息", "warning");
                    return;
                };
            }
            else //insert 
            {
                string queryWhere = " [Spid] = '" + strSpid + "' ";

                int iCheck = lgH.GetCount("[dbo].[CFG_Account]", queryWhere);

                if (iCheck == 0)
                {   
                    bRst = 
                        lgH.Insert("[dbo].[CFG_Account]", field, value);
                }
                else
                {
                    Msg("该企业号或此通道已存在", "警告信息", "warning");
                    return;
                };
            };



            if (bRst)
            {
                //将父窗体传过来

                Main main = (Main)this.Owner;
                main.dataGridView1.DataSource = null;
                main.dataGridView1.DataSource = main.loadData();

                main.dataGridView1.Columns["Id"].Visible = false;
                main.dataGridView1.Columns["Password"].Visible = false;
                main.dataGridView1.Columns["CreateTime"].Visible = false;

                Msg("保存成功。", "提示信息", "ok");
                this.Close();
            }
            else
            {
                Msg("保存失败，请联系信息管理部。", "错误信息", "error");
                this.Close();
            }
        }

        //关闭
        private void btnAccClose_Click
            (object sender, EventArgs e)
        {

            this.Close();
        }

        #endregion
        
        #region 键盘事件

        #region 文本框颜色

        //企业ID
        private void Spid_TextChanged
            (object sender, EventArgs e)
        {
            Spid.BackColor = Color.White;
            if (Spid.Text.Trim() == "")
            {
                Spid.BackColor = Color.MistyRose;
            }
        }

        //企业号
        private void Com_TextChanged
            (object sender, EventArgs e)
        {
            Com.BackColor = Color.White;

            if (Com.Text.Trim() == "")
            {
                Com.BackColor = Color.MistyRose;
            }
        }
        
        //公司名
        private void ComName_TextChanged
            (object sender, EventArgs e)
        {
            ComName.BackColor = Color.White;

            if (ComName.Text.Trim() == "")
            {
                ComName.BackColor = Color.MistyRose;
            }
        }

        //登陆名
        private void LoginName_TextChanged
            (object sender, EventArgs e)
        {
            LoginName.BackColor = Color.White;

            if (LoginName.Text.Trim() == "")
            {
                LoginName.BackColor = Color.MistyRose;
            }
        }

        //密码
        private void Password_TextChanged
            (object sender, EventArgs e) 
        {
            Password.BackColor = Color.White;
            if (Password.Text.Trim() == "")
            {
                Password.BackColor = Color.MistyRose;
            }
        }

        //流量
        private void QueryCNT_TextChanged
            (object sender, EventArgs e)
        {
            QueryCNT.BackColor = Color.White;

            if (QueryCNT.Text.Trim() == "")
            {
                QueryCNT.BackColor = Color.MistyRose;
            }
        }
        #endregion

        #region 只能数字
        private void QueryCNT_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(Char.IsNumber(e.KeyChar))
                && e.KeyChar != (char)8)
            {
                e.Handled = true;
            }
            else
            {
                e.Handled = false;
            }
        }
        #endregion

        

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

        #region 加载数据
        internal DataTable loadData(string _strId)
        {
            DataTable dt = new DataTable();

            LogicHandle lgH = new LogicHandle();

            string strSQL = @"SELECT [Id]
                              ,[Com]
                              ,[ComName]
                              ,[Spid]
                              ,[LoginName]
                              ,[Password] 
                              ,[QueryCNT]
                              ,[Aattribute]
                          FROM [dbo].[CFG_Account]
                          WHERE [Id] = '" + _strId+"'";

            dt = lgH.GetDataView(strSQL);
            return dt;
        }
        #endregion

        #region 绑定下拉框的值
        internal void bindCombox()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("Value");
            dt.Columns.Add("Name");


            DataRow dr = dt.NewRow();
            dr["Value"] = 0;
            dr["Name"] = "营销";
            dt.Rows.Add(dr);

            DataRow dr1 = dt.NewRow();
            dr1["Value"] = 1;
            dr1["Name"] = "行业";
            dt.Rows.Add(dr1);

            this.Aattribute.DataSource = dt;

            this.Aattribute.ValueMember = "Value";
            this.Aattribute.DisplayMember = "Name";

        }
        #endregion

    }
}
