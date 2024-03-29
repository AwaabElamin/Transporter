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

namespace DeskTop
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        
        public MainWindow()
        {
            
            InitializeComponent();
            
        }

        private void btnCustomer_Click(object sender, RoutedEventArgs e)
        {
            switchScreen("Customer");
        }

        private void switchScreen(string switchScreen)
        {
            switch (switchScreen)
            {
                case "Customer":
                    CanCustomers.Visibility = Visibility.Visible;
                    CanManager.Visibility = Visibility.Hidden;
                    break;
                case "Employee":
                    CanCustomers.Visibility = Visibility.Hidden;
                    CanManager.Visibility = Visibility.Hidden;
                    break;
                case "Manager":
                    CanCustomers.Visibility = Visibility.Hidden;
                    CanManager.Visibility = Visibility.Visible;
                    break;
                default:
                    CanCustomers.Visibility = Visibility.Hidden;
                    CanManager.Visibility = Visibility.Hidden;
                    break;
            }
        }

        private void btnEmployees_Click(object sender, RoutedEventArgs e)
        {
            
            switchScreen("Employee");
        }

        private void btnManager_Click(object sender, RoutedEventArgs e)
        {
            switchScreen("Manager");
        }
    }
}
