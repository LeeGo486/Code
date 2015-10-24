using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：ITSM_Check_List_Check 
/// 类说明：对审核步骤进行审核
/// 创建人：马卫清
/// 创建日期：2013-06-14
/// 修改人：
/// 修改日期：
namespace HZY.COM.ITSM
{
    /// <summary>
    /// 对审核步骤进行审核
    /// </summary>
    public class ITSM_Check_List_Check : LogicBase, ILogicGetData
    {
        public ITSM_Check_List_Check()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 对审核步骤进行审核
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                //DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();
                DataSet dsRequest = new DataSet();

                ArrayList listAMSendList = new ArrayList();


                Dbconn conn = new Dbconn("HZY_ITSM");

                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                DataSet ds = Common.Common.GetDSByExcelXML(strXML);

                string strCheck_ID = "";
                string strCheck_User = "";
                string strCheck_Result = "";
                string strCheck_RemarK = "";
                string strKey_Value = "";
                string strKeyColumn = "";
                string strRequestTableName = "";

                strCheck_ID = ds.Tables["LIST"].Rows[0]["ID"].ToString();
                if (strCheck_ID == "")
                {
                    ds_Return = Common.Common.GetRequestDataSet(new string[] { "Result" }, new string[] { "1:您的请求有误!" });

                    return ds_Return;

                }

                DataTable dt = conn.GetDataTable(@"
                            SELECT  t1.ID ,
                                    t1.Key_ID ,
                                    t1.Seq_Index ,
                                    t1.Seq_Name ,
                                    t1.Check_User ,
                                    t1.Check_Type,
                                    t1.Check_Type_Table_Name,
                                    t1.Check_Type_Key_Column,
                                    t1.Check_Date ,
                                    t1.Check_Result ,
                                    t1.Remark ,
                                    t2.Table_Templete
                            FROM    dbo.Check_List t1
                                    LEFT JOIN dbo.check_Table_Type t2 ON t1.Check_Type = t2.Check_Type
                            WHERE   t1.id = @Param0

                    ", new string[1] { strCheck_ID });

                if (dt.Rows.Count == 0)
                {
                    ds_Return = Common.Common.GetRequestDataSet(new string[] { "Result" }, new string[] { "2:您的请求有误！" });

                    return ds_Return;
                }

                strKey_Value = dt.Rows[0]["Key_ID"].ToString();
                strKeyColumn = dt.Rows[0]["Check_Type_Key_Column"].ToString();
                strRequestTableName = dt.Rows[0]["Check_Type_Table_Name"].ToString();

                if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "GET")
                {

                    ITSM_Server_Request_EditByXML itsm_SR = new ITSM_Server_Request_EditByXML();

                    strXML = @"<ROOT><OPTYPE>GET</OPTYPE>
                                        <LIST>
                                        <ROW>    
                                        <condition>" + strKeyColumn + @"='" + strKey_Value + @"'</condition>
                                        </ROW>
                                        </LIST>
                                        </ROOT>";
                    DataSet ds_ITSMSR_Request = Common.Common.GetRequestDataSet(new string[1] { "XML" }, new string[1] { strXML});
                    itsm_SR.Request = ds_ITSMSR_Request;
                    DataSet ds_ITSMSR_Response = itsm_SR.GetData();
                    if (ds_ITSMSR_Response.Tables.Count == 0 || ds_ITSMSR_Response.Tables[0].Rows.Count == 0)
                    {
                        ds_Return = Common.Common.GetRequestDataSet(new string[] { "Result" }, new string[] { "3:获取原始单据有误！" });
                        return ds_Return;
                    }

                    string strTableTemplete = dt.Rows[0]["Table_Templete"].ToString();
                    for (int i = 0; i < ds_ITSMSR_Response.Tables[0].Columns.Count; i++)
                    {
                        string strTemp = ds_ITSMSR_Response.Tables[0].Rows[0][i].ToString().Replace("\n", "<p>");
                        if(strTemp == "")
                        {
                            strTemp = "&nbsp;";
                        }
                        strTableTemplete = strTableTemplete.Replace("[@@" + ds_ITSMSR_Response.Tables[0].Columns[i].ColumnName + "]", strTemp);
                    }
                    dt.Rows[0]["Table_Templete"] = Microsoft.JScript.GlobalObject.escape(strTableTemplete);

                    dt.Columns.Add("timestamps");
                    dt.Rows[0]["timestamps"] = ds_ITSMSR_Response.Tables[0].Rows[0]["timestamps"];

                    ds_Return.Tables.Add(dt.Copy());
                   

                }
                else if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "EDIT")
                {

                    strCheck_ID = ds.Tables["LIST"].Rows[0]["ID"].ToString();
                    strCheck_User = ds.Tables["LIST"].Rows[0]["Check_User"].ToString();
                    strCheck_Result = ds.Tables["LIST"].Rows[0]["Check_Result"].ToString();
                    strCheck_RemarK = ds.Tables["LIST"].Rows[0]["Check_Remark"].ToString();

                    DataTable dtCheckList = conn.GetDataTable("SELECT * FROM Check_List WHERE ID='" + strCheck_ID + "'");

                    if (dt.Rows.Count == 0)
                    {
                        throw new Exception("该审核单已不存在，请联系管理员");
                    }

                    int nSeq_ID = Convert.ToInt32(dt.Rows[0]["Seq_Index"]);

                    //判断是否已经进行后续的审批
                    string strSql = "SELECT '1' as A from Check_List WHERE Check_Type='" + dt.Rows[0]["Check_Type"].ToString() + @"'
                                AND Key_ID='" + dt.Rows[0]["Key_ID"].ToString() + @"'
                                AND Check_Result is not null
                                AND Seq_Index>" + nSeq_ID.ToString() + "";

                    if (conn.GetDataTableRowCount(strSql) > 0)
                    {
                        throw new Exception("下一道的流程已经审批，本次审批不能再做修改！");
                    }


                    dtCheckList.Rows[0]["Check_User"] = strCheck_User;
                    dtCheckList.Rows[0]["Check_Date"] = DateTime.Now;
                    dtCheckList.Rows[0]["Check_Result"] = strCheck_Result;
                    dtCheckList.Rows[0]["Remark"] = strCheck_RemarK;
                    dtCheckList.Rows[0]["updateTime"] = DateTime.Now;

                    ArrayList listTable = new ArrayList();
                    listTable.Add("Check_List");

                    try
                    {
                        conn.BeginTransaction();
                        conn.TableLock(listTable);

                        //判断数据是否为最新数据
                        strSql = "SELECT timestamps+0 as timestamps from " + strRequestTableName
                            + " WHERE Deleted=0 AND " + strKeyColumn + "='" + strKey_Value + "'";

                        string strTimestamps = conn.GetDataTableFirstValue(strSql).ToString();
                        if (strTimestamps != ds.Tables["LIST"].Rows[0]["timestamps"].ToString())
                        {
                            throw new Exception("原申请单数据已被修改，请刷新后重试！");
                        }
                        //dt.Columns.Remove("timestamps");
                        conn.Update("Check_List", dtCheckList, "ID='" + strCheck_ID + "'");


                        string[] strColumn = new string[3];
                        string[] strValue = new string[3];
                        strColumn[0] = "Check_Type";
                        strColumn[1] = "Seq_Name";
                        strColumn[2] = "Key_ID";

                        strValue[0] = dt.Rows[0]["Check_Type"].ToString();
                        strValue[1] = dt.Rows[0]["Seq_Name"].ToString();
                        strValue[2] = dt.Rows[0]["Key_ID"].ToString();

                        DataSet requestDs = Common.Common.GetRequestDataSet(strColumn, strValue);

                        ITSM_Check_List_Edit checkListEdit = new ITSM_Check_List_Edit();
                        checkListEdit.Conn = conn;
                        checkListEdit.ListAMSendList = listAMSendList;
                        checkListEdit.Request = requestDs;
                        checkListEdit.Execute();

                        if (strCheck_Result != "同意")
                        {
                            //更新原表的状态为已驳回
                            strSql = "UPDATE " + strRequestTableName + " SET State='已驳回' WHERE Deleted=0 AND " + strKeyColumn + "='" + strKey_Value + "'";
                            conn.ExcuteQuerryByTran(strSql);
                        }
                        else
                        {
                            //判断是否有已驳回的状态
                            strSql = "SELECT '1' as A from Check_List WHERE Check_Type='" + dt.Rows[0]["Check_Type"].ToString() + @"'
                                AND Key_ID='" + strKey_Value + @"'
                                AND (Seq_index = " + nSeq_ID.ToString() + @" 
                                AND Check_Result='已驳回')";

                            //没有已驳回的记录
                            if (conn.GetDataTableRowCount(strSql) == 0)
                            {
                                //判断是否还有后续的流程
                                strSql = "SELECT '1' as A from Check_List WHERE Check_Type='" + dt.Rows[0]["Check_Type"].ToString() + @"'
                                AND Key_ID='" + strKey_Value + @"'
                                AND (Seq_Index>" + nSeq_ID.ToString() + @"
                                OR (Seq_Index=" + nSeq_ID.ToString() + @"
                                AND Must_Check=1
                                AND Check_Date IS NULL
                                ))";

                                if (conn.GetDataTableRowCount(strSql) == 0)
                                {
                                    //更新原表的状态为已审核
                                    strSql = "UPDATE " + strRequestTableName + " SET State='已审核' WHERE Deleted=0 AND " + strKeyColumn + "='" + strKey_Value + "'";
                                    conn.ExcuteQuerryByTran(strSql);

                                    ITSM_Common.SendAMMessage("", "马卫清", "有服务器申请表需要操作", "您有有服务器申请表需要操作，请进入EXCEL操作");
                                }
                                else
                                {
                                    //更新原表的状态为审核中
                                    strSql = "UPDATE " + strRequestTableName + " SET State='审核中' WHERE Deleted=0 AND " + strKeyColumn + "='" + strKey_Value + "'";
                                    conn.ExcuteQuerryByTran(strSql);
                                }
                            }
                        }

                        conn.CommitTransaction();

                        for (int i = 0; i < listAMSendList.Count; i++)
                        {
                            string[] strList = (string[])(listAMSendList[i]);
                            ITSM_Common.SendAMMessage(strList[0], strList[1], strList[2]);
                        }

                    }
                    catch (Exception)
                    {
                        conn.RollbackTransaction();
                        throw;
                    }

                    ds_Return = Common.Common.GetRequestDataSet(new string[] { "Result" }, new string[] { "true" });
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