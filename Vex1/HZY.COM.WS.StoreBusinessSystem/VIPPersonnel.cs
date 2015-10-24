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

/// 类名：VIPPersonnel
/// 类说明：对VIPPersonnel(VIP会员管理)
/// 创建人：郭琦琦
/// 创建日期：2014-07-30 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.StoreBusinessSystem
{
    public class VIPPersonnel : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public VIPPersonnel()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("F22XY");
        private Dbconn m_conn_GP = new Dbconn("F22GP");
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
                DataTable dtList = ds.Tables["List"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetVIPPersonnel".ToUpper())//查询VIP积分
                {
                    GetVIPPersonnel(dtList);
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EDITVIPPersonnel".ToUpper())//积分兑换劵
                {
                    EDITVIPPersonnel(dtList);
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Getemployee".ToUpper())//获取客户经理
                {
                    Getemployee(dtList);
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Getlookname".ToUpper())//获取职业
                {
                    Getlookname(dtList);
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

        #region 查询VIP会员
        /// <summary>
        /// 查询VIP会员
        /// </summary>
        private void GetVIPPersonnel(DataTable pdt)
        {
            string search = "";
            if (pdt.Columns.Contains("search"))
            {
                search = pdt.Rows[0]["search"].ToString();//筛选条件
            }
            else
            {
                search = search;
            }

            string strSQL = @"SELECT   is_vip ,
                                        vipid ,
                                        depotid ,
                                        vipcode ,
                                        vipname ,
                                        vipsex ,
                                        vipbirth ,
                                        country ,
                                        add_city ,
                                        mobtel ,
                                        vipadd ,
                                        vipoccupation ,
                                        viplove ,
                                        tz_name ,
                                        Employeeid ,
                                        add_province ,
                                        QQ ,
                                        weibo ,
                                        vipemail ,
                                        vipbrand1 ,
                                        liketalktype ,
                                        viptypeid,crdate
                                FROM    dbo.vip_user WITH ( NOLOCK )
                                WHERE   depotid = '" + hzyMessage.User_Name_CN.Substring(0, 8) + "'"
                                + m_hzyPageInfo.Where;
            string strWhereTmp = "AND ( vipname LIKE '%" + search + "%' or mobtel like  '%" + search + "%') ";
            ds_Return = m_conn.GetDataSetForPageList(strSQL + strWhereTmp, new string[0], m_hzyPageInfo);
        }
        #endregion


        #region 获取客户经理
        /// <summary>
        /// 获取客户经理
        /// </summary>
        private void Getemployee(DataTable pdt)
        {
            string depotid = pdt.Rows[0]["depotid"].ToString();//店铺编号
            string strSQL = @"SELECT employeeid,names FROM dbo.j_employee WHERE  valid='0' AND depotid='" + depotid + "'";
            ds_Return = m_conn.GetDataSet(strSQL, new string[0]);
        }
        #endregion

        #region 获取职业
        /// <summary>
        /// 获取职业
        /// </summary>
        private void Getlookname(DataTable pdt)
        {
            string strSQL = @"select lookname , lookname  lookname1 FROM j18_lookupsub WHERE lookupid='3001'";
            ds_Return = m_conn.GetDataSet(strSQL, new string[0]);
        }
        #endregion

        #region VIP会员维护
        /// <summary>
        /// VIP会员维护
        /// </summary>
        private void EDITVIPPersonnel(DataTable pdt)
        {
            string vipid = "";//VIPid
            string strMaxvipcode;//VIP卡号最大值
            string strvipcode = pdt.Rows[0]["vipcode"].ToString();//VIP卡号
            string strvipname = pdt.Rows[0]["vipname"].ToString();//VIP姓名
            string strvipbirth = pdt.Rows[0]["vipbirth"].ToString();//生日
            string strvipsex = pdt.Rows[0]["vipsex"].ToString();//VIP性别
            string strmobtel = pdt.Rows[0]["mobtel"].ToString();//VIP手机
            string strvipoccupation = pdt.Rows[0]["vipoccupation"].ToString();//VIP职业
            string strtz_name = pdt.Rows[0]["tz_name"].ToString();//VIP经理
            string stremployeeid = pdt.Rows[0]["employeeid"].ToString();//VIP经理ID
            string stradd_province = pdt.Rows[0]["add_province"].ToString();//VIP省
            string strcity = pdt.Rows[0]["city"].ToString();//VIP卡城市
            string strvipadd = pdt.Rows[0]["vipadd"].ToString();//VIP卡地址
            string strqq = pdt.Rows[0]["qq"].ToString();//VIP卡qq
            string strweibo = pdt.Rows[0]["weibo"].ToString();//VIP卡微博
            string strvipemail = pdt.Rows[0]["vipemail"].ToString();//VIP卡邮件
            string strvipbrand1 = pdt.Rows[0]["vipbrand1"].ToString();//VIP卡品牌
            string strviplove = pdt.Rows[0]["viplove"].ToString();//VIP卡爱好
            string strliketalktype = pdt.Rows[0]["liketalktype"].ToString();//VIP卡沟通方式
            string strdepotid = pdt.Rows[0]["depotid"].ToString();//VIP店铺编号

            string strParentid = m_conn_GP.GetDataTableFirstValue(" SELECT parentid FROM dbo.j_depot WITH(NOLOCK)  WHERE   depotid = '" + strdepotid + "'", new string[] { }).ToString();
            
            if (strParentid == "" || strParentid == null)
            {
                throw new Exception("请联系管理员！"); ;
            }
            strParentid = strParentid.Trim();

            string strlevel1_type = m_conn.GetDataTableFirstValue(" SELECT level1_type FROM   [DRP_REPORT].[dbo].[Y_NPAIN_VIP_Config]  WITH(NOLOCK)  WHERE   merchantid = '" + strParentid + "'", new string[] { }).ToString();

            if (strlevel1_type == "" || strlevel1_type == null)
            {
                throw new Exception("请联系管理员！"); ;
            }

            m_conn.BeginTransaction();

            //如果strvipcode 为空,新增,反之修改
            if (strvipcode == "")
            {

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
                                                 WHERE  viptypeid IN (SELECT level1_type
                                                         FROM   [DRP_REPORT].[dbo].[Y_NPAIN_VIP_Config] 
                                                         WHERE  merchantid = @Param1
                                                         UNION
                                                         SELECT level2_type
                                                         FROM   [DRP_REPORT].[dbo].[Y_NPAIN_VIP_Config] 
                                                         WHERE  merchantid = @Param1
                                                         UNION
                                                         SELECT level3_type
                                                         FROM   [DRP_REPORT].[dbo].[Y_NPAIN_VIP_Config] 
                                                         WHERE  merchantid = @Param1 )
                                                         AND t1.vipcode = t2.vipcardid )
                                                         AND mobtel = @Param0", new string[] { strmobtel, strParentid}).ToString();

                if (strflagTEL == "1")
                {
                    throw new Exception("该手机号已经存在！");
                }

                int nNum = 1;//默认是0
                vipid = "NP" + hzyMessage.User_Name + "-" + DateTime.Now.ToString("yyyy-MM-dd") + "-" + nNum.ToString("0000");
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
                        vipid = "NP" + hzyMessage.User_Name + "-" + DateTime.Now.ToString("yyyy-MM-dd") + "-" + nNum.ToString("0000");
                        continue;
                    }
                }
                #endregion

                #region 插入vip_user表

                string strSQL = @"
                        insert into dbo.vip_user 
                                (vipcode,vipname,vipsex,Employeeid,mobtel,vipbirth,
                                vipoccupation,add_province,add_city,vipadd, viplove,vipbrand1,
                                vipid,depotid,tz_name,vipstate,crdate,is_vip,qq,weibo,vipemail,liketalktype
	                              )
                             ( SELECT      
                                @Param0 vipcode,@Param1 vipname,@Param2 vipsex,@Param3 Employeeid,@Param4 mobtel,@Param5 vipbirth,
                                @Param6 vipoccupation,@Param7 add_province,@Param8 add_city,@Param9 vipadd,@Param10 viplove,@Param11 vipbrand1,
                                @Param12 vipid,@Param13 depotid,@Param14 tz_name,'金卡' vipstate,@Param15 crdate  ,'0' is_vip,
                                @Param16 qq,@Param17 weibo,@Param18 vipemail,@Param19 liketalktype
                                    )";
                m_conn.ExcuteQuerryByTran(strSQL, new object[] { strMaxvipcode, strvipname, strvipsex, stremployeeid, strmobtel, strvipbirth ,
                                                                strvipoccupation,stradd_province,strcity,strvipadd,strviplove,strvipbrand1,
                                                                vipid,strdepotid,strtz_name,timeNow,
                                                                strqq,strweibo,strvipemail,strliketalktype });

                #endregion

                #region 插入vip_cardvip表

                string strSQL1 = @"
                        INSERT INTO vip_cardvip(vipcardid,viptypeid,vipid,vipemit,vipemitadd,MaxDay,crdate,limitday,crname
	                              )
                             ( SELECT  @Param0 vipcardid, @Param6 viptypeid,@Param1 vipid,@Param2 vipemit,@Param3 vipemitadd,'1000' MaxDay,@Param4 crdate,'9999' limitday
                                       , @Param5 crname
                                    )";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { strMaxvipcode, vipid, timeNow, strdepotid, timeNow, hzyMessage.User_Name_CN.Substring(9), strlevel1_type });
                #endregion
            }
            else
            {
                #region 更新vip_cardvip表审核状态

                //更新的时候也要验证手机号
                string strflagTEL = m_conn.GetDataTableFirstValue(@"
                        SELECT  COUNT(*)
                                FROM    vip_user t1
                                WHERE   EXISTS ( SELECT *
                                                 FROM   vip_cardvip T2
                                                 WHERE  viptypeid IN ( SELECT level1_type
                                                         FROM   [DRP_REPORT].[dbo].[Y_NPAIN_VIP_Config] 
                                                         WHERE  merchantid = @Param2
                                                         UNION
                                                         SELECT level2_type
                                                         FROM   [DRP_REPORT].[dbo].[Y_NPAIN_VIP_Config] 
                                                         WHERE  merchantid = @Param2
                                                         UNION
                                                         SELECT level3_type
                                                         FROM   [DRP_REPORT].[dbo].[Y_NPAIN_VIP_Config] 
                                                         WHERE  merchantid = @Param2 )
                                                         AND t1.vipcode = t2.vipcardid  )
                                        AND mobtel = @Param0 and vipcode !=@Param1
                                        ", new string[] { strmobtel, strvipcode, strParentid }).ToString();

                if (strflagTEL == "1")
                {
                    throw new Exception("该手机号已经存在！");
                }

                string strSQL3 = @"UPDATE dbo.vip_user SET  vipname = @Param0,vipsex= @Param1 ,Employeeid=@Param2 , vipbirth=@Param3,
                                 vipoccupation=@Param4,add_province=@Param5 , add_city=@Param6, vipadd=@Param7,  viplove=@Param8,vipbrand1=@Param9 ,
                                 tz_name=@Param10,qq=@Param11,weibo=@Param12,vipemail=@Param13,liketalktype=@Param14,mobtel=@Param15
                                 WHERE vipcode ='" + strvipcode + "'";

                m_conn.ExcuteQuerryByTran(strSQL3, new object[] { strvipname, strvipsex, stremployeeid, strvipbirth, strvipoccupation, stradd_province, strcity, strvipadd
                ,strviplove,strvipbrand1,strtz_name,strqq,strweibo,strvipemail,strliketalktype,strmobtel});
                #endregion
            }
            m_conn.CommitTransaction();

            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #endregion
    }
}