using System;
using System.Collections.Generic;

namespace WebApplication1.Models;

public partial class ServiceDetail
{
    public long ServiceDetailId { get; set; }

    public long TypeId { get; set; }

    public string ServiceDetailCode { get; set; } = null!;

    public string ServiceDetailName { get; set; } = null!;

    public long ServiceDetailCost { get; set; }

    public long ServiceDetailDuration { get; set; }

    public string AddInfo { get; set; } = null!;

    public virtual ICollection<ServiceRequestDetai> ServiceRequestDetais { get; } = new List<ServiceRequestDetai>();

    public virtual TypeOfService Type { get; set; } = null!;
}
