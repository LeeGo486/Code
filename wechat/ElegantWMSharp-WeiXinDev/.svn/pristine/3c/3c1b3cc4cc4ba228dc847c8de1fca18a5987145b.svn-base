using ElegantWM.DTO;
using ElegantWM.Tools;
using LitJson;
using System.Collections.Generic;
using System.Configuration;
using System.Threading;

/* *
 * Copyright © 2013 CCT All Rights Reserved 
 * 作者：JackChain 
 * 时间：2013/8/23 18:25:28
 * 功能：SSO SAAS
 * 版本：V1.0
 *
 * 修改人：
 * 修改点：
 * */

namespace ElegantWM.Common
{
    public class SSOHelper
    {
        #region Server Url 地址
        /// <summary>
        /// 登录地址
        /// </summary>
        private static string GetLoginUrl
        {
            get
            {
                return ConfigurationManager.AppSettings["SSO"] + "/Login/Login";
            }
        }
        private static string GetLogoutUrl
        {
            get
            {
                return ConfigurationManager.AppSettings["SSO"] + "/api/Permission/LogOut";
            }
        }
        /// <summary>
        /// 认证地址
        /// </summary>
        private static string GetCertificateUrl
        {
            get
            {
                return ConfigurationManager.AppSettings["SSO"] + "/api/Permission/GetCertificate?tokenId=";
            }
        }
        /// <summary>
        /// 获取系统菜单，json
        /// </summary>
        private static string GetSysMenuUrl
        {
            get
            {
                return ConfigurationManager.AppSettings["SSO"] + "/api/Permission/GetMenu";
            }
        }
        /// <summary>
        /// 获取有权限的模块
        /// </summary>
        private static string GetPermissionModuleUrl
        {
            get
            {
                return ConfigurationManager.AppSettings["SSO"] + "/api/Permission/GetModule";
            }
        }

        /// <summary>
        /// 获取用户行为登记
        /// </summary>
        private static string GetAccessRegisterUrl
        {
            get
            {
                return ConfigurationManager.AppSettings["SSO"] + "/api/Permission/AccessRegister";
            }
        }

        /// <summary>
        /// 更新用户信息
        /// </summary>
        private static string getUpdateCertificateUrl
        {
            get
            {
                return ConfigurationManager.AppSettings["SSO"] + "/api/Permission/UpdateCertificate";
            }
        }

        /// <summary>
        /// 同步功能模块
        /// </summary>
        private static string getSynRefModuleUrl
        {
            get
            {
                return ConfigurationManager.AppSettings["SSO"] + "/api/Permission/UpdateRefModule";
            }
        }
        #endregion

        #region 登录登出
        /// <summary>
        /// 用户登录
        /// </summary>
        public static ResultMsg Login(string uid, string pwd, string pf = "Unknown", string ip = "")
        {
            string url = GetLoginUrl + "?uid=" + uid + "&pwd=" + pwd + "&rm=true&sysId=" + ConfigurationManager.AppSettings["SysId"].ToString() + "&pf=" + pf + "&ip=" + ip;
            string json = HttpCrossDomain.Post(url, "");
            ResultMsg result = JsonMapper.ToObject<ResultMsg>(json);
            if (result.result != 0)
                return result;
            //登录
            if (GetCertificate(result.msg))
            {
                return ResultMsg.Success(result.msg);
            }
            else
            {
                return ResultMsg.Failure("用户登录成功，但认证失败！");
            }
        }
        /// <summary>
        /// 安全退出
        /// </summary>
        /// <returns></returns>
        public static ResultMsg LogOut()
        {
            return LogOut(AuthToken.CurrentUser.tokenId);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="tid"></param>
        /// <returns></returns>
        public static ResultMsg LogOut(string tid)
        {
            string url = GetLogoutUrl + "?tokenId=" + tid;
            string result = HttpCrossDomain.Post(url, "");
            if (result == "0")
            {
                AuthToken.ClearAuthToken(tid);
                return ResultMsg.Success("安全退出成功！");
            }
            else
                return ResultMsg.Failure("抱歉，安全退出失败！");
        }

        #endregion 


        /// <summary>
        /// 用户认证
        /// </summary>
        /// <param name="token">sessionId</param>
        /// <returns></returns>
        public static bool GetCertificate(string tokenId)
        {
            try
            {
                //如果没有token直接显示未登陆
                if (string.IsNullOrEmpty(tokenId))
                    return false;
                string cerJson = HttpCrossDomain.Post(GetCertificateUrl + tokenId, "");
                CertificateDto cer = JsonMapper.ToObject<CertificateDto>(cerJson);
                
                if (cer != null)
                    AuthToken.SetAuthToken(cer);//保存用户
                else
                    return false;
                return true;
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// 获取当前用户的功能菜单树
        /// </summary>
        /// <returns></returns>
        public static string GetSysMenu()
        {
            return HttpCrossDomain.Post(GetSysMenuUrl, "{tokenId:'" + AuthToken.CurrentUser.tokenId + "'}");
        }


        /// <summary>
        /// 获取用户拥有的权限
        /// </summary>
        /// <returns></returns>
        public static List<PermissionDto> GetPermission(string tid)
        {
            string moduleJson = HttpCrossDomain.Post(GetPermissionModuleUrl, "{tokenId:'" + tid + "',type:''}");
            return JsonMapper.ToObject<List<PermissionDto>>(moduleJson);
        }

        /// <summary>
        /// 更新用户信息
        /// </summary>
        /// <param name="cer"></param>
        public static ResultMsg UpdateCertificate(CertificateDto cer)
        {
            CertificateDto dto = AuthToken.CurrentUser;
            string jsonData = "{tokenId:'" + dto.tokenId + "',"
                              + "Id:'" + dto.Id + "',"
                              + "UserName:'" + cer.UserName + "',"
                              + "NickName:'" + cer.NickName + "',"
                              + "Phone:'" + cer.Phone + "',"
                              + "Email:'" + cer.Email + "',"
                              + "QQ:'" + cer.QQ + "',"
                              + "Address:'" + cer.Address + "',"
                              + "UserPwd:'" + cer.UserPwd + "',"
                              + "NewPwd:'" + cer.NewPwd + "',"
                              + "Sex:'" + cer.Sex + "'}";
            string result = HttpCrossDomain.Post(getUpdateCertificateUrl, jsonData);
            ResultMsg msg = JsonMapper.ToObject<ResultMsg>(result);
            if (msg.success)
                GetCertificate(dto.tokenId);
            return msg;
        }
        /// <summary>
        /// 同步功能模块
        /// </summary>
        /// <param name="mds"></param>
        /// <returns></returns>
        public static ResultMsg SynRefModule(List<RefModuleDto> mds)
        {
            object oj = new { cer = AuthToken.CurrentUser, refModule = mds };
            string json = JsonMapper.ToJson(oj);
            string result = HttpCrossDomain.Post(getSynRefModuleUrl, json);
            ResultMsg msg = JsonMapper.ToObject<ResultMsg>(result);
            return msg;
        }
        /// <summary>
        /// 登记用户访问情况
        /// </summary>
        /// <param name="moduleId"></param>
        public static void AccessRegister(string tokenId,string moduleId)
        {
            ParameterizedThreadStart ParStart = new ParameterizedThreadStart(ThreadMethod);
            Thread myThread = new Thread(ParStart);
            object obj = "[{tokenId:'" + tokenId + "',Id:'" + moduleId + "'}]";
            myThread.Start(obj);
        }
        //ThreadMethod如下:
        private static void ThreadMethod(object obj)
        {
            try
            {
                HttpCrossDomain.Post(GetAccessRegisterUrl, obj.ToString(), 5000);
            }
            catch
            {
                
            }
        }
    }
}
