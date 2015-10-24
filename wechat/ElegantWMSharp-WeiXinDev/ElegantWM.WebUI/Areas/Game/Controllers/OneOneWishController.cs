using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using ElegantWM.Tools;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.DTO;
using System.Text.RegularExpressions;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class OneOneWishController : Controller
    {
        //
        // GET: /Game/OneOneWish/

        public ActionResult Index()
        {
            return View();
        }

        [Page]
        [Description("品牌")]
        public ActionResult Brand()
        {
            return View();
        }

        [Page]
        [Description("许愿")]
        public ActionResult WriteWish()
        {
            return View();
        }

        [Page]
        [Description("展现愿望")]
        public ActionResult LookWish(string result) {
            ViewBag.result = result;
            return View();
        }

        [Page]
        [Description("分享页面")]
        public ActionResult SharePage(string wish) {
            ViewBag.result = wish;
            return View();
        }

        [Action]
        [HttpPost]
        [Description("心愿提交")]
        public JsonResult SubmitWish(Game_QAVolunteer _t) {
            System.Guid Id = System.Guid.NewGuid();  
            //IEnumerable<Game_QAVolunteer> fans = WMFactory.GameQAVolunteer.FindByConditions(null, f => f.Id == Wish);
            //ElegantWM.EntityModel.Game_QAVolunteer vt = new ElegantWM.EntityModel.Game_QAVolunteer();
           
            //vt.Oid = "oBf_qJbqiosz24JaarxdJN2ZH6ug";
            //vt.VTName = "";
            //vt.VtPhone = "";
            //vt.VtAddress = Wish;
            //vt.VtReason = "";
            //vt.TntId = Id;Oid
            //vt.CreateUser = "admin";
            _t.Oid = Id.ToString();
            _t.TntId = Id;
            _t.CreateUser = "admin";
            WMFactory.GameQAVolunteer.Insert( _t);
            return Json(ResultMsg.Success(Id.ToString()));
        }
    }
}
