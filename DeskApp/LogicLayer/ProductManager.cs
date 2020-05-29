using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LogicLayerInterface;
using DataAccessLayer;
using DataAccessLayerInterface;
using DataObjectLayer;
namespace LogicLayer
{
    public class ProductManager : IProductManager
    {
        private IProductAccosser _productAccessor;

        /// <summary>
        /// Creator: Mohamed Elamin
        /// Created: 2020/05/25
        /// Approver: 
        ///  Product Manager Constructor method
        /// </summary>
        /// <remarks>
        /// Updater Name
        /// Updated: yyyy/mm/dd 
        /// Update: ()
        /// </remarks>
        public ProductManager()
        {
            _productAccessor = new ProductAccosser();

        }

        /// <summary>
        /// Creator: Mohamed Elamin
        /// Created: 2020/05/25
        /// Approver: 
        /// Retrieves Product By Id.
        /// </summary>
        /// <remarks>
        /// Updater Name
        /// Updated: yyyy/mm/dd 
        /// Update: ()
        /// </remarks>
        /// <param name="productId"></param>
        /// <returns>product</returns>
        //public Product RetrieveProductById(string productId)
        //{
        //    try
        //    {
        //        return _productAccessor.SelectProductById(productId);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new ApplicationException("Data not found.", ex);
        //    }

        //}


        /// <summary>
        /// Creator: Mohamed Elamin
        /// Created: 2020/05/25
        /// Approver: 
        /// Updates product.
        /// </summary>
        /// <remarks>
        /// Updater Name
        /// Updated: yyyy/mm/dd 
        /// Update: ()
        /// </remarks>
        /// <param name="product"></param>
        /// <returns>True or False depending if the record was updated</returns>
        //public bool EditProduct(Product oldProdcut, Product newProduct)
        //{     
        //    bool result = false;
        //    try
        //    {
        //        result = _productAccessor.UpdateProduct(oldProdcut, newProduct);
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }

        //    return result;
        //}


        /// <summary>
        /// Creator: Mohamed Elamin
        /// Created: 2020/05/25
        /// Approver: 
        /// Retrieves Products List By Active.
        /// </summary>
        /// <remarks>
        /// Updater Name
        /// Updated: yyyy/mm/dd 
        /// Update: ()
        /// </remarks>
        /// <param name="active"></param>
        /// <returns>Products list</returns>
        public List<Product> GetAllProducts()
        {
            List<Product> result = new List<Product>();

            try
            {
                result = _productAccessor.RetrieveAllProducts();
            }
            catch (Exception)
            {

                throw;
            }


            return result;
        }

        /// <summary>
        /// Creator: Mohamed Elamin
        /// Created: 2020/05/25
        /// Approver: 
        /// Inserts Product.
        /// </summary>
        /// <remarks>
        /// Updater Name
        /// Updated: yyyy/mm/dd 
        /// Update: ()
        /// </remarks>
        /// <param name="product"></param>
        /// <returns>True or False depending if the record was updated</returns>
        //public bool AddProduct(Product product)
        //{
        //    bool result = false;

        //    try
        //    {
        //        result = _productAccessor.InsertProduct(product);
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }

        //    return result;
        //}

        /// <summary>
        /// Creator: Mohamed Elamin
        /// Created: 2020/05/10
        /// Approver: 
        /// Deactivates Product.
        /// </summary>
        /// <remarks>
        /// Updater Name
        /// Updated: yyyy/mm/dd 
        /// Update: ()
        /// </remarks>
        /// <param name="product"></param>
        /// <returns>True or False depending if the record was updated</returns>
        //public bool DeactivateProduct(Product product)
        //{
        //    bool result = false;
        //    try
        //    {
        //        result = _productAccessor.DeactivateProduct(product.ProductID);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new ApplicationException("Deactivation failed.", ex);
        //    }
        //    return result;
        //}

    }
}
