using EPManageWeb.Helper;
using EPManageWeb.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EPManageWeb.Entities.Models;

namespace EPManageWeb.Controllers
{
    public class MainController : BaseController
    {
        private static object _lockObj = new object();
        [CookiesAuthorize]
        public ActionResult Index(int id)
        {
            ClothesType clothesType = DbContext.ClothesTypes.SingleOrDefault(t => t.Id == id);
            if (clothesType == null)
                clothesType = DbContext.ClothesTypes.FirstOrDefault();

            if (clothesType.Children != null && clothesType.Children.Count > 0)
                clothesType = clothesType.Children[0];

            ViewBag.ClothesTypes = DbContext.ClothesTypes.Where(t => t.Parent == null).ToList();
            ViewBag.ClassicStyles = DbContext.Tags.Where(t => t.IsDeleted == false && t.Type == "Classic").OrderBy(t=>t.Order).ToList();
            ViewBag.BestSellingStyles = DbContext.Tags.Where(t => t.IsDeleted == false && t.Type == "BestSell").OrderByDescending(t=>t.Value).ToList();

            if (clothesType != null)
            {
                ViewBag.CurrentClothesType = clothesType;
                return View(clothesType);
            }
            return new HttpNotFoundResult();
        }

        [CookiesAuthorize]
        [HttpGet]
        public ActionResult Add()
        {
            return View();
        }

        [CookiesAuthorize]
        [HttpPost]
        public ActionResult Add(Clothes model, int clothesTypeId)
        {
            lock (_lockObj)
            {

                if (!ValidClothesSize(model.ClothesSize)) return new JsonResult() { Data = false };
                if (!ValidateClothes(model)) return new JsonResult() { Data = "大货编号或样板编号已存在" };

                var pinglei = DbContext.ClothesParts.FirstOrDefault(t => t.Name == "品类" && t.ClothType.Id == clothesTypeId);

                Clothes c = new Clothes()
                {
                    Comment = model.Comment,
                    ProductedCount = model.ProductedCount,
                    SaledCount = model.SaledCount,
                    SampleNO = model.SampleNO ?? string.Empty,
                    ProductNO = model.ProductNO ?? string.Empty,
                    AssessoriesFile = model.AssessoriesFile ?? string.Empty,
                    ClothesPics = model.ClothesPics ?? string.Empty,
                    ClothesSize = model.ClothesSize ?? string.Empty,
                    ModelVersionPics = model.ModelVersionPics ?? string.Empty,
                    SampleFile = model.SampleFile ?? string.Empty,
                    StylePics = model.StylePics ?? string.Empty,
                    TechnologyFile = model.TechnologyFile ?? string.Empty,
                    Tags = model.Tags ?? string.Empty,
                    ClothesType = DbContext.ClothesTypes.SingleOrDefault(t => t.Id == clothesTypeId),
                    Owner = CurrentUser
                };
                string tmp = string.Empty;
                if (pinglei != null)
                {
                    var tags = model.Tags.Split(new char[] { ',' }).ToList();
                    foreach (var t in tags)
                    {
                        foreach (var pt in pinglei.PartTypes)
                        {
                            if (t.Contains(pt.Name))
                            {
                                tmp = pt.Name;
                            }
                        }
                    }

                    if (string.Empty != tmp)
                        c.PingLei = tmp;
                }

                DbContext.Clothes.Add(c);
                DbContext.OperationLogs.Add(new OperationLog()
               {
                   User = CurrentUser,
                   Clothes = c,
                   OperationType = OperationType.AddClothes.ToString()
               });

                DbContext.SaveChanges();
                SaveClothesHelper.Save(c);
                return new JsonResult() { Data = true };
            }
        }

        [CookiesAuthorize]
        public ActionResult Statistic(int id)
        {
            return View();
        }

        [HttpGet]
        public ActionResult Test()
        {
            return View();
        }
        [HttpGet]
        [CookiesAuthorize]
        public ActionResult Edit(int id)
        {
            ClothesType clothesType = DbContext.ClothesTypes.Include("Children").Include("ClothesParts").Include("ClothesParts.Children").Include("ClothesParts.Children.PartTypes").Include("ClothesParts.Children.PartTypes.Children").Include("ClothesParts.PartTypes").Include("ClothesParts.PartTypes.Children").SingleOrDefault(t => t.Id == id);
            ViewBag.ClassicStyles = DbContext.Tags.Where(t => t.IsDeleted == false && t.Type == "Classic").OrderBy(t=>t.Order).ToList();
            ViewBag.BestSellingStyles = DbContext.Tags.Where(t => t.IsDeleted == false && t.Type == "BestSell").OrderBy(t=>t.Order).ToList();

            if (clothesType == null) return new HttpNotFoundResult();

            return View(clothesType);
        }

        [HttpPost]
        [CookiesAuthorize]
        public ActionResult AddClothesPartType(string name, int partId)
        {
            var clothes = DbContext.ClothesParts.Include("PartTypes").SingleOrDefault(t => t.Id == partId);
            var type = new ClothesPartType() { Name = name, Order = clothes.PartTypes.Count };
            clothes.PartTypes.Add(type);
            DbContext.SaveChanges();
            return new JsonResult() { Data = new ClothesPartType() { Id = type.Id, Name = name } };
        }

        [HttpPost]
        [CookiesAuthorize]
        public ActionResult DeleteClothesPartType(int id)
        {
            var clothPartType = DbContext.ClothesPartTypes.SingleOrDefault(t => t.Id == id);
            if (clothPartType != null)
            {
                DbContext.ClothesPartTypes.Remove(clothPartType);
                DbContext.SaveChanges();
                return new JsonResult() { Data = true };
            }
            return new JsonResult() { Data = false };
        }

        [HttpPost]
        [CookiesAuthorize]
        public ActionResult DeleteStyleItem(int id)
        {
            var item = DbContext.Tags.SingleOrDefault(t => t.Id == id);
            if (item == null)
                return new JsonResult() { Data = false };
            else
            {
                item.IsDeleted = true;
                item.ModifiedDT = DateTime.Now;
                DbContext.SaveChanges();
                return new JsonResult() { Data = true };
            }
        }

        [HttpPost]
        [CookiesAuthorize]
        public ActionResult Order(int partId, string items)
        {
            var itemsIds = items.Split(new char[] { ',' }).Where(t => !String.IsNullOrEmpty(t)).Select(t => int.Parse(t)).ToList();
            var clothPart = DbContext.ClothesParts.Include("PartTypes").SingleOrDefault(t => t.Id == partId);
            for (int i = 0; i < itemsIds.Count; i++)
            {
                clothPart.PartTypes.Single(t => t.Id == itemsIds[i]).Order = i;
            }
            DbContext.SaveChanges();
            return new JsonResult() { Data = true };
        }

        [HttpPost]
        [CookiesAuthorize]
        public ActionResult StyleOrder(string style, string items)
        {
            var itemsIds = items.Split(new char[] { ',' }).Where(t => !String.IsNullOrEmpty(t)).Select(t => int.Parse(t)).ToList();
            var tags = DbContext.Tags.Where(t => t.Type == style).ToList();
            for (int i = 0; i < itemsIds.Count; i++)
            {
                tags.Single(t => t.Id == itemsIds[i]).Order = i;
            }
            DbContext.SaveChanges();
            return new JsonResult() { Data = true };
        }


        [CookiesAuthorize]
        [HttpPost]
        public ActionResult AddClothesClassicOrBestSelling(String ClassicOrBestSelling, String styleType)
        {
            var tag = DbContext.Tags.SingleOrDefault(t => t.Value == ClassicOrBestSelling && t.Type == styleType);
            if (tag == null)
            {
                tag = new Tag()
                {
                    Type = styleType,
                    Value = ClassicOrBestSelling,
                    IsDeleted = false,
                    CreateDT = DateTime.Now,
                    ModifiedDT = DateTime.Now
                };
                DbContext.Tags.Add(tag);
                DbContext.SaveChanges();
                return new JsonResult() { Data = tag };
            }
            else
            {
                return new JsonResult() { Data = "该名称已存在" };
            }
        }





        private bool ValidClothesSize(string size)
        {
            return true;
        }

        private bool ValidateClothes(Clothes clothes)
        {
            return DbContext.Clothes.FirstOrDefault(t => (t.ProductNO == clothes.ProductNO || t.SampleNO == clothes.SampleNO) && t.IsDeleted == false) == null;
        }
    }
}
