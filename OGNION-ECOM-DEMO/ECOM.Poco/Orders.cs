using System;
using System.Collections.Generic;

namespace ECOM.Poco
{
    public partial class Orders
    {
        public Orders()
        {
            OrderDetails = new HashSet<OrderDetails>();
        }

        public int OrderId { get; set; }
        public string CustomerName { get; set; }
        public DateTime OrderDate { get; set; }
        public DateTime ShipDate { get; set; }

        public virtual ICollection<OrderDetails> OrderDetails { get; set; }
    }
}
