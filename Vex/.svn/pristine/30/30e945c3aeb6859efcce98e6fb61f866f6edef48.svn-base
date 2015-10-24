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


/// 类名：MDM_Entity_EditByMerchantMarket 
/// 类说明：根据MDM加盟商信息来编辑Entity
/// 创建人：马卫清
/// 创建日期：2013-07-10
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    ///MDM_Entity_EditByStoreMarket 根据MDM加盟商信息来编辑Entity
    /// </summary>
    public class MDM_Entity_EditByMerchantMarket : LogicBase, ILogicGetData
    {
        public MDM_Entity_EditByMerchantMarket()
        {
            this.m_SessionCheck = false;
        }


        private ArrayList m_MaxCode = new ArrayList();
        private ArrayList m_MaxCodeName = new ArrayList();

        /// <summary>
        /// 根据MDM加盟商信息来编辑Entity
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("MDM_Master");

            try
            {
                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                string strStoreEntityCode = "0010";
                string strMarketTableName = "Merchant_For_FM";

                DataSet ds = Common.Common.GetDSByExcelXML(strXML);
                               
                //判断Link是否需要修改

                //获取加盟商的所有属性
                MDM_Entity_Market_PropertyList clsPropertyList = new MDM_Entity_Market_PropertyList();
                clsPropertyList.Request = Common.Common.GetRequestDataSet(new string[2] { "Entity", "MarketTableName" }, new string[2] { strStoreEntityCode, strMarketTableName });
                DataTable dt_PropertyList = clsPropertyList.GetData().Tables[0];

                //修改加盟商数据
                string strUpdateXML = "<table Entity=\"" + strStoreEntityCode + "\" Expression=\"CN\">";

                int nMaxCode = 0;


                for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                {

                    strUpdateXML += "<row>";
                    strUpdateXML += "<body_ID>" + ds.Tables["LIST"].Rows[i]["body_ID"].ToString() + "</body_ID>";

                    //新增
                    if (ds.Tables["LIST"].Rows[i]["body_ID"].ToString() == "")
                    {
                        //判断公司
                        string strComCode = GetComCode(ds.Tables["LIST"].Rows[i]["公司"].ToString());

                        if (strComCode == "")
                        {
                            throw new Exception("公司不正确。");
                        }


                        string strCode = "";


                        string strMaxCode = "";

                        if (m_MaxCodeName.Contains(strComCode))
                        {
                            strMaxCode = m_MaxCode[m_MaxCodeName.IndexOf(strComCode)].ToString();
                        }
                        else
                        {
                            strMaxCode = conn.GetDataTableFirstValue(@"
                                        SELECT  MAX(Value_Text) AS code
                                        FROM    [dbo].[Lib_ExdPropertyList] t1 
                                                LEFT JOIN dbo.MDM_0010_E t2 ON t1.Property_ID = t2.Property_ID
                                        WHERE   Class_name = '0010' AND property_name = '加盟商编码' AND Body_ID IN (
                                                SELECT  t2.Body_ID
                                                FROM    [dbo].[Lib_ExdPropertyList] t1
                                                        LEFT JOIN dbo.MDM_0010_E t2 ON t1.Property_ID = t2.Property_ID
                                                WHERE   Property_Name = '公司' AND t2.Value_Text = '" + ds.Tables["LIST"].Rows[i]["公司"].ToString() + @"' )
                            ").ToString();

                        }


                        if (strMaxCode == "" || strMaxCode == strComCode + "0001")
                        {
                            strCode = strComCode + "1000";
                        }
                        else
                        {
                            strCode = strComCode + (Convert.ToInt32(strMaxCode.Substring(1)) + 1).ToString();
                        }

                        if (m_MaxCodeName.Contains(strComCode))
                        {
                            m_MaxCode[m_MaxCodeName.IndexOf(strComCode)] = strCode;
                        }
                        else
                        {
                            m_MaxCode.Add(strCode);
                            m_MaxCodeName.Add(strComCode);
                        }

                        ds.Tables["LIST"].Rows[i]["加盟商编码"] = strCode;
                    }


                    for (int j = 0; j < ds.Tables["LIST"].Columns.Count; j++)
                    {
                        string strColumnName = ds.Tables["LIST"].Columns[j].ColumnName;

                        //如果修改的列是属于加盟商信息的话,要对加盟商的Entity进行修改
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


        #region GetComCode 获取公司前缀
        /// <summary>
        /// 获取公司前缀
        /// </summary>
        /// <returns></returns>
        private string GetComCode(string strCom)
        {
            string strReturn = "";

            switch (strCom)
            {
                case "雅莹":
                    strReturn = "E";
                    break;
                case "贝爱":
                    strReturn = "D";
                    break;
                case "纳卉":
                    strReturn = "N";
                    break;
                case "雅斓":
                    strReturn = "G";
                    break;
                case "泓雅":
                    strReturn = "H";
                    break;
                case "维姬":
                    strReturn = "W";
                    break;
                case "卓莱雅":
                    strReturn = "J";
                    break;
            }

            return strReturn;
        }
        #endregion
    }


}