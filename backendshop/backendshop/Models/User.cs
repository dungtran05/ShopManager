using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backendshop.Models
{
    [Table("User")]
    public class User
    {
        
        public int ID { get; set; }
        [Required]
        public string? FirstName {  get; set; }
        [Required]
        public string? LastName { get; set; }   
        [Required]
        [StringLength(100)]
        public string? UserName { get;set; }
        [Required]
        [StringLength(100)]
        public string? Password { get; set; }

        public List<Cart>? Carts { get; set;} 
    }
}
