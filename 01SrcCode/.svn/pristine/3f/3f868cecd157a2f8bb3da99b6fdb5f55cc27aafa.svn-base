using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using HZY.COM.DBAccess;
public partial class VipTicketResend : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request["action"] != null)
        {
            switch (Request["action"])
            {
                case "resend":
                    Resend();
                    break;

            }

            Response.End();
        }

        if (IsPostBack)
        {
            Getdata();
        }
    }
    private void Resend()
    {
        string strName = Request["Name"];
        string strOldPhone = Request["oldphone"];
        string strNewPhone = Request["newphone"];
        string strcrdate = Request["crdate"].ToString();
        string strsums = Request["sums"].ToString();
        string strticketid = Request["ticketid"].ToString();
        string strverifycode = Request["verifycode"].ToString();
        string strVipID = Request["vipid"].ToString();
        string strUid = Request["uid"].ToString();

        if (string.IsNullOrEmpty(strOldPhone)
            || string.IsNullOrEmpty(strcrdate)
            || string.IsNullOrEmpty(strsums)
            || string.IsNullOrEmpty(strticketid)
            || string.IsNullOrEmpty(strVipID)
            || string.IsNullOrEmpty(strUid)
        )
        {
            Response.Write("{'Message':'非法提交'}");
            return;
        }
        else
        {
            if (strNewPhone == null)
            {
                strNewPhone = "";
            }

            string strPhone = strNewPhone;
            if (strPhone == "")
            {
                strPhone = strOldPhone;
            }

            string strMessage = "尊敬的"+strName;
            strMessage += "贵宾,您已通过EP雅莹店铺" + strcrdate.ToString() + "成功以";
            strMessage += Convert.ToDecimal(strsums) * 25;
            strMessage += "分兑换面额为" + strsums + "的券，券号" + strticketid;
            strMessage += "，使用即使验证码：" + strverifycode;
           strMessage += "。生活之美，EP雅莹愿与您一同缔造。";

            AMSendWS.MsgCenter cls = new AMSendWS.MsgCenter();
            string strResult = cls.SendSubjectMsgImmediately("SMS", "ep_actualtime", "积分兑换券验证码", strPhone, "信息部服务中心", strMessage, DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");

            if (strResult == "0")
            {
                Response.Write("{'Message':'发送成功'}");
            }
            else
            {
                Response.Write("{'Message':'发送失败，原因：" + strResult.Remove('\n') + "'}");

            }

            //写日志 
            DataTable dt = new DataTable();
            dt.Columns.Add("Account_Id");
            dt.Columns.Add("Phone_Old");
            dt.Columns.Add("Phone_New");
            dt.Columns.Add("Ticket_Id");
            dt.Columns.Add("Create_UserId");
            dt.Columns.Add("Create_Time");

            DataRow dr = dt.NewRow();
            dr["Account_Id"] = strVipID;
            dr["Phone_Old"] = strOldPhone;
            dr["Phone_New"] = strNewPhone;
            dr["Ticket_Id"] = strticketid;
            dr["Create_UserId"] = strUid;
            dr["Create_Time"] = DateTime.Now;
            dt.Rows.Add(dr);

            string strConnstr = ConfigurationManager.AppSettings["ConnectionString_CRMCUS"];
            Dbconn conn = new Dbconn(strConnstr, true);
            conn.BeginTransaction();
            conn.Insert("Log_PhoneChange", dt);
            conn.CommitTransaction();
            return;
        }




    }
    private void Getdata()
    {
        string strConnstr = ConfigurationManager.AppSettings["ConnectionString_POS"];
        Dbconn conn = new Dbconn(strConnstr,true);

        string strPhone = this.txtPhone.Text;

        if (strPhone.Trim() != "")
        {
            string strName = conn.GetDataTableFirstValue(@"SELECT vipname as 姓名, mobtel as 手机号, vipcode as 卡号 FROM vip_user WHERE mobtel=@Param0 OR vipcode=@Param0", new string[] { strPhone }).ToString();
            this.lblName.Text = strName;

            DataSet ds = conn.GetDataSet(@"SELECT  b.ticketid AS 券号 ,
                                                a.sums AS 面值 ,
                                                CASE ISNULL(b.getsure,0)WHEN 0 THEN '否' ELSE '是' END  AS 是否使用 ,
                                                b.crdate AS 创建日期 ,
                                                b.verifycode AS 验证码,a.mobtel, a.vipcode, a.vipid

                                        FROM    vip_user a
                                                INNER JOIN vip_ticket b ON a.vipid = b.vipid
                                        WHERE   b.tictypeid = '31'
                                        AND (a.mobtel=@param0 OR a.vipcode=@param0)
                                        ORDER BY b.crdate DESC
                                        ", new string[] { strPhone });
            RpList.DataSource = ds.Tables[0];
            RpList.DataBind();

            if (ds.Tables[0].Rows.Count == 0)
            {
                this.lblMessage.Text = "<font color='red'>没有查询到手机号/卡号为" + strPhone + "的相关信息，请重试</font>";

            }
            else
            {
                this.lblMessage.Text = "";

            }
        }
        else
        {
            this.lblMessage.Text = "";

            RpList.DataSource = new DataTable();
            RpList.DataBind();
        }
    }
}