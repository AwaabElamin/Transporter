﻿using System;
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
using System.Text.RegularExpressions;

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
        private Customer oldCustomer = null;
        private Customer NewCustomer = null;
        private List<Customer> customers  = new List<Customer>();
        private List<Customer> activeCustomers  = new List<Customer>();
        private List<Customer> deactiveCustomers  = new List<Customer>();

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
            DGCustomerView.ItemsSource = null;
            customers.Clear();
            activeCustomers.Clear();
            deactiveCustomers.Clear();
            customers = customersManager.GetAllCustomers();
            
            foreach (Customer customer in customers)
            {
                if (customer.Active == true)
                {
                    activeCustomers.Add(customer);
                }
                else
                {
                    deactiveCustomers.Add(customer);
                }
            }
            DGCustomerView.ItemsSource = activeCustomers;

            DGCustomerDeativeView.ItemsSource = deactiveCustomers;
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
            string phoneNumber = "";
            string email = "";
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
            
            
            phoneNumber = txtCustomerAddPhoneNumber.Text;
            phoneNumber = phoneNumber.Trim();
            if (phoneNumber.Length != 10)
            {
                lblCustomerAddError.Content = "phone number must be 10 digits";
                ElipCustomerAddPhoneNumber.Visibility = Visibility.Visible;
                return;
            }
            try
            {
                Convert.ToDouble(phoneNumber);
            }
            catch (Exception)
            {

                lblCustomerAddError.Content = "phone number can only be numbers 0123456789";
                return;
            }
            ElipCustomerAddPhoneNumber.Visibility = Visibility.Hidden;

            //Email
            if ((txtCustomerAddEmail.Text == "") || (txtCustomerAddEmail.Text == null))
            {
                lblCustomerAddError.Content = "Please Add the Email";
                ElipCustomerAddEmail.Visibility = Visibility.Visible;
                return;
            }
            email = txtCustomerAddEmail.Text;
            string emailPattern = @"^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$";
            if (!Regex.IsMatch(email, emailPattern))
            {
                ElipCustomerAddEmail.Visibility = Visibility.Hidden;
                lblCustomerAddError.Content = "Email is not in the right format";
                return;
            }
           

            //Region 
            if ((txtCustomerAddRegionID.Text == "") || (txtCustomerAddRegionID.Text == null))
            {
                lblCustomerAddError.Content = "Please Add the Region ID";
                ElipCustomerAddRegionID.Visibility = Visibility.Visible;
                return;
            }
            ElipCustomerAddRegionID.Visibility = Visibility.Hidden;

            //Address line
            if ((txtCustomerAddAddressLine.Text == "") || (txtCustomerAddAddressLine.Text == null))
            {
                lblCustomerAddError.Content = "Please Add the Address line";
                ElipCustomerAddAddressLine.Visibility = Visibility.Visible;
                return;
            }
            ElipCustomerAddAddressLine.Visibility = Visibility.Hidden;

            //Note: we do not need to validate Active because it has a default value 
            
            
            //on this steps all validate steps done,
            //this means all data is good
            //so, we clear the error lable and go to second step
            lblCustomerAddError.Content = "";
            //Second step, fill out Customer (Data object)

            //A- create an object with a refrence to Customer
            Customer customer = new Customer();
            //B- fill all elements of customer
            customer.FirstName = txtCustomerAddFirstName.Text;
            customer.MiddleName = txtCustomerAddMIDName.Text;
            customer.LastName = txtCustomerAddLastName.Text;
            customer.PhoneNumber = phoneNumber;
            customer.Email = email;
            customer.RegionID = txtCustomerAddRegionID.Text;
            customer.AddressLine = txtCustomerAddAddressLine.Text;
            customer.Active = chkCustomerAddActive.IsChecked.Value;

            //the third step is try to send customer to logic layer
            try
            {
                if (customersManager.AddCustomer(customer))
                {
                    txtCustomerAddFirstName.Text = "";
                    txtCustomerAddMIDName.Text = "";
                    txtCustomerAddLastName.Text = "";
                    txtCustomerAddPhoneNumber.Text = "";
                    txtCustomerAddEmail.Text = "";
                    txtCustomerAddRegionID.Text = "";
                    txtCustomerAddAddressLine.Text = "";
                    chkCustomerAddActive.IsChecked = true;
                    lblCustomerAddError.Content = "Customer Added Correctly";
                }
                else
                {
                    lblCustomerAddError.Content = "Adding did not goes alright. Please try again";
                    return;
                }
               
            }
            catch (Exception ex)
            {
                //lblCustomerAddError.Content = "Adding did not goes alright. Please try again";
                //return;
                MessageBox.Show(ex.Message);
            }
        }

        private void TabViewCustomer_GotFocus(object sender, RoutedEventArgs e)
        {
            TabCustomers.Focus();
            DGCustomerView.ItemsSource = null;
            customers.Clear();
            activeCustomers.Clear();
            deactiveCustomers.Clear();
            customers = customersManager.GetAllCustomers();
            

            foreach (Customer customer in customers)
            {
                if (customer.Active == true)
                {
                    activeCustomers.Add(customer);
                }
                else
                {
                    deactiveCustomers.Add(customer);
                }
            }

            DGCustomerView.ItemsSource = activeCustomers;
            DGCustomerDeativeView.ItemsSource = deactiveCustomers;

            switchCanvas("Active");
        }

        private void TabAddCustomer_GotFocus(object sender, RoutedEventArgs e)
        {
            TabAddCustomer.Focus();
            switchCanvas("Add");
        }

        private void btnCustomerEdit_Click(object sender, RoutedEventArgs e)
        {
            if (DGCustomerView.SelectedItem == null)
            {
                lblCustomerError.Content = "Please select a customer first from above grid";
                TabViewCustomer.Focus();
                switchCanvas("Active");
                return;
            } 
            lblCustomerError.Content = "";
            switchCanvas("Edit");

            oldCustomer = (Customer)DGCustomerView.SelectedItem;

            txtCustomerEditFirstName.Text = oldCustomer.FirstName;
            txtCustomerEditMIDName.Text = oldCustomer.MiddleName;
            txtCustomerEditLastName.Text = oldCustomer.LastName;
            txtCustomerEditPhoneNumber.Text = oldCustomer.PhoneNumber;
            txtCustomerEditEmail.Text = oldCustomer.Email;
            txtCustomerEditRegionID.Text = oldCustomer.RegionID;
            txtCustomerEditAddressLine.Text = oldCustomer.AddressLine;
            chkCustomerEditActive.IsChecked = oldCustomer.Active;           

        }

        private void btnCustomerEditSubmit_Click(object sender, RoutedEventArgs e)
        {
            oldCustomer = (Customer)DGCustomerView.SelectedItem;
            NewCustomer = new Customer();
            NewCustomer.CustomerID = oldCustomer.CustomerID;
            NewCustomer.FirstName = txtCustomerEditFirstName.Text;
            NewCustomer.MiddleName = txtCustomerEditMIDName.Text;
            NewCustomer.LastName = txtCustomerEditLastName.Text;
            NewCustomer.PhoneNumber = txtCustomerEditPhoneNumber.Text;
            NewCustomer.Email = txtCustomerEditEmail.Text;
            NewCustomer.RegionID = txtCustomerEditRegionID.Text;
            NewCustomer.AddressLine = txtCustomerEditAddressLine.Text;
            NewCustomer.Active = chkCustomerEditActive.IsChecked.Value;

            if (customersManager.UpdateCustomer(oldCustomer, NewCustomer))
            {
                txtCustomerEditFirstName.Text = "";
                txtCustomerEditMIDName.Text = "";
                txtCustomerEditPhoneNumber.Text = "";
                txtCustomerEditEmail.Text = "";
                txtCustomerEditRegionID.Text = "";
                txtCustomerEditAddressLine.Text = "";
                chkCustomerEditActive.IsChecked = true;

                customers.Clear();
                activeCustomers.Clear();
                deactiveCustomers.Clear();
                customers = customersManager.GetAllCustomers();
                foreach (Customer customer in customers)
                {
                    if (customer.Active == true)
                    {
                        activeCustomers.Add(customer);
                    }
                    else
                    {
                        deactiveCustomers.Add(customer);
                    }
                }

                DGCustomerView.ItemsSource = null;
                DGCustomerDeativeView.ItemsSource = null;
                DGCustomerView.ItemsSource = activeCustomers;
                DGCustomerDeativeView.ItemsSource = deactiveCustomers;

                switchCanvas("Active");

            }
            else
            {
                lblCustomerEditError.Content = "Did not updated yet. please try a gain";
                switchCanvas("Edit");
            }
        }

        private void TabEditCustomer_GotFocus(object sender, RoutedEventArgs e)
        {
            if (DGCustomerView.SelectedItem == null)
            {
                lblCustomerError.Content = "Please select a customer first from above grid";
                TabViewCustomer.Focus();
                switchCanvas("Active");
                return;
            }

            lblCustomerError.Content = "";

            switchCanvas("Edit");

            

            oldCustomer = (Customer)DGCustomerView.SelectedItem;

            txtCustomerEditFirstName.Text = oldCustomer.FirstName;
            txtCustomerEditMIDName.Text = oldCustomer.MiddleName;
            txtCustomerEditLastName.Text = oldCustomer.LastName;
            txtCustomerEditPhoneNumber.Text = oldCustomer.PhoneNumber;
            txtCustomerEditEmail.Text = oldCustomer.Email;
            txtCustomerEditRegionID.Text = oldCustomer.RegionID;
            txtCustomerEditAddressLine.Text = oldCustomer.AddressLine;
            chkCustomerEditActive.IsChecked = oldCustomer.Active;


        }

        private void btnCustomerDelete_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnCustomerActive_Click(object sender, RoutedEventArgs e)
        {
            if (DGCustomerDeativeView.SelectedItem == null)
            {
                lblCustomerDeactiveError.Content = "Please select  a customer";
                return;
            }

            Customer customer = (Customer)DGCustomerDeativeView.SelectedItem;
            try
            {
                customersManager.ActivateCustomer(customer);
                updateCustomersLists();
                updateGrids();
            }
            catch (Exception ex)
            {

                lblCustomerDeactiveError.Content = "There is an error \n" + ex.Message;

            }
        }

        private void updateGrids()
        {
            DGCustomerView.ItemsSource = null;
            DGCustomerDeativeView.ItemsSource = null;
            DGCustomerView.ItemsSource = activeCustomers;
            DGCustomerDeativeView.ItemsSource = deactiveCustomers;
        }

        private void updateCustomersLists()
        {
            customers.Clear();
            activeCustomers.Clear();
            deactiveCustomers.Clear();
            customers = customersManager.GetAllCustomers();
            foreach (Customer customer in customers)
            {
                if (customer.Active == true)
                {
                    activeCustomers.Add(customer);
                }
                else
                {
                    deactiveCustomers.Add(customer);
                }
            }
        }

        private void TabDeactiveCustomers_GotFocus(object sender, RoutedEventArgs e)
        {
            switchCanvas("Deactive");
            updateCustomersLists();
            updateGrids();
        }

        private void switchCanvas(string canvasName) 
        {
            switch (canvasName)
            {
                case "Active":
                    TabCustomers.Focus();

                    CanViewAllCustomer.Visibility = Visibility.Visible;
                    CanCustomerAdd.Visibility = Visibility.Hidden;
                    CanCustomerEdit.Visibility = Visibility.Hidden;
                    CanCustomerDeactive.Visibility = Visibility.Hidden;
                    break;
                case "Add":
                    TabAddCustomer.Focus();

                    CanViewAllCustomer.Visibility = Visibility.Hidden;
                    CanCustomerAdd.Visibility = Visibility.Visible;
                    CanCustomerEdit.Visibility = Visibility.Hidden;
                    CanCustomerDeactive.Visibility = Visibility.Hidden;
                    break;
                case "Edit":
                    TabEditCustomer.Focus();

                    CanViewAllCustomer.Visibility = Visibility.Hidden;
                    CanCustomerAdd.Visibility = Visibility.Hidden;
                    CanCustomerEdit.Visibility = Visibility.Visible;
                    CanCustomerDeactive.Visibility = Visibility.Hidden;
                    break;
                case "Deactive":
                    TabDeactiveCustomers.Focus();

                    CanViewAllCustomer.Visibility = Visibility.Hidden;
                    CanCustomerAdd.Visibility = Visibility.Hidden;
                    CanCustomerEdit.Visibility = Visibility.Hidden;
                    CanCustomerDeactive.Visibility = Visibility.Visible;
                    break;
                default:
                    TabCustomers.Focus();

                    CanViewAllCustomer.Visibility = Visibility.Visible;
                    CanCustomerAdd.Visibility = Visibility.Hidden;
                    CanCustomerEdit.Visibility = Visibility.Hidden;
                    CanCustomerDeactive.Visibility = Visibility.Hidden;
                    break;
            }

        }
    }
}
