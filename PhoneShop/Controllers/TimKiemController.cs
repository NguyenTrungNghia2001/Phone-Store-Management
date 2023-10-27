using PagedList;
using PhoneShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace PhoneShop.Controllers
{
    public class TimKiemController : Controller
    {
        // GET: TimKiem
        DBTHIETBIDIENTUEntities1 db = new DBTHIETBIDIENTUEntities1();
        [HttpGet]
        public ActionResult KQTimKiem(string sTuKhoa, int? page)
        {
            if (Request.HttpMethod != "GET")
            {
                page = 1;
            }
            int pageSize = 10;
            int pageNum = (page ?? 1);
            var lstSP = db.Products.Where(n => n.NamePro.Contains(sTuKhoa));
            ViewBag.TuKhoa = sTuKhoa;
            return View(lstSP.OrderBy(n => n.NamePro).ToPagedList(pageNum, pageSize));
        }
        [HttpPost]
        public ActionResult LayTuKhoaTimKiem(string sTuKhoa)
        {
            return RedirectToAction("KQTimKiem", new {@sTuKhoa= sTuKhoa});
        }
    }
}