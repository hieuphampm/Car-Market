using System;
using System.Linq;
using ClassLibrary.Models;
using Microsoft.EntityFrameworkCore;

namespace CarMarketConsoleApp
{
    public class Program
    {
        public static void Main(string[] args)
        {
            while (true)
            {
                Console.Clear();
                Console.WriteLine("Car Market Management System");
                Console.WriteLine("1. Manage Customers");
                Console.WriteLine("2. Manage Cars");
                Console.WriteLine("3. Manage Employees");
                Console.WriteLine("4. Exit");
                Console.Write("Select an option (1-4): ");

                string choice = Console.ReadLine();

                switch (choice)
                {
                    case "1":
                        ManageCustomers();
                        break;
                    case "2":
                        ManageCars();
                        break;
                    case "3":
                        ManageEmployees();
                        break;
                    case "4":
                        return;
                    default:
                        Console.WriteLine("Invalid option. Press any key to continue...");
                        Console.ReadKey();
                        break;
                }
            }
        }

        static void ManageCustomers()
        {
            using var db = new CarMarketDbContext();
            while (true)
            {
                Console.Clear();
                Console.WriteLine("Customer Management");
                Console.WriteLine("1. Print All Customers");
                Console.WriteLine("2. Add Customer");
                Console.WriteLine("3. Edit Customer");
                Console.WriteLine("4. Delete Customer");
                Console.WriteLine("5. Find Customer by ID");
                Console.WriteLine("6. Back to Main Menu");
                Console.Write("Select an option (1-6): ");

                string choice = Console.ReadLine();

                switch (choice)
                {
                    case "1":
                        var customers = db.Customers.ToList();
                        foreach (var c in customers)
                            Console.WriteLine($"{c.CustomerId}: {c.FirstName} {c.LastName} - {c.Email}");
                        break;
                    case "2":
                        var newCustomer = new Customer
                        {
                            FirstName = GetInput("First Name"),
                            LastName = GetInput("Last Name"),
                            Email = GetInput("Email"),
                            PhoneNumber = GetInput("Phone Number"),
                            Address = GetInput("Address")
                        };
                        db.Customers.Add(newCustomer);
                        db.SaveChanges();
                        Console.WriteLine("Customer added successfully!");
                        break;
                    case "3":
                        PrintAndEdit(db.Customers.AsQueryable(), "Customer", c => $"{c.FirstName} {c.LastName}",
                            c =>
                            {
                                c.FirstName = GetInput("First Name", c.FirstName);
                                c.LastName = GetInput("Last Name", c.LastName);
                                c.Email = GetInput("Email", c.Email);
                                c.PhoneNumber = GetInput("Phone Number", c.PhoneNumber);
                                c.Address = GetInput("Address", c.Address);
                            }, db);
                        break;
                    case "4":
                        PrintAndDelete(db.Customers, "Customer", c => $"{c.FirstName} {c.LastName}");
                        break;
                    case "5":
                        Console.Write("Enter Customer ID: ");
                        if (int.TryParse(Console.ReadLine(), out int customerId))
                        {
                            var customer = FindById<Customer>(customerId, db => db.Customers, "Customer");
                            if (customer != null)
                                Console.WriteLine($"{customer.CustomerId}: {customer.FirstName} {customer.LastName} - {customer.Email} - {customer.PhoneNumber} - {customer.Address}");
                        }
                        break;
                    case "6":
                        return;
                }
                Console.WriteLine("Press any key to continue...");
                Console.ReadKey();
            }
        }

        static void ManageCars()
        {
            while (true)
            {
                Console.Clear();
                Console.WriteLine("Car Management");
                Console.WriteLine("1. Print All Cars");
                Console.WriteLine("2. Add Car");
                Console.WriteLine("3. Edit Car");
                Console.WriteLine("4. Delete Car");
                Console.WriteLine("5. Find Car by ID");
                Console.WriteLine("6. Back to Main Menu");
                Console.Write("Select an option (1-6): ");

                string choice = Console.ReadLine();

                switch (choice)
                {
                    case "1":
                        using (var db = new CarMarketDbContext())
                        {
                            var cars = db.Cars.Include(c => c.Model).ToList();
                            foreach (var c in cars)
                                Console.WriteLine($"{c.CarId}: {(c.Model != null ? c.Model.ModelName : "Unknown Model")} ({c.Year}) - ${c.Price}");
                        }
                        break;
                    case "2":
                        using (var db = new CarMarketDbContext())
                        {
                            try
                            {
                                // Prompt for Car Model selection or creation
                                Console.WriteLine("Do you want to (1) Select an existing Car Model or (2) Create a new Car Model?");
                                Console.Write("Enter 1 or 2: ");
                                string modelChoice = Console.ReadLine();
                                int modelId;

                                if (modelChoice == "2")
                                {
                                    // Create a new Car Model
                                    Console.WriteLine("Creating a new Car Model...");

                                    // Display and validate Manufacturers
                                    Console.WriteLine("Available Manufacturers:");
                                    var manufacturers = db.Manufacturers.ToList();
                                    if (!manufacturers.Any())
                                    {
                                        Console.WriteLine("No manufacturers available. Please add a manufacturer first.");
                                        break;
                                    }
                                    foreach (var manuf in manufacturers)
                                        Console.WriteLine($"{manuf.ManufacturerId}: {manuf.Name}");
                                    int manufacturerId = GetValidIntInput("Manufacturer ID", id => db.Manufacturers.Any(m => m.ManufacturerId == id));

                                    // Collect Car Model details
                                    string modelName = GetInput("Model Name");
                                    if (string.IsNullOrEmpty(modelName))
                                    {
                                        Console.WriteLine("Model Name is required.");
                                        break;
                                    }

                                    string category = GetInput("Category (optional)", null);

                                    Console.Write("Enter First Production Year (optional): ");
                                    int? firstProductionYear = null;
                                    if (int.TryParse(Console.ReadLine(), out int fpy))
                                        firstProductionYear = fpy;

                                    Console.Write("Enter Last Production Year (optional): ");
                                    int? lastProductionYear = null;
                                    if (int.TryParse(Console.ReadLine(), out int lpy))
                                        lastProductionYear = lpy;

                                    // Create and save new Car Model
                                    var newModel = new CarModel
                                    {
                                        ManufacturerId = manufacturerId,
                                        ModelName = modelName,
                                        Category = category,
                                        FirstProductionYear = firstProductionYear,
                                        LastProductionYear = lastProductionYear,
                                        DateCreated = DateTime.Now
                                    };

                                    db.CarModels.Add(newModel);
                                    db.SaveChanges();
                                    modelId = newModel.ModelId;
                                    Console.WriteLine($"New Car Model '{modelName}' added with ID: {modelId}");
                                }
                                else
                                {
                                    // Select existing Car Model
                                    Console.WriteLine("Available Car Models:");
                                    var models = db.CarModels.ToList();
                                    if (!models.Any())
                                    {
                                        Console.WriteLine("No car models available. Please create a new model.");
                                        break;
                                    }
                                    foreach (var model in models)
                                        Console.WriteLine($"{model.ModelId}: {model.ModelName}");
                                    modelId = GetValidIntInput("Model ID", id => db.CarModels.Any(m => m.ModelId == id));
                                }

                                // Display and validate Transmission Types
                                Console.WriteLine("Available Transmission Types:");
                                var transmissions = db.TransmissionTypes.ToList();
                                if (!transmissions.Any())
                                {
                                    Console.WriteLine("No transmission types available. Please add a transmission type first.");
                                    break;
                                }
                                foreach (var trans in transmissions)
                                    Console.WriteLine($"{trans.TransmissionTypeId}: {trans.Name}");
                                int transmissionTypeId = GetValidIntInput("Transmission Type ID", id => db.TransmissionTypes.Any(t => t.TransmissionTypeId == id));

                                // Display and validate Fuel Types
                                Console.WriteLine("Available Fuel Types:");
                                var fuels = db.FuelTypes.ToList();
                                if (!fuels.Any())
                                {
                                    Console.WriteLine("No fuel types available. Please add a fuel type first.");
                                    break;
                                }
                                foreach (var fuel in fuels)
                                    Console.WriteLine($"{fuel.FuelTypeId}: {fuel.Name}");
                                int fuelTypeId = GetValidIntInput("Fuel Type ID", id => db.FuelTypes.Any(f => f.FuelTypeId == id));

                                // Display and validate Colors
                                Console.WriteLine("Available Colors:");
                                var colors = db.Colors.ToList();
                                if (!colors.Any())
                                {
                                    Console.WriteLine("No colors available. Please add a color first.");
                                    break;
                                }
                                foreach (var color in colors)
                                    Console.WriteLine($"{color.ColorId}: {color.Name}");
                                int colorId = GetValidIntInput("Color ID", id => db.Colors.Any(c => c.ColorId == id));

                                // Collect required fields
                                Console.Write("Enter Year: ");
                                if (!int.TryParse(Console.ReadLine(), out int year) || year < 1886 || year > DateTime.Now.Year + 1)
                                {
                                    Console.WriteLine("Invalid Year. Please enter a valid year.");
                                    break;
                                }

                                Console.Write("Enter Price: ");
                                if (!decimal.TryParse(Console.ReadLine(), out decimal price) || price < 0)
                                {
                                    Console.WriteLine("Invalid Price. Please enter a valid positive number.");
                                    break;
                                }

                                Console.Write("Enter Mileage: ");
                                if (!int.TryParse(Console.ReadLine(), out int mileage) || mileage < 0)
                                {
                                    Console.WriteLine("Invalid Mileage. Please enter a valid non-negative number.");
                                    break;
                                }

                                string vin = GetInput("VIN (optional)", null);

                                // Collect optional fields
                                Console.Write("Enter Engine Size (liters, optional): ");
                                decimal? engineSize = null;
                                if (decimal.TryParse(Console.ReadLine(), out decimal es))
                                    engineSize = es;

                                Console.Write("Enter Horsepower (optional): ");
                                int? horsepower = null;
                                if (int.TryParse(Console.ReadLine(), out int hp))
                                    horsepower = hp;

                                Console.Write("Enter Number of Doors (optional): ");
                                int? numberOfDoors = null;
                                if (int.TryParse(Console.ReadLine(), out int doors))
                                    numberOfDoors = doors;

                                string description = GetInput("Description (optional)", null);

                                // Create new Car entity
                                var newCar = new Car
                                {
                                    ModelId = modelId,
                                    Year = year,
                                    Price = price,
                                    Mileage = mileage,
                                    TransmissionTypeId = transmissionTypeId,
                                    FuelTypeId = fuelTypeId,
                                    ColorId = colorId,
                                    Vin = string.IsNullOrEmpty(vin) ? null : vin,
                                    EngineSize = engineSize,
                                    Horsepower = horsepower,
                                    NumberOfDoors = numberOfDoors,
                                    Description = description,
                                    IsAvailable = true,
                                    DateCreated = DateTime.Now,
                                    DateAdded = DateTime.Now
                                };

                                db.Cars.Add(newCar);
                                db.SaveChanges();
                                Console.WriteLine($"Car added successfully with ID: {newCar.CarId}");
                            }
                            catch (DbUpdateException ex)
                            {
                                Console.WriteLine($"Error saving car: {ex.InnerException?.Message ?? ex.Message}");
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine($"An unexpected error occurred: {ex.Message}");
                            }
                        }
                        break;
                    case "3":
                        using (var db = new CarMarketDbContext())
                        {
                            // Load cars with Model to avoid NullReferenceException
                            var cars = db.Cars.Include(c => c.Model).ToList();
                            PrintAndEdit(cars.AsQueryable(), "Car", c => $"{(c.Model != null ? c.Model.ModelName : "Unknown Model")} ({c.Year})",
                                c =>
                                {
                                    c.Year = int.Parse(GetInput("Year", c.Year.ToString()));
                                    c.Price = decimal.Parse(GetInput("Price", c.Price.ToString()));
                                    c.Mileage = int.Parse(GetInput("Mileage", c.Mileage.ToString()));
                                    c.Vin = GetInput("VIN", c.Vin);
                                }, db);
                        }
                        break;
                    case "4":
                        using (var db = new CarMarketDbContext())
                        {
                            var cars = db.Cars.Include(c => c.Model).ToList();
                            foreach (var car in cars)
                            {
                                Console.WriteLine($"{car.CarId}: {(car.Model != null ? car.Model.ModelName : "Unknown Model")} ({car.Year}) - ${car.Price}");
                            }
                            Console.Write("Enter Car ID to delete: ");
                            if (int.TryParse(Console.ReadLine(), out int id))
                            {
                                var car = db.Cars
                                    .Include(c => c.CarImages)
                                    .Include(c => c.Favorites)
                                    .Include(c => c.Sales)
                                    .Include(c => c.Features)
                                    .FirstOrDefault(c => c.CarId == id);
                                if (car != null)
                                {
                                    db.CarImages.RemoveRange(car.CarImages);
                                    db.Favorites.RemoveRange(car.Favorites);
                                    db.Sales.RemoveRange(car.Sales);
                                    car.Features.Clear();
                                    db.Cars.Remove(car);
                                    db.SaveChanges();
                                    Console.WriteLine("Car deleted successfully!");
                                }
                                else
                                {
                                    Console.WriteLine("Car not found!");
                                }
                            }
                            else
                            {
                                Console.WriteLine("Invalid Car ID!");
                            }
                        }
                        break;
                    case "5":
                        Console.Write("Enter Car ID: ");
                        if (int.TryParse(Console.ReadLine(), out int carId))
                        {
                            using (var db = new CarMarketDbContext())
                            {
                                var car = FindById<Car>(carId, db => db.Cars.Include(c => c.Model), "Car");
                                if (car != null)
                                    Console.WriteLine($"{car.CarId}: {(car.Model != null ? car.Model.ModelName : "Unknown Model")} ({car.Year}) - ${car.Price} - Mileage: {car.Mileage} - VIN: {car.Vin}");
                            }
                        }
                        break;
                    case "6":
                        return;
                }
                Console.WriteLine("Press any key to continue...");
                Console.ReadKey();
            }
        }

        static void ManageEmployees()
        {
            using var db = new CarMarketDbContext();
            while (true)
            {
                Console.Clear();
                Console.WriteLine("Employee Management");
                Console.WriteLine("1. Print All Employees");
                Console.WriteLine("2. Add Employee");
                Console.WriteLine("3. Edit Employee");
                Console.WriteLine("4. Delete Employee");
                Console.WriteLine("5. Find Employee by ID");
                Console.WriteLine("6. Back to Main Menu");
                Console.Write("Select an option (1-6): ");

                string choice = Console.ReadLine();

                switch (choice)
                {
                    case "1":
                        var employees = db.Employees.ToList();
                        foreach (var e in employees)
                            Console.WriteLine($"{e.EmployeeId}: {e.FirstName} {e.LastName} - {e.Position}");
                        break;
                    case "2":
                        var newEmployee = new Employee
                        {
                            FirstName = GetInput("First Name"),
                            LastName = GetInput("Last Name"),
                            Position = GetInput("Position"),
                            Salary = decimal.Parse(GetInput("Salary")),
                            Email = GetInput("Email"),
                            PhoneNumber = GetInput("Phone Number")
                        };
                        db.Employees.Add(newEmployee);
                        db.SaveChanges();
                        Console.WriteLine("Employee added successfully!");
                        break;
                    case "3":
                        PrintAndEdit(db.Employees.AsQueryable(), "Employee", e => $"{e.FirstName} {e.LastName}",
                            e =>
                            {
                                e.FirstName = GetInput("First Name", e.FirstName);
                                e.LastName = GetInput("Last Name", e.LastName);
                                e.Position = GetInput("Position", e.Position);
                                e.Salary = decimal.Parse(GetInput("Salary", e.Salary.ToString()));
                                e.Email = GetInput("Email", e.Email);
                                e.PhoneNumber = GetInput("Phone Number", e.PhoneNumber);
                            }, db);
                        break;
                    case "4":
                        PrintAndDelete(db.Employees, "Employee", e => $"{e.FirstName} {e.LastName}");
                        break;
                    case "5":
                        Console.Write("Enter Employee ID: ");
                        if (int.TryParse(Console.ReadLine(), out int employeeId))
                        {
                            var employee = FindById<Employee>(employeeId, db => db.Employees, "Employee");
                            if (employee != null)
                                Console.WriteLine($"{employee.EmployeeId}: {employee.FirstName} {employee.LastName} - {employee.Position} - ${employee.Salary} - {employee.Email}");
                        }
                        break;
                    case "6":
                        return;
                }
                Console.WriteLine("Press any key to continue...");
                Console.ReadKey();
            }
        }

        static T FindById<T>(int id, Func<CarMarketDbContext, IQueryable<T>> querySelector, string entityName) where T : class
        {
            using var db = new CarMarketDbContext();
            var entity = querySelector(db).FirstOrDefault(e => EF.Property<int>(e, entityName + "Id") == id);
            if (entity == null)
            {
                Console.WriteLine($"{entityName} with ID {id} not found!");
                return null;
            }
            return entity;
        }

        static string GetInput(string field, string defaultValue = null)
        {
            Console.Write($"Enter {field} ({(string.IsNullOrEmpty(defaultValue) ? "optional" : $"default: {defaultValue}")}): ");
            string input = Console.ReadLine();
            return string.IsNullOrEmpty(input) ? defaultValue : input;
        }

        static int GetValidIntInput(string fieldName, Func<int, bool> isValid)
        {
            while (true)
            {
                Console.Write($"Enter {fieldName}: ");
                if (int.TryParse(Console.ReadLine(), out int value) && isValid(value))
                    return value;
                Console.WriteLine($"Invalid {fieldName}. Please enter a valid ID from the list.");
            }
        }

        static void PrintAndEdit<T>(IQueryable<T> queryable, string entityName, Func<T, string> displayFunc, Action<T> editFunc, CarMarketDbContext db) where T : class
        {
            var items = queryable.ToList();
            foreach (var item in items)
            {
                Console.WriteLine($"{GetId(item)}: {displayFunc(item)}");
            }
            Console.Write($"Enter {entityName} ID to edit: ");
            if (int.TryParse(Console.ReadLine(), out int id))
            {
                var item = items.FirstOrDefault(i => GetId(i) == id);
                if (item != null)
                {
                    editFunc(item);
                    db.SaveChanges();
                    Console.WriteLine($"{entityName} updated successfully!");
                }
                else
                {
                    Console.WriteLine($"{entityName} not found!");
                }
            }
        }

        static void PrintAndDelete<T>(DbSet<T> dbSet, string entityName, Func<T, string> displayFunc) where T : class
        {
            using var db = new CarMarketDbContext();
            var items = dbSet.ToList();
            foreach (var item in items)
            {
                Console.WriteLine($"{GetId(item)}: {displayFunc(item)}");
            }
            Console.Write($"Enter {entityName} ID to delete: ");
            if (int.TryParse(Console.ReadLine(), out int id))
            {
                var item = items.FirstOrDefault(i => GetId(i) == id);
                if (item != null)
                {
                    db.Remove(item);
                    db.SaveChanges();
                    Console.WriteLine($"{entityName} deleted successfully!");
                }
                else
                {
                    Console.WriteLine($"{entityName} not found!");
                }
            }
        }

        static int GetId<T>(T item)
        {
            var prop = item.GetType().GetProperty(item.GetType().Name + "Id");
            return (int)prop.GetValue(item);
        }
    }
}