

using Api.Model;
using ECOM.Repos.DB;
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

        [HttpPost]
        [Route("postcategory")]
        public IActionResult PostCategory(CategoryModel model)
        {
            using (var _ctx = new COMMERCEContext())
            {
                var category = new Categories
                {
                    CategoryId = model.CategoryId ,
                    CategoryName = model.CategoryName
                    
                };
                _ctx.Add(category);
                _ctx.SaveChanges();
                return Ok(model.CategoryId);
            }
                
        }


        [HttpDelete]
        [Route("deletecategory")]
        public IActionResult DeleteCategory(int categoryID)
        {
            if (categoryID > 0)
            {
                using (var _ctx = new COMMERCEContext())
                {
                    var foundCategory = _ctx.Categories.Where(c => c.CategoryId == categoryID).FirstOrDefault();
                    if (foundCategory != null)
                    {
                        _ctx.Remove(foundCategory);
                        _ctx.SaveChanges();
                    }
                   

                }
                    
            }

            return Ok("");
        }

    }
}