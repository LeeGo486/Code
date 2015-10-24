using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElegantWM.DTO
{
    public class OrderHeadDto
    {
        public string RgUser { get; set; }
        public string Tel { get; set; }
        public string Deliverydate { get; set; }
        public string Amount { get; set; }
        public string Depotid { get; set; }
        public string Desp { get; set; }
        public List<OrderDetailDto> Detail { get; set; }
    }
}
