using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.NPaia.Controllers
{
    public class ShoppingController : Controller
    {
        [Page]
        [Description("公告")]
        public ActionResult Notice()
        {
            return View();
        }
    }
     //[NPaiaAuthFilter]
}
