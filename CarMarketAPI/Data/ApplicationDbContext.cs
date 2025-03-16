// Data/ApplicationDbContext.cs
using CarMarketAPI.Models;
using Microsoft.EntityFrameworkCore;
using System;

namespace CarMarketAPI.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Manufacturer> Manufacturers { get; set; }
        public DbSet<CarModel> CarModels { get; set; }
        public DbSet<TransmissionType> TransmissionTypes { get; set; }
        public DbSet<FuelType> FuelTypes { get; set; }
        public DbSet<Color> Colors { get; set; }
        public DbSet<Car> Cars { get; set; }
        public DbSet<Feature> Features { get; set; }
        public DbSet<CarFeature> CarFeatures { get; set; }
        public DbSet<CarImage> CarImages { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Sale> Sales { get; set; }
        public DbSet<Employee> Employees { get; set; }
        public DbSet<Favorite> Favorites { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configure composite key for CarFeature
            modelBuilder.Entity<CarFeature>()
                .HasKey(cf => new { cf.CarID, cf.FeatureID });

            // Configure relationships
            modelBuilder.Entity<CarFeature>()
                .HasOne(cf => cf.Car)
                .WithMany(c => c.CarFeatures)
                .HasForeignKey(cf => cf.CarID);

            modelBuilder.Entity<CarFeature>()
                .HasOne(cf => cf.Feature)
                .WithMany(f => f.CarFeatures)
                .HasForeignKey(cf => cf.FeatureID);

            // Configure unique constraints
            modelBuilder.Entity<Car>()
                .HasIndex(c => c.VIN)
                .IsUnique();

            modelBuilder.Entity<Customer>()
                .HasIndex(c => c.Email)
                .IsUnique();

            modelBuilder.Entity<Employee>()
                .HasIndex(e => e.Email)
                .IsUnique();

            // Configure default values
            modelBuilder.Entity<Car>()
                .Property(c => c.IsAvailable)
                .HasDefaultValue(true);

            modelBuilder.Entity<CarImage>()
                .Property(ci => ci.IsPrimary)
                .HasDefaultValue(false);

            modelBuilder.Entity<Car>()
                .Property(c => c.DateAdded)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<Car>()
                .Property(c => c.DateCreated)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<Car>()
                .Property(c => c.DateModified)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CarModel>()
                .Property(cm => cm.DateCreated)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CarModel>()
                .Property(cm => cm.DateModified)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<Manufacturer>()
                .Property(m => m.DateCreated)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<Manufacturer>()
                .Property(m => m.DateModified)
                .HasDefaultValueSql("GETDATE()");

             modelBuilder.Entity<Customer>()
                .Property(c => c.DateCreated)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<Customer>()
                .Property(c => c.DateModified)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<Favorite>()
                .Property(f => f.DateAdded)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<Sale>()
                .Property(s => s.SaleDate)
                .HasDefaultValueSql("GETDATE()");

            modelBuilder.Entity<CarImage>()
                .Property(ci => ci.UploadDate)
                .HasDefaultValueSql("GETDATE()");
        }
    }
}