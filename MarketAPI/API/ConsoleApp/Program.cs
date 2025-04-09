using System;
using ClassLibrary.Models;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace CarMarketConsoleApp
{
    class Program
    {
        static void Main(string[] args)
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
                        PrintAndEdit(db.Customers, "Customer", c => $"{c.FirstName} {c.LastName}",
                            c =>
                            {
                                c.FirstName = GetInput("First Name", c.FirstName);
                                c.LastName = GetInput("Last Name", c.LastName);
                                c.Email = GetInput("Email", c.Email);
                                c.PhoneNumber = GetInput("Phone Number", c.PhoneNumber);
                                c.Address = GetInput("Address", c.Address);
                            });
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
            using var db = new CarMarketDbContext();
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
                        var cars = db.Cars.Include(c => c.Model).ToList();
                        foreach (var c in cars)
                            Console.WriteLine($"{c.CarId}: {c.Model.ModelName} ({c.Year}) - ${c.Price}");
                        break;
                    case "2":
                        var newCar = new Car
                        {
                            ModelId = int.Parse(GetInput("Model ID")),
                            Year = int.Parse(GetInput("Year")),
                            Price = decimal.Parse(GetInput("Price")),
                            Mileage = int.Parse(GetInput("Mileage")),
                            TransmissionTypeId = int.Parse(GetInput("Transmission Type ID")),
                            FuelTypeId = int.Parse(GetInput("Fuel Type ID")),
                            ColorId = int.Parse(GetInput("Color ID")),
                            Vin = GetInput("VIN")
                        };
                        db.Cars.Add(newCar);
                        db.SaveChanges();
                        Console.WriteLine("Car added successfully!");
                        break;
                    case "3":
                        PrintAndEdit(db.Cars, "Car", c => $"{c.Model.ModelName} ({c.Year})",
                            c =>
                            {
                                c.Year = int.Parse(GetInput("Year", c.Year.ToString()));
                                c.Price = decimal.Parse(GetInput("Price", c.Price.ToString()));
                                c.Mileage = int.Parse(GetInput("Mileage", c.Mileage.ToString()));
                                c.Vin = GetInput("VIN", c.Vin);
                            });
                        break;
                    case "4":
                        PrintAndDelete(db.Cars, "Car", c => $"{c.Model.ModelName} ({c.Year})");
                        break;
                    case "5":
                        Console.Write("Enter Car ID: ");
                        if (int.TryParse(Console.ReadLine(), out int carId))
                        {
                            var car = FindById<Car>(carId, db => db.Cars.Include(c => c.Model), "Car");
                            if (car != null)
                                Console.WriteLine($"{car.CarId}: {car.Model.ModelName} ({car.Year}) - ${car.Price} - Mileage: {car.Mileage} - VIN: {car.Vin}");
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
                        PrintAndEdit(db.Employees, "Employee", e => $"{e.FirstName} {e.LastName}",
                            e =>
                            {
                                e.FirstName = GetInput("First Name", e.FirstName);
                                e.LastName = GetInput("Last Name", e.LastName);
                                e.Position = GetInput("Position", e.Position);
                                e.Salary = decimal.Parse(GetInput("Salary", e.Salary.ToString()));
                                e.Email = GetInput("Email", e.Email);
                                e.PhoneNumber = GetInput("Phone Number", e.PhoneNumber);
                            });
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

        static string GetInput(string field, string defaultValue = "")
        {
            Console.Write($"Enter {field} ({(string.IsNullOrEmpty(defaultValue) ? "required" : $"default: {defaultValue}")}): ");
            string input = Console.ReadLine();
            return string.IsNullOrEmpty(input) ? defaultValue : input;
        }

        static void PrintAndEdit<T>(DbSet<T> dbSet, string entityName, Func<T, string> displayFunc, Action<T> editFunc) where T : class
        {
            using var db = new CarMarketDbContext();
            var items = dbSet.ToList();
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
                    dbSet.Remove(item);
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