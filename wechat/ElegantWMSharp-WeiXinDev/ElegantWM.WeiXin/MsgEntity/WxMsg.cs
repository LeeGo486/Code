using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.WeiXin.MsgEntity
{
    public class WxMsg
    {
        /// <summary>
        /// 接收人
        /// </summary>
        public string ToUserName { get; set; }
        /// <summary>
        /// 发送人
        /// </summary>
        public string FromUserName { get; set; }
        /// <summary>
        /// 时间
        /// </summary>
        public long CreateTime { get; set; }
        /// <summary>
        /// 类型
        /// </summary>
        public string MsgType { get; set; }
    }
}
