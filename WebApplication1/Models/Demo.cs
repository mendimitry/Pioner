using System;
using System.Collections.Generic;

namespace WebApplication1.Models;

public partial class Demo
{
    public long Id { get; set; }

    public string Name { get; set; } = null!;

    public string Hint { get; set; } = null!;
}
