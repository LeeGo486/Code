using ElegantWM.IDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.DAL
{
    public class ITDCDAL : IITDCDAL
    {
        /// <summary>
        /// 获取AM的部门信息
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        public DataTable GetAMDept(string userName)
        {
            WSRR.WSRRSoapClient ws = new WSRR.WSRRSoapClient();
            WSRR.HZYmessage msg = new WSRR.HZYmessage();
            string rst = ws.CallByXML(ref msg, "<Interface WSID=\"e885e21b-0463-4601-893b-3f13733188f0\" App=\"ITDC\"  SessionID=\"\"><AMUserName>" + userName + "</AMUserName></Interface>");
            DataSet ds = new DataSet();
            StringReader stream = new StringReader(rst);
            ds.ReadXml(stream);
            return ds.Tables[2];
        }
        /// <summary>
        /// 获取ITDC报表值，Web版本
        /// </summary>
        /// <param name="key">关键字</param>
        /// <returns></returns>
        public string GetRptData(string key)
        {
            try
            {
                string cmd = "<Interface WSID=\"4beb00e2-1f71-4f19-a30e-12ee7a53a5a0\" App=\"X6_EPApp\"  SessionID=\"\"><InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,微信】{0}</ConditionStr></Interface>";
                if (key.Trim().StartsWith("【"))
                {
                    cmd = string.Format(cmd, key.Trim());
                }
                else
                {
                    cmd = string.Format(cmd, "【问题," + key.Trim().Replace("'", "").Replace("【", "").Replace("】", "") + "】");
                }
                WSRR.WSRRSoapClient ws = new WSRR.WSRRSoapClient();
                WSRR.HZYmessage msg = new WSRR.HZYmessage();

                string rst = ws.CallByXML(ref msg, cmd);

                DataSet ds = new DataSet();
                StringReader stream = new StringReader(rst);
                ds.ReadXml(stream);

                if (ds.Tables.Count != 2)
                {
                    return rst;
                }
                string content = "";

                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    content += ds.Tables[1].Rows[i][1].ToString();
                    if (i + 1 != ds.Tables[1].Rows.Count)
                        content += "\r\n";
                }
                return content;
            }
            catch //Exception error
            {
                return "哎吆，这是火星文吗？我的小脑壳运算不过来了...\r\n亲，不要调戏我嘛！";// +error.Message;
            }
        }

        /// <summary>
        /// 获取ITDC报表值，Web版本
        /// </summary>
        /// <param name="key">关键字</param>
        /// <returns></returns>
        public DataTable GetRptDataTable(string key)
        {
            string cmd = "<Interface WSID=\"4beb00e2-1f71-4f19-a30e-12ee7a53a5a0\" App=\"X6_EPApp\"  SessionID=\"\"><InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,微信】{0}</ConditionStr></Interface>";
            if (key.Trim().StartsWith("【"))
            {
                cmd = string.Format(cmd, key.Trim());
            }
            else
            {
                cmd = string.Format(cmd, "【问题," + key.Trim().Replace("'", "").Replace("【", "").Replace("】", "") + "】");
            }
            WSRR.WSRRSoapClient ws = new WSRR.WSRRSoapClient();
            WSRR.HZYmessage msg = new WSRR.HZYmessage();

            string rst = ws.CallByXML(ref msg, cmd);

            DataSet ds = new DataSet();
            StringReader stream = new StringReader(rst);
            ds.ReadXml(stream);

            if (ds.Tables.Count != 2)
            {
                return null;
            }
            return ds.Tables[1];
        }



        /// <summary>
        /// 执行WSRR
        /// </summary>
        /// <param name="xml">关键字</param>
        /// <returns></returns>
        public DataTable ExecuteWSRR(string xml)
        {
            try
            {
                WSRR.WSRRSoapClient ws = new WSRR.WSRRSoapClient();
                WSRR.HZYmessage msg = new WSRR.HZYmessage();

                string rst = ws.CallByXML(ref msg, xml);

                if (rst.ToUpper().StartsWith("ERROR"))
                {
                    return GetErrorDataTable(rst);
                }

                DataSet ds = new DataSet();
                StringReader stream = new StringReader(rst);
                ds.ReadXml(stream);

                if (ds.Tables.Count != 2)
                {
                    return null;
                }
                return ds.Tables[1];
            }
            catch (Exception ex) //Exception error
            {
                //return "哎吆，执行WSRR出错喇！" + xml;// +error.Message;
                return GetErrorDataTable("Error" + ex.Message);
            }
        }

        private DataTable GetErrorDataTable(string pstrError)
        {
            DataTable dt = new DataTable("Error");
            dt.Columns.Add("Result");
            dt.Columns.Add("Message");
            dt.Rows.Add(new object[] { false, pstrError });
            return dt;
        }
    }
}
