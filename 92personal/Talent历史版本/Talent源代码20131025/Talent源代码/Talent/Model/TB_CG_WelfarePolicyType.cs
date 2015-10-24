using System;
namespace Talent.Model
{
    /// <summary>
    /// TB_CG_WelfarePolicyType:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class TB_CG_WelfarePolicyType
    {
        public TB_CG_WelfarePolicyType()
        { }
        #region Model
        private int _tc_no;
        private string _tc_class;
        private string _tc_color;
        /// <summary>
        /// 
        /// </summary>
        public int WT_No
        {
            set { _tc_no = value; }
            get { return _tc_no; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string WT_WPType
        {
            set { _tc_class = value; }
            get { return _tc_class; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string WT_Color
        {
            set { _tc_color = value; }
            get { return _tc_color; }
        }
        #endregion Model

    }
}

