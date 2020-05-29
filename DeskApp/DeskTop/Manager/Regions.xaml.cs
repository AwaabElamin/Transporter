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
using LogicLayerInterface.Manager;
using LogicLayer.Manager;
using System.Diagnostics;
using DataObjectLayer;

namespace DeskTop.Manager
{
    /// <summary>
    /// Interaction logic for Regions.xaml
    /// </summary>
    public partial class Regions : Page
    {
        private RegionsManagerInterface regionsManager = null;
        private Region Oldregion = null;
        public Regions()
        {
            regionsManager = new RegionsManager();
            InitializeComponent();
           
        }

       

        private void switchCanvas(string canvasName)
        {
            switch (canvasName)
            {
                case "All":

                    txtRegionAddID.Text = "";
                    txtRegionAddDesription.Text = "";
                    lblRegionAddError.Content = "";
                    chkRegionAddActive.IsChecked = true;

                    lblRegionEditError.Content = "";
                    lblRegionError.Content = "";
                    DGRegionsView.SelectedItem = null;
                    txtRegionEditID.Text = "";
                    txtRegionEditDesription.Text = "";

                    CanViewAllRegions.Visibility = Visibility.Visible;
                    CanAddRegion.Visibility = Visibility.Hidden;
                    CanEditRegion.Visibility = Visibility.Hidden;

                    TabRegionsView.Focus();

                    DGRegionsView.ItemsSource = regionsManager.retrieveAllRegions();
                    break;
                case "Add":
                   
                    

                    CanViewAllRegions.Visibility = Visibility.Hidden;
                    CanAddRegion.Visibility = Visibility.Visible;
                    CanEditRegion.Visibility = Visibility.Hidden;

                    TabRegionsAdd.Focus();

                    DGRegionsView.ItemsSource = regionsManager.retrieveAllRegions();
                    break;
                case "Edit":
                    if (DGRegionsView.SelectedItem == null)
                    {
                        TabRegionsView.Focus();
                        lblRegionError.Content = "Please Select a region first";
                        CanViewAllRegions.Visibility = Visibility.Visible;
                        CanAddRegion.Visibility = Visibility.Hidden;
                        CanEditRegion.Visibility = Visibility.Hidden;
                        return;
                    }
                    lblRegionError.Content = "";
                    Oldregion = (Region)DGRegionsView.SelectedItem;
                    txtRegionEditID.Text = Oldregion.RegionId;
                    txtRegionEditDesription.Text = Oldregion.Description;
                    chkRegionAddActive.IsChecked = Oldregion.Active;

                    CanViewAllRegions.Visibility = Visibility.Hidden;
                    CanAddRegion.Visibility = Visibility.Hidden;
                    CanEditRegion.Visibility = Visibility.Visible;

                    TabRegionsEdit.Focus();

                    DGRegionsView.ItemsSource = regionsManager.retrieveAllRegions();
                    break;
                default:
                    CanRegionsView.Visibility = Visibility.Visible;
                    CanAddRegion.Visibility = Visibility.Hidden;
                    TabRegionsView.Focus();
                    DGRegionsView.ItemsSource = regionsManager.retrieveAllRegions();
                    break;
            }
        }

        

        private void btnRegionInsert_Click(object sender, RoutedEventArgs e)
        {
            switchCanvas("Add");
        }

        private void btnRegionEdit_Click(object sender, RoutedEventArgs e)
        {
            
            switchCanvas("Edit");
            
        }

        private void btnRegionAddSubmit_Click(object sender, RoutedEventArgs e)
        {
            if (Validation.isEmpty(txtRegionAddID.Text))
            {
                lblRegionAddError.Content = "Please fill out the region ID";
                return;
            }
            if (Validation.isEmpty(txtRegionAddDesription.Text))
            {
                lblRegionAddError.Content = "Please fill out the region Description";
                return;
            }
            lblRegionAddError.Content = "";

            Region region = new Region();
            region.RegionId = txtRegionAddID.Text;
            region.Description = txtRegionAddDesription.Text;
            region.Active = chkRegionAddActive.IsChecked.Value;

            try
            {
                if (regionsManager.addRegion(region))
                {
                    
                    switchCanvas("All");
                }
                else
                {
                    lblRegionAddError.Content = "this region didn't added, please try again";
                    return;
                }
            }
            catch (Exception ex)
            {

                lblRegionAddError.Content = ex.Message;
                return;
            }
        }

        private void TabViewRegion_GotFocus(object sender, RoutedEventArgs e)
        {
            switchCanvas("All");
        }

        private void TabRegionDeactive_GotFocus(object sender, RoutedEventArgs e)
        {

        }

        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
           
            DGRegionsView.ItemsSource = regionsManager.retrieveAllRegions();
           
        }

        private void TabAddRegion_GotFocus(object sender, RoutedEventArgs e)
        {
            switchCanvas("Add");
        }

        private void btnRegionEditSubmit_Click(object sender, RoutedEventArgs e)
        {
            Region newRegion = new Region();
            newRegion.RegionId = txtRegionEditID.Text;
            newRegion.Description = txtRegionEditDesription.Text;
            newRegion.Active = chkRegionEditActive.IsChecked.Value;
            try
            {
                if (regionsManager.editRegion(Oldregion, newRegion))
                {

                    switchCanvas("All");
                }
                else
                {
                    lblRegionEditError.Content = "this region didn't edited correctly, please try again";
                    return;
                }
            }
            catch (Exception ex)
            {

                lblRegionEditError.Content = ex.Message ;
                return;
            }
           
        }

        private void TabEditRegion_GotFocus(object sender, RoutedEventArgs e)
        {
           
            switchCanvas("Edit");

        }

        private void btnRegionActive_Click(object sender, RoutedEventArgs e)
        {
            List<Region> regions = new List<Region>();
            regions = regionsManager.retrieveAllRegions();
            DGRegionsView.ItemsSource = null;
            List<Region> activeRegions = new List<Region>();
            foreach (var item in regions)
            {
                if (item.Active)
                {
                    activeRegions.Add(item);
                }
            }
            DGRegionsView.ItemsSource = activeRegions;
            
        }

        private void btnRegionDeactive_Click(object sender, RoutedEventArgs e)
        {
            List<Region> regions = new List<Region>();
            regions = regionsManager.retrieveAllRegions();
            
            DGRegionsView.ItemsSource = null;
            List<Region> deactiveRegions = new List<Region>();
            foreach (var item in regions)
            {
                if (!(item.Active))
                {
                    deactiveRegions.Add(item);
                }
            }
            DGRegionsView.ItemsSource = deactiveRegions;
        }

        private void btnRegionAll_Click(object sender, RoutedEventArgs e)
        {
            List<Region> regions = new List<Region>();
            regions = regionsManager.retrieveAllRegions();

            DGRegionsView.ItemsSource = null;
           
            DGRegionsView.ItemsSource = regions;
        }
    }
}
