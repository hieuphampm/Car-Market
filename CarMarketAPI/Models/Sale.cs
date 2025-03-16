using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarMarketAPI.Models
{
    public class Sale
    {
        public int SaleID { get; set; }
        
        [Required]
        public int CarID { get; set; }
        
        [Required]
        public int CustomerID { get; set; }
        
        public DateTime SaleDate { get; set; }
        
        [Required]
        [Column(TypeName = "decimal(12, 2)")]
        public decimal TotalPrice { get; set; }
        
        [Required]
        [StringLength(50)]
        public string PaymentMethod { get; set; } = string.Empty; // Initialized
        
        // Navigation properties
        [ForeignKey("CarID")]
        public virtual Car Car { get; set; } = null!; // Required relationship
        
        [ForeignKey("CustomerID")]
        public virtual Customer Customer { get; set; } = null!; // Required relationship
    }
}