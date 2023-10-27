using PhoneShop.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using System.Data.Entity.Validation;


namespace PhoneShop.Controllers
{
    public class NguoiDungController : Controller
    {
        // GET: NguoiDung
        DBTHIETBIDIENTUEntities1 database = new DBTHIETBIDIENTUEntities1();
        Customer nguoiDung = System.Web.HttpContext.Current.Session["TaiKhoan"] as Customer;
        public ActionResult ThongTinNguoiDung()
        {
            Customer nguoiDung = (Customer)Session["TaiKhoan"];
            return View(database.Customers.Where(s => s.IDCus == nguoiDung.IDCus).FirstOrDefault());
        }
        [HttpGet]
        public ActionResult DangKy()
        {
            return View();
        }

        [HttpPost]
        public ActionResult DangKy(Customer cus)
        {
 

            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(cus.NameCus))
                    ModelState.AddModelError(string.Empty, "Họ tên không được để trống");
                if (string.IsNullOrEmpty(cus.Login))
                    ModelState.AddModelError(string.Empty, "Tên Đăng Nhập không được để trống");
                if (string.IsNullOrEmpty(cus.PassCus))
                    ModelState.AddModelError(string.Empty, "Mật khẩu không được để trống");
                if (string.IsNullOrEmpty(cus.EmailCus))
                    ModelState.AddModelError(string.Empty, "Email không được để trống");
                if (string.IsNullOrEmpty(cus.PhoneCus))
                    ModelState.AddModelError(string.Empty, "Số điện thoại không được để trống");
                var khachhang = database.Customers.FirstOrDefault(k => k.Login == cus.Login);
                if (khachhang != null)
                    ModelState.AddModelError(string.Empty, "Đã có người dăng ký tên này");

                if(ModelState.IsValid)
                {
                    database.Customers.Add(cus);
                    database.SaveChanges();
                }
                else
                {
                    return View();
                }
            }
            return RedirectToAction("DangNhap");
        }

        [HttpGet]
        public ActionResult DangNhap()
        {
            return View();
        }

        [HttpPost]
        public ActionResult DangNhap(Customer cus)
        {
            if(ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(cus.Login))
                    ModelState.AddModelError(string.Empty, "Tên đăng nhập không được để trống");
                if (string.IsNullOrEmpty(cus.PassCus))
                    ModelState.AddModelError(string.Empty, "Mật khẩu không được để trống");
                if (ModelState.IsValid)
                {
                    var khach = database.Customers.FirstOrDefault(k => k.Login == cus.Login && k.PassCus == cus.PassCus);
                    if (khach != null)
                    {
                        ViewBag.ThongBao = "Đăng nhập thành công";
                        Session["NameCus"] = khach.NameCus;
                        Session["TaiKhoan"] = khach;
                        Session["IDCus"] = khach.IDCus;
                        return RedirectToAction("ListSPTrangChu", "ItemShop");
                    }
                    else

                        ViewBag.ThongBao = "Tên đăng nhập hoặc mật khẩu không đúng";
                } 
            }
            return View();
        }
        public ActionResult Logout()
        {
            Session.Abandon();
            return RedirectToAction("ListSPTrangChu", "ItemShop");
        }


        [HttpPost]
        public ActionResult CapNhatThongTinCaNhan(Customer nguoiDung)
        {
            //if(ModelState.IsValid)
            try
            {
                //nguoiDung.ConfirmPass = nguoiDung.Password;
                database.Entry(nguoiDung).State = EntityState.Modified;
                database.SaveChanges();
                Session["TaiKhoan"] = nguoiDung;
                return RedirectToAction("ThongTinNguoiDung", new { id = nguoiDung.IDCus });
            }
            catch (DbEntityValidationException e)
            {
                string a = "";
                foreach (var eve in e.EntityValidationErrors)
                {
                    a += ("Entity of type \"{0}\" in state \"{1}\" has the following validation errors:",
                        eve.Entry.Entity.GetType().Name, eve.Entry.State) + "\n";
                    foreach (var ve in eve.ValidationErrors)
                    {
                        a += ("- Property: \"{0}\", Error: \"{1}\"",
                            ve.PropertyName, ve.ErrorMessage) + "\n";
                    }
                }
                //throw;
                return Content(a);
            }
        }
        public ActionResult LichSuDonHang()
        {

            var LSDonHang = database.OrderProes.Where(n => n.IDCus == nguoiDung.IDCus).ToList();
            return View(LSDonHang);
        }

    }
}