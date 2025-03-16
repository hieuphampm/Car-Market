IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
CREATE TABLE [Colors] (
    [ColorID] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [HexCode] nvarchar(7) NOT NULL,
    CONSTRAINT [PK_Colors] PRIMARY KEY ([ColorID])
);

CREATE TABLE [Customers] (
    [CustomerID] int NOT NULL IDENTITY,
    [FirstName] nvarchar(100) NOT NULL,
    [LastName] nvarchar(100) NOT NULL,
    [Email] nvarchar(255) NOT NULL,
    [PhoneNumber] nvarchar(20) NOT NULL,
    [Address] nvarchar(255) NOT NULL,
    [DateCreated] datetime2 NOT NULL DEFAULT (GETDATE()),
    [DateModified] datetime2 NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT [PK_Customers] PRIMARY KEY ([CustomerID])
);

CREATE TABLE [Employees] (
    [EmployeeID] int NOT NULL IDENTITY,
    [FirstName] nvarchar(100) NOT NULL,
    [LastName] nvarchar(100) NOT NULL,
    [Position] nvarchar(50) NOT NULL,
    [Salary] decimal(10,2) NULL,
    [DateHired] datetime2 NOT NULL,
    [Email] nvarchar(255) NOT NULL,
    [PhoneNumber] nvarchar(20) NOT NULL,
    CONSTRAINT [PK_Employees] PRIMARY KEY ([EmployeeID])
);

CREATE TABLE [Features] (
    [FeatureID] int NOT NULL IDENTITY,
    [Name] nvarchar(100) NOT NULL,
    [Category] nvarchar(50) NOT NULL,
    CONSTRAINT [PK_Features] PRIMARY KEY ([FeatureID])
);

CREATE TABLE [FuelTypes] (
    [FuelTypeID] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    CONSTRAINT [PK_FuelTypes] PRIMARY KEY ([FuelTypeID])
);

CREATE TABLE [Manufacturers] (
    [ManufacturerID] int NOT NULL IDENTITY,
    [Name] nvarchar(100) NOT NULL,
    [Country] nvarchar(100) NOT NULL,
    [FoundedYear] int NULL,
    [Website] nvarchar(255) NOT NULL,
    [LogoURL] nvarchar(255) NOT NULL,
    [DateCreated] datetime2 NOT NULL DEFAULT (GETDATE()),
    [DateModified] datetime2 NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT [PK_Manufacturers] PRIMARY KEY ([ManufacturerID])
);

CREATE TABLE [TransmissionTypes] (
    [TransmissionTypeID] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    CONSTRAINT [PK_TransmissionTypes] PRIMARY KEY ([TransmissionTypeID])
);

CREATE TABLE [CarModels] (
    [ModelID] int NOT NULL IDENTITY,
    [ManufacturerID] int NOT NULL,
    [ModelName] nvarchar(100) NOT NULL,
    [Category] nvarchar(50) NOT NULL,
    [FirstProductionYear] int NULL,
    [LastProductionYear] int NULL,
    [DateCreated] datetime2 NOT NULL DEFAULT (GETDATE()),
    [DateModified] datetime2 NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT [PK_CarModels] PRIMARY KEY ([ModelID]),
    CONSTRAINT [FK_CarModels_Manufacturers_ManufacturerID] FOREIGN KEY ([ManufacturerID]) REFERENCES [Manufacturers] ([ManufacturerID]) ON DELETE CASCADE
);

CREATE TABLE [Cars] (
    [CarID] int NOT NULL IDENTITY,
    [ModelID] int NOT NULL,
    [Year] int NOT NULL,
    [Price] decimal(12,2) NOT NULL,
    [Mileage] int NOT NULL,
    [TransmissionTypeID] int NOT NULL,
    [FuelTypeID] int NOT NULL,
    [ColorID] int NOT NULL,
    [VIN] nvarchar(17) NOT NULL,
    [EngineSize] decimal(3,1) NULL,
    [Horsepower] int NULL,
    [NumberOfDoors] int NULL,
    [Description] nvarchar(max) NOT NULL,
    [IsAvailable] bit NOT NULL DEFAULT CAST(1 AS bit),
    [DateAdded] datetime2 NOT NULL DEFAULT (GETDATE()),
    [DateSold] datetime2 NULL,
    [DateCreated] datetime2 NOT NULL DEFAULT (GETDATE()),
    [DateModified] datetime2 NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT [PK_Cars] PRIMARY KEY ([CarID]),
    CONSTRAINT [FK_Cars_CarModels_ModelID] FOREIGN KEY ([ModelID]) REFERENCES [CarModels] ([ModelID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Cars_Colors_ColorID] FOREIGN KEY ([ColorID]) REFERENCES [Colors] ([ColorID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Cars_FuelTypes_FuelTypeID] FOREIGN KEY ([FuelTypeID]) REFERENCES [FuelTypes] ([FuelTypeID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Cars_TransmissionTypes_TransmissionTypeID] FOREIGN KEY ([TransmissionTypeID]) REFERENCES [TransmissionTypes] ([TransmissionTypeID]) ON DELETE CASCADE
);

CREATE TABLE [CarFeatures] (
    [CarID] int NOT NULL,
    [FeatureID] int NOT NULL,
    CONSTRAINT [PK_CarFeatures] PRIMARY KEY ([CarID], [FeatureID]),
    CONSTRAINT [FK_CarFeatures_Cars_CarID] FOREIGN KEY ([CarID]) REFERENCES [Cars] ([CarID]) ON DELETE CASCADE,
    CONSTRAINT [FK_CarFeatures_Features_FeatureID] FOREIGN KEY ([FeatureID]) REFERENCES [Features] ([FeatureID]) ON DELETE CASCADE
);

CREATE TABLE [CarImages] (
    [ImageID] int NOT NULL IDENTITY,
    [CarID] int NOT NULL,
    [ImageURL] nvarchar(255) NOT NULL,
    [IsPrimary] bit NOT NULL DEFAULT CAST(0 AS bit),
    [UploadDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT [PK_CarImages] PRIMARY KEY ([ImageID]),
    CONSTRAINT [FK_CarImages_Cars_CarID] FOREIGN KEY ([CarID]) REFERENCES [Cars] ([CarID]) ON DELETE CASCADE
);

CREATE TABLE [Favorites] (
    [FavoriteID] int NOT NULL IDENTITY,
    [CustomerID] int NOT NULL,
    [CarID] int NOT NULL,
    [DateAdded] datetime2 NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT [PK_Favorites] PRIMARY KEY ([FavoriteID]),
    CONSTRAINT [FK_Favorites_Cars_CarID] FOREIGN KEY ([CarID]) REFERENCES [Cars] ([CarID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Favorites_Customers_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Customers] ([CustomerID]) ON DELETE CASCADE
);

CREATE TABLE [Sales] (
    [SaleID] int NOT NULL IDENTITY,
    [CarID] int NOT NULL,
    [CustomerID] int NOT NULL,
    [SaleDate] datetime2 NOT NULL DEFAULT (GETDATE()),
    [TotalPrice] decimal(12,2) NOT NULL,
    [PaymentMethod] nvarchar(50) NOT NULL,
    CONSTRAINT [PK_Sales] PRIMARY KEY ([SaleID]),
    CONSTRAINT [FK_Sales_Cars_CarID] FOREIGN KEY ([CarID]) REFERENCES [Cars] ([CarID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Sales_Customers_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Customers] ([CustomerID]) ON DELETE CASCADE
);

CREATE INDEX [IX_CarFeatures_FeatureID] ON [CarFeatures] ([FeatureID]);

CREATE INDEX [IX_CarImages_CarID] ON [CarImages] ([CarID]);

CREATE INDEX [IX_CarModels_ManufacturerID] ON [CarModels] ([ManufacturerID]);

CREATE INDEX [IX_Cars_ColorID] ON [Cars] ([ColorID]);

CREATE INDEX [IX_Cars_FuelTypeID] ON [Cars] ([FuelTypeID]);

CREATE INDEX [IX_Cars_ModelID] ON [Cars] ([ModelID]);

CREATE INDEX [IX_Cars_TransmissionTypeID] ON [Cars] ([TransmissionTypeID]);

CREATE UNIQUE INDEX [IX_Cars_VIN] ON [Cars] ([VIN]);

CREATE UNIQUE INDEX [IX_Customers_Email] ON [Customers] ([Email]);

CREATE UNIQUE INDEX [IX_Employees_Email] ON [Employees] ([Email]);

CREATE INDEX [IX_Favorites_CarID] ON [Favorites] ([CarID]);

CREATE INDEX [IX_Favorites_CustomerID] ON [Favorites] ([CustomerID]);

CREATE INDEX [IX_Sales_CarID] ON [Sales] ([CarID]);

CREATE INDEX [IX_Sales_CustomerID] ON [Sales] ([CustomerID]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250316135323_UpdateCarModelPrimaryKey', N'9.0.3');

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250316140007_InitialCreate', N'9.0.3');

COMMIT;
GO

