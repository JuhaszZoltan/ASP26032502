using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ASP26032502.Models;

public partial class Zookeeper
{
    [Key]
    [Column("zookeeper_id")]
    public int ZookeeperId { get; set; }

    [Column("name")]
    [StringLength(100)]
    public string Name { get; set; } = null!;

    [Column("expertise")]
    [StringLength(100)]
    public string? Expertise { get; set; }

    [InverseProperty("Zookeeper")]
    public virtual ICollection<Animal> Animals { get; set; } = new List<Animal>();
}
