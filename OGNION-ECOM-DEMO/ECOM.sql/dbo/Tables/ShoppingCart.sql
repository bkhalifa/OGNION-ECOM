CREATE TABLE [dbo].[ShoppingCart] (
    [RecordID]    INT           IDENTITY (1, 1) NOT NULL,
    [CartID]      NVARCHAR (50) NULL,
    [Quantity]    INT           CONSTRAINT [DF_ShoppingCart_Quantity] DEFAULT ((1)) NOT NULL,
    [ProductID]   INT           NOT NULL,
    [DateCreated] DATETIME      CONSTRAINT [DF_ShoppingCart_DateCreated] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ShoppingCart] PRIMARY KEY NONCLUSTERED ([RecordID] ASC),
    CONSTRAINT [FK_ShoppingCart_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);


GO
CREATE NONCLUSTERED INDEX [IX_ShoppingCart]
    ON [dbo].[ShoppingCart]([CartID] ASC, [ProductID] ASC);

