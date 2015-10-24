using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPReper.Model;
using DAO;

namespace EPReper.Web.EPSafe
{
    public partial class SafeRewAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Page_Preload(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InfoBind();

            }

        }





        private void InfoBind()
        {
            CommonDao<SafeRewards> newmgr = new CommonDao<SafeRewards>();
            string condition = " ";

            if (TextBoxSearch.Text.Trim().Length > 0)
            {
                condition = condition + " Area like '%" + this.TextBoxSearch.Text.Trim().ToString() + "%'";
            }

            Pager.RecordCount = int.Parse(newmgr.GetTotalCount(condition));
            RepeaterPubGG.DataSource = newmgr.FindAllByPageDesc(((Pager.CurrentPageIndex - 1) * Pager.PageSize).ToString(), Pager.PageSize.ToString(), condition);
            RepeaterPubGG.DataBind();
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            InfoBind();
        }

        protected void ImgBtnSearch_Click(object sender, ImageClickEventArgs e)
        {
            InfoBind();
        }


        //删除
        protected void btnDelete_Clik(object sender, CommandEventArgs e)
        {

            string fid = e.CommandName;
            CommonDao<SafeRewards> newmgr = new CommonDao<SafeRewards>();
            CommonDao<SafeDeptMoney> moneymgr=new CommonDao<SafeDeptMoney>();

            SafeRewards sf = newmgr.FindById(fid);

            CommonDao<SafeRewards> rewardmgr = new CommonDao<SafeRewards>();
            SafeDeptMoney sm = moneymgr.FindByConditions(" deptname='" + sf.dept + "' and deptyear=datepart(yy,'"+sf.createtime.ToString()+"') ");
            sm.currentmoney = sm.currentmoney - sf.rewards;
            if (sm != null && sf != null)
            {

                if (moneymgr.Update(sm))
                {
                    if (newmgr.Del(sf))
                    {
                        MsgShow("恭喜您，删除记录成功!");
                        InfoBind();
                    }
                }
                else
                {
                    MsgShow("Sorry，删除记录失败!");

                }
            }
            else {
                MsgShow("Sorry，未找到对应部门金额，删除记录失败!");
            }
        }


        protected void btnUpdate_Clik(object sender, CommandEventArgs e)
        {


        }


        private void MsgShow(string infos)
        {
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, this.GetType(), "", "alert('" + infos + "');", true);

        }
    }
}