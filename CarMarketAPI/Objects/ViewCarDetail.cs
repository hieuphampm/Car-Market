using System;
using System.Collections.Generic;

namespace Objects;

public partial class ViewCarDetail
{
    public int CarId { get; set; }

    public int Year { get; set; }

    public decimal Price { get; set; }

    public int Mileage { get; set; }

    public string ModelName { get; set; } = null!;

    public string Manufacturer { get; set; } = null!;

    public string Transmission { get; set; } = null!;

    public string Fuel { get; set; } = null!;

    public string Color { get; set; } = null!;
}
