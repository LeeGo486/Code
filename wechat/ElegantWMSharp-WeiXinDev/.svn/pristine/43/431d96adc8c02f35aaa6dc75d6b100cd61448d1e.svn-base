using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.GLWXSite
{
    public class GLWXSiteAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "GLWXSite";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "GLWXSite_default",
                "GLWXSite/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
