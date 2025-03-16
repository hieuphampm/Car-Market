using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarMarketAPI.Models
{
    public class Favorite
    {
        public int FavoriteID { get; set; }
        
        [Required]
        public int CustomerID { get; set; }
        
        [Required]
        public int CarID { get; set; }
        
        public DateTime DateAdded { get; set; }
        
        // Navigation properties
        [ForeignKey("CustomerID")]
        public virtual Customer Customer { get; set; }
        
        [ForeignKey("CarID")]
        public virtual Car Car { get; set; }
    }
}