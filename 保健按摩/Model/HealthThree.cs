using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
   public class HealthThree
    {
       public HealthThree() { }

        public int fid { get; set; }
        public string username { get; set; }
       
        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
   
}
