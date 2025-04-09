using System;
using System.Collections.Generic;

namespace Objects;

public partial class TransmissionType
{
    public int TransmissionTypeId { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Car> Cars { get; set; } = new List<Car>();
}
