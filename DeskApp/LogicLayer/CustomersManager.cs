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
    /// <summary>
    /// Customer Manager class contains all logic codes that related to customers
    /// </summary>
    /// <remarks>
    /// created by Awaab Elamin on 5/21/2020
    /// </remarks>
    public class CustomersManager : CustomersManagerInterface
    {
        
        private CustomersAccessorInterface CustomersAccessor;

        /// <summary>
        /// default constructor assgined a refrence to customer accessor
        /// </summary>
        /// <remarks>
        /// Created by Awaab Elamin on 5/21/2020
        /// </remarks>
        public CustomersManager()
        {
            CustomersAccessor = new CustomersAccessor();
        }

        public void ActivateCustomer(Customer customer)
        {
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
                UpdateCustomer(customer, newCustomer);
            }
            catch (Exception)
            {

                throw;
            }
            
        }

        /// <summary>
        /// Adding a customer to customer table
        /// </summary>
        /// <remarks>
        /// created by Awaab Elamin on 5/23/2020
        /// </remarks>
        /// <param name="customer"></param>
        /// <returns>True only if get a true from customer accessor</returns>
        public bool AddCustomer(Customer customer)
        {
            bool result = false;

            try
            {
                result = CustomersAccessor.InsertCustomer(customer);
            }
            catch (Exception)
            {

                throw;
            }

            return result;
        }

        /// <summary>
        /// retrive all customers
        /// </summary>
        /// <remarks>
        /// created by Awaab Elamin on 5/22/2020
        /// </remarks>
        /// <returns> list of customers</returns>
        public List<Customer> GetAllCustomers()
        {
            List<Customer> result = new List<Customer>();

            try
            {
                result = CustomersAccessor.RetrieveAllCustomers();
            }
            catch (Exception)
            {

                throw;
            }


            return result;
        }

        public bool UpdateCustomer(Customer oldCustomer, Customer newCustomer)
        {
            bool result = false;
            try
            {
                result = CustomersAccessor.updateCustomer(oldCustomer, newCustomer);
            }
            catch (Exception)
            {

                throw;
            }

            return result;
        }
    }
}
