CREATE TABLE [dbo].[Products] (
    [ProductID]    INT             IDENTITY (1, 1) NOT NULL,
    [CategoryID]   INT             NOT NULL,
    [ModelNumber]  NVARCHAR (50)   NULL,
    [ModelName]    NVARCHAR (50)   NULL,
    [ProductImage] NVARCHAR (50)   NULL,
    [UnitCost]     MONEY           NOT NULL,
    [Description]  NVARCHAR (3800) NULL,
    CONSTRAINT [PK_Products] PRIMARY KEY NONCLUSTERED ([ProductID] ASC),
    CONSTRAINT [FK_Products_Categories] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Categories] ([CategoryID])
);


GO
CREATE CLUSTERED INDEX [ci_product_modelname]
    ON [dbo].[Products]([ModelName] ASC);

