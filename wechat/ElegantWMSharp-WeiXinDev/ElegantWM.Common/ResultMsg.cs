using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
/*
 * Ajax请求，处理结果返回类
 * 2013-05-03
 * JackChain
 */

namespace ElegantWM.Common
{
    /// <summary>
    /// 后台操作结果返回
    /// </summary>
    public class ResultMsg
    {
        #region 定义
        public ResultMsg() { }
        public ResultMsg(int result, string msg)
        {
            this.result = result;
            this.msg = msg;
            this.success = result == 0;
        }

        /// <summary>
        /// 0成功，1成功
        /// </summary>
        public int result { get; set; }
        public string msg { get; set; }
        public bool success { get; set; }
        #endregion

        /// <summary>
        /// 返回成功结果
        /// </summary>
        /// <param name="msg">成功提示</param>
        /// <returns>返回ResultMsg对象，类型为：0</returns>
        public static ResultMsg Success(string msg = "")
        {
            return new ResultMsg(0, msg);
        }
        /// <summary>
        /// 返回失败结果
        /// </summary>
        /// <param name="msg">失败原因</param>
        /// <returns>返回ResultMsg对象，类型为：1</returns>
        public static ResultMsg Failure(string msg = "")
        {
            return new ResultMsg(1, msg);
        }
        /// <summary>
        /// 返回异常结果
        /// </summary>
        /// <param name="msg">异常内容</param>
        /// <returns>返回ResultMsg对象，类型为：9</returns>
        public static ResultMsg Exception(string msg = "")
        {
            return new ResultMsg(9, msg);
        }

    }
}
