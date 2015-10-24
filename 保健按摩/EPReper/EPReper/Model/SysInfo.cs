using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public class SysInfo
    {
        public SysInfo()
        { }
        string _sysname;
        string _sysaddr;
        public string sysname
        {
            set { _sysname = value; }
            get { return _sysname; }
        }
        public string sysaddr
        {
            set { _sysaddr = value; }
            get { return _sysaddr; }
        }
    }
}
