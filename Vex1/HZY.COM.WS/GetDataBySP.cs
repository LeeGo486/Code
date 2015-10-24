using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：GetDataBySP 
/// 类说明：根据AML语言执行对应的存储过程并返回结果
/// 创建人：马卫清
/// 创建日期：2013-08-12  
/// 修改人：
/// 修改日期：
namespace HZY.COM.CommonWS
{
    /// <summary>
    ///GetDataBySP 根据AML语言执行对应的存储过程并返回结果
    /// </summary>
    public class GetDataBySP : LogicBase, ILogicGetData
    {

        public GetDataBySP()
        {
            this.m_SessionCheck = false;
        }

        string strDBConnName = "";
        string strSPName = "";
        string strInputFormat = "";
        string strInputFormatSPSupport = "";
        string strOutputFormat = "DB";
        string strOutputContentType = "";
        string strConditionStr = "";

        /// <summary>
        /// 根据AML语言执行对应的存储过程并返回结果
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {

            try
            {
                strDBConnName = m_request.Tables[0].Rows[0]["DBCfgName"].ToString();
                strSPName = m_request.Tables[0].Rows[0]["SPName"].ToString();
                strInputFormat = m_request.Tables[0].Rows[0]["InputFormat"].ToString().ToUpper();
                strInputFormatSPSupport = m_request.Tables[0].Rows[0]["InputFormatSPSupport"].ToString();
                strOutputContentType = m_request.Tables[0].Rows[0]["OutputContentType"].ToString();
                strConditionStr = m_request.Tables[0].Rows[0]["ConditionStr"].ToString();
            }
            catch (Exception)
            {
                throw;
            }

            //判断存储过程支持的格式与传入的格式,如果不支持,需要进行转换
            if (strInputFormatSPSupport.IndexOf(strInputFormat) == -1)
            {
                //XML转成AML
                if (strInputFormat == "XML" && strConditionStr != "")
                {
                    DataSet ds1 = Common.Common.GetDSByExcelXML(strConditionStr);
                    if (ds1.Tables.Contains("Optype"))
                    {
                        ds1.Tables.Remove("Optype");
                    }
                    strConditionStr = Common.Common.GetAMLByDs(ds1);
                    strInputFormat = "AML";
                }
                //AML转成XML
                else if (strInputFormat == "AML" && strConditionStr != "")
                {
                    DataSet ds1 = Common.Common.GetDsByAML(strConditionStr);
                    strConditionStr = Common.Common.GetExcelXMLStringByDs(ds1);
                    strInputFormat = "XML";
                }

            }

            Dbconn conn = new Dbconn(strDBConnName);
            DataSet ds = new DataSet();
            ds = conn.GetDataSetBySP(strSPName, new string[4] { "@InputFormat", "@OutputFormat", "@OutputContentType", "@ConditionStr" },
                                     new string[4] { strInputFormat, strOutputFormat, strOutputContentType, strConditionStr });
            return ds;
        }

        private void CheckValues()
        {
            if (strDBConnName == "")
            {
                throw new Exception("传入的服务器配置信息不正确!");
            }

            if (strSPName == "")
            {
                throw new Exception("传入的存储过程名称信息不正确!");
            }

            if (strInputFormat != "AML" || strInputFormat != "XML")
            {
                throw new Exception("传入的InputFormat不正确!");
            }

            if (strInputFormatSPSupport == "")
            {
                throw new Exception("配置的InputFormatSPSupport不正确!");
            }

            if (strOutputContentType == "")
            {
                throw new Exception("传入的OutputContentType不正确!");
            }
        }

    }

}