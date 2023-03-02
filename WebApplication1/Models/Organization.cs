using System;
using System.Collections.Generic;

namespace WebApplication1.Models;

public partial class Organization
{
    public long OrganizationId { get; set; }

    public string OrganizationFullName { get; set; } = null!;

    public string OrganizationShortName { get; set; } = null!;

    public string Inn { get; set; } = null!;

    public string Kpp { get; set; } = null!;

    public string Ogrn { get; set; } = null!;

    public string ResponsiblePersonSurname { get; set; } = null!;

    public string ResponsiblePersonName { get; set; } = null!;

    public string ResponsiblePersonEmail { get; set; } = null!;

    public string ResponsiblePersonPhoneNumber { get; set; } = null!;

    public string AddInfo { get; set; } = null!;

    public virtual ICollection<Address> Addresses { get; } = new List<Address>();

    public virtual ICollection<ConnectionRequest> ConnectionRequests { get; } = new List<ConnectionRequest>();

    public virtual ICollection<ServiceRequest> ServiceRequests { get; } = new List<ServiceRequest>();
}
