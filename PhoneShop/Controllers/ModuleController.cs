using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhoneShop.Controllers
{
    public class ModuleController : Controller
    {
        // GET: Module
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Slideshow()
        {
            return View("Slideshow");
        }
    }
}