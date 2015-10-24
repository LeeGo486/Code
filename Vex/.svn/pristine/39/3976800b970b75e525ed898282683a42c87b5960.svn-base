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


/// 类名：MDM2_SaleArea_Edit
/// 类说明：编辑销售大区信息
/// 创建人：马卫清
/// 创建日期：2013-11-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 编辑销售大区信息
    /// </summary>
    public class MDM2_SaleArea_Edit : LogicBase, ILogicGetData
    {
        public MDM2_SaleArea_Edit()
        {
            this.m_SessionCheck = true;

        }

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        /// <summary>
        /// 编辑加盟商信息
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
                string strMDM_Class = "0018";
                string strMDM_LinkClass = "L0014";

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

                            string strBody_id_0018 = "";
                            string strBody_id_L0014 = "";
                            string strBody_id_0008 = null;//用于存放店铺品牌的信息，如果为null，表示不做变更，如果不为NULL,需要变更

                            if (dt_List.Columns.Contains("Body_id_0008"))
                            {
                                strBody_id_0008 = dt_List.Rows[j]["Body_id_0008"].ToString();

                                if (strBody_id_0008 != "")
                                {
                                    //核对boid_ID是否存在
                                    MDM2_BodyIDCheck clsCheck = new MDM2_BodyIDCheck();
                                    clsCheck.Conn = conn;
                                    clsCheck.hzyMessage = this.hzyMessage;
                                    clsCheck.MDMClass = "0008";
                                    clsCheck.Body_ID = strBody_id_0008;
                                    if (clsCheck.Execute() == false)
                                    {
                                        throw new Exception("店铺品牌信息不正确！");
                                    }
                                }
                            }

                            strBody_id_0018 = dt_List.Rows[j]["body_ID_0018"].ToString();
                            strBody_id_L0014 = dt_List.Rows[j]["body_ID"].ToString();
                            MDM2_EntityCreatedBodyID_Edit clsBody = new MDM2_EntityCreatedBodyID_Edit();

                            if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                            {
                                //处理0018的实体
                                clsBody.Conn = conn;
                                clsBody.hzyMessage = hzyMessage;
                                clsBody.MDMClass = strMDM_Class;
                                clsBody.Execute();
                                strBody_id_0018 = clsBody.BodyID;

                                if (strBody_id_0018 == "")
                                {
                                    throw new Exception("BodyID_0018创建失败！");
                                }


                                if (strBody_id_0008 == null)
                                {
                                    throw new Exception("店铺品牌信息不正确！");
                                }

                                strBody_id_L0014 = "";


                            }
                            else if (strBody_id_0018 != "" && strBody_id_L0014 != "") //更新
                            {
                                //核对0010是否存在
                                MDM2_BodyIDCheck clsCheck = new MDM2_BodyIDCheck();
                                clsCheck.hzyMessage = this.hzyMessage;
                                clsCheck.MDMClass = strMDM_Class;
                                clsCheck.Body_ID = strBody_id_0018;
                                clsCheck.Conn = conn;
                                if (clsCheck.Execute() == false)
                                {
                                    throw new Exception("Body_id_0010信息不正确！");
                                }

                                //核对0016是否存在
                                clsCheck.hzyMessage = this.hzyMessage;
                                clsCheck.MDMClass = strMDM_LinkClass;
                                clsCheck.Body_ID = strBody_id_L0014;
                                clsCheck.Conn = conn;
                                if (clsCheck.Execute() == false)
                                {
                                    throw new Exception("Body_id_0018信息不正确！");
                                }
                            }
                            else
                            {
                                throw new Exception("传入的参数有误，如果反复出现，请重新登录！");
                            }


                            //处理0016的实体
                            clsBody.MDMClass = strMDM_LinkClass;
                            clsBody.BodyID = strBody_id_L0014;
                            clsBody.LinkBodyIDList = strBody_id_0008 + "," + strBody_id_0018;
                            clsBody.Execute();
                            strBody_id_L0014 = clsBody.BodyID;

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
                                clsProperty.BodyID = strBody_id_0018;
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
                            string strBody_id_L0014 = dt_List.Rows[rowIndex]["body_id"].ToString();
                            string strBody_ID_0018 = conn.GetDataTableFirstValue("select body_id_0018 from MDM_L0014_B where Body_id=@param0", new string[1] { strBody_id_L0014 }).ToString();

                            MDM2_EntityDeleteBodyID_Edit clsDelete = new MDM2_EntityDeleteBodyID_Edit();
                            clsDelete.Conn = conn;
                            clsDelete.hzyMessage = hzyMessage;

                            //删除加盟商数据
                            if (strBody_ID_0018 != "")
                            {
                                clsDelete.MDMClass = strMDM_Class;
                                clsDelete.BodyID = strBody_ID_0018;

                                if (clsDelete.Execute() == false)
                                {
                                    throw new Exception("删除失败。");
                                }
                            }

                            //删除Link数据
                            clsDelete.MDMClass = strMDM_LinkClass;
                            clsDelete.BodyID = strBody_id_L0014;

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

//        public string GetSaleAreaCode(string strBody_Id_0008, Dbconn conn)
//        {
//            string strCode = "";

//            string str = conn.GetDataTableFirstValue(@"SELECT MAX(加盟商编码) FROM MDM_Market2.dbo.V_销售大区
//                                                    WHERE body_id_0001='" + strBody_Id_0008 + "'").ToString();

//            if (str == "")
//            {
//                str = conn.GetDataTableFirstValue(@"SELECT 公司前缀 FROM MDM_Market2.dbo.V_公司
//                                                    WHERE body_id='" + strBody_Id_0008 + "'").ToString();
//                if (str == "")
//                {
//                    throw new Exception("公司的前缀没有设置，请先设置公司前缀");
//                }

//                strCode = str.Substring(0, 1) + "0001";

//            }
//            else
//            {
//                strCode = str.Substring(0, 1) + (Convert.ToInt32(str.Substring(1)) + 1).ToString("0000");
//            }

//            return strCode;
//        }
    }

}