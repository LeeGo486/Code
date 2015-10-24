using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
          
namespace HZY.COM.PLM
{
    /// <summary>
    ///WS_GetList 获取WSRR的基本信息
    /// </summary>
    public class PLM_GETListSamlpe : LogicBase, ILogicGetData
    {
        public PLM_GETListSamlpe()
        {
            this.m_SessionCheck = false;
        }

        /// <summary>
        /// 获取WSRR的基本信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {

                DataSet ds = new DataSet();

                int nPage = 1;
                int nPageRowCount = 10;
                string strOrder = " desc  ";
                string strSort = " SAPUNO ";
                string strWhere = " ";
                string strSearchFilter = " ";
                string strXml = "";
                  //&& m_request.Tables.Contains("Page_Info")
                if (m_request != null )
                {
                    nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                    nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                    strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                    strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                    strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;
                    strXml = m_request.Tables[0].Rows[0]["Xml"].ToString();
                    if (m_request.Tables[0].Columns.Contains("searchFilter"))
                    {
                        strSearchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : strSearchFilter;
                    }
                    if (strWhere.Trim() != "")
                    {
                        strWhere = " AND " + strWhere;
                    }

                    if (strSearchFilter.Trim() != "")
                    {
                        strWhere = " AND " + strSearchFilter;
                    }
                }

                Dbconn conn = new Dbconn("PLM_AS");
                

                if (strXml == "" )
                {
                    string strSQL = @"SELECT  SLALSU,LEFT(SASERI,1) SASERI,SLITDS,LEFT(SLCLID,1) SLCLID,SMFELE,SMFWTH,SMM3NO+LEFT(SLCLID,2) ITNO, ";
                    strSQL += @" CAST(SLTLQT AS DECIMAL(15,2)) SLTLQT, CAST(ISNULL(ICRPQA,0) AS DECIMAL(15,2)) SLRPQT,CAST(SLPUPR AS DECIMAL(15,2)) SLPUPR,CAST(ISNULL(ICRPQA,0)*SLPUPR AS DECIMAL(15,2)) SLTLAM,SLTLDT,ICRGDT,SLTLPE,SLPRMK,SLBUYE,SAPUNO,usernamec  INTO  #Tmp_Samlpe ";

                    strSQL += @" from PSMAPP A LEFT JOIN PSMAPPSUB B ON A.SAPPNO=B.SLPPNO LEFT JOIN PSMINF C ON B.SLITNO=C.SMITNO LEFT JOIN USERINFO D ON B.SLBUYE=D.username";
                    strSQL += @" LEFT JOIN ERP.elegant_prod.DBO.MPLIND E ON SAPUNO=E.ICPUNO AND SLPNLI=ICPNLI";
                    strSQL += @" WHERE 1=1 " + strWhere ;
                      
                    strSQL += @" SELECT * FROM (SELECT ROW_NUMBER() OVER ( ORDER BY " + strSort + " " + strOrder + @" ) AS RowIndex , ";
                    strSQL += @" #Tmp_Samlpe.* FROM #Tmp_Samlpe WHERE 1=1 " + strWhere + @" ) t1 ";
                    strSQL += @" WHERE   RowIndex > " + (nPage - 1) * nPageRowCount + @" AND RowIndex <= " + (nPage) * nPageRowCount + @" ORDER BY RowIndex ASC ";
                    strSQL += @" SELECT Count(1) as AllRowCount FROM #Tmp_Samlpe WHERE 1=1 " + strWhere + @" DROP TABLE #Tmp_Samlpe ";

                    ds = conn.GetDataSet(strSQL);
                    ds.Tables[1].TableName = "PageRowCount";
                    
                };

                if (strXml != "")
                {
                    string strSQL = @"SELECT  SLALSU,LEFT(SASERI,1) SASERI,SLITDS,LEFT(SLCLID,1) SLCLID,SMFELE,SMFWTH,SMM3NO+LEFT(SLCLID,2) ITNO, ";
                    strSQL += @" CAST(SLTLQT AS DECIMAL(15,2)) SLTLQT, CAST(ISNULL(ICRPQA,0) AS DECIMAL(15,2)) SLRPQT,CAST(SLPUPR AS DECIMAL(15,2)) SLPUPR,CAST(ISNULL(ICRPQA,0)*SLPUPR AS DECIMAL(15,2)) SLTLAM,SLTLDT,ICRGDT,SLTLPE,SLPRMK,SLBUYE,SAPUNO,usernamec   ";

                    strSQL += @" from PSMAPP A LEFT JOIN PSMAPPSUB B ON A.SAPPNO=B.SLPPNO LEFT JOIN PSMINF C ON B.SLITNO=C.SMITNO LEFT JOIN USERINFO D ON B.SLBUYE=D.username";
                    strSQL += @" LEFT JOIN ERP.elegant_prod.DBO.MPLIND E ON SAPUNO=E.ICPUNO AND SLPNLI=ICPNLI";

                    strSQL += @" WHERE 1=1 " + strWhere;

                    ds = conn.GetDataSet(strSQL);
                     
                    
                };
                return ds;
            }
            catch
            {
                throw;

            }



        }

    }

}