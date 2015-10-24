using EPManageWeb.Entities;
using EPManageWeb.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EPManageWeb.Helper
{
    public class UserAuthnicationHelper
    {
        private static String SESSION_ID = "UserId";
        private static int TIMEOUT_MINS = int.MaxValue;

        public static void Login(User user, HttpContextBase context)
        {

            using (EPDataContext dbContext = new EPDataContext())
            {
                SessionUser userSession = new SessionUser()
                {
                    CreateDT = DateTime.Now,
                    Id = Guid.NewGuid(),
                    IsDeleted = false,
                    LastActivityDT = DateTime.Now,
                    LoginDT = DateTime.Now,
                    ModifiedDT = DateTime.Now,
                    RemoteIP = context.Request.ServerVariables["REMOTE_ADDR"],
                    UserId = user.Id,
                    Status = UserLoginStatus.Active.ToString()

                };
                dbContext.SessionUsers.Add(userSession);
                dbContext.SaveChanges();

                HttpCookie cookie = new HttpCookie(SESSION_ID, userSession.Id.ToString());
                context.Response.AppendCookie(cookie);

            }
        }

        public static bool CheckUserLogin(HttpContextBase context)
        {
            using (EPDataContext dbContext = new EPDataContext())
            {
                if (context.Request.Cookies[SESSION_ID] != null)
                {
                    Guid userId = Guid.Parse(context.Request.Cookies[SESSION_ID].Value);
                    SessionUser s = dbContext.SessionUsers.Include("user").SingleOrDefault(t => t.Id == userId);
                    if (s == null)
                        return false;
                    else
                    {
                        UserLoginStatus status = UserLoginStatus.LogoutManual;
                        Enum.TryParse<UserLoginStatus>(s.Status, true, out status);
                        if (status == UserLoginStatus.Active)
                        {
                            if ((DateTime.Now - s.LastActivityDT).Minutes > TIMEOUT_MINS)
                            {
                                s.Status = UserLoginStatus.LogoutTimeOut.ToString();
                                dbContext.SaveChanges();
                                return false;
                            }
                            else
                            {
                                s.LastActivityDT = DateTime.Now;
                                s.ModifiedDT = DateTime.Now;
                                dbContext.SaveChanges();
                                HttpContext.Current.Items.Add("UserId", s.UserId);
                                HttpContext.Current.Items.Add("RealName", s.User.RealName);
                                HttpContext.Current.Items.Add("IP", s.RemoteIP);
                                HttpContext.Current.Items.Add("UserType", (UserType)Enum.Parse(typeof(UserType), s.User.UserType, true));
                                return true;
                            }
                        }
                    }
                }
            }
            return false;
        }

        public static void Logout(HttpContextBase httpContext)
        {
            using (EPDataContext dbContext = new EPDataContext())
            {
                if (httpContext.Request.Cookies[SESSION_ID] != null)
                {
                    Guid userId = Guid.Parse(httpContext.Request.Cookies[SESSION_ID].Value);
                    SessionUser s = dbContext.SessionUsers.SingleOrDefault(t => t.Id == userId);
                    if (s != null)
                    {
                        s.Status = UserLoginStatus.LogoutManual.ToString();
                        dbContext.SaveChanges();
                    }
                }
                HttpCookie cookie = new HttpCookie(SESSION_ID, "");
                cookie.Expires = DateTime.Now.AddDays(-1);
                httpContext.Response.AppendCookie(cookie);
            }

        }



        public enum UserLoginStatus
        {
            Active,       //激活  
            LogoutManual, //自动登出
            LogoutTimeOut,//超时登出
            LogoutForce   //强制登出
        }
    }
}