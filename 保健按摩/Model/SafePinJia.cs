using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
 public    class SafePinJia
    {

     public SafePinJia() { }

        public int fid { get; set; }
        public string  masterfid { get; set; }
        public string  msgs { get; set; }

        public string createperson { get; set; }
        public string createtime { get; set; }


        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
}
