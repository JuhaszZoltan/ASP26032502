using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ASP26032502.Models;

public partial class Department
{
    [Key]
    [Column("department_id")]
    public int DepartmentId { get; set; }

    [Column("name")]
    [StringLength(100)]
    public string Name { get; set; } = null!;

    [Column("size_sm")]
    public int? SizeSm { get; set; }

    [InverseProperty("Department")]
    public virtual ICollection<Animal> Animals { get; set; } = new List<Animal>();
}
