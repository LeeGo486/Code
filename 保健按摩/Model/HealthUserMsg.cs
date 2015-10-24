using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public class HealthUserMsg
    {
        public HealthUserMsg()
        {
        }
        public int fid
        {
            get;
            set;
        }
        public string userschid
        {
            get;
            set;
        }

        public string username
        {
            get;
            set;
        }
        public string userdoctor
        {
            get;
            set;
        }
        public string userdate
        {
            get;
            set;
        }
        public string usertime
        {
            get;
            set;
        }
      
        public string createtime
        {
            get;
            set;
        }

        public string starttime
        {
            get;
            set;
        }


        public int sendstate
        {
            get;
            set;
        }

        private string ReturnAutoID()
        {
            return "fid";
        }


    }
}
