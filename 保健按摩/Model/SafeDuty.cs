using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
   public class SafeDuty
    {
       public SafeDuty() { }

       public int fid { get; set; }
       public string area { get; set;}
       public string person { get; set; }
       public string dept { get; set; }
       public string time { get; set;}
       public string deptleader { get; set; }
       public string areatype { get; set; }
       public string isimportant { get; set; }

       //返回自动增长的ID
       private string ReturnAutoID()
       {
           return "fid";
       }
    }
}
