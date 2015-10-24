using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.WeiXin.MsgEntity
{
    public class WxNews
    {
        public int total_count { get; set; }
        public int item_count { get; set; }
        public List<WxItem> item { get; set; }
    }
}
