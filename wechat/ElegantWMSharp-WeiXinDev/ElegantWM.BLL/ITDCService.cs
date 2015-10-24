using ElegantWM.Common;
using ElegantWM.DAL;
using ElegantWM.IBLL;
using ElegantWM.IDAL;
using ElegantWM.Tools;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.BLL
{
    public class ITDCService:IITDCService
    {
        private IITDCDAL dal = new ITDCDAL();
        /// <summary>
        /// 获取ITDC报表值，Web版本
        /// </summary>
        /// <param name="key">关键字</param>
        /// <returns></returns>
        public string GetRptData(string key)
        {
            return dal.GetRptData(key);
        }


        /// <summary>
        /// 执行WSRR
        /// </summary>
        /// <param name="xml">关键字</param>
        /// <returns></returns>
        public string ExecuteWSRR(string xml)
        {
            DataTable dt= dal.ExecuteWSRR(xml);
            return JsonHelper.ToJson(dt);
        }

        /// <summary>
        /// 获取ITDC报表值，Web版本
        /// </summary>
        /// <param name="key">关键字</param>
        /// <returns>返回DataTable</returns>
        public string GetITDComDept()
        {
            DataTable dt = dal.GetRptDataTable("100C");
            DataView dataView = dt.DefaultView;
            DataTable dtCompany = dataView.ToTable(true, "fCompany");
            return "{Company:" + JsonHelper.ToJson(dtCompany) + ",Dept:" + JsonHelper.ToJson(dt) + "}";
        }
        
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public string GetITDCWebList()
        {
            DataTable dt = dal.GetRptDataTable("100E");
            return "{Data:" + JsonHelper.ToJson(dt) + "}";
        }
        /// <summary>
        /// 获取ITDC报表值，Web版本
        /// </summary>
        /// <param name="key">关键字</param>
        /// <returns>返回DataTable</returns>
        public DataTable GetRptDataTable(string key)
        {
            return dal.GetRptDataTable(key);
        }


        /// <summary>
        /// 获取AM的部门信息
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        public string GetAMDept(string userName)
        {
            DataTable dt=dal.GetAMDept(userName);
            DataView dataView = dt.DefaultView;
            DataTable dtCompany = dataView.ToTable(true, "AM_Company", "AM_Company_Name");
            return "{Company:" + JsonHelper.ToJson(dtCompany) + ",Dept:" + JsonHelper.ToJson(dt) + "}";
        }
    }
}
