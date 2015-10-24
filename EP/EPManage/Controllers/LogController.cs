using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EPManageWeb.Helper;
using EPManageWeb.Entities.Models;

namespace EPManageWeb.Controllers
{
    public class LogController : BaseController
    {
        private const int PAGE_SIZE = 20;

        [CookiesAuthorize]
        public ActionResult Index(string no,  int page = 1)
        {

            IEnumerable<OperationLog> logs = DbContext.OperationLogs;
            if (!String.IsNullOrEmpty(no))
            {
                logs = DbContext.OperationLogs.Where(t => t.Clothes.ProductNO.Contains(no) || t.Clothes.SampleNO.Contains(no));
            }
            int totalCount = logs.Count();
            logs = logs.OrderByDescending(t => t.Id).Skip((page - 1) * PAGE_SIZE).Take(PAGE_SIZE);
            return View(logs.ToPageList<OperationLog>(page, PAGE_SIZE, totalCount));
        }

    }
}
