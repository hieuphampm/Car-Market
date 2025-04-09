using System;
using System.Collections.Generic;

namespace ClassLibrary.Models;

public partial class CarModel
{
    public int ModelId { get; set; }

    public int ManufacturerId { get; set; }

    public string ModelName { get; set; } = null!;

    public string? Category { get; set; }

    public int? FirstProductionYear { get; set; }

    public int? LastProductionYear { get; set; }

    public DateTime? DateCreated { get; set; }

    public DateTime? DateModified { get; set; }

    public virtual ICollection<Car> Cars { get; set; } = new List<Car>();

    public virtual Manufacturer Manufacturer { get; set; } = null!;
}
