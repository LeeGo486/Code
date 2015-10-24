using ElegantWM.Tools;
using ElegantWM.DTO;
using System.Collections.Generic;
using System;
/**
 * 作者：陈杰
 * 时间：2012-08-10
 * 功能：操作当前登陆用户信息，默认cookie认证，可以非常方便的修改成session
 **/
namespace ElegantWM.Common
{
    public class AuthToken
    {
        //枚举
        private enum Cfg
        {
            Matrix_,
            Cer,
            Permission,
            TokenId
        }

        /// <summary>
        /// 设置当前用户信息
        /// </summary>
        public static CertificateDto CurrentUserByTid(string tid)
        {
            //先判断用户是否还登陆着
            object obj = CacheHelper.CacheValue(tid + Cfg.Cer);
            if (obj == null)
            {
                SSOHelper.GetCertificate(tid);//重新认证
                obj = CacheHelper.CacheValue(tid + Cfg.Cer);
            }
            return (CertificateDto)obj;
        }

        /// <summary>
        /// 设置当前用户信息
        /// </summary>
        public static CertificateDto CurrentUser
        {
            get
            {
                //先判断用户是否还登陆着
                object obj = CacheHelper.CacheValue(TokenId + Cfg.Cer);
                if (obj == null)
                {
                    SSOHelper.GetCertificate(TokenId);//重新认证
                    obj = CacheHelper.CacheValue(TokenId + Cfg.Cer);
                }
                return (CertificateDto)obj;
            }
        }

        /// <summary>
        /// 获取操作权限
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        public static List<PermissionDto> GetPermissionModule(string type)
        {
            object obj = CacheHelper.CacheValue(TokenId + Cfg.Permission);
            if (obj == null)
            {
                SSOHelper.GetCertificate(TokenId);
                obj = CacheHelper.CacheValue(TokenId + Cfg.Permission);
            }
            if (obj == null)
            {
                //强制清空当前用户的登录状态
                CacheHelper.CacheNull(TokenId + Cfg.Cer);
                throw new Exception("您已被强制下线，请关闭页面，重新打开！");
            }
            List<PermissionDto> list = (List<PermissionDto>)obj;
            if (string.IsNullOrEmpty(type))
                return list;
            else
                return list.FindAll(p => p.ModuleType == type);
        }

        /// <summary>
        /// 获取操作权限
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        public static List<PermissionDto> GetPermissionModule(string tokenId,string type)
        {
            object obj = CacheHelper.CacheValue(tokenId + Cfg.Permission);
            if (obj == null)
            {
                SSOHelper.GetCertificate(tokenId);
                obj = CacheHelper.CacheValue(tokenId + Cfg.Permission);
            }
            if (obj == null)
            {
                //强制清空当前用户的登录状态
                CacheHelper.CacheNull(tokenId + Cfg.Cer);
                throw new Exception("您已被强制下线，请关闭页面，重新打开！");
            }
            List<PermissionDto> list = (List<PermissionDto>)obj;
            if (string.IsNullOrEmpty(type))
                return list;
            else
                return list.FindAll(p => p.ModuleType == type);
        }


        /// <summary>
        /// 判断访问权限
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static ResultMsg CheckUrlAccess(string url,string type="Page")
        {
            //判定用户是否登录
            if (AuthToken.CurrentUser == null)
            {
                return ResultMsg.Failure("用户未登陆，请先登录！");
            }
            //判断是否是SupperRole,如果是本系统的超级管理员，直接过
            if (AuthToken.CurrentUser.isSupperRole)
                return ResultMsg.Success("超级用户，免检！");
            
            if (type != "Page" && type != "Action")
            {
                return ResultMsg.Success("非托管权限，不检查！");
            }

            url = "#" + url.ToLower();
            PermissionDto per = GetPermissionModule(type).Find(m => url.IndexOf("#" + m.ModuleUrl.ToLower().TrimEnd('/')) == 0 && m.ModuleUrl.Trim().Length > 0);
            if (per == null)
            {
                return ResultMsg.Failure("没有访问改模块的权限！");
            }
            if (url != "#/admin/itsmevent/get")
                SSOHelper.AccessRegister(AuthToken.CurrentUser.tokenId,per.Id);
            return ResultMsg.Success("模块授权成功！");
        }

        /// <summary>
        /// 记录访问日志，微信专用
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static ResultMsg LogUrlAccessForWeiXin(string tokenId,string url, string type = "Page")
        {
            if (type != "Page" && type != "Action")
            {
                return ResultMsg.Success("非托管权限，不检查！");
            }
            url = "#" + url.ToLower();
            PermissionDto per = GetPermissionModule(tokenId,type).Find(m => url.IndexOf("#" + m.ModuleUrl.ToLower().TrimEnd('/')) == 0 && m.ModuleUrl.Trim().Length > 0);
            if (per == null)
            {
                return ResultMsg.Failure("没有访问改模块的权限！");
            }
            SSOHelper.AccessRegister(tokenId,per.Id);
            return ResultMsg.Success("模块授权成功！");
        }
        /// <summary>
        /// SessionID
        /// </summary>
        public static string TokenId
        {
            get
            {
                return CookieHelper.GetCookie(Cfg.Matrix_.ToString() + Cfg.TokenId.ToString());
            }
        }



        /// <summary>
        /// 设置登录成功信息
        /// </summary>
        /// <param name="User"></param>
        /// <param name="SessionId"></param>
        /// <param name="time"></param>
        public static void SetAuthToken(CertificateDto cer)
        {
            CookieHelper.SaveCookie(Cfg.Matrix_.ToString() + Cfg.TokenId.ToString(), cer.tokenId.ToString(), 60 * 24 * 30);
            //缓存23分钟就到期，到期后，如果token不为空，那么继续到sso系统认证，延长周期
            CacheHelper.CacheInsertAddMinutes(cer.tokenId + Cfg.Cer, cer, 23);
            //获取具有的权限
            List<PermissionDto> list = SSOHelper.GetPermission(cer.tokenId);
            CacheHelper.CacheInsertAddMinutes(cer.tokenId + Cfg.Permission.ToString(), list, 5);
        }

        //清空用户状态
        public static void ClearAuthToken(string tid)
        {
            CookieHelper.ClearCookie(Cfg.Matrix_.ToString() + Cfg.TokenId.ToString());
            CacheHelper.CacheNull(tid + Cfg.Cer);
            CacheHelper.CacheNull(tid + Cfg.Permission.ToString());
        }
    }
}
