using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CarMarketAPI.Models
{
    public class Customer
    {
        public int CustomerID { get; set; }
        
        [Required]
        [StringLength(100)]
        public string FirstName { get; set; }
        
        [Required]
        [StringLength(100)]
        public string LastName { get; set; }
        
        [Required]
        [StringLength(255)]
        [EmailAddress]
        public string Email { get; set; }
        
        [StringLength(20)]
        public string PhoneNumber { get; set; }
        
        [StringLength(255)]
        public string Address { get; set; }
        
        public DateTime DateCreated { get; set; }
        
        public DateTime DateModified { get; set; }
        
        // Navigation properties
        public virtual ICollection<Sale> Sales { get; set; }
        
        public virtual ICollection<Favorite> Favorites { get; set; }
    }
}
