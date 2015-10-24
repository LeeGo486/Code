using System;
using System.Collections;
using System.ComponentModel; 

/**
 * 作者：陈杰
 * QQ  : 710782046
 * Email:ovenjackchain@gmail.com
 * Web :http://yj.ChinaCloudTech.com
 */
  
    public class Y_GBCode
    {
        public Y_GBCode() { }
		
        #region 属性
        private int _id;
        private string _code;
        private string _styleid;
		/// <summary>
		/// 自增
		/// </summary>
        public int Id { get { return _id; } set { _id = value; } }
		
		/// <summary>
		/// 国标码
		/// </summary>
        public string Code { get { return _code; } set { _code = value; } }
		
		/// <summary>
		/// 新款式编号
		/// </summary>
        public string StyleId { get { return _styleid; } set { _styleid = value; } }

        private string ReturnAutoID()
        {
            return "Id";
        }
        #endregion
    } 
