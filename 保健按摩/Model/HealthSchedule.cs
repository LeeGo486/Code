using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public class HealthSchedule
    {
        public HealthSchedule() { }

        public HealthSchedule(int fid,
            string orderdate, string ordertime,
            string orderdoctor, int isorder, int islock, string locktime, string orderperson, string starttime,string endtime)
        {
            this._fid = fid;
            this._orderdate = orderdate;
            this._ordertime = ordertime;
            this._islock = islock;
            this._isorder = isorder;
            this._orderperson = orderperson;
            this._locktime = locktime;
        }

        private int _fid;
        private string _orderdate;
        private string _ordertime;
        private string _orderdoctor;
        private int _isorder;
        private int _islock;
        private string _locktime;
        private string _orderperson;
        private string _starttime;
        private string _endtime;


        public int fid
        {
            get { return _fid; }
            set { _fid = value; }
        }
        public string orderdate
        {
            get { return _orderdate; }
            set { _orderdate = value; }
        }
        public string ordertime
        {
            get { return _ordertime; }
            set { _ordertime = value; }
        }

        public string orderdoctor
        {
            get { return _orderdoctor; }
            set { _orderdoctor = value; }
        }

        public int isorder
        {
            get { return _isorder; }
            set { _isorder = value; }
        }

        public int islock
        {
            get { return _islock; }
            set { _islock = value; }
        }


        public string locktime
        {
            get { return _locktime; }
            set { _locktime = value; }
        }
        public string orderperson
        {
            get { return _orderperson; }
            set { _orderperson = value; }
        }
        public string starttime
        {
            get { return _starttime; }
            set { _starttime = value; }
        }
        public string endtime
        {
            get { return _endtime; }
            set { _endtime = value; }
        }


        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }
    }
}
