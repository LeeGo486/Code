using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ElegantWM.DAL;
using ElegantWM.EntityModel;
using ElegantWM.IBLL;
using ElegantWM.IDAL;
using System.Data;
using System.Data.SqlClient;
using ElegantWM.Common;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/17 19:01:20
 * 功能：业务逻辑接口
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

namespace ElegantWM.BLL
{
    public class HRWXEmployeeService : BaseService<HR_WX_Employee>, IHRWXEmployeeService
    {
        private IHRWXEmployeeDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public HRWXEmployeeService()
            : base(new HRWXEmployeeDAL())
        {
            dal = IEF as HRWXEmployeeDAL;
        }

        /// <summary>
        /// 验证用户信息
        /// </summary>
        /// <param name="code">工号</param>
        /// <param name="name">姓名</param>
        /// <returns></returns>
        public HR_CourseUser CheckEmployee(string code, string name)
        {
            HRCourseUserDAL uDal=new HRCourseUserDAL();
            IEnumerable<HR_CourseUser> lstUser = uDal.FindByConditions(null, f => f.UserName == name && f.EmployeeID == code);
            if (lstUser == null || lstUser.Count() <= 0)
            {
                //去HR里验证
                IEnumerable<HR_WX_Employee> employees = FindByConditions(null, f => f.c_code == code && f.c_name == name);
                if (employees == null || employees.Count() != 1)
                    return null;
                //获取EHR用户
                HR_WX_Employee employee = employees.FirstOrDefault();
                //插入到微信表
                HR_CourseUser user = new HR_CourseUser();
                user.Id = Guid.NewGuid();
                user.EmployeeID = employee.c_code.Trim();
                user.UserName = employee.c_name.Trim();
                user.CreateTime = DateTime.Now;
                user.CreateUser = "Matrix";
                uDal.Insert(user);

                return user;
            }
            else
                return lstUser.FirstOrDefault();
        }
    }
}

