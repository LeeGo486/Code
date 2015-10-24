using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：ITSM_Check_List_Edit 
/// 类说明：生成审核步骤
/// 创建人：马卫清
/// 创建日期：2013-06-14
/// 修改人：
/// 修改日期：
namespace HZY.COM.ITSM
{
    /// <summary>
    /// 生成审核步骤
    /// </summary>
    public class ITSM_Check_List_Edit : LogicBase, ILogicExecute
    {
        public ITSM_Check_List_Edit()
        {
            this.m_SessionCheck = false;
        }

        Dbconn conn = null;
        ArrayList listAMSendList = new ArrayList();
        public Dbconn Conn
        {
            set
            {
                conn = value;
            }
        }

        public ArrayList ListAMSendList
        {
            get
            {
                return listAMSendList;
            }
            set
            {
                listAMSendList = value;
            }
        }
        /// <summary>
        /// 生成审核步骤
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
           
            try
            {

                string strCheck_Type = "";
                string strSeq_Name = "";
                string strKey_ID = "";
                string strSQL = "";
                strCheck_Type = m_request.Tables[0].Rows[0]["Check_Type"].ToString().Trim();
                strSeq_Name = m_request.Tables[0].Rows[0]["Seq_Name"].ToString().Trim();
                strKey_ID = m_request.Tables[0].Rows[0]["Key_ID"].ToString().Trim();

                string strSeq_Index = "";
                if (strSeq_Name.Trim() == "")
                {
                    strSeq_Index = "0";
                }
                else
                {
                    strSQL = "SELECT Seq_Index FROM Check_Type WHERE Seq_Name = '" + strSeq_Name + @"'  
                                                                   AND  Check_Type = '" + strCheck_Type + "'";

                    strSeq_Index = conn.GetDataTableFirstValue(strSQL, new string[0]).ToString();

                    if (strSeq_Index == "")
                    {
                        strSeq_Index = "0";
                    }
                }


                //判断本次节点中，是否有未完成或者驳回的节点，如果有的话，就不建立新节点
                strSQL = @"SELECT  Id 
                          FROM [Check_List]
                          WHERE Seq_Index = " + strSeq_Index + @"
                            AND Check_Type = '" + strCheck_Type + @"'
                            AND Key_ID = '" + strKey_ID + @"'
                            AND Must_Check=1
                            AND ISNULL(Check_Result,'')<>'同意'
                            ";

                if (conn.GetDataTableRowCount(strSQL) > 0)
                {
                    return false;

                }

                strSQL = @"SELECT  Id as Check_Type_ID,
                                Check_Type ,
                                Check_Type_Name ,
                                Check_Type_Table_Name,
                                Check_Type_Key_Column,
                                Seq_Name ,
                                Seq_Index ,
                                Check_User ,
                                Must_Check
                          FROM [Check_Type]
                          WHERE Seq_Index = " + (Convert.ToInt32(strSeq_Index) + 1) + @"
                            AND  Check_Type = '" + strCheck_Type + "'";


                DataTable dt_CheckType = conn.GetDataTable(strSQL, new string[0]);
                if (dt_CheckType.Rows.Count > 0)
                {
                    strSQL = "DELETE FROM [Check_List] WHERE Seq_Index >" + strSeq_Index + @"
                            AND  Check_Type = '" + strCheck_Type + @"'
                            AND Key_ID = '" + strKey_ID + "'";

                    conn.ExcuteQuerryByTran(strSQL);

                    for (int i = 0; i < dt_CheckType.Rows.Count; i++)
                    {
                        DataTable dtTemp = dt_CheckType.Clone();
                        dtTemp.ImportRow(dt_CheckType.Rows[i]);

                        string strGuid = conn.GetDataTableFirstValue("SELECT NEWID() as ID").ToString();
                        string strAMRevier = dtTemp.Rows[0]["Check_User"].ToString();
                        dtTemp.Columns.Add("ID");
                        dtTemp.Columns.Add("Key_ID");
                        dtTemp.Rows[0]["ID"] = strGuid;
                        dtTemp.Rows[0]["Key_ID"] = strKey_ID;

                        //插入CheckList
                        conn.Insert("Check_List", dtTemp);

                        //小翅膀进行提醒
                        ListAMSendList.Add(new string[3] { strGuid, strAMRevier,strKey_ID });
                    }
                }

                return true;
            }
            catch
            {
                throw;
            }
        }
       

    }

}