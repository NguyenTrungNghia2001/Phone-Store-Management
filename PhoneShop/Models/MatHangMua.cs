using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PhoneShop.Models
{
    public class MatHangMua
    {
            DBTHIETBIDIENTUEntities1 database = new DBTHIETBIDIENTUEntities1();
        public int ProductID { get; set; }
        public string NamePro { get; set; }
        public string ImagePro { get; set; }
        public double Price { get; set; }
        public int Quantity { get; set; }

        public double ThanhTien()
        {
            return Quantity*Price;
        }

        public MatHangMua(int ProductID)
        {
            this.ProductID = ProductID;
            var product = database.Products.Single(n => n.ProductID == this.ProductID);
            this.NamePro = product.NamePro;
            this.ImagePro = product.ImagePro;
            this.Price = double.Parse(product.Price.ToString());
            this.Quantity = 1;
        }
    }
}