using ElegantWM.Factory;
using ElegantWM.WebUI.Areas.Matrix;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    /*temp 临时*/
    public class S3_Customer{
        public S3_Customer(string _n, string _t,string last)
        {
            name = _n;
            telphone = _t;
            lastbuy = last;
        }
        public string name { get; set; }
        public string telphone { get; set; }
        public string lastbuy { get; set; }
    }


    public class CustomerController : BaseMatrixS3Controller
    {
        //
        // GET: /S3/Customer/

        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("销售分析图标")]
        public PartialViewResult SaleAnalysisCharts()
        {
            return PartialView();
        }

        [Action]
        [Description("我的任务")]
        public PartialViewResult MyTasks()
        {
            return PartialView();
        }

        [Action]
        [Description("客户详细")]
        [HttpPost]
        public PartialViewResult CustomerDetail()
        {
            return PartialView();
        }

        [Action]
        [Description("客户消费记录")]
        [HttpPost]
        public PartialViewResult CustomerConsume()
        {
            return PartialView();
        }

        [Action]
        [Description("客户订单明细")]
        [HttpPost]
        public PartialViewResult CustomerOrderDetail()
        {
            return PartialView();
        }

        [Action]
        [Description("预约客户名单")]
        [HttpPost]
        public PartialViewResult CustomerAppointment()
        {
            return PartialView();
        }

        [Action]
        [Description("成衣维修列表")]
        [HttpPost]
        public PartialViewResult CustomerRepair()
        {
            return PartialView();
        }

        [Action]
        [Description("服务支持")]
        [HttpPost] 
        public PartialViewResult ServiceSupport()
        {
            return PartialView();
        }

        [Action]
        [Description("客户资料")]
        public PartialViewResult CustomerList(string name="")
        {
            List<S3_Customer> cusList = new List<S3_Customer>();
            cusList.Add(new S3_Customer("欧阳雪梅", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("严志勤", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("蔡小芳", "13900000668", "2014-06-04"));
            cusList.Add(new S3_Customer("郭莹", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("张雪", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("杨秀丽", "13900000668", "2014-06-04"));
            cusList.Add(new S3_Customer("刘丽莎", "13900000668", "2014-06-05"));
            cusList.Add(new S3_Customer("惠巧利", "13900000668", "2014-06-03"));
            cusList.Add(new S3_Customer("王永兰", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("陈桂连", "13900000668", "2014-06-04"));
            cusList.Add(new S3_Customer("喻丹", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("周鸥", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("王金玉", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("高明", "13900000668", "2014-06-03"));
            cusList.Add(new S3_Customer("施美玲", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("谢莉莉", "13900000668", "2014-06-04"));
            cusList.Add(new S3_Customer("宋连香", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("黄友菊", "13900000668", "2014-06-05"));
            cusList.Add(new S3_Customer("张金霞", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("夏敏", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("陈小旋", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("连小鹏", "13900000668", "2014-06-04"));
            cusList.Add(new S3_Customer("李影", "13900000668", "2014-06-04"));
            cusList.Add(new S3_Customer("陈静", "13900000668", "2014-06-04"));
            cusList.Add(new S3_Customer("周美玉", "13900000668", "2014-06-05"));
            cusList.Add(new S3_Customer("王慧慧", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("张俊", "13900000668", "2014-06-04"));
            cusList.Add(new S3_Customer("俞美娟", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("赖妙如", "13900000668", "2014-06-05"));
            cusList.Add(new S3_Customer("陈蕾", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("陈颖", "13900000668", "2014-06-03"));
            cusList.Add(new S3_Customer("陈玉清", "13900000668", "2014-06-05"));
            cusList.Add(new S3_Customer("田芳", "13900000668", "2014-06-05"));
            cusList.Add(new S3_Customer("陈光琼", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("刘爱荣", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("冯艳", "13900000668", "2014-06-05"));
            cusList.Add(new S3_Customer("姜爱武", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("赖群群", "13900000668", "2014-06-03"));
            cusList.Add(new S3_Customer("白雪", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("李俸清", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("曹平", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("尤小琴", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("陈美卿", "13900000668", "2014-06-04"));
            cusList.Add(new S3_Customer("高映萍", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("张利群", "13900000668", "2014-06-03"));
            cusList.Add(new S3_Customer("薛政霞", "13900000668", "2014-06-04"));
            cusList.Add(new S3_Customer("徐莉", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("崔南苑", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("任小芳", "13900000668", "2014-06-04"));
            cusList.Add(new S3_Customer("孙玉红", "13900000668", "2014-06-03"));
            cusList.Add(new S3_Customer("张琳", "13900000668", "2014-06-02"));
            cusList.Add(new S3_Customer("徐岩", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("武敏", "13900000668", "2014-06-01"));
            cusList.Add(new S3_Customer("方英", "13900000668", "2014-06-03"));
            cusList.Add(new S3_Customer("梁小宏", "13900000668", "2014-06-04"));
            cusList.Add(new S3_Customer("俞莹", "13900000668", "2014-06-05"));
            
            if (string.IsNullOrEmpty(name))
                return PartialView(cusList);
            else
                return PartialView(cusList.Where(f => f.name.Contains(name)).ToList());
        }
    }
}
