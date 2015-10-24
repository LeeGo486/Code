using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using EPReper.IDAL;
using EPReper.DBUtility;//Please add references
namespace EPReper.SQLServerDAL
{
    /// <summary>
    /// 数据访问类:Class
    /// </summary>
    public partial class ReperClass : IReperClass
    {
        public ReperClass()
        { }
        #region  Method

        /// <summary>
        /// 得到最大ID
        /// </summary>
        public int GetMaxId()
        {
            return DbHelper.GetMaxID("id", "ReperClass");
        }




        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(EPReper.Model.ReperClass model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into ReperClass(");
            strSql.Append("classname,parentID,SubNum,orderNum,PoPlist,men,isDel,pic)");
            strSql.Append(" values (");
            strSql.Append("@classname,@parentID,@SubNum,@orderNum,@PoPlist,@men,@isDel,@pic)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
					new SqlParameter("@classname", SqlDbType.NVarChar,50),
					new SqlParameter("@parentID", SqlDbType.Int,4),
					new SqlParameter("@SubNum", SqlDbType.Int,4),
					new SqlParameter("@orderNum", SqlDbType.Int,4),
					new SqlParameter("@PoPlist", SqlDbType.NText),
					new SqlParameter("@men", SqlDbType.NText),
					new SqlParameter("@isDel", SqlDbType.Int,4),
                    new SqlParameter("@pic",SqlDbType.NVarChar,50)};
            parameters[0].Value = model.classname;
            parameters[1].Value = model.parentID;
            parameters[2].Value = 0;
            parameters[3].Value = 0;
            parameters[4].Value = "";
            parameters[5].Value = "";
            parameters[6].Value = 0;
            parameters[7].Value = model.pic;

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
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(EPReper.Model.ReperClass model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update ReperClass set ");
            strSql.Append("classname=@classname, ");
            strSql.Append("pic=@pic ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@classname", SqlDbType.NVarChar,50),
					new SqlParameter("@pic", SqlDbType.NVarChar,50),
                    new SqlParameter("@id",SqlDbType.Int,4)};
            parameters[0].Value = model.classname;
            parameters[1].Value = model.pic;
            parameters[2].Value = model.id;

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


        public bool Update(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update ReperClass set ");
            strSql.Append("SubNum=SubNum+1 ");
            strSql.Append(" where id=" + id);

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
        public bool UpdateDel(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update ReperClass set ");
            strSql.Append("SubNum=SubNum-1 ");
            strSql.Append(" where id=" + id);

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
        /// 删除一条数据
        /// </summary>
        public bool Delete(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("update ReperClass set ");
            strSql.Append("isDel=1 ");
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
        /*
                 public bool Delete(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from ReperClass ");
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
        }*/
        /// <summary>
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string idlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from ReperClass ");
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
        public EPReper.Model.ReperClass GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 id,classname,parentID,SubNum,orderNum,PoPlist,men,isDel,pic from ReperClass ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
};
            parameters[0].Value = id;

            EPReper.Model.ReperClass model = new EPReper.Model.ReperClass();
            DataSet ds = DbHelper.ExecuteDataSet(CommandType.Text, strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["id"] != null && ds.Tables[0].Rows[0]["id"].ToString() != "")
                {
                    model.id = int.Parse(ds.Tables[0].Rows[0]["id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["classname"] != null && ds.Tables[0].Rows[0]["classname"].ToString() != "")
                {
                    model.classname = ds.Tables[0].Rows[0]["classname"].ToString();
                }
                if (ds.Tables[0].Rows[0]["parentID"] != null && ds.Tables[0].Rows[0]["parentID"].ToString() != "")
                {
                    model.parentID = int.Parse(ds.Tables[0].Rows[0]["parentID"].ToString());
                }
                if (ds.Tables[0].Rows[0]["SubNum"] != null && ds.Tables[0].Rows[0]["SubNum"].ToString() != "")
                {
                    model.SubNum = int.Parse(ds.Tables[0].Rows[0]["SubNum"].ToString());
                }
                if (ds.Tables[0].Rows[0]["orderNum"] != null && ds.Tables[0].Rows[0]["orderNum"].ToString() != "")
                {
                    model.orderNum = int.Parse(ds.Tables[0].Rows[0]["orderNum"].ToString());
                }
                if (ds.Tables[0].Rows[0]["PoPlist"] != null && ds.Tables[0].Rows[0]["PoPlist"].ToString() != "")
                {
                    model.PoPlist = ds.Tables[0].Rows[0]["PoPlist"].ToString();
                }
                if (ds.Tables[0].Rows[0]["men"] != null && ds.Tables[0].Rows[0]["men"].ToString() != "")
                {
                    model.men = ds.Tables[0].Rows[0]["men"].ToString();
                }
                if (ds.Tables[0].Rows[0]["isDel"] != null && ds.Tables[0].Rows[0]["isDel"].ToString() != "")
                {
                    model.isDel = int.Parse(ds.Tables[0].Rows[0]["isDel"].ToString());
                }
                if (ds.Tables[0].Rows[0]["pic"] != null && ds.Tables[0].Rows[0]["pic"].ToString() != "")
                {
                    model.pic = ds.Tables[0].Rows[0]["pic"].ToString();
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
            strSql.Append("select id, [classname],parentID,SubNum,orderNum,PoPlist,men,isDel,pic ");
            strSql.Append(" FROM ReperClass ");
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
            strSql.Append(" id,classname,parentID,SubNum,orderNum,PoPlist,men,isDel,pic ");
            strSql.Append(" FROM ReperClass ");
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
            parameters[0].Value = "ReperClass";
            parameters[1].Value = "id";
            parameters[2].Value = PageSize;
            parameters[3].Value = PageIndex;
            parameters[4].Value = 0;
            parameters[5].Value = 0;
            parameters[6].Value = strWhere;	
            return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
        }*/
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataTable GetTable(int Top, string strWhere, string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Top > 0)
            {
                strSql.Append(" top " + Top.ToString() + " PERCENT ");
            }
            strSql.Append("id,classname,parentID,SubNum,orderNum,PoPlist,men,isDel,pic ");
            strSql.Append(" FROM ReperClass ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
                strSql.Append(" order by " + filedOrder);
            }
            return DbHelper.ExecuteTable(CommandType.Text, strSql.ToString(), null);
        }

        public DataTable GetPage(string sqlWhere, int PageIndex, int PageSize, out int RecordCount, out int PageCount)
        {
            string SqlAllFields = " id,classname,ParentID,SubNum,orderNum,PoPlist,men,isDel,pic ";
            string SqlTabelsAndWhere = " ReperClass Where " + sqlWhere;
            string IndexField = " id";
            string OrderFields = " Order by orderNum ";
            return DbHelper.ExecutePage(SqlAllFields, SqlTabelsAndWhere, IndexField, OrderFields, PageIndex, PageSize, out RecordCount, out PageCount, null);
        }
        #endregion  Method





        public DataSet GetLists(string id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * ");
            strSql.Append(" FROM ReperClass");
            if (id.Trim() != "")
            {
                strSql.Append(" where parentID = " + id);
            }
            return DbHelper.ExecuteDataSet(CommandType.Text, strSql.ToString());
        }
    }
}

