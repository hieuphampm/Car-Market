using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarMarketAPI.Models
{
    public class CarImage
    {
        [Key] // Add this attribute to explicitly define ImageID as the primary key
        public int ImageID { get; set; }
        
        [Required]
        public int CarID { get; set; }
        
        [Required]
        [StringLength(255)]
        public string ImageURL { get; set; }
        
        public bool IsPrimary { get; set; } = false;
        
        public DateTime UploadDate { get; set; }
        
        [ForeignKey("CarID")]
        public virtual Car Car { get; set; }
    }
}