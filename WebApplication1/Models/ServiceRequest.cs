using System;
using System.Collections.Generic;

namespace WebApplication1.Models;

public partial class ServiceRequest
{
    public long ServiceRequestId { get; set; }

    public long CustomerId { get; set; }

    public long OrganizationId { get; set; }

    public string DateService { get; set; } = null!;

    public long ServiceDetailCost { get; set; }

    public long ServiceDetailDuration { get; set; }

    public virtual Customer Customer { get; set; } = null!;

    public virtual Organization Organization { get; set; } = null!;

    public virtual ICollection<ServiceRequestDetai> ServiceRequestDetais { get; } = new List<ServiceRequestDetai>();
}
