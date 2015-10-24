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


/// 类名：MDM2_District_Edit
/// 类说明：编辑行政区信息
/// 创建人：马卫清
/// 创建日期：2014-01-06
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 编辑销售大区信息
    /// </summary>
    public class MDM2_District_Edit : LogicBase, ILogicGetData
    {
        public MDM2_District_Edit()
        {
            this.m_SessionCheck = true;

        }

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        /// <summary>
        /// 编辑销售大区信息
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
                string strMDM_Class = "0015";
                string strMDM_LinkClass = "L0010";

                conn.LockTableList.Add("MDM_" + strMDM_LinkClass + "_B");
                conn.LockTableList.Add("MDM_" + strMDM_Class + "_B");
                conn.LockTableList.Add("MDM_" + strMDM_LinkClass + "_E");
                conn.LockTableList.Add("MDM_" + strMDM_Class + "_E");
                conn.BeginTransaction();

                //获取所有属性
                MDM2_GetEntityPropertyList cls = new MDM2_GetEntityPropertyList();
                cls.hzyMessage = this.hzyMessage;
                cls.MainEntity = strMDM_Class;

                DataTable dtPorperty = cls.GetData().Tables[0];

                for (int i = 0; i < dt_OPTYPE.Rows.Count; i++)
                {
                    DataTable dt_List = dsXML.Tables[i + 1];

                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE"
                        || dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT"
                        )
                    {


                        //插入BODY表
                        for (int j = 0; j < dt_List.Rows.Count; j++)
                        {

                            string strBody_id_0015 = "";
                            string strBody_id_L0010 = "";
                            string strBody_id_0014 = null;//用于存放省的信息，如果为null，表示不做变更，如果不为NULL,需要变更

                            if (dt_List.Columns.Contains("Body_id_0014"))
                            {
                                strBody_id_0014 = dt_List.Rows[j]["Body_id_0014"].ToString();

                                if (strBody_id_0014 != "")
                                {
                                    //核对boid_ID是否存在
                                    MDM2_BodyIDCheck clsCheck = new MDM2_BodyIDCheck();
                                    clsCheck.Conn = conn;
                                    clsCheck.hzyMessage = this.hzyMessage;
                                    clsCheck.MDMClass = "0014";
                                    clsCheck.Body_ID = strBody_id_0014;
                                    if (clsCheck.Execute() == false)
                                    {
                                        throw new Exception("省的信息不正确！");
                                    }
                                }
                            }

                            strBody_id_0015 = dt_List.Rows[j]["body_ID_0015"].ToString();
                            strBody_id_L0010 = dt_List.Rows[j]["body_ID"].ToString();
                            MDM2_EntityCreatedBodyID_Edit clsBody = new MDM2_EntityCreatedBodyID_Edit();

                            if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                            {
                                //处理0015的实体
                                clsBody.Conn = conn;
                                clsBody.hzyMessage = hzyMessage;
                                clsBody.MDMClass = strMDM_Class;
                                clsBody.Execute();
                                strBody_id_0015 = clsBody.BodyID;

                                if (strBody_id_0015 == "")
                                {
                                    throw new Exception("BodyID_0015创建失败！");
                                }


                                if (strBody_id_0014 == null)
                                {
                                    throw new Exception("省信息不正确！");
                                }

                                strBody_id_L0010 = "";


                            }
                            else if (strBody_id_0015 != "" && strBody_id_L0010 != "") //更新
                            {
                                //核对0010是否存在
                                MDM2_BodyIDCheck clsCheck = new MDM2_BodyIDCheck();
                                clsCheck.hzyMessage = this.hzyMessage;
                                clsCheck.MDMClass = strMDM_Class;
                                clsCheck.Body_ID = strBody_id_0015;
                                clsCheck.Conn = conn;
                                if (clsCheck.Execute() == false)
                                {
                                    throw new Exception("Body_id_0015信息不正确！");
                                }

                                //核对L0010是否存在
                                clsCheck.hzyMessage = this.hzyMessage;
                                clsCheck.MDMClass = strMDM_LinkClass;
                                clsCheck.Body_ID = strBody_id_L0010;
                                clsCheck.Conn = conn;
                                if (clsCheck.Execute() == false)
                                {
                                    throw new Exception("Body_id_L0010信息不正确！");
                                }
                            }
                            else
                            {
                                throw new Exception("传入的参数有误，如果反复出现，请重新登录！");
                            }


                            
                            clsBody.MDMClass = strMDM_LinkClass;
                            clsBody.BodyID = strBody_id_L0010;
                            clsBody.LinkBodyIDList = strBody_id_0014 + "," + strBody_id_0015;
                            clsBody.Execute();
                            strBody_id_L0010 = clsBody.BodyID;
                            //处理0015的实体
                            for (int k = 0; k < dt_List.Columns.Count; k++)
                            {
                                string strColumnName = dt_List.Columns[k].ColumnName;
                               
                                if (dtPorperty.Select("Property_Name='" + strColumnName + "'").Length == 0)
                                {
                                    continue;
                                }

                                MDM2_EntityPropertyValue_Edit clsProperty = new MDM2_EntityPropertyValue_Edit();
                                clsProperty.Conn = conn;
                                clsProperty.hzyMessage = hzyMessage;
                                clsProperty.MDMClass = strMDM_Class;
                                clsProperty.ExpressionName = "CN";
                                clsProperty.PropertyName = strColumnName;
                                clsProperty.BodyID = strBody_id_0015;
                                clsProperty.PropertyValue = dt_List.Rows[j][k].ToString();
                                if (clsProperty.Execute() == false)
                                {
                                    throw new Exception("修改失败，" + clsProperty.Message);
                                }
                            }
                        }
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        for (int rowIndex = 0; rowIndex < dt_List.Rows.Count; rowIndex++)
                        {
                            string strBody_id_L0010 = dt_List.Rows[rowIndex]["body_id"].ToString();
                            string strBody_ID_0015 = conn.GetDataTableFirstValue("select body_id_0015 from MDM_L0010_B where Body_id=@param0", new string[1] { strBody_id_L0010 }).ToString();

                            MDM2_EntityDeleteBodyID_Edit clsDelete = new MDM2_EntityDeleteBodyID_Edit();
                            clsDelete.Conn = conn;
                            clsDelete.hzyMessage = hzyMessage;

                            //删除行政区实体的数据
                            if (strBody_ID_0015 != "")
                            {
                                clsDelete.MDMClass = strMDM_Class;
                                clsDelete.BodyID = strBody_ID_0015;

                                if (clsDelete.Execute() == false)
                                {
                                    throw new Exception("删除失败。");
                                }
                            }

                            //删除Link数据
                            clsDelete.MDMClass = strMDM_LinkClass;
                            clsDelete.BodyID = strBody_id_L0010;

                            if (clsDelete.Execute() == false)
                            {
                                throw new Exception("删除失败。");
                            }
                        }
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