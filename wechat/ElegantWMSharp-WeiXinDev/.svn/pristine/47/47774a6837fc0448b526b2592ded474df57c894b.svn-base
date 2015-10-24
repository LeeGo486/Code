using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.S3
{
    public class S3AreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "S3";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "S3_default",
                "S3/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
