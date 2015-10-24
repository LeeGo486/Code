using System;


namespace Talent.Model
{
    /// <summary>
    /// TB_RC_InterViewer:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    ///
    [Serializable]
    public partial class TB_RC_InterViewer
    {
        public TB_RC_InterViewer()
		{}
        #region Model
        private int _iv_no;
        private string _iv_class;

        /// <summary>
        /// 
        /// </summary>
        public int IV_No
        {
            set { _iv_no = value; }
            get { return _iv_no; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string IV_Class
        {
            set { _iv_class = value; }
            get { return _iv_class; }
        }
        #endregion
    }
}
