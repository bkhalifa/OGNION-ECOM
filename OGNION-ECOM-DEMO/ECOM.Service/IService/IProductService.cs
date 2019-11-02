using ECOM.Poco;
using System.Collections.Generic;


namespace ECOM.Service.IService
{
       public interface IProductService
    {
        IEnumerable<Products> GeProducts();
        Products GetProduct(long id);
        void InsertProduct(Products product);
        void UpdateProduct(Products product);
        void DeleteProduct(Products id);
    }

}
