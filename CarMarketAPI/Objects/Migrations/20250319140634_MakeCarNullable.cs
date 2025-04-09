using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Objects.Migrations
{
    /// <inheritdoc />
    public partial class MakeCarNullable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Color",
                columns: table => new
                {
                    ColorID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false),
                    HexCode = table.Column<string>(type: "char(7)", unicode: false, fixedLength: true, maxLength: 7, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Color__8DA7676DBF3A756E", x => x.ColorID);
                });

            migrationBuilder.CreateTable(
                name: "Customer",
                columns: table => new
                {
                    CustomerID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirstName = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    LastName = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    Email = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    PhoneNumber = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true),
                    Address = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    DateCreated = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    DateModified = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Customer__A4AE64B8B6AD1EEA", x => x.CustomerID);
                });

            migrationBuilder.CreateTable(
                name: "Employee",
                columns: table => new
                {
                    EmployeeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirstName = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    LastName = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    Position = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    Salary = table.Column<decimal>(type: "decimal(10,2)", nullable: true),
                    DateHired = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    Email = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    PhoneNumber = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Employee__7AD04FF192E26871", x => x.EmployeeID);
                });

            migrationBuilder.CreateTable(
                name: "Feature",
                columns: table => new
                {
                    FeatureID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    Category = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Feature__82230A290F35CED5", x => x.FeatureID);
                });

            migrationBuilder.CreateTable(
                name: "FuelType",
                columns: table => new
                {
                    FuelTypeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__FuelType__048BEE5731025604", x => x.FuelTypeID);
                });

            migrationBuilder.CreateTable(
                name: "Manufacturer",
                columns: table => new
                {
                    ManufacturerID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    Country = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    FoundedYear = table.Column<int>(type: "int", nullable: true),
                    Website = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    LogoURL = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    DateCreated = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    DateModified = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Manufact__357E5CA1121F9DDD", x => x.ManufacturerID);
                });

            migrationBuilder.CreateTable(
                name: "TransmissionType",
                columns: table => new
                {
                    TransmissionTypeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Transmis__B97624961871C4BD", x => x.TransmissionTypeID);
                });

            migrationBuilder.CreateTable(
                name: "CarModel",
                columns: table => new
                {
                    ModelID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ManufacturerID = table.Column<int>(type: "int", nullable: false),
                    ModelName = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    Category = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    FirstProductionYear = table.Column<int>(type: "int", nullable: true),
                    LastProductionYear = table.Column<int>(type: "int", nullable: true),
                    DateCreated = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    DateModified = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__CarModel__E8D7A1CC6E4603AD", x => x.ModelID);
                    table.ForeignKey(
                        name: "FK_CarModel_Manufacturer",
                        column: x => x.ManufacturerID,
                        principalTable: "Manufacturer",
                        principalColumn: "ManufacturerID");
                });

            migrationBuilder.CreateTable(
                name: "Car",
                columns: table => new
                {
                    CarID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ModelID = table.Column<int>(type: "int", nullable: false),
                    Year = table.Column<int>(type: "int", nullable: false),
                    Price = table.Column<decimal>(type: "decimal(12,2)", nullable: false),
                    Mileage = table.Column<int>(type: "int", nullable: false),
                    TransmissionTypeID = table.Column<int>(type: "int", nullable: false),
                    FuelTypeID = table.Column<int>(type: "int", nullable: false),
                    ColorID = table.Column<int>(type: "int", nullable: false),
                    VIN = table.Column<string>(type: "varchar(17)", unicode: false, maxLength: 17, nullable: true),
                    EngineSize = table.Column<decimal>(type: "decimal(3,1)", nullable: true),
                    Horsepower = table.Column<int>(type: "int", nullable: true),
                    NumberOfDoors = table.Column<int>(type: "int", nullable: true),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    IsAvailable = table.Column<bool>(type: "bit", nullable: true, defaultValue: true),
                    DateAdded = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    DateSold = table.Column<DateTime>(type: "datetime", nullable: true),
                    DateCreated = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    DateModified = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Car__68A0340E4CC9D5E5", x => x.CarID);
                    table.ForeignKey(
                        name: "FK_Car_CarModel",
                        column: x => x.ModelID,
                        principalTable: "CarModel",
                        principalColumn: "ModelID");
                    table.ForeignKey(
                        name: "FK_Car_Color",
                        column: x => x.ColorID,
                        principalTable: "Color",
                        principalColumn: "ColorID");
                    table.ForeignKey(
                        name: "FK_Car_FuelType",
                        column: x => x.FuelTypeID,
                        principalTable: "FuelType",
                        principalColumn: "FuelTypeID");
                    table.ForeignKey(
                        name: "FK_Car_TransmissionType",
                        column: x => x.TransmissionTypeID,
                        principalTable: "TransmissionType",
                        principalColumn: "TransmissionTypeID");
                });

            migrationBuilder.CreateTable(
                name: "CarFeature",
                columns: table => new
                {
                    CarID = table.Column<int>(type: "int", nullable: false),
                    FeatureID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__CarFeatu__E08204ACD37E09B2", x => new { x.CarID, x.FeatureID });
                    table.ForeignKey(
                        name: "FK_CarFeature_Car",
                        column: x => x.CarID,
                        principalTable: "Car",
                        principalColumn: "CarID");
                    table.ForeignKey(
                        name: "FK_CarFeature_Feature",
                        column: x => x.FeatureID,
                        principalTable: "Feature",
                        principalColumn: "FeatureID");
                });

            migrationBuilder.CreateTable(
                name: "CarImage",
                columns: table => new
                {
                    ImageID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CarID = table.Column<int>(type: "int", nullable: false),
                    ImageURL = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    IsPrimary = table.Column<bool>(type: "bit", nullable: true, defaultValue: false),
                    UploadDate = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__CarImage__7516F4ECF3A4223B", x => x.ImageID);
                    table.ForeignKey(
                        name: "FK_CarImage_Car",
                        column: x => x.CarID,
                        principalTable: "Car",
                        principalColumn: "CarID");
                });

            migrationBuilder.CreateTable(
                name: "Favorite",
                columns: table => new
                {
                    FavoriteID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CustomerID = table.Column<int>(type: "int", nullable: false),
                    CarID = table.Column<int>(type: "int", nullable: false),
                    DateAdded = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Favorite__CE74FAF5F2293F69", x => x.FavoriteID);
                    table.ForeignKey(
                        name: "FK_Favorite_Car",
                        column: x => x.CarID,
                        principalTable: "Car",
                        principalColumn: "CarID");
                    table.ForeignKey(
                        name: "FK_Favorite_Customer",
                        column: x => x.CustomerID,
                        principalTable: "Customer",
                        principalColumn: "CustomerID");
                });

            migrationBuilder.CreateTable(
                name: "Sale",
                columns: table => new
                {
                    SaleID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CarID = table.Column<int>(type: "int", nullable: false),
                    CustomerID = table.Column<int>(type: "int", nullable: false),
                    SaleDate = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    TotalPrice = table.Column<decimal>(type: "decimal(12,2)", nullable: false),
                    PaymentMethod = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Sale__1EE3C41FEFB1BEDB", x => x.SaleID);
                    table.ForeignKey(
                        name: "FK_Sale_Car",
                        column: x => x.CarID,
                        principalTable: "Car",
                        principalColumn: "CarID");
                    table.ForeignKey(
                        name: "FK_Sale_Customer",
                        column: x => x.CustomerID,
                        principalTable: "Customer",
                        principalColumn: "CustomerID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Car_ColorID",
                table: "Car",
                column: "ColorID");

            migrationBuilder.CreateIndex(
                name: "IX_Car_FuelTypeID",
                table: "Car",
                column: "FuelTypeID");

            migrationBuilder.CreateIndex(
                name: "IX_Car_ModelID",
                table: "Car",
                column: "ModelID");

            migrationBuilder.CreateIndex(
                name: "IX_Car_TransmissionTypeID",
                table: "Car",
                column: "TransmissionTypeID");

            migrationBuilder.CreateIndex(
                name: "UQ__Car__C5DF234C8E454627",
                table: "Car",
                column: "VIN",
                unique: true,
                filter: "[VIN] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_CarFeature_FeatureID",
                table: "CarFeature",
                column: "FeatureID");

            migrationBuilder.CreateIndex(
                name: "IX_CarImage_CarID",
                table: "CarImage",
                column: "CarID");

            migrationBuilder.CreateIndex(
                name: "IX_CarModel_ManufacturerID",
                table: "CarModel",
                column: "ManufacturerID");

            migrationBuilder.CreateIndex(
                name: "UQ__Customer__A9D10534FCAD5FF3",
                table: "Customer",
                column: "Email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "UQ__Employee__A9D10534AA73B244",
                table: "Employee",
                column: "Email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Favorite_CarID",
                table: "Favorite",
                column: "CarID");

            migrationBuilder.CreateIndex(
                name: "IX_Favorite_CustomerID",
                table: "Favorite",
                column: "CustomerID");

            migrationBuilder.CreateIndex(
                name: "IX_Sale_CarID",
                table: "Sale",
                column: "CarID");

            migrationBuilder.CreateIndex(
                name: "IX_Sale_CustomerID",
                table: "Sale",
                column: "CustomerID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CarFeature");

            migrationBuilder.DropTable(
                name: "CarImage");

            migrationBuilder.DropTable(
                name: "Employee");

            migrationBuilder.DropTable(
                name: "Favorite");

            migrationBuilder.DropTable(
                name: "Sale");

            migrationBuilder.DropTable(
                name: "Feature");

            migrationBuilder.DropTable(
                name: "Car");

            migrationBuilder.DropTable(
                name: "Customer");

            migrationBuilder.DropTable(
                name: "CarModel");

            migrationBuilder.DropTable(
                name: "Color");

            migrationBuilder.DropTable(
                name: "FuelType");

            migrationBuilder.DropTable(
                name: "TransmissionType");

            migrationBuilder.DropTable(
                name: "Manufacturer");
        }
    }
}
