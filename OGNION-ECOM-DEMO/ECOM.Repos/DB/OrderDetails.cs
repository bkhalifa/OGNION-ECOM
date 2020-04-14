using System;
using System.Collections.Generic;

namespace ECOM.Repos.DB
{
    public partial class OrderDetails
    {
        public int Id { get; set; }
        public int? OrderId { get; set; }
        public int? ProductId { get; set; }
        public int? Quantity { get; set; }
        public decimal? UnitCost { get; set; }

        public virtual Orders Order { get; set; }
    }
}
