using System;
using System.Collections.Generic;

namespace ClassLibrary.Models;

public partial class Color
{
    public int ColorId { get; set; }

    public string Name { get; set; } = null!;

    public string? HexCode { get; set; }

    public virtual ICollection<Car> Cars { get; set; } = new List<Car>();
}
