using System;
namespace Talent.Model
{
    /// <summary>
    /// TB_RC_CompanyTalentClassRelate:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class TB_CG_SocialWelfareLink
    {
        public TB_CG_SocialWelfareLink()
        { }
        #region Model
        private int _ct_cb_no;
        private int _ct_tc_no;
        /// <summary>
        /// 
        /// </summary>
        public int CT_CB_No
        {
            set { _ct_cb_no = value; }
            get { return _ct_cb_no; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int CT_TC_No
        {
            set { _ct_tc_no = value; }
            get { return _ct_tc_no; }
        }
        #endregion Model

    }
}

