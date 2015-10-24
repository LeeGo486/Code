using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：VexSSOUser
/// 类说明：SSO帐户相关操作：绑定，解绑，注册
/// 创建人：马卫清
/// 创建日期：2014-07-30
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.SSO
{

    public class VexSSOUser : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public VexSSOUser()
        {
            this.m_SessionCheck = false;

        }
        #endregion

        #region 内部变量
        private Dbconn m_conn = new Dbconn("VexSSO");
        DataSet ds = new DataSet();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_dsRequturn = new DataSet();

        private bool m_SSOCheck = false;

        private HZYmessage m_BindsysInfo = new HZYmessage();
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
                //事务开始
                m_conn.BeginTransaction();

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "SignUp".ToUpper())      //用户注册
                {
                    SignUp();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Bind".ToUpper()) //帐户绑定
                {
                    Bind();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "UnBind".ToUpper()) //帐户解除绑定
                {
                    UnBind();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Destroy".ToUpper()) //帐户注销
                {
                    Destroy();
                }

                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetPassWord".ToUpper()) //密码取回
                {
                    GetPassWord();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetUserInfo".ToUpper()) //获取用户信息
                {
                    GetUserInfo();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetBindLog".ToUpper()) //获取绑定日志
                {
                    GetBindLog();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetEhrInfo".ToUpper()) //获取Ehr用户信息
                {
                    GetEhrInfo();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetPosPOSEmployee".ToUpper()) //获取Pos导购信息信息
                {
                    GetPosPOSEmployee();
                }
                else
                {
                    throw new Exception("操作类型不支持！");
                }
                //事务提交 --注意：不能移动到每个方法里面，这里面的方法会有互相调用的情况
                m_conn.CommitTransaction();

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

        #region CheckUserExist
        /// <summary>
        /// CheckUserExist
        /// </summary>
        public bool CheckUserExist(string pStrUser)
        {
            string strSQL = @"SELECT 1 AS A FROM B01_MDM.VEXSSOUser WHERE 
                            VexSSOLoginUser=@Param0
                            AND Disabled=0";

            if (m_conn.GetDataTableRowCount(strSQL, new string[] { pStrUser }) > 0)
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

        #region  内部函数

        #region  SignUp 用户注册
        /// <summary>
        /// 用户注册
        /// </summary>
        private void SignUp()
        {
            DataTable dtList = ds.Tables["List"];
            DataTable dtVexSSO = new MDM.VEXSSOUserDataTable();

            int nCount = 0;

            VexSSOAccreditatio clsVexSSOAccreditatio = new VexSSOAccreditatio();

            string strVexSSOLoginUser = dtList.Rows[0]["LoginUser"].ToString();
            string strAuthCode = dtList.Rows[0]["AuthCode"].ToString();
            string strAccreditationType = "";
            if (dtList.Columns.Contains("AccreditationType"))
            {
                strAccreditationType = dtList.Rows[0]["AccreditationType"].ToString().ToUpper();
            }

            if (strVexSSOLoginUser == "")
            {
                throw new Exception("SSO用户名不能为空。");
            }

            if (dtList.Rows[0]["PassWord"].ToString() == "")
            {
                throw new Exception("SSO密码不能为空。");
            }

            //验证码是否正确
            if (strAuthCode == "")
            {
                throw new Exception("验证码不能为空。");
            }
            else
            {
                VexSSOAuthCode cls = new VexSSOAuthCode();
                cls.Conn = m_conn;
                cls.CheckAuthCode(strVexSSOLoginUser, strAuthCode, "SignUp");
            }

            nCount = m_conn.GetDataTableRowCount(@"SELECT 1 AS A FROM B01_MDM.[VEXSSOUser] WHERE 
                                                    VexSSOLoginUser=@PARAM0 AND ISNULL(Disabled,0)=0", new string[] { strVexSSOLoginUser });
            if (nCount > 0)
            {
                throw new Exception("该手机号码已被注册！");
            }

            string strVexSSONewID = Guid.NewGuid().ToString();
            DataRow dr = dtVexSSO.NewRow();
            dr["VexSSONewID"] = strVexSSONewID;
            dr["VexSSOLoginUser"] = strVexSSOLoginUser;
            dr["VexSSOPassWord"] = dtList.Rows[0]["PassWord"];
            dr["VexSSOPassWordMd52"] = Common.Common.GetMD5(Common.Common.GetMD5(dr["VexSSOPassWord"].ToString()));
            dr["Disabled"] = "0";

            dtVexSSO.Rows.Add(dr);

            m_conn.HZYMessage = this.hzyMessage;
            m_conn.InsertByVex("B01_MDM.VEXSSOUser", dtVexSSO);


            if (strAccreditationType.Trim() != "")
            {
                m_SSOCheck = false;
                this.Bind();//进行账户绑定

                //更新Info表的用户姓名
                DataTable dtInfo = new MDM.VexSSOUserInfoDataTable();
                DataRow drInfo = dtInfo.NewRow();
                drInfo["VexSSONewId"] = strVexSSONewID;
                drInfo["Name"] = m_BindsysInfo.User_Name_CN;
                dtInfo.Rows.Add(drInfo);

                m_conn.InsertByVex("B01_MDM.VexSSOUserInfo", dtInfo);
            }

            dt_EditResult.Clear(); //清除在绑定时写入的信息
            m_dsRequturn = new DataSet();
            dt_EditResult.Rows.Add(new object[] { true, "注册成功！" });

            m_dsRequturn.Tables.Add(dt_EditResult.Copy());
        }
        #endregion

        #region  Bind 帐户绑定
        /// <summary>
        /// 帐户绑定
        /// </summary>
        private void Bind()
        {
            DataTable dtList = ds.Tables["List"];
            DataTable dtVexSSO = new MDM.VEXSSOUserDataTable();

            VexSSOAccreditatio clsVexSSOAccreditatio = new VexSSOAccreditatio();
            string strSQL = "";

            string strVexSSOLoginUser = dtList.Rows[0]["LoginUser"].ToString();

            string strVexSSOPassWord = "";
            if (dtList.Columns.Contains("PassWord"))
            {
                strVexSSOPassWord = dtList.Rows[0]["PassWord"].ToString();
            }
            string strBindUser = dtList.Rows[0]["BindUser"].ToString();
            string strBindPassWord = dtList.Rows[0]["BindPassWord"].ToString();
            string strAccreditationType = dtList.Rows[0]["AccreditationType"].ToString().ToUpper();

            string strResult = "";

            try
            {
                if (strVexSSOLoginUser == "")
                {
                    strResult = "SSO用户名不能为空。";
                    throw new Exception(strResult);
                }


                if (strAccreditationType.ToUpper() == "VEXSSO")
                {

                    strResult = "VEXSSOSSO不能绑定。";
                    throw new Exception(strResult);
                }

                //POS导购人员
                if (strAccreditationType.ToUpper() == "POSEmployee".ToUpper())
                {
                    //查询EHR的姓名
                    strSQL = @"
                    SELECT  App_UserName
                    FROM    dbo.MDM_System_User t1
                    WHERE   ISNULL(checked,0) =1 
                            AND EXISTS ( SELECT 1
                                        FROM   dbo.MDM_System_Env t2
                                        WHERE  Env_SN = 'EHRCARD'
                                            AND t1.Env_ID = t2.Env_ID )
                            AND EXISTS ( SELECT 1
                                            FROM   B01_MDM.VEXSSOUser t3
                                            WHERE  t1.VexSSONewID = t3.VexSSONewID
                                                AND ISNULL(Disabled,0)=0
                                                AND t3.VexSSOLoginUser =@Param0 )
            ";

                    string strEhrName = m_conn.GetDataTableFirstValue(strSQL, new string[] { strVexSSOLoginUser }).ToString();
                    if (strEhrName == "")
                    {
                        strResult = "请先绑定EHR帐户。";
                        throw new Exception(strResult);
                    }

                    strBindPassWord = strEhrName;
                }

                //进行绑定账户认证
                clsVexSSOAccreditatio.PassWord = strBindPassWord;
                clsVexSSOAccreditatio.UserName = strBindUser;
                clsVexSSOAccreditatio.AccreditatioType = strAccreditationType;
                clsVexSSOAccreditatio.Execute(); //进行认证。
                m_BindsysInfo = clsVexSSOAccreditatio.AccreditatioSystemHZYMessage;

                //进行VEXSSO认证
                if (m_SSOCheck)
                {
                    clsVexSSOAccreditatio.PassWord = strVexSSOPassWord;
                    clsVexSSOAccreditatio.UserName = strVexSSOLoginUser;
                    clsVexSSOAccreditatio.AccreditatioType = "VEXSSO";
                    clsVexSSOAccreditatio.Execute(); //进行认证。
                }

                //开始进行绑定
                string strEnvID = m_conn.GetDataTableFirstValue("SELECT Env_ID FROM dbo.MDM_System_env WHERE Env_SN=@param0", new string[] { strAccreditationType }).ToString();

                if (strEnvID == "")
                {
                    strResult = "系统错误：待绑定的系统不存在！";
                    throw new Exception(strResult);
                }

                string strVexSSONewID = m_conn.GetDataTableFirstValue("SELECT  [VexSSONewID]  FROM B01_MDM.[VEXSSOUser] WHERE VexSSOLoginUser=@Param0 AND ISNULL(Disabled,0)=0", new string[] { strVexSSOLoginUser }).ToString(); ;


                //检查VEXSSO账户是否已经被其他用户绑定
                strSQL = @"
                    SELECT VexSSONewID,t1.app_userName,t1.Env_ID FROM dbo.MDM_System_User t1
                    LEFT JOIN dbo.MDM_System_env t2 ON t2.Env_ID = t1.Env_ID
                    WHERE t2.Env_SN=@Param0
                    and isnull(Checked,0)=1
                    AND (t1.VexSSONewID=@Param1)
            ";

                DataTable dtBindInfo = m_conn.GetDataTable(strSQL, new string[] { strAccreditationType, strVexSSONewID });
                if (dtBindInfo.Rows.Count > 0)
                {
                    if (dtBindInfo.Rows[0]["app_userName"].ToString() != strBindUser)
                    {
                        strResult = "该手机号已与帐户：" + dtBindInfo.Rows[0]["app_userName"].ToString() + "绑定";
                        throw new Exception(strResult);
                    }
                    else //更新成绑定的最新数据。2014-10-07添加，主要避免有用户修改身份证号或者更新密码的问题
                    {
                        string strEnvIDTemp = dtBindInfo.Rows[0]["Env_ID"].ToString();
                        DataTable dt = new DataTable();
                        dt.Columns.Add("App_PasswordSrc");
                        dt.Columns.Add("App_Password");
                        dt.Rows.Add(new object[] { strBindPassWord.ToUpper(), Common.Common.GetMD5(strBindPassWord.ToUpper()) });
                        string strWHERE = "Env_ID='" + strEnvIDTemp + "' and isnull(Checked,0)=1 AND VexSSONewID='" + strVexSSONewID + "'";
                        m_conn.Update("MDM_System_User", dt, strWHERE);
                    }

                }
                else
                {

                    //检查系统用户是否被其他的VEXSSO帐户绑定
                    if (strAccreditationType.ToUpper() == "EHRCARD")
                    {
                        strSQL = @"
                    SELECT VexSSONewID,t1.app_userName FROM dbo.MDM_System_User t1
                    LEFT JOIN dbo.MDM_System_env t2 ON t2.Env_ID = t1.Env_ID
                    WHERE t2.Env_SN=@Param0
                    and isnull(Checked,0)=1
                    AND (t1.App_PasswordSrc=@Param2)
                ";
                    }
                    else
                    {
                        strSQL = @"
                    SELECT VexSSONewID,t1.app_userName FROM dbo.MDM_System_User t1
                    LEFT JOIN dbo.MDM_System_env t2 ON t2.Env_ID = t1.Env_ID
                    WHERE t2.Env_SN=@Param0
                    and isnull(Checked,0)=1
                    AND (t1.App_UserName=@Param1)
                ";
                    }

                    dtBindInfo = m_conn.GetDataTable(strSQL, new string[] { strAccreditationType, strBindUser, strBindPassWord });


                    //说明MDM_System_User不存在该数据，需要插入
                    if (dtBindInfo.Rows.Count == 0)
                    {
                        DataTable dtSystemUser = new MDM.MDM_System_UserDataTable();
                        DataRow dr = dtSystemUser.NewRow();
                        dr["Env_ID"] = strEnvID;
                        dr["VexSSONewID"] = strVexSSONewID;
                        dr["App_UserName"] = strBindUser;
                        dr["App_PasswordSrc"] = strBindPassWord.ToUpper();
                        dr["App_Password"] = Common.Common.GetMD5(strBindPassWord.ToUpper());
                        dr["Checked"] = "1";
                        dr["Check_User"] = "system";
                        dtSystemUser.Rows.Add(dr);
                        m_conn.Insert("MDM_System_User", dtSystemUser);
                    }
                    else
                    {
                        //说明没有绑定，需要更新数据
                        if (dtBindInfo.Rows[0][0].ToString() == "")
                        {
                            DataTable dt = new DataTable();
                            dt.Columns.Add("VexSSONewID");
                            dt.Rows.Add(new object[] { strVexSSONewID });
                            string strWHERE = "Env_ID='" + strEnvID + "' AND App_UserName='" + strBindUser + "'";
                            m_conn.Update("MDM_System_User", dt, strWHERE);
                        }
                        else//说明已经绑定
                        {
                            string strVexSSONewIDExist = dtBindInfo.Rows[0]["VexSSONewID"].ToString();

                            if (strVexSSONewIDExist != "")
                            {
                                strSQL = @"SELECT VexSSOLoginUser FROM B01_MDM.VEXSSOUser WHERE VexSSONewID=@PARAM0 and ISNULL(Disabled, 0) = 0";
                                string strBindedUser = m_conn.GetDataTableFirstValue(strSQL, new string[] { strVexSSONewIDExist }).ToString();

                                //如果是小翅膀，并且是以8开头的数据，说明是默认数据，需要刷新数据
                                if (strAccreditationType == "AM" && strBindedUser.StartsWith("88"))
                                {
                                    //将VEXSSOUser的用户销户，并将小翅膀的绑定变成这个ID
                                    strSQL = @"UPDATE B01_MDM.VEXSSOUser SET Disabled=1,DisabledTime=Getdate() WHERE VexSSONewID=@Param0;
                                    UPDATE MDM_System_User SET VexSSONewID=@Param1 WHERE  VexSSONewID=@Param0;
                                    UPDATE MDM_System_User_Authorization SET VexSSONewID=@Param1 WHERE  VexSSONewID=@Param0
                                    ";
                                    m_conn.ExcuteQuerryByTran(strSQL, new string[] { strVexSSONewIDExist, strVexSSONewID, strEnvID });
                                }
                                else if (strBindedUser == strBindUser)
                                {
                                    //throw new Exception("待绑定的用户已经被手机号：" + strBindedUser + "绑定");

                                }
                                else
                                {
                                    strResult = "待绑定的用户已经被手机号：" + strBindedUser + "绑定";
                                    throw new Exception(strResult);
                                }

                            }
                        }
                    }

                }

                strResult = "绑定成功！";
                dt_EditResult.Rows.Add(new object[] { true, "绑定成功！" });
                m_dsRequturn.Tables.Add(dt_EditResult);
            }
            catch (Exception ex)
            {
                strResult = ex.Message;
                throw ex;
            }
            finally
            {
                WriteBindLog(strVexSSOLoginUser, strVexSSOPassWord, strAccreditationType, strBindUser,
                    strBindPassWord, strResult);
            }

        }
        #endregion

        #region  UnBind 帐户解除绑定
        /// <summary>
        /// 帐户解除绑定
        /// </summary>
        private void UnBind()
        {
            DataTable dtList = ds.Tables["List"];
            DataTable dtVexSSO = new MDM.VEXSSOUserDataTable();

            VexSSOAccreditatio clsVexSSOAccreditatio = new VexSSOAccreditatio();
            string strSQL = "";

            string strVexSSOLoginUser = dtList.Rows[0]["LoginUser"].ToString();

            //string strVexSSOPassWord = "";
            //if (dtList.Columns.Contains("PassWord"))
            //{
            //    strVexSSOPassWord = dtList.Rows[0]["PassWord"].ToString();
            //}
            string strBindUser = dtList.Rows[0]["BindUser"].ToString();
            //string strBindPassWord = dtList.Rows[0]["BindPassWord"].ToString();
            string strAccreditationType = dtList.Rows[0]["AccreditationType"].ToString().ToUpper();

            if (strVexSSOLoginUser == "")
            {
                throw new Exception("SSO用户名不能为空。");
            }


            if (strAccreditationType.ToUpper() == "VEXSSO")
            {
                throw new Exception("VEXSSOSSO不能绑定。");
            }

            //开始解除绑定
            string strEnvID = m_conn.GetDataTableFirstValue("SELECT Env_ID FROM dbo.MDM_System_env WHERE Env_SN=@param0", new string[] { strAccreditationType }).ToString();

            if (strEnvID == "")
            {
                throw new Exception("系统错误：待解除绑定的系统不存在！");
            }

            string strVexSSONewID = m_conn.GetDataTableFirstValue(@"
                                                                    SELECT  [VexSSONewID]
                                                                    FROM    [B01_MDM].[VEXSSOUser]
                                                                    WHERE   ISNULL(Disabled, 0) = 0
                                                                            AND VexSSOLoginUser = @param0 ", new string[] { strVexSSOLoginUser }).ToString();

            if (strVexSSONewID == "")
            {
                throw new Exception("VEXSSO账户不存在！");
            }

            DataTable dt = new DataTable();
            dt.Columns.Add("Env_ID");
            dt.Columns.Add("VexSSONewID");
            dt.Columns.Add("App_UserName");
            dt.Columns.Add("Checked");
            dt.Rows.Add(new string[] { strEnvID, strVexSSONewID, strBindUser, "0" });

            m_conn.TableKeyList.Clear();
            m_conn.TableKeyList.Add("VexSSONewID");
            m_conn.TableKeyList.Add("Env_ID");
            m_conn.TableKeyList.Add("App_UserName");

            m_conn.HZYMessage = this.m_hzyMessage;
            m_conn.Update("[dbo].[MDM_System_User]", dt, m_conn.TableKeyList);

            dt_EditResult.Rows.Add(new object[] { true, "解绑成功！" });
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #region  Destroy 帐户注销
        /// <summary>
        /// 帐户注销
        /// </summary>
        private void Destroy()
        {
            DataTable dtList = ds.Tables["List"];
            DataTable dtVexSSO = new MDM.VEXSSOUserDataTable();

            VexSSOAccreditatio clsVexSSOAccreditatio = new VexSSOAccreditatio();

            string strVexSSOLoginUser = dtList.Rows[0]["LoginUser"].ToString();
            string strVexSSOPassWord = dtList.Rows[0]["PassWord"].ToString();

            string strSQL = @"UPDATE B01_MDM.VEXSSOUser SET Disabled=1,DisabledTime=Getdate() WHERE VexSSONewID=@Param0;
            UPDATE MDM_System_User SET VexSSONewID=null WHERE  VexSSONewID=@Param0;
            ";

            //进行认证
            clsVexSSOAccreditatio.AccreditatioType = "VEXSSO";
            clsVexSSOAccreditatio.UserName = strVexSSOLoginUser;
            clsVexSSOAccreditatio.PassWord = strVexSSOPassWord;
            clsVexSSOAccreditatio.Execute();

            string strVexSSONewID = m_conn.GetDataTableFirstValue("SELECT VexSSONewID FROM B01_MDM.VEXSSOUser WHERE ISNULL(Disabled,0)=0 AND VexSSOLoginUser=@Param0", new string[] { strVexSSOLoginUser }).ToString();

            m_conn.ExcuteQuerryByTran(strSQL, new string[] { strVexSSONewID });
            dt_EditResult.Rows.Add(new object[] { true, "帐户注销成功！" });
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #region  GetPassWord 密码取回
        /// <summary>
        /// 密码取回
        /// </summary>
        private void GetPassWord()
        {
            DataTable dtList = ds.Tables["List"];

            string strVexSSOLoginUser = dtList.Rows[0]["LoginUser"].ToString();
            string strAuthCode = dtList.Rows[0]["AuthCode"].ToString();

            if (strVexSSOLoginUser == "")
            {
                throw new Exception("SSO用户名不能为空。");
            }


            //验证码是否正确
            if (strAuthCode == "")
            {
                throw new Exception("验证码不能为空。");
            }
            else
            {
                VexSSOAuthCode cls = new VexSSOAuthCode();
                cls.Conn = m_conn;
                cls.CheckAuthCode(strVexSSOLoginUser, strAuthCode, "GetPassWord");
            }

            string strPassWord = m_conn.GetDataTableFirstValue(@"SELECT VexSSOPassWord FROM B01_MDM.[VEXSSOUser] WHERE 
                                                    VexSSOLoginUser=@PARAM0 AND ISNULL(Disabled, 0) = 0", new string[] { strVexSSOLoginUser }).ToString();
            if (strPassWord == "")
            {
                throw new Exception("帐户不存在！");
            }

            dt_EditResult.Clear(); //清除在绑定时写入的信息
            m_dsRequturn = new DataSet();
            dt_EditResult.Rows.Add(new object[] { true, strPassWord });

            m_dsRequturn.Tables.Add(dt_EditResult.Copy());
        }
        #endregion

        #region  GetUserInfo 获取用户信息
        /// <summary>
        /// 获取用户信息
        /// </summary>
        private void GetUserInfo()
        {
            DataTable dtList = ds.Tables["List"];

            string strCurrentEnvSN = dtList.Rows[0]["CurrentEnvSN"].ToString(); //当前环境
            string strTargetEnvSN = dtList.Rows[0]["TargetEnvSN"].ToString(); //需要获取的目标环境
            string strUserName = dtList.Rows[0]["UserName"].ToString(); //当前环境的用户名
            string strPassword = dtList.Rows[0]["Password"].ToString();//当前环境的密码

            //进行账户认证
            VexSSOAccreditatio clsVexSSOAccreditatio = new VexSSOAccreditatio();

            clsVexSSOAccreditatio.PassWord = strPassword;
            clsVexSSOAccreditatio.UserName = strUserName;
            clsVexSSOAccreditatio.AccreditatioType = strCurrentEnvSN;
            clsVexSSOAccreditatio.Execute(); //进行认证。


            string strVexSSONewID = "";

            string strSQL = "";
            //获取SSO帐户信息
            if (strCurrentEnvSN.ToUpper() != "VEXSSO")
            {
                strSQL = @"
                        SELECT  VexSSONewID
                        FROM    dbo.MDM_System_User t1
                        WHERE  ISNULL(checked,0)=1
                               AND   EXISTS ( SELECT 1
                                         FROM   dbo.MDM_System_Env t2
                                         WHERE  Env_SN = @Param1
                                                AND t1.Env_ID = t2.Env_ID )
                                AND App_UserName=@param0
                    ";
                strVexSSONewID = m_conn.GetDataTableFirstValue(strSQL, new string[] { strUserName, strCurrentEnvSN }).ToString();
            }
            else
            {
                strSQL = @"
                        SELECT VexSSONewID FROM B01_MDM.VEXSSOUser
                        WHERE VexSSOLoginUser=@param0 AND ISNULL(Disabled,0)=0
                ";
                strVexSSONewID = m_conn.GetDataTableFirstValue(strSQL, new string[] { strUserName }).ToString();

            }

            if (strVexSSONewID == "")
            {
                throw new Exception("当前帐户末绑定VEXSSO！");
            }

            if (strTargetEnvSN.ToUpper() != "VEXSSO")
            {
                strSQL = @"
                        SELECT  
                            t1.VexSSONewID ,
							t3.VexSSOLoginUser,
                            t1.App_UserID,
                            t1.App_UserName ,
                            t1.App_UserName_CN,
                            t1.App_Password
                        FROM    dbo.MDM_System_User t1
                        LEFT JOIN B01_MDM.VEXSSOUser t3 ON t3.VexSSONewID = t1.VexSSONewID

                        WHERE   ISNULL(checked,0)=1
                                AND EXISTS ( SELECT 1
                                         FROM   dbo.MDM_System_Env t2
                                         WHERE  Env_SN = @param1
                                                AND t1.Env_ID = t2.Env_ID )
                                AND t1.VexSSONewID=@param0
                ";
            }
            else
            {
                strSQL = @"
                     SELECT  t1.VexSSONewID , 
                             VexSSOLoginUser,
		                     NULL App_UserID,
                             VexSSOLoginUser App_UserName,
                             t2.Name
                     FROM B01_MDM.VEXSSOUser t1
                     LEFT JOIN B01_MDM.VexSSOUserInfo t2 ON t2.VexSSONewId = t1.VexSSONewID
                     WHERE t1.VexSSONewID=@param0
                     AND ISNULL(Disabled,0)=0
                ";
            }
            m_dsRequturn = m_conn.GetDataSet(strSQL, new string[] { strVexSSONewID, strTargetEnvSN });
        }
        #endregion

        #region WriteBindLog 当进行用户绑定时，写入日志
        /// <summary>
        /// 当进行用户绑定时，写入日志
        /// </summary>
        /// <param name="pstrVexSSOLoginUser"></param>
        /// <param name="pstrVexSSOPassWord"></param>
        /// <param name="pstrAccreditationType"></param>
        /// <param name="pstrBindUser"></param>
        /// <param name="pstrBindPassWord"></param>
        /// <param name="pstrResult"></param>
        private void WriteBindLog(string pstrVexSSOLoginUser, string pstrVexSSOPassWord,
            string pstrAccreditationType, string pstrBindUser, string pstrBindPassWord,
            string pstrResult)
        {
            Dbconn conn = new Dbconn("VEXSSO");
            DataTable dt = new MDM.BindDataTable();
            DataRow dr = dt.NewRow();
            dr["VexSSOLoginUser"] = pstrVexSSOLoginUser;
            dr["VexSSOPassWord"] = pstrVexSSOPassWord;
            dr["AccreditationType"] = pstrAccreditationType;
            dr["BindUser"] = pstrBindUser;
            dr["BindPassWord"] = pstrBindPassWord;
            dr["Result"] = pstrResult;

            dt.Rows.Add(dr);
            conn.BeginTransaction();
            conn.Insert("M03_Govern.Bind", dt);
            conn.CommitTransaction();
        }
        #endregion

        #region GetBindLog 获取绑定日志
        /// <summary>
        /// 获取绑定日志
        /// </summary>
        private void GetBindLog()
        {
            string strSQL = @"
                    SELECT [LogNewID]
                          ,[LogId]
                          ,[LogTime]
                          ,[VexSSOLoginUser]
                          ,[VexSSOPassWord]
                          ,[AccreditationType]
                          ,[BindUser]
                          ,[BindPassWord]
                          ,[Result]
                      FROM [M03_GOVERN].[Bind] With(NOLOCK)
                      WHERE 1=1      " + m_hzyPageInfo.Where;

            m_dsRequturn = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region GetEhrInfo 获取Ehr用户信息
        /// <summary>
        /// 获取Ehr用户信息
        /// </summary>
        private void GetEhrInfo()
        {

            DataTable dtList = ds.Tables["List"];
            string strName = dtList.Rows[0]["Name"].ToString();
            string strCardid = dtList.Rows[0]["Cardid"].ToString();

            Dbconn conn = new Dbconn("EHR");
            string strSQL = @"
                    SELECT C_NAME,C_IDCARD FROM ehr.TB_INF_EMPLOYEE
                    WHERE C_employeestatus<>3
                    and c_name <>'WonJihyun'
                    AND (C_NAME=@Param0
                    OR C_IDCARD=@Param1)
                    ";

            m_dsRequturn = conn.GetDataSet(strSQL, new string[] { strName, strCardid });
        }
        #endregion

        #region GetPosPOSEmployee 获取Pos导购信息信息
        /// <summary>
        /// 获取Ehr用户信息
        /// </summary>
        private void GetPosPOSEmployee()
        {

          
            Dbconn conn = new Dbconn("F22GP");
            string strSQL = @"
                    SELECT   employeeid,names,valid
                    FROM    j_employee t1 ,
                            j_depot t2
                    WHERE   t1.depotid = t2.depotid
                    " + m_hzyPageInfo.Where;

            m_dsRequturn = conn.GetDataSetForPageList(strSQL, new string[] { }, m_hzyPageInfo);
        }
        #endregion
        #endregion
    }

}