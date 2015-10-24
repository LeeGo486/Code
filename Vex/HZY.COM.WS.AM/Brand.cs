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

/// 类名：BR1_Brand
/// 类说明：对BR1_Brand(品牌的增删改查)的CRUD,为Easyui专用
/// 创建人：郭琦琦
/// 创建日期：2014-05-22 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.AM
{
    public class SendMessage : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public SendMessage()
        {
            this.m_SessionCheck = false;
        }
        #endregion


        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            DataSet ds_Return = new DataSet();
            DataTable dt_EditResult = new dsCommon.dtResultDataTable();

            string strType = m_request.Tables[0].Rows[0]["Type"].ToString();
            string strSystem = m_request.Tables[0].Rows[0]["System"].ToString();
            string strReceiver = m_request.Tables[0].Rows[0]["Receiver"].ToString();
            string strSender = m_request.Tables[0].Rows[0]["Sender"].ToString();
            string Content = m_request.Tables[0].Rows[0]["Content"].ToString();
            string SendTime = m_request.Tables[0].Rows[0]["SendTime"].ToString();

            string strResult = AMSendMsg.Send(strType, strSystem, strReceiver, strSender, Content, SendTime);

            if (strResult == "0")
            {
                dt_EditResult.Rows.Add(new object[] { false, "发送成功！" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "发送失败！" });
            }

            ds_Return.Tables.Add(dt_EditResult);

            return ds_Return;

        }
        #endregion


    }
}