using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backendshop.Models
{
    [Table("Cart")]
    public class Cart
    {

        public int Id { get; set; }
        public int UserId { get; set; }
        public User? User { get; set; }
        public int ProductId { get; set; }
        public Product? Product { get; }
        public int quantity { get; set; }
    }
}
