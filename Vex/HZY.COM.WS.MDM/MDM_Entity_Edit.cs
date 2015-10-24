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


/// 类名：MDM_Entity_Edit 
/// 类说明：编辑Entity
/// 创建人：马卫清
/// 创建日期：2013-04-27
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    ///MDM_Entity_Edit 编辑Entity
    /// </summary>
    public class MDM_Entity_Edit : LogicBase, ILogicExecute
    {
        public MDM_Entity_Edit()
        {
            this.m_SessionCheck = false;

        }
        private ArrayList m_BodyID = new ArrayList();
        private bool m_GetDataByRequestDs = false;

        public bool GetDataByRequestDs
        {
            set { m_GetDataByRequestDs = value; }
        }

        public ArrayList BodyID
        {
            get { return m_BodyID; }
        }


        /// <summary>
        /// 编辑用户信息
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            Dbconn conn = new Dbconn("MDM_Master");

            try
            {

                DataSet ds = null;


                //数据直接取到m_Request
                if (m_GetDataByRequestDs)
                {
                    ds = m_request;
                }
                else
                {
                    string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                    ds = GetRequestData(strXML);
                }


                for (int i = 0; i < ds.Tables.Count; i++)
                {
                    //分各实体进行处理
                    DataTable dt = ds.Tables[i];

                    for (int j = 0; j < dt.Rows.Count; j++)
                    {
                        string[] strParam = new string[5];
                        string[] strValue = new string[5];

                        string strBodyId = "";

                        //新添加Body_Id
                        if (dt.Rows[j]["body_id"].ToString() == "")
                        {
                            //如果是Link表，直接插入
                            if (dt.TableName.Substring(0, 1).ToUpper() == "L")
                            {
                                strBodyId = UpdateLinkBody(conn, dt, j, strBodyId);

                            }
                            else
                            {
                                strParam = new string[3];
                                strValue = new string[3];
                                strParam[0] = "@MDMName";
                                strParam[1] = "@bodyID";
                                strParam[2] = "@ReturnTable";

                                strValue[0] = dt.TableName;
                                strValue[1] = "";
                                strValue[2] = "1";

                                DataSet dsTemp = conn.GetDataSetBySP("SP_CreateMasterData_New", strParam, strValue);

                                if (dsTemp.Tables.Count==0 || dsTemp.Tables[0].Columns.Contains("STATE"))
                                {
                                    //发生错误
                                    strBodyId =  "Error:" + dsTemp.Tables[0].Rows[0]["Message"].ToString();

                                }
                                else
                                {
                                    strBodyId = dsTemp.Tables[0].Rows[0]["body_id"].ToString();
                                }
                            }
                        }
                        else //更新数据
                        {
                            strBodyId = dt.Rows[j]["body_id"].ToString();

                            //如果是Link表，那么需要更新Link的数据
                            if (dt.TableName.Substring(0, 1).ToUpper() == "L")
                            {
                                strBodyId = UpdateLinkBody(conn, dt, j, strBodyId);
                            }

                        }

                        m_BodyID.Add(strBodyId);
                        //Body_ID不对，跳过本行的修改
                        if (strBodyId.StartsWith("Error"))
                        {
                            continue;
                        }

                        //取到本实体的所有属性
                        DataTable dtProperty = conn.GetDataTable(@"
                            SELECT 
                                [Property_Name]
                                ,[Property_Field]
      
                            FROM [MDM_Master].[dbo].[Lib_ExdPropertyList]
                            WHERE Class_Name=@Param0

                        ", new string[] {dt.TableName });


                        //取不到属性，说明这张表的数据不对，直接跳出表
                        if (dtProperty.Rows.Count == 0)
                        {
                            continue;
                        }


                        //进行属性值的修改
                        for (int k = 0; k < dt.Columns.Count; k++)
                        {
                            //所有的BodyID都在前面直接修改
                            if (dt.Columns[k].ColumnName.ToLower().StartsWith("body_id") == true)
                            {
                                continue;
                            }

                            //如果这个列不包括是这个实体的，直接跳过
                            if (dtProperty.Select("Property_Name='" + dt.Columns[k].ColumnName + "'").Length == 0)
                            {
                                continue;
                            }

                            strParam = new string[5];
                            strValue = new string[5];
                            strParam[0] = "@MDMClass";
                            strParam[1] = "@PropertyName";
                            strParam[2] = "@ExpressionName";
                            strParam[3] = "@PropertyValue";
                            strParam[4] = "@BodyID";

                            strValue[0] = dt.TableName;
                            strValue[1] = dt.Columns[k].ColumnName;
                            strValue[2] = dt.Namespace;
                            strValue[3] = dt.Rows[j][k].ToString();
                            strValue[4] = strBodyId;

                            DataSet dsTemp=conn.GetDataSetBySP("SP_Insert_Property_Value",strParam,strValue);

                            if (dsTemp.Tables.Count>0 && dsTemp.Tables[0].Columns.Contains("STATE"))
                            {
                                //发生错误
                            }
                           
                        }
                    }
                    
                }
              


                return true;
            }
            catch
            {
                
                throw;
            }



        }

        #region 更新Link表的Body信息
        /// <summary>
        /// 更新Link表的Body信息
        /// </summary>
        /// <returns></returns>
        private string UpdateLinkBody(Dbconn conn,DataTable dt,int row,string strBodyId)
        {
            DataTable dtMDMConfig = conn.GetDataTable(@"
                                            SELECT 
                                                [Ref_Entity]      
                                            FROM [MDM_Master].[dbo].[Lib_MDM_Config]
                                            WHERE MDM_TableName=@Param0", new string[] { "MDM_" + dt.TableName });
            if (dtMDMConfig.Rows.Count == 0)
            {
                return "";
            }

            string strRef_Entity = dtMDMConfig.Rows[0][0].ToString();
            string[] strRefList = strRef_Entity.Split(',');
            string strBodyList = "";
            
            bool bColumnError = false;
            string  bDeleteFalg = "0";
            foreach (string str in strRefList)
            {
                if (!dt.Columns.Contains("body_id_" + str))
                {
                    bColumnError = true;
                    break;
                }
                //if (dt.Rows[row]["body_id_" + str].ToString() == "")
                //{
                //    bDeleteFalg = "1";
                //    break;
                //}
                if (strBodyList != "")
                {
                    strBodyList += ",";
                }
                strBodyList += dt.Rows[row]["body_id_" + str].ToString();
               

            }
            //如果提供的Link的列不足，将不更新Link信息
            if (bColumnError)
            {
                return "Error:提供Link的列不足!";
            }

            //如果没有主body_ID并是删除数据。那么提交的信息无效
            if (strBodyId == "" && bDeleteFalg == "1")
            {
                return "Error:无效的信息!";
            }
            
            string[] strParam = new string[4];
            string[] strValue = new string[4];
            strParam[0] = "@MDMName";
            strParam[1] = "@LinkBodyIDList";
            strParam[2] = "@bodyID";
            strParam[3] = "@DeleteFlag";

            strValue[0] = dt.TableName;
            strValue[1] = strBodyList;
            strValue[2] = strBodyId;
            strValue[3] = bDeleteFalg;
            DataSet dsTemp = conn.GetDataSetBySP("SP_Create_Master_Link_B_Data_New", strParam, strValue);
            if (dsTemp.Tables[0].Columns.Contains("STATE"))
            {
                //发生错误
                return "Error:" + dsTemp.Tables[0].Rows[0]["Message"].ToString();
            }
            else
            {
                return dsTemp.Tables[0].Rows[0]["body_id"].ToString();
            }
        }
        #endregion

        #region GetRequestData 将XML转化成为DataSet
        /// <summary>
        /// 将XML转化成为DataSet
        /// </summary>
        /// <param name="pInputXml"></param>
        /// <returns></returns>
        private DataSet GetRequestData(string pInputXml)
        {

            bool bCreateTable = true;//标志是否需要创建表
            string strXML = "";

            strXML = "<data>"+pInputXml+"</data>";

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(strXML);

            XmlNode xml = xmlDoc.DocumentElement;
           
            DataSet ds = new DataSet("Request");
            foreach (XmlNode xmlTable in xml.ChildNodes)
            {
                DataTable dt = new DataTable(xmlTable.Attributes["Entity"].Value.ToString());
                dt.Namespace = xmlTable.Attributes["Expression"].Value.ToString();
                foreach (XmlNode xmlRow in xmlTable.ChildNodes)
                {
                    DataRow dr = dt.NewRow();
                    foreach (XmlNode xmlColumn in xmlRow.ChildNodes)
                    {
                        string strColumnName = xmlColumn.Name;

                        if (bCreateTable)
                        {
                            dt.Columns.Add(strColumnName);
                        }

                        dr[strColumnName] = xmlColumn.InnerXml;
                    }
                    dt.Rows.Add(dr);
                    bCreateTable = false;
                }
                ds.Tables.Add(dt);

            }

            if (ds.Tables.Count == 0)
            {
                ds = null;
            }

            return ds;
        }
        #endregion
    }

}