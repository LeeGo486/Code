using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.WeiXin.MsgEntity
{
    public class WxServiceNotice
    {
        /// <summary>
        /// 服务接收人的openid
        /// </summary>
        public string touser { get; set; }
        /// <summary>
        /// 服务模板ID
        /// </summary>
        public string template_id { get; set; }
        /// <summary>
        /// 单击详情的链接地址
        /// </summary>
        public string url { get; set; }
        /// <summary>
        /// 通知顶部的颜色块，如：#FF0000
        /// </summary>
        public string topcolor { get; set; }
        /// <summary>
        /// 数据区域，json格式{first:{'value':'','color':''}}
        /// </summary>
        public string data { get; set; }
    }
}
