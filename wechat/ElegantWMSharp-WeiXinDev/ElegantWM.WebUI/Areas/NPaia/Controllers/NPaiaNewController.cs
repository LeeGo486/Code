using ElegantWM.Factory;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.NPaia.Controllers
{
    public class NPaiaNewController : Controller
    {
        [Page]
        [Description("品牌故事")]
        public ActionResult BrandStoryList()
        {
            return View();
        }

    }
}
