using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;


using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.ST1005A;

/// 类名：GoodsShow
/// 类说明：对Goods(商品管理)的CRUD,为Easyui专用
/// 创建人：刘洪
/// 创建日期：2015-01-28
/// 修改人：
/// 修改日期： 
/// 修改内容：
/// WSID: b7b1c571-24b0-4005-a7cc-a95c68707a67

namespace HZY.COM.WS.Present
{
    public class GoodsShow: HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public GoodsShow() {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("HZY_Present");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        private DataTable dt_List = new dsCommon.dtResultDataTable();
        private DataSet m_RequestXML = new DataSet();
        private DataSet m_ReturnData = new DataSet();

        DateTime now = DateTime.Now;
        #endregion

        #region 方法入口
        public DataSet GetData()
        {
            try
            {
                //接收XML的内容
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                m_RequestXML = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = m_RequestXML.Tables["OPTYPE"];
                dt_List = m_RequestXML.Tables["List"];
                string strTag = dt_OPTYPE.Rows[0][0].ToString().ToUpper().ToString();

                if (strTag == "GetGoods".ToUpper())
                {
                    GetGoods("");
                }
                else if (strTag == "GoodsInfo".ToUpper())
                {
                    GoodsInfo();
                }
                else if (strTag == "Classify".ToUpper())
                {
                    Classify();
                }
                else if (strTag == "GetClassifyGoods".ToUpper())
                {
                    GetClassifyGoods();
                }
                else if (strTag == "SaveEdit".ToUpper())
                {
                    
                }
                else if (strTag == "UptStatus".ToUpper())
                {
                    
                };
                return m_ReturnData;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            };
        }
        #endregion

        #region 内部函数
            #region GetGoods
                private void GetGoods(string where)
                {
                            string strSQL = @"SELECT  [GoodsID]
                                                              ,[GoodsNo]
                                                              ,[Name]
                                                              ,[CategoryCode]
                                                              ,[Description]
                                                              ,[Detail]
                                                              ,[Price]
                                                              ,[RetailPrice]
                                                              ,[Spec]
                                                              ,[PicPath]
                                                              ,[Status]
                                                              ,[CreateUser]
                                                              ,[CreateTime]
                                                              ,[LmUser]
                                                              ,[LmDt]
                                                        FROM [dbo].[Goods] WITH(NOLOCK)
                                                        WHERE [Status] = '已上架'  " + where;
                            m_ReturnData = conn.GetDataSet(strSQL);
                        }
            #endregion

            #region GoodsInfo
                    private void GoodsInfo() {
                        string strGoodsNo = dt_List.Rows[0]["GoodsNo"].ToString();
                        string strSQL = @"
                                                    SELECT  [GoodsID]
                                                          ,[GoodsNo]
                                                          ,[Name]
                                                          ,[CategoryCode]
                                                          ,[Description]
                                                          ,[Detail]
                                                          ,[Price]
                                                          ,[RetailPrice]
                                                          ,[Spec]
                                                          ,[PicPath]
                                                          ,[Status]
                                                      FROM [dbo].[Goods] WITH(NOLOCK)
                                                      WHERE [Status] = '已上架' AND [GoodsNo] = '" + strGoodsNo + "'";
                        m_ReturnData = conn.GetDataSet(strSQL);
                    }
            #endregion

            #region Classify
            private void Classify()
            {
                string strSQL = @"SELECT DISTINCT [Code]
                                                            ,[Name]
                                                FROM [dbo].[Category] WITH(NOLOCK)";
                m_ReturnData = conn.GetDataSet(strSQL);
            }
            #endregion

            #region GetClassifyGoods
                private void GetClassifyGoods() {
                    string strWhere = "";
                    string strCode = dt_List.Rows[0]["Code"].ToString();

                    if (strCode != "") {
                        strWhere = " AND [CategoryCode] = '" + strCode + "'";
                    };
                    GetGoods(strWhere);
                }
            #endregion
        #endregion
    }
}
