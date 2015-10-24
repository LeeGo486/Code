using ElegantWM.Factory;
using ElegantWM.Tools;
using System;
using System.Collections.Generic;
using System.Data;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.Game.Controllers
{
    public class FireKnowledgeController : Controller
    {
        //
        // GET: /Game/FireKnowledge/

        
        public ActionResult Index()
        {
            return View();
        }

        [Action]
        [Description("游戏页面")]
        public ActionResult goFireGamePage()
        {
            return View();
        }

        [Action]
        [Description("加载题目")]
        public string getQuestionInfo(string TntId)
        {
            DataTable dtQuesAll = WMFactory.Fire_Question.FireKnowLedgeInfo(TntId);
            DataTable dtQuesHead = WMFactory.Fire_Question.FireKnowLedgeHead(TntId);

            dtQuesAll.TableName = "dtQuesAll";
            dtQuesHead.TableName = "dtQuesHead";
            DataSet ds = new DataSet();

            ds.Tables.Add(dtQuesAll);
            ds.Tables.Add(dtQuesHead);

            string jsonStr = JsonHelper.ToJson(ds);//"]"
            return jsonStr;
        }

    }
}
