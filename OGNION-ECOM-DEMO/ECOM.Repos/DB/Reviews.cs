using System;
using System.Collections.Generic;

namespace ECOM.Repos.DB
{
    public partial class Reviews
    {
        public int ReviewId { get; set; }
        public int ProductId { get; set; }
        public string CustomerName { get; set; }
        public string CustomerEmail { get; set; }
        public int Rating { get; set; }
        public string Comments { get; set; }

        public virtual Products Product { get; set; }
    }
}
