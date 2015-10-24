using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：VexSSOAccreditatio
/// 类说明：SSO账户认证
/// 创建人：马卫清
/// 创建日期：2014-07-30
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.SSO
{

    public class VexSSOAccreditatio : LogicBase, ILogicExecute
    {
        #region 构造函数
        public VexSSOAccreditatio()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量
        private Dbconn m_conn = new Dbconn("VexSSO");

        private bool m_Result = false;

        
        private HZYmessage m_AccreditatioSystemHZYMessage = new HZYmessage();

        /// <summary>
        /// 认证成功后，返回的基本信息
        /// </summary>
        public HZYmessage AccreditatioSystemHZYMessage
        {
            get { return m_AccreditatioSystemHZYMessage; }
            set { m_AccreditatioSystemHZYMessage = value; }
        }

        private string m_accreditatioType = "";
        private string m_UserName = "";
 
        private bool m_MD5 = false;

        /// <summary>
        /// 是否进入MD5认证
        /// </summary>
        public bool MD5
        {
            get { return m_MD5; }
            set { m_MD5 = value; }
        }

        /// <summary>
        /// 待认证系统帐户
        /// </summary>
        public string UserName
        {
            get { return m_UserName; }
            set { m_UserName = value; }
        }
        private string m_PassWord = "";

        /// <summary>
        /// 待认证系统密码
        /// </summary>
        public string PassWord
        {
            get { return m_PassWord; }
            set { m_PassWord = value; }
        }

        /// <summary>
        /// 待认证系统环境SN
        /// </summary>
        public string AccreditatioType
        {
            get { return m_accreditatioType; }
            set { m_accreditatioType = value; }
        }

        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            try
            {


                if (m_request != null)
                {
                    m_accreditatioType = m_request.Tables[0].Rows[0]["accreditatioType"].ToString();
                    m_UserName = m_request.Tables[0].Rows[0]["UserName"].ToString();
                    m_PassWord = m_request.Tables[0].Rows[0]["PassWord"].ToString();
                }


                switch (m_accreditatioType.ToUpper())
                {
                    case "VEXSSO":
                        CheckVEXSSO();
                        break;
                    case "AM":
                        CheckAM();
                        break;
                    case "EHRCARD":
                        CheckEHRCARD();
                        break;
                    case "3SWECHAT": //S3微信平台
                        Check3SWeChat();
                        break;
                    case "ITDCWECHAT": //ITDC微信平台
                        CheckITDCWeChat();
                        break;
                    case "POSEMPLOYEE": //POS导购人员
                        CheckPOSEmployee();
                        break;
                    default:
                        CheckDefault();//以默认方式进行认证
                        break;
                }

                return m_Result;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region  内部函数

        #region CheckAM 小翅膀认证
        /// <summary>
        /// 小翅膀认证
        /// </summary>
        private void CheckAM()
        {
            if (m_PassWord == "")
            {
                throw new Exception("密码不能为空");
            }

            if (m_UserName == "")
            {
                throw new Exception("用户名不能为空");

            }

            m_conn = new Dbconn("AM");
           
            string strSQL = @"
                                SELECT  cn_id AS App_UserID ,
                                        CN_LOGIN AS App_UserName ,
                                        CN_USER_NAME AS App_UserName_CN ,
                                         CN_PASSWORD
                                FROM    dbo.TN_SYS_EM_USER t1 ,
                                        dbo.TN_SYS_EM_USER_PROP t2
                                WHERE   t1.cn_id = t2.CN_USERID
	                                AND ISNULL(CN_ISDELETE,0)=0
	                                AND CN_LOGIN=@param0
	                                
        ";
            DataTable dt = m_conn.GetDataTable(strSQL, new string[] { m_UserName, m_PassWord });
            if (dt.Rows.Count == 0)
            {
                m_Result = false;
                throw new Exception("小翅膀的账户密码错误！");
            }
            else
            {
                string strPassWordDB = dt.Rows[0]["CN_PASSWORD"].ToString();
                if (m_MD5)
                {
                    strPassWordDB = Common.Common.GetMD5(strPassWordDB);
                }

                if (strPassWordDB != m_PassWord)
                {
                    m_Result = false;
                    throw new Exception("小翅膀的账户密码错误！");
                }

                this.m_AccreditatioSystemHZYMessage.User_ID = dt.Rows[0]["App_UserID"].ToString();
                this.m_AccreditatioSystemHZYMessage.User_Name = dt.Rows[0]["App_UserName"].ToString();
                this.m_AccreditatioSystemHZYMessage.User_Name_CN = dt.Rows[0]["App_UserName_CN"].ToString();
                m_Result = true;
            }
        }
        #endregion

        #region CheckDefault 以默认方式进行认证
        /// <summary>
        /// 以默认方式进行认证
        /// </summary>
        private void CheckDefault()
        {
            if (m_PassWord == "")
            {
                throw new Exception("密码不能为空");
            }

            if (m_UserName == "")
            {
                throw new Exception("用户名不能为空");

            }

            m_conn = new Dbconn("VexSSO");
           
            string strSQL = @"
                                SELECT  [App_UserID] ,
                                        [App_UserName] ,
                                        [App_UserName_CN] ,
                                        App_Password,App_PasswordSrc
                                FROM    [VexSSO].[dbo].[MDM_System_User] t1
                                WHERE   ISNULL(Checked, 0) = 1
                                        AND App_UserName = @Param0
                                        AND EXISTS ( SELECT 1
                                                     FROM   dbo.MDM_System_Env t2
                                                     WHERE  t2.Env_ID = t1.Env_ID
                                                            AND t2.Env_SN = @Param1 )
        ";
            DataTable dt = m_conn.GetDataTable(strSQL, new string[] { m_UserName, m_accreditatioType });
            if (dt.Rows.Count == 0)
            {
                m_Result = false;
                throw new Exception("账户错误！");
            }
            else
            {
                string strPassWordDBMD5 = dt.Rows[0]["App_Password"].ToString();
                string strPassword = m_PassWord;

                if (!m_MD5)
                {
                    strPassword = Common.Common.GetMD5(strPassword);

                }

                if (strPassWordDBMD5 != strPassword)
                {
                    m_Result = false;
                    throw new Exception("密码错误！");
                }

                this.m_AccreditatioSystemHZYMessage.User_ID = dt.Rows[0]["App_UserID"].ToString();
                this.m_AccreditatioSystemHZYMessage.User_Name = dt.Rows[0]["App_UserName"].ToString();
                this.m_AccreditatioSystemHZYMessage.User_Name_CN = dt.Rows[0]["App_UserName_CN"].ToString();
                m_Result = true;
            }
        }
        #endregion

        #region CheckEHRCARD EHR身份认证
        /// <summary>
        /// EHR身份认证
        /// </summary>
        private void CheckEHRCARD()
        {
            if (m_UserName == "")
            {
                throw new Exception("姓名不能为空");

            }
            if (m_PassWord == "")
            {
                throw new Exception("身份证号不能为空");
            }


            m_conn = new Dbconn("EHR");

            string strSQL = @"
                    SELECT C_NAME FROM ehr.TB_INF_EMPLOYEE
                    WHERE C_employeestatus<>3
                    AND C_NAME=@Param0
                    AND C_IDCARD=@Param1
            ";
            DataTable dt = m_conn.GetDataTable(strSQL, new string[] { m_UserName, m_PassWord });
            if (dt.Rows.Count == 0)
            {
                m_Result = false;
                throw new Exception("EHR的身份认证信息错误！");
            }
            else
            {
                this.m_AccreditatioSystemHZYMessage.User_ID = dt.Rows[0]["C_NAME"].ToString();
                this.m_AccreditatioSystemHZYMessage.User_Name = dt.Rows[0]["C_NAME"].ToString();
                this.m_AccreditatioSystemHZYMessage.User_Name_CN = dt.Rows[0]["C_NAME"].ToString();
                m_Result = true;
            }
        }
        #endregion

        #region CheckS3WeChat S3微信平台身份认证
        /// <summary>
        /// S3微信平台身份认证
        /// </summary>
        private void Check3SWeChat()
        {

            this.m_AccreditatioSystemHZYMessage.User_ID = m_UserName;
            this.m_AccreditatioSystemHZYMessage.User_Name = m_UserName;
            this.m_AccreditatioSystemHZYMessage.User_Name_CN = "";

            m_Result = true;
        }
        #endregion

        #region CheckITDCWeChat ITDC微信平台身份认证
        /// <summary>
        /// S3微信平台身份认证
        /// </summary>
        private void CheckITDCWeChat()
        {

            this.m_AccreditatioSystemHZYMessage.User_ID = m_UserName;
            this.m_AccreditatioSystemHZYMessage.User_Name = m_UserName;
            this.m_AccreditatioSystemHZYMessage.User_Name_CN = "";

            m_Result = true;
        }
        #endregion

        #region CheckVEXSSO VEXSSO认证
        /// <summary>
        /// VEXSSO认证
        /// </summary>
        private void CheckVEXSSO()
        {
            if (m_PassWord == "")
            {
                throw new Exception("密码不能为空");
            }

            if (m_UserName == "")
            {
                throw new Exception("用户名不能为空");

            }

            m_conn = new Dbconn("VexSSO");
            string strSQL = @"
                    SELECT t1.[VexSSOLoginUser],t2.Name,t1.VexSSONewID, VexSSOPassWord
                     FROM   B01_MDM.[VEXSSOUser] t1 WITH(NOLOCK)
                     LEFT JOIN B01_MDM.VexSSOUserInfo t2 WITH(NOLOCK) ON t2.VexSSONewId = t1.VexSSONewID
                     WHERE  VexSSOLoginUser = @param0 
                            AND ISNULL(Disabled, 0) = 0
            ";

            DataTable dt = m_conn.GetDataTable(strSQL, new string[] { m_UserName, m_PassWord });
            if (dt.Rows.Count == 0)
            {
                m_Result = false;
                throw new Exception("SSO户或者密码错误！");
            }
            else
            {
                string strPassWordDB = dt.Rows[0]["VexSSOPassWord"].ToString();

                if (m_MD5)
                {
                    strPassWordDB = Common.Common.GetMD5(strPassWordDB);
                }

                if (strPassWordDB != m_PassWord)
                {
                    m_Result = false;
                    throw new Exception("SSO户或者密码错误！");
                }
                //this.m_AccreditatioSystemHZYMessage.VexSSONewID = dt.Rows[0]["VexSSONewID"].ToString();
                this.m_AccreditatioSystemHZYMessage.User_ID = dt.Rows[0]["VexSSONewID"].ToString();
                this.m_AccreditatioSystemHZYMessage.User_Name = dt.Rows[0]["VexSSOLoginUser"].ToString();
                this.m_AccreditatioSystemHZYMessage.User_Name_CN = dt.Rows[0]["Name"].ToString();
                m_Result = true;
            }
        }
        #endregion

        #region CheckPOSEmployee POS导购人员认证
        /// <summary>
        /// POS导购人员认证
        /// </summary>
        private void CheckPOSEmployee()
        {
            if (m_UserName == "")
            {
                throw new Exception("导购编号不能为空");
            }

            if (m_PassWord == "")
            {
                throw new Exception("导购姓名不能为空");
            } 

            m_conn = new Dbconn("F22GP");

            string strSQL = @"
                SELECT  1 AS a
                FROM    j_employee t1 ,
                        j_depot t2
                WHERE   t1.depotid = t2.depotid
                        AND t1.valid = 0   --0在岗 1离职
		                AND employeeid=@param0
		                AND names=@param1
            ";
            DataTable dt = m_conn.GetDataTable(strSQL, new string[] { m_UserName, m_PassWord });
            if (dt.Rows.Count == 0)
            {
                m_Result = false;
                throw new Exception("POS导购信息不匹配！");
            }
            else
            {
                this.m_AccreditatioSystemHZYMessage.User_ID = m_UserName;
                this.m_AccreditatioSystemHZYMessage.User_Name = m_UserName;
                this.m_AccreditatioSystemHZYMessage.User_Name_CN = m_PassWord;
                m_Result = true;
            }
        }
        #endregion

        #region CheckPosUser POS用户认证
        /// <summary>
        /// POS用户认证
        /// </summary>
        private void CheckPosUser()
        {
            if (m_UserName == "")
            {
                throw new Exception("用户名不能为空");
            }

            if (m_PassWord == "")
            {
                throw new Exception("密码不能为空");
            }

            m_conn = new Dbconn("F22GP");

            string strSQL = @" SELECT   
                                b.userid AS App_UserName ,
                                RIGHT(sys.fn_VarBinToHexStr(hashbytes('MD5', CONVERT(VARCHAR(100), b.password))), 32) AS App_Password ,
                                b.password AS App_PasswordSrc ,
                                CASE WHEN b.dptype <> 0 THEN ISNULL(a.depotid,'') + '_' + d_name ELSE b.username END  AS App_UserName_CN 
                        FROM    
                                j_user b with(nolock)
                                LEFT JOIN j_depot a with(nolock) ON a.depotid = b.depotid
                        WHERE b.userid=@param0 and RIGHT(sys.fn_VarBinToHexStr(hashbytes('MD5', CONVERT(VARCHAR(100), b.password))), 32)=@param1
                     ";
            DataTable dt = m_conn.GetDataTable(strSQL, new string[] { m_UserName, m_PassWord });
            if (dt.Rows.Count == 0)
            {
                m_Result = false;
                throw new Exception("POS用户信息不正确！");
            }
            else
            {
                this.m_AccreditatioSystemHZYMessage.User_ID = dt.Rows[0]["App_UserName"].ToString();
                this.m_AccreditatioSystemHZYMessage.User_Name = dt.Rows[0]["App_UserName"].ToString();
                this.m_AccreditatioSystemHZYMessage.User_Name_CN = dt.Rows[0]["App_UserName_CN"].ToString();
                m_Result = true;
            }
        }
        #endregion


        #endregion
    }

}