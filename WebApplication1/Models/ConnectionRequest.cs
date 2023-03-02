using System;
using System.Collections.Generic;

namespace WebApplication1.Models;

public partial class ConnectionRequest
{
    public long ConnectionRequestId { get; set; }

    public long OrganizationId { get; set; }

    public string RegNumber { get; set; } = null!;

    public string DateBegin { get; set; } = null!;

    public string Status { get; set; } = null!;

    public virtual ICollection<AggregatorSpecialistConnectorRequest> AggregatorSpecialistConnectorRequests { get; } = new List<AggregatorSpecialistConnectorRequest>();

    public virtual Organization Organization { get; set; } = null!;
}
