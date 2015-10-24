#pragma checksum "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\Y_CareLabel.cs" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "1FE4576CC4447B7E0BBD770AAD9CB30BBD8B3F0C"

#line 1 "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\Y_CareLabel.cs"
using System;
using System.Collections;
using System.ComponentModel;

/**
 * 作者：陈杰
 * QQ  : 710782046
 * Email:ovenjackchain@gmail.com
 * Web :http://yj.ChinaCloudTech.com
 */
    public class Y_CareLabel
    {
        public Y_CareLabel() { }

        private int _id;
        private string _lburl;
        private string _lbname;
        #region 属性
		/// <summary>
		/// 自增
		/// </summary>
        public int Id { get { return _id; } set { _id = value; } }
		
		/// <summary>
		/// 图标地址
		/// </summary>
        public string LbUrl { get { return _lburl; } set { _lburl = value; } }
		
		/// <summary>
		/// 图标名称
		/// </summary>
        public string LbName { get { return _lbname; } set { _lbname = value; } }

        private string ReturnAutoID()
        {
            return "Id";
        }
        #endregion
    }

#line default
#line hidden
