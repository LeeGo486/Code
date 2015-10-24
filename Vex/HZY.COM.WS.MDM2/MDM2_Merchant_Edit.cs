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


/// 类名：MDM2_Merchant_Edit
/// 类说明：编辑加盟商信息
/// 创建人：马卫清
/// 创建日期：2013-11-08
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 编辑加盟商信息
    /// </summary>
    public class MDM2_Merchant_Edit : LogicBase, ILogicGetData
    {
        public MDM2_Merchant_Edit()
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
                string strAutoCode = "";
                strAutoCode = m_request.Tables[0].Rows[0]["AutoCode"].ToString();

                if (strXML == "")
                {
                    throw new Exception("提交的XML为空！");
                }


                DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = dsXML.Tables["OPTYPE"];
                string strMDM_Class = "0010";
                string strMDM_LinkClass = "L0006";

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
                            string str加盟商编码 = "";
                            bool bIsInsert = false;

                            string strBody_id_0010 = "";
                            string strBody_id_L0006 = "";
                            string strBody_id_0001 = null;//用于存放公司的信息，如果为null，表示不做变更，如果不为NULL,需要变更

                            if (dt_List.Columns.Contains("Body_id_0001"))
                            {
                                strBody_id_0001 = dt_List.Rows[j]["Body_id_0001"].ToString();

                                if (strBody_id_0001 != "")
                                {
                                    //核对boid_ID是否存在
                                    MDM2_BodyIDCheck clsCheck = new MDM2_BodyIDCheck();
                                    clsCheck.Conn = conn;
                                    clsCheck.hzyMessage = this.hzyMessage;
                                    clsCheck.MDMClass = "0001";
                                    clsCheck.Body_ID = strBody_id_0001;
                                    if (clsCheck.Execute() == false)
                                    {
                                        throw new Exception("公司信息不正确！");
                                    }
                                }
                            }

                            strBody_id_0010 = dt_List.Rows[j]["body_ID_0010"].ToString();
                            strBody_id_L0006 = dt_List.Rows[j]["body_ID"].ToString();
                            MDM2_EntityCreatedBodyID_Edit clsBody = new MDM2_EntityCreatedBodyID_Edit();

                            if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                            {
                                //处理0010的实体
                                clsBody.Conn = conn;
                                clsBody.hzyMessage = hzyMessage;
                                clsBody.MDMClass = strMDM_Class;
                                clsBody.Execute();
                                strBody_id_0010 = clsBody.BodyID;

                                if (strBody_id_0010 == "")
                                {
                                    throw new Exception("BodyID_0010创建失败！");
                                }


                                if (strBody_id_0001 == null)
                                {
                                    throw new Exception("公司信息不正确！");
                                }

                                strBody_id_L0006 = "";

                                //生成新的加盟商编码
                                bIsInsert = true;


                                string str父加盟商编号 = "";
                                if (dt_List.Columns.Contains("父加盟商"))
                                {
                                    str父加盟商编号 = dt_List.Rows[j]["父加盟商"].ToString();

                                    if (str父加盟商编号 == "-1")
                                    {
                                        str父加盟商编号 = "";
                                    }
                                }
                                if (strAutoCode == "0")
                                {
                                    str加盟商编码 = dt_List.Rows[j]["加盟商编码"].ToString();
                                }
                                else
                                {
                                    str加盟商编码 = GetMerchatCode(strBody_id_0001, conn, str父加盟商编号);
                                }

                            }
                            else if (strBody_id_0010 != "" && strBody_id_L0006 != "") //更新
                            {
                                if (strAutoCode == "0" && dt_List.Columns.Contains("加盟商编码"))
                                {
                                    str加盟商编码 = dt_List.Rows[j]["加盟商编码"].ToString();
                                }
                                //核对0010是否存在
                                MDM2_BodyIDCheck clsCheck = new MDM2_BodyIDCheck();
                                clsCheck.hzyMessage = this.hzyMessage;
                                clsCheck.MDMClass = strMDM_Class;
                                clsCheck.Body_ID = strBody_id_0010;
                                clsCheck.Conn = conn;
                                if (clsCheck.Execute() == false)
                                {
                                    throw new Exception("Body_id_0010信息不正确！");
                                }

                                //核对0016是否存在
                                clsCheck.hzyMessage = this.hzyMessage;
                                clsCheck.MDMClass = strMDM_LinkClass;
                                clsCheck.Body_ID = strBody_id_L0006;
                                clsCheck.Conn = conn;
                                if (clsCheck.Execute() == false)
                                {
                                    throw new Exception("Body_id_0016信息不正确！");
                                }
                            }
                            else
                            {
                                throw new Exception("传入的参数有误，如果反复出现，请重新登录！");
                            }


                            //处理0016的实体
                            clsBody.MDMClass = strMDM_LinkClass;
                            clsBody.BodyID = strBody_id_L0006;
                            clsBody.LinkBodyIDList = strBody_id_0001 + "," + strBody_id_0010;
                            clsBody.Execute();
                            strBody_id_L0006 = clsBody.BodyID;

                            for (int k = 0; k < dt_List.Columns.Count; k++)
                            {
                                string strColumnName = dt_List.Columns[k].ColumnName;

                                if (strColumnName == "加盟商编码")
                                {
                                    if (bIsInsert == false && strAutoCode != "0")
                                    {
                                        continue;
                                    }
                                    else
                                    {
                                        dt_List.Rows[j][k] = str加盟商编码;

                                    }
                                }

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
                                clsProperty.BodyID = strBody_id_0010;
                                clsProperty.PropertyValue = dt_List.Rows[j][k].ToString();
                                if (clsProperty.Execute() == false)
                                {
                                    throw new Exception("修改失败，" + clsProperty.Message);
                                }

                                //插入加盟商编码
                                if (bIsInsert == true)
                                {
                                    clsProperty.PropertyName = "加盟商编码";
                                    clsProperty.BodyID = strBody_id_0010;
                                    clsProperty.PropertyValue = str加盟商编码;
                                    if (clsProperty.Execute() == false)
                                    {
                                        throw new Exception("修改失败，" + clsProperty.Message);
                                    }
                                }
                            }
                        }
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        for (int rowIndex = 0; rowIndex < dt_List.Rows.Count; rowIndex++)
                        {
                            string strBody_id_L0006 = dt_List.Rows[rowIndex]["body_id"].ToString();
                            string strBody_ID_0010 = conn.GetDataTableFirstValue("select body_id_0010 from MDM_L0006_B where Body_id=@param0", new string[1] { strBody_id_L0006 }).ToString();

                            MDM2_EntityDeleteBodyID_Edit clsDelete = new MDM2_EntityDeleteBodyID_Edit();
                            clsDelete.Conn = conn;
                            clsDelete.hzyMessage = hzyMessage;

                            //删除加盟商数据
                            if (strBody_ID_0010 != "")
                            {
                                clsDelete.MDMClass = strMDM_Class;
                                clsDelete.BodyID = strBody_ID_0010;

                                if (clsDelete.Execute() == false)
                                {
                                    throw new Exception("删除失败。");
                                }
                            }

                            //删除Link数据
                            clsDelete.MDMClass = strMDM_LinkClass;
                            clsDelete.BodyID = strBody_id_L0006;

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

        public string GetMerchatCode(string strBody_Id_0001, Dbconn conn, string strParentID)
        {
            string strCode = "";
            string str = "";
            if (strParentID != "")
            {

                //查找上级加盟商的最大值
                str = conn.GetDataTableFirstValue(@"SELECT MAX(加盟商编码) FROM MDM_Market2.dbo.V_L0006
                                                    WHERE 父加盟商='" + strParentID + "'").ToString();


                if (str == "")
                {
                    //检查加盟商是否存在
                    str = conn.GetDataTableFirstValue(@"SELECT MAX(加盟商编码) FROM MDM_Market2.dbo.V_L0006
                                                    WHERE 加盟商编码='" + strParentID + "'").ToString();

                    if (str == "")
                    {
                        throw new Exception("父加盟商不正确");
                    }
                    strCode = strParentID + "1";

                }
                else if (str.Length != 5)
                {
                    throw new Exception("父加盟商不正确");
                }
                else
                {
                    strCode = strParentID + Convert.ToInt32(str.Substring(4, 1) + 1).ToString();
                    if (strCode.Length == 6)
                    {
                        throw new Exception(strParentID + "的二级加盟商不允许超过10个，请联系IT部");
                    }
                }
            }
            else
            {
                str = conn.GetDataTableFirstValue(@"SELECT MAX(加盟商编码) FROM MDM_Market2.dbo.V_L0006
                                                    WHERE body_id_0001='" + strBody_Id_0001 + "'").ToString();

                if (str == "")
                {
                    str = conn.GetDataTableFirstValue(@"SELECT 公司前缀 FROM MDM_Market2.dbo.V_0001
                                                    WHERE body_id='" + strBody_Id_0001 + "'").ToString();
                    if (str == "")
                    {
                        throw new Exception("公司的前缀没有设置，请先设置公司前缀");
                    }

                    strCode = str.Substring(0, 1) + "0000";

                }
                else
                {
                    strCode = str.Substring(0, 1) + (Convert.ToInt32(str.Substring(1)) + 1).ToString("0000");
                }

            }
            return strCode;
        }
    }

}