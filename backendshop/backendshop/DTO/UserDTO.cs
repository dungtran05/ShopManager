using System.ComponentModel.DataAnnotations;

namespace backendshop.DTO
{
    public class UserDTO
    {
        [Required]
        public string? FirstName { get; set; }
        [Required]
        public string? LastName { get; set; }
        [Required]
        [StringLength(100)]
        public string? UserName { get; set; }
        [Required]
        [StringLength(100)]
        public string? Password { get; set; }

       
    }
}
