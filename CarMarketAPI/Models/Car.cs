using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarMarketAPI.Models
{
    public class Car
    {
        public int CarID { get; set; }
        
        [Required]
        public int ModelID { get; set; }
        
        [Required]
        public int Year { get; set; }
        
        [Required]
        [Column(TypeName = "decimal(12, 2)")]
        public decimal Price { get; set; }
        
        [Required]
        public int Mileage { get; set; }
        
        [Required]
        public int TransmissionTypeID { get; set; }
        
        [Required]
        public int FuelTypeID { get; set; }
        
        [Required]
        public int ColorID { get; set; }
        
        [StringLength(17)]
        public string VIN { get; set; } = string.Empty; // Initialized
        
        [Column(TypeName = "decimal(3, 1)")]
        public decimal? EngineSize { get; set; }
        
        public int? Horsepower { get; set; }
        
        public int? NumberOfDoors { get; set; }
        
        public string Description { get; set; } = string.Empty; // Initialized
        
        public bool IsAvailable { get; set; } = true;
        
        public DateTime DateAdded { get; set; }
        
        public DateTime? DateSold { get; set; }
        
        public DateTime DateCreated { get; set; }
        
        public DateTime DateModified { get; set; }
        
        [ForeignKey("ModelID")]
        public virtual CarModel CarModel { get; set; } = null!; // Non-nullable navigation
        
        [ForeignKey("TransmissionTypeID")]
        public virtual TransmissionType TransmissionType { get; set; } = null!; // Non-nullable navigation
        
        [ForeignKey("FuelTypeID")]
        public virtual FuelType FuelType { get; set; } = null!; // Non-nullable navigation
        
        [ForeignKey("ColorID")]
        public virtual Color Color { get; set; } = null!; // Non-nullable navigation
        
        public virtual ICollection<CarFeature> CarFeatures { get; set; } = new List<CarFeature>(); // Initialized
        
        public virtual ICollection<CarImage> CarImages { get; set; } = new List<CarImage>(); // Initialized
        
        public virtual ICollection<Sale> Sales { get; set; } = new List<Sale>(); // Initialized
        
        public virtual ICollection<Favorite> Favorites { get; set; } = new List<Favorite>(); // Initialized
    }
}