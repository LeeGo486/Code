using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
   public  class Safezhuan
    {

       public Safezhuan() { }

        public int fid { get; set; }
        public string ZhuanName { get; set; }
       
        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
}
