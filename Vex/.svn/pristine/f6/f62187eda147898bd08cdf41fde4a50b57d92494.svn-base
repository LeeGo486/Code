using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;



/// 类名：System_Property_Info
/// 类说明：取到系统属性值（CRUD）
/// 创建人：郭琦琦
/// 创建日期：2014-02-10
/// 修改人：郭琦琦
/// 修改日期：2014-2-12

namespace HZY.COM.WS.EPAcount
{
    public class System_Property_Info : LogicBase, ILogicGetData
    {
        public System_Property_Info()
        {
            this.m_SessionCheck = false;
        }

        private Dbconn conn = new Dbconn("VexSSO");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                for (int j = 0; j < ds.Tables["OPTYPE"].Rows.Count; j++)
                {
                    if (dt_OPTYPE.Rows[j][0].ToString().ToUpper() == "GET")
                    {

                        int nPage = 1;
                        int nPageRowCount = 20;
                        string strOrder = " desc  ";
                        string strSort = " System_CODE ";
                        string strWhere = " 1=1 ";
                        string strSearchFilter = " ";

                        nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                        nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                        strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                        //strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                        strOrder = "System_CODE";
                        strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;
                        strSearchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : strSearchFilter;


                        if (strSearchFilter.Trim() != "")
                        {
                            strWhere += " AND " + strSearchFilter;
                        }


                        //取系统编号列表
                        System_Code sysList = new System_Code();
                        sysList.Request = m_request;
                        sysList.hzyMessage = this.hzyMessage;
                        DataSet ds_System = sysList.GetData();

                        //取到属性表
                        DataSet ds_Property = conn.GetDataSet(@"  SELECT 
                                                                        [Property_ID],
                                                                        [Property_Name]                                   
                                                                  FROM [MDM_System_Property]");

                        //取当前系统编号列表页System_ID字段的值
                        string strSystem_IDList = "0";
                        for (int i = 0; i < ds_System.Tables[0].Rows.Count; i++)
                        {
                            if (strSystem_IDList.Length > 0)
                            {
                                strSystem_IDList += ",";
                            }
                            strSystem_IDList += ds_System.Tables[0].Rows[i]["System_ID"].ToString();
                        }


                        DataTable dt = conn.GetDataTable(@" 
                                                            SELECT 
                                                                   a.[Property_Info_ID],
                                                                   a.[System_ID],
                                                                   a.[System_Code],
                                                                   a.[Property_ID],
                                                                   a.[Property_Text],
                                                                   b.Property_Name
                                                            FROM  [dbo].[MDM_System_Property_Info] a
                                                                   LEFT JOIN dbo.MDM_System_Property b
                                                                        ON  a.Property_ID = b.Property_ID
                                                            WHERE  a.System_ID IN (" + strSystem_IDList + ")", new string[0]);

                        //添加列:
                        for (int i = 0; i < ds_Property.Tables[0].Rows.Count; i++)
                        {
                            //ds_System.Tables[0].Columns.Add("COL"+ds_Property.Tables[0].Rows[i]["Property_Name"].ToString());
                            ds_System.Tables[0].Columns.Add(ds_Property.Tables[0].Rows[i]["Property_Name"].ToString());
                        }

                        //将值放进去新构造的表里，得到
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            string strSystem_ID = dt.Rows[i]["System_ID"].ToString();
                            string strProperty_Name = dt.Rows[i]["Property_Name"].ToString();

                            DataRow[] dr = ds_System.Tables[0].Select("System_ID=" + strSystem_ID);

                            if (dr.Length > 0 && ds_System.Tables[0].Columns.Contains(strProperty_Name))
                            {
                                dr[0][strProperty_Name] = dt.Rows[i]["Property_Text"].ToString();
                            }
                        }

                        ds_Return = ds_System;
                        ds_System = null;

                    }
                    if (dt_OPTYPE.Rows[j][0].ToString().ToUpper() == "UPDATE")
                    {
                        bool bResult = false;
                        conn.BeginTransaction();
                        DataTable dt_list = ds.Tables["List"];
                        //取XML返回的数据的list表的第一行数据（不支持多行保存）
                        string strSystem_ID = dt_list.Rows[0]["System_ID"].ToString();
                        string strSystem_Code = dt_list.Rows[0]["System_Code"].ToString();
                        dt_list.Columns.Remove("rowindex");

                        //构成新表供最后UPDATE 或者INSERT
                        DataTable dt_Data = new DataTable();
                        dt_Data.Columns.Add("System_ID");
                        dt_Data.Columns.Add("System_Code");
                        dt_Data.Columns.Add("Property_ID");
                        dt_Data.Columns.Add("Property_Name");
                        dt_Data.Columns.Add("Property_Text");
                        dt_Data.Columns.Add("Property_Info_ID");
                        dt_Data.Columns.Add("CreateTime");
                        dt_Data.Columns.Add("UpdateTime");

                        DateTime timeNow = DateTime.Now;

                        //从第四列 开始（行转列之后新加的列）
                        for (int i = 4; i < dt_list.Columns.Count; i++)
                        {
                            string strProperty_Text = dt_list.Rows[0][i].ToString();
                            //if (strProperty_Text != "")
                            //{
                                dt_Data.Rows.Add(new object[] { strSystem_ID, strSystem_Code, "", dt_list.Columns[i].ToString(), strProperty_Text, "", timeNow, timeNow });
                            //}
                        }
                        DataSet ds_Property = conn.GetDataSet(@"  SELECT 
                                                                        [Property_ID],
                                                                        [Property_Name]                                   
                                                                    FROM [MDM_System_Property]");

                        //获取Property_Name 系统属性值名称放到去StrProperty_Name_New

                        DataTable dtData_Update = dt_Data.Clone();
                        DataTable dtData_Insert = dt_Data.Clone();
                        for (int i = 0; i < dt_Data.Rows.Count; i++)
                        {
                            string strProperty_Name_New = dt_Data.Rows[i]["Property_Name"].ToString();
                            DataRow[] pr = ds_Property.Tables[0].Select("Property_Name='" + strProperty_Name_New + "'");
                            if (pr.Length > 0)
                            {
                                dt_Data.Rows[i]["Property_ID"] = pr[0]["Property_ID"].ToString();
                                string strProperty_Info_ID = conn.GetDataTableFirstValue(@"
                                                                SELECT 
                                                                        Property_Info_ID
                                                                FROM  [MDM_System_Property_Info]
                                                                WHERE Property_ID=" + pr[0]["Property_ID"].ToString() + @"
                                                                AND system_id=" + strSystem_ID + @" 
                                                                ").ToString();

                                if (strProperty_Info_ID != "")
                                {
                                    dt_Data.Rows[i]["Property_Info_ID"] = strProperty_Info_ID;
                                    dtData_Update.ImportRow(dt_Data.Rows[i]);
                                }
                                else
                                {
                                    dtData_Insert.ImportRow(dt_Data.Rows[i]);
                                }
                            }
                        }

                        dtData_Update.Columns.Remove("CreateTime");//弄成和 MDM_System_Property_Info一样 
                        dtData_Update.Columns.Remove("Property_Name");//弄成和 MDM_System_Property_Info一样 
                        dtData_Insert.Columns.Remove("Property_Name");//弄成和 MDM_System_Property_Info一样 
                        dtData_Insert.Columns.Remove("Property_Info_ID");//弄成和 MDM_System_Property_Info一样 

                        if (dtData_Update.Rows.Count > 0)
                        {
                            ArrayList listKey = new ArrayList();
                            listKey.Add("Property_Info_ID");
                            bResult = conn.Update("MDM_System_Property_info", dtData_Update, listKey);
                        }

                        if (dtData_Insert.Rows.Count > 0)
                        {
                            bResult = conn.Insert("MDM_System_Property_info", dtData_Insert);
                        }

                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "更新成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "更新失败" });
                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                }
                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
    }
}