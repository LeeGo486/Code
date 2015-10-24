using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EPManageWeb.Entities.Models;
using EPManageWeb.Filters;
using EPManageWeb.Helper;
using EPManageWeb.Models;

namespace EPManageWeb.Controllers
{
    public class UserController : BaseController
    {
        [HttpGet]
        public ActionResult Reg()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Reg(User user)
        {
            if (!String.IsNullOrEmpty(user.UserName) && !String.IsNullOrEmpty(user.Password))
            {
                if (DbContext.Users.SingleOrDefault(t => t.UserName == user.UserName) == null)
                {
                    user.UserType = UserType.User.ToString();
                    DbContext.Users.Add(user);
                    DbContext.SaveChanges();
                    return new ContentResult() { Content = "true" };
                }
                else
                {
                    return new ContentResult() { Content = "该用户名已存在" };
                }
            }
            else
            {
                return new ContentResult() { Content = "用户名和密码不得为空" };
            }
        }

        [HttpGet]
        [CookiesAuthorize]
        public ActionResult ChangePassword()
        {
            return View();
        }

        [HttpPost]
        [CookiesAuthorize]
        public ActionResult ChangePassword(UserChangePasswordModel model)
        {
            if (ModelState.IsValid)
            {
                var user = DbContext.Users.SingleOrDefault(t => t.Id == CurrentUser.Id);
                if (user.Password == model.OldPassword)
                {
                    if (model.NewPassword == model.RetypeNewPassword)
                    {
                        user.Password = model.NewPassword;
                        user.ModifiedDT = DateTime.Now;
                        DbContext.SaveChanges();
                        AddInfo("密码修改成功");
                        return View();
                    }
                    else
                    {
                        AddError("两次密码输入不一致");
                        return View(model);
                    }
                }
                else
                {
                    AddError("旧密码输入不正确");
                    return View(model);
                }
            }
            else
            {
                AddError("输入信息有误");
                return View(model);
            }
        }

        [HttpGet]
        [CookiesAuthorize]
        public ActionResult List(int page = 1)
        {
            int pageSize = 10;
            IEnumerable<User> users = DbContext.Users.OrderBy(t=>t.IsDeleted);
            int totalCount = users.Count();
            users = users.OrderByDescending(t => t.Id).Skip((page - 1) * pageSize).Take(pageSize);
            return View(users.ToPageList<User>(page, pageSize, totalCount));
        }

        [HttpGet]
        [CookiesAuthorize]
        public ActionResult Add()
        {
            return View();
        }

        [HttpPost]
        [CookiesAuthorize]
        public ActionResult Add(UserAddModel model)
        {
            if (ModelState.IsValid)
            {
                var user = DbContext.Users.SingleOrDefault(t => t.UserName == model.UserName);
                if (user == null)
                {
                    DbContext.Users.Add(new User()
                    {
                        UserName = model.UserName,
                        RealName = model.RealName,
                        UserType = UserType.User.ToString(),
                        Department = model.Department,
                        CreateDT = DateTime.Now,
                        ModifiedDT = DateTime.Now,
                        Password = "111",
                        IsDeleted = false
                    });
                    DbContext.SaveChanges();
                    return new JsonResult() { Data = true };
                }
                else
                {
                    return new JsonResult() { Data = "该用户名已存在" };
                }
            }
            return new JsonResult() { Data = false };
        }

        [HttpGet]
        [CookiesAuthorize]
        public ActionResult ResetPassword(string username)
        {
            var user = DbContext.Users.SingleOrDefault(t => t.UserName == username);
            user.Password = "111";
            DbContext.SaveChanges();
            return RedirectToAction("List");
        }

        [HttpGet]
        [CookiesAuthorize]
        public ActionResult Del(string username)
        {
            //删除用户，删除用户9527，如果重新添加9527，就会无法进行添加
            var user = DbContext.Users.SingleOrDefault(t => t.UserName == username);
            //return new JsonResult() { Data = "该用户名已存在" };
            //string strMsg = "管理员无法删除";
            //if (user.UserType == "Admin")
            //{
            //    System.Web.HttpContext.Current.Response.Write("<Script Language='JavaScript'>window.alert('" + strMsg + "');</script>");
            //    //AddError("管理员无法删除");
            //    return RedirectToAction("List");
            //}
         
            //DbContext.Users.Remove(user);
            user.IsDeleted = true;
            DbContext.SaveChanges();
            return RedirectToAction("List");
        }

        [HttpGet]
        [CookiesAuthorize]
        public ActionResult Rel(string username)
        {
            //删除用户，删除用户9527，如果重新添加9527，就会无法进行添加
            var user = DbContext.Users.SingleOrDefault(t => t.UserName == username);
            user.IsDeleted = false;
            DbContext.SaveChanges();
            return RedirectToAction("List");
        }
    }
}
