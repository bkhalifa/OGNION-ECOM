using System;
using System.Collections.Generic;

namespace ECOM.Repos.DB
{
    public partial class Products
    {
        public Products()
        {
            Reviews = new HashSet<Reviews>();
            ShoppingCart = new HashSet<ShoppingCart>();
        }

        public int ProductId { get; set; }
        public int CategoryId { get; set; }
        public string ModelNumber { get; set; }
        public string ModelName { get; set; }
        public string ProductImage { get; set; }
        public decimal UnitCost { get; set; }
        public string Description { get; set; }

        public virtual Categories Category { get; set; }
        public virtual ICollection<Reviews> Reviews { get; set; }
        public virtual ICollection<ShoppingCart> ShoppingCart { get; set; }
    }
}
