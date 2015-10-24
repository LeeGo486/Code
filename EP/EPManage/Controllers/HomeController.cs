using EPManageWeb.Controllers;
using EPManageWeb.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EPManageWeb.Helper;

namespace EPManageWeb.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            if (UserAuthnicationHelper.CheckUserLogin(HttpContext))
                return RedirectToAction("Index", "Main", new { id = 1 });

            return View();
        }

        [HttpPost]
        public ActionResult Index(UserLoginModel model)
        {
            if (ModelState.IsValid)
            {
                var user = DbContext.Users.SingleOrDefault(t => t.UserName == model.UserName && t.Password == model.PassWord);

                if (user != null)
                {
                    if (user.IsDeleted == false)
                    {
                        UserAuthnicationHelper.Login(user, HttpContext);

                        return RedirectToAction("Index", "Main", new { id = 1 });
                    }
                    else
                    {
                        ModelState.AddModelError("Error", "您的账户已被删除，请联系管理员");
                        AddError("您的账户已被删除，请联系管理员");
                    }
                }
                else
                {
                    AddError("用户名或密码错误");
                    ModelState.AddModelError("Error", "用户名或密码错误");
                }
            }
            else
            {
                AddError("用户名和密码不得为空");
                ModelState.AddModelError("Error", "用户名和密码不得为空");
            }
            return View(model);
        }

        [HttpGet]
        public ActionResult Logout()
        {
            UserAuthnicationHelper.Logout(HttpContext);
            return RedirectToAction("Index");
        }
    }
}
