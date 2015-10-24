using System;
using System.Collections.Generic;
using System.Web;
using System.ComponentModel;
using System.Data.OracleClient;
using System.Data;
using System.Drawing;
using System.Text;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base; 

namespace HZY.COM.DRP
{
    public class DRP_ShopDetailTarget_EditByXML : LogicBase, ILogicGetData
    {
        public DRP_ShopDetailTarget_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        public DataSet GetData()
        {

            DataSet ds = new DataSet();
            DataSet ds_Return = new DataSet();
          //  #region 从region到endregion是手工写的。别的都是系统自动生成的
            string constring = @"Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.0.62) (PORT=1521)))(CONNECT_DATA=(SERVICE_NAME= orcl)));User Id=prod01; Password=elegantbi";//定义连接数据库的字符串              
            //string constring = @"Dsn=ORCL;uid=prod01;pwd=elegantbi;";//定义连接数据库的字符串              
            OracleConnection conn = new OracleConnection(constring);//进行连接             
            try
            {
                conn.Open();//打开指定的连接                  

              //  OracleDataAdapter oda = new OracleDataAdapter("select * from dim_shop", conn);
                string strXML = "";
                string strSQL = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                //XML是前台传入
                ds = Common.Common.GetDSByExcelXML(strXML);

                if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "GET")
                //读取ROWS到/ROWS 中的参数
                {

                    string strWHERE = " and 1=1";
 
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                  //  strSQL = @" Select * from 
                   //             dim_shop    
                    //             ";
                    strSQL = @"    Select dim_shop.COSTCENTER as SSCOSTCENTER,
                                   Dim_Shop.Costcenter As Gzcostcenter,
                                   Substr(Tmp_Shop_Dayly.Dates,1,4)||'-'||Substr(Tmp_Shop_Dayly.Dates,5,2) as dates,
                                   '店铺总销售' As Satype,
                                    tmp_shop_dayly.fcalcsums_all    
                                    From Dim_Shop,Tmp_Shop_Dayly
                                    where dim_shop.shopid=tmp_shop_dayly.depotid 
                                    " + strWHERE;


                    OracleDataAdapter oda = new OracleDataAdapter(strSQL, conn);


                    oda.Fill(ds_Return, "Data");
                    conn.Close();//关闭reader.这是一定要写的     
                  //  return ds; 
                }

                return ds_Return; 
 
                      
            }
            catch
            {
                throw;     
            }
            finally
            {
                conn.Close();//关闭打开的连接           
            }

            
         //   #endregion

           
        }

    }
        
}