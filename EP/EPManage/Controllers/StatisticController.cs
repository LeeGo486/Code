using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EPManageWeb.Entities.Models;
using EPManageWeb.Helper;

namespace EPManageWeb.Controllers
{
    public class StatisticController : BaseController
    {
        private const int PAGE_SIZE = 20;
        private String[] ClothesType = { "裙子", "裤子", "毛衫" };
        public StatisticController()
        {
            List<ClothesPartType> pingleis = new List<ClothesPartType>();
            DbContext.ClothesParts.Where(t => t.Name == "品类").ToList().ForEach(t =>
            {
                pingleis.AddRange(t.PartTypes);
            });
            Array.ForEach(ClothesType, t =>
                {
                    pingleis.Add(new ClothesPartType() { Name = t });
                });
            ViewBag.Pingleis = pingleis;
        }

        [CookiesAuthorize]
        public ActionResult Index(string type, string startDT, string endDT, string no, int page = 1)
        {
            DateTime startDateTime = DateTime.Now.AddDays(-30);
            DateTime endDateTime = DateTime.Now.AddDays(1);
            if (!String.IsNullOrEmpty(startDT))
                if (!DateTime.TryParse(startDT, out startDateTime))
                    startDateTime = DateTime.Now.AddDays(-30);

            if (!String.IsNullOrEmpty(endDT))
                if (!DateTime.TryParse(endDT, out endDateTime))
                    endDateTime = DateTime.Now;

            ViewBag.StartDT = startDateTime;
            ViewBag.EndDT = endDateTime;
            ViewBag.No = no;
            endDateTime = endDateTime.AddDays(1);

            IEnumerable<Clothes> clothes = DbContext.Clothes;
            clothes = DbContext.Clothes.Where(t=>t.CreateDT >= startDateTime && t.CreateDT <= endDateTime);
            if (!String.IsNullOrEmpty(no))
                clothes = DbContext.Clothes.Where(t => t.ProductNO.Contains(no) || t.SampleNO.Contains(no)
                    && t.CreateDT >= startDateTime && t.CreateDT<=endDateTime);

            if (!String.IsNullOrEmpty(type))
            {
                if (Array.Exists(ClothesType, t => t == type))
                {
                    var clothesType = DbContext.ClothesTypes.SingleOrDefault(t => t.Name == type);
                    clothes = clothes.Where(t => t.ClothesType == clothesType && t.CreateDT >= startDateTime && t.CreateDT <= endDateTime);
                }
                else
                {
                    clothes = clothes.Where(t => t.PingLei == type);
                }
            }

            int totalCount = clothes.Count();
            clothes = clothes.OrderByDescending(t => t.ViewCount).Skip((page - 1) * PAGE_SIZE).Take(PAGE_SIZE);
            return View(clothes.ToPageList<Clothes>(page, PAGE_SIZE, totalCount));
        }

        [CookiesAuthorize]
        public ActionResult Pinglei()
        {
            List<IGrouping<string, Clothes>> pinglei = DbContext.Clothes.GroupBy(t => t.PingLei).ToList();
            return View(pinglei);

        }
    }
}
