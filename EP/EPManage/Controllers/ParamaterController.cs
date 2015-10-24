using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EPManageWeb.Entities.Models;

namespace EPManageWeb.Controllers
{
    public class ParamaterController : BaseController
    {
        public ActionResult Index(int id)
        {
            ClothesType type = DbContext.ClothesTypes
                .Include("ClothesParts").Include("ClothesParts.Children").Include("ClothesParts.PartTypes")
                .SingleOrDefault(t => t.Id == id);

            return View(type);
        }

    }
}
