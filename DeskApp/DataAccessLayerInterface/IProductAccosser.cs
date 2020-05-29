using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataObjectLayer;

namespace DataAccessLayerInterface
{
    public interface IProductAccosser
    {
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
        List<Product> RetrieveAllProducts();

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
      //  bool InsertProduct(Product product);

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
     //   bool UpdateProduct(Product oldProduct, Product newProduct);

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
      //  bool DeactivateProduct(string productId);


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
      //  Product SelectProductById(string productId);


       // Product RetriveProductByID(string productID);
       // List<Product> RetrieveAllProducts();
       // Product RetriveCustomerByFirstName(string productName);
        //Product RetriveCustomerByMidName(string customerMidName);
       // Product RetriveCustomerByLastName(string customerLastName);
       // Product RetriveCustomerByPhoneNumber(string customerPhoneNumber);
       // Product RetriveCustomerByEmail(string customerEmail);
       // List<Product> RetriveCustomersByRegionID(string regionID);
    }
}
