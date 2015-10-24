using EPManageWeb.Entities;
using EPManageWeb.Entities.Models;
using EPManageWeb.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EPManageWeb.Controllers
{
    public abstract class BaseController : Controller
    {
        protected EPDataContext DbContext = new EPDataContext();

        protected BaseController()
        {
            ViewBag.ClothesTypes = DbContext.ClothesTypes.Where(t => t.Parent == null).ToList();
        }

        public List<Message> Messages = new List<Message>();

        protected void AddError(String msg)
        {
            Messages.Add(new Message() { Content = msg, Type = MessageType.Error });
        }

        protected void AddInfo(String msg)
        {
            Messages.Add(new Message() { Content = msg, Type = MessageType.Info });
        }

        protected void AddWarning(String msg)
        {
            Messages.Add(new Message() { Content = msg, Type = MessageType.Warning });
        }

        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            base.OnActionExecuted(filterContext);

            ViewBag.Errors = Messages.Where(t => t.Type == MessageType.Error).ToList();
            ViewBag.Warnings = Messages.Where(t => t.Type == MessageType.Warning).ToList();
            ViewBag.Infos = Messages.Where(t => t.Type == MessageType.Info).ToList();
        }

        protected User CurrentUser
        {
            get
            {
                var userId = (int)System.Web.HttpContext.Current.Items["UserId"];
                return DbContext.Users.Single(t => t.Id == userId);
            }
        }


    }
}
