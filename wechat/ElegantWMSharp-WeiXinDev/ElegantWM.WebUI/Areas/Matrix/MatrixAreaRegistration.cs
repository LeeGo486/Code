using System.Web.Mvc;

namespace ElegantWM.WebUI.Areas.Matrix
{
    public class MatrixAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Matrix";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Matrix_default",
                "Matrix/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
