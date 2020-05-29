using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataObjectLayer;

namespace LogicLayerInterface
{
    public interface IProductManager
    {
        /// <summary>
        /// Creator: Mohamed Elamin
        /// Created: 2020/05/10
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
     //   bool EditProduct(Product oldProdcut, Product newProduct);

        /// <summary>
        /// Creator: Mohamed Elamin
        /// Created: 2020/05/10
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
        List<Product> GetAllProducts();


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
     //   bool DeactivateProduct(Product product);


        /// <summary>
        /// Creator: Mohamed Elamin
        /// Created: 2020/05/10
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
     //   bool AddProduct(Product product);


        /// <summary>
        /// Creator: Mohamed Elamin
        /// Created: 2020/05/10
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
     //   Product RetrieveProductById(string productId);

        //List<Product> GetAllProducts();
        //bool AddProduct(Product product);
        //bool UpdateProduct(Product oldProduct, Product newProduct);
        //void ActivateProduct(Product product);
        //void DeactivateProduct(Product product);
    }
}
