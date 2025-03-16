using System.ComponentModel.DataAnnotations.Schema;

namespace CarMarketAPI.Models
{
    public class CarFeature
    {
        public int CarID { get; set; }
        
        public int FeatureID { get; set; }
        
        [ForeignKey("CarID")]
        public virtual Car Car { get; set; } = null!; // Non-nullable navigation
        
        [ForeignKey("FeatureID")]
        public virtual Feature Feature { get; set; } = null!; // Non-nullable navigation
    }
}