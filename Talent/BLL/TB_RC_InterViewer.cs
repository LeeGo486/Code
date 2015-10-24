using System;
using System.Data;
using System.Collections.Generic;
using Maticsoft.Common;
using Talent.Model;

namespace Talent.BLL
{
    public partial class TB_RC_InterViewer
    {
        private readonly Talent.DAL.TB_RC_InterViewer dal = new Talent.DAL.TB_RC_InterViewer();
        public TB_RC_InterViewer()
		{ }
        #region  Method
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList()
        {
            return dal.GetList();
        }
        #endregion
    }
}
