using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：AuthCode
/// 类说明：手机短信发送和验证
/// 创建人：郭琦琦
/// 创建日期：2014-08-06
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.NPaiaWXSite
{

    public class AuthCode : LogicBase, ILogicGetData
    {
        #region 构造函数
        public AuthCode()
        {
            this.m_SessionCheck = false;

        }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("SMS");
        private Dbconn m_conn = new Dbconn("VEXSSO");
        private bool m_tranFlag = true;

        public Dbconn Conn
        {
            get { return m_conn; }
            set { m_tranFlag = false; m_conn = value; }
        }
        DataSet ds = new DataSet();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_dsRequturn = new DataSet();

        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DateTime time = DateTime.Now;

                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetAuthCode".ToUpper())      //获取验证码
                {
                    GetAuthCode();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CheckAuthCode".ToUpper())      //验证验证码
                {
                    CheckAuthCode();
                }
                return m_dsRequturn;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion



        #region  GetAuthCode 获取验证码
        /// <summary>
        /// 获取验证码
        /// </summary>
        private void GetAuthCode()
        {
            DataTable dtList = ds.Tables["List"];
            //DataTable dtVexSSO = new MDM.VEXSSOUserDataTable();

            string strSQL = "";
            int nCount = 0;

            //认证类型
            string strAuthType = dtList.Rows[0]["AuthType"].ToString().ToUpper();
            string strContent = "";
            string strAuthCode = "";
            string strPhone = dtList.Rows[0]["Phone"].ToString().ToUpper();

            if (strAuthType == "")
            {
                throw new Exception("AuthType不能为空！");
            }
            if (strPhone == "")
            {
                throw new Exception("Phone不能为空！");
            }

            if (m_tranFlag == true)
            {
                m_conn.BeginTransaction();
            }


            Random ra = new Random();
            strAuthCode = ra.Next(1000, 9999).ToString();
            //strContent = "您正在申请注册登录账户，验证码：" + strAuthCode + "，请勿向任何人提供您收到的验证码。（有效期：1小时）";
            strContent = "验证码：" + strAuthCode + ";欢迎关注当代设计师品牌N.Paia官方微信!【简约主张，针织情怀】N.Paia带给您摩登、时尚、轻松、愉悦的全新体验！";
            //DataTable dtAuthCode = new MDM.VEXSSOAuthCodeDataTable();
            DataTable dtAuthCode = new DataTable();
            dtAuthCode.Columns.Add("ID");
            dtAuthCode.Columns.Add("Type");
            dtAuthCode.Columns.Add("Phone");
            dtAuthCode.Columns.Add("Content");
            dtAuthCode.Columns.Add("AuthCode");

            DataRow dr = dtAuthCode.NewRow();
            dr["ID"] = Guid.NewGuid();
            dr["Type"] = strAuthType;
            dr["Phone"] = strPhone;
            dr["Content"] = strContent;
            dr["AuthCode"] = strAuthCode;

            dtAuthCode.Rows.Add(dr);

            m_conn.BeginTransaction();
            m_conn.HZYMessage = this.hzyMessage;
            m_conn.InsertByVex("B01_MDM.VEXSSOAuthCode", dtAuthCode);

            //HZY.COM.WS.AM.SMSSendImmediately.Send(strPhone, strContent);
            Send(strPhone, strContent);

            if (m_tranFlag == true)
            {
                m_conn.CommitTransaction();
            }

            dt_EditResult.Rows.Add(new object[] { true, "发送成功！" });
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #region  内部函数

        #region 验证码正确性检查
        //<summary>
        //验证码正确性检查
        //</summary>
        //<param name="pstrPhone">电话号码</param>
        //<param name="pstrAuthCode">验证码</param>
        //<param name="pstrAuthType">验证码类型</param>
        public void CheckAuthCode()
        {
            DataTable dtList = ds.Tables["List"];
            string strPhone = dtList.Rows[0]["Phone"].ToString().ToUpper();
            string strAuthCode = dtList.Rows[0]["AuthCode"].ToString().ToUpper();

            if (m_tranFlag == true)
            {
                m_conn.BeginTransaction();
            }
            string strSQL = "";
            //查询一个小时内，最后有效的那个验证码
            strSQL = @"
                                SELECT TOP 1
                                        AuthCode,ID
                                FROM    B01_MDM.[VEXSSOAuthCode]
                                WHERE   phone = @param0
                                        AND AuthCode =@param1
                                        AND authtime IS NULL
                                        AND createtime>DATEADD(HOUR,-1,GETDATE())
                                ORDER BY createtime DESC 

                    ";
            DataTable dt = m_conn.GetDataTable(strSQL, new string[] { strPhone, strAuthCode });

            if (dt.Rows.Count == 0 || strAuthCode != dt.Rows[0]["AuthCode"].ToString())
            {
                throw new Exception("验证码无效或者已过期！");
            }

            //更新验证码信息
            strSQL = @"UPDATE B01_MDM.[VEXSSOAuthCode] SET authtime=GETDATE() WHERE ID=@Param0";

            m_conn.ExcuteQuerryByTran(strSQL, new object[] { dt.Rows[0]["ID"] });

            if (m_tranFlag == true)
            {
                m_conn.CommitTransaction();
            }

            dt_EditResult.Rows.Add(new object[] { true, "验证成功！" });
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion


        public static void Send(string pstrPhoneNumber, string pstrContent)
        {
            pstrPhoneNumber = pstrPhoneNumber.Replace("'", "");
            pstrContent = pstrContent.Replace("'", "");

            Dbconn conn = new Dbconn("SMS");
            string strSQL = @"
                EXEC SMS.DBO.sp_smstosend 'SMS', 'POS', '" + pstrPhoneNumber + @"', '', '" + pstrContent + @"', '" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + @"',
                    '4', '' ;
                EXEC SMS.DBO.sp_smspush_phone '" + pstrPhoneNumber + @"';
            ";
            conn.Excute(strSQL);
        }


        #endregion
    }

}