
using Api.Model;
using ECOM.Repos.DB;
using Microsoft.AspNetCore.Mvc;
using System.Linq;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ShoppingController : ControllerBase
    {

        [HttpPost]
        [Route("postshopping")]
        public IActionResult PostProduct(ShoppingCartModel model)
        {
            using(var _ctx = new COMMERCEContext())
            {
                var existingProduct = _ctx.
                    ShoppingCart.
                    Where(s => s.ProductId == model.ProductId  && s.CartId == model.CartId)
                   .FirstOrDefault();

                if(existingProduct != null)
                {
                    var upshoppingCart = new ShoppingCart
                    {
                        DateCreated = System.DateTime.Now,
                        ProductId = model.ProductId,
                        Quantity = model.Quantity +1,
                        CartId = model.CartId
                        
                    };
                    _ctx.ShoppingCart.Update(upshoppingCart);
                    _ctx.SaveChanges();
                    return Ok(existingProduct.Quantity);
                }
                else
                {
                    var shoppingCart = new ShoppingCart
                    {
                        DateCreated = System.DateTime.Now,
                        ProductId = model.ProductId,
                        Quantity = model.Quantity,
                        CartId = model.CartId

                    };
                    _ctx.ShoppingCart.Add(shoppingCart);
                    _ctx.SaveChanges();
                    return Ok(shoppingCart.Quantity);
                }
              
            }
        }
    }
}