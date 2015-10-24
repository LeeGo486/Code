using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.ST1005A;
using HZY.COM.Common.Base;

/// 类名：MDM2_Depot_Info
/// 类说明：获取GP店铺相关信息（店铺信息，店铺营业员信,取GP店铺前缀）
/// 创建人：郭琦琦 
/// 创建日期：2014-02-24 
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{

    public class MDM2_Depot_Info : HZYLogicBase, ILogicGetData
    {
        public MDM2_Depot_Info()
        {
            this.m_SessionCheck = false ;
        }

        private Dbconn conn = new Dbconn("F22GP");

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                //根据用户登录信息取到权限信息
                MDM_System_User_Authorization_GetListBySession_ID cls = new MDM_System_User_Authorization_GetListBySession_ID();
                cls.hzyMessage = this.hzyMessage;
                DataSet dsAUZ = cls.GetData();

                string strComList = "";
                if (dsAUZ.Tables[0].Rows.Count > 0)
                {
                    DataRow[] listAuzCom = dsAUZ.Tables[0].Select("Authorization_Name" + " like'%COM%'");
                    for (int k = 0; k < listAuzCom.Length; k++)
                    {
                        if (k > 0)
                        {
                            strComList += ",";
                        }
                        string strCom = listAuzCom[k]["Authorization_Name"].ToString();
                        strComList += strCom.Substring(strCom.Length - 1);
                    }
                }
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
                {
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GETFORCOMBOBOX")
                    {
                        string strSQL = @"
                                         SELECT 
                                                a.depotid,
                                                a.d_name,
                                                a.areaid,
                                                b.shutname,
                                                CASE a. m_type
                                                    WHEN 11 THEN '自营'
                                                    WHEN 92 THEN '加盟'
                                                    WHEN 0 THEN '总仓'
                                                END AS m_type
                                        FROM   [F22GP].[dbo].[j_depot] a,
                                                [F22GP].dbo.j_area b
                                        WHERE  a.areaid = b.areaid" + m_hzyPageInfo.Where;
                        string strWhereTmp = " AND (depotid LIKE '" + strComList.Replace(",", "%'   OR depotid LIKE '") + "%')";
                        ds_Return = conn.GetDataSetForPageList(strSQL + strWhereTmp, new string[0],m_hzyPageInfo);
                    }
                        //取GP店铺所有信息
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GETDEPOTINFO")
                    {
                        string strSQL = @"
                                       SELECT  CASE WHEN LEFT(DEPOTID, 1) = 'N' THEN '纳卉'
                                                    WHEN LEFT(DEPOTID, 1) = 'A' THEN '嘉雅'
                                                    WHEN LEFT(DEPOTID, 1) = 'Z' THEN '郑州'
                                                    WHEN LEFT(DEPOTID, 1) = 'K' THEN '诺珂'
                                                    WHEN LEFT(DEPOTID, 1) = 'D' THEN '贝爱'
                                                    WHEN LEFT(DEPOTID, 1) = 'E' THEN '雅莹'
                                                    WHEN LEFT(DEPOTID, 1) = 'X' THEN '新疆'
                                                    WHEN LEFT(DEPOTID, 1) = 'W' THEN '维姬'
                                                    WHEN LEFT(DEPOTID, 1) = 'J' THEN '卓莱雅'
                                                    WHEN LEFT(DEPOTID, 1) = 'M' THEN '嘉澜'
                                                    WHEN LEFT(DEPOTID, 1) = 'L' THEN '雅妍集'
                                                    WHEN LEFT(DEPOTID, 1) = 'H' THEN '泓雅'
                                                    WHEN LEFT(DEPOTID, 1) = 'H' THEN '慧斓'
                                                    WHEN LEFT(DEPOTID, 1) = 'F' THEN '嘉莹'
                                                    WHEN LEFT(DEPOTID, 1) = 'Y' THEN '恩派雅'
                                                    WHEN LEFT(DEPOTID, 1) = 'P' THEN '澳门'
                                                    WHEN LEFT(DEPOTID, 1) = 'S' THEN '斓居'
                                                    WHEN LEFT(DEPOTID, 1) = 'R' THEN '斓绣'
                                                    WHEN LEFT(DEPOTID, 1) = 'G' THEN '雅斓'
                                                    WHEN LEFT(DEPOTID, 1) = 'O' THEN '雅斓电商'
                                                    WHEN LEFT(DEPOTID, 1) = 'Q' THEN '拉萨格桑拉'
                                            END AS 公司 ,
                                            depotid ,
                                            areaid ,
                                            d_name ,
                                            r_name ,
                                            Tel ,
                                            Fax ,
                                            email ,
                                            CASE m_type
                                                WHEN 11 THEN '自营'
                                                WHEN 92 THEN '加盟'
                                                WHEN 0 THEN '总仓'
                                            END AS m_type ,
                                            Comment ,
                                            CrDate ,
                                            updatetime ,
                                            scale ,
                                            acreage ,
                                            begdate ,
                                            enddate ,
                                            fristdate ,
                                            avgsum ,
                                            leven ,
                                            pact ,
                                            present ,
                                            cwkh ,
                                            cwbm ,
                                            jsrq ,
                                            sums ,
                                            rate ,
                                            bail ,
                                            s_sums ,
                                            bank ,
                                            account ,
                                            backrate ,
                                            backadd ,
                                            backspare ,
                                            backdate ,
                                            bachcredit ,
                                            havepact ,
                                            fh_sums ,
                                            unitid ,
                                            address ,
                                            hjsl ,
                                            yyrs ,
                                            bdje ,
                                            fhjs ,
                                            dpthelp ,
                                            power_rate ,
                                            power_jpric ,
                                            power_xpric ,
                                            power_nums ,
                                            power_sprice ,
                                            power_2rate ,
                                            freeze ,
                                            power_45 ,
                                            zbset ,
                                            pos_haveprn ,
                                            pos_prncnt ,
                                            pos_prn ,
                                            pos_scr ,
                                            pos_vipzsz ,
                                            pos_vipshow ,
                                            pos_round ,
                                            clothing_len ,
                                            pos_ifday ,
                                            pos_day ,
                                            pos_fh ,
                                            parentid ,
                                            qryday ,
                                            mobtel ,
                                            floor ,
                                            floortype ,
                                            floorname ,
                                            floorloop ,
                                            stylenums ,
                                            depotpower ,
                                            brandpower ,
                                            del ,
                                            xpname ,
                                            qxadd ,
                                            setkc0 ,
                                            zbget ,
                                            zmrqdate ,
                                            onlybdkc ,
                                            nozckc ,
                                            autosetdepotid ,
                                            fh_sure ,
                                            parentget ,
                                            maxkcsums ,
                                            maxkcnums ,
                                            pos_off ,
                                            FRoundDec ,
                                            pos_AppPro ,
                                            pos_ProInc ,
                                            pos_SelCx ,
                                            pos_novip ,
                                            pos_ifkc ,
                                            pic1 ,
                                            pic2 ,
                                            pceid ,
                                            d_dq ,
                                            d_dd ,
                                            d_hp ,
                                            d_lx ,
                                            b28web ,
                                            brandid ,
                                            begdepotdate ,
                                            enddepotdate ,
                                            old_depotid ,
                                            depot_no ,
                                            pos_cxsy ,
                                            pos_jprice ,
                                            pos_cxvip ,
                                            pos_nozs ,
                                            pos_spxp ,
                                            vip_chkup ,
                                            vip_lookunit ,
                                            webprint ,
                                            costcenter ,
                                            indentplanid ,
                                            dhh_sums ,
                                            fm_type ,
                                            f_enddepotdate ,
                                            Dh_depot ,
                                            m_skfs ,
                                            m_swzt ,
                                            Modify_Date ,
                                            oldvnewv ,
                                            ChangeReason ,
                                            thck_sure ,
                                            d_qd ,
                                            Pos_VipBdz ,
                                            ESB_ID ,
                                            ESB_src_App ,
                                            Retail_ThDay ,
                                            YearGoal ,
                                            AreaManager ,
                                            BrandNumber
                                    FROM    dbo.j_depot
                                    WHERE   1 = 1  " + m_hzyPageInfo.Where;
                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                    }
                        //取GP店铺所有营业员信息
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GETEMPLOYEEINFO")
                    {
                        string strSQL = @"
                                         SELECT  employeeid ,
                                                    names ,
                                                    sex ,
                                                    depotid ,
                                                    groupid ,
                                                    userrate ,
                                                    birthday ,
                                                    IDCard ,
                                                    workdate ,
                                                    telephone ,
                                                    address ,
                                                    usedstatus ,
                                                    valid ,
                                                    updatetime ,
                                                    Cr_name ,
                                                    Comment ,
                                                    cr_date ,
                                                    CrName ,
                                                    level ,
                                                    Modify_Date ,
                                                    ESB_ID ,
                                                    ESB_src_App ,
                                                    YearGoal ,
                                                    Position ,
                                                    job_number
                                            FROM    dbo.j_employee
                                         WHERE  1=1  and  valid = 0" + m_hzyPageInfo.Where;
                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                    }
                        //取GP店铺前缀
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GETSTORE_PREFIX")
                    {
                        string strSQL = @"
                                        sELECT  店铺前缀
                                        FROM    ( SELECT 
                                                                                                                DISTINCT
                                                            SUBSTRING(depotid, 1, 1) 店铺前缀
                                                    FROM      [dbo].[j_depot]
                                                    WHERE     1 = 1
                                                            AND depotid NOT LIKE 's%'
                                                ) t
                                        " + m_hzyPageInfo.Where;
                        ds_Return = conn.GetDataSet(strSQL);
                    }
                        //通过店铺编号前缀获取店铺大区
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GETDQ")
                    {
                        string strSQL = @"
                                   SELECT  DISTINCT
                                            d_dq ,
                                            d_dq
                                     FROM   dbo.j_depot
                                     WHERE  d_name NOT LIKE '停%'
                                            AND d_name NOT LIKE 'P停%'
                                            AND m_type NOT IN ( '0', '90', '80' )
                                            AND d_dq IS NOT  NULL
                                            " + m_hzyPageInfo.Where;
                        ds_Return = conn.GetDataSet(strSQL);
                    }
                    //通过店铺登入ID判断是店铺还是总部人员
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "VERIFICATION")
                    {
                        string strSQL = @"
                                    SELECT TOP 2 depotid
                                    FROM    dbo.j_user WITH ( NOLOCK )
                                    WHERE   1=1 " + m_hzyPageInfo.Where;
                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                    }
                }
                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
    }
}
