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


/// 类名：MDM2_Depot_Edit
/// 类说明：编辑店铺信息
/// 创建人：马卫清
/// 创建日期：2013-11-12
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 编辑店铺信息
    /// </summary>
    public class MDM2_Depot_Edit : LogicBase, ILogicGetData
    {
        public MDM2_Depot_Edit()
        {
            this.m_SessionCheck = true;

        }
        private Dbconn m_Conn = null;

        public Dbconn Conn
        {
            get { return m_Conn; }
            set { m_Conn = value; }
        }

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        /// <summary>
        /// 编辑店铺信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            bool bRollBack = false;

            Dbconn conn = null;
            if (m_Conn == null)
            {
                conn = new Dbconn("MDM_Master2");
                bRollBack = true;
            }
            else
            {
                conn = m_Conn;
            }

            try
            {
                DataSet ds_Return = new DataSet();
                DataSet dsRequest = new DataSet();

                string strXML = "";
                string strAutoCode = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                strAutoCode = m_request.Tables[0].Rows[0]["AutoCode"].ToString();
                if (strXML == "")
                {
                    throw new Exception("提交的XML为空！");
                }


                DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = dsXML.Tables["OPTYPE"];
                string strMDM_Class_0006 = "0006";
                string strMDM_LinkClass = "L0013";

                conn.LockTableList.Add("MDM_" + strMDM_LinkClass + "_B");
                conn.LockTableList.Add("MDM_" + strMDM_Class_0006 + "_B");
                conn.LockTableList.Add("MDM_" + strMDM_LinkClass + "_E");
                conn.LockTableList.Add("MDM_" + strMDM_Class_0006 + "_E");
                conn.BeginTransaction();

                //获取所有属性
                MDM2_GetEntityPropertyList cls = new MDM2_GetEntityPropertyList();
                cls.hzyMessage = this.hzyMessage;
                cls.MainEntity = strMDM_Class_0006;

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
                            string str店铺ID = "";
                            bool bIsInsert = false;

                            string strBody_id_0006 = "";
                            string strBody_id_L0013 = "";
                            string strBody_id_L0006 = null;//用于存放加盟商的信息，如果为null，表示不做变更，如果不为NULL,需要变更
                            string strBody_id_L0011 = null;//用于存放县级市的信息，如果为null，表示不做变更，如果不为NULL,需要变更
                            string strBody_id_L0014 = null;//用于存放销售大区的信息，如果为null，表示不做变更，如果不为NULL,需要变更

                            strBody_id_0006 = dt_List.Rows[j]["body_ID_0006"].ToString();
                            strBody_id_L0013 = dt_List.Rows[j]["body_ID"].ToString();

                            if (dt_List.Columns.Contains("Body_id_L0006"))
                            {
                                strBody_id_L0006 = dt_List.Rows[j]["Body_id_L0006"].ToString();

                                if (strBody_id_L0006 != "")
                                {
                                    //核对boid_ID是否存在
                                    MDM2_BodyIDCheck clsCheck = new MDM2_BodyIDCheck();
                                    clsCheck.Conn = conn;
                                    clsCheck.hzyMessage = this.hzyMessage;
                                    clsCheck.MDMClass = "L0006";
                                    clsCheck.Body_ID = strBody_id_L0006;
                                    if (clsCheck.Execute() == false)
                                    {
                                        throw new Exception("加盟商信息不正确！");
                                    }
                                }
                            }
                            


                            if (dt_List.Columns.Contains("Body_id_L0011"))
                            {
                                strBody_id_L0011 = dt_List.Rows[j]["Body_id_L0011"].ToString();

                                if (strBody_id_L0011 != "")
                                {
                                    //核对boid_ID是否存在
                                    MDM2_BodyIDCheck clsCheck = new MDM2_BodyIDCheck();
                                    clsCheck.Conn = conn;
                                    clsCheck.hzyMessage = this.hzyMessage;
                                    clsCheck.MDMClass = "L0011";
                                    clsCheck.Body_ID = strBody_id_L0011;
                                    if (clsCheck.Execute() == false)
                                    {
                                        throw new Exception("县级市信息不正确！");
                                    }
                                }
                            }


                            if (dt_List.Columns.Contains("Body_id_L0014"))
                            {
                                strBody_id_L0014 = dt_List.Rows[j]["Body_id_L0014"].ToString();

                                if (strBody_id_L0014 != "")
                                {
                                    //核对boid_ID是否存在
                                    MDM2_BodyIDCheck clsCheck = new MDM2_BodyIDCheck();
                                    clsCheck.Conn = conn;
                                    clsCheck.hzyMessage = this.hzyMessage;
                                    clsCheck.MDMClass = "L0014";
                                    clsCheck.Body_ID = strBody_id_L0014;
                                    if (clsCheck.Execute() == false)
                                    {
                                        throw new Exception("销售大区信息不正确！");
                                    }
                                }
                            }



                            MDM2_EntityCreatedBodyID_Edit clsBody = new MDM2_EntityCreatedBodyID_Edit();

                            if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                            {
                                //处理0006的实体
                                clsBody.Conn = conn;
                                clsBody.hzyMessage = hzyMessage;
                                clsBody.MDMClass = strMDM_Class_0006;
                                clsBody.Execute();
                                strBody_id_0006 = clsBody.BodyID;

                                if (strBody_id_0006 == "")
                                {
                                    throw new Exception("BodyID_0006创建失败！");
                                }

                                strBody_id_L0013 = "";

                                //生成新的店铺编码
                                bIsInsert = true;
                                if (strAutoCode == "0")
                                {
                                    str店铺ID = dt_List.Rows[j]["店铺ID"].ToString();
                                }
                                else
                                {
                                    str店铺ID = GetDepotID(strBody_id_L0006, conn);
                                }
                            }
                            else if (strBody_id_0006 != "" && strBody_id_L0013 != "") //更新
                            {
                                if (strAutoCode == "0" && dt_List.Columns.Contains("店铺id"))
                                {
                                    str店铺ID = dt_List.Rows[j]["店铺id"].ToString();
                                }
                                //核对0006是否存在
                                MDM2_BodyIDCheck clsCheck = new MDM2_BodyIDCheck();
                                clsCheck.hzyMessage = this.hzyMessage;
                                clsCheck.MDMClass = strMDM_Class_0006;
                                clsCheck.Body_ID = strBody_id_0006;
                                clsCheck.Conn = conn;
                                if (clsCheck.Execute() == false)
                                {
                                    throw new Exception("Body_id_0006信息不正确！");
                                }

                                //核对L0013是否存在
                                clsCheck.hzyMessage = this.hzyMessage;
                                clsCheck.MDMClass = strMDM_LinkClass;
                                clsCheck.Body_ID = strBody_id_L0013;
                                clsCheck.Conn = conn;
                                if (clsCheck.Execute() == false)
                                {
                                    throw new Exception("Body_id_L0013信息不正确！");
                                }

                                 if (strBody_id_L0006 == null)
                                 {
                                     strBody_id_L0006 = conn.GetDataTableFirstValue(@"SELECT Body_id_L0006 FROM MDM_Market2.dbo.V_L0013
                                                    WHERE body_id='" + strBody_id_L0013 + @"'
                                                    ").ToString();
                                 }
                                 if (strBody_id_L0011 == null)
                                 {
                                     strBody_id_L0011 = conn.GetDataTableFirstValue(@"SELECT Body_id_L0011 FROM MDM_Market2.dbo.V_L0013
                                                    WHERE body_id='" + strBody_id_L0013 + @"'
                                                    ").ToString();
                                 }

                                 if (strBody_id_L0014 == null)
                                 {
                                     strBody_id_L0014 = conn.GetDataTableFirstValue(@"SELECT Body_id_L0014 FROM MDM_Market2.dbo.V_L0013
                                                    WHERE body_id='" + strBody_id_L0013 + @"'
                                                    ").ToString();
                                 }
                            
                            }
                            else
                            {
                                throw new Exception("传入的参数有误，如果反复出现，请重新登录！");
                            }


                            //处理L0013的实体
                            clsBody.MDMClass = strMDM_LinkClass;
                            clsBody.BodyID = strBody_id_L0013;
                            clsBody.LinkBodyIDList = strBody_id_0006 + "," + strBody_id_L0006 + "," + strBody_id_L0011 + "," + strBody_id_L0014;
                            clsBody.Execute();
                            strBody_id_L0013 = clsBody.BodyID;

                            MDM2_EntityPropertyValue_Edit clsProperty = new MDM2_EntityPropertyValue_Edit();

                            string strAMMessage = "";
                            DataTable dtAMList = new DataTable();
                            //插入店铺编号
                            if (bIsInsert == true)
                            {
                                clsProperty.Conn = conn;
                                clsProperty.hzyMessage = hzyMessage;
                                clsProperty.MDMClass = strMDM_Class_0006;
                                clsProperty.ExpressionName = "CN";
                                clsProperty.PropertyName = "店铺ID";
                                clsProperty.BodyID = strBody_id_0006;
                                clsProperty.PropertyValue = str店铺ID;
                                if (clsProperty.Execute() == false)
                                {
                                    throw new Exception("修改失败，" + clsProperty.Message);
                                }

                                //如果是新增店铺，需要发送小翅膀提醒
                                string strDepotName = "";
                                if (dt_List.Columns.Contains("店铺名称"))
                                {
                                    strDepotName = str店铺ID + " " + dt_List.Rows[j]["店铺名称"].ToString();
                                }
                                else
                                {
                                    strDepotName = str店铺ID;
                                }

                                dtAMList = conn.GetDataTable("SELECT * FROM CFG_AM_Send WHERE CFG_Type='新开店提醒'");
                                for (int amrows = 0; amrows < dtAMList.Rows.Count; amrows++)
                                {
                                    dtAMList.Rows[amrows]["AM_Message"] = dtAMList.Rows[amrows]["AM_Message"].ToString().Replace("[@店铺信息]", strDepotName);
                                }
                            }
                            else
                            {
                                if (dt_List.Columns.Contains("拓展类型"))
                                {

                                    string str拓展类型 = dt_List.Rows[j]["拓展类型"].ToString();
                                    string strDepotName = Get拓展类型Changed(strBody_id_0006, str拓展类型, conn);
                                    if (strDepotName != "")
                                    {
                                        dtAMList = conn.GetDataTable("SELECT * FROM CFG_AM_Send WHERE CFG_Type='拓展类型改变'");
                                        for (int amrows = 0; amrows < dtAMList.Rows.Count; amrows++)
                                        {
                                            dtAMList.Rows[amrows]["AM_Message"] = dtAMList.Rows[amrows]["AM_Message"].ToString().Replace("[@店铺信息]", strDepotName).Replace("[@拓展类型]", str拓展类型);
                                        }
                                    }
                                }
                            }

                            for (int k = 0; k < dt_List.Columns.Count; k++)
                            {
                                string strColumnName = dt_List.Columns[k].ColumnName;

                                if (strColumnName.ToUpper() == "店铺ID")
                                {
                                    if (bIsInsert == false && strAutoCode != "0")
                                    {
                                        continue;
                                    }
                                    else
                                    {
                                        dt_List.Rows[j][k] = str店铺ID;

                                    }
                                }

                                if (dtPorperty.Select("Property_Name='" + strColumnName + "'").Length == 0)
                                {
                                    continue;
                                }

                                clsProperty.Conn = conn;
                                clsProperty.hzyMessage = hzyMessage;
                                clsProperty.MDMClass = strMDM_Class_0006;
                                clsProperty.ExpressionName = "CN";
                                clsProperty.PropertyName = strColumnName;
                                clsProperty.BodyID = strBody_id_0006;
                                clsProperty.PropertyValue = dt_List.Rows[j][k].ToString();
                                if (clsProperty.Execute() == false)
                                {
                                    throw new Exception("修改失败，" + clsProperty.Message);
                                }
                            }


                            for (int amRowIndex = 0; amRowIndex < dtAMList.Rows.Count; amRowIndex++)
                            {
                                AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
                                string strResult = msg.SendSubjectMsg("AM", "MDM", "MDM", dtAMList.Rows[amRowIndex]["AM_Receiver"].ToString(), "信息部服务中心", dtAMList.Rows[amRowIndex]["AM_Message"].ToString(), DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");

                            }
                        }
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        for (int rowIndex = 0; rowIndex < dt_List.Rows.Count; rowIndex++)
                        {
                            string strBody_id_L0013 = dt_List.Rows[rowIndex]["body_id"].ToString();
                            string strBody_ID_0006 = conn.GetDataTableFirstValue("select body_id_0006 from MDM_L0013_B where Body_id=@param0", new string[1] { strBody_id_L0013 }).ToString();

                            MDM2_EntityDeleteBodyID_Edit clsDelete = new MDM2_EntityDeleteBodyID_Edit();
                            clsDelete.Conn = conn;
                            clsDelete.hzyMessage = hzyMessage;

                            //删除店铺数据
                            if (strBody_ID_0006 != "")
                            {
                                clsDelete.MDMClass = strMDM_Class_0006;
                                clsDelete.BodyID = strBody_ID_0006;

                                if (clsDelete.Execute() == false)
                                {
                                    throw new Exception("删除失败。");
                                }
                            }

                            //删除主数据
                            clsDelete.MDMClass = strMDM_LinkClass;
                            clsDelete.BodyID = strBody_id_L0013;

                            if (clsDelete.Execute() == false)
                            {
                                throw new Exception("删除失败。");
                            }
                        }
                    }

                }

                dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                ds_Return.Tables.Add(dt_EditResult);

                if (bRollBack)
                {
                    conn.CommitTransaction();
                }

                return ds_Return;
            }
            catch
            {
                if (bRollBack)
                {
                    conn.RollbackTransaction();
                }
                throw;

            }


        }

        public string Get拓展类型Changed(string strBody_Id_0006, string str拓展类型, Dbconn conn)
        {
            string strDepotName = conn.GetDataTableFirstValue(@"SELECT 店铺ID +' '+ isnull(店铺名称,'') as 店铺名称 FROM MDM_Market2.dbo.MKT_0006
                                                    WHERE body_id='" + strBody_Id_0006 + @"'
                                                    AND 拓展类型 <> '" + str拓展类型 + "'").ToString();

            return strDepotName;
        }

        public string GetDepotID(string strBody_Id_L0006, Dbconn conn)
        {
            string strCode = "";

            string str = conn.GetDataTableFirstValue(@"SELECT MAX(店铺ID) FROM MDM_Market2.dbo.V_L0013
                                                    WHERE body_id_L0006='" + strBody_Id_L0006 + @"'
                                                    AND 店铺ID not like 'shop%'").ToString();

            if (str == "")
            {
                str = conn.GetDataTableFirstValue(@"SELECT 加盟商编码 FROM MDM_Market2.dbo.V_L0006
                                                    WHERE body_id='" + strBody_Id_L0006 + "'").ToString();
                if (str == "")
                {
                    throw new Exception("加盟商编码没有设置，请先设置加盟商编码");
                }

                if (str.Length == 5)
                {
                    strCode = str + "000";
                }
                else if (str.Length == 6)
                {
                    strCode = str + "00";
                }

            }
            else
            {
                strCode = str.Substring(0, 5) + (Convert.ToInt32(str.Substring(5)) + 1).ToString("000");
            }

            return strCode;
        }
    }

}