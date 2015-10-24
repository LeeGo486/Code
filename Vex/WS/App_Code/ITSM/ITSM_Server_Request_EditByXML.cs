using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：ITSM_Server_Request_EditByXML 
/// 类说明：根据XML内容更新服务器申请单
/// 创建人：马卫清
/// 创建日期：2013-06-08
/// 修改人：
/// 修改日期：
namespace HZY.COM.ITSM
{
    /// <summary>
    /// 根据XML内容更新服务器申请单
    /// </summary>
    public class ITSM_Server_Request_EditByXML : LogicBase, ILogicGetData
    {
        public ITSM_Server_Request_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容更新服务器申请单
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();
                DataSet dsRequest = new DataSet();

                ArrayList listAMSendList = new ArrayList();

                Dbconn conn = new Dbconn("HZY_ITSM");

                string strXML = "";
                string strSQL = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);

                if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "GET")
                {
                    string strWHERE = " Deleted=0 ";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = @" SELECT  [Request_ID]
                                      ,[Request_Code]
                                      ,[Request_UserName]
                                      ,[Request_Date]
                                      ,[Request_Type]
                                      ,[Prod]
                                      ,[Memory]
                                      ,[CPU]
                                      ,[Disk_Space]
                                      ,[Request_Reason]
                                      ,[Request_RequireMent]
                                      ,[State]
                                      ,[OM_Opration]
                                      ,[OM_Opration_Name]
                                      ,[OM_Opration_Date]
                                      ,[Deleted]     
                                      ,[timestamps]+0 timestamps ,
                                    t2.Check_User CIO ,
                                    t2.Check_Date CIO_Check_Date ,
                                    t2.Remark AS CIO_Remark ,
                                    t2.Check_Result AS CIO_Check_Result ,
                                    t2.ID AS CIO_Check_ID ,
                                    t3.Check_User OM ,
                                    t3.Check_Date OM_Check_Date ,
                                    t3.Check_Result AS OM_Check_Result ,
                                    t3.ID AS OM_Check_ID ,
                                    t3.Remark AS OM_Remark
                                FROM    Server_Request WITH ( NOLOCK )
                                    LEFT JOIN dbo.Check_List t2 ON Server_Request.Request_Code = t2.Key_ID
                                                                    AND t2.Check_Type = 'Server_Request'
                                                                    AND t2.seq_name = 'CIO'
                                    LEFT JOIN dbo.Check_List t3 ON Server_Request.Request_Code = t3.Key_ID
                                                                    AND t3.Check_Type = 'Server_Request'
                                                                    AND t3.seq_name = 'OM'
                                WHERE " + strWHERE;
                    ds_Return = conn.GetDataSet(strSQL);
                }
                else
                {

                    ArrayList tableList = new ArrayList();
                    tableList.Add("Server_Request");
                    tableList.Add("Check_List");
                    conn.BeginTransaction();
                    conn.TableLock(tableList);
                    try
                    {
                        if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "DELETE")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                strSQL = @"UPDATE Server_Request SET Deleted=1 
                               WHERE Request_Code='" + ds.Tables["LIST"].Rows[i]["Request_Code"].ToString() + @"'
                                AND Deleted=0 ";
                                conn.ExcuteQuerryByTran(strSQL);
                            }

                        }
                        else if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "EDIT")
                        {
                            for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                            {
                                DataTable dt = ds.Tables["LIST"].Clone();
                                dt.ImportRow(ds.Tables["LIST"].Rows[i]);

                                strSQL = @"SELECT * FROM Server_Request WHERE  Request_Code=@param0
                                AND Deleted=0 ";

                                DataTable dt_SR = conn.GetDataTable(strSQL, new string[1] { ds.Tables["LIST"].Rows[i]["Request_Code"].ToString() });
                                //update
                                if (dt_SR.Rows.Count > 0)
                                {
                                    //运维操作
                                    if (ds.Tables["LIST"].Rows[i]["OM_Opration"].ToString()!= "")
                                    {

                                        if (!dt.Columns.Contains("State"))
                                        {
                                            dt.Columns.Add("State");
                                        }

                                        if (!dt.Columns.Contains("OM_Opration_Date"))
                                        {
                                            dt.Columns.Add("OM_Opration_Date");
                                        }
                                        dt.Rows[0]["State"] = "已完成";
                                        dt.Rows[0]["OM_Opration_Date"] =DateTime.Now;

                                        ITSM_Common.SendAMMessage("", dt_SR.Rows[0]["Request_UserName"].ToString(), "您的申请单已经处理完毕", "您的申请单（" + dt_SR.Rows[0]["Request_Code"].ToString() + "）已经处理完毕，请进入EXCEL查看");

                                    }

                                    conn.Update("Server_Request", dt, "Request_Code='" + ds.Tables["LIST"].Rows[i]["Request_Code"].ToString() + @"'");


                                }
                                else  //add
                                {


                                    DataTable dtTemp = conn.GetDataTableInTrans(
                                    @"SELECT MAX(Request_Code) AS MaxCode ,'SR'+CONVERT(VARCHAR(10),GETDATE(),112) AS PreCode FROM dbo.Server_Request
                                    WHERE Request_Code LIKE 'SR'+CONVERT(VARCHAR(10),GETDATE(),112) + '%'");

                                    string strCode = dtTemp.Rows[0]["MaxCode"].ToString();
                                    if (strCode == "")
                                    {
                                        strCode = dtTemp.Rows[0]["PreCode"].ToString() + "001";
                                    }
                                    else
                                    {
                                        strCode = dtTemp.Rows[0]["PreCode"].ToString() + (Convert.ToInt32(strCode.Substring(strCode.Length - 3)) + 1).ToString("000");
                                    }

                                    if (!dt.Columns.Contains("State"))
                                    {
                                        dt.Columns.Add("State");
                                    }
                                    dt.Rows[0]["State"] = "已提交";

                                    dt.Rows[0]["Request_Code"] = strCode;
                                    conn.Insert("Server_Request", dt);
                                     

                                    ITSM_Check_List_Edit checkList = new ITSM_Check_List_Edit();
                                    string[] strColumn = new string[3];
                                    string[] strValue = new string[3];
                                    strColumn[0] = "Check_Type";
                                    strColumn[1] = "Seq_Name";
                                    strColumn[2] = "Key_ID";

                                    strValue[0] = "Server_Request";
                                    strValue[1] = "";
                                    strValue[2] = strCode;

                                    checkList.Request = Common.Common.GetRequestDataSet(strColumn,strValue);
                                    checkList.Conn = conn;
                                    checkList.ListAMSendList = listAMSendList;
                                    checkList.Execute();

                                    //listAMSendList = checkList.ListAMSendList;
                                }

                            }
                        }
                        conn.CommitTransaction();

                        for (int i = 0; i < listAMSendList.Count; i++)
                        {
                            string[]  strList= (string[])(listAMSendList[i]);
                            ITSM_Common.SendAMMessage(strList[0], strList[1],strList[2]);
                        }

                        ds_Return = Common.Common.GetRequestDataSet(new string[]{"Result"},new string[]{"true"});
                    }
                    catch
                    {
                        conn.RollbackTransaction();
                        throw;
                    }
                }
                return ds_Return;
            }
            catch
            {
                throw;
            }

        }





    }

}