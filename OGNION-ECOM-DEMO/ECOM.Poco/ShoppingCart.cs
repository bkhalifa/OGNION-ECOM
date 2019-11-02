﻿using System;

namespace ECOM.Poco
{
    public partial class ShoppingCart
    {
        public int RecordId { get; set; }
        public string CartId { get; set; }
        public int Quantity { get; set; }
        public int ProductId { get; set; }
        public DateTime DateCreated { get; set; }

        public virtual Products Product { get; set; }
    }
}
