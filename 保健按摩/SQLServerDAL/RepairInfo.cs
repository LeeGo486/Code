using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using EPReper.IDAL;
using EPReper.DBUtility;//Please add references
namespace EPReper.SQLServerDAL
{
    /// <summary>
    /// 数据访问类:RepairInfo
    /// </summary>
    public partial class RepairInfo : IRepairInfo
    {
        public RepairInfo()
        { }
        #region  Method

        /// <summary>
        /// 得到最大ID
        /// </summary>
        public int GetMaxId()
        {
            return DbHelper.GetMaxID("id", "RepairInfo");
        }




        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(EPReper.Model.RepairInfo model)
        {
            string str = "select count(code) from RepairInfo where bigid = " + model.BigID + " and isdel = 0 and finish!= 2 and code > 0 ";
            model.code = Convert.ToInt32(DbHelper.ExecuteScalar(CommandType.Text, str, null)) + 1;

            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into RepairInfo(");
            strSql.Append("BigID,ClassID,userID,UpTime,Times,StartComment,Finish,isDel,applyPhone,code,BaseCode)");
            strSql.Append(" values (");
            strSql.Append("@BigID,@ClassID,@userID,@UpTime,@Times,@StartComment,@Finish,@isDel,@applyPhone,@code,@BaseCode)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
                    new SqlParameter("@BigID",SqlDbType.Int,4),
					new SqlParameter("@ClassID", SqlDbType.Int,4),                    
					new SqlParameter("@userID", SqlDbType.Int,4),
					new SqlParameter("@UpTime", SqlDbType.DateTime),
					new SqlParameter("@Times", SqlDbType.NVarChar,50),
					new SqlParameter("@StartComment", SqlDbType.NText),
					new SqlParameter("@Finish", SqlDbType.Int,4),
					new SqlParameter("@isDel", SqlDbType.Int,4),
                    new SqlParameter("@applyPhone",SqlDbType.VarChar,50),
                    new SqlParameter("@code",SqlDbType.Int,4),
                    new SqlParameter("@BaseCode",SqlDbType.NChar,20)};
            parameters[0].Value = model.BigID;
            parameters[1].Value = model.ClassID;
            parameters[2].Value = model.userID;
            parameters[3].Value = model.UpTime;
            parameters[4].Value = model.Times;
            parameters[5].Value = model.StartComment;
            parameters[6].Value = 0;
            parameters[7].Value = 0;
            parameters[8].Value = model.applyPhone;
            parameters[9].Value = model.code;
            parameters[10].Value = model.BaseCode;

            object obj = DbHelper.ExecuteNonQuery(CommandType.Text, strSql.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        public bool UpdateDal(string id, string userid, string repairphone)
        {

            string strSql = ("update RepairInfo set Finish = 1,DoTime = getdate(),ReperID = " + userid + ",repairPhone = " + repairphone + " where id = " + id);
            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql, null);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool UpdateEnd(string id, string OverComment)
        {

            string strSql = ("update RepairInfo set Finish=2,code = -1,overComment='" + OverComment + "',OverTime=getdate() where id = " + id);
            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql, null);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public bool UpCode(string bigid, string code)
        {
            StringBuilder strSql = new StringBuilder();
            //update [EPReper].[dbo].[RepairInfo] set code = code+1 where bigid=1 and code>2
            strSql.Append("update RepairInfo set ");
            strSql.Append("code = code - 1 ");
            strSql.Append("where BigID = @BigID and code > @code");
            SqlParameter[] parameters ={
                new SqlParameter("@BigID",SqlDbType.Int,4),
                new SqlParameter("@code",SqlDbType.Int,4)};
            parameters[0].Value = bigid;
            parameters[1].Value = code;
            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(EPReper.Model.RepairInfo model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update RepairInfo set ");
            strSql.Append("BigID=@BigID,");
            strSql.Append("ClassID=@ClassID,");
            strSql.Append("userID=@userID,");
            strSql.Append("point=@point,");
            strSql.Append("UpTime=@UpTime,");
            strSql.Append("DoTime=@DoTime,");
            strSql.Append("OverTime=@OverTime,");
            strSql.Append("Times=@Times,");
            strSql.Append("StartComment=@StartComment,");
            strSql.Append("OverComment=@OverComment,");
            strSql.Append("Finish=@Finish,");
            strSql.Append("isDel=@isDel");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@BigID", SqlDbType.Int,4),
					new SqlParameter("@ClassID", SqlDbType.Int,4),
					new SqlParameter("@userID", SqlDbType.Int,4),
					new SqlParameter("@point", SqlDbType.Int,4),
					new SqlParameter("@UpTime", SqlDbType.DateTime),
					new SqlParameter("@DoTime", SqlDbType.DateTime),
					new SqlParameter("@OverTime", SqlDbType.DateTime),
					new SqlParameter("@Times", SqlDbType.NVarChar,50),
					new SqlParameter("@StartComment", SqlDbType.NText),
					new SqlParameter("@OverComment", SqlDbType.NText),
					new SqlParameter("@Finish", SqlDbType.Int,4),
					new SqlParameter("@isDel", SqlDbType.Int,4),
                    new SqlParameter("@BaseCode",SqlDbType.NChar,20),
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = model.BigID;
            parameters[1].Value = model.ClassID;
            parameters[2].Value = model.userID;
            parameters[3].Value = model.point;
            parameters[4].Value = model.UpTime;
            parameters[5].Value = model.DoTime;
            parameters[6].Value = model.OverTime;
            parameters[7].Value = model.Times;
            parameters[8].Value = model.StartComment;
            parameters[9].Value = model.OverComment;
            parameters[10].Value = model.Finish;
            parameters[11].Value = model.isDel;
            parameters[12].Value = model.BaseCode;
            parameters[13].Value = model.id;

            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("update RepairInfo set isDel = 1,code = -1 ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
};
            parameters[0].Value = id;

            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /// <summary>
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string idlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from RepairInfo ");
            strSql.Append(" where id in (" + idlist + ")  ");
            int rows = DbHelper.ExecuteNonQuery(CommandType.Text, strSql.ToString());
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public EPReper.Model.RepairInfo GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 id,BaseCode,BigID,ClassID,userID,point,UpTime,DoTime,OverTime,Times,StartComment,OverComment,Finish,isDel from RepairInfo ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
};
            parameters[0].Value = id;

            EPReper.Model.RepairInfo model = new EPReper.Model.RepairInfo();
            DataSet ds = DbHelper.ExecuteDataSet(CommandType.Text, strSql.ToString(), null);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["id"] != null && ds.Tables[0].Rows[0]["id"].ToString() != "")
                {
                    model.id = int.Parse(ds.Tables[0].Rows[0]["id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["BaseCode"] != null && ds.Tables[0].Rows[0]["BaseCode"].ToString() != "")
                {
                    model.BaseCode = ds.Tables[0].Rows[0]["BaseCode"].ToString();
                }
                if (ds.Tables[0].Rows[0]["BigID"] != null && ds.Tables[0].Rows[0]["BigID"].ToString() != "")
                {
                    model.BigID = int.Parse(ds.Tables[0].Rows[0]["BigID"].ToString());
                }
                if (ds.Tables[0].Rows[0]["ClassID"] != null && ds.Tables[0].Rows[0]["ClassID"].ToString() != "")
                {
                    model.ClassID = int.Parse(ds.Tables[0].Rows[0]["ClassID"].ToString());
                }
                if (ds.Tables[0].Rows[0]["userID"] != null && ds.Tables[0].Rows[0]["userID"].ToString() != "")
                {
                    model.userID = int.Parse(ds.Tables[0].Rows[0]["userID"].ToString());
                }
                if (ds.Tables[0].Rows[0]["point"] != null && ds.Tables[0].Rows[0]["point"].ToString() != "")
                {
                    model.point = int.Parse(ds.Tables[0].Rows[0]["point"].ToString());
                }
                if (ds.Tables[0].Rows[0]["UpTime"] != null && ds.Tables[0].Rows[0]["UpTime"].ToString() != "")
                {
                    model.UpTime = DateTime.Parse(ds.Tables[0].Rows[0]["UpTime"].ToString());
                }
                if (ds.Tables[0].Rows[0]["DoTime"] != null && ds.Tables[0].Rows[0]["DoTime"].ToString() != "")
                {
                    model.DoTime = DateTime.Parse(ds.Tables[0].Rows[0]["DoTime"].ToString());
                }
                if (ds.Tables[0].Rows[0]["OverTime"] != null && ds.Tables[0].Rows[0]["OverTime"].ToString() != "")
                {
                    model.OverTime = DateTime.Parse(ds.Tables[0].Rows[0]["OverTime"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Times"] != null && ds.Tables[0].Rows[0]["Times"].ToString() != "")
                {
                    model.Times = ds.Tables[0].Rows[0]["Times"].ToString();
                }
                if (ds.Tables[0].Rows[0]["StartComment"] != null && ds.Tables[0].Rows[0]["StartComment"].ToString() != "")
                {
                    model.StartComment = ds.Tables[0].Rows[0]["StartComment"].ToString();
                }
                if (ds.Tables[0].Rows[0]["OverComment"] != null && ds.Tables[0].Rows[0]["OverComment"].ToString() != "")
                {
                    model.OverComment = ds.Tables[0].Rows[0]["OverComment"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Finish"] != null && ds.Tables[0].Rows[0]["Finish"].ToString() != "")
                {
                    model.Finish = int.Parse(ds.Tables[0].Rows[0]["Finish"].ToString());
                }
                if (ds.Tables[0].Rows[0]["isDel"] != null && ds.Tables[0].Rows[0]["isDel"].ToString() != "")
                {
                    model.isDel = int.Parse(ds.Tables[0].Rows[0]["isDel"].ToString());
                }
                return model;
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select id,BaseCode,BigID,ClassID,userID,ReperID,point,UpTime,DoTime,OverTime,Times,StartComment,OverComment,Finish,isDel,applyPhone,repairPhone,code ");
            strSql.Append(" FROM RepairInfo ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelper.ExecuteDataSet(CommandType.Text, strSql.ToString(), null);
        }

        /// <summary>
        /// 获得前几行数据
        /// </summary>
        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Top > 0)
            {
                strSql.Append(" top " + Top.ToString());
            }
            strSql.Append(" id,BaseCode,BigID,ClassID,userID,ReperID,point,UpTime,DoTime,OverTime,Times,StartComment,OverComment,Finish,isDel ");
            strSql.Append(" FROM RepairInfo ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return DbHelper.ExecuteDataSet(CommandType.Text, strSql.ToString(), null);
        }

        /*
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetList(int PageSize,int PageIndex,string strWhere)
        {
            SqlParameter[] parameters = {
                    new SqlParameter("@tblName", SqlDbType.VarChar, 255),
                    new SqlParameter("@fldName", SqlDbType.VarChar, 255),
                    new SqlParameter("@PageSize", SqlDbType.Int),
                    new SqlParameter("@PageIndex", SqlDbType.Int),
                    new SqlParameter("@IsReCount", SqlDbType.Bit),
                    new SqlParameter("@OrderType", SqlDbType.Bit),
                    new SqlParameter("@strWhere", SqlDbType.VarChar,1000),
                    };
            parameters[0].Value = "RepairInfo";
            parameters[1].Value = "id";
            parameters[2].Value = PageSize;
            parameters[3].Value = PageIndex;
            parameters[4].Value = 0;
            parameters[5].Value = 0;
            parameters[6].Value = strWhere;	
            return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
        }*/

        public DataTable GetPage(string sqlWhere, int PageIndex, int PageSize, out int RecordCount, out int PageCount)
        {
            string SqlAllFields = " id,BaseCode,BigID,ClassID,userID,ReperID,point,UpTime,DoTime,OverTime,Times,StartComment,OverComment,Finish,isDel,applyPhone,repairPhone,code ";
            string SqlTabelsAndWhere = " RepairInfo Where " + sqlWhere;
            string IndexField = " id";
            string OrderFields = " Order by UpTime asc ";
            return DbHelper.ExecutePage(SqlAllFields, SqlTabelsAndWhere, IndexField, OrderFields, PageIndex, PageSize, out RecordCount, out PageCount, null);
        }
        //select count(*) from RepairInfo where BigID = 1 and Finish != 2
        public int counts(int bigid)
        {
            string strSql = "select count(*) from RepairInfo where Finish !=2 and isDel = 0 and BigID = " + bigid;
            return int.Parse(DbHelper.ExecuteScalar(CommandType.Text, strSql, null).ToString());
        }

        #endregion  Method


        public int GetCount(string id,string sqlwhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(id) from RepairInfo ");
            strSql.Append(" where bigid = " + id);
            if (sqlwhere != "")
            {
                strSql.Append(" and " + sqlwhere);
            }
            object obj = DbHelper.ExecuteScalar(CommandType.Text, strSql.ToString(), null);
            int count = 0;
            if (obj != null)
            {
                count = Convert.ToInt32(obj);
            }
            return count;
        }
    }
}

