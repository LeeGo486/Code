using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
   public  class SafePitFalls
    {
       public SafePitFalls() { }

       public int fid { get; set; }
       public string area { get; set;}
       public string person { get; set; }
       public string dept { get; set; }
       public string time { get; set;}
       public string pitcontents { get; set; }
       public string pitsuggestion { get; set; }
       public string pitresult { get; set; }
       public string createperson { get; set; }
       public string createtime { get; set; }
       public int Fine { get; set; }
       public string picurl { get; set; }

       //返回自动增长的ID
       private string ReturnAutoID()
       {
           return "fid";
       }
    }
}
