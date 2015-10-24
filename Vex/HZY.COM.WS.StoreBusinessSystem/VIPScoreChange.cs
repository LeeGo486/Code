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

/// 类名：VIPScoreChange
/// 类说明：对VIPScoreChange(VIP积分调整)
/// 创建人：郭琦琦
/// 创建日期：2014-07-28 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.StoreBusinessSystem
{
    public class VIPScoreChange : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public VIPScoreChange()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("F22XY_TEST");
        private Dbconn m_conn_XY_TEST_DRP_REPORT = new Dbconn("F22XY_TEST_DRP_REPORT");
        private Dbconn m_conn_GP = new Dbconn("F22GP");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();
        string UserName;


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
                DataTable dtList = ds.Tables["List"];

                UserName = m_conn.GetDataTableFirstValue(" SELECT username   FROM [dbo].[j_user] WHERE userid ='" + hzyMessage.User_Name + @"' ", new string[] { }).ToString();

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetVIPIntegral".ToUpper())//查询VIP积分
                {
                    GetVIPIntegral(dtList);
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EDIT".ToUpper())//积分兑换劵
                {
                    EDIT(dtList);
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EDITNPAINVIPCONFIG".ToUpper())//修改恩派雅VIP兑换配置
                {
                    EDITNPAINVIPCONFIG(dtList);
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETNPAINVIPCONFIG".ToUpper())//获取恩派雅VIP兑换配置
                {
                    GETNPAINVIPCONFIG(dtList);
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetMerchantid".ToUpper())//获取店铺加盟商编号并返回加盟商VIP兑换规则
                {
                    GetMerchantid(dtList);
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

        #region 查询VIP积分
        /// <summary>
        /// 查询VIP积分
        /// </summary>
        private void GetVIPIntegral(DataTable pdt)
        {
            string strVipCode = ds.Tables["list"].Rows[0]["vipcode"].ToString();//取前台传过来的VIP卡号
            string strYesNo = m_conn.GetDataTableFirstValue(" SELECT TOP 1 * FROM dbo.vip_cardvip WITH(NOLOCK)  WHERE   vipcardid = '" + strVipCode + @"' ", new string[] { strVipCode }).ToString();
            string strSQL;
            if (strYesNo == "")
            {
                throw new Exception("该VIP卡号不存在!");
            }
            else
            {
                //                strSQL = @"SELECT  *
                //                                    FROM    dbo.vip_user t5 WITH ( NOLOCK )
                //                                    WHERE   vipcode = ( SELECT  vipcardid
                //                                                        FROM    dbo.vip_cardvip t3 WITH ( NOLOCK )
                //                                                        WHERE   EXISTS ( SELECT *
                //                                                                         FROM   dbo.vip_user t2 WITH ( NOLOCK )
                //                                                                         WHERE  t3.vipcardid = t2.vipcode
                //                                                                                AND EXISTS ( SELECT
                //                                                                                                  *
                //                                                                                             FROM dbo.vip_cardvip t1
                //                                                                                                  WITH ( NOLOCK )
                //                                                                                             WHERE
                //                                                                                                  t1.vipid = t2.vipid
                //                                                                                                            AND vipcardid = '" + strVipCode + "'" + ") ) )";

                strSQL = @"SELECT  *
                                    FROM    dbo.vip_cardvip t3 WITH ( NOLOCK )
                                            LEFT JOIN dbo.vip_typevip t4 WITH ( NOLOCK ) ON t4.viptypeid = t3.viptypeid
                                            LEFT JOIN dbo.vip_user t5 WITH ( NOLOCK ) ON t5.vipcode = t3.vipcardid
                                    WHERE   EXISTS ( SELECT *
                                                     FROM   dbo.vip_user t2 WITH ( NOLOCK )
                                                     WHERE  t3.vipcardid = t2.vipcode
                                                            AND EXISTS ( SELECT *
                                                                         FROM   dbo.vip_cardvip t1 WITH ( NOLOCK )
                                                                         WHERE  t1.vipid = t2.vipid
                                                                                AND vipcardid = '" + strVipCode + "'" + " ) )";
            }
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion

        #region 积分兑换
        /// <summary>
        /// 积分兑换
        /// </summary>
        private void EDIT(DataTable pdt)
        {
            //string strviptypeid = pdt.Rows[0]["viptypeid"].ToString();//VIP卡类型
            string strtikect_type = pdt.Rows[0]["tikect_type"].ToString();//VIP配置表配置券号
            string strvipstate = pdt.Rows[0]["vipstate"].ToString();//VIP卡状态
            string VIPState = "";//VIP卡类型 YF贵宾卡  Y1,YF金卡 Y2,YF铂金卡 Y3
            string strvipid = pdt.Rows[0]["vipid"].ToString();//VIP卡号
            string strtckname = pdt.Rows[0]["tckname"].ToString();//VIP券名
            string strvipcode = pdt.Rows[0]["vipcode"].ToString();//VIPcode
            string strsums = pdt.Rows[0]["sums"].ToString();//VIP券大小
            string strcentum = pdt.Rows[0]["centum"].ToString();//积分
            //string UserName = hzyMessage.User_Name_CN.Substring(9);
            DateTime timeNow = DateTime.Now;
            string nextYear = DateTime.Now.AddYears(1).ToString();//明年的今天



            #region 获取券号生成前缀

            string strtictypename = m_conn.GetDataTableFirstValue(" SELECT ticketpre  FROM vip_tictype    WITH(NOLOCK)  where tictypeid ='" + strtikect_type + "'", new string[] { }).ToString();
            //strtictypename y1  y2 y3 

            #endregion



            #region 判断券号在表里面是否存在

            string randomTimeNow = DateTime.Now.ToString("yyyyMMddHHmmssff");//时间戳
            string ticketid = strtictypename + randomTimeNow;//券号

            for (int i = 0; i < 100000; i++)
            {
                string strflag = m_conn.GetDataTableFirstValue(" SELECT count(*) count FROM dbo.vip_ticket WITH(NOLOCK) WHERE ticketid ='" + ticketid + "'", new string[] { }).ToString();
                if (strflag == "0")
                {
                    break;
                }
                else
                {
                    randomTimeNow = DateTime.Now.ToString("yyyyMMddHHmmssff");//时间戳
                    ticketid = strtictypename + randomTimeNow;//券号
                    continue;
                }
            }
            #endregion

            #region 判断积分调整单据在表里面是否存在

            int nNum = 1;//默认是0
            string strjfid = "CH" + hzyMessage.User_Name + "-" + DateTime.Now.ToString("yyyy-MM-dd") + "-" + nNum.ToString("0000");

            for (int j = 0; j < 100000; j++)
            {
                string strflagvip_jfchange = m_conn.GetDataTableFirstValue(" SELECT COUNT(*) count  FROM dbo.vip_jfchange WITH(NOLOCK)  WHERE jfid ='" + strjfid + "'", new string[] { }).ToString();
                if (strflagvip_jfchange == "0")
                {
                    break;
                }
                else
                {
                    nNum++;
                    strjfid = "CH" + hzyMessage.User_Name + "-" + DateTime.Now.ToString("yyyy-MM-dd") + "-" + nNum.ToString("0000");
                    continue;
                }
            }

            #endregion

            m_conn.BeginTransaction();

            #region 插入VIP_TICKET表

            string strSQL = @"
                        INSERT INTO dbo.vip_ticket (
                        ticketid ,tckname ,ttype ,sums ,setdate ,begdate ,enddate,freeze ,crdate ,crname ,comment ,tictypeid ,dtype ,fbegdate ,
                        fenddate ,setsure ,signsure ,sellsure ,selldate ,sellname ,getsure ,acttype ,days ,closedate ,vipid ,ticket
	                              )
                             ( SELECT      
                        @Param0 ticketid ,@Param1 tckname ,'1' ttype , @Param2 sums ,@Param3 setdate ,@Param4 begdate ,@Param5 enddate,
                        '0' freeze ,@Param6 crdate ,@Param7 crname ,'兑换生成' comment ,@Param15 tictypeid ,'2' dtype ,@Param8 fbegdate ,
                        @Param9 fenddate ,'1' setsure ,'1' signsure ,'1' sellsure ,@Param10 selldate ,
                        @Param11 sellname ,'0' getsure ,'1' acttype ,'365' days ,@Param12 closedate ,@Param13 vipid ,@Param14 ticket                  
                                    )";
            m_conn.ExcuteQuerryByTran(strSQL, new object[] { ticketid, strtckname, strsums, timeNow, timeNow, nextYear, timeNow,UserName,
                timeNow,nextYear,timeNow,UserName,nextYear,strvipid,ticketid ,strtikect_type});
            #endregion

            #region 插入vip_change表
            string strSQL1 = @"
                        INSERT INTO dbo.vip_jfchange (
                            jfid ,setdate ,sure ,chk_sure ,chk_name ,sure_name ,chk_date ,sure_date ,cr_date ,
                            cr_name ,crdate , comment ,d_type , mb
                                  )
                             ( SELECT  
                            @Param0 jfid ,@Param1 setdate ,'0' sure ,'0' chk_sure ,@Param2 chk_name ,@Param3 sure_name ,@Param4 chk_date ,@Param5 sure_date ,@Param6 cr_date ,
                            @Param7 cr_name ,@Param8 crdate ,'积分兑换' comment ,'2' d_type ,'01'mb
                                  )";
            m_conn.ExcuteQuerryByTran(strSQL1, new object[] { strjfid, timeNow, UserName, UserName, timeNow, timeNow, timeNow, UserName, timeNow });


            #region 插入vip_changesub表

            string strSQL4 = @"INSERT INTO dbo.vip_jfchangesub (jfid ,vipid ,vipcode ,centum ,comment ,crdate )
                                          (SELECT @Param0 jfid ,@Param1 vipid ,@Param2 vipcode ,@Param3 centum ,@Param4 comment ,@Param5 crdate)";
            m_conn.ExcuteQuerryByTran(strSQL4, new object[] { strjfid, strvipid, strvipcode, "-" + strcentum, "券号" + ticketid, timeNow });
            #endregion

            #endregion

            #region 更新vip_change表审核状态
            string strSQL2 = @"UPDATE dbo.vip_jfchange SET chk_sure =1 WHERE jfid ='" + strjfid + "'";

            m_conn.ExcuteQuerryByTran(strSQL2, new object[] { });
            #endregion

            #region 更新vip_change表登帐状态
            string strSQL3 = @"UPDATE dbo.vip_jfchange SET sure =1 WHERE jfid ='" + strjfid + "'";

            m_conn.ExcuteQuerryByTran(strSQL3, new object[] { });
            #endregion

            m_conn.CommitTransaction();

            dt_EditResult.Rows.Add(new object[] { true, "兑换成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 获取恩派雅VIP兑换配置
        /// <summary>
        /// 获取恩派雅VIP兑换配置
        /// </summary>
        private void GETNPAINVIPCONFIG(DataTable pdt)
        {
            string strSQL = @"SELECT	* FROM Y_NPAIN_VIP_Config" + m_hzyPageInfo.Where; ;
            ds_Return = m_conn_XY_TEST_DRP_REPORT.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 修改恩派雅VIP兑换配置
        /// <summary>
        /// 修改恩派雅VIP兑换配置
        /// </summary>
        private void EDITNPAINVIPCONFIG(DataTable pdt)
        {
            DateTime timeNow = DateTime.Now;//取本地当前时间。
            string strmerchantid = ds.Tables["list"].Rows[0]["merchantid"].ToString();//获取供应商编号
            m_conn.LockTableList.Add("Y_NPAIN_VIP_Config");
            m_conn.BeginTransaction();

            string strlevel1_type = ds.Tables["list"].Rows[0]["level1_type"].ToString();//
            string strlevel1_rate = ds.Tables["list"].Rows[0]["level1_rate"].ToString();//
            string strlevel2_type = ds.Tables["list"].Rows[0]["level2_type"].ToString();//
            string strlevel2_rate = ds.Tables["list"].Rows[0]["level2_rate"].ToString();//
            string strlevel3_type = ds.Tables["list"].Rows[0]["level3_type"].ToString();//
            string strlevel3_rate = ds.Tables["list"].Rows[0]["level3_rate"].ToString();//
            string strtikect_type = ds.Tables["list"].Rows[0]["tikect_type"].ToString();//

            //判断前台传过来的加盟商编号在数据库存不存在,如果存在就更新,如果不存在就新增
            int nCountYN = m_conn_XY_TEST_DRP_REPORT.GetDataTableRowCount("SELECT	* FROM Y_NPAIN_VIP_Config WHERE merchantid='" + strmerchantid + "'");

            if (nCountYN == 0)
            {

                string strSQL = @"
            insert into dbo.Y_NPAIN_VIP_Config 
            (merchantid,level1_type,level1_rate,level2_type,level2_rate,level3_type,level3_rate,tikect_type)( SELECT
            @Param0 merchantid,@Param1 level1_type,@Param2 level1_rate,@Param3 level2_type,@Param4 level2_rate,@Param5 level3_type, @Param6 level3_rate,@Param7 tikect_type)";
                m_conn_XY_TEST_DRP_REPORT.ExcuteQuerryByTran(strSQL, new object[] { strmerchantid, strlevel1_type, strlevel1_rate, strlevel2_type, strlevel2_rate, strlevel3_type ,
                                                                strlevel3_rate,strtikect_type});
            }
            else
            {
                string strSQL1 = @"
            update   dbo.Y_NPAIN_VIP_Config set level1_type=@Param1,level1_rate=@Param2,level2_type=@Param3,level2_rate=@Param4,level3_type=@Param5,
            level3_rate=@Param6,tikect_type=@Param7
            where merchantid= @Param0";
                m_conn_XY_TEST_DRP_REPORT.ExcuteQuerryByTran(strSQL1, new object[] { strmerchantid, strlevel1_type, strlevel1_rate, strlevel2_type, strlevel2_rate, strlevel3_type ,
                                                                strlevel3_rate,strtikect_type});
            }
            m_conn.CommitTransaction();

            dt_EditResult.Rows.Add(new object[] { true, "成功" });

            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion


        #region 查询VIP积分
        /// <summary>
        /// 查询VIP积分
        /// </summary>
        private void GetMerchantid(DataTable pdt)
        {
            string strDepotid = ds.Tables["list"].Rows[0]["Depotid"].ToString();//取前台传过来的店铺编号
            string strParentid = m_conn_GP.GetDataTableFirstValue(" SELECT parentid FROM dbo.j_depot WITH(NOLOCK)  WHERE   depotid = '" + strDepotid + "'", new string[] { }).ToString();

            if (strParentid == "" || strParentid == null)
            {
                throw new Exception("请联系管理员！"); ;
            }
            strParentid = strParentid.Trim();
            string strSQL3 = @"SELECT   merchantid ,
                                level1_type ,
                                level1_rate ,
                                level2_type ,
                                level2_rate ,
                                level3_type ,
                                level3_rate ,
                                tikect_type
                        FROM    Y_NPAIN_VIP_Config t1
                        WHERE  merchantid = '" + strParentid + "'";
            ds_Return = m_conn_XY_TEST_DRP_REPORT.GetDataSet(strSQL3);
        }
        #endregion

        #endregion
    }
}