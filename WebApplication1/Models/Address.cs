using System;
using System.Collections.Generic;

namespace WebApplication1.Models;

public partial class Address
{
    public long AddressId { get; set; }

    public long OrganizationId { get; set; }

    public long AddressTypeId { get; set; }

    public string SubjectName { get; set; } = null!;

    public string CityName { get; set; } = null!;

    public string StreetName { get; set; } = null!;

    public string HouseNumber { get; set; } = null!;

    public string AddInfo { get; set; } = null!;

    public virtual AddressType AddressType { get; set; } = null!;

    public virtual Organization Organization { get; set; } = null!;
}
