using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarMarketAPI.Models
{
    public class CarDetailsDTO
    {
        public int CarID { get; set; }
        public int Year { get; set; }
        public decimal Price { get; set; }
        public int Mileage { get; set; }
        public string ModelName { get; set; } = string.Empty; 
        public string Manufacturer { get; set; } = string.Empty; 
        public string Transmission { get; set; } = string.Empty; 
        public string Fuel { get; set; } = string.Empty; 
        public string Color { get; set; } = string.Empty; 
    }
}