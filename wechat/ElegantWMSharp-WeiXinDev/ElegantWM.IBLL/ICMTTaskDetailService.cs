using System;
using ElegantWM.EntityModel;
using System.Data;

/**
 * 作者：WebMisSharp
 * 时间：2014-10-21 17:53:47
 * 功能：业务逻辑接口
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

namespace ElegantWM.IBLL
{
    public interface ICMTTaskDetailService : IBaseService<TK2_TaskDetail>
    {
        DataTable TaskDetailPlan(string ID, string Tpye,DateTime date);

        #region 调用任务的存储过程
            DataSet TaskResult(string strName, string strAml);
        #endregion
        
    }
}
