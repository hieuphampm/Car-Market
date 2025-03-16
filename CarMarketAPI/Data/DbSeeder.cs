using CarMarketAPI.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CarMarketAPI.Data
{
    public class DbSeeder
    {
        public static async Task SeedDatabaseAsync(IServiceProvider serviceProvider)
        {
            using var scope = serviceProvider.CreateScope();
            var services = scope.ServiceProvider;
            
            try
            {
                var context = services.GetRequiredService<ApplicationDbContext>();
                await context.Database.MigrateAsync();
                
                // Only seed if tables are empty
                if (!await context.TransmissionTypes.AnyAsync())
                {
                    await SeedTransmissionTypesAsync(context);
                }
                
                if (!await context.FuelTypes.AnyAsync())
                {
                    await SeedFuelTypesAsync(context);
                }
                
                if (!await context.Colors.AnyAsync())
                {
                    await SeedColorsAsync(context);
                }
                
                if (!await context.Features.AnyAsync())
                {
                    await SeedFeaturesAsync(context);
                }
                
                if (!await context.Manufacturers.AnyAsync())
                {
                    await SeedManufacturersAsync(context);
                }
                
                if (!await context.CarModels.AnyAsync())
                {
                    await SeedCarModelsAsync(context);
                }
                
                if (!await context.Cars.AnyAsync())
                {
                    await SeedCarsAsync(context);
                }
                
                if (!await context.CarFeatures.AnyAsync())
                {
                    await SeedCarFeaturesAsync(context);
                }
                
                if (!await context.CarImages.AnyAsync())
                {
                    await SeedCarImagesAsync(context);
                }
            }
            catch (Exception ex)
            {
                var logger = services.GetRequiredService<ILogger<DbSeeder>>();
                logger.LogError(ex, "An error occurred while seeding the database.");
                throw;
            }
        }
        
        private static async Task SeedTransmissionTypesAsync(ApplicationDbContext context)
        {
            var transmissionTypes = new List<TransmissionType>
            {
                new TransmissionType { Name = "Automatic" },
                new TransmissionType { Name = "Manual" },
                new TransmissionType { Name = "CVT" }
            };
            
            await context.TransmissionTypes.AddRangeAsync(transmissionTypes);
            await context.SaveChangesAsync();
        }
        
        private static async Task SeedFuelTypesAsync(ApplicationDbContext context)
        {
            var fuelTypes = new List<FuelType>
            {
                new FuelType { Name = "Gasoline" },
                new FuelType { Name = "Diesel" },
                new FuelType { Name = "Electric" },
                new FuelType { Name = "Hybrid" }
            };
            
            await context.FuelTypes.AddRangeAsync(fuelTypes);
            await context.SaveChangesAsync();
        }
        
        private static async Task SeedColorsAsync(ApplicationDbContext context)
        {
            var colors = new List<Color>
            {
                new Color { Name = "Red", HexCode = "#FF0000" },
                new Color { Name = "Blue", HexCode = "#0000FF" },
                new Color { Name = "Black", HexCode = "#000000" },
                new Color { Name = "White", HexCode = "#FFFFFF" },
                new Color { Name = "Silver", HexCode = "#C0C0C0" }
            };
            
            await context.Colors.AddRangeAsync(colors);
            await context.SaveChangesAsync();
        }
        
        private static async Task SeedFeaturesAsync(ApplicationDbContext context)
        {
            var features = new List<Feature>
            {
                new Feature { Name = "ABS", Category = "Safety" },
                new Feature { Name = "Air Conditioning", Category = "Comfort" },
                new Feature { Name = "Sunroof", Category = "Luxury" },
                new Feature { Name = "GPS Navigation", Category = "Technology" },
                new Feature { Name = "Backup Camera", Category = "Safety" }
            };
            
            await context.Features.AddRangeAsync(features);
            await context.SaveChangesAsync();
        }
        
        private static async Task SeedManufacturersAsync(ApplicationDbContext context)
        {
            var manufacturers = new List<Manufacturer>
            {
                new Manufacturer
                {
                    Name = "Porsche",
                    Country = "Germany",
                    FoundedYear = 1931,
                    Website = "https://www.porsche.com",
                    LogoURL = "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Fporsche-seeklogo.png?alt=media&token=53f50dae-4d5d-4e2e-abb2-acab7d5a06c7",
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                },
                new Manufacturer
                {
                    Name = "Chevrolet",
                    Country = "USA",
                    FoundedYear = 1911,
                    Website = "https://www.chevrolet.com",
                    LogoURL = "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Fchevrolet-seeklogo.png?alt=media&token=27623d33-aace-4622-b7ac-d0761bf09ca8",
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                },
                new Manufacturer
                {
                    Name = "Ford",
                    Country = "USA",
                    FoundedYear = 1903,
                    Website = "https://www.ford.com",
                    LogoURL = "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Fford-seeklogo.png?alt=media&token=596173bd-295c-4586-8bfc-63288e2995b1",
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                },
                new Manufacturer
                {
                    Name = "Honda",
                    Country = "Japan",
                    FoundedYear = 1948,
                    Website = "https://www.honda.com",
                    LogoURL = "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Fhonda-seeklogo.png?alt=media&token=83f2f641-4d72-4ba4-8aae-ba7849bdfa64",
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                },
                new Manufacturer
                {
                    Name = "Toyota",
                    Country = "Japan",
                    FoundedYear = 1937,
                    Website = "https://www.toyota.com",
                    LogoURL = "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Ftoyota-seeklogo.png?alt=media&token=16e5eca2-0686-4e0c-95e4-47a627ff98a3",
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                }
            };
            
            await context.Manufacturers.AddRangeAsync(manufacturers);
            await context.SaveChangesAsync();
        }
        
        private static async Task SeedCarModelsAsync(ApplicationDbContext context)
        {
            var carModels = new List<CarModel>
            {
                new CarModel
                {
                    ManufacturerID = 1, // Porsche
                    ModelName = "911 GT3 Touring",
                    Category = "Sports Car",
                    FirstProductionYear = 2022,
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                },
                new CarModel
                {
                    ManufacturerID = 2, // Chevrolet
                    ModelName = "Corvette Stingray Coupe",
                    Category = "Sports Car",
                    FirstProductionYear = 2021,
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                },
                new CarModel
                {
                    ManufacturerID = 3, // Ford
                    ModelName = "Focus RS",
                    Category = "Hatchback",
                    FirstProductionYear = 2016,
                    LastProductionYear = 2018,
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                },
                new CarModel
                {
                    ManufacturerID = 4, // Honda
                    ModelName = "Civic Type R TC",
                    Category = "Sedan",
                    FirstProductionYear = 2020,
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                },
                new CarModel
                {
                    ManufacturerID = 1, // Porsche
                    ModelName = "718 Boxster",
                    Category = "Sports Car",
                    FirstProductionYear = 2018,
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                }
            };
            
            await context.CarModels.AddRangeAsync(carModels);
            await context.SaveChangesAsync();
        }
        
        private static async Task SeedCarsAsync(ApplicationDbContext context)
        {
            var cars = new List<Car>
            {
                new Car
                {
                    ModelID = 1, // 911 GT3 Touring
                    Year = 2022,
                    Price = 180000.00M,
                    Mileage = 5000,
                    TransmissionTypeID = 1, // Automatic
                    FuelTypeID = 1, // Gasoline
                    ColorID = 3, // Black
                    VIN = "WP0AC2A95NS270167",
                    EngineSize = 4.0M,
                    Horsepower = 502,
                    NumberOfDoors = 2,
                    Description = "Porsche 911 GT3 Touring",
                    IsAvailable = true,
                    DateAdded = DateTime.Now,
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                },
                new Car
                {
                    ModelID = 2, // Corvette Stingray Coupe
                    Year = 2021,
                    Price = 67000.00M,
                    Mileage = 8000,
                    TransmissionTypeID = 1, // Automatic
                    FuelTypeID = 1, // Gasoline
                    ColorID = 5, // Silver
                    VIN = "1G1YB2D47M5101234",
                    EngineSize = 6.2M,
                    Horsepower = 495,
                    NumberOfDoors = 2,
                    Description = "Chevrolet Corvette Stingray Coupe",
                    IsAvailable = true,
                    DateAdded = DateTime.Now,
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                },
                new Car
                {
                    ModelID = 3, // Focus RS
                    Year = 2017,
                    Price = 36000.00M,
                    Mileage = 30000,
                    TransmissionTypeID = 2, // Manual
                    FuelTypeID = 1, // Gasoline
                    ColorID = 2, // Blue
                    VIN = "1FAFP3R42HL123456",
                    EngineSize = 2.3M,
                    Horsepower = 350,
                    NumberOfDoors = 4,
                    Description = "Ford Focus RS",
                    IsAvailable = true,
                    DateAdded = DateTime.Now,
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                },
                new Car
                {
                    ModelID = 4, // Civic Type R TC
                    Year = 2020,
                    Price = 45000.00M,
                    Mileage = 15000,
                    TransmissionTypeID = 1, // Automatic
                    FuelTypeID = 1, // Gasoline
                    ColorID = 4, // White
                    VIN = "SHHFK8G75LU123456",
                    EngineSize = 2.0M,
                    Horsepower = 320,
                    NumberOfDoors = 4,
                    Description = "Honda Civic Type R TC",
                    IsAvailable = true,
                    DateAdded = DateTime.Now,
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                },
                new Car
                {
                    ModelID = 5, // 718 Boxster
                    Year = 2019,
                    Price = 35000.00M,
                    Mileage = 22000,
                    TransmissionTypeID = 1, // Automatic
                    FuelTypeID = 1, // Gasoline
                    ColorID = 1, // Red
                    VIN = "4T1B11HK7KU123456",
                    EngineSize = 2.5M,
                    Horsepower = 206,
                    NumberOfDoors = 4,
                    Description = "Porsche 718 Boxster",
                    IsAvailable = true,
                    DateAdded = DateTime.Now,
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now
                }
            };
            
            await context.Cars.AddRangeAsync(cars);
            await context.SaveChangesAsync();
        }
        
        private static async Task SeedCarFeaturesAsync(ApplicationDbContext context)
        {
            var carFeatures = new List<CarFeature>
            {
                // Data/DbSeeder.cs (continued)
                new CarFeature { CarID = 1, FeatureID = 1 }, // Car 1, ABS
                new CarFeature { CarID = 1, FeatureID = 2 }, // Car 1, Air Conditioning
                new CarFeature { CarID = 1, FeatureID = 4 }, // Car 1, GPS Navigation
                new CarFeature { CarID = 2, FeatureID = 1 }, // Car 2, ABS
                new CarFeature { CarID = 2, FeatureID = 3 }, // Car 2, Sunroof
                new CarFeature { CarID = 3, FeatureID = 1 }, // Car 3, ABS
                new CarFeature { CarID = 3, FeatureID = 5 }, // Car 3, Backup Camera
                new CarFeature { CarID = 4, FeatureID = 2 }, // Car 4, Air Conditioning
                new CarFeature { CarID = 4, FeatureID = 4 }, // Car 4, GPS Navigation
                new CarFeature { CarID = 5, FeatureID = 3 }, // Car 5, Sunroof
                new CarFeature { CarID = 5, FeatureID = 5 }  // Car 5, Backup Camera
            };
            
            await context.CarFeatures.AddRangeAsync(carFeatures);
            await context.SaveChangesAsync();
        }
        
        private static async Task SeedCarImagesAsync(ApplicationDbContext context)
        {
            var carImages = new List<CarImage>
            {
                new CarImage
                {
                    CarID = 1,
                    ImageURL = "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2F2022%20Porsche%20911%20GT3%20Touring%2F2022%20Porsche%20911%20GT3%20Touring%201.jpg?alt=media&token=5a679b3b-890f-4aa4-b550-ba2da738bdf2",
                    IsPrimary = true,
                    UploadDate = DateTime.Now
                },
                new CarImage
                {
                    CarID = 2,
                    ImageURL = "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2FChevrolet%20Corvette%20Stingray%20Coupe%2FChevrolet%20Corvette%20Stingray%20Coupe%201.jpg?alt=media&token=6bab82a6-3311-4e19-adae-b76d0d74a307",
                    IsPrimary = true,
                    UploadDate = DateTime.Now
                },
                new CarImage
                {
                    CarID = 3,
                    ImageURL = "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2FFord%20Focus%20RS%2FFord%20Focus%20RS%201.jpg?alt=media&token=80ff51e0-22d3-4751-9b2a-f85d7733ce67",
                    IsPrimary = true,
                    UploadDate = DateTime.Now
                },
                new CarImage
                {
                    CarID = 4,
                    ImageURL = "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2FHonda%20Civic%20Type%20R%20TC%2FHonda%20Civic%20Type%20R%20TC%201.jpg?alt=media&token=ef7eadf5-cf9d-48bc-8ca6-0d025d815f94",
                    IsPrimary = true,
                    UploadDate = DateTime.Now
                },
                new CarImage
                {
                    CarID = 5,
                    ImageURL = "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2FPorsche%20718%20Boxster%2FPorsche%20718%20Boxster%201.jpg?alt=media&token=7c7dd94a-215a-4d28-864e-d109fc0cc01d",
                    IsPrimary = true,
                    UploadDate = DateTime.Now
                }
            };
            
            await context.CarImages.AddRangeAsync(carImages);
            await context.SaveChangesAsync();
        }
    }
}