using System;
using System.Collections.Generic;

namespace WebApplication1.Models;

public partial class AddressType
{
    public long AddressTypeId { get; set; }

    public string AddressTypeName { get; set; } = null!;

    public virtual ICollection<Address> Addresses { get; } = new List<Address>();
}
