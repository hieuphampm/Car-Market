using System;
using System.Collections.Generic;

namespace Objects;

public partial class Employee
{
    public int EmployeeId { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string? Position { get; set; }

    public decimal? Salary { get; set; }

    public DateTime? DateHired { get; set; }

    public string Email { get; set; } = null!;

    public string? PhoneNumber { get; set; }
}
