using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using System.Text.RegularExpressions;
using HZY.COM.Common.Base;

namespace HZY.COM.CRM
{

    /// <summary>
    ///CRM_ID_EditByXML 的摘要说明
    /// </summary>
    public class CRM_ID_EditByXML : LogicBase, ILogicGetData
    {
        public CRM_ID_EditByXML()
        {
            this.m_SessionCheck = false;
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }
        public DataSet GetData()
        {

            try
            {


                string strID = this.m_request.Tables[0].Rows[0]["USERID"].ToString();
               
                string strurl = "";
                if (strID == "")
                {
                     
                     strurl = "http://www.elegant-prosper.com/?task=json_get_all_user_id";
                }

                if (strID != "")
                {
                    strurl = "http://www.elegant-prosper.com/?task=json_get_userdata&user_id=";     
                }


                string str1 = WebServiceHelperRestful.InvokeWebService(strurl, strID, "get");
                str1 = strConvertCode(str1);
                return Common.Common.GetRequestDataSet(new string[1] { "Message" }, new string[1] { str1 });
           
            
            }
            catch
            {
                throw;
            }
        }

        private string strConvertCode(string strSource)
        {
            
            Regex regex = new Regex(@"\\u(\w{4})");
            string result = regex.Replace(strSource, delegate(Match m)
            {
                string hexStr = m.Groups[1].Value;
                string charStr = ((char)int.Parse(hexStr, System.Globalization.NumberStyles.HexNumber)).ToString();
                return charStr;
            });
            return result;
        }
    }
}