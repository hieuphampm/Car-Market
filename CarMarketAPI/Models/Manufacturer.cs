using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CarMarketAPI.Models
{
    public class Manufacturer
    {
        public int ManufacturerID { get; set; }
        
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty; // Initialized
        
        [StringLength(100)]
        public string Country { get; set; } = string.Empty; // Initialized
        
        public int? FoundedYear { get; set; }
        
        [StringLength(255)]
        public string Website { get; set; } = string.Empty; // Initialized
        
        [StringLength(255)]
        public string LogoURL { get; set; } = string.Empty; // Initialized
        
        public DateTime DateCreated { get; set; }
        
        public DateTime DateModified { get; set; }
        
        // Navigation properties
        public virtual ICollection<CarModel> CarModels { get; set; } = new List<CarModel>(); // Initialized
    }
}