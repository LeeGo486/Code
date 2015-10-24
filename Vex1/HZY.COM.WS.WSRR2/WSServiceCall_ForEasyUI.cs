using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

/// 类名：WSServiceCall_ForEasyUI 
/// 类说明：任务列表项目操作入口，通过WSID进入
/// 创建人：HWA-沈加华
/// 创建日期：2014-11-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{
    /// <summary>
    /// 任务列表项目操作入口，通过WSID进入
    /// </summary>
    public class WSServiceCall_ForEasyUI : LogicBase, ILogicGetData
    {
        public WSServiceCall_ForEasyUI()
        {
            this.m_SessionCheck = true;
        }

        public DataSet GetData()
        {
            try
            {
                Dbconn conn = new Dbconn("WSRR");    //创建连接类
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();
                DataTable dt_EditResult = new dsCommon.dtResultDataTable();

                string strXML = string.Empty;

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString(); //获取参数XML
                ds = Common.Common.GetDSByExcelXML(strXML); //转换XML到DataSet

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

                for (int i = 0; i < dt_OPTYPE.Rows.Count; i++)
                {
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                    {
                        //获取List操作
                        m_request.Tables[0].TableName = "Page_Info";
                        m_request.Tables[0].Columns.Remove("XML");  //删除参数列XML
                        WSServiceCall_GetList cls = new WSServiceCall_GetList();
                        cls.hzyMessage = this.hzyMessage;
                        cls.Request = m_request;
                        ds_Return = cls.GetData();  //调用WSServiceCall_GetList
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                    {
                        //编辑操作
                        DataSet ds1 = new DataSet();
                        ds1.Tables.Add(ds.Tables["list"].Copy());   //将XML获取的数据放入ds1

                        WSServiceCall_Edit cls = new WSServiceCall_Edit();
                        cls.hzyMessage = this.hzyMessage;   //session信息传递

                        cls.Request = ds1;  //传递参数
                        bool bResult = cls.Execute();   //调用WSServiceCall_Edit

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
                        ds1.Tables.Add(ds.Tables["list"].Copy());   //将XML获取的数据放入ds1

                        WSServiceCall_Delete cls = new WSServiceCall_Delete();
                        cls.hzyMessage = this.hzyMessage;   //session信息传递

                        cls.Request = ds1;//传递参数
                        bool bResult = cls.Execute();  //调用WSServiceCall_Delete

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
            catch (Exception)
            {
                throw;
            }
        }

    }
}
