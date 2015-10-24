using ElegantWM.IDAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace ElegantWM.DAL
{
    public class WsrrDAL:IWsrrDAL
    {
        

        /// <summary>
        /// 调用AML协议的WSRR
        /// </summary>
        /// <param name="wsid"></param>
        /// <param name="aml"></param>
        /// <returns></returns>
        public string ExcuteWsrrAML(string wsid, string aml)
        {
            WSRR.WSRRSoapClient ws = new WSRR.WSRRSoapClient();
            WSRR.HZYmessage msg = new WSRR.HZYmessage();
            string rst = ws.CallByXML(ref msg, "<Interface WSID=\"" + wsid + "\" App=\"WX\"  SessionID=\"\"><InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>" + aml + "</ConditionStr></Interface>");
            if (rst.ToUpper().StartsWith("ERROR"))
                throw new Exception(rst);
            return rst;
        }
        /// <summary>
        /// 执行wsrr，返回数据集合
        /// </summary>
        /// <param name="wsid"></param>
        /// <param name="aml"></param>
        /// <returns></returns>
        public DataSet GetData(string wsid,string aml)
        {
            WSRR.WSRRSoapClient ws = new WSRR.WSRRSoapClient();
            WSRR.HZYmessage msg = new WSRR.HZYmessage();
            string rst = ws.CallByXML(ref msg, "<Interface WSID=\"" + wsid + "\" App=\"WX\"  SessionID=\"\"><InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>" + aml + "</ConditionStr></Interface>");
            if (rst.ToUpper().StartsWith("ERROR"))
                throw new Exception(rst);

            DataSet ds = new DataSet();
            StringReader stream = new StringReader(rst);
            ds.ReadXml(stream);
            return ds;
        }

        /// <summary>
        /// 执行标准的wsrr
        /// </summary>
        /// <param name="wsid"></param>
        /// <param name="xml"></param>
        /// <returns></returns>
        public DataSet ExcuteWsrrTest(string wsid, string xml)
        {
            WSRRTest.WSRRSoapClient ws = new WSRRTest.WSRRSoapClient();
            WSRRTest.HZYmessage msg = new WSRRTest.HZYmessage();
            string rst = ws.CallByXML(ref msg, "<Interface WSID=\"" + wsid + "\" App=\"HZYSSO\"  SessionID=\"\">" + xml + "</Interface>");
            if (rst.ToUpper().StartsWith("ERROR"))
            {
                throw new Exception(rst.Replace("Error:", ""));
            }
            DataSet ds = new DataSet();
            StringReader stream = new StringReader(rst);
            ds.ReadXml(stream);
            return ds;
        }


        /// <summary>
        /// 执行标准的wsrr
        /// </summary>
        /// <param name="wsid"></param>
        /// <param name="xml"></param>
        /// <returns></returns>
        public DataSet ExcuteWsrr(string wsid, string xml)
        {
            WSRR.WSRRSoapClient ws = new WSRR.WSRRSoapClient();
            WSRR.HZYmessage msg = new WSRR.HZYmessage();
            string rst = ws.CallByXML(ref msg, "<Interface WSID=\"" + wsid + "\" App=\"HZYSSO\"  SessionID=\"\">" + xml + "</Interface>");
            if (rst.ToUpper().StartsWith("ERROR"))
            {
                throw new Exception(rst.Replace("Error:", ""));
            }
            DataSet ds = new DataSet();
            StringReader stream = new StringReader(rst);
            ds.ReadXml(stream);
            return ds;
        }

        /// <summary>
        /// 更新C3AM用户信息，手机号，密码
        /// </summary>
        /// <param name="amuser"></param>
        /// <param name="tel"></param>
        /// <param name="pwd"></param>
        public void UpdateC3AMUser(string amuser, string tel, string pwd)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["C3AM"].ToString()))
            {
                if (conn.State != ConnectionState.Open)
                {
                    conn.Open();
                }
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "UPDATE WMS_User SET Phone='" + tel.Replace("'", "") + "',UserPwd=dbo.F_PwdSecurity('" + pwd.Replace("'", "") + "') WHERE UserName='" + amuser.Replace("'", "") + "'";
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
    }
}
