using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataObjectLayer
{
    public class Product
    {
        public string ProductID { get; set; }
        public string ProductName { get; set; }
        public decimal pirice { get; set; }
        public DateTime DateReceived { get; set; }
        public decimal weight { get; set; }
        public decimal Dimension { get; set; }
        public string Description { get; set; }
        public int Qoh { get; set; }
        public bool Active { get; set; }
        public int SupplierId { get; set; }

    }
}
