using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using Api.Model;
using BrunoZell.ModelBinding;
using ECOM.Repos.DB;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;


namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]

    public class ProductController : ControllerBase
    {
       



        // GET api/values
        [HttpGet]
        public ActionResult<IEnumerable<ProductModel>> Get()
        {
            using (var _ctx = new COMMERCEContext())
            {
                var products = _ctx.Products.Select(
                    p => new ProductModel
                    {
                        CategoryId = p.CategoryId,
                        ProductId = p.ProductId,
                        Description = p.Description,
                        ModelName = p.ModelName,
                        ModelNumber = p.ModelNumber,
                        ProductImage = p.ProductImage,
                        UnitCost = p.UnitCost
                    }).ToList();

                return products;
            }
        }


        [HttpGet]
        [Route("details")]
        public ActionResult<ProductModel> GetById(int? productId)
        {

            using (var _context = new COMMERCEContext())
            {
                return _context.Products.Where(_ => _.ProductId == productId)
                                         .Select(_ =>
                                           new ProductModel
                                           {
                                               ProductId = _.ProductId,
                                               Description = _.Description,
                                               ModelName = _.ModelName,
                                               ProductImage = _.ProductImage,
                                               ModelNumber = _.ModelNumber,
                                               UnitCost = _.UnitCost,
                                               CategoryId = _.CategoryId
                                           }
                                           ).FirstOrDefault();
            }

        }


        [HttpGet]
        [Route("productCategory")]
        public ActionResult<IEnumerable<ProductModel>> GetProductByIdCategory(int? categoryId)
        {

            using (var _context = new COMMERCEContext())
            {
                return (categoryId == 0 || categoryId == null) ?
                    _context.Products.Select(_ =>
                                          new ProductModel
                                          {
                                              ProductId = _.ProductId,
                                              Description = _.Description,
                                              ModelName = _.ModelName,
                                              ProductImage = _.ProductImage,
                                              ModelNumber = _.ModelNumber,
                                              UnitCost = _.UnitCost,
                                              CategoryId = _.CategoryId
                                          }
                                           ).ToList() :

                 _context.Products.Where(_ => _.CategoryId == categoryId)
                                         .Select(_ =>
                                           new ProductModel
                                           {
                                               ProductId = _.ProductId,
                                               Description = _.Description,
                                               ModelName = _.ModelName,
                                               ProductImage = _.ProductImage,
                                               ModelNumber = _.ModelNumber,
                                               UnitCost = _.UnitCost,
                                               CategoryId = _.CategoryId
                                           }
                                           ).ToList();
            }

        }



        [HttpPost]
        [Route("postproduct")]
        public IActionResult PostProduct(IList<IFormFile> files, [ModelBinder(BinderType = typeof(JsonModelBinder))] ProductModel Model)
        {
            string fileName = string.Empty;
            if (files?.Any() == true)
            {
                string folderName = @"D://Projects//ng//E-Com//src//resource";
                var pathToSave = Path.Combine(Directory.GetCurrentDirectory(), folderName);

                for (int i = 0; i < files.Count(); i++)
                {
                    fileName = ContentDispositionHeaderValue.Parse(files[i].ContentDisposition).FileName.Trim('"');
                    var fullPath = Path.Combine(pathToSave, fileName);
                    var dbPath = Path.Combine(folderName, fileName);

                    using (var stream = new FileStream(fullPath, FileMode.Create))
                    {
                        files[i].CopyTo(stream);
                    }
                }
            }
            var pr = new Products();
            if (Model != null)
            {
                pr.CategoryId = Model.CategoryId;
                pr.ModelName = Model.ModelName;
                pr.ModelNumber = Model.ModelNumber;
                pr.ProductImage = fileName;
                pr.Description = Model.Description;
                using (var _context = new COMMERCEContext())
                {
                    _context.Products.Add(pr);
                    _context.SaveChanges();
                }

                   
                return Ok(pr.ProductId);
            }
            return Ok("");
        }


        [HttpDelete]
        [Route("deleteproduct")]
        public IActionResult DeleteProduct(int prodcutId)
        {
            if(prodcutId > 0)
            {
                using (var _ctx = new COMMERCEContext())
                {
                    var product = _ctx.Products.Where(p => p.ProductId == prodcutId).FirstOrDefault();

                    if(product != null)
                    {
                        _ctx.Products.Remove(product);
                        _ctx.SaveChanges();

                    }
                }
                
            }
            return Ok("");
        }

    }
}