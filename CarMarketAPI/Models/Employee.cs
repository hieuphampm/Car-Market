using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarMarketAPI.Models
{
    public class Employee
    {
        public int EmployeeID { get; set; }
        
        [Required]
        [StringLength(100)]
        public string FirstName { get; set; }
        
        [Required]
        [StringLength(100)]
        public string LastName { get; set; }
        
        [StringLength(50)]
        public string Position { get; set; }
        
        [Column(TypeName = "decimal(10, 2)")]
        public decimal? Salary { get; set; }
        
        public DateTime DateHired { get; set; }
        
        [Required]
        [StringLength(255)]
        [EmailAddress]
        public string Email { get; set; }
        
        [StringLength(20)]
        public string PhoneNumber { get; set; }
    }
}