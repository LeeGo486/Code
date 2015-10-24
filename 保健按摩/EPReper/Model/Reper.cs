using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public partial class Reper
    {
        public Reper()
        { }
        private static int _isreper;

        public static int isReper
        {
            set { _isreper = value; }
            get { return _isreper; }
        }
    }
}
