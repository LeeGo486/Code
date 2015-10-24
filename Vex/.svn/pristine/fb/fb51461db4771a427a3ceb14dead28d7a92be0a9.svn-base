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


/// 类名：MDM_Entity_EditByStoreForFMMarket 
/// 类说明：根据MDM店铺的Market数据来编辑Entity
/// 创建人：马卫清
/// 创建日期：2013-07-17
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    ///MDM_Entity_EditByStoreForFMMarket 根据MDM店铺的Market数据来编辑Entity
    /// </summary>
    public class MDM_Entity_EditByStoreForFMMarket : LogicBase, ILogicGetData
    {
        public MDM_Entity_EditByStoreForFMMarket()
        {
            this.m_SessionCheck = true;
        }

        private ArrayList m_MaxCode = new ArrayList();
        private ArrayList m_MaxCodeName = new ArrayList();

        private DataTable m_Com = null;
        private DataTable m_Merchant = null;
        private DataTable m_City = null;
        private DataTable m_SaleArea = null;

        string strAuzWhere = "";
        string strAuzColumnList = "";


        /// <summary>
        /// 根据MDM店铺的Market数据来编辑Entity
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("MDM_Master");

            try
            {
                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                string strEntityCode = "0006";
                string strMarketTableName = "Store_For_FM";

                DataSet ds = Common.Common.GetDSByExcelXML(strXML);

                //获取店铺的所有属性
                MDM_Entity_Market_PropertyList clsPropertyList = new MDM_Entity_Market_PropertyList();
                clsPropertyList.Request = Common.Common.GetRequestDataSet(new string[2] { "Entity", "MarketTableName" }, new string[2] { strEntityCode, strMarketTableName });
                DataTable dt_PropertyList = clsPropertyList.GetData().Tables[0];

                //修改店铺数据
                DataTable dtStore = new DataTable(strEntityCode);
                dtStore.Namespace = "CN"; //定义表达方式

                DataTable dtStoreLink = new DataTable("L0013");
                dtStoreLink.Namespace = "CN"; //定义表达方式

                dtStoreLink.Columns.Add("Body_ID");
                dtStoreLink.Columns.Add("Body_ID_0001");
                dtStoreLink.Columns.Add("Body_ID_0006");
                dtStoreLink.Columns.Add("Body_ID_0010");
                dtStoreLink.Columns.Add("Body_ID_L0011");
                dtStoreLink.Columns.Add("Body_ID_L0014");

                bool bCreateTable = true;

                GetBaseData(ds.Tables["LIST"]);

                for (int i = 0; i < ds.Tables["LIST"].Rows.Count; i++)
                {
                    DataRow dr = dtStore.NewRow();
                    DataRow drLink = dtStoreLink.NewRow();

                    drLink["body_ID"] = ds.Tables["LIST"].Rows[i]["body_ID"].ToString();

                    DataTable dtLinkOld = new DataTable();
                    string strLinkBody_ID = drLink["body_ID"].ToString().Trim();
                    if (strLinkBody_ID != "")
                    {
                        //获取所有的BODY_ID数据
                        dtLinkOld = conn.GetDataTable(@"SELECT * FROM MDM_L0013_B WHERE Body_ID='"+strLinkBody_ID+"'");
                        if (dtLinkOld.Rows.Count == 0)
                        {
                            throw new Exception("传入的BodyID不正确");
                        }
                    }

                    //取到对应的BodyID
                    if (ds.Tables["LIST"].Columns.Contains("公司中文简称"))
                    {
                        string str公司中文简称 = ds.Tables["LIST"].Rows[i]["公司中文简称"].ToString();
                        if (str公司中文简称 != "")
                        {
                            drLink["Body_ID_0001"] = GetBodyID("公司", "公司中文简称='" + str公司中文简称 + "'");
                        }

                        if (drLink["Body_ID_0001"].ToString() == "")
                        {
                            if (strLinkBody_ID != "")
                            {
                                //如果没有传入公司信息的话，可能是由于用户没有权限，所以使用旧值
                                drLink["Body_ID_0001"] = dtLinkOld.Rows[0]["Body_ID_0001"];
                            }
                            else
                            {
                                //如果是添加状态的话，必须要有BodyID
                                throw new Exception("公司中文简称的信息不正确或者没有权限！");
                            }
                        }
                    }
                    else
                    {
                        if (strLinkBody_ID != "")
                        {
                            //如果没有传入公司信息的话，可能是由于用户没有权限，所以使用旧值
                            drLink["Body_ID_0001"] = dtLinkOld.Rows[0]["Body_ID_0001"];
                        }
                    }

                    if (ds.Tables["LIST"].Columns.Contains("加盟商编码"))
                    {
                        string str加盟商编码 = ds.Tables["LIST"].Rows[i]["加盟商编码"].ToString();
                        if (str加盟商编码 != "")
                        {
                            drLink["Body_ID_0010"] = GetBodyID("加盟商", "加盟商编码='" + str加盟商编码 + "'");
                        }

                        if (drLink["Body_ID_0010"].ToString() == "")
                        {
                            if (strLinkBody_ID != "")
                            {
                                //如果没有传入加盟商信息的话，可能是由于用户没有权限，所以使用旧值
                                drLink["Body_ID_0010"] = dtLinkOld.Rows[0]["Body_ID_0010"];
                            }
                            else
                            {
                                //如果是添加状态的话，必须要有BodyID
                                throw new Exception("加盟商编码的信息不正确或者没有权限！");
                            }
                        }
                    }
                    else
                    {
                        if (strLinkBody_ID != "")
                        {
                            //如果没有传入加盟商信息的话，可能是由于用户没有权限，所以使用旧值
                            drLink["Body_ID_0010"] = dtLinkOld.Rows[0]["Body_ID_0010"];
                        }
                       
                    }
                    string str加盟商Body_id = drLink["Body_ID_0010"].ToString();

                    //添加状态下，如果加盟商编码为空的话，就无法生成POS编号，所以是不允许的
                    if (strLinkBody_ID == "" && str加盟商Body_id == "")
                    {
                        throw new Exception("加盟商编码的信息不正确");
                    }

                    if (ds.Tables["LIST"].Columns.Contains("县级市编号"))
                    {
                        string str县级市 = ds.Tables["LIST"].Rows[i]["县级市编号"].ToString();

                        if (str县级市 != "")
                        {
                            drLink["Body_ID_L0011"] = GetBodyID("县", "县级市编号='" + str县级市 + "'");
                        }

                        if (drLink["Body_ID_L0011"].ToString() == "")
                        {
                            if (strLinkBody_ID != "")
                            {
                                //如果没有传入县级市信息的话，可能是由于用户没有权限，所以使用旧值
                                drLink["Body_ID_L0011"] = dtLinkOld.Rows[0]["Body_ID_L0011"];
                            }
                        }
                    }

                    if (ds.Tables["LIST"].Columns.Contains("销售大区名称"))
                    {
                        string str销售大区名称 = ds.Tables["LIST"].Rows[i]["销售大区名称"].ToString();

                        if (str销售大区名称 != "")
                        {
                            drLink["Body_ID_L0014"] = GetBodyID("销售大区", "销售大区名称='" + str销售大区名称 + "'");
                        }

                        if (drLink["Body_ID_L0014"].ToString() == "")
                        {
                            if (strLinkBody_ID != "")
                            {
                                //如果没有传入销售大区信息的话，可能是由于用户没有权限，所以使用旧值
                                drLink["Body_ID_L0014"] = dtLinkOld.Rows[0]["Body_ID_L0014"];
                            }
                        }
                    }
                    dtStoreLink.Rows.Add(drLink);

                    if (bCreateTable)
                    {
                        dtStore.Columns.Add("body_ID");
                    }

                    dr["body_ID"] = ds.Tables["LIST"].Rows[i]["body_ID_0006"].ToString();

                    if (dr["body_ID"].ToString().Trim() == "")
                    {
                        ds.Tables["LIST"].Rows[i]["POS编号"] = GetStoreCode(str加盟商Body_id,conn);
                    }

                    for (int j = 0; j < ds.Tables["LIST"].Columns.Count; j++)
                    {
                        string strColumnName = ds.Tables["LIST"].Columns[j].ColumnName;

                        //如果修改的列是属于店铺信息的话,要对店铺的Entity进行修改
                        DataRow[] drList = dt_PropertyList.Select("Table_Property_Name = '" + strColumnName + "'");
                        if (drList.Length > 0)
                        {
                            string strPorpertyname = drList[0]["Porperty_Name"].ToString();
                                                        
                            if (bCreateTable)
                            {
                                dtStore.Columns.Add(strPorpertyname);
                            }
                            dr[strPorpertyname] = ds.Tables["LIST"].Rows[i][j].ToString();

                        }
                    }

                    dtStore.Rows.Add(dr);
                    bCreateTable = false;

                }

                DataSet dsRequest = new DataSet();
                dsRequest.Tables.Add(dtStore);

                MDM_Entity_Edit cls_Entity_Edit = new MDM_Entity_Edit();
                cls_Entity_Edit.Request = dsRequest;
                cls_Entity_Edit.GetDataByRequestDs = true;
                cls_Entity_Edit.Execute();

                ArrayList listBody_0006 = cls_Entity_Edit.BodyID; //获取店铺的BODYID

                //修改LINK数据
                for (int i = 0; i < listBody_0006.Count; i++)
                {
                    dtStoreLink.Rows[i]["Body_ID_0006"] = listBody_0006[i].ToString();
                }
                dsRequest.Clear();
                dsRequest.Tables.Add(dtStoreLink);
                cls_Entity_Edit.Request = dsRequest;
                cls_Entity_Edit.Execute();

                ArrayList listBody = cls_Entity_Edit.BodyID;
                string strMessage = "影响的行数为:" + listBody.Count.ToString() + "行";
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

        private string GetBodyID(string strMarketTableName,string strCondition)
        {
            string strBodyid = "";

            DataRow[] dr = new DataRow[0];
            switch (strMarketTableName)
            { 
            
                case "公司":
                    dr = m_Com.Select(strCondition);                    
                    break;

                case "加盟商":
                    dr = m_Merchant.Select(strCondition);                    
                    break;

                case "县":
                    dr = m_City.Select(strCondition);                    
                    break;

                case "销售大区":
                    dr = m_SaleArea.Select(strCondition);                   
                    break;
            }

            if (dr.Length > 0)
            {
                strBodyid = dr[0]["body_ID"].ToString();
            }
            return strBodyid;
        }


        private DataTable GetEntityData(string strMarketTableName, string strCondition)
        {
            DataSet ds = Common.Common.GetRequestDataSet(new string[2] { "MarketTableName", "Condition" }, new string[] { strMarketTableName, strCondition });
            MDM_GetMarketDataByTableName mdm = new MDM_GetMarketDataByTableName();
            mdm.Request = ds;
            mdm.hzyMessage = this.hzyMessage;
            ds = mdm.GetData();

            return ds.Tables[0];
        }

        private void GetBaseData(DataTable dtList)
        {

            string str公司 = "";
            string str加盟商 = "";
            string str销售大区 = "";
            string str县 = "";
            for (int i = 0; i < dtList.Rows.Count; i++)
            {
                string str公司中文简称 ="";
                string str加盟商编码 = "";
                string str县级市编号 = "";
                string str销售大区名称 = "";

                if (dtList.Columns.Contains("公司中文简称"))
                {
                    str公司中文简称 = dtList.Rows[i]["公司中文简称"].ToString();
                }
                if (dtList.Columns.Contains("加盟商编码"))
                {
                    str加盟商编码 = dtList.Rows[i]["加盟商编码"].ToString();
                }

                if (dtList.Columns.Contains("县级市编号"))
                {
                    str县级市编号 = dtList.Rows[i]["县级市编号"].ToString();
                }

                if (dtList.Columns.Contains("销售大区名称"))
                {
                    str销售大区名称 = dtList.Rows[i]["销售大区名称"].ToString();
                }

                if (str公司中文简称 != "" && !str公司.Contains(" 公司中文简称 ='" + str公司中文简称 + "'"))
                {
                    if (str公司 != "")
                    {
                        str公司 += " OR ";
                    }
                    str公司 += " 公司中文简称 ='" + str公司中文简称+"'";
                }

                if (str加盟商编码 != "" && !str加盟商.Contains(" 加盟商编码 ='" + str加盟商编码 + "'"))
                {
                    if (str加盟商 != "")
                    {
                        str加盟商 += " OR ";
                    }
                    str加盟商 += " 加盟商编码 ='" + str加盟商编码+"'";
                }

                if (str县级市编号 != "" && !str县.Contains(" 县级市编号 ='" + str县级市编号 + "'"))
                {
                    if (str县 != "")
                    {
                        str县 += " OR ";
                    }
                    str县 += " 县级市编号 ='" + str县级市编号+"'";
                }

                if (str销售大区名称 != "" && !str销售大区.Contains(" 销售大区名称 ='" + str销售大区名称 + "'"))
                {
                    if (str销售大区 != "")
                    {
                        str销售大区 += " OR ";
                    }
                    str销售大区 += " 销售大区名称 ='" + str销售大区名称+"'";
                }

            }

            if (str公司 != "")
            {
                m_Com = GetEntityData("Com_For_FM", "(" + str公司 + ")");
            }

            if (str加盟商 != "")
            {
                m_Merchant = GetEntityData("Merchant_For_FM", "(" + str加盟商 + ")");
            }

            if (str县 != "")
            {
                m_City = GetEntityData("City_For_FM", "(" + str县 + ")");
            }

            if (str销售大区 != "")
            {
                m_SaleArea = GetEntityData("SaleArea_For_FM", "(" + str销售大区 + ")");
            }

        }

        private string GetStoreCode(string str加盟商Body_id,Dbconn conn)
        {
            string strReturn = "";

            string strMaxCode = "";

            if (m_MaxCodeName.Contains(str加盟商Body_id))
            {
                strMaxCode = m_MaxCode[m_MaxCodeName.IndexOf(str加盟商Body_id)].ToString();
            }
            else
            {
                strMaxCode = conn.GetDataTableFirstValue(@"
                 
                SELECT  MAX(t2.Value_Text) AS code
                FROM    dbo.MDM_L0013_B t1
                        LEFT JOIN dbo.MDM_0006_E t2 ON t1.Body_ID_0006 = t2.Body_ID
                WHERE   Body_ID_0010 = '" + str加盟商Body_id + @"' AND Property_ID IN (
                        SELECT  Property_ID
                        FROM    dbo.Lib_ExdPropertyList
                        WHERE   Class_Name = '0006' AND Property_Name = '店铺ID' )

 
                    ").ToString();

                if (strMaxCode == "")
                {
                    //根据加盟商名称获取加盟商编号
                    string str加盟商编号 = conn.GetDataTableFirstValue(@"
                                            SELECT Value_Text FROM dbo.MDM_0010_E
                                            WHERE Body_ID='" + str加盟商Body_id + @"'
                                            AND Property_ID IN (
                                            SELECT Property_ID FROM dbo.Lib_ExdPropertyList
                                            WHERE Class_Name='0010'
                                            AND Property_Name='加盟商编码'
                                            )
                                        ").ToString();

                    if (str加盟商编号.Length == 5)
                    {
                        strMaxCode = str加盟商编号 + "000";
                    }
                    else //二级加盟商
                    {
                        strMaxCode = str加盟商编号 + "00";
                    }
                }
                
            }

             strReturn = strMaxCode.Substring(0, 5) + (Convert.ToInt32(strMaxCode.Substring(5)) + 1).ToString().PadLeft(3, '0');

             if (m_MaxCodeName.Contains(str加盟商Body_id))
             {
                 m_MaxCode[m_MaxCodeName.IndexOf(str加盟商Body_id)] = strReturn;
             }
             else
             {
                 m_MaxCodeName.Add(str加盟商Body_id);
                 m_MaxCode.Add(strReturn);
             }

            return strReturn;
        }


    }


}