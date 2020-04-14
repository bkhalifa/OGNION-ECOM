

namespace Api.Model
{
    public class ShoppingCartModel
    {
        public int RecordId { get; set; }
        public string CartId { get; set; }
        public int Quantity { get; set; }
        public int ProductId { get; set; }
        public  System.DateTime DateCreated { get; set; }
    }
}
