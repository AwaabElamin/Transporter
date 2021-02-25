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
    /// <summary>
    /// CustomersAccessor includes interactive methos with customer table
    /// </summary>
    /// <remarks>
    /// Created by Awaab Elamin on 5/21/2020
    /// </remarks>
    public class CustomersAccessor : CustomersAccessorInterface
    {
       // private List<Customer> customers= null;
        public CustomersAccessor()
        {
            AppData.CustomersFilePath = System.AppDomain.CurrentDomain.BaseDirectory + @"../../../" + @"OLEDB\Customer.xlsx";
         //   AppData.CustomersFilePath = "F:\\Transporter\\DeskApp\\OLEDB\\Customer.xlsx";
            
        }

        public bool updateCustomer(Customer oldCustomer, Customer newCustomer)
        {
            bool result = false;

            //foreach (Customer customer in customers)
            //{
            //    if ((customer.CustomerID == oldCustomer.CustomerID) && (customer.FirstName == oldCustomer.FirstName)
            //        && (customer.MiddleName == oldCustomer.MiddleName) && (customer.LastName == oldCustomer.LastName)
            //        && (customer.PhoneNumber == oldCustomer.PhoneNumber) && (customer.RegionID == oldCustomer.RegionID)
            //        && (customer.Email == oldCustomer.Email) && (customer.AddressLine== oldCustomer.AddressLine))
            //    {
            //        customers.Remove(customer);
            //        customers.Add(newCustomer);
            //        break;
            //    }
            //}
            // AppData. = "F:\\Transporter\\DeskApp\\OLEDB\\Customer.xlsx";
            using (OleDbConnection conn = DBConnection.OLEConnCustomers())
            {
                try
                {


                    conn.Open();
                    OleDbCommand cmd = new OleDbCommand();
                    cmd.Connection = conn;
                    //UPDATE table_name
                    //SET column1 = value1, column2 = value2, ...
                    //WHERE condition;
                    cmd.CommandText =
                          @"UPDATE  [Sheet1$] " +
                          "SET " +
                          "CustomerID = '" + newCustomer.CustomerID + "'," +
                          "FirstName = '" + newCustomer.FirstName + "'," +
                          "MiddleName = '" + newCustomer.MiddleName + "'," +
                          "LastName = '" + newCustomer.LastName + "'," +
                          "PhoneNumber = '" + newCustomer.PhoneNumber + "'," +
                          "Email = '" + newCustomer.Email + "'," +
                          "RegionID = '" + newCustomer.RegionID + "'," +
                          "AddressLine = '" + newCustomer.AddressLine + "'," +
                          "Active = '" + newCustomer.Active + "'" +
                          " WHERE " +
                          "CustomerID = '" + oldCustomer.CustomerID + "'" +
                          " And FirstName = '" + oldCustomer.FirstName + "'" +
                          " And MiddleName = '" + oldCustomer.MiddleName + "'" +
                          " And LastName = '" + oldCustomer.LastName + "'" +
                          " And PhoneNumber = '" + oldCustomer.PhoneNumber + "'" +
                          " And Email = '" + oldCustomer.Email + "'" +
                          " And RegionID = '" + oldCustomer.RegionID + "'" +
                          " And AddressLine = '" + oldCustomer.AddressLine + "'" +
                          " And Active = '" + oldCustomer.Active + "'";



                    int rows = cmd.ExecuteNonQuery();
                    if (rows == 1)
                    {
                        result = true;
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


            return result;
        }

        public bool ActivateCustomer(Customer customer)
        {
            bool result = false;

            //foreach (Customer cust in customers)
            //{
            //    if ((cust.CustomerID == customer.CustomerID) && (cust.FirstName == customer.FirstName)
            //        &&(cust.MiddleName == customer.MiddleName) && (cust.LastName == customer.LastName)
            //        && (cust.PhoneNumber == customer.PhoneNumber) && (cust.RegionID == customer.RegionID))
            //    {
            //        cust.Active = true;
            //    }
            //}

            Customer newCustomer = new Customer();
            newCustomer.CustomerID = customer.CustomerID;
            newCustomer.FirstName = customer.FirstName;
            newCustomer.MiddleName = customer.MiddleName;
            newCustomer.LastName = customer.LastName;
            newCustomer.PhoneNumber = customer.PhoneNumber;
            newCustomer.Email = customer.Email;
            newCustomer.RegionID = customer.RegionID;
            newCustomer.AddressLine = customer.AddressLine;
            newCustomer.Active = true;

            try
            {
                result = updateCustomer(customer, newCustomer);
            }
            catch (Exception)
            {

                throw;
            }

            return result;
        }

        public bool DeactivateCustomer(Customer customer)
        {
            bool result = false;

            //foreach (Customer cust in customers)
            //{
            //    if ((cust.CustomerID == customer.CustomerID) && (cust.FirstName == customer.FirstName)
            //        && (cust.MiddleName == customer.MiddleName) && (cust.LastName == customer.LastName)
            //        && (cust.PhoneNumber == customer.PhoneNumber) && (cust.RegionID == customer.RegionID))
            //    {
            //        cust.Active = false;
            //    }
            //}
            Customer newCustomer = new Customer();
            newCustomer.CustomerID = customer.CustomerID;
            newCustomer.FirstName = customer.FirstName;
            newCustomer.MiddleName = customer.MiddleName;
            newCustomer.LastName = customer.LastName;
            newCustomer.PhoneNumber = customer.PhoneNumber;
            newCustomer.Email = customer.Email;
            newCustomer.RegionID = customer.RegionID;
            newCustomer.AddressLine = customer.AddressLine;
            newCustomer.Active = false;

            try
            {
                result = updateCustomer(customer, newCustomer);
            }
            catch (Exception)
            {

                throw;
            }

            return result;
        }

        //OLEDB does not support DELETE query.
        public bool DeleteCustomer(Customer customer)
        {
            bool result = false;

            //using (OleDbConnection conn = DBConnection.OLEConnCustomers())
            //{
            //    try
            //    {

            //        conn.Open();
            //        OleDbCommand cmd = new OleDbCommand();
            //        cmd.Connection = conn;
            //        //DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';
            //        cmd.CommandText = @"DELETE  FROM [Sheet1$] "
            //                         + "WHERE CustomerID = '"
            //                         + customer.CustomerID + "';";
            //        int rows = cmd.ExecuteNonQuery();

            //        if (rows == 1)
            //        {
            //            result = true;
            //        }
            //    }
            //    catch (Exception)
            //    {

            //        throw;
            //    }
            //    finally
            //    {
            //        conn.Close();
            //        conn.Dispose();
            //    }

            //}


            return result;
        }
       
        /// <summary>
        /// insert a new item to customers list
        /// </summary>
        /// <remarks>
        /// created by Awaab Elamin on 5/23/2020
        /// </remarks>
        /// <param name="customer"></param>
        /// <returns></returns>
        public bool InsertCustomer(Customer customer)
        {
            bool result = false;


            //AppData.FilePath = "F:\\Transporter\\DeskApp\\OLEDB\\Customer.xlsx";
            using (OleDbConnection conn = DBConnection.OLEConnCustomers())
            {
                try
                {


                    conn.Open();
                    OleDbCommand cmd = new OleDbCommand();
                    cmd.Connection = conn;
                    //
                    cmd.CommandText =
                        @"INSERT INTO  [Sheet1$] (CustomerID,FirstName,MiddleName,LastName,PhoneNumber,Email,RegionID,AddressLine,Active)
                          VALUES('" +
                           customer.CustomerID + "','" +
                           customer.FirstName + "','" +
                           customer.MiddleName + "','" +
                           customer.LastName + "','" +
                           customer.PhoneNumber + "','" +
                           customer.Email + "','" +
                           customer.RegionID + "','" +
                           customer.AddressLine + "','" +
                           customer.Active + "');";
                    int rows = cmd.ExecuteNonQuery();
                    if (rows == 1)
                    {
                        result = true;

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
            return result;
        }

        public List<Customer> RetrieveAllCustomers()
        {

            List<Customer> customers = new List<Customer>();

            using (OleDbConnection conn = DBConnection.OLEConnCustomers())
            {
                try
                {

                    conn.Open();
                    OleDbCommand cmd = new OleDbCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = @"select CustomerID, FirstName,	MiddleName,	LastName, PhoneNumber, Email, RegionID, AddressLine, Active
                                        
                                       from [Sheet1$];";
                    OleDbDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {

                            Customer customer = new Customer();
                            customer.CustomerID = reader[0].ToString();
                            customer.FirstName = reader[1].ToString();
                            customer.MiddleName = reader[2].ToString();
                            customer.LastName = reader[3].ToString();
                            customer.PhoneNumber = reader[4].ToString();
                            customer.Email = reader[5].ToString();
                            customer.RegionID = reader[6].ToString();
                            customer.AddressLine = reader[7].ToString();
                            customer.Active = Convert.ToBoolean(reader[8]);
                            customers.Add(customer);
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




            return customers;
        }

        //public Customer RetriveCustomerByEmail(string customerEmail)
        //    {
        //    Customer customer = new Customer();
        //    foreach (Customer cust in customers)
        //    {
        //        if (cust.Email == customerEmail)
        //        {
        //            customer = cust;
        //            break;
        //        }
        //    }

        //    return customer;
        //}

        //public Customer RetriveCustomerByFirstName(string customerFirstName)
        //{
        //    Customer customer = new Customer();
        //    foreach (Customer cust in customers)
        //    {
        //        if (cust.FirstName == customerFirstName)
        //        {
        //            customer = cust;
        //            break;
        //        }
        //    }

        //    return customer;
        //}

        //public Customer RetriveCustomerByID(string customerID)
        //{
        //    Customer customer = new Customer();
        //    foreach (Customer cust in customers)
        //    {
        //        if (cust.CustomerID == customerID)
        //        {
        //            customer = cust;
        //            break;
        //        }
        //    }

        //    return customer;
        //}

        //public Customer RetriveCustomerByLastName(string customerLastName)
        //{
        //    Customer customer = new Customer();
        //    foreach (Customer cust in customers)
        //    {
        //        if (cust.LastName == customerLastName)
        //        {
        //            customer = cust;
        //            break;
        //        }
        //    }

        //    return customer;
        //}

        //public Customer RetriveCustomerByMidName(string customerMidName)
        //{
        //    Customer customer = new Customer();
        //    foreach (Customer cust in customers)
        //    {
        //        if (cust.MiddleName == customerMidName)
        //        {
        //            customer = cust;
        //            break;
        //        }
        //    }

        //    return customer;
        //}

        //public Customer RetriveCustomerByPhoneNumber(string customerPhoneNumber)
        //{
        //    Customer customer = new Customer();
        //    foreach (Customer cust in customers)
        //    {
        //        if (cust.PhoneNumber == customerPhoneNumber)
        //        {
        //            customer = cust;
        //            break;
        //        }
        //    }

        //    return customer;
        //}

        //public List<Customer> RetriveCustomersByRegionID(string regionID)
        //{
        //    List<Customer> customers = new List<Customer>();
        //    foreach (Customer cust in customers)
        //    {
        //        if (cust.RegionID == regionID)
        //        {
        //            customers.Add(cust);
        //        }
        //    }

        //    return customers;
        //}




    }
}
