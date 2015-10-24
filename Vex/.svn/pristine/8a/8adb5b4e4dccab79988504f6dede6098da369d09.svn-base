using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：MDM2_Get_AreaInfo
/// 类说明：获取国家地理的信息
/// 创建人：马卫清
/// 创建日期：2013-12-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 获取国家地理的下拉框信息
    /// </summary>
    public class MDM2_Get_AreaInfo : LogicBase, ILogicGetData
    {
        public MDM2_Get_AreaInfo()
        {
            this.m_SessionCheck = true;

        }

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        private string m_Containnull = "0";
        /// <summary>
        /// 根据实体编号和属性名获取数据供下拉框使用
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {

            DataSet ds = new DataSet();
            DataSet ds_Return = new DataSet();
            
            string strAreaType = m_request.Tables[0].Rows[0]["AreaType"].ToString();
            string str省 = m_request.Tables[0].Rows[0]["Province"].ToString();
            string str地级市 = m_request.Tables[0].Rows[0]["Prefecture"].ToString();
            m_Containnull = m_request.Tables[0].Rows[0]["containnull"].ToString();

            switch (strAreaType)
            {
                case "省份":
                    ds_Return = GetProvince();
                    break;
                case "地级市":
                    ds_Return = GetPrefecture(str省);
                    break;
                case "县级市":
                    ds_Return = GetCity(str省, str地级市);
                    break;
            }

            
            return ds_Return;
        }

        private DataSet GetProvince()
        {
            DataSet ds_Return = new DataSet();
            

            Dbconn conn = new Dbconn("MDM_Market2");
            ds_Return = conn.GetDataSet(@"
                    SELECT  
                            编号 as id,
                            名称 as text 
                    FROM dbo.V_0014
                    WHERE 1=1 
                    order by 2 asc
            ");

            if (m_Containnull == "1")
            {
                ds_Return.Tables[0].Rows.Add(new object[] {"","无" });
            }
            return ds_Return;
        }


        private DataSet GetPrefecture(string str省)
        {
            DataSet ds_Return = new DataSet();
            string strWhere = "  t1.名称=@param0 ";
            if (str省== "")
            {
                throw new Exception("必须输入省份");
            }
            

            Dbconn conn = new Dbconn("MDM_Market2");
            ds_Return = conn.GetDataSet(@"
                        SELECT t2.编号,t2.名称,t2.城市等级
                        FROM  [dbo].[V_0014] t1
                        LEFT JOIN [dbo].[V_0015] t2 ON t1.编号=t2.省编号
                        WHERE " + strWhere + @"
                        order by 2 desc 
            ", new string[1] { str省 });


            if (m_Containnull == "1")
            {
                ds_Return.Tables[0].Rows.Add(new object[] { "", "无", " " });
            }
            return ds_Return;
        }



        private DataSet GetCity(string str省,string str地级市)
        {
            DataSet ds_Return = new DataSet();
            string strWhere = "  t1.名称=@param0 and t2.名称=@param1";
            if (str省 == "")
            {
                throw new Exception("必须输入省份");
            }

            if (str地级市 == "")
            {
                throw new Exception("必须输入地级市");
            }

            Dbconn conn = new Dbconn("MDM_Market2");
            ds_Return = conn.GetDataSet(@"
                        SELECT t3.编号,t3.名称,t3.城市等级
                        FROM  [dbo].[V_0014] t1
                        JOIN [dbo].[V_0015] t2 ON t1.编号=t2.省编号
                        JOIN dbo.V_0016 t3 ON t2.编号 = t3.地级市编号
                        WHERE " + strWhere + @"
                        order by 2 desc 
            ", new string[2] { str省, str地级市 });

            if (m_Containnull == "1")
            {
                ds_Return.Tables[0].Rows.Add(new object[] { "", "无", " " });
            }
            return ds_Return;
        }

    }

}