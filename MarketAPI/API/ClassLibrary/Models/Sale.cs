using System;
using System.Collections.Generic;

namespace ClassLibrary.Models;

public partial class Sale
{
    public int SaleId { get; set; }

    public int CarId { get; set; }

    public int CustomerId { get; set; }

    public DateTime? SaleDate { get; set; }

    public decimal TotalPrice { get; set; }

    public string PaymentMethod { get; set; } = null!;

    public virtual Car Car { get; set; } = null!;

    public virtual Customer Customer { get; set; } = null!;
}
