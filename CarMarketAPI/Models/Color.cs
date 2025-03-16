using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CarMarketAPI.Models
{
    public class Color
    {
        public int ColorID { get; set; }
        
        [Required]
        [StringLength(50)]
        public string Name { get; set; }
        
        [StringLength(7)]
        public string HexCode { get; set; }
        
        // Navigation properties
        public virtual ICollection<Car> Cars { get; set; }
    }
}