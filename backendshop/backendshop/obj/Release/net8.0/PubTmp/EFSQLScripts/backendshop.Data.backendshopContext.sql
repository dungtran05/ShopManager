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
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240312133637_inittable'
)
BEGIN
    CREATE TABLE [User] (
        [ID] int NOT NULL IDENTITY,
        [FirstName] nvarchar(max) NOT NULL,
        [LastName] nvarchar(max) NOT NULL,
        [UserName] nvarchar(100) NOT NULL,
        [Password] nvarchar(100) NOT NULL,
        CONSTRAINT [PK_User] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240312133637_inittable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240312133637_inittable', N'8.0.3');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240314155439_123u1'
)
BEGIN
    CREATE TABLE [Product] (
        [Id] int NOT NULL IDENTITY,
        [ProductName] nvarchar(200) NOT NULL,
        [ProductDescription] nvarchar(2000) NOT NULL,
        [ProductPrice] float NOT NULL,
        CONSTRAINT [PK_Product] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240314155439_123u1'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240314155439_123u1', N'8.0.3');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240317145039_123sda'
)
BEGIN
    CREATE TABLE [Cart] (
        [ID] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        [Image] nvarchar(max) NULL,
        [quantity] int NOT NULL,
        [UserID] int NULL,
        CONSTRAINT [PK_Cart] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_Cart_User_UserID] FOREIGN KEY ([UserID]) REFERENCES [User] ([ID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240317145039_123sda'
)
BEGIN
    CREATE INDEX [IX_Cart_UserID] ON [Cart] ([UserID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240317145039_123sda'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240317145039_123sda', N'8.0.3');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240317145347_12k3sadas2'
)
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'Image');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [Cart] DROP COLUMN [Image];
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240317145347_12k3sadas2'
)
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'Name');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [Cart] DROP COLUMN [Name];
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240317145347_12k3sadas2'
)
BEGIN
    ALTER TABLE [Cart] ADD [ProductId] int NULL;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240317145347_12k3sadas2'
)
BEGIN
    CREATE INDEX [IX_Cart_ProductId] ON [Cart] ([ProductId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240317145347_12k3sadas2'
)
BEGIN
    ALTER TABLE [Cart] ADD CONSTRAINT [FK_Cart_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240317145347_12k3sadas2'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240317145347_12k3sadas2', N'8.0.3');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    ALTER TABLE [Cart] DROP CONSTRAINT [FK_Cart_Product_ProductId];
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    ALTER TABLE [Cart] DROP CONSTRAINT [FK_Cart_User_UserID];
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'ProductDescription');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var2 + '];');
    ALTER TABLE [Product] DROP COLUMN [ProductDescription];
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    DECLARE @var3 sysname;
    SELECT @var3 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'ProductName');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var3 + '];');
    ALTER TABLE [Product] DROP COLUMN [ProductName];
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    DECLARE @var4 sysname;
    SELECT @var4 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'ProductPrice');
    IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var4 + '];');
    ALTER TABLE [Product] DROP COLUMN [ProductPrice];
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    DECLARE @var5 sysname;
    SELECT @var5 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'quantity');
    IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var5 + '];');
    ALTER TABLE [Cart] DROP COLUMN [quantity];
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    EXEC sp_rename N'[Cart].[UserID]', N'UserId', N'COLUMN';
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    EXEC sp_rename N'[Cart].[ID]', N'Id', N'COLUMN';
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    EXEC sp_rename N'[Cart].[IX_Cart_UserID]', N'IX_Cart_UserId', N'INDEX';
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    ALTER TABLE [Product] ADD [Name] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    ALTER TABLE [Product] ADD [Price] decimal(18,2) NOT NULL DEFAULT 0.0;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    DROP INDEX [IX_Cart_UserId] ON [Cart];
    DECLARE @var6 sysname;
    SELECT @var6 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'UserId');
    IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var6 + '];');
    EXEC(N'UPDATE [Cart] SET [UserId] = 0 WHERE [UserId] IS NULL');
    ALTER TABLE [Cart] ALTER COLUMN [UserId] int NOT NULL;
    ALTER TABLE [Cart] ADD DEFAULT 0 FOR [UserId];
    CREATE INDEX [IX_Cart_UserId] ON [Cart] ([UserId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    DROP INDEX [IX_Cart_ProductId] ON [Cart];
    DECLARE @var7 sysname;
    SELECT @var7 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'ProductId');
    IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var7 + '];');
    EXEC(N'UPDATE [Cart] SET [ProductId] = 0 WHERE [ProductId] IS NULL');
    ALTER TABLE [Cart] ALTER COLUMN [ProductId] int NOT NULL;
    ALTER TABLE [Cart] ADD DEFAULT 0 FOR [ProductId];
    CREATE INDEX [IX_Cart_ProductId] ON [Cart] ([ProductId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    ALTER TABLE [Cart] ADD CONSTRAINT [FK_Cart_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    ALTER TABLE [Cart] ADD CONSTRAINT [FK_Cart_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([ID]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240319150839_1238jsa'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240319150839_1238jsa', N'8.0.3');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240320074727_uijhsa'
)
BEGIN
    ALTER TABLE [Product] ADD [Description] nvarchar(max) NOT NULL DEFAULT N'';
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240320074727_uijhsa'
)
BEGIN
    ALTER TABLE [Cart] ADD [quantity] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240320074727_uijhsa'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240320074727_uijhsa', N'8.0.3');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240320081713_123u18'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240320081713_123u18', N'8.0.3');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240322082204_21736usha'
)
BEGIN
    ALTER TABLE [Product] ADD [IsTrendy] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240322082204_21736usha'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240322082204_21736usha', N'8.0.3');
END;
GO

COMMIT;
GO

