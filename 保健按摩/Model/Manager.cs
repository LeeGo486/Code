using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public partial class Manager
    {
        public Manager() { }
        private  string _username;
        private  int _isadmin;
        private string _repair;
        private string _phonenum;

        public  string UserName
        {
            set { _username = value; }
            get { return _username; }
        }
        public  int isAdmin
        {
            set { _isadmin = value; }
            get { return _isadmin; }
        }
        public string repair
        {
            set { _repair = value; }
            get { return _repair; }
        }
        public string phonenum
        {
            set{_phonenum=value;}
            get { return _phonenum; }
        }

        public string id { get; set; }

        public string works { get; set; }

        public string states { get; set; }
    }
}
