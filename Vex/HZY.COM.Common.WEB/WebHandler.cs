using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;
using System.Text.RegularExpressions;

namespace HZY.COM.WEB
{
    public class HandlerCfg
    {
        public string m_WSID = "";
        public string m_SessionID = "";
        public string m_RequestType = "";
        public string m_App = "";
        public string m_LoginApp = "";
        public string m_ExcelExportColumns = "";
        public bool m_ExcelExport = false;

        public HandlerCfg(string pApp, string pLoginApp)
        {
            this.m_App = pApp;
            this.m_LoginApp = pLoginApp;

        }
    }

    public class WebHandler
    {

        #region GetRequestData
        public static DataSet GetRequestData(HttpContext context, HandlerCfg pclsHandlerCfg)
        {

            DataSet ds = new DataSet("Request");

            try
            {
                DataTable dt = new DataTable("RequestTable");

                pclsHandlerCfg.m_WSID = context.Request["WSID"].ToString();
                if (context.Request["RequestType"] != null)
                {
                    pclsHandlerCfg.m_RequestType = context.Request["RequestType"].ToString();

                }
                else
                {
                    if (context.Request["ExcelExport"] != null && context.Request["ExcelExport"].ToString().ToUpper() == "TRUE")
                    {
                        pclsHandlerCfg.m_ExcelExport = true;
                    }
                    else
                    {
                        pclsHandlerCfg.m_ExcelExport = false;
                    }
                }



                dt.Columns.Add("ParamName");
                dt.Columns.Add("ParamValue");

                for (int i = 0; i < context.Request.QueryString.Count; i++)
                {
                    if (context.Request.QueryString.AllKeys[i] != "SessionID"
                        && context.Request.QueryString.AllKeys[i] != "WSID"
                        && context.Request.QueryString.AllKeys[i] != "RequestType"
                        && context.Request.QueryString.AllKeys[i] != "AspxAutoDetectCookieSupport"
                        )
                    {
                        DataRow dr = dt.NewRow();
                        dr["ParamName"] = context.Request.QueryString.AllKeys[i];
                        dr["ParamValue"] = CheckRequestSafe(context.Request.QueryString[i]);
                        dt.Rows.Add(dr);
                    }
                }

                for (int i = 0; i < context.Request.Form.Count; i++)
                {
                    if (context.Request.Form.AllKeys[i] != "SessionID"
                        && context.Request.Form.AllKeys[i] != "WSID"
                        && context.Request.Form.AllKeys[i] != "RequestType"
                        )
                    {
                        DataRow dr = dt.NewRow();

                        //兼容后台WSRR的需要,将grid的rows关键字改成pagerows
                        if (context.Request.Form.AllKeys[i] == "rows")
                        {
                            dr["ParamName"] = "pagerows";
                        }
                        else
                        {
                            dr["ParamName"] = context.Request.Form.AllKeys[i];
                        }
                        dr["ParamValue"] = context.Request.Form[i];
                        dt.Rows.Add(dr);
                    }
                }


                if (pclsHandlerCfg.m_WSID == "550fc164-adc8-4f88-bc9d-73c4248050bc"
                    || pclsHandlerCfg.m_WSID == "08d42db4-d2b3-4999-a3ea-8b4be8f2333e") //登录
                {

                    DataRow dr = dt.NewRow();
                    dr["ParamName"] = "AppSn";
                    dr["ParamValue"] = pclsHandlerCfg.m_App;
                    dt.Rows.Add(dr);

                    dr = dt.NewRow();
                    dr["ParamName"] = "LoginApp";
                    dr["ParamValue"] = pclsHandlerCfg.m_LoginApp;
                    dt.Rows.Add(dr);
                }
                else if (pclsHandlerCfg.m_WSID == "f5f35aca-469b-463c-b33c-2e872dabbec3")//登出
                {
                    DataRow dr = dt.NewRow();
                    dr["ParamName"] = "SessionID";
                    dr["ParamValue"] = context.Session["SessionID" + pclsHandlerCfg.m_App].ToString();
                    pclsHandlerCfg.m_SessionID = context.Session["SessionID" + pclsHandlerCfg.m_App].ToString();
                    dt.Rows.Add(dr);
                }
                else
                {
                    if (context.Session["SessionID" + pclsHandlerCfg.m_App] != null)
                    {
                        pclsHandlerCfg.m_SessionID = context.Session["SessionID" + pclsHandlerCfg.m_App].ToString();

                    }
                }

                ds.Tables.Add(dt);
            }
            catch
            {
                throw;
            }


            return ds;


        }
        #endregion

        #region GetXMLFromDS
        public static string GetXMLFromDS(DataSet ds, HandlerCfg pclsHandlerCfg)
        {
            string strXML = "";
            strXML = "<Interface WSID=\"" + pclsHandlerCfg.m_WSID + "\" App=\"" + pclsHandlerCfg.m_App + "\" SessionID=\"" + pclsHandlerCfg.m_SessionID + "\">";

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Columns.Count == 2)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (ds.Tables[0].Rows[i][0].ToString().ToUpper() == "ExcelExportColumns".ToUpper())
                    {
                        pclsHandlerCfg.m_ExcelExportColumns = ds.Tables[0].Rows[i][1].ToString();
                    }
                    else
                    {
                        strXML += "<" + ds.Tables[0].Rows[i][0].ToString() + ">" + ds.Tables[0].Rows[i][1].ToString() + "</" + ds.Tables[0].Rows[i][0].ToString() + ">";
                    }

                }
            }
            strXML += "</Interface>";

            return strXML;
        }
        #endregion

        #region GetJSONFromXML
        public static string GetJSONFromXML(string strXML, HttpContext context, HandlerCfg pclsHandlerCfg)
        {
            if (strXML.StartsWith("Error"))
            {
                return "{\"Error\":\"" + strXML + "\"}";
            }

            if (pclsHandlerCfg.m_WSID.ToUpper() == "550fc164-adc8-4f88-bc9d-73c4248050bc".ToUpper()
                || pclsHandlerCfg.m_WSID.ToUpper() == "08d42db4-d2b3-4999-a3ea-8b4be8f2333e".ToUpper())
            {
                //m_SessionID = strXML;
                context.Session["SessionID" + pclsHandlerCfg.m_App] = strXML;
                context.Session["UserName" + pclsHandlerCfg.m_App] = context.Request["UserName"];

                return "{\"Result\":\"登录成功\"}";

            }
            else if (pclsHandlerCfg.m_WSID.ToUpper() == "f5f35aca-469b-463c-b33c-2e872dabbec3".ToUpper())
            {
                context.Session.Clear();

                return "{\"Result\":\"注销成功\"}";
            }

            string strJSON = "";
            DataSet ds = HZY.COM.Common.Common.GetDSByExcelXML(strXML);

            if (ds.Tables.Count > 0
                && ds.Tables[0].TableName.ToUpper() == "OPTYPE")
            {
                ds.Tables.Remove("OPTYPE");
            }

            //说明是Result,Message的形式
            if (ds.Tables.Count > 0
                && ds.Tables[0].Rows.Count > 0
                && ds.Tables[0].Columns.Count == 2
                && ds.Tables[0].Columns[0].ColumnName == ""
                && ds.Tables[0].Columns[1].ColumnName == "")
            {
                strJSON = HZY.COM.Common.JsonHelper.CreateJsonParameters(ds.Tables[0]);
                return strJSON;
            }

            string strComboxIDFiled = "";
            string strComboxTextFiled = "";
            switch (pclsHandlerCfg.m_RequestType)
            {
                case "combox":
                case "comboxAllColumn":

                    strComboxIDFiled = context.Request["comboxIDFiled"];
                    strComboxTextFiled = context.Request["comboxTextFiled"];

                    if (strComboxIDFiled == null || strComboxIDFiled == "" || !ds.Tables[0].Columns.Contains(strComboxIDFiled))
                    {
                        strComboxIDFiled = ds.Tables[0].Columns[0].ColumnName;
                    }
                    if (strComboxTextFiled == null || strComboxTextFiled == "" || !ds.Tables[0].Columns.Contains(strComboxTextFiled))
                    {
                        strComboxTextFiled = ds.Tables[0].Columns[1].ColumnName;
                    }

                    if (pclsHandlerCfg.m_RequestType == "combox")
                    {
                        strJSON = HZY.COM.Common.JsonHelper.CreateComboxJsonByDt(ds.Tables[0], strComboxIDFiled, strComboxTextFiled, null, false, false);
                    }
                    else
                    {
                        strJSON = HZY.COM.Common.JsonHelper.CreateComboxJsonByDt(ds.Tables[0], strComboxIDFiled, strComboxTextFiled, null, false, true);
                    }
                    break;
                case "tree":

                    string strTreeCheckboxCol = context.Request["treeCheckboxCol"];
                    string strParentID = context.Request["parentID"];
                    string strContainRoot = context.Request["ContainRoot"]; //如果为1时，说明包含
                    bool bContainRoot = false;

                    ArrayList attr = new ArrayList();
                    if (ds.Tables[0].Columns.Count < 3)
                    {
                        //return "{\"Error\":\"发生错误!\"}";
                        return "[]";

                    }
                    else
                    {
                        for (int i = 3; i < ds.Tables[0].Columns.Count; i++)
                        {
                            attr.Add(ds.Tables[0].Columns[i].ColumnName);
                        }
                    }

                    string strFidCol = ds.Tables[0].Columns[2].ColumnName;

                    string strFidParentID = "0";
                    if (strParentID != null && strParentID != "")
                    {
                        strFidParentID = strParentID;
                    }
                    else if (ds.Tables[0].Select(strFidCol + "='-1'").Length == 1)
                    {
                        strFidParentID = "-1";
                    }

                    if (strContainRoot != null && strContainRoot == "1")
                    {
                        bContainRoot = true;
                    }


                    if (strTreeCheckboxCol != null && strTreeCheckboxCol.ToString() != "")
                    {
                        strJSON = HZY.COM.Common.JsonHelper.GreateTreeJsonByTable(ds.Tables[0], ds.Tables[0].Columns[0].ColumnName,
                                ds.Tables[0].Columns[1].ColumnName,
                                strFidCol, strFidParentID, "", "", attr, true, strTreeCheckboxCol, bContainRoot
                                );
                    }
                    else
                    {
                        strJSON = HZY.COM.Common.JsonHelper.GreateTreeJsonByTable(ds.Tables[0], ds.Tables[0].Columns[0].ColumnName,
                            ds.Tables[0].Columns[1].ColumnName,
                            strFidCol, strFidParentID, "", "",
                            attr, bContainRoot
                            );
                    }
                    break;
                case "GridColumns":
                    string strGridColumnsWidth = context.Request["GridColumnsWidth"];
                    string strGridColumnsSort = context.Request["GridColumnsSort"];
                    string strGridColumnsSearch = context.Request["GridColumnsSearch"];

                    if (strGridColumnsWidth == null || strGridColumnsWidth == "")
                    {
                        strGridColumnsWidth = "100";
                    }

                    if (strGridColumnsSort == null || strGridColumnsSort == "")
                    {
                        strGridColumnsSort = "true";
                    }

                    if (strGridColumnsSearch == null || strGridColumnsSearch == "")
                    {
                        strGridColumnsSearch = "true";
                    }

                    strJSON = HZY.COM.Common.JsonHelper.CreateGridColumns_ByMDM(ds.Tables[0], strGridColumnsWidth, strGridColumnsSort, strGridColumnsSearch);
                    strJSON = "{\"Col\":\"[[" + strJSON + "]]\"}";

                    break;
                default:

                    string strMultiTable = context.Request["MultiTable"];
                    if (strMultiTable == null || strMultiTable == "")
                    {


                        if (pclsHandlerCfg.m_ExcelExport == true)
                        {
                            string strExcelExportColumns = context.Request["ExcelExportColumns"];
                            string strTitle = context.Request["title"];
                            DataSet dsColumn = HZY.COM.Common.Common.GetDSByExcelXML(strExcelExportColumns);
                            string strFileName = "";
                            strFileName = HZY.COM.Common.Excel.ExcelExport.Export(ds, "/Export/GridExcel/", strTitle, dsColumn.Tables["List"]);
                            strJSON = "{'FileName':'" + strFileName + "'}";
                        }
                        else
                        {
                            int nRowAllCount = 2147483647;
                            if (ds.Tables.Contains("PageRowCount"))
                            {
                                nRowAllCount = Convert.ToInt32(ds.Tables["PageRowCount"].Rows[0]["AllRowCount"]);
                            }

                            string strHeihgRightKeyWord = context.Request["HeihgRightKeyWord"];
                            strJSON = HZY.COM.Common.JsonHelper.CreateJsonParameters(ds.Tables[0], true, nRowAllCount, strHeihgRightKeyWord);

                        }
                    }
                    else
                    {
                        strJSON = "[";
                        for (int i = 0; i < ds.Tables.Count; i++)
                        {
                            if (i > 0)
                            {
                                strJSON += ",";
                            }
                            strJSON += HZY.COM.Common.JsonHelper.CreateJsonParameters(ds.Tables[i], false);

                        }
                        strJSON += "]";

                    }
                    break;
            }

            return strJSON;
        }
        #endregion

        #region CheckRequestSafe
        public static string CheckRequestSafe(string pstrValue)
        {

            if (pstrValue.IndexOf("'") > 0)
            {
                if ((pstrValue.Length - pstrValue.Replace("'", "").Length) % 2 != 0)
                {
                    throw new Exception("参数值存在安全问题");
                }
            }
            return pstrValue;
        }
        #endregion



    }
}
