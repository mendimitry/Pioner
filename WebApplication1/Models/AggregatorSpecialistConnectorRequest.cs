using System;
using System.Collections.Generic;

namespace WebApplication1.Models;

public partial class AggregatorSpecialistConnectorRequest
{
    public long AggregatorSpecialistConnectorRequestId { get; set; }

    public long AggregatorSpecialistsId { get; set; }

    public long ConnectionRequestId { get; set; }

    public virtual AggregatorSpecialist AggregatorSpecialists { get; set; } = null!;

    public virtual ConnectionRequest ConnectionRequest { get; set; } = null!;
}
