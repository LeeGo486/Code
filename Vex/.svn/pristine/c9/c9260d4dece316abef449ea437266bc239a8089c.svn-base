using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：对VEX项目小组群发每日汇报的提醒
/// 类说明：
/// 创建人：马卫清
/// 创建日期：2014-04-10
/// 修改人：
/// 修改日期：
namespace HZY.COM.ITSM
{
    /// <summary>
    /// 根据XML内容更新服务器申请单
    /// </summary>
    public class SendAMMessageForVex : LogicBase, ILogicExecute
    {
        public SendAMMessageForVex()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容更新服务器申请单
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {

            DateTime timeNow = DateTime.Now;

            if (timeNow.DayOfWeek != DayOfWeek.Sunday)
            {
                //System.Threading.Thread.Sleep(30000);
                AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
                msg.SendSubjectMsg("AM", "ITSM", "各位好，请将今天的工作内容发给我。谢谢！", "马卫清", "马卫清", "各位好，请将今天的工作内容发给我。谢谢！", DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");

                msg.SendSubjectMsg("AM", "ITSM", "各位好，请将今天的工作内容发给我。谢谢！", "刘洪", "马卫清", "各位好，请将今天的工作内容发给我。谢谢！", DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
                msg.SendSubjectMsg("AM", "ITSM", "各位好，请将今天的工作内容发给我。谢谢！", "张凯军", "马卫清", "各位好，请将今天的工作内容发给我。谢谢！", DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
                msg.SendSubjectMsg("AM", "ITSM", "各位好，请将今天的工作内容发给我。谢谢！", "郭琦琦", "马卫清", "各位好，请将今天的工作内容发给我。谢谢！", DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
                msg.SendSubjectMsg("AM", "ITSM", "各位好，请将今天的工作内容发给我。谢谢！", "俞晓东", "马卫清", "各位好，请将今天的工作内容发给我。谢谢！", DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");

                Dbconn conn = new Dbconn("WS_Log");
                conn.Excute("INSERT INTO Log_MDMTEST (name1) values('" + System.Net.Dns.GetHostName() + "')");
            }
            return true;
        }





    }

}