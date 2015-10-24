using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EPManageWeb.Controllers
{
    public class ClothesPartTypesController : BaseController
    {

        public ActionResult Index(int id)
        {
            var clothesPartType = DbContext.ClothesPartTypes.SingleOrDefault(t => t.Id == id);
            if (clothesPartType == null)
                return new ContentResult() { Content = "Not Found" };
            return View(clothesPartType);
        }

        [HttpPost]
        public ActionResult Add(int clothesPartTypeId, string name)
        {
            var clothesPartType = DbContext.ClothesPartTypes.SingleOrDefault(t => t.Id == clothesPartTypeId);
            clothesPartType.Children.Add(new Entities.Models.ClothesPartType()
            {
                Name = name,
                Order = clothesPartType.Children.Count
            });
            DbContext.SaveChanges();
            return View("Index", clothesPartType);
        }

        [HttpPost]
        public ActionResult SaveClothesPartTypes(int clothesPartTypeId, string itemIds)
        {
            var clothesPartType = DbContext.ClothesPartTypes.SingleOrDefault(t => t.Id == clothesPartTypeId);
            var items = itemIds.Split(new char[] { ',' }).Where(t => !String.IsNullOrEmpty(t)).Select(t => int.Parse(t)).ToList();
            for (var i = 0; i < items.Count(); i++)
            {
                clothesPartType.Children.Single(t => t.Id == items[i]).Order = i;
            }
            DbContext.SaveChanges();
            return new JsonResult() { Data = true };
        }

        [HttpPost]
        public ActionResult Del(int clothesPartTypeId, int id)
        {
            var clothesPartType = DbContext.ClothesPartTypes.SingleOrDefault(t => t.Id == clothesPartTypeId);
            var child = DbContext.ClothesPartTypes.SingleOrDefault(t => t.Id == id);
            clothesPartType.Children.Remove(child);
            DbContext.SaveChanges();
            return View("Index", clothesPartType);
        }

        [HttpPost]
        public ActionResult ChildCount(int clothesPartTypeId)
        {
            return new ContentResult() { Content = DbContext.ClothesPartTypes.SingleOrDefault(t => t.Id == clothesPartTypeId).Children.Count.ToString() };
        }
    }
}
