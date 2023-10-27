using PhoneShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;

namespace PhoneShop.Controllers
{
    public class ItemShopController : Controller
    {
        // Use DbContext to manage database
        DBTHIETBIDIENTUEntities1 database = new DBTHIETBIDIENTUEntities1();
        private List<Product> LayProduct(int soluong)
        {
            // Sắp xếp sách theo ngày cập nhật giảm dần, lấy đúng số lượng sách cần
            // Chuyển qua dạng danh sách kết quả đạt được
            return database.Products.Take(soluong).ToList();
        }
        // GET: BookStore
        public ActionResult ListSPTrangChu()
        {
            var dsSanPham = LayProduct(5);
            return View(dsSanPham);
        }
        public ActionResult PhuKien()
        {
            var ip = database.Products.Where(n => n.Category == "5").Take(5).ToList();
            return PartialView(ip);
        }
        public ActionResult Laptop()
        {
            var ip = database.Products.Where(n => n.Category == "4").Take(5).ToList();
            return PartialView(ip);
        }
        public ActionResult Macbook()
        {
            var ip = database.Products.Where(n => n.Category == "3").Take(5).ToList();
            return PartialView(ip);
        }
        public ActionResult DienThoai()
        {

            var ip = database.Products.Where(n => n.ParentID == "1").Take(5).ToList();
            return PartialView(ip);
        }
        public ActionResult ProductCategory(int id, int? page)
        {
            int pageSize = 5;
            int pageNum = (page ?? 1);
            var lstProductCate = database.Products.Where(n => n.Category1.Id == id).ToList();
            return View(lstProductCate.ToPagedList(pageNum, pageSize));
        }
        public ActionResult ListCategory()
        {
            var lstCategory = database.Categories.ToList();
            return PartialView(lstCategory);
        }
        public ActionResult Details(int id)
        {
            var product = database.Products.FirstOrDefault(n => n.ProductID == id);
            return View(product);
        }
    }
}