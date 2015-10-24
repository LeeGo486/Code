using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.Factory;
using System.ComponentModel;
using ElegantWM.Common;
using ElegantWM.DTO;
using ElegantWM.Tools;
using System.Reflection;
using System.Text;

/**
 * Author:jackchain 
 * DateTime:2012-09-27 
 * Version:1.0 
 * Description: 
 * QQ:710782046  
 * Email:ovenjackchain@gmail.com
 **/

namespace ElegantWM.WebUI.Areas.Admin.Controllers
{
    public class MainController : BaseController
    {
        //主页面
        public ActionResult Index()
        {
            return View();
        }
        //欢迎页面
        public ActionResult Welcome()
        {
            return View();
        }
        //获取当前用户昵称
        public JsonResult GetCurName()
        {
            return Json(Common.AuthToken.CurrentUser.NickName, JsonRequestBehavior.AllowGet);
        }
        //获取Extjs功能菜单树
        public string GetMenu()
        {
            string menu = Common.SSOHelper.GetSysMenu();
            return menu.Trim('"');
        }
        //获取当前用户，修改用户用
        public JsonResult GetCurUser()
        {
            CertificateDto cer = AuthToken.CurrentUser;
            cer.UserPwd = "";
            return Json(cer, JsonRequestBehavior.AllowGet);
        }
        //获取一个页面的按钮权限
        public JsonResult GetModuleButtons(string module)
        {
            List<PermissionDto> btns = new List<PermissionDto>();
            //超级管理员不校验
            if (!AuthToken.CurrentUser.isSupperRole)
                btns = AuthToken.GetPermissionModule("Button").FindAll(b => b.ModuleController == module);
            return Json(btns, JsonRequestBehavior.AllowGet);
        }
        //更新用户个人信息
        [HttpPost]
        public JsonResult UpdateCurUser(CertificateDto cer)
        {
            cer.Id = AuthToken.CurrentUser.Id;
            if (string.IsNullOrEmpty(cer.UserName) || string.IsNullOrEmpty(cer.NickName))
            {
                return Json(ResultMsg.Failure("用户名和昵称不能为空！"));
            }
            if (!string.IsNullOrEmpty(cer.UserPwd) && !string.IsNullOrEmpty(cer.NewPwd))
            {
                cer.UserPwd = DEncrypt.PwdSecurity(cer.UserPwd);
                cer.NewPwd = DEncrypt.PwdSecurity(cer.NewPwd);
            }
            ResultMsg result = SSOHelper.UpdateCertificate(cer) as ResultMsg;
            return Json(result);
        }
        //反射功能模块
        public JsonResult GetRefModules(string assmblyName, string urlPrefix)
        {
            if (AuthToken.CurrentUser.isSupperRole == false)
            {
                return Json(ResultMsg.Failure("您没有权限操作该功能！"), JsonRequestBehavior.AllowGet);
            }

            Assembly asm = Assembly.Load(assmblyName);
            List<RefModuleDto> list = new List<RefModuleDto>();
            if (CacheHelper.CacheValue("RefModule") != null)
            {
                list = (List<RefModuleDto>)CacheHelper.CacheValue("RefModule");
                return Json(list, JsonRequestBehavior.AllowGet);
            }

            var types = asm.GetTypes();

            foreach (var type in types)
            {
                if (type.BaseType.Name == "BaseController")//如果是Controller
                {
                    var members = type.GetMethods();
                    foreach (var member in members)
                    {
                        RefModuleDto module = new RefModuleDto();
                        //获取HTTPAttribute
                        IEnumerable<Attribute> atts = member.GetCustomAttributes();
                        bool isAction = false;
                        foreach (Attribute a in atts)
                        {
                            if (a.GetType().Name == "Action" || a.GetType().Name == "Page")
                            {
                                module.ModuleType = a.GetType().Name;
                                isAction = true;
                            }
                            else if (a.ToString().Contains("System.Web.Mvc.Http"))
                            {
                                module.ModuleMethod = a.GetType().Name.Replace("Attribute", "");
                            }
                        }
                        if (!isAction) continue;

                        //获取返回值 member.ReturnType.Name

                        //获取方法说明
                        object[] attrs = member.GetCustomAttributes(typeof(System.ComponentModel.DescriptionAttribute), true);
                        if (attrs.Length > 0)
                        {
                            module.ModuleName = (attrs[0] as System.ComponentModel.DescriptionAttribute).Description;
                        }

                        //获取参数
                        ParameterInfo[] param = member.GetParameters();
                        StringBuilder sb = new StringBuilder();
                        foreach (ParameterInfo pm in param)
                        {
                            sb.Append(pm.ParameterType.Name + " " + pm.Name + ",");
                        }
                        if (sb.ToString().Trim().Length > 0)
                            module.ModuleParam = "(" + sb.ToString().Trim(',') + ")";

                        module.ModuleAction = member.Name;
                        module.ModuleController = member.DeclaringType.Name.Replace("Controller", "");
                        module.ModuleUrl = urlPrefix + module.ModuleController + "/" + module.ModuleAction;
                        if (module.ModuleType == "Action")
                            module.ModuleIcon = "BulletLightning";
                        module.SysId = AuthToken.CurrentUser.SysId;
                        module.ModuleIndex = 0;
                        module.ModuleDesc = module.ModuleName;
                        module.CreateUser = AuthToken.CurrentUser.UserName;
                        list.Add(module);
                    }
                }
            }
            CacheHelper.CacheInsertAddMinutes("RefModule", list, 10);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        //同步功能模块到WMC
        [HttpPost]
        public JsonResult SynRefModule()
        {
            List<RefModuleDto> list = new List<RefModuleDto>();
            if (CacheHelper.CacheValue("RefModule") != null)
            {
                list = (List<RefModuleDto>)CacheHelper.CacheValue("RefModule");
                return Json(SSOHelper.SynRefModule(list));
            }
            else
            {
                return Json(ResultMsg.Failure("请先单击加载按钮，加载模块"));
            }
        }
    }
}
