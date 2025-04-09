using System;
using System.Collections.Generic;

namespace Objects;

public partial class Favorite
{
    public int FavoriteId { get; set; }

    public int CustomerId { get; set; }

    public int CarId { get; set; }

    public DateTime? DateAdded { get; set; }

    public virtual Car Car { get; set; } = null!;

    public virtual Customer Customer { get; set; } = null!;
}
