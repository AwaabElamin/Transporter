using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataObjectLayer;

namespace DataAccessLayerInterface.ManagerAccessInterfaces
{
    public interface RegionsInterface
    {
        List<Region> selectAllRegions();
        bool insertRegion(Region region);
        bool updateRegion(Region oldregion, Region newRegion);
    }
}
