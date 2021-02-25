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
using System.Windows.Shapes;

namespace DeskTop.Customers
{
    /// <summary>
    /// Interaction logic for Report.xaml
    /// </summary>
    public partial class Report : Window
    {
        public Report()
        {
            InitializeComponent();
            _reportViewer.Load += ReportViewer_Load;
        }
        private bool _isReportViewerLoaded;

        private void ReportViewer_Load(object sender, EventArgs e)
        {
            //if (!_isReportViewerLoaded)
            //{
            //    Microsoft.Reporting.WinForms.ReportDataSource reportDataSource1 = new
            //    Microsoft.Reporting.WinForms.ReportDataSource();
            //   // WpfApplication4DataSet dataset = new WpfApplication4DataSet();

            //    dataset.BeginInit();

            //    reportDataSource1.Name = "DataSet1";
            //    //Name of the report dataset in our .RDLC file

            //    reportDataSource1.Value = dataset.Accounts;
            //    this._reportViewer.LocalReport.DataSources.Add(reportDataSource1);

            //    this._reportViewer.LocalReport.ReportPath = "../../Report.rdlc";
            //    dataset.EndInit();

            //    //fill data into WpfApplication4DataSet
            //  //  WpfApplication4DataSetTableAdapters.AccountsTableAdapter
            //    accountsTableAdapter = new
            //   // WpfApplication4DataSetTableAdapters.AccountsTableAdapter();

            //    accountsTableAdapter.ClearBeforeFill = true;
            //    accountsTableAdapter.Fill(dataset.Accounts);
            //    _reportViewer.RefreshReport();
            //    _isReportViewerLoaded = true;
            //}
        }
    }
}
