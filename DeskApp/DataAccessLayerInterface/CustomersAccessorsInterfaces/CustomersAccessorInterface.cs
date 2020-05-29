using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataObjectLayer;

namespace DataAccessLayerInterface
{
    /// <summary>
    /// Interface contains generals methods headers that related to customers tables
    /// </summary>
    public interface CustomersAccessorInterface
    {
        bool InsertCustomer(Customer customer);
        bool updateCustomer(Customer oldCustomer, Customer newCustomer);
        bool DeleteCustomer(Customer customer);
        bool ActivateCustomer(Customer customer);
        bool DeactivateCustomer(Customer customer);
        List<Customer> RetrieveAllCustomers();
        //Customer RetriveCustomerByID(string customerID);
        //Customer RetriveCustomerByFirstName(string customerFirstName);
        //Customer RetriveCustomerByMidName(string customerMidName);
        //Customer RetriveCustomerByLastName(string customerLastName);
        //Customer RetriveCustomerByPhoneNumber(string customerPhoneNumber);
        //Customer RetriveCustomerByEmail(string customerEmail);
        //List<Customer> RetriveCustomersByRegionID(string regionID);

    }
}
