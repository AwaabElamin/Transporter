using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataObjectLayer;

namespace LogicLayerInterface
{
    public interface CustomersManagerInterface
    {
        List<Customer> GetAllCustomers();
    }
}
