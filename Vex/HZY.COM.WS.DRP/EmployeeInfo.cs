using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using HZY.COM.WS.SSO;

/// 类名：EmployeeInfo
/// 类说明：导购信息
/// 创建人：马卫清
/// 创建日期：2014-08-07
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DRP
{

    public class EmployeeInfo : HZYLogicBase, ILogicGetData
    {
        public EmployeeInfo()
        {
            this.m_SessionCheck = false;

        }

        private Dbconn m_conn = new Dbconn("VexSSO");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_dsRetrun = new DataSet();
        private DataSet ds = new DataSet();

        public DataSet GetData()
        {
            try
            {

                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                //事务开始
                m_conn.BeginTransaction();


                //根据3S微信号获取导购相关信息
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetEmployeeInfoBy3SWeChat".ToUpper())
                {
                    GetEmployeeInfoBy3SWeChat();
                }
                else
                {
                    throw new Exception("操作类型不支持！");
                }
                //事务提交 --注意：不能移动到每个方法里面，这里面的方法会有互相调用的情况
                m_conn.CommitTransaction();

                return m_dsRetrun;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }

        #region 内部函数

        #region GetEmployeeInfoBy3SWeChat 根据3S微信号获取导购相关信息
        /// <summary>
        /// 根据3S微信号获取导购相关信息
        /// </summary>
        private void GetEmployeeInfoBy3SWeChat()
        {
            DataTable dt = ds.Tables["List"];

            string str3SWeChatUserID = dt.Rows[0]["S3WeChatID"].ToString();
            if (str3SWeChatUserID == "")
            {
                throw new Exception("3S微信号不允许为空");
            }


            DataSet dsResponse = null;
            try
            {
                //判断是否已经绑定EHR
                VexSSOUser cls = new VexSSOUser();
                string[] strColumns = new string[] { "CurrentEnvSN", "TargetEnvSN", "UserName", "Password" };
                string[] strValues = new string[] { "3SWeChat", "EHRCARD", str3SWeChatUserID, "" };
                DataSet dsRequestCls = Common.Common.GetDataSetContainsRequestExcelXML(strColumns, strValues, "GetUserInfo");
                cls.Request = dsRequestCls;
                dsResponse = cls.GetData();
            }
            catch (Exception ex)
            {
                dt_EditResult.Rows.Add(new object[] { "1", "末绑定EHR！" });
                m_dsRetrun.Tables.Add(dt_EditResult.Copy());
                return;
            }

            if (dsResponse.Tables[0].Rows.Count == 0
                || dsResponse.Tables[0].Rows[0]["App_UserName"].ToString() == "")
            {
                dt_EditResult.Rows.Add(new object[] { "1", "末绑定EHR！" });
                m_dsRetrun.Tables.Add(dt_EditResult.Copy());
                return;
            }
            else
            {
                string strName = dsResponse.Tables[0].Rows[0]["App_UserName"].ToString();
                string strCardMD5 = dsResponse.Tables[0].Rows[0]["App_Password"].ToString();
                
                Dbconn connEHR = new Dbconn("EHR");
                string strSQL1 = @"
                    SELECT C_NAME,C_IDCARD FROM ehr.TB_INF_EMPLOYEE
                    WHERE C_employeestatus<>3
                    AND C_NAME=@Param0
                    AND right(sys.fn_VarBinToHexStr(hashbytes('MD5',Convert(varchar(100),C_IDCARD))),32)=@param1
                    ";
                DataTable dtEHR = connEHR.GetDataTable(strSQL1, new string[] { strName, strCardMD5 });
                if (dtEHR.Rows.Count == 0)
                {
                    dt_EditResult.Rows.Add(new object[] { "1", "您的信息在EHR状态为离职，请与人资部联系！" });
                    m_dsRetrun.Tables.Add(dt_EditResult.Copy());
                    return;
                }
            }


            try
            {
                //判断是否已经绑定POS
                VexSSOUser cls = new VexSSOUser();
                string[] strColumns = new string[] { "CurrentEnvSN", "TargetEnvSN", "UserName", "Password" };
                string[] strValues = new string[] { "3SWeChat", "POSEmployee", str3SWeChatUserID, "" };
                DataSet dsRequestCls = Common.Common.GetDataSetContainsRequestExcelXML(strColumns, strValues, "GetUserInfo");
                cls.Request = dsRequestCls;
                dsResponse = cls.GetData();
            }
            catch (Exception ex)
            {
                dt_EditResult.Rows.Add(new object[] { "2", "末绑定POS！" });
                m_dsRetrun.Tables.Add(dt_EditResult.Copy());
                return;
            }

            string strApp_UserName = "";
            if (dsResponse.Tables[0].Rows.Count == 0
                || dsResponse.Tables[0].Rows[0]["App_UserName"].ToString() == "")
            {
                dt_EditResult.Rows.Add(new object[] { "2", "末绑定POS！" });
                m_dsRetrun.Tables.Add(dt_EditResult.Copy());
            }
            else
            {
                
                string strSQL = "";

                string strVexSSOLoginUser = dsResponse.Tables[0].Rows[0]["VexSSOLoginUser"].ToString();

                strApp_UserName = dsResponse.Tables[0].Rows[0]["App_UserName"].ToString();
                 strSQL = @"
                    SELECT  '3' as Result,
                            '' as Message,
                            employeeid ,
                            names ,
                            t1.depotid ,
                            t2.d_name ,
                            t1.valid,
                            t2.d_dq,
                            t2.d_dd,
                            t1.position
                    FROM    j_employee t1 ,
                            j_depot t2
                    WHERE   t1.depotid = t2.depotid
                            AND t1.valid = 0   --0在岗 1离职
		                    AND employeeid=@param0
                ";

                Dbconn conn = new Dbconn("F22GP");
                DataTable dtResult = conn.GetDataTable(strSQL, new string[] { strApp_UserName });

                strSQL = @"SELECT  dbo.j_depot.freeze FROM dbo.j_employee inner JOIN dbo.j_depot ON dbo.j_depot.depotid = dbo.j_employee.depotid
                           WHERE employeeid=@param0  AND freeze=1
                            ";
                DataTable dtDepotResult = conn.GetDataTable(strSQL, new string[] { strApp_UserName });

                //说明店铺已关闭
                if (dtDepotResult.Rows.Count > 0)
                {
                    dt_EditResult.Rows.Add(new object[] { "2", "店铺已关闭，请重新绑定新导购编号！" });
                    m_dsRetrun.Tables.Add(dt_EditResult.Copy());
                }
                //如果员工已离职，需要对SSO进行解绑
                else if (dtResult.Rows.Count == 0)
                {
                    dt_EditResult.Rows.Add(new object[] { "2", "员工已离职！" });
                    m_dsRetrun.Tables.Add(dt_EditResult.Copy());
                }
                else
                {
                    m_dsRetrun.Tables.Add(dtResult.Copy());
                }

                //如果员工已离职，需要对SSO进行解绑
                if (dtResult.Rows.Count == 0 || dtDepotResult.Rows.Count > 0)
                {
                    //进行SSO解绑
                    try
                    {
                        VexSSOUser cls = new VexSSOUser();
                        string[] strColumns = new string[] { "LoginUser", "BindUser", "AccreditationType" };
                        string[] strValues = new string[] { strVexSSOLoginUser, strApp_UserName, "POSEmployee" };
                        DataSet dsRequestCls = Common.Common.GetDataSetContainsRequestExcelXML(strColumns, strValues, "UnBind");
                        cls.Request = dsRequestCls;
                        dsResponse = cls.GetData();
                    }
                    catch (Exception ex)
                    {
                        dt_EditResult.Clear();
                        dt_EditResult.Rows.Add(new object[] { "4", "解绑失败！" });
                        m_dsRetrun.Tables.Add(dt_EditResult.Copy());
                        return;
                    }
                }

            }

        }
        #endregion

        #endregion


    }

}