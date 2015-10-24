using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public class SafeDeptMoney
    {
        public SafeDeptMoney() { }

        public int fid { get; set; }
        public string deptname { get; set; }
        public int deptmoney { get; set; }
        public int currentmoney { get; set; }
        public string deptyear { get; set; }
        public string createtime { get; set; }


        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
}
