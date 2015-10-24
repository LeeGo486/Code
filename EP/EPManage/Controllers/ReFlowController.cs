using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EPManageWeb.Helper;

namespace EPManageWeb.Controllers
{
    public class ReFlowController : BaseController
    {
        public ActionResult Index()
        {
            var clothes = DbContext.Clothes.Where(t => t.IsDeleted == false).ToList();
            SaveClothesHelper.RemovePreviousIndex();
            clothes.ForEach(c =>
                {
                    c.Tags = c.Tags.Replace("undefined", "Tag");
                    SaveClothesHelper.Save(c);
                });
            return new ContentResult() { Content = "Reflowed" };
        }

    }
}
