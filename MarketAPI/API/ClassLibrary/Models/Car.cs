using System;
using System.Collections.Generic;

namespace ClassLibrary.Models;

public partial class Car
{
    public int CarId { get; set; }

    public int ModelId { get; set; }

    public int Year { get; set; }

    public decimal Price { get; set; }

    public int Mileage { get; set; }

    public int TransmissionTypeId { get; set; }

    public int FuelTypeId { get; set; }

    public int ColorId { get; set; }

    public string? Vin { get; set; }

    public decimal? EngineSize { get; set; }

    public int? Horsepower { get; set; }

    public int? NumberOfDoors { get; set; }

    public string? Description { get; set; }

    public bool? IsAvailable { get; set; }

    public DateTime? DateAdded { get; set; }

    public DateTime? DateSold { get; set; }

    public DateTime? DateCreated { get; set; }

    public DateTime? DateModified { get; set; }

    public virtual ICollection<CarImage> CarImages { get; set; } = new List<CarImage>();

    public virtual Color Color { get; set; } = null!;

    public virtual ICollection<Favorite> Favorites { get; set; } = new List<Favorite>();

    public virtual FuelType FuelType { get; set; } = null!;

    public virtual CarModel Model { get; set; } = null!;

    public virtual ICollection<Sale> Sales { get; set; } = new List<Sale>();

    public virtual TransmissionType TransmissionType { get; set; } = null!;

    public virtual ICollection<Feature> Features { get; set; } = new List<Feature>();
}
