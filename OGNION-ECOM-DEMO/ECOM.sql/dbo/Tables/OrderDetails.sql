CREATE TABLE [dbo].[OrderDetails] (
    [Id]        INT   IDENTITY (1, 1) NOT NULL,
    [OrderID]   INT   NULL,
    [ProductID] INT   NULL,
    [Quantity]  INT   NULL,
    [UnitCost]  MONEY NULL,
    CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Order_OrderDetails] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID])
);

