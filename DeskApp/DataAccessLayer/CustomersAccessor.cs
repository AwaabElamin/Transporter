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
        private List<Customer> customers= null;
        public CustomersAccessor()
        {
            customers = retriveAllCustomers();
        }

        private List<Customer> retriveAllCustomers()
        {
            List<Customer> customers = new List<Customer>();
            AppData.FilePath = "F:\\Transporter\\DeskApp\\OLEDB\\Customer.xlsx";
            using (OleDbConnection conn = DBConnection.OLEConn())
            {
                try
                {
                    

                    conn.Open();
                    OleDbCommand cmd = new OleDbCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = @"select CustomerID, FirstName,	MiddleName,	LastName, PhoneNumber, Email, ReigonID, AddressLine, Active
                                        
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

        public bool ActivateCustomer(Customer customer)
        {
            bool result = false;

            foreach (Customer cust in customers)
            {
                if ((cust.CustomerID == customer.CustomerID) && (cust.FirstName == customer.FirstName)
                    &&(cust.MiddleName == customer.MiddleName) && (cust.LastName == customer.LastName)
                    && (cust.PhoneNumber == customer.PhoneNumber) && (cust.RegionID == customer.RegionID))
                {
                    cust.Active = true;
                }
            }

            return result;
        }

        public bool DeactivateCustomer(Customer customer)
        {
            bool result = false;

            foreach (Customer cust in customers)
            {
                if ((cust.CustomerID == customer.CustomerID) && (cust.FirstName == customer.FirstName)
                    && (cust.MiddleName == customer.MiddleName) && (cust.LastName == customer.LastName)
                    && (cust.PhoneNumber == customer.PhoneNumber) && (cust.RegionID == customer.RegionID))
                {
                    cust.Active = false;
                }
            }

            return result;
        }

        public bool DeleteCustomer(Customer customer)
        {
            bool result = false;

            foreach (Customer cust in customers)
            {
                if ((cust.CustomerID == customer.CustomerID) && (cust.FirstName == customer.FirstName)
                    && (cust.MiddleName == customer.MiddleName) && (cust.LastName == customer.LastName)
                    && (cust.PhoneNumber == customer.PhoneNumber) && (cust.RegionID == customer.RegionID))
                {
                    customers.Remove(cust);
                }
            }

            return result;
        }

        public void InsertCustomer(Customer customer)
        {
            customers.Add(customer);
        }

        public Customer RetriveCustomerByEmail(string customerEmail)
        {
            Customer customer = new Customer();
            foreach (Customer cust in customers)
            {
                if (cust.Email == customerEmail)
                {
                    customer = cust;
                    break;
                }
            }

            return customer;
        }

        public Customer RetriveCustomerByFirstName(string customerFirstName)
        {
            Customer customer = new Customer();
            foreach (Customer cust in customers)
            {
                if (cust.FirstName == customerFirstName)
                {
                    customer = cust;
                    break;
                }
            }

            return customer;
        }

        public Customer RetriveCustomerByID(string customerID)
        {
            Customer customer = new Customer();
            foreach (Customer cust in customers)
            {
                if (cust.CustomerID == customerID)
                {
                    customer = cust;
                    break;
                }
            }

            return customer;
        }

        public Customer RetriveCustomerByLastName(string customerLastName)
        {
            Customer customer = new Customer();
            foreach (Customer cust in customers)
            {
                if (cust.LastName == customerLastName)
                {
                    customer = cust;
                    break;
                }
            }

            return customer;
        }

        public Customer RetriveCustomerByMidName(string customerMidName)
        {
            Customer customer = new Customer();
            foreach (Customer cust in customers)
            {
                if (cust.MiddleName == customerMidName)
                {
                    customer = cust;
                    break;
                }
            }

            return customer;
        }

        public Customer RetriveCustomerByPhoneNumber(string customerPhoneNumber)
        {
            Customer customer = new Customer();
            foreach (Customer cust in customers)
            {
                if (cust.PhoneNumber == customerPhoneNumber)
                {
                    customer = cust;
                    break;
                }
            }

            return customer;
        }

        public List<Customer> RetriveCustomersByRegionID(string regionID)
        {
            List<Customer> customers = new List<Customer>();
            foreach (Customer cust in customers)
            {
                if (cust.RegionID == regionID)
                {
                    customers.Add(cust);
                }
            }

            return customers;
        }

        public bool updateCustomer(Customer oldCustomer, Customer newCustomer)
        {
            bool result = false;

            foreach (Customer customer in customers)
            {
                if ((customer.CustomerID == oldCustomer.CustomerID) && (customer.FirstName == oldCustomer.FirstName)
                    && (customer.MiddleName == oldCustomer.MiddleName) && (customer.LastName == oldCustomer.LastName)
                    && (customer.PhoneNumber == oldCustomer.PhoneNumber) && (customer.RegionID == oldCustomer.RegionID)
                    && (customer.Email == oldCustomer.Email) && (customer.AddressLine== oldCustomer.AddressLine))
                {
                    customers.Remove(customer);
                    customers.Add(newCustomer);
                    break;
                }
            }

            return result;
        }

        public List<Customer> RetrieveAllCustomers()
        {
            return customers;
        }
    }
}
