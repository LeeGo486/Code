using EPManageWeb.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EPManageWeb.Helper
{
    public abstract class EPViewePage : System.Web.Mvc.WebViewPage
    {
        protected bool HasErrorMessage { get { return Errors != null && Errors.Count > 0; } }

        protected List<Message> Errors { get { return ViewBag.Errors; } }

        protected bool HasWarningMessage { get { return Warnings != null && Warnings.Count > 0; } }

        protected List<Message> Warnings { get { return ViewBag.Warnings; } }

        protected bool HasInfoMessage { get { return Infos != null && Infos.Count > 0; } }

        protected List<Message> Infos { get { return ViewBag.Infos; } }
    }

    public abstract class EPViewePage<T> : System.Web.Mvc.WebViewPage<T>
    {
        protected bool HasErrorMessage { get { return Errors != null && Errors.Count > 0; } }

        protected List<Message> Errors { get { return ViewBag.Errors; } }

        protected bool HasWarningMessage { get { return Warnings != null && Warnings.Count > 0; } }

        protected List<Message> Warnings { get { return ViewBag.Warnings; } }

        protected bool HasInfoMessage { get { return Infos != null && Infos.Count > 0; } }

        protected List<Message> Infos { get { return ViewBag.Infos; } }
    }
}