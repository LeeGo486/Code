using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.IBLL
{
    public interface IITDCService
    {
        /// <summary>
        /// 获取ITDC报表值，Web版本
        /// </summary>
        /// <param name="key">关键字</param>
        /// <returns></returns>
        string GetRptData(string key);

        /// <summary>
        /// 获取ITDC报表值，Web版本
        /// </summary>
        /// <param name="key">关键字</param>
        /// <returns>返回json string</returns>
        string GetITDComDept();


        /// <summary>
        /// 获取ITDC报表值，Web版本
        /// </summary>
        /// <param name="key">关键字</param>
        /// <returns>返回DataTable</returns>
        DataTable GetRptDataTable(string key);

         /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        string GetITDCWebList();
        /// <summary>
        /// 获取AM的部门信息
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        string GetAMDept(string userName);

        /// <summary>
        /// 执行WSRR
        /// </summary>
        /// <param name="xml">关键字</param>
        /// <returns></returns>
        string ExecuteWSRR(string xml);
    }
}
