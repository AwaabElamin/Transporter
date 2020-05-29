using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeskTop
{
    public class Validation
    {
        public static bool isEmpty(string textValue) 
        {
            bool result = false;
            if ((textValue == "") || (textValue == null))
            {
                result = true;
            }
            return result;
        }
    }
}
