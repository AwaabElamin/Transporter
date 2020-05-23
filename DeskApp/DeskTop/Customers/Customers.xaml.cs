using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using LogicLayer;
using LogicLayerInterface;
using DataObjectLayer;

namespace DeskTop.Customers
{
    /// <summary>
    /// Interaction logic for Customers.xaml
    /// </summary>
    /// <remarks>
    /// created by Awaab Elamin on 5/21/2020
    /// </remarks>
    public partial class Customers : Page
    {
        //blow object represent the logic layer class for customers
        private CustomersManagerInterface customersManager;

        /// <summary>
        /// default constructor assigned a refrence to customers manger and
        /// fill out the grid with customers data
        /// </summary>
        /// <remarks>
        /// created by Awaab Elamin on 5/21/2020
        /// </remarks>
        public Customers()
        {
            customersManager = new CustomersManager();
            InitializeComponent();
            DGCustomerView.ItemsSource = customersManager.GetAllCustomers();
        }

        /// <summary>
        /// on click on Insert buttom, we hid all other canvases and let 
        /// Canvas of customerAdd to pop up
        /// </summary>
        /// <remarks>
        /// created by Awaab Elamin on 5/21/2020
        /// </remarks>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnCustomerInsert_Click(object sender, RoutedEventArgs e)
        {
            CanViewAllCustomer.Visibility = Visibility.Hidden;
            CanCustomerAdd.Visibility = Visibility.Visible;
            TabAddCustomer.Focus();
            
            //if (DGCustomerView.SelectedItem == null)
            //{
            //    lblCustomerError.Content = "AWaab";
            //    return;
            //}
            //Customer customer = (Customer)DGCustomerView.SelectedItem;
            //lblCustomerError.Content = "";


        }

        /// <summary>
        /// when hit submit button, first vlaidate the data, then fill customer data object
        /// then we send it to logic layer
        /// </summary>
        /// <remarks>
        /// created by Awaab Elamin onn 5/22/2020
        /// </remarks>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnCustomerAddSubmit_Click(object sender, RoutedEventArgs e)
        {
            //first, validate the data entry
                //first name
            if ((txtCustomerAddFirstName.Text == "") || (txtCustomerAddFirstName.Text == null))
            {
                lblCustomerAddError.Content = "Please Add the First Name";
                ElipCustomerAddFirstName.Visibility = Visibility.Visible;
                return;
            }
            ElipCustomerAddFirstName.Visibility = Visibility.Hidden;

            //Middle name
            if ((txtCustomerAddMIDName.Text == "") || (txtCustomerAddMIDName.Text == null))
            {
                lblCustomerAddError.Content = "Please Add the Middle Name";
                ElipCustomerAddMIDName.Visibility = Visibility.Visible;
                return;
            }
            ElipCustomerAddMIDName.Visibility = Visibility.Hidden;
            
            //Last Name
            if ((txtCustomerAddLastName.Text == "") || (txtCustomerAddLastName.Text == null))
            {
                lblCustomerAddError.Content = "Please Add the Last Name";
                ElipCustomerAddLastName.Visibility = Visibility.Visible;
                return;
            }
            ElipCustomerAddLastName.Visibility = Visibility.Hidden;

            //Phone Number
            if ((txtCustomerAddPhoneNumber .Text == "") || (txtCustomerAddPhoneNumber.Text == null))
            {
                lblCustomerAddError.Content = "Please Add the Middle Name";
                ElipCustomerAddPhoneNumber.Visibility = Visibility.Visible;
                return;
            }
            ElipCustomerAddPhoneNumber.Visibility = Visibility.Hidden;

            //Email
            if ((txtCustomerAddEmail.Text == "") || (txtCustomerAddEmail.Text == null))
            {
                lblCustomerAddError.Content = "Please Add the Middle Name";
                ElipCustomerAddEmail.Visibility = Visibility.Visible;
                return;
            }
            ElipCustomerAddEmail.Visibility = Visibility.Hidden;

            //Region 
            if ((txtCustomerAddRegionID.Text == "") || (txtCustomerAddRegionID.Text == null))
            {
                lblCustomerAddError.Content = "Please Add the Middle Name";
                ElipCustomerAddRegionID.Visibility = Visibility.Visible;
                return;
            }
            ElipCustomerAddRegionID.Visibility = Visibility.Hidden;

            //Address line
            if ((txtCustomerAddAddressLine.Text == "") || (txtCustomerAddAddressLine.Text == null))
            {
                lblCustomerAddError.Content = "Please Add the Middle Name";
                ElipCustomerAddAddressLine.Visibility = Visibility.Visible;
                return;
            }
            ElipCustomerAddAddressLine.Visibility = Visibility.Hidden;

            //Note: we do need to validate Active because it has a default value 

            //on this steps all validate steps done,
            //this means all data is good
            //so, we clear the error lable and go to second step
            lblCustomerAddError.Content = "";

            //Second step, fill out Customer (Data object)

            //A- create an object with a refrence to Customer
            Customer customer = new Customer();

            
            
            
            
            
            
            
            
        }

     

     

        private void TabViewCustomer_GotFocus(object sender, RoutedEventArgs e)
        {
            CanViewAllCustomer.Visibility = Visibility.Visible;
            CanCustomerAdd.Visibility = Visibility.Hidden;
        }
    }
}
