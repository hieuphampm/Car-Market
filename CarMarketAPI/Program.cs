using CarMarketAPI.Data; // For ApplicationDbContext and DbSeeder
using Microsoft.EntityFrameworkCore; // For UseSqlServer
using Microsoft.Extensions.DependencyInjection; // For AddDbContext and CreateScope
using System;
using System.Threading.Tasks;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

// Configure the HTTP request pipeline.
app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

// Seed the database
try
{
    using (var scope = app.Services.CreateScope())
    {
        var services = scope.ServiceProvider;
        await DbSeeder.SeedDatabaseAsync(services);
        Console.WriteLine("Database seeding completed successfully.");
    }
}
catch (Exception ex)
{
    Console.WriteLine($"An error occurred while seeding the database: {ex.Message}");
    throw; // Optionally rethrow to halt startup, or handle gracefully
}

app.Run();