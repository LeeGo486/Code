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
 * 时间：2014/6/15 22:28:59
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
    public class WXMenuService : BaseService<WX_Menu>, IWXMenuService
    {
        private IWXMenuDAL dal = null;
        /// <summary>
        /// 构造函数(接口转换,Dal只负责基类的增删改查)
        /// </summary>
        public WXMenuService()
            : base(new WXMenuDAL())
        {
            dal = IEF as WXMenuDAL;
        }

        /// <summary>
        /// 获取需要上传到微信服务器的MenuJson
        /// </summary>
        /// <param name="accountId"></param>
        /// <returns></returns>
        public string WxMenuJson(Guid accountId)
        {
            List<WX_Menu> module = dal.FindByConditions(null, f => f.AccountId == accountId).ToList();
            List<WX_Menu> fatherList = module.FindAll(c => c.FatherId == Guid.Empty).OrderBy(c => c.OrderIndex).ToList();
            List<WX_Menu> childList = module.FindAll(c => c.FatherId != Guid.Empty).OrderBy(c => c.OrderIndex).ToList();
            return "{\"button\":[" + CreateWxMenu(fatherList, childList).ToString().TrimEnd(',') + "]}";
        }
        //递归
        private StringBuilder CreateWxMenu(List<WX_Menu> fatherList, List<WX_Menu> childList)
        {
            StringBuilder sb = new StringBuilder();
            foreach (WX_Menu menu in fatherList)
            {
                StringBuilder sub = new StringBuilder();
                //核心
                Guid guid = menu.Id;
                List<WX_Menu> stack = childList.FindAll(c => c.FatherId == guid).OrderBy(c => c.OrderIndex).ToList();
                if (stack.Count > 0) //说明是父节点
                {
                    sub.Append("{\"name\":\"" + menu.Name + "\","
                                + "\"sub_button\": ["
                              );
                    sub.Append(CreateWxMenu(stack, childList).ToString().TrimEnd(',') + "]},");
                }
                else //说明是子节点
                {
                    sub.Append("{\"name\":\"" + menu.Name + "\","
                                + "\"type\":\"" + menu.Type + "\","
                                + (menu.Type == "view" ? "\"url\":\"" + menu.KeyUrl : "\"key\":\"" + menu.Id) + "\"},"
                              );
                }
                sb.Append(sub);
            }
            return sb;
        }
        /// <summary>
        /// 获取微信账号的菜单
        /// </summary>
        /// <param name="sysId"></param>
        /// <returns></returns>
        public string MenuTree(Guid accountId)
        {
            List<WX_Menu> module = dal.FindByConditions(null, f => f.AccountId == accountId).ToList();
            List<WX_Menu> fatherList = module.FindAll(c => c.FatherId == Guid.Empty).OrderBy(c => c.OrderIndex).ToList();
            List<WX_Menu> childList = module.FindAll(c => c.FatherId != Guid.Empty).OrderBy(c => c.OrderIndex).ToList();
            return "[" + CreateFunTree(fatherList, childList).ToString().TrimEnd(',') + "]";
        }
        //递归
        private StringBuilder CreateFunTree(List<WX_Menu> fatherList, List<WX_Menu> childList)
        {
            StringBuilder sb = new StringBuilder();
            foreach (WX_Menu menu in fatherList)
            {
                StringBuilder sub = new StringBuilder();
                //核心
                Guid guid = menu.Id;
                List<WX_Menu> stack = childList.FindAll(c => c.FatherId == guid).OrderBy(c => c.OrderIndex).ToList();
                if (stack.Count > 0) //说明是父节点
                {
                    sub.Append("{Id:'" + menu.Id.ToString() + "',"
                                + "Name:'" + menu.Name + "',"
                                + "Type:'" + menu.Type + "',"
                                + "RespType:'" + menu.RespType + "',"
                                + "AccountId:'" + menu.AccountId + "',"
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
                                + "AccountId:'" + menu.AccountId + "',"
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


        /// <summary>
        /// 复制行业菜单模板
        /// </summary>
        /// <param name="idtId">行业菜单id</param>
        /// <param name="wxId">微信号id</param>
        /// <param name="user">用户</param>
        /// <returns></returns>
        public bool CopyMenu(Guid idtId, Guid wxId)
        {
            return dal.CopyMenu(idtId, wxId, AuthToken.CurrentUser.UserName);
        }
    }
}

