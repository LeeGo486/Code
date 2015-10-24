using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.WS.MDM2;
using HZY.COM.Common.Base;

/// 类名：CM_Depot_Opration_History
/// 类说明：编辑渠道店铺装修历史记录
/// 创建人：马卫清
/// 创建日期：2013-12-23
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.CM
{
    class CM_Depot_Opration_History : LogicBase, ILogicGetData
    {
        public CM_Depot_Opration_History()
        {
            this.m_SessionCheck = true;

        }


        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private string m_OldAutoId = "";
        private string m_Body_ID_0006 = "";
        private string m_Body_ID_l0006 = "";
        private string m_Body_ID_l0011 = "";
        private string m_Body_ID_l0014 = "";

        /// <summary>
        /// 编辑渠道店铺装修历史记录
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("MDM");
            Dbconn conn_MDM = new Dbconn("MDM_Master2");

            DataSet ds_Return = new DataSet();
            string strXML = "";

            strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

            if (strXML == "")
            {
                throw new Exception("提交的XML为空！");
            }

            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);

            DataTable dt_OPTYPE = dsXML.Tables["OPTYPE"];



            for (int i = 0; i < dt_OPTYPE.Rows.Count; i++)
            {
                DataTable dt_List = dsXML.Tables[Common.Common.GetListTableName(i)];
                if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE"
                    )
                {
                    conn.LockTableList.Add("CM_Depot_Opration_History");
                    conn.BeginTransaction();
                    conn_MDM.BeginTransaction();
                    try
                    {
                        for (int j = 0; j < dt_List.Rows.Count; j++)
                        {
                            string strBody_id = dt_List.Rows[j]["body_id"].ToString();
                            string str合同面积 = dt_List.Rows[j]["合同面积"].ToString();
                            string str楼层 = dt_List.Rows[j]["楼层"].ToString();
                            string str地址 = dt_List.Rows[j]["地址"].ToString();
                            string str商务状态 = dt_List.Rows[j]["商务状态"].ToString();
                            string str拓展类型 = dt_List.Rows[j]["拓展类型"].ToString();

                            if (strBody_id == "" || str商务状态 == "" || str拓展类型 == "")
                            {

                                throw new Exception("Body_id,商务状态,拓展类型不能为空");
                            }

                            //获取MDM当前的数据
                            DataTable dt_ResposeGet = this.GetMDMData(strBody_id);

                            //设置CM的数据
                            DataSet ds_CM = SetCMData(strBody_id, conn, dt_ResposeGet, dt_List, j);

                            //更新CM
                            UpdateCMData(conn, ds_CM.Tables[0]);

                            //更新MDM
                            UpdateMDMData(conn_MDM, dt_List, j);
                        }

                        dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                        ds_Return.Tables.Add(dt_EditResult);
                        conn.CommitTransaction();
                        conn_MDM.CommitTransaction();
                    }
                    catch
                    {
                        conn.RollbackTransaction();
                        conn_MDM.RollbackTransaction();
                        throw;
                    }
                }
                else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET"
                    )
                {
                    int nPage = 1;
                    int nPageRowCount = 20;
                    string strOrder = " desc  ";
                    string strSort = " J_DEPOTID ";
                    string strWhere = " 1=1 ";
                    string strSearchFilter = " ";

                    if (m_request != null && m_request.Tables[0].Columns.Contains("page"))
                    {
                        nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                        nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                        strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                        strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                        strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;

                        if (m_request.Tables[0].Columns.Contains("searchFilter"))
                        {
                            strSearchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : strSearchFilter;
                        }
                        if (strWhere.Trim() != "")
                        {
                            strWhere += " AND " + strWhere;
                        }

                        if (strSearchFilter.Trim() != "")
                        {
                            strWhere += " AND " + strSearchFilter;
                        }
                    }

                    ds_Return = conn.GetDataSetForPageList("SELECT * FROM CM_Depot_Opration_History WHERE " + strWhere, new string[] { }, nPage, nPageRowCount, strSort + " " + strOrder);

                }
            }




            return ds_Return;
        }

        private void UpdateMDMData(Dbconn conn, DataTable dt, int rowIndex)
        {
            string strXMLGetData = "<Root><OPTYPE>UPDATE</OPTYPE><List><Rows>"
                  + "<合同面积>" + dt.Rows[rowIndex]["合同面积"].ToString() + "</合同面积>"
                  + "<楼层>" + dt.Rows[rowIndex]["楼层"].ToString() + "</楼层>"
                  + "<地址>" + dt.Rows[rowIndex]["地址"].ToString() + "</地址>"
                  + "<商务状态>" + dt.Rows[rowIndex]["商务状态"].ToString() + "</商务状态>"
                  + "<拓展类型>" + dt.Rows[rowIndex]["拓展类型"].ToString() + "</拓展类型>"
                  + "<body_id>" + dt.Rows[rowIndex]["body_id"].ToString() + "</body_id>"
                  + "<body_id_0006>" + m_Body_ID_0006 + "</body_id_0006>"
                  + "<body_id_l0006>" + m_Body_ID_l0006 + "</body_id_l0006>"
                  + "<body_id_l0011>" + m_Body_ID_l0011 + "</body_id_l0011>"
                  + "<body_id_l0014>" + m_Body_ID_l0014 + "</body_id_l0014>"
                  + "</Rows></List></Root>";

            DataSet ds = Common.Common.GetRequestDataSet(new string[] { "XML", "AutoCode" }, new string[] { strXMLGetData, "1" });
            MDM2_Depot_Edit cls = new MDM2_Depot_Edit();
            cls.hzyMessage = this.hzyMessage;
            cls.Conn = conn;
            cls.Request = ds;
            cls.GetData();
        }


        private void UpdateCMData(Dbconn conn, DataTable dt_CMData)
        {
            //更新旧数据
            if (m_OldAutoId != "")
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("IsHistory");
                dt.Rows.Add(new object[] { "1" });
                conn.Update("CM_Depot_Opration_History", dt, "autoid =" + m_OldAutoId);
            }

            //插入新数据
            conn.Insert("CM_Depot_Opration_History", dt_CMData);
        }

        private DataSet SetCMData(string strBody_Id, Dbconn conn, DataTable dtMDM, DataTable dt, int rowIndex)
        {
            DataSet ds = new DataSet();
            ds = conn.GetDataSet("SELECT * FROM CM_Depot_Opration_History WHERE body_id='" + strBody_Id + "' and Ishistory=0");
            ds.Tables[0].TableName = "old";

            DataRow dr = null;
            if (ds.Tables[0].Rows.Count > 0)
            {
                m_OldAutoId = ds.Tables[0].Rows[0]["AutoID"].ToString();

                dr = ds.Tables[0].Rows[0];

            }
            else
            {
                dr = ds.Tables[0].NewRow();

            }
            ds.Tables[0].Columns.Remove("AutoID");

            m_Body_ID_0006 = dtMDM.Rows[0]["body_id_0006"].ToString();
            m_Body_ID_l0006 = dtMDM.Rows[0]["body_id_l0006"].ToString();
            m_Body_ID_l0011 = dtMDM.Rows[0]["body_id_l0011"].ToString();
            m_Body_ID_l0014 = dtMDM.Rows[0]["body_id_l0014"].ToString();

            dr["body_id"] = dtMDM.Rows[0]["body_id"].ToString();
            dr["J_DEPOTID"] = dtMDM.Rows[0]["店铺id"].ToString();
            dr["J_NAME"] = dtMDM.Rows[0]["店铺名称"].ToString();
            dr["J_DQ"] = dtMDM.Rows[0]["所属大区"].ToString();
            dr["J_FORM"] = dtMDM.Rows[0]["店铺型态"].ToString();
            dr["J_FREEZE"] = dtMDM.Rows[0]["冻结状态"].ToString();
            dr["b_designing"] = dtMDM.Rows[0]["店铺定位"].ToString();
            dr["b_properties"] = dtMDM.Rows[0]["店铺性质"].ToString();
            dr["B_CHANNEL"] = dtMDM.Rows[0]["渠道类型"].ToString();
            dr["G_SF"] = dtMDM.Rows[0]["省份"].ToString();
            dr["G_CS"] = dtMDM.Rows[0]["城市"].ToString();
            dr["G_QX"] = dtMDM.Rows[0]["区县"].ToString();
            dr["G_CZ"] = dtMDM.Rows[0]["城市定义"].ToString();

            dr["tzlx"] = dt.Rows[rowIndex]["拓展类型"].ToString();
            dr["b_htarea"] = dt.Rows[rowIndex]["合同面积"].ToString();
            dr["P_LC"] = dt.Rows[rowIndex]["楼层"].ToString();
            dr["G_ADDRESS"] = dt.Rows[rowIndex]["地址"].ToString();
            dr["B_STATE"] = dt.Rows[rowIndex]["商务状态"].ToString();

            dr["oprationTime"] = DateTime.Now;
            dr["oprationUser"] = hzyMessage.User_Name;
            dr["IsHistory"] = 0;

            if (ds.Tables[0].Rows.Count == 0)
            {
                ds.Tables[0].Rows.Add(dr);
            }

            return ds;
        }

        private DataTable GetMDMData(string strBody_ID)
        {
            string strXMLGetData = "<Root><OPTYPE>GET</OPTYPE><List ><Rows><TableName>V_L0013</TableName></Rows></List></Root>";
            DataSet ds_RequestGet = new DataSet();
            DataTable dt_RequestGet = new DataTable();
            dt_RequestGet.Columns.Add("XML");
            dt_RequestGet.Columns.Add("Where");
            dt_RequestGet.Rows.Add(new object[] { strXMLGetData, "body_id='" + strBody_ID + "'" });
            ds_RequestGet.Tables.Add(dt_RequestGet);

            MDM2.MDM2_GetEntityBYName clsGet = new MDM2.MDM2_GetEntityBYName();
            clsGet.hzyMessage = this.hzyMessage;
            clsGet.Request = ds_RequestGet;
            DataSet ds_ResponseGet = clsGet.GetData();
            DataTable dt_ResponseGet = ds_ResponseGet.Tables[0];

            if (dt_ResponseGet.Rows.Count == 0)
            {
                throw new Exception("需要修改的行数据已经删除，请刷新后重试！");
            }

            return dt_ResponseGet;
        }
    }


}
