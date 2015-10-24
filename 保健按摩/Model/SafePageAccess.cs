using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public class SafePageAccess
    {
        public SafePageAccess() { }

        public int fid { get; set; }
        public string pagename { get; set; }
        public string userinfo { get; set; }
        public string createtime { get; set; }

        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
}
