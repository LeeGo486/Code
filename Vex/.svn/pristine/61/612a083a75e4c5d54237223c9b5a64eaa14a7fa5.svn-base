using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：VexSSOAuthCode
/// 类说明：SSO验证码相关操作
/// 创建人：马卫清
/// 创建日期：2014-07-31
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.SSO
{

    public class VexSSOAuthCode : LogicBase, ILogicGetData
    {
        #region 构造函数
        public VexSSOAuthCode()
        {
            this.m_SessionCheck = false;

        }
        #endregion

        #region 内部变量
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
                return m_dsRequturn;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 外部函数

        #region 验证码正确性检查
        /// <summary>
        /// 验证码正确性检查
        /// </summary>
        /// <param name="pstrPhone">电话号码</param>
        /// <param name="pstrAuthCode">验证码</param>
        /// <param name="pstrAuthType">验证码类型</param>
        public void CheckAuthCode(string pstrPhone, string pstrAuthCode, string pstrAuthType)
        {
            
            if (m_tranFlag == true)
            {
                m_conn.BeginTransaction();
            }
            string strSQL = "";

            //用户注册
            if (pstrAuthType.ToUpper() == "SignUp".ToUpper())
            {
                //目前注册的时候不使用验证码，直接返回
                if (m_tranFlag == true)
                {
                    m_conn.CommitTransaction();
                }
                return;
                //目前注册的时候不使用验证码，直接返回


                //查询一个小时内，最后有效的那个验证码
                strSQL = @"
                                SELECT TOP 1
                                        AuthCode,ID
                                FROM    B01_MDM.[VEXSSOAuthCode]
                                WHERE   type = @param0
                                        AND phone = @param1
                                        AND authtime IS NULL
                                        AND createtime>DATEADD(HOUR,-1,GETDATE())
                                ORDER BY createtime DESC 

                    ";
                
                
            }
            else if (pstrAuthType.ToUpper() == "getPassword".ToUpper())
            {
                //查询一个小时内，最后有效的那个验证码
                strSQL = @"
                                SELECT TOP 1
                                        AuthCode,ID
                                FROM   B01_MDM.[VEXSSOAuthCode]
                                WHERE   type = @param0
                                        AND phone = @param1
                                        AND authtime IS NULL
                                        AND createtime>DATEADD(HOUR,-1,GETDATE())
                                ORDER BY createtime DESC  
                    ";

            }
            else
            {
                throw new Exception("验证类型不支持！");
            }


            DataTable dt = m_conn.GetDataTable(strSQL, new string[] { pstrAuthType, pstrPhone });

            if (dt.Rows.Count == 0 || pstrAuthCode != dt.Rows[0]["AuthCode"].ToString())
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
        }
        #endregion

        #endregion

        #region  内部函数

        #region  GetAuthCode 获取验证码
        /// <summary>
        /// 获取验证码
        /// </summary>
        private void GetAuthCode()
        {
            DataTable dtList = ds.Tables["List"];
            DataTable dtVexSSO = new MDM.VEXSSOUserDataTable();

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

            //用户注册
            if (strAuthType.ToUpper() == "signup".ToUpper())
            {
                //判断手机是否已经被注册
                VexSSOUser cls = new VexSSOUser();
                if (cls.CheckUserExist(strPhone))
                {
                    throw new Exception("该手机号已注册，请使用找回密码功能。");
                }
                Random ra = new Random();
                strAuthCode = ra.Next(1000, 9999).ToString();

                strContent = "您正在申请注册单点登录账户，验证码：" + strAuthCode + "，请勿向任何人提供您收到的验证码。（有效期：1小时）";

            }
            else if (strAuthType.ToUpper() == "getPassword".ToUpper())
            {
                //判断手机是否已经被注册
                VexSSOUser cls = new VexSSOUser();
                if (!cls.CheckUserExist(strPhone))
                {
                    throw new Exception("手机号还末注册帐户，请先注册。");
                }
                Random ra = new Random();
                strAuthCode = ra.Next(1000, 9999).ToString();

                strContent = "您正在申请单点登录账户密码取回，验证码：" + strAuthCode + "，请勿向任何人提供您收到的验证码。（有效期：1小时）";
                
            }
            else
            {
                throw new Exception("认证类型不支持！");
            }

            DataTable dtAuthCode = new MDM.VEXSSOAuthCodeDataTable();
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
            
            HZY.COM.WS.AM.SMSSendImmediately.Send(strPhone, strContent);

            if (m_tranFlag == true)
            {
                m_conn.CommitTransaction();
            }


            dt_EditResult.Rows.Add(new object[] { true, "发送成功！" });
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #endregion
    }

}