using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：WS_Deploy_ForEasyUI
/// 类说明：部署WS,为Easyui专用
/// 创建人：马卫清
/// 创建日期：2013-10-24
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{
    /// <summary>
    /// 部署WS,为Easyui专用
    /// </summary>
    public class WS_Deploy_ForEasyUI : LogicBase, ILogicGetData
    {
        public WS_Deploy_ForEasyUI()
        {
            this.m_SessionCheck = true;

        }

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        /// <summary>
        /// 部署WS,为Easyui专用
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                for (int i = 0; i < dt_OPTYPE.Rows.Count; i++)
                {

                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                    {
                        DataSet ds1 = new DataSet();
                        ds1.Tables.Add(ds.Tables["list"].Copy());

                        WS_Deploy cls = new WS_Deploy();
                        cls.hzyMessage = this.hzyMessage;

                        cls.Request = ds1;
                        bool bResult = cls.Execute();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "同步成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "同步失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);

                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "操作失败" });
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                   
                }
                return ds_Return;
            }
            catch
            {
                throw;

            }
        }
    }

}