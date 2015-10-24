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

/// 类名：VIPPersonnelForWX
/// 类说明：对VIPPersonnelForWX(VIP会员管理)特殊处理为WX不需要登入
/// 创建人：郭琦琦
/// 创建日期：2014-07-30 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.NPaiaWXSite
{
    public class VIPPersonnelForWX : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public VIPPersonnelForWX()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("F22XY_TEST");
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
            string strPhone = dtList.Rows[0]["Phone"].ToString();//VIP卡号
            string strSQL = @"SELECT  t1.mobtel ,
                                    CASE WHEN T2.viptypeid = 'Y1'
                                         THEN CONVERT(INT, ROUND(centum * 0.03, 0))
                                         WHEN T2.viptypeid = 'Y2'
                                         THEN CONVERT(INT, ROUND(centum * 0.05, 0))
                                         WHEN T2.viptypeid = 'Y3'
                                         THEN CONVERT(INT, ROUND(centum * 0.08, 0))
                                    END centum ,
                                    t1.vipname ,
                                    t1.vipsex ,
                                    t1.crdate ,
                                    t2.viptypeid,
                                    t1.vipcode,
	                                t1.lastSums,
									t1.viplastdate,
									 CASE WHEN T2.viptypeid = 'Y1'
                                         THEN CONVERT(INT, ROUND(lastSums * 0.03, 0))
                                         WHEN T2.viptypeid = 'Y2'
                                         THEN CONVERT(INT, ROUND(lastSums * 0.05, 0))
                                         WHEN T2.viptypeid = 'Y3'
                                         THEN CONVERT(INT, ROUND(lastSums * 0.08, 0))
                                    END lastcentum 
                            FROM    vip_user t1 WITH ( NOLOCK )
                                    LEFT JOIN dbo.vip_cardvip t2 ON t1.vipcode = t2.vipcardid
                            WHERE   t1.mobtel = '" + strPhone + "' AND t2.viptypeid IN ( 'Y1', 'Y2', 'Y3' ) ";
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
            string vipid = "";//VIPid
            string strMaxvipcode;//VIP卡号最大值
            string strvipname = dtList.Rows[0]["vipname"].ToString();//VIP姓名
            string strvipsex = dtList.Rows[0]["vipsex"].ToString();//VIP性别
            string strmobtel = dtList.Rows[0]["Phone"].ToString();//VIP手机
            m_conn.BeginTransaction();

            #region 判断 vipcode 和 vipid
            string strflag = m_conn.GetDataTableFirstValue(" SELECT MAX(RIGHT(vipcardid,6))+1 FROM vip_cardvip WHERE LEFT(vipcardid,2)='NP'", new string[] { }).ToString();
            if (strflag == "")
            {
                strMaxvipcode = "NP000000";
            }
            else
            {
                strMaxvipcode = "NP" + Convert.ToInt32(strflag).ToString("000000");
            }
            //验证手机号
            string strflagTEL = m_conn.GetDataTableFirstValue(@"
                        SELECT  COUNT(*)
                                FROM    vip_user t1
                                WHERE   EXISTS ( SELECT *
                                                 FROM   vip_cardvip T2
                                                 WHERE  viptypeid IN ( 'Y1', 'Y2', 'Y3' )
                                                        AND t1.vipcode = t2.vipcardid )
                                        AND mobtel = @Param0", new string[] { strmobtel }).ToString();

            if (strflagTEL == "1")
            {
                throw new Exception("该手机号已经存在！");
            }

            int nNum = 1;//默认是0
            vipid = "NP" + "6314" + "-" + DateTime.Now.ToString("yyyy-MM-dd") + "-" + nNum.ToString("0000");
            for (int j = 0; j < 100000; j++)
            {
                string strflagvip_cardvip = m_conn.GetDataTableFirstValue(" SELECT COUNT(*) count  FROM dbo.vip_cardvip WITH(NOLOCK)  WHERE vipid ='" + vipid + "'", new string[] { }).ToString();
                if (strflagvip_cardvip == "0")
                {
                    break;
                }
                else
                {
                    nNum++;
                    vipid = "NP" + "6314" + "-" + DateTime.Now.ToString("yyyy-MM-dd") + "-" + nNum.ToString("0000");
                    continue;
                }
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
            m_conn.ExcuteQuerryByTran(strSQL, new object[] { strMaxvipcode, strvipname, strvipsex, strmobtel, vipid, timeNow });
            #endregion

            #region 插入vip_cardvip表

            string strSQL1 = @"
                        INSERT INTO vip_cardvip(vipcardid,viptypeid,vipid,vipemit,vipemitadd,MaxDay,crdate,limitday,crname
	                              )
                             ( SELECT  @Param0 vipcardid, 'Y1' viptypeid,@Param1 vipid,@Param2 vipemit,@Param3 vipemitadd,'1000' MaxDay,@Param4 crdate,'9999' limitday
                                       , @Param5 crname )";
            m_conn.ExcuteQuerryByTran(strSQL1, new object[] { strMaxvipcode, vipid, timeNow, "Y0016027", timeNow, "Y0016027" });
            #endregion

            m_conn.CommitTransaction();

            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }

        #endregion

        #endregion
    }
}