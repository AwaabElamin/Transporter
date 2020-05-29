using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataObjectLayer;

namespace LogicLayerInterface.Manager
{
    
   public interface RegionsManagerInterface
    {
        List<Region> retrieveAllRegions();
        bool addRegion(Region region);
        bool editRegion(Region oldregion, Region newRegion);
    }
}
