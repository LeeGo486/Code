using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public class HealthIPAddress
    {
        public HealthIPAddress() { }

        public int fid { get; set; }
        public string deptname { get; set; }
        public string ipaddress { get; set; }
        public string style { get; set; }

        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
}
