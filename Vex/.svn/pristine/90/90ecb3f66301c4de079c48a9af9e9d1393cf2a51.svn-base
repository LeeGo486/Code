using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：HZY.COM.WS.DLWXSite
/// 类说明：对VIPPersonnel(VIP会员管理)
/// 创建人：郭琦琦
/// 创建日期：2015-05-25 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.GLWXSite
{
    public class VIPPersonnel : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public VIPPersonnel()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("DLWXWZ");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();
        DateTime timeNow = DateTime.Now;

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
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];


                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETVIPINTEGRAL".ToUpper())//查询VIP积分是否会员
                {
                    GetVIPIntegral();
                }

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EDITVIPPERSONNEL".ToUpper())//会员维护
                {
                    EDITVIPPersonnel();
                }
                return ds_Return;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region 查询VIP
        /// <summary>
        /// 查询VIP
        /// </summary>
        private void GetVIPIntegral()
        {
            DataTable dtList = ds.Tables["List"];
            string strPhone = dtList.Rows[0]["Phone"].ToString();
            string strSQL = @"SELECT  *
                              FROM    vip_user t1 WITH ( NOLOCK )
                              WHERE   mobtel = '" + strPhone + "'";
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion

        #region VIP会员维护
        /// <summary>
        /// VIP会员维护
        /// </summary>
        private void EDITVIPPersonnel()
        {
            DataTable dtList = ds.Tables["List"];
            string strVipid = "";//VIPid
            string strSetvaldt = "";//VIP卡号前缀
            string strMaxvipcode;//VIP卡号最大值
            string userid = "1111";//定义授权代码
            string strPrefix;//卡号前缀
            string strViptypeid;//VIP卡类型

            string strvipname = dtList.Rows[0]["vipname"].ToString();//VIP姓名
            string strvipsex = dtList.Rows[0]["vipsex"].ToString();//VIP性别
            string strmobtel = dtList.Rows[0]["Phone"].ToString();//VIP手机
            string f18pass = dtList.Rows[0]["f18pass"].ToString();//授权代码
            m_conn.BeginTransaction();

            #region 验证手机号
            string strflagTEL = m_conn.GetDataTableFirstValue(@"
                         SELECT A.* FROM dbo.vip_user a WITH(NOLOCK)  INNER JOIN dbo.j_depot b WITH(NOLOCK)  ON a.depotid = b.depotid AND 
                               b.unitid IN (SELECT  unitid FROM dbo.j_depot  WITH(NOLOCK) WHERE depotid=@Param0) 
                               WHERE A.mobtel = @Param1", new string[] { strmobtel }).ToString();

            if (strflagTEL == "1")
            {
                throw new Exception("该手机号已经存在！");
            }

            #endregion


            #region 取配置
            strSetvaldt = m_conn.GetDataTableFirstValue("SELECT setval  FROM dbo.vip_setup WHERE setid =1", new string[] { }).ToString();

            DataTable dtConfigdt = m_conn.GetDataSet(@" SELECT [f18pass] ,[Prefix],[viptypeid] FROM [DRP_REPORT].[dbo].[EP_Affiliate_VIP_Config] 
                                                        WHERE [f18pass]=@Param0", new string[] { f18pass }).Tables[0];

            strPrefix = dtConfigdt.Rows[0]["Prefix"].ToString();//卡号前缀
            strViptypeid = dtConfigdt.Rows[0]["viptypeid"].ToString();//VIP卡类型

            #endregion



            #region 取VIPID

            int nNum = 1;//默认是0
            strVipid = strSetvaldt + userid + "-" + DateTime.Now.ToString("yyyy-MM-dd") + "-" + nNum.ToString("0000");
            for (int j = 0; j < 100000; j++)
            {
                string strflagVIPID = m_conn.GetDataTableFirstValue(@" SELECT COUNT(*) count  FROM dbo.vip_cardvip WITH(NOLOCK)  WHERE vipid =@Param0",
                                                                    new string[] { strVipid }).ToString();

                if (strflagVIPID == "0")
                {
                    break;
                }
                else
                {
                    nNum++;
                    strVipid = strSetvaldt + userid + "-" + DateTime.Now.ToString("yyyy-MM-dd") + "-" + nNum.ToString("0000");
                    continue;
                }
            }

            #endregion

            #region 取VIPCODE

            string strflagVIPCODE = m_conn.GetDataTableFirstValue(@" SELECT MAX(RIGHT(vipcardid,6))+1 FROM vip_cardvip WHERE ISNUMERIC(RIGHT(vipcardid, 6)) = 1 and 
                                                                     LEFT(vipcardid," + strPrefix.Length + ")=@Param0", new string[] { strPrefix }).ToString();

            if (strflagVIPCODE == "")
            {
                strMaxvipcode = strPrefix + "000000";
            }
            else
            {
                strMaxvipcode = strPrefix + Convert.ToInt32(strflagVIPCODE).ToString("000000");
            }
            #endregion



            #region 插入vip_user表

            string strSQL = @"
                        insert into dbo.vip_user 
                                (vipcode,vipname,vipsex,mobtel,vipid,depotid,vipstate,crdate,is_vip,vipapply,viptypeid)
                             ( SELECT      
                                @Param0 vipcode,@Param1 vipname,@Param2 vipsex,@Param3 mobtel,
                                @Param4 vipid,'Y0016027' depotid,'金卡' vipstate,@Param5 crdate  ,'0' is_vip,'微信' vipapply, 'Y1' viptypeid
                                    )";
            m_conn.ExcuteQuerryByTran(strSQL, new object[] { strMaxvipcode, strvipname, strvipsex, strmobtel, strVipid, timeNow });
            #endregion

            #region 插入vip_cardvip表

            string strSQL1 = @"
                        INSERT INTO vip_cardvip(vipcardid,viptypeid,vipid,vipemit,vipemitadd,MaxDay,crdate,limitday,crname
	                              )
                             ( SELECT  @Param0 vipcardid, 'Y1' viptypeid,@Param1 vipid,@Param2 vipemit,@Param3 vipemitadd,'1000' MaxDay,@Param4 crdate,'9999' limitday
                                       , @Param5 crname )";
            m_conn.ExcuteQuerryByTran(strSQL1, new object[] { strMaxvipcode, strVipid, timeNow, "Y0016027", timeNow, "Y0016027" });
            #endregion

            m_conn.CommitTransaction();

            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }

        #endregion

        #endregion
    }
}