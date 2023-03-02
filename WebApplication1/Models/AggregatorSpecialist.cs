using System;
using System.Collections.Generic;

namespace WebApplication1.Models;

public partial class AggregatorSpecialist
{
    public long AggregatorSpecialistsId { get; set; }

    public string AggregatorSpecialistSurname { get; set; } = null!;

    public string AggregatorSpecialistName { get; set; } = null!;

    public string AggregatorSpecialistsDepartment { get; set; } = null!;

    public string AggregatorSpecialistsPosition { get; set; } = null!;

    public string AggregatorSpecialistsPhoneNumber { get; set; } = null!;

    public virtual ICollection<AggregatorSpecialistConnectorRequest> AggregatorSpecialistConnectorRequests { get; } = new List<AggregatorSpecialistConnectorRequest>();
}
