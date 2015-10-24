using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
  public  class SafeInfo
    {
      public SafeInfo() { }

       public int fid { get; set; }
       public string infoTitle { get; set;}
       public string infocontents { get; set; }
       public string infotype { get; set; }
       public string createperson { get; set;}
       public string createtime { get; set; }
       public int InfoKits { get; set; }

       //返回自动增长的ID
       private string ReturnAutoID()
       {
           return "fid";
       }
    }
}
