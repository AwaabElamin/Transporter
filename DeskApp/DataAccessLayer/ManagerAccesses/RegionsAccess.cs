using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayerInterface.ManagerAccessInterfaces;
using DataObjectLayer;

namespace DataAccessLayer.ManagerAccesses
{
    public class RegionsAccess : RegionsInterface
    {
        public RegionsAccess()
        {
            AppData.RegionsFilePath = "F:\\Transporter\\DeskApp\\OLEDB\\region.xlsx";
        }

        public bool insertRegion(Region region)
        {
            bool result = false;
            using (OleDbConnection conn = DBConnection.OLEConnRegions())
            {
                try
                {

                    conn.Open();
                    OleDbCommand cmd = new OleDbCommand();
                    cmd.Connection = conn;
                    //INSERT INTO table_name (column1, column2, column3, ...)
                    //VALUES(value1, value2, value3, ...);
                    cmd.CommandText = @"INSERT INTO [Sheet1$] (RegionID, Description, Active)
                                        
                                       VALUES('" + region.RegionId + "', '" + region.Description + "', '" + region.Active + "');";
                    int rows = cmd.ExecuteNonQuery();
                    if (rows == 1)
                    {
                        result = true;
                    }
                      
                    
                }
                catch (Exception)
                {

                    throw;
                }
                finally
                {
                    conn.Close();
                    conn.Dispose();
                }

            }

            return result;
        }

        public List<Region> selectAllRegions()
        {
            List<Region> regions = new List<Region>();
            using (OleDbConnection conn = DBConnection.OLEConnRegions())
            {
                try
                {

                    conn.Open();
                    OleDbCommand cmd = new OleDbCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = @"select RegionID, Description, Active
                                        
                                       from [Sheet1$];";
                    OleDbDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            //reader[0].ToString();
                            Region region = new Region();
                            region.RegionId = reader[0].ToString();
                            region.Description = reader[1].ToString();
                            region.Active = Convert.ToBoolean(reader[2]);
                            regions.Add(region);
                           
                        }
                        reader.Close();
                    }
                }
                catch (Exception)
                {

                    throw;
                }
                finally
                {
                    conn.Close();
                    conn.Dispose();
                }

            }


            return regions;
        }

        public bool updateRegion(Region oldRegion, Region newRegion)
        {
            bool result = false;

            using (OleDbConnection conn = DBConnection.OLEConnRegions())
            {
                try
                {

                    conn.Open();
                    OleDbCommand cmd = new OleDbCommand();
                    cmd.Connection = conn;
                    //UPDATE table_name
                    //SET column1 = value1, column2 = value2, ...
                    //WHERE condition;
                    cmd.CommandText = @"UPDATE [Sheet1$]" +
                                        "SET " +
                                           "RegionID = '" + newRegion.RegionId + "', " +
                                           "Description = '" + newRegion.Description + "', " +
                                           "Active = '" + newRegion.Active + "' " +
                                        "WHERE " +
                                            "RegionID = '" + oldRegion.RegionId + "' " +
                                        "AND Description = '" + oldRegion.Description + "' " +
                                        "AND Active = '" + oldRegion.Active + "';";
                    int rows = cmd.ExecuteNonQuery();
                    if (rows == 1)
                    {
                        result = true;
                    }


                }
                catch (Exception)
                {

                    throw;
                }
                finally
                {
                    conn.Close();
                    conn.Dispose();
                }

            }

            return result;
        }
    }
}
