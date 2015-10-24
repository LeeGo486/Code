using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public class SafeRewards
    {

        public SafeRewards() { }

        public int fid { get; set; }
        public string area { get; set; }
        public string person { get; set; }
        public string dept { get; set; }
        public int rewards { get; set; }
        public int totals { get; set; }
        public string createtime { get; set; }
        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
}
