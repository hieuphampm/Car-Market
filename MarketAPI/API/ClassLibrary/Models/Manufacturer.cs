using System;
using System.Collections.Generic;

namespace ClassLibrary.Models;

public partial class Manufacturer
{
    public int ManufacturerId { get; set; }

    public string Name { get; set; } = null!;

    public string? Country { get; set; }

    public int? FoundedYear { get; set; }

    public string? Website { get; set; }

    public string? LogoUrl { get; set; }

    public DateTime? DateCreated { get; set; }

    public DateTime? DateModified { get; set; }

    public virtual ICollection<CarModel> CarModels { get; set; } = new List<CarModel>();
}
