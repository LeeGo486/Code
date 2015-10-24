using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.NPaia
{
    public class NPaiaAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "NPaia";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "NPaia_default",
                "NPaia/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
