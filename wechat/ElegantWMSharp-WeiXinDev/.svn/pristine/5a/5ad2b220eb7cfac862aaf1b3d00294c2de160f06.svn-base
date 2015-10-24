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
 * 时间：2014/7/26 0:33:42
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
    public class OO_MenuTemplateService : BaseService<OO_MenuTemplate>, IOO_MenuTemplateService
    {
        private IOO_MenuTemplateDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public OO_MenuTemplateService()
            : base(new OO_MenuTemplateDAL())
        {
            dal = IEF as OO_MenuTemplateDAL;
        }


        /// <summary>
        /// 获取微信账号的菜单
        /// </summary>
        /// <param name="sysId"></param>
        /// <returns></returns>
        public string MenuTree(Guid idtid)
        {
            List<OO_MenuTemplate> module = dal.FindByConditions(null, f => f.IdtId == idtid).ToList();
            List<OO_MenuTemplate> fatherList = module.FindAll(c => c.FatherId == Guid.Empty).OrderBy(c => c.OrderIndex).ToList();
            List<OO_MenuTemplate> childList = module.FindAll(c => c.FatherId != Guid.Empty).OrderBy(c => c.OrderIndex).ToList();
            return "[" + CreateFunTree(fatherList, childList).ToString().TrimEnd(',') + "]";
        }
        //递归
        private StringBuilder CreateFunTree(List<OO_MenuTemplate> fatherList, List<OO_MenuTemplate> childList)
        {
            StringBuilder sb = new StringBuilder();
            foreach (OO_MenuTemplate menu in fatherList)
            {
                StringBuilder sub = new StringBuilder();
                //核心
                Guid guid = menu.Id;
                List<OO_MenuTemplate> stack = childList.FindAll(c => c.FatherId == guid).OrderBy(c => c.OrderIndex).ToList();
                if (stack.Count > 0) //说明是父节点
                {
                    sub.Append("{Id:'" + menu.Id.ToString() + "',"
                                + "Name:'" + menu.Name + "',"
                                + "Type:'" + menu.Type + "',"
                                + "RespType:'" + menu.RespType + "',"
                                + "IdtId:'" + menu.IdtId + "',"
                                + "FatherId:'" + menu.FatherId + "',"
                                + "KeyUrl:'" + menu.KeyUrl + "',"
                                + "OrderIndex:'" + menu.OrderIndex + "',"
                                + "expanded:true"
                                + ",children: ["
                              );
                    sub.Append(CreateFunTree(stack, childList).ToString().TrimEnd(',') + "]},");
                }
                else //说明是子节点
                {
                    sub.Append("{Id:'" + menu.Id.ToString() + "',"
                                + "Name:'" + menu.Name + "',"
                                + "Type:'" + menu.Type + "',"
                                + "RespType:'" + menu.RespType + "',"
                                + "IdtId:'" + menu.IdtId + "',"
                                + "FatherId:'" + menu.FatherId + "',"
                                + "KeyUrl:'" + menu.KeyUrl + "',"
                                + "iconCls:'RecordGreen',"
                                + "OrderIndex:'" + menu.OrderIndex + "',"
                                + "leaf:true},"
                              );
                }
                sb.Append(sub);
            }
            return sb;
        }

    }
}

