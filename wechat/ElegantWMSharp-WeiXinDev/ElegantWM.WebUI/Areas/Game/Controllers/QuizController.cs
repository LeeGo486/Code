using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class QuizController : Controller
    {
        [Description("首页")]
        public ActionResult Index()
        {
            //获取筹集进度
            ViewBag.process = WMFactory.GameQARst.Process(Guid.Parse("cfe404ea-fe5b-4a85-87f0-b2701929462c"));
            string oid = Request["oid"];
            ViewBag.playCount = WMFactory.GameQARst.GetCount(f => f.Oid == oid);
            return View();
        }

        [Description("开始游戏")]
        public ActionResult Start()
        {
            return View();
        }

        [Description("游戏结束")]
        public ActionResult Share(Guid sid,Guid id)
        {
            string oid = Request["oid"];
            if (string.IsNullOrEmpty(oid))
            {
                ViewBag.MyResult = WMFactory.GameQARst.GetQAResult(sid, id);
            }
            else
            {
                ViewBag.MyTotal = WMFactory.GameQARst.FindByConditions(null, f => f.Oid == oid).Sum(s => s.Total);
            }
            return View();
        }

        [Description("志愿者管理")]
        public ActionResult Volunteer()
        {
            return View();
        }

        [HttpPost]
        [Description("志愿者提交")]
        public JsonResult SubmitUser(Game_QAVolunteer vt)
        {
            IEnumerable<Game_QAVolunteer> volunteers = WMFactory.GameQAVolunteer.FindByConditions(null, f => f.Oid == vt.Oid);
            bool flag = false;
            if (volunteers.Count() <= 0)
            {
                vt.CreateUser = "admin";
                vt.TntId = Guid.Parse("cfe404ea-fe5b-4a85-87f0-b2701929462c");
                flag = WMFactory.GameQAVolunteer.Insert(vt);
            }
            else
            {
                Game_QAVolunteer vtnew = volunteers.First();
                vtnew.VtAddress = vt.VtAddress;
                vtnew.VTName = vt.VTName;
                vtnew.VtPhone = vt.VtPhone;
                vtnew.VtReason = vt.VtReason;
                vtnew.ModifyUser = "admin";
                flag = WMFactory.GameQAVolunteer.Update(vtnew);
            }
            if (flag)
                return Json(ResultMsg.Success("报名成功！"));
            else
                return Json(ResultMsg.Failure("报名失败！"));
        }

        [Description("加载题目")]
        public JsonResult LoadQuestion(Guid sid)
        {
            string type = "1";
            IEnumerable<Game_Question> questions = WMFactory.GameQuestion.GetQuestions(sid ,type );
            var qrst = from q in questions
                      select new
                      {
                          Id = q.Id,
                          Question = q.Question,
                          QImage=q.QImage
                      };
            var answers = WMFactory.GameAnswer.GetAll();
            var arst = from a in answers
                       select new
                       {
                           Qid=a.Qid,
                           Answer=a.Answer,
                           IsRight=a.IsRight
                       };
            return Json(new { Q = qrst, A = arst }, JsonRequestBehavior.AllowGet);
        }

        [Description("提交成绩")]
        [HttpPost]
        public JsonResult Submit(Guid sid, int score)
        {
            Game_QARst rst = new Game_QARst();
            rst.TntId = sid;
            rst.Oid = string.IsNullOrEmpty(Request["oid"]) ? Guid.NewGuid().ToString() : Request["oid"];
            rst.Total = score;
            rst.CreateUser = "Quiz";
            rst.Id = Guid.NewGuid();
            if (WMFactory.GameQARst.Insert(rst))
                return Json(ResultMsg.Success(rst.Id.ToString()));
            else
                return Json(ResultMsg.Failure("很抱歉，成绩提交失败"));
        }
    }
}
