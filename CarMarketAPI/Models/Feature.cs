using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CarMarketAPI.Models
{
    public class Feature
    {
        public int FeatureID { get; set; }
        
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty; // Initialized
        
        [StringLength(50)]
        public string Category { get; set; } = string.Empty; // Initialized
        
        public virtual ICollection<CarFeature> CarFeatures { get; set; } = new List<CarFeature>(); // Initialized
    }
}