using System;
namespace Talent.Model
{
    /// <summary>
    /// TB_CG_Permission:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class TB_CG_Permission
    {
        public TB_CG_Permission()
        { }
        #region Model
        private int _pm_no;
        private string _pm_login;
        private int? _pm_level = -1;
        private string _pm_province;
        /// <summary>
        /// 
        /// </summary>
        public int PM_No
        {
            set { _pm_no = value; }
            get { return _pm_no; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string PM_Login
        {
            set { _pm_login = value; }
            get { return _pm_login; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? PM_Level
        {
            set { _pm_level = value; }
            get { return _pm_level; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string PM_Province
        {
            set { _pm_province = value; }
            get { return _pm_province; }
        }
        #endregion Model

    }
}

