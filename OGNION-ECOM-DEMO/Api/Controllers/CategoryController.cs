

using Api.Model;
using ECOM.Repos.DBInteractions;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoryController : ControllerBase
    {
        // GET api/values
        [HttpGet]
        public ActionResult<IEnumerable<CategoryModel>> Get()
        {
            using (var _ctx = new COMMERCEContext())
            {
                return _ctx.Categories.Select(_ => new CategoryModel
                {
                    CategoryId = _.CategoryId,
                    CategoryName = _.CategoryName
                }).ToList();
            }
        }



    }
}