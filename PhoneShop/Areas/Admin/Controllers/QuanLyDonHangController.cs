using PhoneShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Web.UI;
using PagedList;
using System.Net;
using System.IO;
using System.Web.Services.Description;
using System.Data.Entity;

namespace PhoneShop.Areas.Admin.Controllers
{
    public class QuanLyDonHangController : Controller
    {
        // GET: Admin/QuanLyDonHang
        private DBTHIETBIDIENTUEntities1 db = new DBTHIETBIDIENTUEntities1();
        public ActionResult Index(int? page)
        {
            var item = db.OrderProes.OrderByDescending(x => x.DateOrder).ToList();
            if(page == null)
            {
                page = 1;
            }
            var pageNumber = page ?? 1;
            var pageSize = 10;
            ViewBag.PageSize = pageSize;
            ViewBag.Page = pageNumber;
            return View(item.ToPagedList(pageNumber,pageSize));
        }
        public List<MatHangMua> LayGioHang()
        {
            List<MatHangMua> gioHang = Session["GioHang"] as List<MatHangMua>;
            if (gioHang == null)
            {
                gioHang = new List<MatHangMua>();
                Session["GioHang"] = gioHang;
            }
            return gioHang;
        }

        public ActionResult HienThiDonHang(int id)
        {
            var item = db.OrderProes.Find(id);
            return View(item);
        }

        [HttpPost]
        public ActionResult UpdateTT(int id, bool trangthai)
        {
            var item= db.OrderProes.Find(id); 
            if (item != null) 
            {
                db.OrderProes.Attach(item);
                item.Dagiao = trangthai;
                db.Entry(item).Property(x => x.Dagiao).IsModified = true;
                db.SaveChanges();
                return Json(new { message = "Success", Success = true });

            }
            return Json(new { message = "Unsuccess", Success = false });
        }
        public ActionResult UpdateTTrang(int id, bool TTrang)
        {
            var item = db.OrderProes.Find(id);
            if (item != null)
            {
                db.OrderProes.Attach(item);
                item.TTrang = TTrang;
                db.Entry(item).Property(x => x.TTrang).IsModified = true;
                db.SaveChanges();
                return Json(new { message = "Success", Success = true });

            }
            return Json(new { message = "Unsuccess", Success = false });
        }
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            OrderPro orderPro = db.OrderProes.Find(id);
            if (orderPro == null)
            {
                return HttpNotFound();
            }
            ViewBag.IDCus = new SelectList(db.Customers, "IDCus", "NameCus", orderPro.IDCus);
            return View(orderPro);
        }

        // POST: Admin/OrderProes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,DateOrder,IDCus,AddressDeliverry,Trigia,Ngaygiaohang,Dagiao,TenNguoiNhan,DienThoaiNhan,HTThanhToan,HTGiaoHang,TTrang")] OrderPro orderPro)
        {
            if (ModelState.IsValid)
            {
                db.Entry(orderPro).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IDCus = new SelectList(db.Customers, "IDCus", "NameCus", orderPro.IDCus);
            return View(orderPro);
        }

    }

}