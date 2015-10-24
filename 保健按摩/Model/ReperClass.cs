using System;
namespace EPReper.Model
{
    /// <summary>
    /// Class:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class ReperClass
    {
        public ReperClass()
        { }
        #region Model
        private int _id;
        private string _classname;
        private int? _parentid;
        private int? _subnum = 0;
        private int? _ordernum = 0;
        private string _poplist;
        private string _men;
        private int? _isdel;
        private string _pic;
        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string classname
        {
            set { _classname = value; }
            get { return _classname; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? parentID
        {
            set { _parentid = value; }
            get { return _parentid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? SubNum
        {
            set { _subnum = value; }
            get { return _subnum; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? orderNum
        {
            set { _ordernum = value; }
            get { return _ordernum; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string PoPlist
        {
            set { _poplist = value; }
            get { return _poplist; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string men
        {
            set { _men = value; }
            get { return _men; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? isDel
        {
            set { _isdel = value; }
            get { return _isdel; }
        }

        public string pic
        {
            set { _pic = value; }
            get { return _pic; }
        }
        #endregion Model

    }
}

