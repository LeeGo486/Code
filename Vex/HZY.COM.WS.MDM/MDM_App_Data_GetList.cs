using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_App_Data_GetList
/// 类说明：获取MDM应用的数据
/// 创建人：马卫清
/// 创建日期：2013-05-04 
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 获取MDM应用的数据
    /// </summary>
    public class MDM_App_Data_GetList : LogicBase, ILogicGetData   
    {
        public MDM_App_Data_GetList()
        {
            this.m_SessionCheck = false  ; 
              
        }

        /// <summary>
        /// 获取MDM应用的数据
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                MDM_GetEntityData mdm = new MDM_GetEntityData();
                string[] strColumn = new string[3];
                string[] strValue = new string[3];

                strColumn[0] = "Columns";
                strValue[0] = "[应用简称,L01,应用简称,CN]";

                strColumn[1] = "Where";
                strValue[1] = " 应用简称 LIKE '%F22%' ";

                strColumn[2] = "MainEntity";
                strValue[2] = "L01";
                mdm.Request = Common.Common.GetRequestDataSet(strColumn,strValue);

                DataSet returnDs = mdm.GetData();
                return returnDs;
            }
            catch  
            {
                throw;

            }



        }

    }

}