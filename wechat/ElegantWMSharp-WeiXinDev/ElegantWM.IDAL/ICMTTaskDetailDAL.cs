using System;
using ElegantWM.EntityModel;
using System.Data;

/**
 * 作者：WebMisSharp
 * 时间：2014-10-21 17:53:47
 * 功能：数据访问层接口
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

namespace ElegantWM.IDAL
{
    public interface ICMTTaskDetailDAL : IEFRepository<TK2_TaskDetail> 
    {
        DataTable TaskDetailPlan(string ID,string Type,DateTime date);


        #region 调用任务的存储过程
            DataSet TaskResult(string strName, string strAml);
        #endregion
        
    }
}
