using ElegantWM.Common;
using ElegantWM.EntityModel;
using ElegantWM.Factory;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElegantWM.Tools;
using System.Data;
using ElegantWM.DTO;

namespace ElegantWM.WebUI.Areas.HR.Controllers
{
    public class CourseController : BaseHRController
    {
        [Page]
        [Description("所有课程")]
        public ActionResult All()
        {
            ViewBag.Courses = WMFactory.HRCourse.FindByConditions(o => o.OrderByDescending(c => c.CreateTime), f => f.IsShow == 0, null);
            return View();
        }

        [Page]
        [Description("课程详细")]
        public ActionResult Detail(Guid id)
        {
            //获取报名人数
            ViewBag.Registers = WMFactory.HRLKCourseUser.GetCount(f => f.Cid == id);
            //获取课时
            ViewBag.Lesson = WMFactory.HRCourseLesson.FindByConditions(o => o.OrderBy(c => c.StartTime), f => f.Cid == id, null);
            //获取课程
            return View(WMFactory.HRCourse.GetById(id.ToString()));
        }

        [Page]
        [Description("课程课时详细")]
        public ActionResult LenDetail(Guid id)
        {
            //获取报名人数
            ViewBag.Registers = WMFactory.HRLKCourseUser.GetCount(f => f.Cid == id);
            //获取课时
            ViewBag.Lesson = WMFactory.HRCourseLesson.FindByConditions(o => o.OrderBy(c => c.StartTime), f => f.Cid == id, null);
            //获取课程
            return View(WMFactory.HRCourse.GetById(id.ToString()));
        }


        #region 用户登录
        [Page]
        [Description("签到登记")]
        [Open]
        public ActionResult Register()
        {
            return View();
        }

        [Action]
        [Description("用户绑定")]
        [Open]
        [HttpPost]
        public JsonResult Login(string code, string name)
        {
            HR_CourseUser user = WMFactory.HRWXEmployee.CheckEmployee(code, name);
            if (user == null)
                return Json(ResultMsg.Failure("员工名称或工号错误！"));
            else
            {
                CookieHelper.SaveCookie("HRWXUid", user.Id.ToString(), 60 * 24 * 30 * 10);
                CookieHelper.SaveCookie("HRWXUName", user.UserName, 60 * 24 * 30 * 10);
                return Json(ResultMsg.Success("登录成功，正在跳转"));
            }
        }
        #endregion

        [Page]
        [Description("出勤情况")]
        public ActionResult SignDetail(string id)
        {
            Guid uid = Guid.Parse(CookieHelper.GetCookie("HRWXUid"));
            IEnumerable<V_HR_CourseSignRst> signList = WMFactory.HRCourseAttend.CourseSignHistory(o => o.OrderBy(k => k.StartTime), f => f.Uid == uid && f.SignRst == id);
            IEnumerable<Guid> cids = signList.Select(s => s.Cid).Distinct();
            IEnumerable<HR_Course> crsList = WMFactory.HRCourse.FindByConditions(o => o.OrderByDescending(k => k.StartDate), f => cids.Contains(f.Id));
            ViewBag.SignList = signList;
            return View(crsList);
        }

        [Page]
        [Description("问卷调查")]
        public ActionResult Survey(Guid id)
        {
            IEnumerable<HR_Question> qstList = WMFactory.HRQuestion.GetAll();

            IEnumerable<HR_CourseLesson> Lensson = WMFactory.HRCourseLesson.GetAll();

            HR_CourseLesson CourseLesson = WMFactory.HRCourseLesson.GetById(id.ToString());

            ViewBag.CategoryRadio = qstList.Where(w => w.QsnType == "radio" && w.QsnSatisfactionType.Contains(CourseLesson.SatisfactionType))
                                                 .OrderBy(w => w.QsnCategory).Distinct().Select(f => f.QsnCategory).Distinct();//按照条件获取问卷调查的题目选择

            ViewBag.CategoryText = qstList.Where(w => w.QsnType == "text" && w.QsnSatisfactionType.Contains(CourseLesson.SatisfactionType))
                                                 .OrderBy(w => w.QsnCategory).Distinct().Select(f => f.QsnCategory).Distinct();//按照条件获取问卷调查的题目文本

            ViewBag.QsnCount = qstList.Count(f => f.QsnType == "radio" && f.QsnSatisfactionType.Contains(CourseLesson.SatisfactionType));

            //ViewBag.QsnALL = qstList.Where(w => w.QsnType == "radio" && w.QsnSatisfactionType.Contains(CourseLesson.SatisfactionType));//获取所有类别的题目

            return View(qstList);
        }

        [Page]
        [Description("是否能评价")]
        [HttpPost]
        public JsonResult CheckSurvey(Guid id)
        {
            Guid uid = Guid.Parse(CookieHelper.GetCookie("HRWXUid"));
            //HR_Course course = WMFactory.HRCourse.GetById(id.ToString());

            HR_CourseLesson CourseLesson = WMFactory.HRCourseLesson.GetById(id.ToString());

            if (CourseLesson == null)
                return Json(ResultMsg.Failure("课时不存在！"));
            if (CourseLesson.StartTime > DateTime.Now)
                return Json(ResultMsg.Failure("课时未开始无法评价！"));
            if (WMFactory.HRQARst.GetCount(f => f.Cid == id && f.Uid == uid) > 0)
            {
                return Json(ResultMsg.Failure("请勿重复评价！"));
            }
            return Json(ResultMsg.Success("OK"));
        }

        [Page]
        [Description("提交数据")]
        [HttpPost]
        public JsonResult SumitQA(Guid id, List<HR_QARst> rstList)
        {
            Guid uid = Guid.Parse(CookieHelper.GetCookie("HRWXUid"));

            HR_CourseLesson CourseLesson = WMFactory.HRCourseLesson.GetById(id.ToString());
            id = CourseLesson.Cid;

            if (WMFactory.HRLKCourseUser.GetCount(f => f.Cid == id && f.Uid == uid) <= 0)
            {
                return Json(ResultMsg.Failure("未选择课程无法评价！"));
            }
            HR_Course course = WMFactory.HRCourse.GetById(id.ToString());
            if (course == null)
                return Json(ResultMsg.Failure("课程不存在！"));
            if (course.StartDate > DateTime.Now.Date)
                return Json(ResultMsg.Failure("课程未开始无法评价！"));

            if (WMFactory.HRQARst.GetCount(f => f.Cid == id && f.Uid == uid) > 0)
            {
                return Json(ResultMsg.Failure("请勿重复评价！"));
            }
            foreach (HR_QARst rst in rstList)
            {
                rst.Cid = id;
                rst.Uid = uid;
                rst.CreateUser = "Matrix";
                WMFactory.HRQARst.Insert(rst);
            }
            return Json(ResultMsg.Success("评价成功！"));
        }

        [Page]
        [Description("用户资料")]
        public ActionResult UserInfo()
        {
            Guid uid = Guid.Parse(CookieHelper.GetCookie("HRWXUid"));
            ViewBag.CrsCount = WMFactory.HRLKCourseUser.GetCount(f => f.Uid == uid);
            ViewBag.Score = WMFactory.HRCourseUser.TotalScore(uid);

            DataTable dtClassHour = WMFactory.HRCourseUser.ClassHour(uid);//获取课时总数

            ViewBag.ClassHour = dtClassHour.Rows[0][0];

            DataTable dt = WMFactory.HRCourseUser.AttendResult(uid);


            string zc = "0", zt = "0", cd = "0", qq = "0", qj = "0", qt = "0";//正常早退迟到缺勤
            foreach (DataRow dr in dt.Rows)
            {
                switch (dr[0].ToString())
                {
                    case "正常":
                        zc = dr[1].ToString();
                        break;
                    case "迟到":
                        cd = dr[1].ToString();
                        break;
                    case "早退":
                        zt = dr[1].ToString();
                        break;
                    case "缺勤":
                        qq = dr[1].ToString();
                        break;
                    case "请假":
                        qj = dr[1].ToString();
                        break;
                    case "其他":
                        qt = dr[1].ToString();
                        break;
                }
            }
            ViewBag.Zc = zc;
            ViewBag.Cd = cd;
            ViewBag.Zt = zt;
            ViewBag.Qq = qq;
            ViewBag.Qj = qj;
            ViewBag.Qt = qt;
            return View();
        }

        [Page]
        [Description("已选课程")]
        public ActionResult History()
        {
            Guid uid = Guid.Parse(CookieHelper.GetCookie("HRWXUid"));
            var courseList = WMFactory.HRLKCourseUser.GetCourseByUserId(uid);
            return View(courseList);
        }

        [Page]
        [Description("积分明细")]
        public ActionResult ScoreInfo()
        {
            Guid uid = Guid.Parse(CookieHelper.GetCookie("HRWXUid"));
            ViewBag.ScoreInfo = WMFactory.HRCourseUser.ScoreInfo(uid);
            return View();
        }

        //[Action]
        //[Description("课时下课")]
        //[HttpPost]
        //public JsonResult SignOut(Guid id)
        //{
        //    Guid uid = Guid.Parse(CookieHelper.GetCookie("HRWXUid"));
        //    IEnumerable<HR_CourseAttend> attList = WMFactory.HRCourseAttend.FindByConditions(null, f => f.Lid == id && f.Uid == uid);
        //    if (attList == null || attList.Count() <= 0)
        //    {
        //        return Json(ResultMsg.Failure("该课时无上课签！"));
        //    }
        //    if (attList.FirstOrDefault().ModifyTime != null)
        //    {
        //        return Json(ResultMsg.Failure("请勿重复签到！"));
        //    }
        //    HR_CourseAttend att = attList.FirstOrDefault();
        //    HR_CourseLesson lesson = WMFactory.HRCourseLesson.GetById(att.Lid.ToString());
        //    if (DateTime.Now > lesson.EndTime.AddMinutes(30))
        //    {
        //        return Json(ResultMsg.Failure("已下课30分钟,无效签到！"));
        //    }
        //    att.ModifyTime = DateTime.Now;
        //    att.ModifyUser = "Matrix";
        //    WMFactory.HRCourseAttend.Update(att);
        //    return Json(ResultMsg.Success("下课签成功"));
        //}

        [Page]
        [Description("课程签到")]
        public ActionResult SignIn(Guid id)
        {
            ResultMsg rst = new ResultMsg();
            HR_CourseLesson lesson = WMFactory.HRCourseLesson.GetById(id.ToString());
            if (lesson == null)
            {
                rst = ResultMsg.Failure("找不到课时信息！签到失败！");
                return View(rst);
            }
            //是否报名
            Guid uid = Guid.Parse(CookieHelper.GetCookie("HRWXUid"));
            int lkcu = WMFactory.HRLKCourseUser.GetCount(f => f.Cid == lesson.Cid && f.Uid == uid);
            if (lkcu <= 0)
            {
                rst = ResultMsg.Failure("该课程您没有报名，无法签到！");
                return View(rst);
            }
            ViewBag.Lsn = lesson;
            //已签到人数
            ViewBag.LsnSigned = WMFactory.HRCourseAttend.GetCount(f => f.Lid == id);
            //已报名人数
            ViewBag.CrsAttended = WMFactory.HRLKCourseUser.GetCount(f => f.Cid == lesson.Cid);

            HR_Course course = WMFactory.HRCourse.GetById(lesson.Cid.ToString());
            ViewBag.Crs = course;

            IEnumerable<HR_CourseAttend> attList = WMFactory.HRCourseAttend.FindByConditions(null, f => f.Lid == id && f.Uid == uid);
            //if (attList != null && attList.Count() > 0 && attList.FirstOrDefault().ModifyTime != null)
            //{
            //    rst = ResultMsg.Failure("该课时您的上下课签到已完成！");
            //    return View(rst);
            //}
            if (attList != null && attList.Count() > 0)
            {
                rst = ResultMsg.Failure("该课时您已签过到了！");
                return View(rst);
            }
            //判断当前时间是否可以签到，提前15分钟，开课后10分钟算正常
            if (DateTime.Now <= lesson.StartTime.AddMinutes(-120))
            {
                rst = ResultMsg.Failure("开课前2小时内才能签到！");
                return View(rst);
            }
            if (DateTime.Now > lesson.EndTime)
            {
                rst = ResultMsg.Failure("该课时已结束，无法签到！");
                return View(rst);
            }
            //签到
            HR_CourseAttend attend = new HR_CourseAttend();
            attend.Lid = id;
            attend.Uid = uid;

            attend.CreateTime = DateTime.Now;
            if (attend.CreateTime <= lesson.StartTime)
                attend.CreateUser = "正常";
            else if (attend.CreateTime <= lesson.StartTime.AddMinutes(30))
                attend.CreateUser = "迟到";
            else
                attend.CreateUser = "其他";

            WMFactory.HRCourseAttend.Insert(attend);
            return View(ResultMsg.Success("签到成功！"));
        }

        [Page]
        [Description("课程考勤")]
        [HttpPost]
        public PartialViewResult SignList(Guid id)
        {
            //判断该课程是否能选(开始时间，人数判断)
            Guid uid = Guid.Parse(CookieHelper.GetCookie("HRWXUid"));
            IEnumerable<V_HR_CourseSignRst> signList = WMFactory.HRCourseAttend.CourseSignHistory(o => o.OrderBy(s => s.StartTime), f => f.Cid == id && f.Uid == uid);
            return PartialView(signList);
        }

        #region Actions List

        [Action]
        [Description("课程报名")]
        [HttpPost]
        public JsonResult Choose(Guid id, string SignUpType)
        {

            if (SignUpType == "3")
            {
                string HRWXUName = (CookieHelper.GetCookie("HRWXUName"));

                if (WMFactory.HRSpecific.GetCount(f => f.CourseID == id && f.UserName == HRWXUName) == 0)
                {
                    return Json(ResultMsg.Failure("很抱歉,你不能报名这个课程！"));
                }
            }

            //判断该课程是否能选(开始时间，人数判断)
            HR_Course course = WMFactory.HRCourse.GetById(id.ToString());
            if (DateTime.Now.Date > course.StartDate)
            {
                return Json(ResultMsg.Failure("报名时间已过！"));
            }
            if (course.TrainingNum <= course.Users.Count())
            {
                return Json(ResultMsg.Failure("人数已满！"));
            }
            //判断是否已经选过
            Guid uid = Guid.Parse(CookieHelper.GetCookie("HRWXUid"));
            if (WMFactory.HRLKCourseUser.FindByConditions(null, f => f.Cid == id && f.Uid == uid).Count() > 0)
            {
                return Json(ResultMsg.Failure("该课程已报名！"));
            }
            //添加到选课
            HR_LK_CourseUser cu = new HR_LK_CourseUser();
            cu.Uid = uid;
            cu.Cid = id;
            cu.CreateUser = "Matrix";
            WMFactory.HRLKCourseUser.Insert(cu);
            return Json(ResultMsg.Success("报名成功！"));
        }

        [Action]
        [Description("取消报名")]
        [HttpPost]
        public JsonResult CancelChoose(Guid id)
        {
            //判断该课程是否能选(开始时间，人数判断)
            HR_Course course = WMFactory.HRCourse.GetById(id.ToString());
            if (DateTime.Now >= course.StartDate)
            {
                return Json(ResultMsg.Failure("课程已开,无法取消！"));
            }
            Guid uid = Guid.Parse(CookieHelper.GetCookie("HRWXUid"));
            WMFactory.HRLKCourseUser.Delete(f => f.Cid == id && f.Uid == uid);
            return Json(ResultMsg.Success("成功取消！"));
        }

        [Action]
        [Description("退出登录")]
        [HttpPost]
        public JsonResult LogOut()
        {
            CookieHelper.ClearCookie("HRWXUid");
            CookieHelper.ClearCookie("HRWXUName");
            return Json(ResultMsg.Success("退出成功！"));
        }

        #endregion
    }
}
