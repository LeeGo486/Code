using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_Lib_AUZ_Property_GetListBySessionIDForStoreFM
/// 类说明：获取SessionID获取MKT的权限表供店铺MDM使用
/// 创建人：马卫清
/// 创建日期：2013-09-05
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 获取SessionID获取MKT的权限表
    /// </summary>
    public class MDM_Lib_AUZ_Property_GetListBySessionIDForStoreFM : LogicBase, ILogicGetData
    {
        public MDM_Lib_AUZ_Property_GetListBySessionIDForStoreFM()
        {
            this.m_SessionCheck = true;

        }

        string m_UpdateAUZ = "";
        string m_ViewAUZ = "";

        /// <summary>
        /// 获取SessionID获取MKT的权限表
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                //先获取属性相关权限
                MDM_Lib_AUZ_Property_GetListBySessionID cls = new MDM_Lib_AUZ_Property_GetListBySessionID();
                cls.Request = this.m_request;
                cls.hzyMessage = this.m_hzyMessage;
                DataSet ds = cls.GetData();

                MDM_Lib_AUZ_Body_GetListBySessionID cls_body = new MDM_Lib_AUZ_Body_GetListBySessionID();
                cls_body.Request = this.m_request;
                cls_body.hzyMessage = this.hzyMessage;
                DataSet ds_body = cls_body.GetData();
                string strView = "";
                string strUpdate = "";
                string strInsert = "";
                for (int i = 0; i < ds_body.Tables[0].Rows.Count; i++)
                {
                    if (ds_body.Tables[0].Rows[i]["Main_Entity"].ToString() == "L0013")
                    {
                        switch (ds_body.Tables[0].Rows[i]["Entity"].ToString())
                        {
                            case "0006":
                                if (ds_body.Tables[0].Rows[i]["Insert_AUZ"].ToString() == "1")
                                {
                                    strInsert = "允许";
                                }
                                break;
                            case "0001":
                                if (ds_body.Tables[0].Rows[i]["Update_AUZ"].ToString() == "1")
                                {
                                    strUpdate += "【公司中文简称】";
                                    strView += "【公司中文简称】"; 
                                }
                                else if (ds_body.Tables[0].Rows[i]["ViewAUZ"].ToString() == "1")
                                {
                                    strView += "【公司中文简称】";
                                }
                                break;
                            case "0010":
                                if (ds_body.Tables[0].Rows[i]["Update_AUZ"].ToString() == "1")
                                {
                                    strUpdate += "【加盟商编码】";
                                    strView += "【加盟商编码】";
                                }
                                else if (ds_body.Tables[0].Rows[i]["ViewAUZ"].ToString() == "1")
                                {
                                    strView += "【加盟商编码】";
                                }
                                break;

                            case "L0011":
                                if (ds_body.Tables[0].Rows[i]["Update_AUZ"].ToString() == "1")
                                {
                                    strUpdate += "【县级市编号】";
                                    strView += "【县级市编号】";
                                }
                                else if (ds_body.Tables[0].Rows[i]["ViewAUZ"].ToString() == "1")
                                {
                                    strView += "【县级市编号】";
                                }
                                break;
                            case "L0014":                                
                                if (ds_body.Tables[0].Rows[i]["Update_AUZ"].ToString() == "1")
                                {
                                    strUpdate += "【销售大区名称】";
                                    strView += "【销售大区名称】";
                                }
                                else if (ds_body.Tables[0].Rows[i]["ViewAUZ"].ToString() == "1")
                                {
                                    strView += "【销售大区名称】";
                                }
                                break;
                        }
                    }
                }

                //dt.Rows.Add(new object[] { "查看", hzyMessage.User_Name, strView });
                //dt.Rows.Add(new object[] { "保存", hzyMessage.User_Name, strUpdate });

                //returnDs.Tables.Add(dt);
                ds.Tables[0].Rows[0]["列名"] += strView;
                ds.Tables[0].Rows[1]["列名"] += strUpdate;
                ds.Tables[0].Rows.Add(new object[] { "新增", hzyMessage.User_Name, strInsert });
                return ds;
            }
            catch
            {
                throw;

            }



        }



    }

}