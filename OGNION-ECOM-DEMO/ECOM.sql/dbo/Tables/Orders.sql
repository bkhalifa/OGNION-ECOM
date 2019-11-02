CREATE TABLE [dbo].[Orders] (
    [OrderID]      INT            IDENTITY (1, 1) NOT NULL,
    [CustomerName] NVARCHAR (256) NOT NULL,
    [OrderDate]    DATETIME       CONSTRAINT [DF_Orders_OrderDate] DEFAULT (getdate()) NOT NULL,
    [ShipDate]     DATETIME       CONSTRAINT [DF_Orders_ShipDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY NONCLUSTERED ([OrderID] ASC)
);

