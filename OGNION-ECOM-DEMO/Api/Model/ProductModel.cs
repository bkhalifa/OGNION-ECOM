

namespace Api.Model
{
    public class ProductModel
    {
        public int ProductId { get; set; }
        public int CategoryId { get; set; }
        public string ModelNumber { get; set; }
        public string ModelName { get; set; }
        public string ProductImage { get; set; }
        public decimal UnitCost { get; set; }
        public string Description { get; set; }
    }
}
