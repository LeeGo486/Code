using System;
using System.Collections;
using System.ComponentModel;

/**
 * 作者：陈杰
 * QQ  : 710782046
 * Email:ovenjackchain@gmail.com
 * Web :http://yj.ChinaCloudTech.com
 */

    public class d_Move
    {
        public d_Move() { }

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
		/// 发货单号
		/// </summary>
		public string move { get; set; }
		
		/// <summary>
		/// indentid
		/// </summary>
		public string indentid { get; set; }
		
		/// <summary>
		/// 发货仓编号
		/// </summary>
		public string set_depotid { get; set; }
		
		/// <summary>
		/// 收货仓编号
		/// </summary>
		public string get_depotid { get; set; }
		
		/// <summary>
		/// 发货登帐
		/// </summary>
		public int set_sure { get; set; }
		
		/// <summary>
		/// 收货登帐
		/// </summary>
		public int get_sure { get; set; }
		
		/// <summary>
		/// 发货审核
		/// </summary>
		public int setchk_sure { get; set; }
		
		/// <summary>
		/// 收货审核
		/// </summary>
		public int getchk_sure { get; set; }
		
		/// <summary>
		/// 发货日期
		/// </summary>
		public string setdate { get; set; }
		
		/// <summary>
		/// 收货人
		/// </summary>
		public string getcr_name { get; set; }
		
		/// <summary>
		/// 收货日期
		/// </summary>
		public string getcr_date { get; set; }
		
		/// <summary>
		/// 发货审核人
		/// </summary>
		public string setchk_name { get; set; }
		
		/// <summary>
		/// 发货制单日期
		/// </summary>
		public string setcr_date { get; set; }
		
		/// <summary>
		/// 发货登帐人
		/// </summary>
		public string setsure_name { get; set; }
		
		/// <summary>
		/// 收货日期
		/// </summary>
		public string getdate { get; set; }
		
		/// <summary>
		/// 收货审核人
		/// </summary>
		public string getchk_name { get; set; }
		
		/// <summary>
		/// 发货制单人
		/// </summary>
		public string setcr_name { get; set; }
		
		/// <summary>
		/// 收货审核人
		/// </summary>
		public string getchk_date { get; set; }
		
		/// <summary>
		/// 收货登帐人
		/// </summary>
		public string getsure_name { get; set; }
		
		/// <summary>
		/// 发货登帐日期
		/// </summary>
		public string setsure_date { get; set; }
		
		/// <summary>
		/// 收货登帐日期
		/// </summary>
		public string getsure_date { get; set; }
		
		/// <summary>
		/// 发货审核日期
		/// </summary>
		public string setchk_date { get; set; }
		
		/// <summary>
		/// 发货备注
		/// </summary>
		public string set_comment { get; set; }
		
		/// <summary>
		/// 收货备注
		/// </summary>
		public string get_comment { get; set; }
		
		/// <summary>
		/// 发货日期
		/// </summary>
		public string crdate { get; set; }
		

		
		/// <summary>
		/// cwchk
		/// </summary>
		public bool cwchk { get; set; }
		
		/// <summary>
		/// cwgetchk
		/// </summary>
		public bool cwgetchk { get; set; }
		
		/// <summary>
		/// cwpz
		/// </summary>
		public int cwpz { get; set; }
		
		/// <summary>
		/// cwgetpz
		/// </summary>
		public int cwgetpz { get; set; }
		
		/// <summary>
		/// 换货日期
		/// </summary>
		public string backdate { get; set; }
		
		/// <summary>
		/// 换货率
		/// </summary>
		public decimal backrate { get; set; }
		
		/// <summary>
		/// 销售类型
		/// </summary>
		public string selltype { get; set; }
		
		/// <summary>
		/// AutoCrId
		/// </summary>
		public string AutoCrId { get; set; }
		
		/// <summary>
		/// znums
		/// </summary>
		public int znums { get; set; }
		
		/// <summary>
		/// zjsums
		/// </summary>
		public decimal zjsums { get; set; }
		
		/// <summary>
		/// zxsums
		/// </summary>
		public decimal zxsums { get; set; }
		
		/// <summary>
		/// zssums
		/// </summary>
		public decimal zssums { get; set; }
		
		/// <summary>
		/// 品牌
		/// </summary>
		public string loadplanid { get; set; }
		
		/// <summary>
		/// loadbox
		/// </summary>
		public int loadbox { get; set; }
		
		/// <summary>
		/// ifcancelbox
		/// </summary>
		public bool ifcancelbox { get; set; }
		
		/// <summary>
		/// ifquota
		/// </summary>
		public bool ifquota { get; set; }
		
		/// <summary>
		/// shjjquotaid
		/// </summary>
		public string shjjquotaid { get; set; }
		
		/// <summary>
		/// cancelbox
		/// </summary>
		public bool cancelbox { get; set; }
		
		/// <summary>
		/// sel_sure
		/// </summary>
		public bool sel_sure { get; set; }
		
		/// <summary>
		/// loadplanjhid
		/// </summary>
		public string loadplanjhid { get; set; }
		
		/// <summary>
		/// shjjdepotid
		/// </summary>
		public string shjjdepotid { get; set; }
		
		/// <summary>
		/// loaddate
		/// </summary>
		public string loaddate { get; set; }
		
		/// <summary>
		/// ifjhsure
		/// </summary>
		public bool ifjhsure { get; set; }
		
		/// <summary>
		/// ESB_ID
		/// </summary>
		public string ESB_ID { get; set; }
		
		/// <summary>
		/// Only_Update_sub
		/// </summary>
		public int Only_Update_sub { get; set; }
		
		/// <summary>
		/// ESB_src_App
		/// </summary>
		public string ESB_src_App { get; set; }
		

        #endregion
    }

