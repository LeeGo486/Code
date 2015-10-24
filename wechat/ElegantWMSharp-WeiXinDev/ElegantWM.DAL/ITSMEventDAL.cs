using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;


/**
 * 作者：WebMisSharp
 * 时间：2014/6/30 22:37:06
 * 功能：数据访问层
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

 namespace ElegantWM.DAL
{
    public class ITSMEventDAL : EFRepository<ITSM_Event>, IITSMEventDAL
    {
		/* 如果是多数据库，请开启
        public ITSMEventDAL()
            : base("Your web.config DbConnectString")
        {

        }
		*/
        /// <summary>
        /// 返回ITSM报表
        /// </summary>
        /// <param name="type">类型1</param>
        /// <returns></returns>
        public DataTable Report(int type)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultDB"].ToString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "ITSM_P_EventReport";
                cmd.CommandType = CommandType.StoredProcedure;//存储过程
                cmd.Connection = connection;//数据库连接
                cmd.Parameters.Add("@type", SqlDbType.Int);
                cmd.Parameters["@type"].Value =type;
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                connection.Open();
                adapter.Fill(ds);
                connection.Close();
                return ds.Tables[0];
            }
        }
        /// <summary>
        /// 消息通知
        /// </summary>
        /// <param name="type">0 请派工，1 已派工，4 已完成，5 已评价</param>
        /// <param name="evt">事件</param>
        public void Notice(int type,ITSM_Event evt)
        {
            try
            {
                string content = "";
                switch (type)
                {
                    //提交中，请派工
                    case 0:
                        //获取事件经理
                        DataTable dt = Query("select EventTitle from dbo.ITSM_EgrSchedule WHERE categoryId=1 AND StartDate='" + DateTime.Now.ToString("yyyy-MM-dd") + "'", null);
                        if (dt != null && dt.Rows.Count == 1)
                        {
                            foreach (string str in dt.Rows[0][0].ToString().Split(','))
                            {
                                content = "<b>“"+str+"”</b>您好：<br /><br /><b>" + evt.ReqMan + "</b>，刚刚提交了事件请求服务单，请及时派工处理。"
                                       + "<br /><br />单号：" + evt.Code + "<br />内容：" + evt.EventDesc + "<br />"
                                       + (string.IsNullOrEmpty(evt.FileUrl) ? "" : "附件：<a href='http://it.hwafashion.com/Content/Uploads/Event/" + evt.FileUrl + "' target='_blank' >点击查看</a>")
                                       + "<br />公司部门：" + evt.ReqCom + "," + evt.ReqDept
                                       + "<br />办公地点：" + evt.ReqIncident
                                       + "<br />提交时间：" + evt.CreateTime.ToString();
                                SendAm(str, content);
                            }
                        }
                        else
                        {
                            log.Debug("不存在当天的事件经理");
                            return;
                        }
                        break;
                    //派工完成，通知用户，通知工程师
                    case 1:
                        content="尊敬的<b>“"+evt.ReqMan+"”</b>您好：<br /><br />您刚刚提交的事件申请，由IT工程师<b>“"+evt.Engineer+"”</b>为您服务。您可在<b>“华之毅IT交付中心”</b>微信号中查看处理进度。"
                                + "<br /><br />单号：" + evt.Code + "<br />内容：" + evt.EventDesc + "<br />"
                                + (string.IsNullOrEmpty(evt.FileUrl) ? "" : "附件：<a href='http://it.hwafashion.com/Content/Uploads/Event/" + evt.FileUrl + "' target='_blank' >点击查看</a>")
                                + "<br />公司部门：" + evt.ReqCom + "," + evt.ReqDept
                                + "<br />办公地点：" + evt.ReqIncident
                                + "<br />提交时间：" + evt.CreateTime.ToString();
                        SendAm(evt.ReqMan, content);
                        //content = "<b>“" + evt.Engineer + "”</b>您好：<br /><br />事件经理给您分配了新的任务，请及时在“华之毅IT交付中心”服务号中处理。"
                        //        + "<br /><br />单号：" + evt.Code + "<br />内容：" + evt.EventDesc + "<br />"
                        //        + (string.IsNullOrEmpty(evt.FileUrl) ? "" : "附件：<a href='http://it.hwafashion.com/Content/Uploads/Event/" + evt.FileUrl + "' target='_blank' >点击查看</a>")
                        //        + "<br />申请人员：" + evt.ReqMan 
                        //        + "<br />公司部门：" + evt.ReqCom + "," + evt.ReqDept
                        //        + "<br />办公地点：" + evt.ReqIncident
                        //        + "<br />提交时间：" + evt.CreateTime.ToString();
                        //SendAm(evt.Engineer, content);
                        ////发送短信
                        //content = evt.Engineer + "您好,收到新的ITSM任务，请及时处理。\r\n"
                        //        + "单号:" + evt.Code + "\r\n内容:" + evt.EventDesc + ""
                        //        + "\r\n申请人:" + evt.ReqMan
                        //        + "\r\n部门:" + evt.ReqCom + "," + evt.ReqDept
                        //        + "\r\n地点:" + evt.ReqIncident;
                        //SendSms(evt.EngineerPhone, content);
                        break;
                    //派工完成，通知用户，通知工程师
                    case 6:
                        content = "尊敬的<b>“" + evt.ReqMan + "”</b>您好：<br /><br />您提交的事件申请，由于其他原因，我们内部进行了工程师转派，现由IT工程师<b>“" + evt.Engineer + "”</b>为您服务。您可在<b>“华之毅IT交付中心”</b>微信号中查看处理进度。"
                                + "<br /><br />单号：" + evt.Code + "<br />内容：" + evt.EventDesc + "<br />"
                                + (string.IsNullOrEmpty(evt.FileUrl) ? "" : "附件：<a href='http://it.hwafashion.com/Content/Uploads/Event/" + evt.FileUrl + "' target='_blank' >点击查看</a>")
                                + "<br />公司部门：" + evt.ReqCom + "," + evt.ReqDept
                                + "<br />办公地点：" + evt.ReqIncident
                                + "<br />提交时间：" + evt.CreateTime.ToString();
                        SendAm(evt.ReqMan, content);
                        //content = "<b>“" + evt.Engineer + "”</b>您好：<br /><br />收到一条新的转派任务，请及时在“华之毅IT交付中心”服务号中处理。"
                        //        + "<br /><br />单号：" + evt.Code + "<br />内容：" + evt.EventDesc + "<br />"
                        //        + (string.IsNullOrEmpty(evt.FileUrl) ? "" : "附件：<a href='http://it.hwafashion.com/Content/Uploads/Event/" + evt.FileUrl + "' target='_blank' >点击查看</a>")
                        //        + "<br />申请人员：" + evt.ReqMan
                        //        + "<br />公司部门：" + evt.ReqCom + "," + evt.ReqDept
                        //        + "<br />办公地点：" + evt.ReqIncident
                        //        + "<br />提交时间：" + evt.CreateTime.ToString();
                        //SendAm(evt.Engineer, content);
                        break;
                    //完成事件，通知用户
                    case 4:
                        content = "尊敬的<b>“" + evt.ReqMan + "”</b>您好：<br /><br />您提交的事件申请（" + evt.Code + "），IT工程师<b>“" + evt.Engineer + "”</b>，已经为您处理完成。请在<b>“华之毅IT交付中心”</b>微信号中对我们的服务进行评价，谢谢您的支持。"
                                + "<br /><br />单号：" + evt.Code + "<br />内容：" + evt.EventDesc + "<br />"
                                + (string.IsNullOrEmpty(evt.FileUrl) ? "" : "附件：<a href='http://it.hwafashion.com/Content/Uploads/Event/" + evt.FileUrl + "' target='_blank' >点击查看</a>")
                                + "<br /><br /><b>解决方案：</b>" + evt.EventSolution;
                        SendAm(evt.ReqMan, content);
                        break;
                    //完成评价，通知工程师
                    case 5:
                        content = "<b>“" + evt.Engineer + "”</b>您好：<br /><br />收到新的事件满意度评价（" + evt.Code + "）。"
                                + "<br /><br />单号：" + evt.Code + "<br />内容：" + evt.EventDesc + "<br />"
                                + (string.IsNullOrEmpty(evt.FileUrl) ? "" : "附件：<a href='http://it.hwafashion.com/Content/Uploads/Event/" + evt.FileUrl + "' target='_blank' >点击查看</a>")
                                + "<br />申请人员：" + evt.ReqMan
                                + "<br />公司部门：" + evt.ReqCom + "," + evt.ReqDept
                                + "<br />办公地点：" + evt.ReqIncident
                                + "<br />提交时间：" + evt.CreateTime.ToString()
                                + "<br /><br /><b>解决方案：</b>" + evt.EventSolution
                                + "<br /><br />响应时间：" + evt.ElvTime.ToString()
                                + "<br />服务态度：" + evt.ElvAtude.ToString()
                                + "<br />服务结果：" + evt.ElvRst.ToString()
                                + "<br />评价内容：" + evt.ElvDesc;
                        SendAm(evt.Engineer, content);
                        break;
                }
                //发送小翅膀
            }
            catch (Exception error)
            {
                log.Error("发送小翅膀异常了：" + error);
            }
        }

        private void SendAm(string rec,string content)
        {
            WSRR.WSRRSoapClient ws = new WSRR.WSRRSoapClient();
            WSRR.HZYmessage msg = new WSRR.HZYmessage();
            string rst = ws.CallByXML(ref msg, "<Interface WSID='36834cd9-c1fb-4fd7-b142-8feb069fb22f' App='EP_PLM' SessionID=''><Type>AM</Type><System>C3Matrix</System><Subject>ITSM事件</Subject><Receiver>"+rec+"</Receiver><Sender>信息部服务中心</Sender><Content>"+content+"</Content><SendTime>" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "</SendTime><Com>1</Com></Interface>");
        }

        private void SendSms(string rec, string content)
        {
            WSRR.WSRRSoapClient ws = new WSRR.WSRRSoapClient();
            WSRR.HZYmessage msg = new WSRR.HZYmessage();
            string rst = ws.CallByXML(ref msg, "<Interface WSID='2bae1ee5-d9d8-4840-beda-f29959941586' App='EP_PLM' SessionID=''><Type>SMS</Type><System>wifi</System><Subject>ITSM事件派工</Subject><Receiver>" + rec + "</Receiver><Sender></Sender><Content>" + content + "</Content><SendTime>" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "</SendTime><Com>1</Com></Interface>");
        }

    }
}
