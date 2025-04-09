using System;
using System.Collections.Generic;

namespace ClassLibrary.Models;

public partial class FuelType
{
    public int FuelTypeId { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Car> Cars { get; set; } = new List<Car>();
}
