using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System.Collections;
using HZY.COM.Common.Base;

/// 类名：AMSendDesingerStyleChanged
/// 类说明：PLMAS-CONF-当设计师对应的款式发生改变时
/// 创建人：马卫清
/// 创建日期：2014-04-23
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.PLMAS
{

    public class AMSendDesingerStyleChanged : HZYLogicBase, ILogicGetData
    {
        public AMSendDesingerStyleChanged()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn;

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dtOPTYPE = ds.Tables["OPTYPE"];
                DataTable dtList = ds.Tables["List"];

                var strzt = dtList.Rows[0]["zt"].ToString();//获取帐套


                conn = new Dbconn("PLM_AS_" + strzt);

                if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "SendAM".ToUpper())
                {
                    string strProductName = dtList.Rows[0]["ProductName"].ToString();

                    string strUserPost = conn.GetDataTableFirstValue(@"
                                                                        SELECT  UserPost
                                                                        FROM    Userinfo
                                                                        WHERE   username = @Param0
                                                                        ", new string[] { m_hzyMessage.User_Name }).ToString();

                    string strUserNameC = conn.GetDataTableFirstValue(@"
                                                                        SELECT  UserNameC
                                                                        FROM    Userinfo
                                                                        WHERE   username = @Param0
                                                                        ", new string[] { m_hzyMessage.User_Name }).ToString();

                    string strSQL = @"
                                    SELECT Designer,DesignerId,OrderSeason,producttype,part, brand FROM dbo.FLEXPLMProduct
                                    WHERE ProductName=@Param0"
                                    ;

                    DataTable dt = conn.GetDataTable(strSQL, new string[] { strProductName });
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string strContent = @"{6}你好：{0}于{1}变更了设计号为{2}的款式信息，变更后信息为：
                                                                    <p>　　　　设计号：{2}<p>
                                                                    <p>　　　　订货会季节：{3}<p>
                                                                    <p>　　　　款式类型：{4}<p>
                                                                    <p>　　　　款式类别：{5}<p>
                                                                    <p>　　　　请及时跟踪！<p>
                                                                ";

                        string strDesigner = dt.Rows[i]["Designer"].ToString();
                        string strBrand = dt.Rows[i]["brand"].ToString();
                        if (strDesigner != strUserNameC)
                        {
                            string strContentSend = string.Format(strContent, new string[] { strUserNameC, DateTime.Now.ToString("yyyy年MM月dd日"),
                                dt.Rows[i]["DesignerId"].ToString(), 
                                dt.Rows[i]["OrderSeason"].ToString(), 
                                dt.Rows[i]["producttype"].ToString(), 
                                dt.Rows[i]["part"].ToString() ,
                                strDesigner});

                            if (Common.Common.m_RouteCode != null && Common.Common.m_RouteCode.ToUpper() == "PROD")
                            {
                                AM.AMSendMsg.Send("AM", "PLMAS", strDesigner, "PLM系统", strContentSend, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                            }
                            else
                            {
                                AM.AMSendMsg.Send("AM", "PLMAS", "马卫清", "PLM系统", strContentSend, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));

                            }

                        }


                        DataTable dt1 = conn.GetDataTable(@"
                                SELECT UserNameC FROM dbo.USERINFO
                                 WHERE UserPost='版师助理'
                                 AND OwnedBrand=@param0
                                ", new string[] { strBrand });

                        for (int j = 0; j < dt1.Rows.Count; j++)
                        {
                            strDesigner = dt1.Rows[j][0].ToString();

                            string strContentSend = string.Format(strContent, new string[] { strUserNameC, DateTime.Now.ToString("yyyy年MM月dd日"),
                                dt.Rows[i]["DesignerId"].ToString(), 
                                dt.Rows[i]["OrderSeason"].ToString(), 
                                dt.Rows[i]["producttype"].ToString(), 
                                dt.Rows[i]["part"].ToString(),
                                strDesigner });

                            //正式库
                            if (Common.Common.m_RouteCode != null && Common.Common.m_RouteCode.ToUpper() == "PROD")
                            {
                                AM.AMSendMsg.Send("AM", "PLMAS", strDesigner, "PLM系统", strContentSend, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                            }
                            else//其他系统
                            {
                                AM.AMSendMsg.Send("AM", "PLMAS", "卞磊", "PLM系统", strContentSend, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                            }
                        }
                    }

                }
                dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                ds_Return.Tables.Add(dt_EditResult);
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
