using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public class V_HealthScoreHistory
    {

        public V_HealthScoreHistory() { }

        
        public int fid
        {
            get ;
            set ;
        }

        public string username
        {
            get ;
            set;
        }
        public string usertel
        {
            get ;
            set ;
        }

        public string userdept
        {
            get;
            set;
        }


        public string userdoctor
        {
            get ;
            set ;
        }
        public string userdate
        {
            get ;
            set ;
        }
        public string usertime
        {
            get ;
            set ;
        }
        public string userstate
        {
            get ;
            set ;
        }
        public string starttime
        {
            get ;
            set ;
        }

        public int liaoxiao
        {
            set;
            get;
        }
        public int lidao
        {
            set;
            get;
        }
        public int shushidu
        {
            set;
            get;
        }
        public int jifa
        {
            set;
            get;
        }
        public int fuwutaidu
        {
            set;
            get;
        }

        public int totalsum
        {
            set;
            get;
        }
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
}
