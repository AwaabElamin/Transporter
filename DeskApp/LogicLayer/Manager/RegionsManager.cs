using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LogicLayerInterface.Manager;
using DataObjectLayer;
using DataAccessLayerInterface;
using DataAccessLayer;
using DataAccessLayerInterface.ManagerAccessInterfaces;
using DataAccessLayer.ManagerAccesses;

namespace LogicLayer.Manager
{
    public class RegionsManager : RegionsManagerInterface
    {
        private RegionsInterface regionsAccessor = null;
        public RegionsManager()
        {
            regionsAccessor = new RegionsAccess();
        }

        public bool addRegion(Region region)
        {
            bool result = false;
            try
            {
                result = regionsAccessor.insertRegion(region);
            }
            catch (Exception)
            {

                throw;
            }

            return result;
        }

        public bool editRegion(Region oldregion, Region newRegion)
        {
            bool result = false;

            try
            {
                result = regionsAccessor.updateRegion(oldregion, newRegion);
            }
            catch (Exception)
            {

                throw;
            }


            return result;
        }

        public List<Region> retrieveAllRegions()
        {
            List<Region> regions = new List<Region>();
            try
            {
                regions = regionsAccessor.selectAllRegions();
            }
            catch (Exception)
            {

                throw;
            }

            return regions;
        }
    }
}
