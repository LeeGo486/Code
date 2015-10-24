using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.WeiXin.SimulatorEntity
{
    /// <summary>
    /// 基础应答，标记成功或者失败
    /// </summary>
    public class BaseResp
    {
        public int ret { get; set; }
        public string err_msg { get; set; }
    }

    /// <summary>
    /// 主微信应答
    /// </summary>
    public class WXResponse
    {
        /// <summary>
        /// 服务器应答
        /// </summary>
        public BaseResp base_resp { get; set; }
        /// <summary>
        /// 登录成功，跳转url
        /// </summary>
        public string redirect_url { get; set; }

        public Contact contact_info { get; set; }
    }

    /// <summary>
    /// 携带fakeId的微信用户信息
    /// </summary>
    public class Contact
    {
        public long id { get; set; }
        public long fake_id { get; set; }
        public string nick_name { get; set; }
        public string remark_name { get; set; }
        public string signature { get; set; }
        public string city { get; set; }
        public string province { get; set; }
        public string country { get; set; }
        public string group { get; set; }
    }
}
