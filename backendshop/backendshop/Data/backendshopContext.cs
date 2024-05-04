using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using backendshop.Models;

namespace backendshop.Data
{
    public class backendshopContext : DbContext
    {
        public backendshopContext (DbContextOptions<backendshopContext> options)
            : base(options)
        {
        }

        public DbSet<backendshop.Models.User> User { get; set; } = default!;
        public DbSet<backendshop.Models.Product> Product { get; set; } = default!;
        public DbSet<backendshop.Models.Cart> Cart { get; set; } = default!;


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Define relationships
            modelBuilder.Entity<Cart>()
                .HasOne(c => c.User)
                .WithMany(u => u.Carts)
                .HasForeignKey(c => c.UserId);

            modelBuilder.Entity<Cart>()
                .HasOne(c => c.Product)
                .WithMany()
                .HasForeignKey(c => c.ProductId);
            modelBuilder.Entity<Product>()
    .Property(p => p.Price)
    .HasColumnType("decimal(18,2)");
        }
    }
}
