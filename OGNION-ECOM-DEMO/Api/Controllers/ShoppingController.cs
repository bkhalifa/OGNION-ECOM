
using Api.Model;
using ECOM.Repos.DB;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ShoppingController : ControllerBase
    {

        [HttpPost]
        [Route("postshoppingcard")]
        public IActionResult PostProduct(ShoppingCartModel model)
        {
            using(var _ctx = new COMMERCEContext())
            {
                var shoppingCart = new ShoppingCart
                {
                    DateCreated = System.DateTime.Now,
                    ProductId = model.ProductId,
                    Quantity = model.Quantity,
                    CartId = model.CartId
                    
                };
                _ctx.Add(shoppingCart);
                _ctx.SaveChanges();
            }
            
            return Ok("");
        }
    }
}