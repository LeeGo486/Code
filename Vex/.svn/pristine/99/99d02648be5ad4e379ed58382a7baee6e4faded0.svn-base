using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_UserRelation_ExecuteGetFromTFG 从TFG中取到TFG与AM用户之间的关系，并插入到MDM中
    /// </summary>
    public class MDM_UserRelation_ExecuteGetFromTFG : LogicBase, ILogicExecute
    {
        public MDM_UserRelation_ExecuteGetFromTFG()
        {
            this.m_SessionCheck = false;

        }


        public bool Execute()
        {
            Dbconn conn = new Dbconn("iCollecter");
            DataSet ds = conn.GetDataSet(
                @"  SELECT  AMLoginName AS CN_LOGIN,TfgMachineNo,ComputerName
                    FROM    ( SELECT    ROW_NUMBER() OVER ( PARTITION BY TfgMachineNo ORDER BY collectDate DESC ) AS RowIndex ,
                                        ComputerName ,
                                        AMLoginName,
                                        TfgMachineNo
                              FROM      dbo.AMAndTFG WITH(NOLOCK)
                              WHERE     1 = 1
                                        AND ISNULL(AMLoginUsers, '') <> ''
                            ) t
                    WHERE   RowIndex = 1
 	                    ");



            Dbconn connMDM = new Dbconn("MDM");


            //获取用户ID
            ds.Tables[0].Columns.Add("AM_User_id", typeof(Int32));

            ds.Tables[0].AcceptChanges();
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string[] strParm = new string[1];
                strParm[0]=ds.Tables[0].Rows[i]["CN_LOGIN"].ToString();

                DataTable dt = connMDM.GetDataTable("SELECT AM_User_id FROM AM_User WHERE AM_login=@Param0", strParm);
                if (dt.Rows.Count > 0)
                {
                    ds.Tables[0].Rows[i]["AM_User_id"] = dt.Rows[0]["AM_User_id"];
                }
                else
                {
                    ds.Tables[0].Rows[i].Delete();
                }

            }

            ds.Tables[0].Columns.Remove("CN_LOGIN");
            ds.Tables[0].AcceptChanges();
            try
            {


                ArrayList tableList = new ArrayList();
                connMDM.BeginTransaction();

                tableList.Add("AM_TFG_Relation_log");
                tableList.Add("AM_TFG_Relation");
                connMDM.TableLock(tableList);


                //存入日志数据
                connMDM.ExcuteQuerryByTran(@"INSERT  INTO dbo.AM_TFG_Relation_log
                ( Log_datetime ,
                  AM_User_id ,
                  TfgMachineNo ,
                  ComputerName ,
                  CreateTime ,
                  UpdateTime ,
                  Timestamps_old
		        
                )
                SELECT  GETDATE() ,
                        AM_User_id ,
                        TfgMachineNo ,
                        ComputerName ,
                        CreateTime ,
                        UpdateTime,
                        Convert(bigint,Timestamps)
                FROM    AM_TFG_Relation;");


                //删除数据
                connMDM.ExcuteQuerryByTran("DELETE  FROM AM_TFG_Relation");
                connMDM.Insert("AM_TFG_Relation", ds.Tables[0]);
                connMDM.CommitTransaction();

                return true;

            }
            catch
            {
                connMDM.RollbackTransaction();
                throw;
            }
        }

    }

}