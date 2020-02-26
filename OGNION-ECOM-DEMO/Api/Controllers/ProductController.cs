using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using Api.Model;
using BrunoZell.ModelBinding;
using ECOM.Poco;
using ECOM.Repos.DBInteractions;
using ECOM.Service.IService;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;


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
                   ModelName = _.ModelName,
                   ProductImage = _.ProductImage,
                   ModelNumber = _.ModelNumber,
                   UnitCost = _.UnitCost,
                   CategoryId = _.CategoryId
               };
               model.Add(product);
           });
            return model;
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

                _productService.InsertProduct(pr);

                return Ok(pr.ProductId);
            }
            return Ok("");
        }



    }
}