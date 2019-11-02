using System;
using System.Collections.Generic;
using ECOM.Poco;
using ECOM.Repos;
using ECOM.Service.IService;


namespace ECOM.Service
{
    public class ProductService : IProductService
    {
        private IRepository<Products> _productRepository;


        public ProductService(IRepository<Products> productRepository)
        {
            _productRepository = productRepository;
        }

        public void DeleteProduct(Products id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Products> GeProducts()
        {
          return  _productRepository.GetAll();
        }

        public Products GetProduct(long id)
        {
            throw new NotImplementedException();
        }

        public void InsertProduct(Products product)
        {
            throw new NotImplementedException();
        }

        public void UpdateProduct(Products product)
        {
            throw new NotImplementedException();
        }
    }
}
