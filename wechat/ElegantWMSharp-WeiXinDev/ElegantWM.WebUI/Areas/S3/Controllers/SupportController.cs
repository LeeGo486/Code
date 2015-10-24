using ElegantWM.WebUI.Areas.Matrix;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    public class SupportController : BaseMatrixS3Controller
    {
        //
        // GET: /S3/Support/

        public ActionResult Index()
        {
            return View();
        }

    }
}
