using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarMarketAPI.Models
{
    public class CarModel
    {
        [Key] // Add this to explicitly define ModelID as the primary key
        public int ModelID { get; set; }
        
        [Required]
        public int ManufacturerID { get; set; }
        
        [Required]
        [StringLength(100)]
        public string ModelName { get; set; }
        
        [StringLength(50)]
        public string Category { get; set; }
        
        public int? FirstProductionYear { get; set; }
        
        public int? LastProductionYear { get; set; }
        
        public DateTime DateCreated { get; set; }
        
        public DateTime DateModified { get; set; }
        
        [ForeignKey("ManufacturerID")]
        public virtual Manufacturer Manufacturer { get; set; }
        
        public virtual ICollection<Car> Cars { get; set; }
    }
}