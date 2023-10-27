using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PhoneShop.Models;

namespace PhoneShop.Controllers
{
    public class GioHangController : Controller
    {
        // GET: GioHang
        public ActionResult Index()
        {
            return View();
        }
        public List<MatHangMua> LayGioHang()
        {
            List<MatHangMua> gioHang = Session["GioHang"] as List<MatHangMua>;
            if( gioHang == null)
            {
                gioHang = new List<MatHangMua>();
                Session["GioHang"] = gioHang;
            }
            return gioHang;
        }
        public ActionResult ThemSanPhamVaoGio(int ProductID)
        {
            List<MatHangMua> gioHang = LayGioHang();
            MatHangMua sanPham = gioHang.FirstOrDefault(s => s.ProductID == ProductID);
            if(sanPham == null)
            {
                sanPham = new MatHangMua(ProductID);
                gioHang.Add(sanPham);
            }
            else
            {
                sanPham.Quantity++;
            }
            return RedirectToAction("Details", "ItemShop", new { id = ProductID });
        }
        private double TinhTongSL()
        {
            double tongSL = 0;
            List<MatHangMua> gioHang = LayGioHang();
            if (gioHang != null)
                tongSL = gioHang.Sum(n => n.Quantity);
            return tongSL;
        }
        private double TinhTongTien()
        {
            double TongTien = 0;
            List<MatHangMua> gioHang = LayGioHang();
            if (gioHang != null)
                TongTien = gioHang.Sum(n => n.ThanhTien());
            return TongTien;
        }
        public ActionResult HienThiGioHang()
        {
            List<MatHangMua> gioHang = LayGioHang();
            if(gioHang == null || gioHang.Count == 0)
            {
                return RedirectToAction("GioHangRong", "GioHang");
            }
            ViewBag.TongSL = TinhTongSL();
            ViewBag.TongTien = TinhTongTien();
            return View(gioHang);
        }
        public ActionResult GioHangPartial()
        {
            ViewBag.TongSL = TinhTongSL();
            ViewBag.TongTien = TinhTongTien();
            return PartialView();
        }
        public ActionResult XoaMatHang(int MaSP)
        {
            List<MatHangMua> gioHang = LayGioHang();
            var sanpham = gioHang.FirstOrDefault(s => s.ProductID == MaSP);
            if(sanpham != null)
            {
                gioHang.RemoveAll(s => s.ProductID == MaSP);
                return RedirectToAction("HienThiGioHang");
            }
            if (gioHang.Count == 0)
                return RedirectToAction("GioHangRong");
            return RedirectToAction("HienThiGioHang");
        }
        public ActionResult CapNhatMatHang(int MaSP, int SoLuong)
        {
            List<MatHangMua> gioHang = LayGioHang();
            var sanpham = gioHang.FirstOrDefault(s => s.ProductID == MaSP);
            if(sanpham != null)
            {
                sanpham.Quantity = SoLuong;
            }
            return RedirectToAction("HienThiGioHang");
        }
        public ActionResult GioHangRong()
        {
            return View();
        }

        public ActionResult DatHang()
        {
            if (Session["TaiKhoan"] == null)
                return RedirectToAction("DangNhap", "NguoiDung");
            List<MatHangMua> gioHang = LayGioHang();
            if (gioHang == null || gioHang.Count == 0)
                return RedirectToAction("ListSPTrangChu", "ItemShop");
            ViewBag.TongSL = TinhTongSL();
            ViewBag.TongTien = TinhTongTien();
            return View(gioHang);
        }

            DBTHIETBIDIENTUEntities1 database = new DBTHIETBIDIENTUEntities1();
        public ActionResult DongYDatHang()
        {
            Customer cus = Session["TaiKhoan"] as Customer;
            List<MatHangMua> gioHang = LayGioHang();

            OrderPro DonHang = new OrderPro();
            DonHang.IDCus = cus.IDCus;
            DonHang.DateOrder = DateTime.Now;
            DonHang.Trigia = (decimal)TinhTongTien();
            DonHang.Dagiao = false;
            DonHang.TenNguoiNhan = cus.NameCus;
            DonHang.AddressDeliverry = cus.AddCus;
            DonHang.DienThoaiNhan = cus.PhoneCus;
            DonHang.HTThanhToan = false;
            DonHang.HTGiaoHang = false;

            database.OrderProes.Add(DonHang);
            database.SaveChanges();

            foreach (var sanpham in gioHang)
            {
                OrderDetail chitiet = new OrderDetail();
                chitiet.IDOrder = DonHang.ID;
                chitiet.IDProduct = sanpham.ProductID;
                chitiet.Quantity = sanpham.Quantity;
                chitiet.UnitPrice = (decimal)sanpham.Price;
                database.OrderDetails.Add(chitiet);

            }
            database.SaveChanges();

            Session["GioHang"] = null;
            return RedirectToAction("HoanThanhDonHang");
        }

        public ActionResult HoanThanhDonHang()
        {
            return View();
        }
    }
}