using System;
using System.Collections;
using System.ComponentModel; 

/**
 * 作者：陈杰
 * QQ  : 710782046
 * Email:ovenjackchain@gmail.com
 * Web :http://yj.ChinaCloudTech.com
 */ 
    public class Y_StyleCareLabel
    {
        public Y_StyleCareLabel() { }

        private int _id;
        private int _lbid;
        private string _StyleId;
        #region 属性
		/// <summary>
		/// Id
		/// </summary>
        public int Id { get { return _id; } set { _id = value; } }
		
		/// <summary>
		/// LbId
		/// </summary>
        public int LbId { get { return _lbid; } set { _lbid = value; } }
		
		/// <summary>
		/// StyleId
		/// </summary>
        public string StyleId { get { return _StyleId; } set { _StyleId = value; } }

        private string ReturnAutoID()
        {
            return "Id";
        }
        #endregion
    } 