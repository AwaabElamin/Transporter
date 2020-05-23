using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataObjectLayer;

namespace DataAccessLayer
{
    /// <summary>
    /// DBConnection provides static methods specify in connection to dbs types
    /// </summary>
    public class DBConnection
    {
        /// <summary>
        /// OLEConn connect to an excel sheet using OLEDBConnection
        /// </summary>
        /// <remarks>
        /// created by Awaab Elamin on 5/21/2020
        /// reviewed by
        /// </remarks>
        public static OleDbConnection OLEConn() {

            // Connect EXCEL sheet with OLEDB using connection string
            OleDbConnection oleDb = new OleDbConnection();

            //connectionString contains the string path and connection
            String connectionString = "";

            //check the extention of file to see if it xls or xlsx
            FileInfo file = new FileInfo(AppData.FilePath);
            if (file.Extension == ".xls")
            {
                // if the File extension is .XLS using below connection string
                //In following sample 'szFilePath' is the variable for filePath
                connectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source = '" + AppData.FilePath + "'; Extended Properties=\"Excel 8.0;HDR=YES;\"";
                oleDb = new OleDbConnection(connectionString);
            }
            else if (file.Extension == ".xlsx")
            {
                // if the File extension is .XLSX using below connection string
                connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source='" + AppData.FilePath + "';Extended Properties=\"Excel 12.0;HDR=YES;\"";
                oleDb = new OleDbConnection(connectionString);
            }
            
            //Note: here should have an else to assgine a value to connectionString if it is not has above Extensions

            

            return oleDb;
        
        }
    }
}
