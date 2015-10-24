using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.WeiXin.MsgEntity
{
    public class WxItem
    {
        public string media_id { get; set; }
        public WxItemContent content { get; set; }
        public int update_time { get; set; }
    }
}
