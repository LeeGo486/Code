using ElegantWM.DAL;
using ElegantWM.EntityModel;
using ElegantWM.IBLL;
using ElegantWM.IDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.BLL
{
    public class CMTTaskDetailService: BaseService<TK2_TaskDetail>, ICMTTaskDetailService
    {
        private ICMTTaskDetailDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public CMTTaskDetailService()
            : base(new CMTTaskDetailDAL())
        {
            dal = IEF as CMTTaskDetailDAL;
        }


        public System.Data.DataTable TaskDetailPlan(string ID, string Type, DateTime date)
        {
            return dal.TaskDetailPlan(ID, Type, date);
        }

        public System.Data.DataSet TaskResult(string strName, string strAml)
        {
            return dal.TaskResult(strName, strAml);
        }
    }
}
