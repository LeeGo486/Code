using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using System.Xml;
using HZY.COM.Common.Base;


/// 类名：MDM_Entity_EditByAreaMarket 
/// 类说明：根据MDM国家区域信息来编辑Entity
/// 创建人：马卫清
/// 创建日期：2013-07-13
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    ///MDM_Entity_EditByAreaMarket 根据MDM国家区域信息来编辑Entity
    /// </summary>
    public class MDM_Entity_EditByAreaMarket : LogicBase, ILogicGetData
    {
        public MDM_Entity_EditByAreaMarket()
        {
            this.m_SessionCheck = false;
        }

        private string m_EntityCode_S = "";
        private string m_EntityCode_P = "";
        private string m_MKTTableName = "";
        private string m_LinkEntityCode = "";

        /// <summary>
        ///  根据MDM国家区域信息来编辑Entity
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("MDM_Master");

            try
            {
                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

               
                DataSet ds = Common.Common.GetDSByExcelXML(strXML);

                GetEntityCode(ds);

                if (m_EntityCode_S == "")
                {
                    return new DataSet();
                }

                ds.Tables["LIST"].Columns.Remove("type");


                //获所有属性
                MDM_Entity_Market_PropertyList clsPropertyList = new MDM_Entity_Market_PropertyList();
                clsPropertyList.Request = Common.Common.GetRequestDataSet(new string[2] { "Entity", "MarketTableName" }, new string[2] { m_EntityCode_S, m_MKTTableName });
                DataTable dt_PropertyList = clsPropertyList.GetData().Tables[0];

                //修改国家数据
                string strUpdateXML = "<table Entity=\"" + m_EntityCode_S + "\" Expression=\"CN\">";

                for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                {

                    strUpdateXML += "<row>";
                    strUpdateXML += "<body_ID>" + ds.Tables["LIST"].Rows[i]["body_ID_" + m_EntityCode_S].ToString() + "</body_ID>";

                    for (int j = 0; j < ds.Tables["LIST"].Columns.Count; j++)
                    {
                        string strColumnName = ds.Tables["LIST"].Columns[j].ColumnName;

                        //如果修改的列是属于国家信息的话,要对洲的Entity进行修改
                        DataRow[] drList = dt_PropertyList.Select("Table_Property_Name = '" + strColumnName + "'");
                        if (drList.Length > 0)
                        {
                            string strPorpertyname = drList[0]["Porperty_Name"].ToString();
                            strUpdateXML += "<" + strPorpertyname + ">" + ds.Tables["LIST"].Rows[i][j].ToString() + "</" + strPorpertyname + ">";

                        }
                    }
                    strUpdateXML += "</row>";

                }
                strUpdateXML += "</table>";

                MDM_Entity_Edit cls_Entity_Edit = new MDM_Entity_Edit();
                cls_Entity_Edit.Request = Common.Common.GetRequestDataSet(new string[1] { "XML" }, new string[1] { strUpdateXML });
                cls_Entity_Edit.Execute();
                ArrayList alBodyID = cls_Entity_Edit.BodyID;

                //修改国家与洲的Link
                strUpdateXML = "<table Entity=\"" + m_LinkEntityCode + "\" Expression=\"CN\">";

                for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                {
                    //获取国家的bodyid
                    string strBodyID = alBodyID[i].ToString();
                    
                    //到表里查找Link的BodyID
                    string strSQL = "SELECT Body_ID FROM MDM_" + m_LinkEntityCode + "_B WHERE Body_ID_" + m_EntityCode_S + "='" + strBodyID + "'";
                    string strLinkBodyID = conn.GetDataTableFirstValue(strSQL).ToString();

                    strUpdateXML += "<row>";
                    strUpdateXML += "<body_ID>" + strLinkBodyID + "</body_ID>";
                    strUpdateXML += "<body_ID_" + m_EntityCode_S + ">" + strBodyID + "</body_ID_" + m_EntityCode_S + ">";
                    strUpdateXML += "<body_ID_" + m_EntityCode_P + ">" + ds.Tables["LIST"].Rows[i]["body_ID_" + m_EntityCode_P].ToString() + "</body_ID_" + m_EntityCode_P + ">";

                    strUpdateXML += "</row>";

                }
                strUpdateXML += "</table>";
                cls_Entity_Edit.Request = Common.Common.GetRequestDataSet(new string[1] { "XML" }, new string[1] { strUpdateXML });
                cls_Entity_Edit.Execute();

                return Common.Common.GetRequestDataSet(new string[1] { "result" }, new string[1] { "true" });
            }
            catch
            {

                throw;
            }
        }

        private void GetEntityCode(DataSet ds)
        {
            m_EntityCode_S = "";
            if (ds.Tables["LIST"].Rows.Count > 0)
            {
                if (ds.Tables["LIST"].Rows[0]["type"].ToString() == "国家")
                {
                    m_EntityCode_S = "0012";
                    m_LinkEntityCode = "L0007";
                    m_MKTTableName = "Country_For_FM"; 
                    m_EntityCode_P = "0011";
                }
                else if (ds.Tables["LIST"].Rows[0]["type"].ToString() == "大区")
                {
                    m_EntityCode_P = "0012";
                    m_EntityCode_S = "0013";
                    m_LinkEntityCode = "L0008";
                    m_MKTTableName = "Area_For_FM";

                }
                else if (ds.Tables["LIST"].Rows[0]["type"].ToString() == "省")
                {
                    m_EntityCode_P = "0013";
                    m_EntityCode_S = "0014";
                    m_LinkEntityCode = "L0009";
                    m_MKTTableName = "Province_For_FM";


                }
                else if (ds.Tables["LIST"].Rows[0]["type"].ToString() == "地级市")
                {
                    m_EntityCode_P = "0014";
                    m_EntityCode_S = "0015";
                    m_LinkEntityCode = "L0010";
                    m_MKTTableName = "Prefecture_For_FM";

                }
                else if (ds.Tables["LIST"].Rows[0]["type"].ToString() == "县级市")
                {
                    m_EntityCode_P = "0015";
                    m_EntityCode_S = "0016";
                    m_LinkEntityCode = "L0011"; 
                    m_MKTTableName = "City_For_FM";
                }
                else if (ds.Tables["LIST"].Rows[0]["type"].ToString() == "区")
                {
                    m_EntityCode_P = "0016";
                    m_EntityCode_S = "0017";
                    m_LinkEntityCode = "L0012";
                    m_MKTTableName = "District_For_FM";
                }
            }

        }

    }
}


//示例XML
//<Interface WSID="3ab62c81-17f4-442f-a349-e74c8eaa7595" 
// App="ITSM_EXCEL"  SessionID="">
//<XML><ROOT>
//<OPTYPE>EDIT</OPTYPE>
//<LIST>
//<ROWS>
//<type>国家</type>
//<body_ID_P>上一级也就是洲的BodyID</body_ID_P>
//<body_ID>国家的BodyID,如果是空，就会新增</body_ID>
//<编号>01</编号>
//<名称>亚太区</名称>
//</ROWS>
//</LIST>
//</ROOT></XML>
//</Interface>
