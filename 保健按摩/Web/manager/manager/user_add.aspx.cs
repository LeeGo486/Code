using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPReper.Web.manager.manager
{
    public partial class user_add : System.Web.UI.Page
    {
        EPReper.BLL.Manager Manager = new BLL.Manager();
        EPReper.Model.Manager manager = new Model.Manager();
        EPReper.BLL.Userinfo UI = new BLL.Userinfo();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Tools.CookieHelper.GetCookie("CN_ID") == "" || Tools.CookieHelper.GetCookie("CN_ID") == null)
            {
                Response.Redirect("../../login.aspx");
            }
            getusername();
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            string OperationID = this.username.SelectedValuesToString(",").ToString().Trim() + ",";
            string[] RespondentArr = OperationID.Split(',');  //选中的被申请人数组
            string isrepair = "";
            for (int j = 0; j < RespondentArr.Length - 1; j++)
            {
                manager.UserName = RespondentArr[j];
                if (admin.Checked)
                {
                    manager.isAdmin = 1;
                }
                else
                {
                    manager.isAdmin = 0;
                }
                manager.phonenum = phonenum.Value.Trim();
                string chkSelect = "";
                for (int i = 0; i < URole.Items.Count; i++)
                {
                    if (URole.Items[i].Selected == true)
                        chkSelect += URole.Items[i].Value + ",";
                }
                if (chkSelect != "")
                {
                    chkSelect = chkSelect.Remove(chkSelect.Length - 1);
                }
                manager.repair = chkSelect;
                if (Manager.has("username like '" + manager.UserName + "'") > 0)
                {
                    isrepair += manager.UserName + ",";
                }
                else
                {
                    Manager.Add(manager);
                    
                }
            }
            if (isrepair != "")
            {
                Session["usermsg"] = "<font color=\"Red\">" + isrepair.Substring(0,isrepair.Length-1) + " 已经是维修员工<font>";
            }
            Response.Redirect("user_list.aspx");
        }
        public void getusername()
        {
            //fenlei1.Items.Clear();
            //fenlei1.Items.Insert(0, new ListItem("<-- 请选择 -->", "0"));
            string[] depts = EPReper.Config.UIConfig.Dept.Split(',');
            string dept="";
            if (depts.Length == 1)
            {
                dept += "TN_SYS_EM_USER_PROP.CN_DEPTINFO LIKE '%" + depts[0] + "%'";
            }
            else
            {
                for (int i = 0; i < depts.Length; i++)
                {
                    dept += " TN_SYS_EM_USER_PROP.CN_DEPTINFO LIKE '%" + depts[i] + "%' OR";
                }
                dept = dept.Remove(dept.Length - 2);
            }

            DataTable dt = UI.GetInfo(dept);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string login = dt.Rows[i]["CN_LOGIN"].ToString();
                username.Items.Add(new ListItem(login, login));
            }
        }
        protected void bx(object sender, EventArgs e)
        {
            Response.Redirect("../ReperInfo/ReperInfo.aspx");
        }

        protected void ml(object sender, EventArgs e)
        {
            Response.Redirect("../ReperClass/ReperClass_List.aspx");
        }

        protected void ry(object sender, EventArgs e)
        {
            Response.Redirect("user_list.aspx");
        }

        protected void work(object sender, EventArgs e)
        {
            Response.Redirect("../../index.aspx");
        }
    }
}