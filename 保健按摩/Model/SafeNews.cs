using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
   public class SafeNews
    {
       public SafeNews() { }

       public int fid { get; set; }
       public string newstitle { get; set;}
       public string newscontents { get; set; }
       public string NewsInfoType { get; set; }
       public string NewsZhuan { get; set; }
       public string newstype { get; set; }
       public string newspics { get; set;}
       public string createperson { get; set; }
       public string createtime { get; set; }
       public int newskits { get; set; }

       //返回自动增长的ID
       private string ReturnAutoID()
       {
           return "fid";
       }
    }
}
