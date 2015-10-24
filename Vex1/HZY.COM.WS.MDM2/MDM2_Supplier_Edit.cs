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


/// 类名：MDM2_0007_Edit
/// 类说明：编辑供应商信息
/// 创建人：马卫清
/// 创建日期：2013-11-08
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 编辑供应商信息
    /// </summary>
    public class MDM2_Supplier_Edit : LogicBase, ILogicGetData
    {
        public MDM2_Supplier_Edit()
        {
            this.m_SessionCheck = true;

        }

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        /// <summary>
        /// 编辑供应商信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("MDM_Master2");

            try
            {
                DataSet ds_Return = new DataSet();
                DataSet dsRequest = new DataSet();

                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                if (strXML == "")
                {
                    throw new Exception("提交的XML为空！");
                }


                DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = dsXML.Tables["OPTYPE"];
                string strMDM_Class = "0007";

                conn.LockTableList.Add("MDM_" + strMDM_Class + "_B");
                conn.LockTableList.Add("MDM_" + strMDM_Class + "_E");
                conn.BeginTransaction();

                for (int i = 0; i < dt_OPTYPE.Rows.Count; i++)
                {

                    DataTable dt_List = dsXML.Tables[Common.Common.GetListTableName(i)];
                    
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE"
                        || dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT"
                        )
                    {

                        //插入BODY表

                        for (int j = 0; j < dt_List.Rows.Count; j++)
                        {
                            string strBody_id = "";

                            strBody_id = dt_List.Rows[j]["body_ID"].ToString();

                            if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                            {
                                MDM2_EntityCreatedBodyID_Edit clsBody = new MDM2_EntityCreatedBodyID_Edit();
                                clsBody.Conn = conn;
                                clsBody.hzyMessage = hzyMessage;
                                clsBody.MDMClass = strMDM_Class;
                                clsBody.Execute();
                                strBody_id = clsBody.BodyID;

                                if (strBody_id == "")
                                {
                                    throw new Exception("BodyID创建失败！");
                                }
                            }
                            else if (strBody_id == "")
                            {
                                throw new Exception("传入的参数有误，如果反复出现，请重新登录！");
                            }


                            for (int k = 0; k < dt_List.Columns.Count; k++)
                            {
                                string strColumnName = dt_List.Columns[k].ColumnName;

                                if (strColumnName.ToLower() == "rowindex" ||
                                    strColumnName.ToLower() == "timestamps" ||
                                    strColumnName.ToLower() == "body_id" 
                                    )
                                {
                                    continue;
                                }

                                MDM2_EntityPropertyValue_Edit clsProperty = new MDM2_EntityPropertyValue_Edit();
                                clsProperty.Conn = conn;
                                clsProperty.hzyMessage = hzyMessage;
                                clsProperty.MDMClass = strMDM_Class;
                                clsProperty.ExpressionName = "CN";
                                clsProperty.PropertyName = strColumnName;
                                clsProperty.BodyID = strBody_id;
                                clsProperty.PropertyValue = dt_List.Rows[j][k].ToString();
                                if (clsProperty.Execute() == false)
                                {
                                    throw new Exception("修改失败，" + clsProperty.Message);
                                }
                            }
                        }


                        
                    }
                    else
                    {
                        throw new Exception("提交了错误的操作类型");
                    }
                }

                dt_EditResult.Rows.Add(new object[] { true, "操作成功" });

                ds_Return.Tables.Add(dt_EditResult);
                conn.CommitTransaction();

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