using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EPReper.DALFactory;
using EPReper.IDAL;
using System.Data;

namespace EPReper.BLL
{
    public class SysInfo
    {
        private readonly ISysInfo dal=DataAccess.CreateSysInfo();
		public SysInfo()
		{}
        public DataSet GetList()
        {
            return dal.GetList();
        }
        public List<EPReper.Model.SysInfo> GetModelList()
        {
            DataSet ds = dal.GetList();
            return DataTableToList(ds.Tables[0]);
        }

        public List<EPReper.Model.SysInfo> DataTableToList(DataTable dt)
		{
            List<EPReper.Model.SysInfo> modelList = new List<EPReper.Model.SysInfo>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
                EPReper.Model.SysInfo model;
				for (int n = 0; n < rowsCount; n++)
				{
                    model = new EPReper.Model.SysInfo();
                    if (dt.Rows[n]["sysname"] != null && dt.Rows[n]["sysname"].ToString() != "")
					{
                        model.sysname = dt.Rows[n]["sysname"].ToString();
					}
                    if (dt.Rows[n]["sysaddr"] != null && dt.Rows[n]["sysaddr"].ToString() != "")
					{
                        model.sysaddr = dt.Rows[n]["sysaddr"].ToString();
					}					
					modelList.Add(model);
				}
			}
			return modelList;
		}
    }
}
