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


/// 类名：MDM_Entity_EditBySaleAreaMarket 
/// 类说明：根据MDM销售大区来编辑Entity
/// 创建人：马卫清
/// 创建日期：2013-07-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    ///MDM_Entity_EditBySaleAreaMarket 根据MDM销售大区来编辑Entity
    /// </summary>
    public class MDM_Entity_EditBySaleAreaMarket : LogicBase, ILogicGetData
    {
        public MDM_Entity_EditBySaleAreaMarket()
        {
            this.m_SessionCheck = false;
        }

        /// <summary>
        /// 根据MDM销售大区来编辑Entity
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("MDM_Master");

            try
            {
                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                string strEntityCode = "0018";
                string strMarketTableName = "SaleArea_For_FM";

                DataSet ds = Common.Common.GetDSByExcelXML(strXML);

                //获取销售大区的所有属性
                MDM_Entity_Market_PropertyList clsPropertyList = new MDM_Entity_Market_PropertyList();
                clsPropertyList.Request = Common.Common.GetRequestDataSet(new string[2] { "Entity", "MarketTableName" }, new string[2] { strEntityCode, strMarketTableName });
                DataTable dt_PropertyList = clsPropertyList.GetData().Tables[0];

                //修改销售大区数据
                DataTable dtSaleArea = new DataTable(strEntityCode);
                dtSaleArea.Namespace = "CN"; //定义表达方式

                DataTable dtSaleAreaLink = new DataTable("L0014");
                dtSaleAreaLink.Namespace = "CN"; //定义表达方式

                dtSaleAreaLink.Columns.Add("Body_ID");
                dtSaleAreaLink.Columns.Add("Body_ID_0008");
                dtSaleAreaLink.Columns.Add("Body_ID_0018");

                bool bCreateTable = true;

                for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                {
                    DataRow dr = dtSaleArea.NewRow();
                    DataRow drLink = dtSaleAreaLink.NewRow();

                    //drLink["body_ID"] = ds.Tables["LIST"].Rows[i]["body_ID"].ToString();
                    drLink["Body_ID_0008"] = ds.Tables["LIST"].Rows[i]["Body_ID_0008"].ToString();
                    
                    if (drLink["Body_ID_0008"].ToString() == "")
                    {
                        throw new Exception("店铺品牌的Body_ID不能为空！");
                    }
                    dtSaleAreaLink.Rows.Add(drLink);


                    if (bCreateTable)
                    {
                        dtSaleArea.Columns.Add("body_ID");
                    }


                    dr["body_ID"] = ds.Tables["LIST"].Rows[i]["body_ID_0018"].ToString();
                    for (int j = 0; j < ds.Tables["LIST"].Columns.Count; j++)
                    {
                        string strColumnName = ds.Tables["LIST"].Columns[j].ColumnName;

                        //如果修改的列是属于品牌信息的话,要对品牌的Entity进行修改
                        DataRow[] drList = dt_PropertyList.Select("Table_Property_Name = '" + strColumnName + "'");
                        if (drList.Length > 0)
                        {
                            string strPorpertyname = drList[0]["Porperty_Name"].ToString();

                            if (bCreateTable)
                            {
                                dtSaleArea.Columns.Add(strPorpertyname);
                            }
                            dr[strPorpertyname] = ds.Tables["LIST"].Rows[i][j].ToString();

                        }
                    }

                    dtSaleArea.Rows.Add(dr);
                    bCreateTable = false;

                }

                DataSet dsRequest = new DataSet();
                dsRequest.Tables.Add(dtSaleArea);

                MDM_Entity_Edit cls_Entity_Edit = new MDM_Entity_Edit();
                cls_Entity_Edit.Request = dsRequest;
                cls_Entity_Edit.GetDataByRequestDs = true;
                cls_Entity_Edit.Execute();

                ArrayList listBody_0018 = cls_Entity_Edit.BodyID; //获取品牌的BODYID

                //修改LINK数据
                for (int i = 0; i < listBody_0018.Count; i++)
                {
                    dtSaleAreaLink.Rows[i]["Body_ID_0018"] = listBody_0018[i].ToString();

                    //到表里查找Link的BodyID
                    string strSQL = "SELECT Body_ID FROM MDM_L0014_B WHERE Body_ID_0018='" + listBody_0018[i].ToString() + "'";
                    string strLinkBodyID = conn.GetDataTableFirstValue(strSQL).ToString();

                    dtSaleAreaLink.Rows[i]["Body_ID"] = strLinkBodyID;


                }
                dsRequest.Clear();
                dsRequest.Tables.Add(dtSaleAreaLink);
                cls_Entity_Edit.Request = dsRequest;
                cls_Entity_Edit.Execute();
                ArrayList listBody = cls_Entity_Edit.BodyID;
                string strMessage = "影响的行数为:" + listBody.Count.ToString() +"行" ;
                for (int i = 0; i < listBody.Count; i++)
                {
                    strMessage += ";" + listBody[i].ToString();
                }
                return Common.Common.GetRequestDataSet(new string[2] { "result", "Message" }, new string[2] { "true", strMessage });
            }
            catch
            {

                throw;
            }
        }

    }


}