using System;
using System.Collections.Generic;

namespace WebApplication1.Models;

public partial class ServiceRequestDetai
{
    public long ServiceRequestDetailId { get; set; }

    public long ServiceRequestId { get; set; }

    public long ServiceDetailId { get; set; }

    public virtual ServiceDetail ServiceDetail { get; set; } = null!;

    public virtual ServiceRequest ServiceRequest { get; set; } = null!;
}
