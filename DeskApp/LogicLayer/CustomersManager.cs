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
    public class CustomersManager : CustomersManagerInterface
    {
        private CustomersAccessorInterface CustomersAccessor;

        public CustomersManager()
        {
            CustomersAccessor = new CustomersAccessor();
        }

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
    }
}
