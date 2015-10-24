using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAO;
using EPReper.Model;
using Maticsoft.Common;

namespace EPReper.Web.EPSafe
{
    public partial class SafeAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Page_Preload(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InfoBind();
                SetDefaultdata();
            }
           
        }

        private void SetDefaultdata()
        {


            if (Request.QueryString["Infotype"] != null && Request.QueryString["type"] != null)
            {
                SpanType.InnerText = Request.QueryString["Infotype"] + "--" + Request.QueryString["type"];

                this.newstype.InnerHtml = " <a href='NewsAdd.aspx?Infotype=" + Request.QueryString["Infotype"] + "&type=" + Request.QueryString["type"] + "' title='' style='font-size:larger' ><strong> 添加" + Request.QueryString["type"] + "</strong></a>";
            }
        }



        private void InfoBind()
        {
            string Infotype = Request.QueryString["Infotype"];
            string type = Request.QueryString["type"];
            if (Infotype == null && type == null)
            {
                Infotype = "安全新闻";
            }

            string condition = "";
            CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
            if (Infotype == "安全新闻")
            {
                condition = " NewsInfoType = '" + Infotype + "' ";
            }
            else
            {
                condition = " NewsInfoType = '" + Infotype + "' and NewsType='" + type + "' ";
            }


            if (TextBoxSearch.Text.Trim().Length > 0)
            {
                condition = condition + " and  newstitle like '%" + this.TextBoxSearch.Text.Trim().ToString() + "%'";
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
            CommonDao<SafeNews> newmgr = new CommonDao<SafeNews>();
            SafeNews sf = newmgr.FindById(fid);

            if (newmgr.Del(sf))
            {


                MsgShow("恭喜您，删除记录成功!");
                InfoBind();
            }
            else
            {
                MsgShow("Sorry，删除记录失败!");

            }
        }


        protected void btnUpdate_Clik(object sender, CommandEventArgs e)
        {


        }


        private void MsgShow(string infos)
        {
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, this.GetType(), "", "alert('" + infos + "');", true);

        }

    }}