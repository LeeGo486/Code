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
/// 创建日期：2015-03-03
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.CommonInterface
{

    public class MsgCenter : LogicBase, ILogicGetData
    {
        #region 构造函数
        public MsgCenter()
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
                string strOPTYPE = dt_OPTYPE.Rows[0][0].ToString().ToUpper();//类型

                if (strOPTYPE == "GetAuthCode".ToUpper())      //获取验证码
                {
                    GetAuthCode();
                }
                else if (strOPTYPE == "CheckAuthCode".ToUpper())      //验证验证码
                {
                    CheckAuthCode();
                }
                else if (strOPTYPE == "SendAM".ToUpper())      //小翅膀发送
                {
                    SendAM();
                }
                else if (strOPTYPE == "SendSMS".ToUpper())      //短信发送
                {
                    SendSMS();
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

        #region  内部函数

        #region 手机短信发送,验证码验证

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
            string strAuthType = dtList.Rows[0]["AuthType"].ToString().ToUpper();//获取短信发送类型
            string strContent = "";//主题
            string strAuthCode = "";//验证码
            string strPhone = dtList.Rows[0]["Phone"].ToString().ToUpper();//手机短信
            string strSystem = dtList.Rows[0]["System"].ToString().ToUpper();//系统
            string strCom = dtList.Rows[0]["Com"].ToString().ToUpper();//公司

            if (strAuthType == "")
            {
                throw new Exception("AuthType不能为空！");
            }
            if (strPhone == "")
            {
                throw new Exception("Phone不能为空！");
            }
            if (strSystem == "")
            {
                throw new Exception("系统不能为空！");
            }
            if (strCom == "")
            {
                throw new Exception("公司不能为空！");
            }
            if (m_tranFlag == true)
            {
                m_conn.BeginTransaction();
            }

            Random ra = new Random();
            strAuthCode = ra.Next(1000, 9999).ToString();
            strContent = "验证码：" + strAuthCode + "，请勿向任何人提供您收到的验证码。（有效期：1小时）";
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

            Send(strSystem, strPhone, strContent, strCom);

            if (m_tranFlag == true)
            {
                m_conn.CommitTransaction();
            }

            dt_EditResult.Rows.Add(new object[] { true, "发送成功！" });
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

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

        #endregion

        #region  SendAM 发送小翅膀
        /// <summary>
        /// SendAM 发送小翅膀
        /// </summary>
        private void SendAM()
        {
            DataTable dtList = ds.Tables["List"];
            //string strSystem, string pstrReceiver, string pstrSender, string pstrContent, string pstrstrCom
            //认证类型
            string strSystem = dtList.Rows[0]["System"].ToString().ToUpper();
            string strReceiver = dtList.Rows[0]["Receiver"].ToString().ToUpper();
            string strSender = dtList.Rows[0]["Sender"].ToString().ToUpper();
            string strContent = dtList.Rows[0]["Content"].ToString().ToUpper();
            string strCom = dtList.Rows[0]["Com"].ToString().ToUpper();

            if (strSystem == "")
            {
                throw new Exception("所属系统不能为空！");
            }
            if (strReceiver == "")
            {
                throw new Exception("接收者不能为空！");
            }
            if (strSender == "")
            {
                throw new Exception("发送者不能为空！");
            }
            if (strContent == "")
            {
                throw new Exception("主题不能为空！");
            }
            if (m_tranFlag == true)
            {
                m_conn.BeginTransaction();
            }

            m_conn.BeginTransaction();

            strContent = strContent.Replace("'", "");
            string strSQL = @"
                EXEC SMS.DBO.sp_smstosend 'AM', '" + strSystem + "', '" + strReceiver + "', '" + strSender + "', '" + strContent + @"', '"
                                                    + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + strCom + @"', '' ;";
            conn.Excute(strSQL);

            m_conn.CommitTransaction();

            dt_EditResult.Rows.Add(new object[] { true, "发送成功！" });
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #region  SendSMS 短信发送
        /// <summary>
        /// 短信发送
        /// </summary>
        private void SendSMS()
        {
            DataTable dtList = ds.Tables["List"];

            string strSQL = "";
            int nCount = 0;

            //认证类型
            string strAuthType = dtList.Rows[0]["AuthType"].ToString().ToUpper();//获取短信发送类型
            string strContent = dtList.Rows[0]["Content"].ToString().ToUpper();//主题
            string strPhone = dtList.Rows[0]["Phone"].ToString().ToUpper();//手机短信
            string strSystem = dtList.Rows[0]["System"].ToString().ToUpper();//系统
            string strCom = dtList.Rows[0]["Com"].ToString().ToUpper();//公司
            strSystem = "POS";
            if (strPhone == "")
            {
                throw new Exception("Phone不能为空！");
            }
            if (strSystem == "")
            {
                throw new Exception("系统不能为空！");
            }
            if (strCom == "")
            {
                throw new Exception("公司不能为空！");
            }
            if (m_tranFlag == true)
            {
                m_conn.BeginTransaction();
            }

            Send(strSystem, strPhone, strContent, strCom);

            if (m_tranFlag == true)
            {
                m_conn.CommitTransaction();
            }

            dt_EditResult.Rows.Add(new object[] { true, "发送成功！" });
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 短信发送接口
        /// <summary>
        /// 短信发送接口
        /// </summary>
        /// <param name="所属系统"></param>
        /// <param name="手机号"></param> 
        /// <param name="主题"></param> 
        /// <param name="公司"></param> strSystem  strCom
        public static void Send(string strSystem, string pstrPhoneNumber, string pstrContent, string strCom)
        {
            pstrPhoneNumber = pstrPhoneNumber.Replace("'", "");
            pstrContent = pstrContent.Replace("'", "");

            Dbconn conn = new Dbconn("SMS");
            string strSQL = @"
                EXEC SMS.DBO.sp_smstosend 'SMS', '" + strSystem + "', '" + pstrPhoneNumber + "', '', '" + pstrContent + @"', '"
                                                    + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + strCom + @"', '' ;
                EXEC SMS.DBO.sp_smspush_phone '" + pstrPhoneNumber + @"';";
            conn.Excute(strSQL);
        }

        #endregion

        #endregion

        #region 外部函数

        #region SendSMS 发送短信
        /// <summary>
        /// SendSMS 发送短信
        /// </summary>
        /// <param name="strSystem"></param>
        /// <param name="pstrPhoneNumber"></param>
        /// <param name="pstrContent"></param>
        /// <param name="strCom"></param>
        /// <returns></returns>
        public bool SendSMS(string pstrSystem, string pstrPhoneNumber, string pstrContent, string pstrCom)
        {
            pstrPhoneNumber = pstrPhoneNumber.Replace("'", "");
            pstrContent = pstrContent.Replace("'", "");
            int iResult = -1;
            Dbconn conn = new Dbconn("SMS");
            string strSQL = @"
                EXEC SMS.DBO.sp_smstosend 'SMS', '" + pstrSystem + "', '" + pstrPhoneNumber + "', '', '" + pstrContent + @"', '"
                                                    + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + pstrCom + @"', '' ;
                EXEC SMS.DBO.sp_smspush_phone '" + pstrPhoneNumber + @"';";
            iResult = conn.Excute(strSQL);

            if (iResult > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        #endregion

        #region SendAM 发送小翅膀
        /// <summary>
        /// SendAM
        /// </summary>
        public bool CheckUserExist(string pstrSystem, string pstrReceiver, string pstrSender, string pstrContent, string pstrCom)
        {
            int iResult = -1;
            string strSQL = @"
                EXEC SMS.DBO.sp_smstosend 'AM', '" + pstrSystem + "', '" + pstrReceiver + "', '" + pstrSender + "', '" + pstrContent + @"', '"
                                                    + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + pstrCom + @"', '' ;";
            iResult = conn.Excute(strSQL);

            if (iResult > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        #endregion

        #endregion
    }
}