using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Collections;
using System.Web;
using System.Data;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.ST1005A;
using HZY.COM.Common.Base;


namespace HZY.COM.WS.StoreBusinessSystem
{

    public class AM_Message_Send
    {
        public HZYmessage m_hzyMessage;
        static Dbconn conn_Log = new Dbconn("HZY_Mat");

        //        public static void SendMessage(string pstrDepot, string pstrBillID, string pstrState)
        //        {
        //            //上报
        //            //需要给MAT_MENU_总部维修处理并且拥有相关店铺权限的人员发送AM提醒
        //            //获取具备权限的人员
        //            if (pstrState == "上报")
        //            {
        //                MDM_System_User_GetByAuthorization cls = new MDM_System_User_GetByAuthorization();
        //                cls.Request = Common.Common.GetRequestDataSet(new string[2] { "Env_SN", "AUZ" }
        //                                                                , new string[2] { "HZY_SBS", "MAT_MENU_总部维修处理,MAT_COM_" + pstrDepot.Substring(0, 1) });
        //                DataSet dsUserList = cls.GetData();

        //                for (int i = 0; i < dsUserList.Tables[0].Rows.Count; i++)
        //                {
        //                    string strMessage = pstrDepot + "店铺已提报维修申请，单据号" + pstrBillID + @"，请及时登录系统进行相关操作。</p> 
        //                                            点击<a href=''>这里</a>进行操作。";
        //                                   点击<a href='http://localhost:8084/WEB/Base/LoginAndRedirect.html?EnvID=HZY_SBS&UserName=1700&PassWord=9cbf8a4dcb8e30682b927f352d6559a0&URL=../Mat/Mat_bill.html?vexmenuid=153&billid='>这里</a>进行操作。";

        //                    AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
        //                    string strResult = msg.SendSubjectMsg("AM", "ITSM", strTitle, strAMRevier, "信息部服务中心", strContent, DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
        //                }

        //            }
        //        }

        /// <summary>
        /// 店铺申请赔偿小翅膀提醒
        /// </summary>
        /// <param name="pstrDepotname">店铺名称</param>
        /// <param name="pstrUser_Name">操作者</param>
        /// <param name="pstrDepotid">店铺编号</param>
        /// <param name="pstrAreaName">大区名称</param>
        /// <param name="pstrInventoryID">盘点单号</param>
        /// <param name="pstrState">状态</param>
        public static void SendMessage_Submit_inventory(string pstrDepotname, string pstrUser_Name, string pstrDepotid, string pstrAreaName, string pstrInventoryID, string pstrState)
        {
            if (pstrState == "待分公司经理审批")
            {
                Inventory_Authority_List amsender = new Inventory_Authority_List();
                DataSet dsAUZ = amsender.GetData();
                string Store_prefix = pstrDepotid.Substring(0, 1);
                DataRow[] listAuz = dsAUZ.Tables[0].Select("Store_prefix=" + "'" + Store_prefix + "'" + " and AreaName=" + "'" + pstrAreaName + "'");

                for (int i = 0; i < listAuz.Count(); i++)
                {

                    string strReceive = listAuz[i]["Branch_AM"].ToString();

                    if (strReceive != "无")
                    {
                        string strMessage = pstrDepotname + "  店铺已经提交盘亏赔偿申请，单据号" + pstrInventoryID + @"，请及时登录系统进行相关操作。</p> 
                                点击<a href= http://192.168.0.125  target=_blank>这里</a>进行操作。";
                        AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
                        string strResult = msg.SendSubjectMsg("AM", "ITSM", "店铺盘点赔偿申请", strReceive, "信息部服务中心", strMessage, DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
                        DataTable dt = new HZY_SBS.AM_Sender_LogDataTable();
                        DataRow dr = dt.NewRow();
                        DateTime datetime = DateTime.Now;
                        string strGuid = System.Guid.NewGuid().ToString();
                        dr["ID"] = strGuid;
                        dr["Result"] = strResult;
                        dr["Receive"] = strReceive;
                        dr["AM"] = "AM";
                        dr["Sender"] = "信息部服务中心";
                        dr["ITSM"] = "ITSM";
                        dr["Type"] = "店铺盘点赔偿申请";
                        dr["Message"] = strMessage;
                        dr["Createtime"] = datetime;
                        dr["Com"] = "1";
                        dt.Rows.Add(dr);
                        conn_Log.BeginTransaction();
                        conn_Log.Insert("AM_Sender_Log", dt);
                        conn_Log.CommitTransaction();
                    }
                }
            }

            if (pstrState == "待销售总部审批")
            {
                Inventory_Authority_List amsender = new Inventory_Authority_List();
                DataSet dsAUZ = amsender.GetData();
                string Store_prefix = pstrDepotid.Substring(0, 1);
                DataRow[] listAuz = dsAUZ.Tables[0].Select("Store_prefix=" + "'" + Store_prefix + "'" + " and AreaName=" + "'" + pstrAreaName + "'");

                for (int i = 0; i < listAuz.Count(); i++)
                {
                    string strReceive = listAuz[i]["General_AM"].ToString();
                    if (strReceive != "无")
                    {
                        string strMessage = "单据号" + pstrInventoryID + @"，分公司经理已经审批，请及时登录店务系统进行相关操作。</p> 
                                点击<a href= http://192.168.0.125  target=_blank>这里</a>进行操作。";
                        AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
                        string strResult = msg.SendSubjectMsg("AM", "ITSM", "待销售总部审批", strReceive, "信息部服务中心", strMessage, DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
                        DataTable dt = new HZY_SBS.AM_Sender_LogDataTable();
                        DataRow dr = dt.NewRow();
                        DateTime datetime = DateTime.Now;
                        string strGuid = System.Guid.NewGuid().ToString();
                        dr["ID"] = strGuid;
                        dr["Result"] = strResult;
                        dr["Receive"] = strReceive;
                        dr["AM"] = "AM";
                        dr["Sender"] = "信息部服务中心";
                        dr["ITSM"] = "ITSM";
                        dr["Type"] = "待销售总部审批";
                        dr["Message"] = strMessage;
                        dr["Createtime"] = datetime;
                        dr["Com"] = "1";
                        dt.Rows.Add(dr);
                        conn_Log.BeginTransaction();
                        conn_Log.Insert("AM_Sender_Log", dt);
                        conn_Log.CommitTransaction();
                    }
                }
            }

            if (pstrState == "待店铺汇款")
            {
                //Inventory_Authority_List amsender = new Inventory_Authority_List();
                //DataSet dsAUZ = amsender.GetData();
                //string Store_prefix = pstrDepotid.Substring(0, 1);
                //DataRow[] listAuz = dsAUZ.Tables[0].Select("Store_prefix=" + "'" + Store_prefix + "'" + " and AreaName=" + "'" + pstrAreaName + "'");

                //for (int i = 0; i < listAuz.Count(); i++)
                //{
                //string strReceive = listAuz[i]["General_AM"].ToString();
                string strMessage = "单据号" + pstrInventoryID + @"，销售总部已经审批，请进行汇款，请及时登录店务系统进行相关操作。</p> 
                                点击<a href= http://192.168.0.125  target=_blank>这里</a>进行操作。";
                AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
                string strResult = msg.SendSubjectMsg("AM", "ITSM", "待店铺汇款", pstrDepotname, "信息部服务中心", strMessage, DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
                DataTable dt = new HZY_SBS.AM_Sender_LogDataTable();
                DataRow dr = dt.NewRow();
                DateTime datetime = DateTime.Now;
                string strGuid = System.Guid.NewGuid().ToString();
                dr["ID"] = strGuid;
                dr["Result"] = strResult;
                dr["Receive"] = pstrDepotname;
                dr["AM"] = "AM";
                dr["Sender"] = "信息部服务中心";
                dr["ITSM"] = "ITSM";
                dr["Type"] = "待店铺汇款";
                dr["Message"] = strMessage;
                dr["Createtime"] = datetime;
                dr["Com"] = "1";
                dt.Rows.Add(dr);
                conn_Log.BeginTransaction();
                conn_Log.Insert("AM_Sender_Log", dt);
                conn_Log.CommitTransaction();
                //}
            }
            if (pstrState == "待财务汇款确认")
            {
                Inventory_Authority_List amsender = new Inventory_Authority_List();
                DataSet dsAUZ = amsender.GetData();
                string Store_prefix = pstrDepotid.Substring(0, 1);
                DataRow[] listAuz = dsAUZ.Tables[0].Select("Store_prefix=" + "'" + Store_prefix + "'" + " and AreaName=" + "'" + pstrAreaName + "'");

                for (int i = 0; i < listAuz.Count(); i++)
                {
                    string strReceive = listAuz[i]["Financial_AM"].ToString();
                    if (strReceive != "无")
                    {
                        string strMessage = pstrDepotname + "  店铺已经汇款，单据号" + pstrInventoryID + @"，请及时登录店务系统进行相关操作。</p> 
                                点击<a href= http://192.168.0.125  target=_blank>这里</a>进行操作。";
                        AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
                        string strResult = msg.SendSubjectMsg("AM", "ITSM", "店铺汇款", strReceive, "信息部服务中心", strMessage, DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
                        DataTable dt = new HZY_SBS.AM_Sender_LogDataTable();
                        DataRow dr = dt.NewRow();
                        DateTime datetime = DateTime.Now;
                        string strGuid = System.Guid.NewGuid().ToString();
                        dr["ID"] = strGuid;
                        dr["Result"] = strResult;
                        dr["Receive"] = strReceive;
                        dr["AM"] = "AM";
                        dr["Sender"] = "信息部服务中心";
                        dr["ITSM"] = "ITSM";
                        dr["Type"] = "店铺汇款";
                        dr["Message"] = strMessage;
                        dr["Createtime"] = datetime;
                        dr["Com"] = "1";
                        dt.Rows.Add(dr);
                        conn_Log.BeginTransaction();
                        conn_Log.Insert("AM_Sender_Log", dt);
                        conn_Log.CommitTransaction();
                    }
                }
            }
            if (pstrState == "完成")
            {
                string strMessage = "单据号" + pstrInventoryID + @"，财务已经收款确认，此单据完结";
                AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
                string strResult = msg.SendSubjectMsg("AM", "ITSM", "财务收款确认", pstrDepotname, "信息部服务中心", strMessage, DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
                DataTable dt = new HZY_SBS.AM_Sender_LogDataTable();
                DataRow dr = dt.NewRow();
                DateTime datetime = DateTime.Now;
                string strGuid = System.Guid.NewGuid().ToString();
                dr["ID"] = strGuid;
                dr["Result"] = strResult;
                dr["Receive"] = pstrDepotname;
                dr["AM"] = "AM";
                dr["Sender"] = "信息部服务中心";
                dr["ITSM"] = "ITSM";
                dr["Type"] = "财务收款确认";
                dr["Message"] = strMessage;
                dr["Createtime"] = datetime;
                dr["Com"] = "1";
                dt.Rows.Add(dr);
                conn_Log.BeginTransaction();
                conn_Log.Insert("AM_Sender_Log", dt);
                conn_Log.CommitTransaction();
            }

            //驳回
            if (pstrState == "分公司经理驳回")
            {
                string strMessage = "单据号" + pstrInventoryID + @"，分公司经理已经驳回，请及时登录店务系统进行相关操作。</p> 
                                点击<a href= http://192.168.0.125  target=_blank>这里</a>进行操作。";
                AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
                string strResult = msg.SendSubjectMsg("AM", "ITSM", "分公司经理已经驳回", pstrDepotname, "信息部服务中心", strMessage, DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
                DataTable dt = new HZY_SBS.AM_Sender_LogDataTable();
                DataRow dr = dt.NewRow();
                DateTime datetime = DateTime.Now;
                string strGuid = System.Guid.NewGuid().ToString();
                dr["ID"] = strGuid;
                dr["Result"] = strResult;
                dr["Receive"] = pstrDepotname;
                dr["AM"] = "AM";
                dr["Sender"] = "信息部服务中心";
                dr["ITSM"] = "ITSM";
                dr["Type"] = "分公司经理已经驳回";
                dr["Message"] = strMessage;
                dr["Createtime"] = datetime;
                dr["Com"] = "1";
                dt.Rows.Add(dr);
                conn_Log.BeginTransaction();
                conn_Log.Insert("AM_Sender_Log", dt);
                conn_Log.CommitTransaction();
            }
            if (pstrState == "总部销售驳回")
            {
                string strMessage = "单据号" + pstrInventoryID + @"，总部销售驳回，请及时登录店务系统进行相关操作。</p> 
                                点击<a href= http://192.168.0.125  target=_blank>这里</a>进行操作。";
                AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
                string strResult = msg.SendSubjectMsg("AM", "ITSM", "总部销售驳回", pstrDepotname, "信息部服务中心", strMessage, DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
                DataTable dt = new HZY_SBS.AM_Sender_LogDataTable();
                DataRow dr = dt.NewRow();
                DateTime datetime = DateTime.Now;
                string strGuid = System.Guid.NewGuid().ToString();
                dr["ID"] = strGuid;
                dr["Result"] = strResult;
                dr["Receive"] = pstrDepotname;
                dr["AM"] = "AM";
                dr["Sender"] = "信息部服务中心";
                dr["ITSM"] = "ITSM";
                dr["Type"] = "总部销售驳回";
                dr["Message"] = strMessage;
                dr["Createtime"] = datetime;
                dr["Com"] = "1";
                dt.Rows.Add(dr);
                conn_Log.BeginTransaction();
                conn_Log.Insert("AM_Sender_Log", dt);
                conn_Log.CommitTransaction();
            }
            if (pstrState == "财务驳回")
            {
                string strMessage = "单据号" + pstrInventoryID + @"，财务驳回，请及时登录店务系统进行相关操作。</p> 
                                点击<a href= http://192.168.0.125  target=_blank>这里</a>进行操作。";
                AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
                string strResult = msg.SendSubjectMsg("AM", "ITSM", "财务驳回", pstrDepotname, "信息部服务中心", strMessage, DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
                DataTable dt = new HZY_SBS.AM_Sender_LogDataTable();
                DataRow dr = dt.NewRow();
                DateTime datetime = DateTime.Now;
                string strGuid = System.Guid.NewGuid().ToString();
                dr["ID"] = strGuid;
                dr["Result"] = strResult;
                dr["Receive"] = pstrDepotname;
                dr["AM"] = "AM";
                dr["Sender"] = "信息部服务中心";
                dr["ITSM"] = "ITSM";
                dr["Type"] = "财务驳回";
                dr["Message"] = strMessage;
                dr["Createtime"] = datetime;
                dr["Com"] = "1";
                dt.Rows.Add(dr);
                conn_Log.BeginTransaction();
                conn_Log.Insert("AM_Sender_Log", dt);
                conn_Log.CommitTransaction();
            }



        }
    }
}

