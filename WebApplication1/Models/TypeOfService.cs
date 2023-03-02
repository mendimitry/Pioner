using System;
using System.Collections.Generic;

namespace WebApplication1.Models;

public partial class TypeOfService
{
    public long TypeId { get; set; }

    public string TypeCode { get; set; } = null!;

    public string TypeName { get; set; } = null!;

    public virtual ICollection<ServiceDetail> ServiceDetails { get; } = new List<ServiceDetail>();
}
