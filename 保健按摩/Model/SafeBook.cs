using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
  public  class SafeBook
    {
        public SafeBook() { }

        public int fid { get; set; }
        public string booktitle { get; set; }
        public string bookcontents { get; set; }

        public string createperson { get; set; }
        public string createtime { get; set; }
        public int bookkits { get; set; }

        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
}
