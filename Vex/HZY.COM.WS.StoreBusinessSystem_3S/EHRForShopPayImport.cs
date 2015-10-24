using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：HZY.COM.WS.StoreBusinessSystem_3S
/// 类说明：课程人员导入
/// 创建人：郭琦琦
/// 创建日期：2015-01-20 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.StoreBusinessSystem_3S
{
    public class EHRForShopPayImport : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public EHRForShopPayImport()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("ShopPAY");
        private Dbconn m_conn_c3 = new Dbconn("C3AMEHRCourseImport");
        DateTime m_TimeNow = DateTime.Now;
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataSet ds_Return_mdm = new DataSet();

        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                DataTable dtList = ds.Tables["List"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EHRForShopPayImportSQL".ToUpper())//店铺薪资条导入
                {
                    EHRForShopPayImportSQL(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DeleteData".ToUpper())//删除导入数据按照月份
                {
                    DeleteData(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EhrCouseImportSQL".ToUpper())//C3 课程导入
                {
                    EhrCouseImportSQL(dtList);
                }
                return ds_Return;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region 薪资
        /// <summary>
        /// 薪资
        /// </summary>
        private void EHRForShopPayImportSQL(DataTable pdt)
        {

            DataTable dtInput = m_RequestBak.Tables[0];
            dtInput.Columns.Add("ID");
            dtInput.Columns.Add("CreateName");
            dtInput.Columns.Add("CreateDate");

            string strMonth = dtInput.Rows[0]["月份"].ToString();//获取第一行excel月
            string strYear = dtInput.Rows[0]["年份"].ToString();//年
            string str身份证号 = dtInput.Rows[0]["身份证号"].ToString();//身份证

            string strYESorNO = m_conn.GetDataTableFirstValue(@" SELECT COUNT(*) count FROM [dbo].[EHRForShopPay]
                                                                 WHERE 年份='" + strYear + "' AND 月份='" + strMonth + @"' 
                                                                  AND 身份证号='" + str身份证号 + "'", new string[] { }).ToString();

            if (strYESorNO != "0")
            {
                throw new Exception("数据有重复请勿重复导入！" + "身份证号 " + str身份证号 + "年份为 " + strYear + "月份为 " + strMonth); ;
            }

            for (int i = 0; i < dtInput.Rows.Count; i++)
            {
                dtInput.Rows[i]["ID"] = System.Guid.NewGuid().ToString();
                dtInput.Rows[i]["CreateDate"] = m_TimeNow;
                dtInput.Rows[i]["CreateName"] = "admin";
            }

            bool bResult;
            m_conn.BeginTransaction(); // 开启事务
            bResult = m_conn.Insert("EHRForShopPay", dtInput);
            m_conn.CommitTransaction();//提交事务

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "上传成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "上传失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion


        #region 删除导入数据
        /// <summary>
        /// 删除导入数据
        /// </summary>
        private void DeleteData(DataTable pdt)
        {


            string strMonth = pdt.Rows[0]["month"].ToString();//月
            string strYear = pdt.Rows[0]["year"].ToString();//年
            bool bResult;
            m_conn.BeginTransaction(); // 开启事务
            bResult = m_conn.Delete("EHRForShopPay", "年份=" + "'" + strYear + "' and 月份='" + strMonth + "'");

            m_conn.CommitTransaction();//提交事务

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "删除成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "删除失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 课程导入
        /// <summary>
        /// 课程导入
        /// </summary>
        private void EhrCouseImportSQL(DataTable pdt)
        {

            DataTable dtInput = m_RequestBak.Tables[0];
            dtInput.Columns.Add("ID");
            dtInput.Columns.Add("CreateUser");
            dtInput.Columns.Add("CreateTime");
            dtInput.Columns.Add("ModifyUser");
            dtInput.Columns.Add("ModifyTime");

            bool bResult = false;
            string strId = pdt.Rows[0]["courseid"].ToString();//获取课程号
            string strType = pdt.Rows[0]["type"].ToString();//获取课程类型

            if (strType == "2")
            {
                string strSQL2 = @" DELETE HR_LK_CourseUser WHERE cid = '" + strId + "'";//删除所有课程信息
                m_conn_c3.ExcuteQuerryByTran(strSQL2, new object[] { });

                dtInput.Columns.Add("Uid");
                dtInput.Columns.Add("cid");

                DataSet dtCourseUser = m_conn_c3.GetDataSet(@" select * from  HR_CourseUser ");

                for (int i = 0; i < dtInput.Rows.Count; i++)
                {
                    DataRow[] dr = dtCourseUser.Tables[0].Select("EmployeeID=" + dtInput.Rows[i]["EmployeeID"]);
                    dtInput.Rows[i]["Uid"] = dr[0]["Id"].ToString();
                }

                for (int i = 0; i < dtInput.Rows.Count; i++)
                {
                    dtInput.Rows[i]["ID"] = System.Guid.NewGuid().ToString();
                    dtInput.Rows[i]["Cid"] = strId;
                    dtInput.Rows[i]["CreateTime"] = m_TimeNow;
                    dtInput.Rows[i]["CreateUser"] = "admin";
                    dtInput.Rows[i]["ModifyUser"] = "admin";
                    dtInput.Rows[i]["ModifyTime"] = m_TimeNow;
                }
                m_conn_c3.BeginTransaction(); // 开启事务
                dtInput.Columns.Remove("EmployeeID");
                dtInput.Columns.Remove("UserName");
                bResult = m_conn_c3.Insert("HR_LK_CourseUser", dtInput);
                m_conn_c3.CommitTransaction();//提交事务
            }

            else if (strType == "3")
            {
                string strSQL3 = @" DELETE HR_Specific WHERE CourseID = '" + strId + "'";
                m_conn_c3.ExcuteQuerryByTran(strSQL3, new object[] { });

                dtInput.Columns.Add("CourseID");

                for (int i = 0; i < dtInput.Rows.Count; i++)
                {
                    dtInput.Rows[i]["ID"] = System.Guid.NewGuid().ToString();
                    dtInput.Rows[i]["CourseID"] = strId;
                    dtInput.Rows[i]["CreateTime"] = m_TimeNow;
                    dtInput.Rows[i]["CreateUser"] = "admin";
                    dtInput.Rows[i]["ModifyUser"] = "admin";
                    dtInput.Rows[i]["ModifyTime"] = m_TimeNow;
                }
                m_conn_c3.BeginTransaction(); // 开启事务
                bResult = m_conn_c3.Insert("HR_Specific", dtInput);
                m_conn_c3.CommitTransaction();//提交事务
            }

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "上传成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "上传失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #endregion
    }
}
