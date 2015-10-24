using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

/// 类名：WSServiceCall_Param_Edit_ForEasyUI 
/// 类说明：任务列表项目参数操作入口
/// 创建人：HWA-沈加华
/// 创建日期：2014-11-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{
    /// <summary>
    /// 任务列表项目参数操作入口
    /// </summary>
    public class WSServiceCall_Param_Edit_ForEasyUI : LogicBase, ILogicGetData
    {
        public WSServiceCall_Param_Edit_ForEasyUI()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn = new Dbconn("MDM");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        /// <summary>
        /// 任务列表项目参数操作
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();  //获取参数XML

                ds = Common.Common.GetDSByExcelXML(strXML); //将XML转化为DataSet

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                for (int i = 0; i < dt_OPTYPE.Rows.Count; i++)
                {
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                    {
                        //获取List操作
                        ds.Tables.Remove("OPTYPE");
                        WSServiceCall_Param_GetListByTaskID cls = new WSServiceCall_Param_GetListByTaskID();
                        cls.hzyMessage = this.hzyMessage;   //传递session
                        cls.Request = ds;   //传递ds
                        ds_Return = cls.GetData();  //调用WSServiceCall_Param_GetListByTaskID
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                    {
                        //编辑操作
                        DataSet ds1 = new DataSet();
                        ds1.Tables.Add(ds.Tables["list"].Copy());

                        WSServiceCall_Param_Edit cls = new WSServiceCall_Param_Edit();
                        cls.hzyMessage = this.hzyMessage;  //传递session
                        cls.Request = ds1;  //传递ds1
                        bool bResult = cls.Execute();//调用WSServiceCall_Param_Edit

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "修改失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        //删除操作
                        DataSet ds1 = new DataSet();
                        ds1.Tables.Add(ds.Tables["list"].Copy());

                        WSServiceCall_Param_Delete cls = new WSServiceCall_Param_Delete();
                        cls.hzyMessage = this.hzyMessage;  //传递session
                        cls.Request = ds1; //传递ds1
                        bool bResult = cls.Execute();//调用WSServiceCall_Param_Delete

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "删除成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "删除失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
                        ds_Return.Tables.Add(dt_EditResult);

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
