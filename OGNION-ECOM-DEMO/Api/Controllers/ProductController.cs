using System.Collections.Generic;
using System.Linq;
using Api.Model;
using ECOM.Service.IService;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly IProductService _productService;

        public ProductController(IProductService productService)
        {
            _productService = productService;
        }



        // GET api/values
        [HttpGet]
        public ActionResult<IEnumerable<ProductModel>> Get()
        {
            List<ProductModel> model = new List<ProductModel>();

             _productService.GeProducts().ToList().ForEach(_ =>
            {
                ProductModel product = new ProductModel
                {
                   ProductId = _.ProductId,
                  Description = _.Description,
                  ModelName =_.ModelName,
                  ProductImage =_.ProductImage,
                  ModelNumber =_.ModelNumber,
                  UnitCost =_.UnitCost,
                  CategoryId =_.CategoryId
                };
                model.Add(product);
            });
            return model;


        }
    }
}
