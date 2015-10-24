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


/// 类名：MDM_Entity_EditByContinentMarket 
/// 类说明：根据MDM洲信息来编辑Entity
/// 创建人：马卫清
/// 创建日期：2013-07-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    ///MDM_Entity_EditByContinentMarket 根据MDM洲信息来编辑Entity
    /// </summary>
    public class MDM_Entity_EditByContinentMarket : LogicBase, ILogicGetData
    {
        public MDM_Entity_EditByContinentMarket()
        {
            this.m_SessionCheck = false;
        }

        /// <summary>
        ///  根据MDM洲信息来编辑Entity
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("MDM_Master");

            try
            {
                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                string strStoreEntityCode = "0011";
                string strMarketTableName = "Continent_For_FM";

                DataSet ds = Common.Common.GetDSByExcelXML(strXML);

                //获取洲的所有属性
                MDM_Entity_Market_PropertyList clsPropertyList = new MDM_Entity_Market_PropertyList();
                clsPropertyList.Request = Common.Common.GetRequestDataSet(new string[2] { "Entity", "MarketTableName" }, new string[2] { strStoreEntityCode, strMarketTableName });
                DataTable dt_PropertyList = clsPropertyList.GetData().Tables[0];

                //修改洲数据
                string strUpdateXML = "<table Entity=\"" + strStoreEntityCode + "\" Expression=\"CN\">";

                for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                {

                    strUpdateXML += "<row>";
                    strUpdateXML += "<body_ID>" + ds.Tables["LIST"].Rows[i]["body_ID"].ToString() + "</body_ID>";

                    for (int j = 0; j < ds.Tables["LIST"].Columns.Count; j++)
                    {
                        string strColumnName = ds.Tables["LIST"].Columns[j].ColumnName;

                        //如果修改的列是属于洲信息的话,要对洲的Entity进行修改
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

                return Common.Common.GetRequestDataSet(new string[1] { "result" }, new string[1] { "true" });
            }
            catch
            {

                throw;
            }
        }

    }
}