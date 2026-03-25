using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;

namespace ASP26032502.Models;

public partial class Animal
{
    [Key]
    [Column("animal_id")]
    public int AnimalId { get; set; }

    [Column("name")]
    [StringLength(50)]
    public string? Name { get; set; }

    [Column("species")]
    [StringLength(50)]
    public string Species { get; set; } = null!;

    [Column("age")]
    public double Age { get; set; }

    [Column("department_id")]
    [JsonIgnore]
    [ValidateNever]
    public int? DepartmentId { get; set; }

    [Column("zookeeper_id")]
    [JsonIgnore]
    [ValidateNever]
    public int? ZookeeperId { get; set; }

    [ForeignKey("DepartmentId")]
    [InverseProperty("Animals")]
    [JsonIgnore]
    [ValidateNever]
    public virtual Department? Department { get; set; }

    [ForeignKey("ZookeeperId")]
    [InverseProperty("Animals")]
    [JsonIgnore]
    [ValidateNever]
    public virtual Zookeeper? Zookeeper { get; set; }
}
