using System;
using System.Collections.Generic;

namespace Objects;

public partial class Feature
{
    public int FeatureId { get; set; }

    public string Name { get; set; } = null!;

    public string? Category { get; set; }

    public virtual ICollection<Car> Cars { get; set; } = new List<Car>();
}
