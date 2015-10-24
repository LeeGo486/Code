using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.IDAL
{
    public interface IWsrrDAL
    {
        /// <summary>
        /// 执行wsrr，返回数据集合
        /// </summary>
        /// <param name="wsid"></param>
        /// <param name="aml"></param>
        /// <returns></returns>
        DataSet GetData(string wsid, string aml);

         /// <summary>
        /// 执行标准的wsrr测试库
        /// </summary>
        /// <param name="wsid"></param>
        /// <param name="xml"></param>
        /// <returns></returns>
        DataSet ExcuteWsrrTest(string wsid, string xml);

        /// <summary>
        /// 执行标准的wsrr
        /// </summary>
        /// <param name="wsid"></param>
        /// <param name="xml"></param>
        /// <returns></returns>
        DataSet ExcuteWsrr(string wsid, string xml);

        /// <summary>
        /// 立即更新C3AM的用户名和密码
        /// </summary>
        /// <param name="amuser"></param>
        /// <param name="tel"></param>
        /// <param name="pwd"></param>
        void UpdateC3AMUser(string amuser, string tel, string pwd);

        /// <summary>
        /// 调用AML协议的WSRR
        /// </summary>
        /// <param name="wsid"></param>
        /// <param name="aml"></param>
        /// <returns></returns>
        string ExcuteWsrrAML(string wsid, string aml);
    }
}
