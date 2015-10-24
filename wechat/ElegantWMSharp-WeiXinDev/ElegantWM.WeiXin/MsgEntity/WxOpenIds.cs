using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.WeiXin.MsgEntity
{

    public class WxOpenIdArray
    {
        public List<string> openid { get; set; }
    }

    /// <summary>
    /// 获取所有关注者的openid，同步到微信库
    /// </summary>
    public class WxOpenIds
    {
        public int total { get; set; }
        public int count { get; set; }
        public string next_openid { get; set; }
        public WxOpenIdArray data { get; set; }
    }

}
