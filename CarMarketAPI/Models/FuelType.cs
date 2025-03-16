using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CarMarketAPI.Models
{
    public class FuelType
    {
        public int FuelTypeID { get; set; }
        
        [Required]
        [StringLength(50)]
        public string Name { get; set; } = string.Empty; // Initialized
        
        // Navigation properties
        public virtual ICollection<Car> Cars { get; set; } = new List<Car>(); // Initialized
    }
}