using ElegantWM.Common;
using ElegantWM.DTO;
using ElegantWM.Factory;
using ElegantWM.WebUI.Areas.Matrix;
using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.S3.Controllers
{
    public class StoreCheckController : BaseMatrixS3Controller
    {
        /*temp 临时*/
        public class S3_Depot
        {
            public S3_Depot(string _id, string _company, string _depotName, Int32 _target, Int32 _saleAccount, decimal _completeRate, decimal _increaseRate)
            {
                ID = _id;
                DepotName = _depotName;
                Company = _company;
                Target = _target;
                SaleAccount = _saleAccount;
                CompleteRate = _completeRate;
                IncreaseRate = _increaseRate;
            }
            public string ID { get; set; }
            public string DepotName { get; set; }
            public string Company { get; set; }
            public Int32 Target { get; set; }
            public Int32 SaleAccount { get; set; }
            public decimal CompleteRate { get; set; }
            public decimal IncreaseRate { get; set; }
        }


        public class S3_DepotEmployee
        {
            public S3_DepotEmployee(string _name, string _companyAge, string _target, string _complete, decimal _completeRate, string _salary, string _capacity, string _imgUrl)
            {
                Name = _name;
                CompanyAge = _companyAge;
                Target = _target;
                Complete = _complete;
                CompleteRate = _completeRate;
                Salary = _salary;
                Capacity = _capacity;
                ImgUrl = _imgUrl;
            }
            public string Name { get; set; }
            public string CompanyAge { get; set; }
            public string Target { get; set; }
            public string Complete { get; set; }
            public decimal CompleteRate { get; set; }
            public string Salary { get; set; }
            public string Capacity { get; set; }
            public string ImgUrl { get; set; }
        }

        public class S3_CheckList
        {
            public S3_CheckList(string _employee, string _checkTime, string _suggest)
            {
                Employee = _employee;
                CheckTime = _checkTime;
                Suggest = _suggest;
            }
            public string Employee { get; set; }
            public string CheckTime { get; set; }
            public string Suggest { get; set; }
        }

        //
        // GET: /S3/StoreCheck/

        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("店铺信息")]
        public PartialViewResult DepotList(string type = "")
        {
            List<S3_Depot> depotList = new List<S3_Depot>();
            depotList.Add(new S3_Depot("0002", "浙江分公司", "温岭万寿路店", 390000, 337226, (decimal)0.864682051282051, (decimal)-0.145962756514318));
            depotList.Add(new S3_Depot("0003", "华北零售", "临沂和谐广场MALL", 350000, 284767, (decimal)0.81362, (decimal)-0.143516680501919));
            depotList.Add(new S3_Depot("0001", "江苏分公司", "无锡八佰伴", 500000, 435157, (decimal)0.870314, (decimal)-0.141478649273578));
            depotList.Add(new S3_Depot("0004", "华南零售", "东莞专卖", 1200000, 1011282, (decimal)0.842735, (decimal)-0.137069551059973));
            depotList.Add(new S3_Depot("0005", "西南零售", "重庆时代天街购物广场MALL", 100000, 77745, (decimal)0.77745, (decimal)-0.135484660120762));
            depotList.Add(new S3_Depot("0006", "上海分公司", "上海安信商业广场MALL", 400000, 448674, (decimal)1.121685, (decimal)-0.123914592831968));
            depotList.Add(new S3_Depot("0007", "上海分公司", "上海虹桥友谊商城", 250000, 250308, (decimal)1.001232, (decimal)-0.117035761907113));
            depotList.Add(new S3_Depot("0008", "北京分公司", "北京百盛", 350000, 292337, (decimal)0.835248571428571, (decimal)-0.114597151804806));
            depotList.Add(new S3_Depot("0009", "上海分公司", "上海八佰伴", 1800000, 1803239, (decimal)1.00179944444444, (decimal)0.0136051286231029));
            depotList.Add(new S3_Depot("00010", "华北零售", "天津塘沽区生活馆", 700000, 700381, (decimal)1.00054428571429, (decimal)0.0171145345020882));
            depotList.Add(new S3_Depot("00011", "浙江分公司", "杭州解百", 370000, 370179, (decimal)1.00048378378378, (decimal)0.0186263448997002));
            depotList.Add(new S3_Depot("00012", "东北零售", "沈阳新玛特", 750000, 753561, (decimal)1.004748, (decimal)0.0287578362202658));
            depotList.Add(new S3_Depot("00013", "华南零售", "厦门信达免税商场", 550000, 552404, (decimal)1.00437090909091, (decimal)0.0354510065020712));
            depotList.Add(new S3_Depot("00014", "西北区", "西安咸阳机场T2店", 450000, 478117, (decimal)1.06248222222222, (decimal)0.138151598973534));
            depotList.Add(new S3_Depot("00015", "西南零售", "成都青羊大道店", 500000, 576290, (decimal)1.15258, (decimal)0.138253935961982));
            depotList.Add(new S3_Depot("00016", "浙江分公司", "余姚南雷路店", 550000, 665437, (decimal)1.20988545454545, (decimal)0.222072853824045));
            depotList.Add(new S3_Depot("00017", "西南零售", "重庆大都会广场MALL", 1000000, 1000424, (decimal)1.000424, (decimal)0.22648175891213));
            depotList.Add(new S3_Depot("00018", "西北区", "西安世纪金花赛高店", 600000, 492758, (decimal)0.821264166666667, (decimal)0.231803248854712));
            depotList.Add(new S3_Depot("00019", "江苏分公司", "昆山商厦", 380000, 577902, (decimal)1.52079578947368, (decimal)1.05489341018083));
            depotList.Add(new S3_Depot("00020", "西北区", "西安开元商城", 900000, 1784384, (decimal)1.98264888888889, (decimal)1.40674390688013));


            depotList.Add(new S3_Depot("000111", "浙江分公司", "温岭万寿路店", 390000, 337226, (decimal)0.864682051282051, (decimal)-0.145962756514318));
            depotList.Add(new S3_Depot("000112", "华北零售", "临沂和谐广场MALL", 350000, 284767, (decimal)0.81362, (decimal)-0.143516680501919));
            depotList.Add(new S3_Depot("000113", "江苏分公司", "无锡八佰伴", 500000, 435157, (decimal)0.870314, (decimal)-0.141478649273578));
            depotList.Add(new S3_Depot("000114", "华南零售", "东莞专卖", 1200000, 1011282, (decimal)0.842735, (decimal)-0.137069551059973));
            depotList.Add(new S3_Depot("000115", "西南零售", "重庆时代天街购物广场MALL", 100000, 77745, (decimal)0.77745, (decimal)-0.135484660120762));
            depotList.Add(new S3_Depot("000116", "上海分公司", "上海安信商业广场MALL", 400000, 448674, (decimal)1.121685, (decimal)-0.123914592831968));
            depotList.Add(new S3_Depot("000117", "上海分公司", "上海虹桥友谊商城", 250000, 250308, (decimal)1.001232, (decimal)-0.117035761907113));
            depotList.Add(new S3_Depot("000118", "北京分公司", "北京百盛", 350000, 292337, (decimal)0.835248571428571, (decimal)-0.114597151804806));


            if (!string.IsNullOrEmpty(type) && type.ToUpper() == "NoComplete".ToUpper())
            {
                return PartialView(depotList.Where(f => f.IncreaseRate < 0).ToList());
            }
            else
            {
                return PartialView(depotList);
            }
        }


        [Action]
        [Description("店铺人员信息")]
        public PartialViewResult DepotEmployeeList(string type = "")
        {
            List<S3_DepotEmployee> depotEmployeeList = new List<S3_DepotEmployee>();
            depotEmployeeList.Add(new S3_DepotEmployee("徐艳琼", "9", "50,000元", "50,500元", (decimal)1.01, "8,765元", "4.8", "/Areas/S3/Resources/images/hr01.png"));
            depotEmployeeList.Add(new S3_DepotEmployee("陈慧珊", "4", "40,000元", "50,500元", (decimal)1.01, "5,585元", "4.2", "/Areas/S3/Resources/images/hr02.png"));
            depotEmployeeList.Add(new S3_DepotEmployee("黄秋娜", "2", "40,000元", "19,600元", (decimal)0.49, "3,245元", "3.2", "/Areas/S3/Resources/images/hr03.png"));
            depotEmployeeList.Add(new S3_DepotEmployee("陈小芳", "1", "30,000元", "10,200元", (decimal)0.34, "2,776元", "2.7", "/Areas/S3/Resources/images/hr04.png"));

            return PartialView(depotEmployeeList);
        }

        [Action]
        [Description("巡店记录")]
        public PartialViewResult CheckList()
        {
            @ViewBag.UserName = GetUserName();
            List<S3_CheckList> checkList = new List<S3_CheckList>();
            checkList.Add(new S3_CheckList("黄秋娜", "2014-07-01", "1、6S需要加强。<p>2、橱窗的陈列需要调整一下，要更加时尚一些。</p>"));
            checkList.Add(new S3_CheckList("陈小芳", "2014-04-12", "1、6S需要加强。<br />2、店内人员的服务意识比较好，可以向别的店做一些推广。<br />3、店铺灯光布局较好。"));

            return PartialView(checkList);
        }

        [Action]
        [Description("获取用户信息")]
        public string GetUserName()
        {
            //CertificateDto cer = AuthToken.CurrentUserByTid(WMFactory.WXLKFansC3AM.GetCurrentAMUser(Guid.Parse(Request["sid"]), Request["oid"]).TokenId.ToString());
            //return cer.UserName;
            return "黄秋娜";
        }

    }
}
