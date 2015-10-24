using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public class SafeSuggestion
    {

        public SafeSuggestion() { }

        public int fid { get; set; }
        public string sugcontent { get; set; }
        public string createperson { get; set; }
        public string createtime { get; set; }

        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
}
