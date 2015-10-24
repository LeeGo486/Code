using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references

namespace Talent.DAL
{
    /// <summary>
    /// 数据访问类:TB_RC_InterViewer
    /// </summary>
    public partial class TB_RC_InterViewer
    {
        private DbHelperSQLP dbhelp = null;

        public TB_RC_InterViewer()
		{
            this.dbhelp = new DbHelperSQLP(PubConstant.TalentConnectionString);
        }

        #region Method

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList()
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select IV_No,IV_Class from dbo.TB_RC_InterViewer");

            return dbhelp.Query(strSql.ToString());
        }
        #endregion
    }
}
