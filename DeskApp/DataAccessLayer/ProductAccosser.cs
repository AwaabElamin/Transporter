using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataObjectLayer;
using DataAccessLayerInterface;
using System.Data.OleDb;
using System.Data.SqlClient;


namespace DataAccessLayer
{
    public class ProductAccosser : IProductAccosser
    {
        private List<Product> products = null;
        public ProductAccosser()
        {
            products = RetrieveAllProducts();
        }

        //public int DeactivateProduct(int productId)
        //{
        //    throw new NotImplementedException();
        //}

        //public bool DeactivateProduct(string productId)
        //{
        //    throw new NotImplementedException();
        //}

        //public bool InsertProduct(Product product)
        //{
        //    throw new NotImplementedException();
        //}

        public List<Product> RetrieveAllProducts()
        {
            List<Product> products = new List<Product>();
            AppData.FilePath = "C:\\Transporter\\DeskApp\\OLEDB\\Product.xlsx";
            using (OleDbConnection conn = DBConnection.OLEConn())
            {
                try
                {
                    conn.Open();
                    OleDbCommand cmd = new OleDbCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = @"select ProductID, ProductName, pirice,	DateReceived, weight, Dimension, Description,
                         Qoh, Active, SupplierId
                                        
                                       from [Sheet1$];";
                    OleDbDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {

                            Product product = new Product();
                            product.ProductID = reader[0].ToString();
                            product.ProductName = reader[1].ToString();
                            product.pirice = Convert.ToDecimal(reader[2]);
                            product.DateReceived = Convert.ToDateTime (reader[3]);
                            product.weight = Convert.ToDecimal(reader[4]);
                            product.Dimension = Convert.ToDecimal(reader[5]);
                            product.Description = reader[6].ToString();
                            product.Qoh = Convert.ToInt32(reader[7].ToString());
                            product.Active =Convert.ToBoolean(reader[8]);                         
                            product.SupplierId = Convert.ToInt32(reader[9].ToString());
                            products.Add(product);
                        }
                        reader.Close();
                    }
                }
                catch (Exception)
                {
                    throw;
                }
                finally
                {
                    conn.Close();
                    conn.Dispose();
                }
            }
            return products;
        }


        //public Product SelectProductById(string productId)
        //{
        //    throw new NotImplementedException();
        //}

        //public bool UpdateProduct(Product oldProduct, Product newProduct)
        //{
        //    throw new NotImplementedException();
        //}
    }
}
