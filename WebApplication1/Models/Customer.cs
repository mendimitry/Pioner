using System;
using System.Collections.Generic;

namespace WebApplication1.Models;

public partial class Customer
{
    public long CustomerId { get; set; }

    public string CustomerSurname { get; set; } = null!;

    public string CustomerName { get; set; } = null!;

    public string CustomerPhoneNumber { get; set; } = null!;

    public virtual ICollection<ServiceRequest> ServiceRequests { get; } = new List<ServiceRequest>();
}
