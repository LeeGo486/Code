using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using Talent.Model;
namespace Talent.BLL
{
	/// <summary>
	/// TN_SYS_EM_USER
	/// </summary>
	public partial class TN_SYS_EM_USER
	{
        private readonly Talent.DAL.TN_SYS_EM_USER dal = new Talent.DAL.TN_SYS_EM_USER();
		public TN_SYS_EM_USER()
		{}
		#region  Method

        public bool checkUserValid(string CN_LOGIN, string CN_PASSWORD)
        {
            var tmp = this.getModel(CN_LOGIN);
            if (tmp == null) return false;
            if (tmp.CN_PASSWORD == null || tmp.CN_PASSWORD.Trim() == "")
            {
                if (CN_PASSWORD.Trim() == "")
                    return true;
                else return false;
            }
            if (tmp.CN_PASSWORD.Trim() == CN_PASSWORD.Trim())
            {
                return true;
            }
            return false ;
        }

        public Model.TN_SYS_EM_USER getModel(string CN_LOGIN)
        {
            return dal.GetModel(CN_LOGIN);
        }

        public Talent.Model.TN_SYS_EM_USER GetModelByID(string CN_ID)
        {
            return dal.GetModelByID(CN_ID);
        }



        public List<Talent.Model.TN_SYS_EM_USER> DataTableToList(DataTable dt)
        {
            List<Talent.Model.TN_SYS_EM_USER> modelList = new List<Talent.Model.TN_SYS_EM_USER>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Talent.Model.TN_SYS_EM_USER model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Talent.Model.TN_SYS_EM_USER();
                    if (dt.Rows[n]["CN_LOGIN"] != null && dt.Rows[n]["CN_LOGIN"].ToString() != "")
                    {
                        model.CN_LOGIN = dt.Rows[n]["CN_LOGIN"].ToString();
                    }
                    modelList.Add(model);
                }
            }
            return modelList;
        }

        public List<Talent.Model.TN_SYS_EM_USER> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }

		#endregion  Method
	}
}

