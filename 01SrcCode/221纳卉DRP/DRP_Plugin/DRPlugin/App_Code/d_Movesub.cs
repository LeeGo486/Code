using System;
using System.Collections;
using System.ComponentModel;

/**
 * 作者：陈杰
 * QQ  : 710782046
 * Email:ovenjackchain@gmail.com
 * Web :http://yj.ChinaCloudTech.com
 */

    public class d_Movesub
    {
        public d_Movesub() { }
        private string ReturnAutoID()
        {
            return "";
        }
        #region 属性
		/// <summary>
		/// 流水号
		/// </summary>
		public string moveid { get; set; }
		
		/// <summary>
		/// boxid
		/// </summary>
		public string boxid { get; set; }
		
		/// <summary>
		/// 款号
		/// </summary>
		public string clothingid { get; set; }
		
		/// <summary>
		/// 款式编号
		/// </summary>
		public string styleid { get; set; }
		
		/// <summary>
		/// 颜色编号
		/// </summary>
		public string colorid { get; set; }
		
		/// <summary>
		/// 尺码编号
		/// </summary>
		public string sizeid { get; set; }
		
		/// <summary>
		/// 成本
		/// </summary>
		public decimal j_cost { get; set; }
		
		/// <summary>
		/// 原价
		/// </summary>
		public decimal j_price { get; set; }
		
		/// <summary>
		/// 现价
		/// </summary>
		public decimal x_price { get; set; }
		
		/// <summary>
		/// 折扣
		/// </summary>
		public decimal discount { get; set; }
		
		/// <summary>
		/// 结算价
		/// </summary>
		public decimal s_price { get; set; }
		
		/// <summary>
		/// 发货数量
		/// </summary>
		public int set_nums { get; set; }
		
		/// <summary>
		/// 收货数量
		/// </summary>
		public int get_nums { get; set; }
		
		/// <summary>
		/// crdate
		/// </summary>
		public string crdate { get; set; }
		
		/// <summary>
		/// comment
		/// </summary>
		public string comment { get; set; }
		
		
		/// <summary>
		/// chknums
		/// </summary>
		public int chknums { get; set; }
		

        #endregion
    }


