-- Create the database 
CREATE DATABASE CarMarketDB;
GO

USE CarMarketDB;
GO

-- Create Manufacturer table
CREATE TABLE Manufacturer (
    ManufacturerID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Country VARCHAR(100),
    FoundedYear INT,
    Website VARCHAR(255),
    LogoURL VARCHAR(255),
    DateCreated DATETIME DEFAULT GETDATE(),
    DateModified DATETIME DEFAULT GETDATE()
);
GO

-- Create CarModel table
CREATE TABLE CarModel (
    ModelID INT PRIMARY KEY IDENTITY(1,1),
    ManufacturerID INT NOT NULL,
    ModelName VARCHAR(100) NOT NULL,
    Category VARCHAR(50), -- SUV, Sedan, Truck, etc.
    FirstProductionYear INT,
    LastProductionYear INT,
    DateCreated DATETIME DEFAULT GETDATE(),
    DateModified DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_CarModel_Manufacturer FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)
);
GO

-- Create TransmissionType lookup table
CREATE TABLE TransmissionType (
    TransmissionTypeID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL -- Automatic, Manual, CVT, etc.
);
GO

-- Create FuelType lookup table
CREATE TABLE FuelType (
    FuelTypeID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL -- Gasoline, Diesel, Electric, Hybrid, etc.
);
GO

-- Create Color lookup table
CREATE TABLE Color (
    ColorID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    HexCode CHAR(7) NULL
);
GO

-- Create Car table (main inventory table)
CREATE TABLE Car (
    CarID INT PRIMARY KEY IDENTITY(1,1),
    ModelID INT NOT NULL,
    Year INT NOT NULL,
    Price DECIMAL(12, 2) NOT NULL,
    Mileage INT NOT NULL,
    TransmissionTypeID INT NOT NULL,
    FuelTypeID INT NOT NULL,
    ColorID INT NOT NULL,
    VIN VARCHAR(17) UNIQUE,
    EngineSize DECIMAL(3, 1), -- In liters
    Horsepower INT,
    NumberOfDoors INT,
    Description NVARCHAR(MAX),
    IsAvailable BIT DEFAULT 1,
    DateAdded DATETIME DEFAULT GETDATE(),
    DateSold DATETIME NULL,
    DateCreated DATETIME DEFAULT GETDATE(),
    DateModified DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Car_CarModel FOREIGN KEY (ModelID) REFERENCES CarModel(ModelID),
    CONSTRAINT FK_Car_TransmissionType FOREIGN KEY (TransmissionTypeID) REFERENCES TransmissionType(TransmissionTypeID),
    CONSTRAINT FK_Car_FuelType FOREIGN KEY (FuelTypeID) REFERENCES FuelType(FuelTypeID),
    CONSTRAINT FK_Car_Color FOREIGN KEY (ColorID) REFERENCES Color(ColorID)
);
GO

-- Create Feature lookup table for car features
CREATE TABLE Feature (
    FeatureID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50) -- Safety, Comfort, Technology, etc.
);
GO

-- Create Car-Feature mapping table (many-to-many)
CREATE TABLE CarFeature (
    CarID INT NOT NULL,
    FeatureID INT NOT NULL,
    PRIMARY KEY (CarID, FeatureID),
    CONSTRAINT FK_CarFeature_Car FOREIGN KEY (CarID) REFERENCES Car(CarID),
    CONSTRAINT FK_CarFeature_Feature FOREIGN KEY (FeatureID) REFERENCES Feature(FeatureID)
);
GO

-- Create CarImage table
CREATE TABLE CarImage (
    ImageID INT PRIMARY KEY IDENTITY(1,1),
    CarID INT NOT NULL,
    ImageURL VARCHAR(255) NOT NULL,
    IsPrimary BIT DEFAULT 0,
    UploadDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_CarImage_Car FOREIGN KEY (CarID) REFERENCES Car(CarID)
);
GO

-- Create Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20),
    Address VARCHAR(255),
    DateCreated DATETIME DEFAULT GETDATE(),
    DateModified DATETIME DEFAULT GETDATE()
);
GO

-- Create Sale table
CREATE TABLE Sale (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CarID INT NOT NULL,
    CustomerID INT NOT NULL,
    SaleDate DATETIME DEFAULT GETDATE(),
    TotalPrice DECIMAL(12, 2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    CONSTRAINT FK_Sale_Car FOREIGN KEY (CarID) REFERENCES Car(CarID),
    CONSTRAINT FK_Sale_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
GO

-- Create Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    DateHired DATETIME DEFAULT GETDATE(),
    Email VARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20)
);
GO

-- favorites
BEGIN
    CREATE TABLE Favorite (
        FavoriteID INT PRIMARY KEY IDENTITY(1,1),
        CustomerID INT NOT NULL,
        CarID INT NOT NULL,
        DateAdded DATETIME DEFAULT GETDATE(),
        CONSTRAINT FK_Favorite_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
        CONSTRAINT FK_Favorite_Car FOREIGN KEY (CarID) REFERENCES Car(CarID)
    );
END

-- Create View for Car Details
GO
CREATE VIEW ViewCarDetails AS
SELECT c.CarID, c.Year, c.Price, c.Mileage, 
       cm.ModelName, m.Name AS Manufacturer, 
       t.Name AS Transmission, f.Name AS Fuel, 
       col.Name AS Color
FROM Car c
JOIN CarModel cm ON c.ModelID = cm.ModelID
JOIN Manufacturer m ON cm.ManufacturerID = m.ManufacturerID
JOIN TransmissionType t ON c.TransmissionTypeID = t.TransmissionTypeID
JOIN FuelType f ON c.FuelTypeID = f.FuelTypeID
JOIN Color col ON c.ColorID = col.ColorID;
GO

-- Create Procedure to Get Available Cars
GO
CREATE PROCEDURE GetAvailableCars
AS
BEGIN
    SELECT * FROM Car WHERE IsAvailable = 1;
END;
GO

-- Create Procedure to Get Car Sales by Manufacturer
GO
CREATE PROCEDURE GetCarSalesByManufacturer
AS
BEGIN
    SELECT m.Name AS Manufacturer, COUNT(s.SaleID) AS TotalSales, SUM(s.TotalPrice) AS TotalRevenue
    FROM Sale s
    JOIN Car c ON s.CarID = c.CarID
    JOIN CarModel cm ON c.ModelID = cm.ModelID
    JOIN Manufacturer m ON cm.ManufacturerID = m.ManufacturerID
    GROUP BY m.Name;
END;
GO

USE CarMarketDB;
GO

-- Insert sample data into TransmissionType
INSERT INTO TransmissionType (Name) VALUES 
('Automatic'), 
('Manual'), 
('CVT');
GO

-- Insert sample data into FuelType
INSERT INTO FuelType (Name) VALUES 
('Gasoline'), 
('Diesel'), 
('Electric'), 
('Hybrid');
GO

-- Insert sample data into Color
INSERT INTO Color (Name, HexCode) VALUES 
('Red', '#FF0000'), 
('Blue', '#0000FF'), 
('Black', '#000000'), 
('White', '#FFFFFF'), 
('Silver', '#C0C0C0');
GO

-- Insert sample data into Feature
INSERT INTO Feature (Name, Category) VALUES 
('ABS', 'Safety'), 
('Air Conditioning', 'Comfort'), 
('Sunroof', 'Luxury'), 
('GPS Navigation', 'Technology'), 
('Backup Camera', 'Safety');
GO

-- Insert sample data into Manufacturer
INSERT INTO Manufacturer (Name, Country, FoundedYear, Website, LogoURL) VALUES
('Porsche', 'Germany', 1931, 'https://www.porsche.com', 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Fporsche-seeklogo.png?alt=media&token=53f50dae-4d5d-4e2e-abb2-acab7d5a06c7'),
('Chevrolet', 'USA', 1911, 'https://www.chevrolet.com', 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Fchevrolet-seeklogo.png?alt=media&token=27623d33-aace-4622-b7ac-d0761bf09ca8'),
('Ford', 'USA', 1903, 'https://www.ford.com', 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Fford-seeklogo.png?alt=media&token=596173bd-295c-4586-8bfc-63288e2995b1'),
('Honda', 'Japan', 1948, 'https://www.honda.com', 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Fhonda-seeklogo.png?alt=media&token=83f2f641-4d72-4ba4-8aae-ba7849bdfa64'),
('Toyota', 'Japan', 1937, 'https://www.toyota.com', 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Ftoyota-seeklogo.png?alt=media&token=16e5eca2-0686-4e0c-95e4-47a627ff98a3'),
('BMW', 'Germany', 1916, 'https://www.bmw.com', 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Fbmw-seeklogo.png?alt=media&token=f498d1bf-8b29-448e-bed4-04e449c67bd9'),
('Mercedes-Benz', 'Germany', 1926, 'https://www.mercedes-benz.com', 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Fmercedes-benz-seeklogo.png?alt=media&token=779b6897-5ab5-4958-9d0b-980ca6daa8a4'),
('Audi', 'Germany', 1909, 'https://www.audi.com', 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Faudi-seeklogo.png?alt=media&token=922851bb-5a91-4c73-8096-9e434a37ecc3'),
('Tesla', 'USA', 2003, 'https://www.tesla.com', 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Ftesla-seeklogo.png?alt=media&token=6de0509e-5b58-450b-9ea6-f27e56e8e96f'),
('Nissan', 'Japan', 1933, 'https://www.nissan-global.com', 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2Flogo%2Fnissan-seeklogo.png?alt=media&token=5ff801bf-8b91-412c-8e37-d21c...'
);
GO

-- Insert sample data into CarModel
INSERT INTO CarModel (ManufacturerID, ModelName, Category, FirstProductionYear, LastProductionYear) VALUES
(1, '911 GT3 Touring', 'Sports Car', 2022, NULL), 
(2, 'Corvette Stingray Coupe', 'Sports Car', 2021, NULL), 
(3, 'Focus RS', 'Hatchback', 2016, 2018), 
(4, 'Civic Type R TC', 'Sedan', 2020, NULL), 
(1, '718 Boxster', 'Sports Car', 2018, NULL);
GO

-- Insert sample data into Car
INSERT INTO Car (ModelID, Year, Price, Mileage, TransmissionTypeID, FuelTypeID, ColorID, VIN, EngineSize, Horsepower, NumberOfDoors, Description, IsAvailable) VALUES
(1, 2022, 180000.00, 5000, 1, 1, 3, 'WP0AC2A95NS270167', 4.0, 502, 2, 'Porsche 911 GT3 Touring', 1),
(2, 2021, 67000.00, 8000, 1, 1, 5, '1G1YB2D47M5101234', 6.2, 495, 2, 'Chevrolet Corvette Stingray Coupe', 1),
(3, 2017, 36000.00, 30000, 2, 1, 2, '1FAFP3R42HL123456', 2.3, 350, 4, 'Ford Focus RS', 1),
(4, 2020, 45000.00, 15000, 1, 1, 4, 'SHHFK8G75LU123456', 2.0, 320, 4, 'Honda Civic Type R TC', 1),
(5, 2019, 35000.00, 22000, 1, 1, 1, '4T1B11HK7KU123456', 2.5, 206, 4, 'Porsche 718 Boxster', 1);
GO

-- Insert sample data into CarFeature
INSERT INTO CarFeature (CarID, FeatureID) VALUES
(1, 1), (1, 2), (1, 4), 
(2, 1), (2, 3), 
(3, 1), (3, 5), 
(4, 2), (4, 4), 
(5, 3), (5, 5);
GO

-- Insert sample data into CarImage
INSERT INTO CarImage (CarID, ImageURL) VALUES
(1, 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2F2022%20Porsche%20911%20GT3%20Touring%2F2022%20Porsche%20911%20GT3%20Touring%201.jpg?alt=media&token=5a679b3b-890f-4aa4-b550-ba2da738bdf2'),
(2, 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2FChevrolet%20Corvette%20Stingray%20Coupe%2FChevrolet%20Corvette%20Stingray%20Coupe%201.jpg?alt=media&token=6bab82a6-3311-4e19-adae-b76d0d74a307'),
(3, 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2FFord%20Focus%20RS%2FFord%20Focus%20RS%201.jpg?alt=media&token=80ff51e0-22d3-4751-9b2a-f85d7733ce67'),
(4, 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2FHonda%20Civic%20Type%20R%20TC%2FHonda%20Civic%20Type%20R%20TC%201.jpg?alt=media&token=ef7eadf5-cf9d-48bc-8ca6-0d025d815f94'),
(5, 'https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/car-market%2FPorsche%20718%20Boxster%2FPorsche%20718%20Boxster%201.jpg?alt=media&token=7c7dd94a-215a-4d28-864e-d109fc0cc01d');
GO