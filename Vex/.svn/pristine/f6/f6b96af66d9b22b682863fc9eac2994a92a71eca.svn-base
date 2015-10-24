using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_System_User_Authorization_GetListBySession_ID 
/// 类说明：取所有审批权限和小翅膀提醒人员
/// 创建人：郭琦琦
/// 创建日期：204-03-20
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.StoreBusinessSystem
{
    /// <summary>
    ///Inventory_Authority_List 取所有审批权限和小翅膀提醒人员
    /// </summary>
    public class Inventory_Authority_List : LogicBase, ILogicGetData
    {

        public Inventory_Authority_List()
        {
            this.m_SessionCheck = false;

        }

        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("HZY_Mat");
            string strSQL = @"
                            SELECT  
                            [Inventort_Authority_ID] ,
                            [Store_prefix] ,
                            [AreaName] ,
                            [Branch_POS] ,
                            [Branch_AM] ,
                            [General_POS] ,
                            [General_AM] ,
                            [Financial_POS] ,
                            [Financial_AM]
                    FROM    [inventory].[Inventort_Authority]
                    where 1=1 ";
            DataSet ds = conn.GetDataSet(strSQL);
            return ds;
        }

    }

}