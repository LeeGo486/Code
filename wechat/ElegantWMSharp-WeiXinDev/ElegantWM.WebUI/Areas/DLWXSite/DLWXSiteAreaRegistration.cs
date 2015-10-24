using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.DLWXSite
{
    public class DLWXSiteAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "DLWXSite";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "DLWXSite_default",
                "DLWXSite/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
