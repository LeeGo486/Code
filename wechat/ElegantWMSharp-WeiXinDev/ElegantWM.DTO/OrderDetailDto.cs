using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.DTO
{
    public class OrderDetailDto
    {
        public string id { get; set; }
        public string Stlid { get; set; }
        public string Deliverydate { get; set; }
        public string Number { get; set; }
        public string Price { get; set; }
        public string SellPrice { get; set; }
        public string Amount { get; set; }
    }
}
