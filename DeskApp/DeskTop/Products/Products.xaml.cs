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
using System.Text.RegularExpressions;

namespace DeskTop.Products
{
    /// <summary>
    /// Interaction logic for Products.xaml
    /// </summary>
    public partial class Products : Page
    {
        private IProductManager productManager;
        private Product oldProduct = null;
        private Product NewProduct = null;
        private List<Product> products = new List<Product>();
        private List<Product> activeProducts = new List<Product>();
        private List<Product> deactiveProducts = new List<Product>();
        public Products()
        {
            productManager = new ProductManager();
            InitializeComponent();
            dgAdoptionApplicationsAappointmentsList.ItemsSource = null;
            products.Clear();
            activeProducts.Clear();
            deactiveProducts.Clear();
            products = productManager.GetAllProducts();

            foreach (Product product in products)
            {
                if (product.Active == true)
                {
                    activeProducts.Add(product);
                }
                else
                {
                    deactiveProducts.Add(product);
                }
            }
            dgAdoptionApplicationsAappointmentsList.ItemsSource = activeProducts;

            dgAdoptionApplicationsAappointmentsList.ItemsSource = deactiveProducts;
        }

        private void btnOpen_Click(object sender, RoutedEventArgs e)
        {

        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            dgAdoptionApplicationsAappointmentsList.ItemsSource = productManager.GetAllProducts();
        }
    }
}
