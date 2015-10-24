using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EPReper.Model
{
    public class HealthUserOrder
    {
        #region 构造函数
        public HealthUserOrder() { }

        public HealthUserOrder(int fid, string userid, string username, string usertel, string userdept, string userschid,
            string userdoctor, string userdate,
            string usertime, string usersate, string starttime, string description, string createtime, string usertype)
        {

            this._fid = fid;
            this._userid = userid;
            this._username = username;
            this._usertel = usertel;
            this._userdept = userdept;
            this._userschid = userschid;
            this._userdoctor = userdoctor;
            this._userdate = userdate;
            this._usertime = usertime;
            this._userstate = usersate;
            this._starttime = starttime;
            this._description = description;

            this._createtime = createtime;
       
        }

        private int _fid;
        private string _userid;
        private string _username;
        private string _userdept;
        private string _usertel;
        private string _userschid;
        private string _userdoctor;
        private string _userdate;
        private string _usertime;
        private string _userstate;
        private string _starttime;
        private string _description;
        private string _createtime;
    
        #endregion

        #region 成员

        public int fid
        {
            get { return _fid; }
            set { _fid = value; }
        }
        public string userid
        {
            get { return _userid; }
            set { _userid = value; }
        }
        public string username
        {
            get { return _username; }
            set { _username = value; }
        }
        public string usertel
        {
            get { return _usertel; }
            set { _usertel = value; }
        }

        public string userdept
        {
            get { return _userdept; }
            set { _userdept = value; }
        }
        public string userschid
        {
            get { return _userschid; }
            set { _userschid = value; }
        }


        public string userdoctor
        {
            get { return _userdoctor; }
            set { _userdoctor = value; }
        }
        public string userdate
        {
            get { return _userdate; }
            set { _userdate = value; }
        }
        public string usertime
        {
            get { return _usertime; }
            set { _usertime = value; }
        }
        public string userstate
        {
            get { return _userstate; }
            set { _userstate = value; }
        }
        public string createtime
        {
            get { return _createtime; }
            set { _createtime = value; }
        }

        public string starttime
        {
            get { return _starttime; }
            set { _starttime = value; }
        }

        public string description
        {
            get { return _description; }
            set { _description = value; }
        }

       
        #endregion
        //返回自动增长的ID
        private string ReturnAutoID()
        {
            return "fid";
        }

    }
}
